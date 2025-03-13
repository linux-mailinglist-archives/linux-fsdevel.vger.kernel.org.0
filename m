Return-Path: <linux-fsdevel+bounces-43973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE364A605D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAA5421ACD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4C2066DC;
	Thu, 13 Mar 2025 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c5NYk8M4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F407205ADF
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908928; cv=none; b=aSpfcHjGYn2nfneb7QdL2k1i1GZHioa2mKcjBEyv/uE4oFK3td4SohIij9FgUd4T1CJ18Hw+C/wixs6npYCu0S28paH+XQDkFK/9k3qN5PluozKwBKRbvhtWToBuSZ90pE1LaXfYaFaVe+k4p7nvef6ivis6R8lwll0k1jytP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908928; c=relaxed/simple;
	bh=6OzzDKzbbzQbGvjekWWPuzdxFcthY11POqQiisXIVZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlCT7Pho+3X99WHBpZTV5Qoydt+Du1ZaDai3/SAXtWJk7KlD8Mn64smP5in52q67+1Y5boFeAHaVGxsG1TSD/8AmSZEc3K9V/l70eX1oNP7TuRpFCo9pnXoYNg/O+oLvp2oXgTBmrMT9Ibl2GhCHULej/gx0hZ93Y2DUYGvpzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c5NYk8M4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908924;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LT2VwrPDEakuKlQLz45hjD3tXAYQbwEpQFgWzIEY3WI=;
	b=c5NYk8M41tCygvKzRQD+ptmtQpEZEpUFdeD17GLlkl6ZTHZu4+AsMrccpptdpFwpu7gY5T
	BGLrOIfsQXTDGQrQ/KRJS1Mh2ChLh6FMuDVtlznBKFNyEdcInQS2nklJ9l3iRXewldpBZq
	jrDF/AX+UCsRk26sF2X2HarFDjTAsoY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-2l4YVEmmOEC1NkRBqXosiw-1; Thu,
 13 Mar 2025 19:35:21 -0400
X-MC-Unique: 2l4YVEmmOEC1NkRBqXosiw-1
X-Mimecast-MFC-AGG-ID: 2l4YVEmmOEC1NkRBqXosiw_1741908919
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 831A51801A00;
	Thu, 13 Mar 2025 23:35:19 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 493F51828A83;
	Thu, 13 Mar 2025 23:35:17 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	Alex Markuze <amarkuze@redhat.com>
Cc: David Howells <dhowells@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 24/35] ceph: Make ceph_calc_file_object_mapping() return size as size_t
Date: Thu, 13 Mar 2025 23:33:16 +0000
Message-ID: <20250313233341.1675324-25-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Make ceph_calc_file_object_mapping() return the size as a size_t.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/addr.c               | 4 ++--
 fs/ceph/crypto.c             | 2 +-
 fs/ceph/file.c               | 9 ++++-----
 fs/ceph/ioctl.c              | 2 +-
 include/linux/ceph/striper.h | 6 +++---
 net/ceph/osd_client.c        | 2 +-
 net/ceph/striper.c           | 4 ++--
 7 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 482a9f41a685..7c89cafcb91a 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -335,8 +335,8 @@ static int ceph_netfs_prepare_read(struct netfs_io_subrequest *subreq)
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
+	size_t xlen;
 	u64 objno, objoff;
-	u32 xlen;
 
 	/* Truncate the extent at the end of the current block */
 	ceph_calc_file_object_mapping(&ci->i_layout, subreq->start, subreq->len,
@@ -1205,9 +1205,9 @@ void ceph_allocate_page_array(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	size_t xlen;
 	u64 objnum;
 	u64 objoff;
-	u32 xlen;
 
 	/* prepare async write request */
 	ceph_wbc->offset = (u64)folio_pos(folio);
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 3b3c4d8d401e..a28dea74ca6f 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -594,8 +594,8 @@ int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int i, ret = 0;
 	struct ceph_inode_info *ci = ceph_inode(inode);
+	size_t xlen;
 	u64 objno, objoff;
-	u32 xlen;
 
 	/* Nothing to do for empty array */
 	if (ext_cnt == 0) {
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index fb4024bc8274..ffd36e00b0de 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1731,12 +1731,11 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 		u64 write_pos = pos;
 		u64 write_len = len;
 		u64 objnum, objoff;
-		u32 xlen;
 		u64 assert_ver = 0;
 		bool rmw;
 		bool first, last;
 		struct iov_iter saved_iter = *from;
-		size_t off;
+		size_t off, xlen;
 
 		ceph_fscrypt_adjust_off_and_len(inode, &write_pos, &write_len);
 
@@ -2870,8 +2869,8 @@ static ssize_t ceph_do_objects_copy(struct ceph_inode_info *src_ci, u64 *src_off
 	struct ceph_osd_client *osdc;
 	struct ceph_osd_request *req;
 	size_t bytes = 0;
+	size_t src_objlen, dst_objlen;
 	u64 src_objnum, src_objoff, dst_objnum, dst_objoff;
-	u32 src_objlen, dst_objlen;
 	u32 object_size = src_ci->i_layout.object_size;
 	struct ceph_client *cl = fsc->client;
 	int ret;
@@ -2948,8 +2947,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_client *cl = src_fsc->client;
 	loff_t size;
 	ssize_t ret = -EIO, bytes;
+	size_t src_objlen, dst_objlen;
 	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
-	u32 src_objlen, dst_objlen;
 	int src_got = 0, dst_got = 0, err, dirty;
 
 	if (src_inode->i_sb != dst_inode->i_sb) {
@@ -3060,7 +3059,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	 * starting at the src_off
 	 */
 	if (src_objoff) {
-		doutc(cl, "Initial partial copy of %u bytes\n", src_objlen);
+		doutc(cl, "Initial partial copy of %zu bytes\n", src_objlen);
 
 		/*
 		 * we need to temporarily drop all caps as we'll be calling
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index e861de3c79b9..fab0e89ad7b4 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -186,7 +186,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 		&ceph_sb_to_fs_client(inode->i_sb)->client->osdc;
 	struct ceph_object_locator oloc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
-	u32 xlen;
+	size_t xlen;
 	u64 tmp;
 	struct ceph_pg pgid;
 	int r;
diff --git a/include/linux/ceph/striper.h b/include/linux/ceph/striper.h
index 50bc1b88c5c4..e1036e953d7b 100644
--- a/include/linux/ceph/striper.h
+++ b/include/linux/ceph/striper.h
@@ -10,7 +10,7 @@ struct ceph_file_layout;
 
 void ceph_calc_file_object_mapping(struct ceph_file_layout *l,
 				   u64 off, u64 len,
-				   u64 *objno, u64 *objoff, u32 *xlen);
+				   u64 *objno, u64 *objoff, size_t *xlen);
 
 struct ceph_object_extent {
 	struct list_head oe_item;
@@ -97,14 +97,14 @@ int ceph_iterate_extents(struct ceph_file_layout *l, u64 off, u64 len,
 	while (len) {
 		struct ceph_object_extent *ex;
 		u64 objno, objoff;
-		u32 xlen;
+		size_t xlen;
 
 		ceph_calc_file_object_mapping(l, off, len, &objno, &objoff,
 					      &xlen);
 
 		ex = ceph_lookup_containing(object_extents, objno, objoff, xlen);
 		if (!ex) {
-			WARN(1, "%s: objno %llu %llu~%u not found!\n",
+			WARN(1, "%s: objno %llu %llu~%zu not found!\n",
 			     __func__, objno, objoff, xlen);
 			return -EINVAL;
 		}
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 92aaa5ed9145..f943d4e85a13 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -100,7 +100,7 @@ static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
 			u64 *objnum, u64 *objoff, u64 *objlen)
 {
 	u64 orig_len = *plen;
-	u32 xlen;
+	size_t xlen;
 
 	/* object extent? */
 	ceph_calc_file_object_mapping(layout, off, orig_len, objnum,
diff --git a/net/ceph/striper.c b/net/ceph/striper.c
index 3dedbf018fa6..c934c9addc9d 100644
--- a/net/ceph/striper.c
+++ b/net/ceph/striper.c
@@ -23,7 +23,7 @@
  */
 void ceph_calc_file_object_mapping(struct ceph_file_layout *l,
 				   u64 off, u64 len,
-				   u64 *objno, u64 *objoff, u32 *xlen)
+				   u64 *objno, u64 *objoff, size_t *xlen)
 {
 	u32 stripes_per_object = l->object_size / l->stripe_unit;
 	u64 blockno;	/* which su in the file (i.e. globally) */
@@ -100,7 +100,7 @@ int ceph_file_to_extents(struct ceph_file_layout *l, u64 off, u64 len,
 	while (len) {
 		struct list_head *add_pos = NULL;
 		u64 objno, objoff;
-		u32 xlen;
+		size_t xlen;
 
 		ceph_calc_file_object_mapping(l, off, len, &objno, &objoff,
 					      &xlen);


