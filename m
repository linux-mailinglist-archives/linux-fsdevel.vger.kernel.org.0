Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 450373626F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 19:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243060AbhDPRgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 13:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242995AbhDPRgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 13:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618594536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=p38vcdUQLLL50x6xjFxwTWwCdDOs1BMYGT6mRYrbojs=;
        b=QqYIW8hn+RQCYuLeM1zqFcY8aqHn+ZWHjIKcWN59+e9aHrqsSQKFDQxw9Y5m3hpIIzGj3W
        mVtSTF4UgpBSOVCzJ2t7o9eSA5/TzZsEzchz5nv3LfwKtl3gFsOGaD8kPC9Br7Ounm+NhO
        qS1dbDpAmGSvc4dIWVl8YY6q1aFyUmQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-yVMTDXfsO46liQvLlHUzbw-1; Fri, 16 Apr 2021 13:35:34 -0400
X-MC-Unique: yVMTDXfsO46liQvLlHUzbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 590ED8030A1;
        Fri, 16 Apr 2021 17:35:32 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-117.rdu2.redhat.com [10.10.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C35D060CED;
        Fri, 16 Apr 2021 17:35:24 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 606B922054F; Fri, 16 Apr 2021 13:35:24 -0400 (EDT)
Date:   Fri, 16 Apr 2021 13:35:24 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Linux fsdevel mailing list <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>, willy@infradead.org
Cc:     virtio-fs-list <virtio-fs@redhat.com>,
        Sergio Lopez <slp@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>, linux-nvdimm@lists.01.org,
        linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] dax: Fix missed wakeup in put_unlocked_entry()
Message-ID: <20210416173524.GA1379987@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am seeing missed wakeups which ultimately lead to a deadlock when I am
using virtiofs with DAX enabled and running "make -j". I had to mount
virtiofs as rootfs and also reduce to dax window size to 32M to reproduce
the problem consistently.

This is not a complete patch. I am just proposing this partial fix to
highlight the issue and trying to figure out how it should be fixed.
Should it be fixed in generic dax code or should filesystem (fuse/virtiofs)
take care of this.

So here is the problem. put_unlocked_entry() wakes up waiters only
if entry is not null as well as !dax_is_conflict(entry). But if I
call multiple instances of invalidate_inode_pages2() in parallel,
then I can run into a situation where there are waiters on 
this index but nobody will wait these.

invalidate_inode_pages2()
  invalidate_inode_pages2_range()
    invalidate_exceptional_entry2()
      dax_invalidate_mapping_entry_sync()
        __dax_invalidate_entry() {
		xas_lock_irq(&xas);
		entry = get_unlocked_entry(&xas, 0);
		...
		...
		dax_disassociate_entry(entry, mapping, trunc);
		xas_store(&xas, NULL);
		...
		...
	        put_unlocked_entry(&xas, entry);
        	xas_unlock_irq(&xas);
	} 

Say a fault in in progress and it has locked entry at offset say "0x1c".
Now say three instances of invalidate_inode_pages2() are in progress
(A, B, C) and they all try to invalidate entry at offset "0x1c". Given
dax entry is locked, all tree instances A, B, C will wait in wait queue.

When dax fault finishes, say A is woken up. It will store NULL entry
at index "0x1c" and wake up B. When B comes along it will find "entry=0"
at page offset 0x1c and it will call put_unlocked_entry(&xas, 0). And
this means put_unlocked_entry() will not wake up next waiter, given
the current code. And that means C continues to wait and is not woken
up.

In my case I am seeing that dax page fault path itself is waiting
on grab_mapping_entry() and also invalidate_inode_page2() is 
waiting in get_unlocked_entry() but entry has already been cleaned
up and nobody woke up these processes. Atleast I think that's what
is happening.

This patch wakes up a process even if entry=0. And deadlock does not
happen. I am running into some OOM issues, that will debug.

So my question is that is it a dax issue and should it be fixed in
dax layer. Or should it be handled in fuse to make sure that
multiple instances of invalidate_inode_pages2() on same inode
don't make progress in parallel and introduce enough locking
around it.

Right now fuse_finish_open() calls invalidate_inode_pages2() without
any locking. That allows it to make progress in parallel to dax
fault path as well as allows multiple instances of invalidate_inode_pages2()
to run in parallel.

Not-yet-signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: redhat-linux/fs/dax.c
===================================================================
--- redhat-linux.orig/fs/dax.c	2021-04-16 12:50:40.141363317 -0400
+++ redhat-linux/fs/dax.c	2021-04-16 12:51:42.385926390 -0400
@@ -266,9 +266,10 @@ static void wait_entry_unlocked(struct x
 
 static void put_unlocked_entry(struct xa_state *xas, void *entry)
 {
-	/* If we were the only waiter woken, wake the next one */
-	if (entry && !dax_is_conflict(entry))
-		dax_wake_entry(xas, entry, false);
+	if (dax_is_conflict(entry))
+		return;
+
+	dax_wake_entry(xas, entry, false);
 }
 
 /*

