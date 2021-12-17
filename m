Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78490478FA7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Dec 2021 16:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhLQP37 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Dec 2021 10:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59796 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238010AbhLQP37 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639754998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBRj8GYjGjhf8bCMKBOGvpl1VQtGqlW2e0yDrphlBy8=;
        b=QX02YNmDkqC7og6CW/QJ4dkrQ3hX4CRxWBLrLf5cV2W5SpcV5LFGd6WhKPMM275qeFCnZe
        KXbcopsO6NkHGmFgQlF6Aw2Th6qoGH4LX2/GZEYDJHvzRR80tT6YtgEvu3uM6FrGuF9nTw
        C/lQEjHAFXGTV8vjJWrYoNHga3cplLY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-SB_tTzArOICA7u0jh-w7fw-1; Fri, 17 Dec 2021 10:29:55 -0500
X-MC-Unique: SB_tTzArOICA7u0jh-w7fw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74AE6801962;
        Fri, 17 Dec 2021 15:29:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.122])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A072E5E499;
        Fri, 17 Dec 2021 15:29:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 2/2] ceph: Remove some other inline-setting bits
From:   David Howells <dhowells@redhat.com>
To:     jlayton@kernel.org
Cc:     idryomov@gmail.com, dhowells@redhat.com,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 17 Dec 2021 15:29:52 +0000
Message-ID: <163975499268.2021751.9526015087273381693.stgit@warthog.procyon.org.uk>
In-Reply-To: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
References: <163975498535.2021751.13839139728966985077.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 6e1b15cc87cf..553e2b5653f3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1534,11 +1534,9 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
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
index d16ba8720783..4a0aeed7f660 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1031,7 +1031,6 @@ static void ceph_aio_complete(struct inode *inode,
 		}
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &aio_req->prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -1838,7 +1837,6 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		int dirty;
 
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2116,7 +2114,6 @@ static long ceph_fallocate(struct file *file, int mode,
 
 	if (!ret) {
 		spin_lock(&ci->i_ceph_lock);
-		ci->i_inline_version = CEPH_INLINE_NONE;
 		dirty = __ceph_mark_dirty_caps(ci, CEPH_CAP_FILE_WR,
 					       &prealloc_cf);
 		spin_unlock(&ci->i_ceph_lock);
@@ -2509,7 +2506,6 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	}
 	/* Mark Fw dirty */
 	spin_lock(&dst_ci->i_ceph_lock);
-	dst_ci->i_inline_version = CEPH_INLINE_NONE;
 	dirty = __ceph_mark_dirty_caps(dst_ci, CEPH_CAP_FILE_WR, &prealloc_cf);
 	spin_unlock(&dst_ci->i_ceph_lock);
 	if (dirty)


