Return-Path: <linux-fsdevel+bounces-21083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28468FDE1D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 07:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ACDB286A27
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 05:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB161374FB;
	Thu,  6 Jun 2024 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsDqW2B7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B2D1754B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717651470; cv=none; b=EQ3mn7PS/msPzedfrtLBbAqIZAOgCgL7vYo18tnGqth2d4tu+XGLpJppDNxEQt9WkAfmr52MmURgDjjksk2AHNarwpaaXliEVymrzEBGzyTz1TemoQFfXEKX0n5Fjv7UFW245/ERE/s2JX28z97eGws8lVra0A1VzemC7zBdlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717651470; c=relaxed/simple;
	bh=pPBnlqVWi38Xct8OdLcRfZMr0TWIy49wpDlNsGTxwXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BCy/tBKNL5tJFpnXVGOPZStB32kRny7SOCaD44GuDCNR4KTp59IWGrEWUctKHotg0HvQ5MqQbUGiKCooAt3u3noSaARpUucW/bd8GbPTczOdcCsFNKbykC3WdlPvpvGDEb8D9qIbrlumTd/jGizEUWFbbp9CRPQngy96JtVk2uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsDqW2B7; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2c1a4192d55so450477a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 22:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717651468; x=1718256268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEUEFl1eF8bbOWBmBCCME2t3ev7m6QXNPymuHxfIalA=;
        b=GsDqW2B7ZjqV6fxsiFM12LnUyVwwBpm26Xe3vw+Pok6kto3HFf7m455jeTBLcps5uF
         OhJRUiXXaNfjghnded0gQxSOOiywo1FLiulKxz1r+XoSr2yE6feoPfZHLKs/EKeBNFif
         7Dxb6Ac9mgK2z84h991+rrIm2pbGB3I/qTUiF9kTyxazUmlwUOadpzuPTzT22n0i6KhV
         ToBu1CY93usFsPKzQxKsJgPK9CP4yfOuEnNC3Udv0U+YyQDmEJjlL2c3Ohj8/r0eVGxB
         gRQGrgDDN9gJT4E0X8I+y5wUKDuR+Qn5FUDPy/hX+YTpGflIziy7Iu8eBhoSB0OPK15I
         bq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717651468; x=1718256268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEUEFl1eF8bbOWBmBCCME2t3ev7m6QXNPymuHxfIalA=;
        b=uiXyW6aeoZTUFYkaSzBINg1Lch+a9Ifwh1slNO6NqyZ8eFAGsVAfH045n+0TaLzVka
         gSU9Je1jo0wMhQi0m7nMMLMaV04deAxkDsOIsDo15oQfcHteNopMO6/HulAruvkfEBG1
         pLYcvOjo0pGEEZQdlaMF+Nyj1zvHm7kfA3laC1D5rSrKN2bqBznLlzuql0Tyki9l2lom
         8ndFK7h92DMCyhAS12qBJcuD49QMsG9e19dMrdAujCVVb4OolFHJh3H7rUGstafJTe92
         pbQ1fhqr1LaEWY/CnMT3eugVsfLzIGwoSfVJQu2lXGOQ7lMEk2bSFw/mIMFm7oTPieum
         AK0g==
X-Gm-Message-State: AOJu0YyGP33xC5moH2LeYutG3OuYoJFadXf0YQNpK1ZkLkF9aqH/x3Tq
	3zqZbZan/amccA57uQHZ979cOb6uGKrKUC8ZOvdYHzNV7DWyhQl1IdmbjD6yB2yl6g==
X-Google-Smtp-Source: AGHT+IHy1hgDBrQfR2o3bzZozlnxBL+97o0vDsRJo9bSUCuUlxNeQddU7MKGufSjuLTPzr5c8fukfg==
X-Received: by 2002:a17:90b:1992:b0:2b6:22bd:f4b2 with SMTP id 98e67ed59e1d1-2c27daf658fmr4364469a91.4.1717651467744;
        Wed, 05 Jun 2024 22:24:27 -0700 (PDT)
Received: from localhost ([139.196.161.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c388fa8sm572106a91.41.2024.06.05.22.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 22:24:27 -0700 (PDT)
From: Jemmy <jemmywong512@gmail.com>
To: jemmywong512@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	jemmy512@icloud.com
Subject: [PATCH v2] Employ `copy mount tree from src to dst` concept in copy_tree
Date: Thu,  6 Jun 2024 13:23:51 +0800
Message-Id: <20240606052351.32223-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240604134347.9357-1-jemmywong512@gmail.com>
References: <20240604134347.9357-1-jemmywong512@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Variable names in copy_tree (e.g., p, q, r, s) are opaque;
renaming them to be more descriptive
would aim to make the code easier to understand.

V2 Changes:
mnt 	-> src_root (root of the tree to copy)
r 		-> src_child (direct child of the root being cloning)
p 		-> src_parent (parent of src_mnt)
s 		-> src_mnt (current mount being copying)
parent	-> dst_parent (parent of dst_child)
q 		-> dst_mnt (freshly cloned mount)

Signed-off-by: Jemmy <jemmywong512@gmail.com>
---
 fs/namespace.c | 59 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..38048b9b6c6c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1966,69 +1966,72 @@ static bool mnt_ns_loop(struct dentry *dentry)
 	return current->nsproxy->mnt_ns->seq >= mnt_ns->seq;
 }
 
-struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
+struct mount *copy_tree(struct mount *src_root, struct dentry *dentry,
 					int flag)
 {
-	struct mount *res, *p, *q, *r, *parent;
+	struct mount *res, *src_parent, *src_child, *src_mnt,
+		*dst_parent, *dst_mnt;
 
-	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(mnt))
+	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(src_root))
 		return ERR_PTR(-EINVAL);
 
 	if (!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry))
 		return ERR_PTR(-EINVAL);
 
-	res = q = clone_mnt(mnt, dentry, flag);
-	if (IS_ERR(q))
-		return q;
+	res = dst_mnt = clone_mnt(src_root, dentry, flag);
+	if (IS_ERR(dst_mnt))
+		return dst_mnt;
 
-	q->mnt_mountpoint = mnt->mnt_mountpoint;
+	src_parent = src_root;
+	dst_mnt->mnt_mountpoint = src_root->mnt_mountpoint;
 
-	p = mnt;
-	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
-		struct mount *s;
-		if (!is_subdir(r->mnt_mountpoint, dentry))
+	list_for_each_entry(src_child, &src_root->mnt_mounts, mnt_child) {
+		if (!is_subdir(src_child->mnt_mountpoint, dentry))
 			continue;
 
-		for (s = r; s; s = next_mnt(s, r)) {
+		for (src_mnt = src_child; src_mnt;
+			src_mnt = next_mnt(src_mnt, src_child)) {
 			if (!(flag & CL_COPY_UNBINDABLE) &&
-			    IS_MNT_UNBINDABLE(s)) {
-				if (s->mnt.mnt_flags & MNT_LOCKED) {
+				IS_MNT_UNBINDABLE(src_mnt)) {
+				if (src_mnt->mnt.mnt_flags & MNT_LOCKED) {
 					/* Both unbindable and locked. */
-					q = ERR_PTR(-EPERM);
+					dst_mnt = ERR_PTR(-EPERM);
 					goto out;
 				} else {
-					s = skip_mnt_tree(s);
+					src_mnt = skip_mnt_tree(src_mnt);
 					continue;
 				}
 			}
 			if (!(flag & CL_COPY_MNT_NS_FILE) &&
-			    is_mnt_ns_file(s->mnt.mnt_root)) {
-				s = skip_mnt_tree(s);
+				is_mnt_ns_file(src_mnt->mnt.mnt_root)) {
+				src_mnt = skip_mnt_tree(src_mnt);
 				continue;
 			}
-			while (p != s->mnt_parent) {
-				p = p->mnt_parent;
-				q = q->mnt_parent;
+			while (src_parent != src_mnt->mnt_parent) {
+				src_parent = src_parent->mnt_parent;
+				dst_mnt = dst_mnt->mnt_parent;
 			}
-			p = s;
-			parent = q;
-			q = clone_mnt(p, p->mnt.mnt_root, flag);
-			if (IS_ERR(q))
+
+			src_parent = src_mnt;
+			dst_parent = dst_mnt;
+			dst_mnt = clone_mnt(src_mnt, src_mnt->mnt.mnt_root, flag);
+			if (IS_ERR(dst_mnt))
 				goto out;
 			lock_mount_hash();
-			list_add_tail(&q->mnt_list, &res->mnt_list);
-			attach_mnt(q, parent, p->mnt_mp, false);
+			list_add_tail(&dst_mnt->mnt_list, &res->mnt_list);
+			attach_mnt(dst_mnt, dst_parent, src_parent->mnt_mp, false);
 			unlock_mount_hash();
 		}
 	}
 	return res;
+
 out:
 	if (res) {
 		lock_mount_hash();
 		umount_tree(res, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
-	return q;
+	return dst_mnt;
 }
 
 /* Caller should check returned pointer for errors */
-- 
2.34.1


