Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B053770128
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHDNQ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjHDNQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:16:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC9F4C3E
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691154841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ucOU73UJvL5lCXTBUmFZSu8hq85qxGTL5/KzMwKRC7s=;
        b=bhDopYROlhka60VFwO8lxMxgmXTlgFufmaDSkVJL+JQGUmc/43ZRDjfNJ6ygHta4ajUUsp
        LHgK/amZnfryWJOFGdurQVuvwc8ttg1+LxwAv8xm/RS/Sxs8BFE9CufniJ2yvhpNC+QXG5
        M6zXpcVNGuJ+s4QeobLo6i1KSVFrsYY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-EEHHPTiQMVeIQTvxqE2XFg-1; Fri, 04 Aug 2023 09:13:57 -0400
X-MC-Unique: EEHHPTiQMVeIQTvxqE2XFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40AEF3C0FCA3;
        Fri,  4 Aug 2023 13:13:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F290040C2063;
        Fri,  4 Aug 2023 13:13:55 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 13/18] ceph: Convert users of ceph_pagelist to ceph_databuf
Date:   Fri,  4 Aug 2023 14:13:22 +0100
Message-ID: <20230804131327.2574082-14-dhowells@redhat.com>
In-Reply-To: <20230804131327.2574082-1-dhowells@redhat.com>
References: <20230804131327.2574082-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert users of ceph_pagelist to use ceph_databuf instead.  ceph_pagelist
is then unused and can be removed.

Signed-off-by: David Howells <dhowells@redhat.com>
---
 fs/ceph/locks.c                 |  22 +++---
 fs/ceph/mds_client.c            | 122 +++++++++++++++-----------------
 fs/ceph/super.h                 |   6 +-
 include/linux/ceph/osd_client.h |   2 +-
 net/ceph/osd_client.c           |  90 ++++++++++++-----------
 5 files changed, 124 insertions(+), 118 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index e07ad29ff8b9..b3c018a8a92f 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -370,8 +370,8 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 }
 
 /*
- * Fills in the passed counter variables, so you can prepare pagelist metadata
- * before calling ceph_encode_locks.
+ * Fills in the passed counter variables, so you can prepare metadata before
+ * calling ceph_encode_locks.
  */
 void ceph_count_locks(struct inode *inode, int *fcntl_count, int *flock_count)
 {
@@ -481,38 +481,38 @@ int ceph_encode_locks_to_buffer(struct inode *inode,
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
index 85b2f1eccf88..9f5c4f47982e 100644
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
@@ -4244,8 +4244,7 @@ static void replay_unsafe_requests(struct ceph_mds_client *mdsc,
 static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 {
 	struct ceph_msg *reply;
-	struct ceph_pagelist *_pagelist;
-	struct page *page;
+	struct ceph_databuf *_dbuf;
 	__le32 *addr;
 	int err = -ENOMEM;
 
@@ -4255,9 +4254,9 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 	/* can't handle message that contains both caps and realm */
 	BUG_ON(!recon_state->nr_caps == !recon_state->nr_realms);
 
-	/* pre-allocate new pagelist */
-	_pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!_pagelist)
+	/* pre-allocate new databuf */
+	_dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!_dbuf)
 		return -ENOMEM;
 
 	reply = ceph_msg_new2(CEPH_MSG_CLIENT_RECONNECT, 0, 1, GFP_NOFS, false);
@@ -4265,28 +4264,27 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
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
@@ -4294,18 +4292,18 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 		/* currently encoding relams */
 		*(addr + 1) = cpu_to_le32(recon_state->nr_realms);
 	}
-	kunmap_atomic(addr);
+	kunmap_local(addr);
 
 	reply->hdr.version = cpu_to_le16(5);
 	reply->hdr.compat_version = cpu_to_le16(4);
 
-	reply->hdr.data_len = cpu_to_le32(recon_state->pagelist->length);
-	ceph_msg_data_add_pagelist(reply, recon_state->pagelist);
+	reply->hdr.data_len = cpu_to_le32(recon_state->dbuf->length);
+	ceph_msg_data_add_databuf(reply, recon_state->dbuf);
 
 	ceph_con_send(&recon_state->session->s_con, reply);
-	ceph_pagelist_release(recon_state->pagelist);
+	ceph_databuf_release(recon_state->dbuf);
 
-	recon_state->pagelist = _pagelist;
+	recon_state->dbuf = _dbuf;
 	recon_state->nr_caps = 0;
 	recon_state->nr_realms = 0;
 	recon_state->msg_version = 5;
@@ -4313,7 +4311,7 @@ static int send_reconnect_partial(struct ceph_reconnect_state *recon_state)
 fail:
 	ceph_msg_put(reply);
 fail_msg:
-	ceph_pagelist_release(_pagelist);
+	ceph_databuf_release(_dbuf);
 	return err;
 }
 
@@ -4363,7 +4361,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 	} rec;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_reconnect_state *recon_state = arg;
-	struct ceph_pagelist *pagelist = recon_state->pagelist;
+	struct ceph_databuf *dbuf = recon_state->dbuf;
 	struct dentry *dentry;
 	struct ceph_cap *cap;
 	char *path;
@@ -4482,7 +4480,7 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 			struct_v = 2;
 		}
 		/*
-		 * number of encoded locks is stable, so copy to pagelist
+		 * number of encoded locks is stable, so copy to databuf
 		 */
 		struct_len = 2 * sizeof(u32) +
 			    (num_fcntl_locks + num_flock_locks) *
@@ -4496,41 +4494,42 @@ static int reconnect_caps_cb(struct inode *inode, int mds, void *arg)
 
 		total_len += struct_len;
 
-		if (pagelist->length + total_len > RECONNECT_MAX_SIZE) {
+		if (dbuf->length + total_len > RECONNECT_MAX_SIZE) {
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
@@ -4544,12 +4543,12 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			      struct ceph_reconnect_state *recon_state)
 {
 	struct rb_node *p;
-	struct ceph_pagelist *pagelist = recon_state->pagelist;
+	struct ceph_databuf *dbuf = recon_state->dbuf;
 	struct ceph_client *cl = mdsc->fsc->client;
 	int err = 0;
 
 	if (recon_state->msg_version >= 4) {
-		err = ceph_pagelist_encode_32(pagelist, mdsc->num_snap_realms);
+		err = ceph_databuf_encode_32(dbuf, mdsc->num_snap_realms);
 		if (err < 0)
 			goto fail;
 	}
@@ -4568,20 +4567,20 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 			size_t need = sizeof(u8) * 2 + sizeof(u32) +
 				      sizeof(sr_rec);
 
-			if (pagelist->length + need > RECONNECT_MAX_SIZE) {
+			if (dbuf->length + need > RECONNECT_MAX_SIZE) {
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
@@ -4590,7 +4589,7 @@ static int encode_snap_realms(struct ceph_mds_client *mdsc,
 		sr_rec.seq = cpu_to_le64(realm->seq);
 		sr_rec.parent = cpu_to_le64(realm->parent_ino);
 
-		err = ceph_pagelist_append(pagelist, &sr_rec, sizeof(sr_rec));
+		err = ceph_databuf_append(dbuf, &sr_rec, sizeof(sr_rec));
 		if (err)
 			goto fail;
 
@@ -4625,9 +4624,9 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 
 	pr_info_client(cl, "mds%d reconnect start\n", mds);
 
-	recon_state.pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!recon_state.pagelist)
-		goto fail_nopagelist;
+	recon_state.dbuf = ceph_databuf_alloc(1, 0, GFP_NOFS);
+	if (!recon_state.dbuf)
+		goto fail_nodatabuf;
 
 	reply = ceph_msg_new2(CEPH_MSG_CLIENT_RECONNECT, 0, 1, GFP_NOFS, false);
 	if (!reply)
@@ -4675,7 +4674,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	down_read(&mdsc->snap_rwsem);
 
 	/* placeholder for nr_caps */
-	err = ceph_pagelist_encode_32(recon_state.pagelist, 0);
+	err = ceph_databuf_encode_32(recon_state.dbuf, 0);
 	if (err)
 		goto fail;
 
@@ -4700,7 +4699,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	/* check if all realms can be encoded into current message */
 	if (mdsc->num_snap_realms) {
 		size_t total_len =
-			recon_state.pagelist->length +
+			recon_state.dbuf->length +
 			mdsc->num_snap_realms *
 			sizeof(struct ceph_mds_snaprealm_reconnect);
 		if (recon_state.msg_version >= 4) {
@@ -4729,31 +4728,28 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
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
+	reply->hdr.data_len = cpu_to_le32(recon_state.dbuf->length);
+	ceph_msg_data_add_databuf(reply, recon_state.dbuf);
 
 	ceph_con_send(&session->s_con, reply);
 
@@ -4764,7 +4760,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	mutex_unlock(&mdsc->mutex);
 
 	up_read(&mdsc->snap_rwsem);
-	ceph_pagelist_release(recon_state.pagelist);
+	ceph_databuf_release(recon_state.dbuf);
 	return;
 
 fail:
@@ -4772,8 +4768,8 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
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
index 681e634052b1..169d88725209 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1358,9 +1358,9 @@ extern int ceph_encode_locks_to_buffer(struct inode *inode,
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
index fec78550d5ce..82c1c325861d 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -333,7 +333,7 @@ struct ceph_osd_linger_request {
 	rados_watcherrcb_t errcb;
 	void *data;
 
-	struct ceph_pagelist *request_pl;
+	struct ceph_databuf *request_pl;
 	struct ceph_databuf *notify_id_buf;
 
 	struct page ***preply_pages;
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index c83ae9bb335e..c4486799f54b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -255,6 +255,16 @@ void osd_req_op_extent_osd_iter(struct ceph_osd_request *osd_req,
 }
 EXPORT_SYMBOL(osd_req_op_extent_osd_iter);
 
+static void osd_req_op_cls_request_info_databuf(struct ceph_osd_request *osd_req,
+						unsigned int which,
+						struct ceph_databuf *dbuf)
+{
+	struct ceph_osd_data *osd_data;
+
+	osd_data = osd_req_op_data(osd_req, which, cls, request_info);
+	ceph_osd_databuf_init(osd_data, dbuf);
+}
+
 static void osd_req_op_cls_request_info_pagelist(
 			struct ceph_osd_request *osd_req,
 			unsigned int which, struct ceph_pagelist *pagelist)
@@ -779,41 +789,41 @@ int osd_req_op_cls_init(struct ceph_osd_request *osd_req, unsigned int which,
 			const char *class, const char *method)
 {
 	struct ceph_osd_req_op *op;
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *databuf;
 	size_t payload_len = 0;
 	size_t size;
 	int ret;
 
 	op = osd_req_op_init(osd_req, which, CEPH_OSD_OP_CALL, 0);
 
-	pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!pagelist)
+	databuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!databuf)
 		return -ENOMEM;
 
 	op->cls.class_name = class;
 	size = strlen(class);
 	BUG_ON(size > (size_t) U8_MAX);
 	op->cls.class_len = size;
-	ret = ceph_pagelist_append(pagelist, class, size);
+	ret = ceph_databuf_append(databuf, class, size);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 	payload_len += size;
 
 	op->cls.method_name = method;
 	size = strlen(method);
 	BUG_ON(size > (size_t) U8_MAX);
 	op->cls.method_len = size;
-	ret = ceph_pagelist_append(pagelist, method, size);
+	ret = ceph_databuf_append(databuf, method, size);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 	payload_len += size;
 
-	osd_req_op_cls_request_info_pagelist(osd_req, which, pagelist);
+	osd_req_op_cls_request_info_databuf(osd_req, which, databuf);
 	op->indata_len = payload_len;
 	return 0;
 
-err_pagelist_free:
-	ceph_pagelist_release(pagelist);
+err_databuf_free:
+	ceph_databuf_release(databuf);
 	return ret;
 }
 EXPORT_SYMBOL(osd_req_op_cls_init);
@@ -824,37 +834,37 @@ int osd_req_op_xattr_init(struct ceph_osd_request *osd_req, unsigned int which,
 {
 	struct ceph_osd_req_op *op = osd_req_op_init(osd_req, which,
 						     opcode, 0);
-	struct ceph_pagelist *pagelist;
+	struct ceph_databuf *databuf;
 	size_t payload_len;
 	int ret;
 
 	BUG_ON(opcode != CEPH_OSD_OP_SETXATTR && opcode != CEPH_OSD_OP_CMPXATTR);
 
-	pagelist = ceph_pagelist_alloc(GFP_NOFS);
-	if (!pagelist)
+	databuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOFS);
+	if (!databuf)
 		return -ENOMEM;
 
 	payload_len = strlen(name);
 	op->xattr.name_len = payload_len;
-	ret = ceph_pagelist_append(pagelist, name, payload_len);
+	ret = ceph_databuf_append(databuf, name, payload_len);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 
 	op->xattr.value_len = size;
-	ret = ceph_pagelist_append(pagelist, value, size);
+	ret = ceph_databuf_append(databuf, value, size);
 	if (ret)
-		goto err_pagelist_free;
+		goto err_databuf_free;
 	payload_len += size;
 
 	op->xattr.cmp_op = cmp_op;
 	op->xattr.cmp_mode = cmp_mode;
 
-	ceph_osd_data_pagelist_init(&op->xattr.osd_data, pagelist);
+	ceph_osd_databuf_init(&op->xattr.osd_data, databuf);
 	op->indata_len = payload_len;
 	return 0;
 
-err_pagelist_free:
-	ceph_pagelist_release(pagelist);
+err_databuf_free:
+	ceph_databuf_release(databuf);
 	return ret;
 }
 EXPORT_SYMBOL(osd_req_op_xattr_init);
@@ -878,14 +888,14 @@ static void osd_req_op_watch_init(struct ceph_osd_request *req, int which,
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
+	ceph_osd_databuf_init(&op->notify.request_data, request_pl);
 	op->indata_len = request_pl->length;
 }
 
@@ -2741,7 +2751,7 @@ static void linger_release(struct kref *kref)
 	WARN_ON(!list_empty(&lreq->pending_lworks));
 	WARN_ON(lreq->osd);
 
-	ceph_pagelist_release(lreq->request_pl);
+	ceph_databuf_release(lreq->request_pl);
 	ceph_databuf_release(lreq->notify_id_buf);
 	ceph_osdc_put_request(lreq->reg_req);
 	ceph_osdc_put_request(lreq->ping_req);
@@ -3030,7 +3040,7 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 		void *p;
 
 		WARN_ON(req->r_ops[0].op != CEPH_OSD_OP_NOTIFY ||
-			osd_data->type != CEPH_OSD_DATA_TYPE_PAGELIST);
+			osd_data->type != CEPH_OSD_DATA_TYPE_DATABUF);
 
 		p = kmap_ceph_databuf_page(osd_data->dbuf, 0);
 
@@ -4802,30 +4812,30 @@ static int osd_req_op_notify_ack_init(struct ceph_osd_request *req, int which,
 				      u32 payload_len)
 {
 	struct ceph_osd_req_op *op;
-	struct ceph_pagelist *pl;
+	struct ceph_databuf *dbuf;
 	int ret;
 
 	op = osd_req_op_init(req, which, CEPH_OSD_OP_NOTIFY_ACK, 0);
 
-	pl = ceph_pagelist_alloc(GFP_NOIO);
-	if (!pl)
+	dbuf = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
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
+	op->indata_len = dbuf->length;
 	return 0;
 }
 
@@ -4896,16 +4906,16 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
 	if (!lreq)
 		return -ENOMEM;
 
-	lreq->request_pl = ceph_pagelist_alloc(GFP_NOIO);
+	lreq->request_pl = ceph_databuf_alloc(1, PAGE_SIZE, GFP_NOIO);
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

