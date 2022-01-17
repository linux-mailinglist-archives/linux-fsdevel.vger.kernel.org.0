Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928D84908F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 13:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240019AbiAQMor (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 07:44:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229851AbiAQMor (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642423486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/eTiGeKgJweoBkM+jM6fCGcojKvmmsTj3Mllo6ublYw=;
        b=EPIMmUsSRxob1ZsvNkEXxC+Cf1C9bu5ujrptMYLJvAVgia9siGl494K5yblSIYlK2LF0uw
        UsBmyYJ9ozHGn4n05UONTchstFhvHcvvvtC5rZThKDRKYLpXwtmg8k7A4fAyvn04huMUX+
        84DRBJCsqcb/qkh+2dm7FpZQiuFKr+Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-MFK0Y_ROMly23p9IEq85aQ-1; Mon, 17 Jan 2022 07:44:43 -0500
X-MC-Unique: MFK0Y_ROMly23p9IEq85aQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16ECC1023F4D;
        Mon, 17 Jan 2022 12:44:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CAE072FA8;
        Mon, 17 Jan 2022 12:44:41 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 2/3] ceph: Remove some other inline-setting bits
From:   David Howells <dhowells@redhat.com>
To:     ceph-devel@vger.kernel.org
Cc:     dhowells@redhat.com, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org
Date:   Mon, 17 Jan 2022 12:44:40 +0000
Message-ID: <164242348039.2763588.3727304091317734903.stgit@warthog.procyon.org.uk>
In-Reply-To: <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
References: <164242347319.2763588.2514920080375140879.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
index ef1caa43b521..a8e5e6ded96e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1530,11 +1530,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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


