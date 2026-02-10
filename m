Return-Path: <linux-fsdevel+bounces-76830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NcyCWT1imn2OwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:07:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C032C1188FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DBF6305ED35
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EEE33F37F;
	Tue, 10 Feb 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwKM5iab";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T4Tra04b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191D33DEE9
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770714401; cv=none; b=M2KIdl+DmAT5F05Z9BcwIGm0gkimqck2hYJqcu48PmNr2jPwQlaY9Vlnu7qJxzhNOqVkSCMF2VAZhS1qPikYGfAC4FmYmcUJ4B1k1hA8ylNAngTUBWRLxCQaXhqNIu8QPJXKmHJT6PKppC0B0WlzEgiNyX1FLfM2m0irvwGEd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770714401; c=relaxed/simple;
	bh=HqvTUkcK2KaBNeIhkjInpeKwxjrauzprCJnCkfP9WjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iVtD2fbYeresgOvOw2ddro5qzzaf6YjSakimj+RrU5TnpUZcx0JlAqrBOdrwyqKaLcbrKZZfR9Jnf10mffcOmQu/SwjGxjcL9WcQGlNCKKPymKZGR2p/+KM5QYVIHH6EhOEckYvFnOrNogIkF0PNFMuEEr20kU1Dz6p1UX6jJbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwKM5iab; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T4Tra04b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770714399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zkCs1P3pUk+bErhrnErXIh8MOnGD+CKHMvkl2mwZZKc=;
	b=BwKM5iabJZTK9mwwChP4MUKfGUUpEKzaz0tuWFOqtBPfsdnmxXAR6pQq+UZ4CMsvSNydbh
	KSlEoG2MyYYhI7LuHnpCArIZL4lRKaoIIn8wrxVrtf75dC4Mfw4lOt45hpinNertbCaYSC
	iNBNqqFL93+YjMQzoVkV97+U94Kc+t8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-9rg73lxRO1ONe01gF7Hl1A-1; Tue, 10 Feb 2026 04:06:38 -0500
X-MC-Unique: 9rg73lxRO1ONe01gF7Hl1A-1
X-Mimecast-MFC-AGG-ID: 9rg73lxRO1ONe01gF7Hl1A_1770714397
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70e610242so1511743185a.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770714397; x=1771319197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkCs1P3pUk+bErhrnErXIh8MOnGD+CKHMvkl2mwZZKc=;
        b=T4Tra04b9uTuaA6I+bDTmA+lK7D+xlMIhjriot/p6Mewc+nHdN55bMH8VUNIgRVRjs
         TM7sBwIlDL1d6bjLaTuxTJkwFbrJZXIoEmFp0BUj0s/QeIJ0ZRbiEOtmc0KYToyphIt6
         IwAPW9VoU+1B4HLiJUUbPbK8SefdkjOagD42D0wwdJ524wm89f3S1TNfCwgXOPQHXfGJ
         8HU/giFa8pDQUWpD3LAookncNJHdtN8ghQuKasKupo9SGvXd4IH0jpylOK0YV4wu6GYJ
         U8aceDLZwHvdXyI8GvOpV4j567hpPd8Ij3RFgPypuXOEyWH+syq6+l01ki6z1aGEIoa6
         HtFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770714397; x=1771319197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkCs1P3pUk+bErhrnErXIh8MOnGD+CKHMvkl2mwZZKc=;
        b=uOtzGMin4oiqTz8xL1ZignB4Z4ZuxiDV9Jv+EARm2lHIPDyVFvMTSil0l+JDUeIBx6
         FHa4Pjg6FA4iTtfu3uqseSsEj/K8PWYHSd3We0zXj1pUPMZ2dVwo7GMjh+phKSoltu+z
         5Xt+w1JJffL5VYLS0h+QClNh6IKYPSZ7ul61v3Q3O5sGxHs2k7ajSAsKiMng9pnTCHRU
         5xjzCLPy+fQFCg4zn5WfZ31LrtFuk+zHE+sWK7f2uVhzabUzCW/L2vDn80zC5qEQGEjM
         GR8EAD4bSwP91xswf8xLQ/4ybU0jdbsjB0TJ+IrYVB5G/8MjlxRVgxJheyRqHojJYk9T
         /Xjg==
X-Forwarded-Encrypted: i=1; AJvYcCUqb40v2tS6SafAj/HKeXfsAGkzpllsp2cs8OyyLaMc88shhI6T7NjDp0LwxqKwYIGtgUMbH2UcefkKW2U4@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyQ3+HE5gOYsQKXcHLqDBxyjtKooqzerkferH7FjAjIYtLO+s
	OzVkwv6c0Oxb72rDZX5U4/wmJcustklpWtviQ6b9gEepLeAMlHzhWUGnnEWwoWZEggjrqVMvobU
	Hnyl5TF1dsTbP52I9TV8KFrqkfXruiQmnzzOx7X+nXF3ylR3lSR5ox+8sDO3t3lRw8b4=
X-Gm-Gg: AZuq6aKvlaInAQ85T9Ryyzrx8zzXiXrMedg284j5/TjxYbj3fLlV0PH6/tmJ/85mjqY
	zM07Ai721LU11JW9ZI4dWlE3qfWoVeSRVe6gREw9jtMjWIujXTODwjHR44nl/6C9vH7WifRzrBo
	bzAGsTyu4XImPaPljKTdzojw2WIalC3UCS4rOAsZTXiSZamAL7t36GC2pi5g/CEBbEVQE8WNDoT
	34ay49FTjIn6xujtUxplzRZARZHB/1Ee60tLWTcLk29rGQE9Q9QAsHIjxO9SGeCJrJX9xtqez8j
	enQlWed2XkkOd1pd7ZZKOWyyac8Qc720GB036EoFRLDPOcuzTMkXEVxLoE0lS5dKIX1t7i4DeMb
	KHKqDCfC+BAKUBa/ckyl3M9Eak+pG7bTOsDlnJdLg5Rf48HiH7TKvTjI=
X-Received: by 2002:a05:620a:2901:b0:8ca:3c67:891e with SMTP id af79cd13be357-8cb1f6ebf31mr145645685a.42.1770714397333;
        Tue, 10 Feb 2026 01:06:37 -0800 (PST)
X-Received: by 2002:a05:620a:2901:b0:8ca:3c67:891e with SMTP id af79cd13be357-8cb1f6ebf31mr145643385a.42.1770714396962;
        Tue, 10 Feb 2026 01:06:36 -0800 (PST)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c068292sm108053326d6.45.2026.02.10.01.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:06:36 -0800 (PST)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	linux-fsdevel@vger.kernel.org,
	amarkuze@redhat.com,
	vdubeyko@redhat.com
Subject: [PATCH v6 2/3] ceph: parse subvolume_id from InodeStat v9 and store in inode
Date: Tue, 10 Feb 2026 09:06:25 +0000
Message-Id: <20260210090626.1835644-3-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260210090626.1835644-1-amarkuze@redhat.com>
References: <20260210090626.1835644-1-amarkuze@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76830-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,redhat.com];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amarkuze@redhat.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C032C1188FA
X-Rspamd-Action: no action

Add support for parsing the subvolume_id field from InodeStat v9 and
storing it in the inode for later use by subvolume metrics tracking.

The subvolume_id identifies which CephFS subvolume an inode belongs to,
enabling per-subvolume I/O metrics collection and reporting.

This patch:
- Adds subvolume_id field to struct ceph_mds_reply_info_in
- Adds i_subvolume_id field to struct ceph_inode_info
- Parses subvolume_id from v9 InodeStat in parse_reply_info_in()
- Adds ceph_inode_set_subvolume() helper to propagate the ID to inodes
- Initializes i_subvolume_id in inode allocation and clears on destroy

Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/ceph/inode.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 fs/ceph/mds_client.c | 38 ++++++++++++++++++++++++--------------
 fs/ceph/mds_client.h |  1 +
 fs/ceph/super.h      | 10 ++++++++++
 4 files changed, 76 insertions(+), 14 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 2966f88310e3..c2edbeda19ca 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -638,6 +638,7 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	ci->i_max_bytes = 0;
 	ci->i_max_files = 0;
+	ci->i_subvolume_id = CEPH_SUBVOLUME_ID_NONE;
 
 	memset(&ci->i_dir_layout, 0, sizeof(ci->i_dir_layout));
 	memset(&ci->i_cached_layout, 0, sizeof(ci->i_cached_layout));
@@ -742,6 +743,8 @@ void ceph_evict_inode(struct inode *inode)
 
 	percpu_counter_dec(&mdsc->metric.total_inodes);
 
+	ci->i_subvolume_id = CEPH_SUBVOLUME_ID_NONE;
+
 	netfs_wait_for_outstanding_io(inode);
 	truncate_inode_pages_final(&inode->i_data);
 	if (inode_state_read_once(inode) & I_PINNING_NETFS_WB)
@@ -873,6 +876,40 @@ int ceph_fill_file_size(struct inode *inode, int issued,
 	return queue_trunc;
 }
 
+/*
+ * Set the subvolume ID for an inode.
+ *
+ * The subvolume_id identifies which CephFS subvolume this inode belongs to.
+ * CEPH_SUBVOLUME_ID_NONE (0) means unknown/unset - the MDS only sends
+ * non-zero IDs for inodes within subvolumes.
+ *
+ * An inode's subvolume membership is immutable - once an inode is created
+ * in a subvolume, it stays there. Therefore, if we already have a valid
+ * (non-zero) subvolume_id and receive a different one, that indicates a bug.
+ */
+void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id)
+{
+	struct ceph_inode_info *ci;
+	u64 old;
+
+	if (!inode || subvolume_id == CEPH_SUBVOLUME_ID_NONE)
+		return;
+
+	ci = ceph_inode(inode);
+	old = READ_ONCE(ci->i_subvolume_id);
+
+	if (old == subvolume_id)
+		return;
+
+	if (old != CEPH_SUBVOLUME_ID_NONE) {
+		/* subvolume_id should not change once set */
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	WRITE_ONCE(ci->i_subvolume_id, subvolume_id);
+}
+
 void ceph_fill_file_time(struct inode *inode, int issued,
 			 u64 time_warp_seq, struct timespec64 *ctime,
 			 struct timespec64 *mtime, struct timespec64 *atime)
@@ -1076,6 +1113,7 @@ int ceph_fill_inode(struct inode *inode, struct page *locked_page,
 	new_issued = ~issued & info_caps;
 
 	__ceph_update_quota(ci, iinfo->max_bytes, iinfo->max_files);
+	ceph_inode_set_subvolume(inode, iinfo->subvolume_id);
 
 #ifdef CONFIG_FS_ENCRYPTION
 	if (iinfo->fscrypt_auth_len &&
@@ -1583,6 +1621,8 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 		if (parent_dir) {
+			ceph_inode_set_subvolume(parent_dir,
+						 rinfo->diri.subvolume_id);
 			err = ceph_fill_inode(parent_dir, NULL, &rinfo->diri,
 					      rinfo->dirfrag, session, -1,
 					      &req->r_caps_reservation);
@@ -1671,6 +1711,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 		BUG_ON(!req->r_target_inode);
 
 		in = req->r_target_inode;
+		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
 		err = ceph_fill_inode(in, req->r_locked_page, &rinfo->targeti,
 				NULL, session,
 				(!test_bit(CEPH_MDS_R_ABORTED, &req->r_req_flags) &&
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 045e06a1647d..269bd2141cdc 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -96,19 +96,19 @@ static int parse_reply_info_quota(void **p, void *end,
 	return -EIO;
 }
 
-/*
- * parse individual inode info
- */
 static int parse_reply_info_in(void **p, void *end,
 			       struct ceph_mds_reply_info_in *info,
-			       u64 features)
+			       u64 features,
+			       struct ceph_mds_client *mdsc)
 {
 	int err = 0;
 	u8 struct_v = 0;
+	u8 struct_compat = 0;
+	u32 struct_len = 0;
+
+	info->subvolume_id = CEPH_SUBVOLUME_ID_NONE;
 
 	if (features == (u64)-1) {
-		u32 struct_len;
-		u8 struct_compat;
 		ceph_decode_8_safe(p, end, struct_v, bad);
 		ceph_decode_8_safe(p, end, struct_compat, bad);
 		/* struct_v is expected to be >= 1. we only understand
@@ -252,6 +252,10 @@ static int parse_reply_info_in(void **p, void *end,
 			ceph_decode_skip_n(p, end, v8_struct_len, bad);
 		}
 
+		/* struct_v 9 added subvolume_id */
+		if (struct_v >= 9)
+			ceph_decode_64_safe(p, end, info->subvolume_id, bad);
+
 		*p = end;
 	} else {
 		/* legacy (unversioned) struct */
@@ -384,12 +388,13 @@ static int parse_reply_info_lease(void **p, void *end,
  */
 static int parse_reply_info_trace(void **p, void *end,
 				  struct ceph_mds_reply_info_parsed *info,
-				  u64 features)
+				  u64 features,
+				  struct ceph_mds_client *mdsc)
 {
 	int err;
 
 	if (info->head->is_dentry) {
-		err = parse_reply_info_in(p, end, &info->diri, features);
+		err = parse_reply_info_in(p, end, &info->diri, features, mdsc);
 		if (err < 0)
 			goto out_bad;
 
@@ -409,7 +414,8 @@ static int parse_reply_info_trace(void **p, void *end,
 	}
 
 	if (info->head->is_target) {
-		err = parse_reply_info_in(p, end, &info->targeti, features);
+		err = parse_reply_info_in(p, end, &info->targeti, features,
+					  mdsc);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -430,7 +436,8 @@ static int parse_reply_info_trace(void **p, void *end,
  */
 static int parse_reply_info_readdir(void **p, void *end,
 				    struct ceph_mds_request *req,
-				    u64 features)
+				    u64 features,
+				    struct ceph_mds_client *mdsc)
 {
 	struct ceph_mds_reply_info_parsed *info = &req->r_reply_info;
 	struct ceph_client *cl = req->r_mdsc->fsc->client;
@@ -545,7 +552,7 @@ static int parse_reply_info_readdir(void **p, void *end,
 		rde->name_len = oname.len;
 
 		/* inode */
-		err = parse_reply_info_in(p, end, &rde->inode, features);
+		err = parse_reply_info_in(p, end, &rde->inode, features, mdsc);
 		if (err < 0)
 			goto out_bad;
 		/* ceph_readdir_prepopulate() will update it */
@@ -753,7 +760,8 @@ static int parse_reply_info_extra(void **p, void *end,
 	if (op == CEPH_MDS_OP_GETFILELOCK)
 		return parse_reply_info_filelock(p, end, info, features);
 	else if (op == CEPH_MDS_OP_READDIR || op == CEPH_MDS_OP_LSSNAP)
-		return parse_reply_info_readdir(p, end, req, features);
+		return parse_reply_info_readdir(p, end, req, features,
+						req->r_mdsc);
 	else if (op == CEPH_MDS_OP_CREATE)
 		return parse_reply_info_create(p, end, info, features, s);
 	else if (op == CEPH_MDS_OP_GETVXATTR)
@@ -782,7 +790,8 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
 		ceph_decode_need(&p, end, len, bad);
-		err = parse_reply_info_trace(&p, p+len, info, features);
+		err = parse_reply_info_trace(&p, p + len, info, features,
+					     s->s_mdsc);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -791,7 +800,7 @@ static int parse_reply_info(struct ceph_mds_session *s, struct ceph_msg *msg,
 	ceph_decode_32_safe(&p, end, len, bad);
 	if (len > 0) {
 		ceph_decode_need(&p, end, len, bad);
-		err = parse_reply_info_extra(&p, p+len, req, features, s);
+		err = parse_reply_info_extra(&p, p + len, req, features, s);
 		if (err < 0)
 			goto out_bad;
 	}
@@ -3986,6 +3995,7 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
 			goto out_err;
 		}
 		req->r_target_inode = in;
+		ceph_inode_set_subvolume(in, rinfo->targeti.subvolume_id);
 	}
 
 	mutex_lock(&session->s_mutex);
diff --git a/fs/ceph/mds_client.h b/fs/ceph/mds_client.h
index 0428a5eaf28c..bd3690baa65c 100644
--- a/fs/ceph/mds_client.h
+++ b/fs/ceph/mds_client.h
@@ -118,6 +118,7 @@ struct ceph_mds_reply_info_in {
 	u32 fscrypt_file_len;
 	u64 rsnaps;
 	u64 change_attr;
+	u64 subvolume_id;
 };
 
 struct ceph_mds_reply_dir_entry {
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 29a980e22dc2..cd5f71061264 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -398,6 +398,15 @@ struct ceph_inode_info {
 	/* quotas */
 	u64 i_max_bytes, i_max_files;
 
+	/*
+	 * Subvolume ID this inode belongs to. CEPH_SUBVOLUME_ID_NONE (0)
+	 * means unknown/unset, matching the FUSE client convention.
+	 * Once set to a valid (non-zero) value, it should not change
+	 * during the inode's lifetime.
+	 */
+#define CEPH_SUBVOLUME_ID_NONE 0
+	u64 i_subvolume_id;
+
 	s32 i_dir_pin;
 
 	struct rb_root i_fragtree;
@@ -1069,6 +1078,7 @@ extern struct inode *ceph_get_inode(struct super_block *sb,
 extern struct inode *ceph_get_snapdir(struct inode *parent);
 extern int ceph_fill_file_size(struct inode *inode, int issued,
 			       u32 truncate_seq, u64 truncate_size, u64 size);
+extern void ceph_inode_set_subvolume(struct inode *inode, u64 subvolume_id);
 extern void ceph_fill_file_time(struct inode *inode, int issued,
 				u64 time_warp_seq, struct timespec64 *ctime,
 				struct timespec64 *mtime,
-- 
2.34.1


