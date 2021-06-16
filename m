Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC913AA618
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 23:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhFPVYm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 17:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48414 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233909AbhFPVYl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 17:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623878553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GUzVV1RzuS/uejV8gOCi1Hq++h3D2eM6DMUllFfeIsg=;
        b=Am9PY8HLr42aDk+GutZ8JmawblxL//m9QFtZR5elHnJ90dOK1mn+EZj2LoP+Ran5Q5zv/m
        ikFwuFe+dpib3NC46k5xxVySzcM72vl+nPyPhHAZ14o2SBI/9pUeTlRhV0nx7lE+cQAPUG
        WPMLEea22YNlnxgEp8nywpEX69r1VVE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-sqaPo7RxOm-kKy-LjM7vgw-1; Wed, 16 Jun 2021 17:22:32 -0400
X-MC-Unique: sqaPo7RxOm-kKy-LjM7vgw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A48D18D6A2C;
        Wed, 16 Jun 2021 21:22:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-118-65.rdu2.redhat.com [10.10.118.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB5C55C1D0;
        Wed, 16 Jun 2021 21:22:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Re-enable freezing once a page fault is interrupted
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        marc.dionne@auristor.com, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 16 Jun 2021 22:22:28 +0100
Message-ID: <162387854886.1035841.15139736369962171742.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Matthew Wilcox (Oracle) <willy@infradead.org>

If a task is killed during a page fault, it does not currently call
sb_end_pagefault(), which means that the filesystem cannot be frozen
at any time thereafter.  This may be reported by lockdep like this:

====================================
WARNING: fsstress/10757 still has locks held!
5.13.0-rc4-build4+ #91 Not tainted
------------------------------------
1 lock held by fsstress/10757:
 #0: ffff888104eac530
 (
sb_pagefaults

as filesystem freezing is modelled as a lock.

Fix this by removing all the direct returns from within the function,
and using 'ret' to indicate whether we were interrupted or successful.

Fixes: 1cf7a1518aef ("afs: Implement shared-writeable mmap")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20210616154900.1958373-1-willy@infradead.org/
---

 fs/afs/write.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index f722cb80a594..ff36800a7389 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -848,6 +848,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	struct inode *inode = file_inode(file);
 	struct afs_vnode *vnode = AFS_FS_I(inode);
 	unsigned long priv;
+	vm_fault_t ret = VM_FAULT_RETRY;
 
 	_enter("{{%llx:%llu}},{%lx}", vnode->fid.vid, vnode->fid.vnode, page->index);
 
@@ -859,14 +860,14 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 #ifdef CONFIG_AFS_FSCACHE
 	if (PageFsCache(page) &&
 	    wait_on_page_fscache_killable(page) < 0)
-		return VM_FAULT_RETRY;
+		goto out;
 #endif
 
 	if (wait_on_page_writeback_killable(page))
-		return VM_FAULT_RETRY;
+		goto out;
 
 	if (lock_page_killable(page) < 0)
-		return VM_FAULT_RETRY;
+		goto out;
 
 	/* We mustn't change page->private until writeback is complete as that
 	 * details the portion of the page we need to write back and we might
@@ -874,7 +875,7 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	 */
 	if (wait_on_page_writeback_killable(page) < 0) {
 		unlock_page(page);
-		return VM_FAULT_RETRY;
+		goto out;
 	}
 
 	priv = afs_page_dirty(page, 0, thp_size(page));
@@ -888,8 +889,10 @@ vm_fault_t afs_page_mkwrite(struct vm_fault *vmf)
 	}
 	file_update_time(file);
 
+	ret = VM_FAULT_LOCKED;
+out:
 	sb_end_pagefault(inode->i_sb);
-	return VM_FAULT_LOCKED;
+	return ret;
 }
 
 /*


