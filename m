Return-Path: <linux-fsdevel+bounces-21126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 604A58FF3E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 19:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10851F28322
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA01C1991B4;
	Thu,  6 Jun 2024 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4kOC41u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E1338DC7
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717695560; cv=none; b=Q6t/6WnmA4IEwVYpTaCN+FRWbu7n+7TUmWqwNwvhxq7xosSj1iaMT8ucB73bmTn9DRIloQTOTGB1gOGautA6KZHpGe+zHVExZ76xyyJ4WI6z+xA+/USJmINCWc57gt3R+tG3wnGmC1W+fZmj4hCvNaf4Qk6QQCaPOvIyFmfXPo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717695560; c=relaxed/simple;
	bh=6ZLOLgUsahNUert6UfZ0xAtyOIP7jxomahEyAKLhSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lLv7XeqAeJfXzZuD1+9adDDpeIfnppHw48+MqAJTT6t0Ru3V/IRpgqE/ErHpln5o/nt9fKyz604UsVZPu3OGJpGLr+49Neg6yAqv5et8hafdrYmfKj72+FuyS+PNsf/5/hsutHYmVlYlSW05SrwoP9bY5oXfwu26/im3FXPNOxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4kOC41u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6818e31e5baso1033955a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 10:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717695558; x=1718300358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLjPNbmQ3T/KGN7caalo0yUHC7q2vkk8jW/C1DYK+Rs=;
        b=X4kOC41uhxaQzvUfAiiZuNU5kSocPJCO8IrP2Hs18zT9Sz9Dt5+HEG2mpoVnvQmMU9
         sZxpakvJISDGa+rVr3g8ymNNGi3uuZ6D0VGgKKoe/WwC1ZSYAUv9y9I8dZlalYzNjyjP
         Mce8kde0C4dLf4xyrdHwtovEBJbwkeLaPb59QARo/bCZ7IeSrKdZwnMZlBR8Rejz12Eo
         tUqw8sb9WNd37gYAQl236aNEd8XgBCAo8HjRY3z1rKKV2wqJVfNM8Fnx9d1fwYRnn1ST
         CS4RL+OUhDhCQmCZIJETxXx+IXcbrnW04o9gHnEKqoHuH2NUw/w1v2fS8/ThRyA1uijg
         YmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717695558; x=1718300358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLjPNbmQ3T/KGN7caalo0yUHC7q2vkk8jW/C1DYK+Rs=;
        b=fd2/0Pyk0rfBs0XuNhBtaFvmfi9Zyp4Dtp2uPMjMkfMdJN/KYzl925w2H2OZizCFxn
         u+evjekMkhTYyLa33akLHodzEU+ca04lH8SHZBqOwjClSb916Fs4EWPKl5s2LsX5Ex1/
         03NOfcGG3TW9x3SvnVgFbKymbp5V5OJwKa3u9+a4m/b8EbikjSf9H6vgawzl1ZB6Fsjs
         OXoNsOB79nkxy5eGqw1PD/90BnK8iYwTzdi2WwKZYWWnfr6ierZOzsps5yTz1KoZM4dN
         hb4qUs22sYcHKrkScpVCPdZpZ6Gn5rIvhjp4Pm69Ej4LfaVCUi+s5e1BXpe34mprbsq8
         38eg==
X-Forwarded-Encrypted: i=1; AJvYcCUVDtquOUWfxX1lSNyvjWptaQzxrRbSg/LbWKkW6d9xZ4gjFbCr0VawW3uDOIFxprw82c+UZvWrWTECV5/g3duyIMhlz6ffM2AZxipwxA==
X-Gm-Message-State: AOJu0YzuFzsMVGIP1U2L8I6fGXr6AXB8x0DW72Y6PRXbM20GZ3uxiH48
	aHVT+WJBUoVPrejklI8xCBq2PKBLJagvwgQyoaaw6Kh7WQH4/Zlx
X-Google-Smtp-Source: AGHT+IHIR0j3uywtIcfxrlyMhGHLSuH4OIb0wvLCtuf1B/y8jDwY+V5RJ/mG51U8e3ic3blWPR927w==
X-Received: by 2002:a17:90a:4591:b0:2c2:792d:8805 with SMTP id 98e67ed59e1d1-2c2bcafe2b3mr207685a91.27.1717695557974;
        Thu, 06 Jun 2024 10:39:17 -0700 (PDT)
Received: from localhost ([139.196.161.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2806d2936sm3841641a91.53.2024.06.06.10.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 10:39:17 -0700 (PDT)
From: Jemmy <jemmywong512@gmail.com>
To: jemmywong512@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	jemmy512@icloud.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v4] Improve readability of copy_tree
Date: Fri,  7 Jun 2024 01:39:12 +0800
Message-Id: <20240606173912.99442-1-jemmywong512@gmail.com>
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

by employing `copy mount tree from src to dst` concept.
This involves renaming the opaque variables (e.g., p, q, r, s)
to be more descriptive, aiming to make the code easier to understand.

Changes:
mnt     -> src_root (root of the tree to copy)
r       -> src_root_child (direct child of the root being cloning)
p       -> src_parent (parent of src_mnt)
s       -> src_mnt (current mount being copying)
parent  -> dst_parent (parent of dst_child)
q       -> dst_mnt (freshly cloned mount)

Signed-off-by: Jemmy <jemmywong512@gmail.com>
---
 fs/namespace.c | 59 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..b0202e37515e 100644
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
+	struct mount *res, *src_parent, *src_root_child, *src_mnt,
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
+	list_for_each_entry(src_root_child, &src_root->mnt_mounts, mnt_child) {
+		if (!is_subdir(src_root_child->mnt_mountpoint, dentry))
 			continue;
 
-		for (s = r; s; s = next_mnt(s, r)) {
+		for (src_mnt = src_root_child; src_mnt;
+		    src_mnt = next_mnt(src_mnt, src_root_child)) {
 			if (!(flag & CL_COPY_UNBINDABLE) &&
-			    IS_MNT_UNBINDABLE(s)) {
-				if (s->mnt.mnt_flags & MNT_LOCKED) {
+			    IS_MNT_UNBINDABLE(src_mnt)) {
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
+			    is_mnt_ns_file(src_mnt->mnt.mnt_root)) {
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


