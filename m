Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CF4490C7B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 17:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241102AbiAQQ0y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 11:26:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33469 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241094AbiAQQ0x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642436812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVhWU8KqQGXyjPFyWVxq+9Ch5uH2D+A31Q7UBYQ2fRk=;
        b=N/cth5REbgabckw3tyIhZ58U5K5i9NVTb9kdVyhiKB0A8bR0RXrutJ1+sFF5GC5ET3+ukU
        lBYSERnIcA18/TBH9q2kNmG1NucoTKVGnDyeHddbujONY6PFdXIxE/zEG7JZRJ/slaB35N
        qwe2QobL2N7nRq64PntGcoPEKWG4sLE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-335-bfD05rciPJaga5oTmp8xGQ-1; Mon, 17 Jan 2022 11:26:49 -0500
X-MC-Unique: bfD05rciPJaga5oTmp8xGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B3CE874985;
        Mon, 17 Jan 2022 16:26:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66B347E918;
        Mon, 17 Jan 2022 16:26:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 3/3] ceph: Remove some other inline-setting bits
From:   David Howells <dhowells@redhat.com>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 16:26:46 +0000
Message-ID: <164243680645.2863669.4899458643136219190.stgit@warthog.procyon.org.uk>
In-Reply-To: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
References: <164243678893.2863669.12713835397467153827.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some other bits where a ceph file can't be inline because we
uninlined it when we opened it for writing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/ceph/addr.c |    4 +---
 fs/ceph/file.c |    4 ----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 10837587f7db..a2a03d4c28fb 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1575,11 +1575,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 		ceph_put_snap_context(snapc);
 	} while (err == 0);
 
-	if (ret == VM_FAULT_LOCKED ||
-	    ci->i_inline_version != CEPH_INLINE_NONE) {
+	if (ret == VM_FAULT_LOCKED) {
 		int dirty;
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d1d28220f691..114d8c7d5aab 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1043,7 +1043,6 @@ static void ceph_aio_complete(struct inode *inode,
 		}
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &aio_req->prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1850,7 +1849,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		int dirty;
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2128,7 +2126,6 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2521,7 +2518,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	}
 	/* Mark Fw dirty */
 	spin_lock(&dst_ci->i_ceph_lock);
-	dst_ci->i_inline_version = CEPH_INLINE_NONE;
 	dirty = __ceph_mark_dirty_caps(dst_ci, CEPH_CAP_FILE_WR, &prealloc_cf);
 	spin_unlock(&dst_ci->i_ceph_lock);
 	if (dirty)


