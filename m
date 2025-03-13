Return-Path: <linux-fsdevel+bounces-43967-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C12A605B0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70CA7172F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD664203707;
	Thu, 13 Mar 2025 23:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo0RIQGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9531F941B
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 23:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741908909; cv=none; b=LH+s6u8pu/6KwRHJq87Gqv7WxzEIz7NmOvVzk6M/o6egqn6xKpL0/7NKEGspAP8zFnzYc7hI3QoBncF28UoCJaRy/U3JUSQDlKMxBTfcfvAD4oVHFYh9/X9Qgbgx7taHmvUTUfw9CQJ/DBZR8r+Fc3gX3I1CooULi3vhqwfKFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741908909; c=relaxed/simple;
	bh=vZ4f0SKQ1K//pN1RFVWQNYZC2HaLx6kNtSvr2iXq9is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0Mmdz6OrBf5cL29l67G/2OZkbMWmg7lbCKsY/y1dqj8HGHDDQmbeYOakoJrkFYbifaIujGplVddYfCAbjVb9/kc7PDN9aKIbB7S66dea7QlWmvGC+6uA10OJB4+VAjO3gV+9x63iDe77Gii3xcndc8RNCDe9z2NjHYcagf3eCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo0RIQGN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741908906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUBZOhWuEQVpSjpi/CjhZKRTs0wsYH6r52iItV59hho=;
	b=Lo0RIQGNUHiSzgsedVR/wBY3yucNx64YD6XfgBeVOcW1e4Gitk0l20jhGuETHZcu1MNfU9
	SVYnY64ioNjW0G3nMrL9pvWxcb+5lVhQ274tjX6FfePuHaKDrXoVjhL1ogIzDcc3GK6fUX
	Hceo1a4NQ2aIGLGiHosqT3TJIieD/No=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-EUCU_udSMd2taUaoL9R1JA-1; Thu,
 13 Mar 2025 19:35:02 -0400
X-MC-Unique: EUCU_udSMd2taUaoL9R1JA-1
X-Mimecast-MFC-AGG-ID: EUCU_udSMd2taUaoL9R1JA_1741908901
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 227DB19560B7;
	Thu, 13 Mar 2025 23:35:01 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.61])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 698A119373D7;
	Thu, 13 Mar 2025 23:34:58 +0000 (UTC)
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
Subject: [RFC PATCH 19/35] libceph, ceph: Convert users of ceph_pagelist to ceph_databuf
Date: Thu, 13 Mar 2025 23:33:11 +0000
Message-ID: <20250313233341.1675324-20-dhowells@redhat.com>
In-Reply-To: <20250313233341.1675324-1-dhowells@redhat.com>
References: <20250313233341.1675324-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Convert users of ceph_pagelist to use ceph_databuf instead.  ceph_pagelist
is then unused and can be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Viacheslav Dubeyko <slava@dubeyko.com>
cc: Alex Markuze <amarkuze@redhat.com>
cc: Ilya Dryomov <idryomov@gmail.com>
cc: ceph-devel@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/locks.c                 |  22 +++---
 fs/ceph/mds_client.c            | 122 +++++++++++++++-----------------
 fs/ceph/super.h                 |   6 +-
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/osd_client.c           |  61 ++++++++--------
 5 files changed, 104 insertions(+), 109 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index ebf4ac0055dd..32c7b0f0d61f 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -371,8 +371,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 }
 
 /*
- * Fills in the passed counter variables, so you can prepare pagelist metadata
- * before calling ceph_encode_locks.
+ * Fills in the passed counter variables, so you can prepare metadata before
+ * calling ceph_encode_locks.
  */
 void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 {
@@ -483,38 +483,38 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
 }
 
 /*
- * Copy the encoded flock and fcntl locks into the pagelist.
+ * Copy the encoded flock and fcntl locks into the data buffer.
  * Format is: #fcntl locks, sequential fcntl locks, #flock locks,
  * sequential flock locks.
  * Returns zero on success.
  */
-int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
-			   struct ceph_pagelist *pagelist,
+int ceph_locks_to_databuf(struct ceph_filelock *flocks,
+			   struct ceph_databuf *dbuf,
 			   int num_fcntl_locks, int num_flock_locks)
 {
 	int err = 0;
 	__le32 nlocks;
 
 	nlocks = cpu_to_le32(num_fcntl_locks);
-	err = ceph_pagelist_append(pagelist, &nlocks, sizeof(nlocks));
+	err = ceph_databuf_append(dbuf, &nlocks, sizeof(nlocks));
 	if (err)
 		goto out_fail;
 
 	if (num_fcntl_locks > 0) {
-		err = ceph_pagelist_append(pagelist, flocks,
-					   num_fcntl_locks * sizeof(*flocks));
+		err = ceph_databuf_append(dbuf, flocks,
+					  num_fcntl_locks * sizeof(*flocks));
 		if (err)
 			goto out_fail;
 	}
 
 	nlocks = cpu_to_le32(num_flock_locks);
-	err = ceph_pagelist_append(pagelist, &nlocks, sizeof(nlocks));
+	err = ceph_databuf_append(dbuf, &nlocks, sizeof(nlocks));
 	if (err)
 		goto out_fail;
 
 	if (num_flock_locks > 0) {
-		err = ceph_pagelist_append(pagelist, &flocks[num_fcntl_locks],
-					   num_flock_locks * sizeof(*flocks));
+		err = ceph_databuf_append(dbuf, &flocks[num_fcntl_locks],
+					  num_flock_locks * sizeof(*flocks));
 	}
 out_fail:
 	return err;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 09661a34f287..f1c6d0ebf548 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -55,7 +55,7 @@
 struct ceph_reconnect_state {
 	struct ceph_mds_session *session;
 	int nr_caps, nr_realms;
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *dbuf;
 	unsigned msg_version;
 	bool allow_multi;
 };
@@ -4456,8 +4456,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 {
 	struct ceph_msg *reply;
-	struct ceph_pagelist *_pagelist;
-	struct page *page;
+	struct ceph_databuf *_dbuf;
 	__le32 *addr;
 	int err = -ENOMEM;
 
@@ -4467,9 +4466,9 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 	/* can't handle message that contains both caps and realm */
 	BUG_ON(!recon_state->nr_caps == !recon_state->nr_realms);
 
-	/* pre-allocate new pagelist */
-	_pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!_pagelist)
+	/* pre-allocate new databuf */
+	_dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!_dbuf)
 		return -ENOMEM;
 
 	reply = ceph_msg_new2(CEPH_MSG_CLIENT_RECONNECT, 0, 1, GFP_NOFS, false);
@@ -4477,28 +4476,27 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 		goto fail_msg;
 
 	/* placeholder for nr_caps */
-	err = ceph_pagelist_encode_32(_pagelist, 0);
+	err = ceph_databuf_encode_32(_dbuf, 0);
 	if (err < 0)
 		goto fail;
 
 	if (recon_state->nr_caps) {
 		/* currently encoding caps */
-		err = ceph_pagelist_encode_32(recon_state->pagelist, 0);
+		err = ceph_databuf_encode_32(recon_state->dbuf, 0);
 		if (err)
 			goto fail;
 	} else {
 		/* placeholder for nr_realms (currently encoding relams) */
-		err = ceph_pagelist_encode_32(_pagelist, 0);
+		err = ceph_databuf_encode_32(_dbuf, 0);
 		if (err < 0)
 			goto fail;
 	}
 
-	err = ceph_pagelist_encode_8(recon_state->pagelist, 1);
+	err = ceph_databuf_encode_8(recon_state->dbuf, 1);
 	if (err)
 		goto fail;
 
-	page = list_first_entry(&recon_state->pagelist->head, struct page, lru);
-	addr = kmap_atomic(page);
+	addr = kmap_ceph_databuf_page(recon_state->dbuf, 0);
 	if (recon_state->nr_caps) {
 		/* currently encoding caps */
 		*addr = cpu_to_le32(recon_state->nr_caps);
@@ -4506,18 +4504,18 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 		/* currently encoding relams */
 		*(addr + 1) = cpu_to_le32(recon_state->nr_realms);
 	}
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	reply->hdr.version = cpu_to_le16(5);
 	reply->hdr.compat_version = cpu_to_le16(4);
 
-	reply->hdr.data_len = cpu_to_le32(recon_state->pagelist->length);
-	ceph_msg_data_add_pagelist(reply, recon_state->pagelist);
+	reply->hdr.data_len = cpu_to_le32(ceph_databuf_len(recon_state->dbuf));
+	ceph_msg_data_add_databuf(reply, recon_state->dbuf);
 
 	ceph_con_send(&recon_state->session->s_con, reply);
-	ceph_pagelist_release(recon_state->pagelist);
+	ceph_databuf_release(recon_state->dbuf);
 
-	recon_state->pagelist = _pagelist;
+	recon_state->dbuf = _dbuf;
 	recon_state->nr_caps = 0;
 	recon_state->nr_realms = 0;
 	recon_state->msg_version = 5;
@@ -4525,7 +4523,7 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 fail:
 	ceph_msg_put(reply);
 fail_msg:
-	ceph_pagelist_release(_pagelist);
+	ceph_databuf_release(_dbuf);
 	return err;
 }
 
@@ -4575,7 +4573,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	} rec;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_reconnect_state *recon_state = arg;
-	struct ceph_pagelist *pagelist = recon_state->pagelist;
+	struct ceph_databuf *dbuf = recon_state->dbuf;
 	struct dentry *dentry;
 	struct ceph_cap *cap;
 	char *path;
@@ -4698,7 +4696,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 			struct_v = 2;
 		}
 		/*
-		 * number of encoded locks is stable, so copy to pagelist
+		 * number of encoded locks is stable, so copy to databuf
 		 */
 		struct_len = 2 * sizeof(u32) +
 			    (num_fcntl_locks + num_flock_locks) *
@@ -4712,41 +4710,42 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 
 		total_len += struct_len;
 
-		if (pagelist->length + total_len > RECONNECT_MAX_SIZE) {
+		if (ceph_databuf_len(dbuf) + total_len > RECONNECT_MAX_SIZE) {
 			err = send_reconnect_partial(recon_state);
 			if (err)
 				goto out_freeflocks;
-			pagelist = recon_state->pagelist;
+			dbuf = recon_state->dbuf;
 		}
 
-		err = ceph_pagelist_reserve(pagelist, total_len);
+		err = ceph_databuf_reserve(dbuf, total_len, GFP_NOFS);
 		if (err)
 			goto out_freeflocks;
 
-		ceph_pagelist_encode_64(pagelist, ceph_ino(inode));
+		ceph_databuf_encode_64(dbuf, ceph_ino(inode));
 		if (recon_state->msg_version >= 3) {
-			ceph_pagelist_encode_8(pagelist, struct_v);
-			ceph_pagelist_encode_8(pagelist, 1);
-			ceph_pagelist_encode_32(pagelist, struct_len);
+			ceph_databuf_encode_8(dbuf, struct_v);
+			ceph_databuf_encode_8(dbuf, 1);
+			ceph_databuf_encode_32(dbuf, struct_len);
 		}
-		ceph_pagelist_encode_string(pagelist, path, pathlen);
-		ceph_pagelist_append(pagelist, &rec, sizeof(rec.v2));
-		ceph_locks_to_pagelist(flocks, pagelist,
-				       num_fcntl_locks, num_flock_locks);
+		ceph_databuf_encode_string(dbuf, path, pathlen);
+		ceph_databuf_append(dbuf, &rec, sizeof(rec.v2));
+		ceph_locks_to_databuf(flocks, dbuf,
+				      num_fcntl_locks, num_flock_locks);
 		if (struct_v >= 2)
-			ceph_pagelist_encode_64(pagelist, snap_follows);
+			ceph_databuf_encode_64(dbuf, snap_follows);
 out_freeflocks:
 		kfree(flocks);
 	} else {
-		err = ceph_pagelist_reserve(pagelist,
-					    sizeof(u64) + sizeof(u32) +
-					    pathlen + sizeof(rec.v1));
+		err = ceph_databuf_reserve(dbuf,
+					   sizeof(u64) + sizeof(u32) +
+					   pathlen + sizeof(rec.v1),
+					   GFP_NOFS);
 		if (err)
 			goto out_err;
 
-		ceph_pagelist_encode_64(pagelist, ceph_ino(inode));
-		ceph_pagelist_encode_string(pagelist, path, pathlen);
-		ceph_pagelist_append(pagelist, &rec, sizeof(rec.v1));
+		ceph_databuf_encode_64(dbuf, ceph_ino(inode));
+		ceph_databuf_encode_string(dbuf, path, pathlen);
+		ceph_databuf_append(dbuf, &rec, sizeof(rec.v1));
 	}
 
 out_err:
@@ -4760,12 +4759,12 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			      struct ceph_reconnect_state *recon_state)
 {
 	struct rb_node *p;
-	struct ceph_pagelist *pagelist = recon_state->pagelist;
 	struct ceph_client *cl = mdsc->fsc->client;
+	struct ceph_databuf *dbuf = recon_state->dbuf;
 	int err = 0;
 
 	if (recon_state->msg_version >= 4) {
-		err = ceph_pagelist_encode_32(pagelist, mdsc->num_snap_realms);
+		err = ceph_databuf_encode_32(dbuf, mdsc->num_snap_realms);
 		if (err < 0)
 			goto fail;
 	}
@@ -4784,20 +4783,20 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			size_t need = sizeof(u8) * 2 + sizeof(u32) +
 				      sizeof(sr_rec);
 
-			if (pagelist->length + need > RECONNECT_MAX_SIZE) {
+			if (ceph_databuf_len(dbuf) + need > RECONNECT_MAX_SIZE) {
 				err = send_reconnect_partial(recon_state);
 				if (err)
 					goto fail;
-				pagelist = recon_state->pagelist;
+				dbuf = recon_state->dbuf;
 			}
 
-			err = ceph_pagelist_reserve(pagelist, need);
+			err = ceph_databuf_reserve(dbuf, need, GFP_NOFS);
 			if (err)
 				goto fail;
 
-			ceph_pagelist_encode_8(pagelist, 1);
-			ceph_pagelist_encode_8(pagelist, 1);
-			ceph_pagelist_encode_32(pagelist, sizeof(sr_rec));
+			ceph_databuf_encode_8(dbuf, 1);
+			ceph_databuf_encode_8(dbuf, 1);
+			ceph_databuf_encode_32(dbuf, sizeof(sr_rec));
 		}
 
 		doutc(cl, " adding snap realm %llx seq %lld parent %llx\n",
@@ -4806,7 +4805,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 		sr_rec.seq = cpu_to_le64(realm->seq);
 		sr_rec.parent = cpu_to_le64(realm->parent_ino);
 
-		err = ceph_pagelist_append(pagelist, &sr_rec, sizeof(sr_rec));
+		err = ceph_databuf_append(dbuf, &sr_rec, sizeof(sr_rec));
 		if (err)
 			goto fail;
 
@@ -4841,9 +4840,9 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	pr_info_client(cl, "mds%d reconnect start\n", mds);
 
-	recon_state.pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!recon_state.pagelist)
-		goto fail_nopagelist;
+	recon_state.dbuf = ceph_databuf_req_alloc(1, 0, GFP_NOFS);
+	if (!recon_state.dbuf)
+		goto fail_nodatabuf;
 
 	reply = ceph_msg_new2(CEPH_MSG_CLIENT_RECONNECT, 0, 1, GFP_NOFS, false);
 	if (!reply)
@@ -4891,7 +4890,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	down_read(&mdsc->snap_rwsem);
 
 	/* placeholder for nr_caps */
-	err = ceph_pagelist_encode_32(recon_state.pagelist, 0);
+	err = ceph_databuf_encode_32(recon_state.dbuf, 0);
 	if (err)
 		goto fail;
 
@@ -4916,7 +4915,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	/* check if all realms can be encoded into current message */
 	if (mdsc->num_snap_realms) {
 		size_t total_len =
-			recon_state.pagelist->length +
+			ceph_databuf_len(recon_state.dbuf) +
 			mdsc->num_snap_realms *
 			sizeof(struct ceph_mds_snaprealm_reconnect);
 		if (recon_state.msg_version >= 4) {
@@ -4945,31 +4944,28 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 		goto fail;
 
 	if (recon_state.msg_version >= 5) {
-		err = ceph_pagelist_encode_8(recon_state.pagelist, 0);
+		err = ceph_databuf_encode_8(recon_state.dbuf, 0);
 		if (err < 0)
 			goto fail;
 	}
 
 	if (recon_state.nr_caps || recon_state.nr_realms) {
-		struct page *page =
-			list_first_entry(&recon_state.pagelist->head,
-					struct page, lru);
-		__le32 *addr = kmap_atomic(page);
+		__le32 *addr = kmap_ceph_databuf_page(recon_state.dbuf, 0);
 		if (recon_state.nr_caps) {
 			WARN_ON(recon_state.nr_realms != mdsc->num_snap_realms);
 			*addr = cpu_to_le32(recon_state.nr_caps);
 		} else if (recon_state.msg_version >= 4) {
 			*(addr + 1) = cpu_to_le32(recon_state.nr_realms);
 		}
-		kunmap_atomic(addr);
+		kunmap_local(addr);
 	}
 
 	reply->hdr.version = cpu_to_le16(recon_state.msg_version);
 	if (recon_state.msg_version >= 4)
 		reply->hdr.compat_version = cpu_to_le16(4);
 
-	reply->hdr.data_len = cpu_to_le32(recon_state.pagelist->length);
-	ceph_msg_data_add_pagelist(reply, recon_state.pagelist);
+	reply->hdr.data_len = cpu_to_le32(ceph_databuf_len(recon_state.dbuf));
+	ceph_msg_data_add_databuf(reply, recon_state.dbuf);
 
 	ceph_con_send(&session->s_con, reply);
 
@@ -4980,7 +4976,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	mutex_unlock(&mdsc->mutex);
 
 	up_read(&mdsc->snap_rwsem);
-	ceph_pagelist_release(recon_state.pagelist);
+	ceph_databuf_release(recon_state.dbuf);
 	return;
 
 fail:
@@ -4988,8 +4984,8 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	up_read(&mdsc->snap_rwsem);
 	mutex_unlock(&session->s_mutex);
 fail_nomsg:
-	ceph_pagelist_release(recon_state.pagelist);
-fail_nopagelist:
+	ceph_databuf_release(recon_state.dbuf);
+fail_nodatabuf:
 	pr_err_client(cl, "error %d preparing reconnect for mds%d\n",
 		      err, mds);
 	return;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 984a6d2a5378..b072572e2cf4 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1351,9 +1351,9 @@ extern int ceph_encode_locks_to_buffer(struct inode *inode,
 				       struct ceph_filelock *flocks,
 				       int num_fcntl_locks,
 				       int num_flock_locks);
-extern int ceph_locks_to_pagelist(struct ceph_filelock *flocks,
-				  struct ceph_pagelist *pagelist,
-				  int num_fcntl_locks, int num_flock_locks);
+extern int ceph_locks_to_databuf(struct ceph_filelock *flocks,
+				 struct ceph_databuf *dbuf,
+				 int num_fcntl_locks, int num_flock_locks);
 
 /* debugfs.c */
 extern void ceph_fs_debugfs_init(struct ceph_fs_client *client);
diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 6e126e212271..ce04205b8143 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -334,7 +334,7 @@ struct ceph_osd_linger_request {
 	rados_watcherrcb_t errcb;
 	void *data;
 
-	struct ceph_pagelist *request_pl;
+	struct ceph_databuf *request_pl;
 	struct ceph_databuf *notify_id_buf;
 
 	struct page ***preply_pages;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 64a06267e7b3..a967309d01a7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -810,37 +810,37 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 {
 	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which,
 						     opcode, 0);
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *dbuf;
 	size_t payload_len;
 	int ret;
 
 	BUG_ON(opcode != CEPH_OSD_OP_SETXATTR && opcode != CEPH_OSD_OP_CMPXATTR);
 
-	pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!pagelist)
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!dbuf)
 		return -ENOMEM;
 
 	payload_len = strlen(name);
 	op->xattr.name_len = payload_len;
-	ret = ceph_pagelist_append(pagelist, name, payload_len);
+	ret = ceph_databuf_append(dbuf, name, payload_len);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 
 	op->xattr.value_len = size;
-	ret = ceph_pagelist_append(pagelist, value, size);
+	ret = ceph_databuf_append(dbuf, value, size);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 	payload_len += size;
 
 	op->xattr.cmp_op = cmp_op;
 	op->xattr.cmp_mode = cmp_mode;
 
-	ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
+	ceph_osd_databuf_init(&op->xattr.osd_data, dbuf);
 	op->indata_len = payload_len;
 	return 0;
 
-err_pagelist_free:
-	ceph_pagelist_release(pagelist);
+err_databuf_free:
+	ceph_databuf_release(dbuf);
 	return ret;
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
@@ -864,15 +864,15 @@ static void osd_req_op_watch_init(struct ceph_osd_request *req, int which,
  * encoded in @request_pl
  */
 static void osd_req_op_notify_init(struct ceph_osd_request *req, int which,
-				   u64 cookie, struct ceph_pagelist *request_pl)
+				   u64 cookie, struct ceph_databuf *request_pl)
 {
 	struct ceph_osd_req_op *op;
 
 	op = osd_req_op_init(req, which, CEPH_OSD_OP_NOTIFY, 0);
 	op->notify.cookie = cookie;
 
-	ceph_osd_data_pagelist_init(&op->notify.request_data, request_pl);
-	op->indata_len = request_pl->length;
+	ceph_osd_databuf_init(&op->notify.request_data, request_pl);
+	op->indata_len = ceph_databuf_len(request_pl);
 }
 
 /*
@@ -2730,8 +2730,7 @@ static void linger_release(struct kref *kref)
 	WARN_ON(!list_empty(&lreq->pending_lworks));
 	WARN_ON(lreq->osd);
 
-	if (lreq->request_pl)
-		ceph_pagelist_release(lreq->request_pl);
+	ceph_databuf_release(lreq->request_pl);
 	ceph_databuf_release(lreq->notify_id_buf);
 	ceph_osdc_put_request(lreq->reg_req);
 	ceph_osdc_put_request(lreq->ping_req);
@@ -4800,30 +4799,30 @@ static int osd_req_op_notify_ack_init(struct ceph_osd_request *req, int which,
 				      u32 payload_len)
 {
 	struct ceph_osd_req_op *op;
-	struct ceph_pagelist *pl;
+	struct ceph_databuf *dbuf;
 	int ret;
 
 	op = osd_req_op_init(req, which, CEPH_OSD_OP_NOTIFY_ACK, 0);
 
-	pl = ceph_pagelist_alloc(GFP_NOIO);
-	if (!pl)
+	dbuf = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
+	if (!dbuf)
 		return -ENOMEM;
 
-	ret = ceph_pagelist_encode_64(pl, notify_id);
-	ret |= ceph_pagelist_encode_64(pl, cookie);
+	ret = ceph_databuf_encode_64(dbuf, notify_id);
+	ret |= ceph_databuf_encode_64(dbuf, cookie);
 	if (payload) {
-		ret |= ceph_pagelist_encode_32(pl, payload_len);
-		ret |= ceph_pagelist_append(pl, payload, payload_len);
+		ret |= ceph_databuf_encode_32(dbuf, payload_len);
+		ret |= ceph_databuf_append(dbuf, payload, payload_len);
 	} else {
-		ret |= ceph_pagelist_encode_32(pl, 0);
+		ret |= ceph_databuf_encode_32(dbuf, 0);
 	}
 	if (ret) {
-		ceph_pagelist_release(pl);
+		ceph_databuf_release(dbuf);
 		return -ENOMEM;
 	}
 
-	ceph_osd_data_pagelist_init(&op->notify_ack.request_data, pl);
-	op->indata_len = pl->length;
+	ceph_osd_databuf_init(&op->notify_ack.request_data, dbuf);
+	op->indata_len = ceph_databuf_len(dbuf);
 	return 0;
 }
 
@@ -4894,16 +4893,16 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	if (!lreq)
 		return -ENOMEM;
 
-	lreq->request_pl = ceph_pagelist_alloc(GFP_NOIO);
+	lreq->request_pl = ceph_databuf_req_alloc(1, PAGE_SIZE, GFP_NOIO);
 	if (!lreq->request_pl) {
 		ret = -ENOMEM;
 		goto out_put_lreq;
 	}
 
-	ret = ceph_pagelist_encode_32(lreq->request_pl, 1); /* prot_ver */
-	ret |= ceph_pagelist_encode_32(lreq->request_pl, timeout);
-	ret |= ceph_pagelist_encode_32(lreq->request_pl, payload_len);
-	ret |= ceph_pagelist_append(lreq->request_pl, payload, payload_len);
+	ret = ceph_databuf_encode_32(lreq->request_pl, 1); /* prot_ver */
+	ret |= ceph_databuf_encode_32(lreq->request_pl, timeout);
+	ret |= ceph_databuf_encode_32(lreq->request_pl, payload_len);
+	ret |= ceph_databuf_append(lreq->request_pl, payload, payload_len);
 	if (ret) {
 		ret = -ENOMEM;
 		goto out_put_lreq;


