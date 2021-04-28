Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319C536DD7D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Apr 2021 18:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241305AbhD1Qvt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 12:51:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241291AbhD1Qvs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 12:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619628662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BHdHg0RFU1qOPaKtIS99H89bvmSSqduaW6j8IHmwfQ8=;
        b=OIE1G3e+qCQ0TSL3ObQCCxSZ23IN1uGtucB6RxSuxLY8QX+E8dipAG1rbEV8IqqsfAMEGt
        F/hagiEx0Kbg15BEMzfPJX1QftmyTeXpEhZQaOu5DWZTRr4RwK+8P5RM8gIz4MazNM2R+o
        w6auO/aeufrNHSfSblM2VkSwSom+GtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-r3ZHLjFLMBmFPbWHRK9lQQ-1; Wed, 28 Apr 2021 12:51:00 -0400
X-MC-Unique: r3ZHLjFLMBmFPbWHRK9lQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EDC1192CC5D;
        Wed, 28 Apr 2021 16:50:50 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-128.rdu2.redhat.com [10.10.116.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D142C60E3A;
        Wed, 28 Apr 2021 16:50:49 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 5F75F225FCF; Wed, 28 Apr 2021 12:50:49 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, virtio-fs@redhat.com,
        dan.j.williams@intel.com
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, jack@suse.cz,
        willy@infradead.org, slp@redhat.com
Subject: [PATCH v5 3/3] dax: Wake up all waiters after invalidating dax entry
Date:   Wed, 28 Apr 2021 12:50:40 -0400
Message-Id: <20210428165040.1856202-4-vgoyal@redhat.com>
In-Reply-To: <20210428165040.1856202-1-vgoyal@redhat.com>
References: <20210428165040.1856202-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index e84dd240c35c..42d7406b2cea 100644
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

