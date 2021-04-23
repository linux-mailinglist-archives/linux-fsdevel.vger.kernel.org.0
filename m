Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7568B3692AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Apr 2021 15:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhDWNI0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Apr 2021 09:08:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236860AbhDWNIY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Apr 2021 09:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619183268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrEvCjKrNvU8f2Kdeia0iPn8GHvkOfIv042jQr8u048=;
        b=IgJFoiKOgEGF3HzZkv35ROiYIOXSiXbjoHLEEilZ7SQ+nW0W9uwOPtXp8jMgUBNra2HFad
        e+SywUIf61lvTTl0HdBFQyLyzU4wxCMiFvgn00BdUi25Gv/2Hq90srdQAlhDfBIVZw1FZG
        KMzjS2yBHHKoJ1HZFqTc2R9PnQZldkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-p2aXp0xRN9iTLkrd4oJhkA-1; Fri, 23 Apr 2021 09:07:46 -0400
X-MC-Unique: p2aXp0xRN9iTLkrd4oJhkA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 269C61006C81;
        Fri, 23 Apr 2021 13:07:45 +0000 (UTC)
Received: from horse.redhat.com (ovpn-115-86.rdu2.redhat.com [10.10.115.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C37250DD2;
        Fri, 23 Apr 2021 13:07:38 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A8368225FCD; Fri, 23 Apr 2021 09:07:37 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        vgoyal@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        willy@infradead.org, slp@redhat.com, groug@kaod.org
Subject: [PATCH v4 3/3] dax: Wake up all waiters after invalidating dax entry
Date:   Fri, 23 Apr 2021 09:07:23 -0400
Message-Id: <20210423130723.1673919-4-vgoyal@redhat.com>
In-Reply-To: <20210423130723.1673919-1-vgoyal@redhat.com>
References: <20210423130723.1673919-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I am seeing missed wakeups which ultimately lead to a deadlock when I am
using virtiofs with DAX enabled and running "make -j". I had to mount
virtiofs as rootfs and also reduce to dax window size to 256M to reproduce
the problem consistently.

So here is the problem. put_unlocked_entry() wakes up waiters only
if entry is not null as well as !dax_is_conflict(entry). But if I
call multiple instances of invalidate_inode_pages2() in parallel,
then I can run into a situation where there are waiters on
this index but nobody will wake these waiters.

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

This patch fixes the issue by waking up all waiters when a dax entry
has been invalidated. This seems to fix the deadlock I am facing
and I can make forward progress.

Reported-by: Sergio Lopez <slp@redhat.com>
Fixes: ac401cc78242 ("dax: New fault locking")
Reviewed-by: Jan Kara <jack@suse.cz>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/dax.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/dax.c b/fs/dax.c
index 96e896de8f18..83daa57d37d3 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -675,7 +675,7 @@ static int __dax_invalidate_entry(struct address_space *mapping,
 	mapping->nrexceptional--;
 	ret = 1;
 out:
-	put_unlocked_entry(&xas, entry, WAKE_NEXT);
+	put_unlocked_entry(&xas, entry, WAKE_ALL);
 	xas_unlock_irq(&xas);
 	return ret;
 }
-- 
2.25.4

