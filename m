Return-Path: <linux-fsdevel+bounces-20953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0CD8FB442
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C54EB21F19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9BE1474BE;
	Tue,  4 Jun 2024 13:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7XaJz1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9605146D71
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508633; cv=none; b=XmVwpbDI0BX+uxfy9ZLLczqbzt0iWFnyxDyjVbcGXfQIgQZU2vqI8JRd81yJ7X04LvCgOo/taXZAk07VUNMYolldxY4RSKnG0TKVLFHces/G3kYGsmaSb1B5zAv6kMjgPenNtkbCD/VCl2pN+mxn4W+1xO9g8N0U9AK0yEFFm9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508633; c=relaxed/simple;
	bh=HKqQj1xqRoP8Rv142AITS7qLKkCNCKZjooPfiZgN/2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TyD7LEzmvJOHt4TsZdjnwwcoZiyqeI95gIHkx2RxRjgz4mIocFwI/YmMAPsIcA06+5yFNt+D0CVKWIXOMJoXUVmjIMy+f6qwfup+XBgrZDpm7K7tYAzpaFvSPNSQe4DUdkP6HrZycX4HKvVlKhC6GZ7GqYonCieCIhlZyJ+hgng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7XaJz1h; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f44b4404dfso49029845ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717508631; x=1718113431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8rRxSZ78eQkzLx/zheEMKx7Iya5NaIt0ajkWAKPjw3Q=;
        b=b7XaJz1h0Ttdd+5DvKqFgag5d1u4xleCTInqM2Yv1ZlUIWUJACXz4qyb4V+tYEp/ww
         Nr0eYuCJMAXdUD5gcr6mfeeY1WF26ykeO6FU8vxfiiWcqDm784WXbczvdC4+sVAvB67X
         XPfk8VKtjT5EXuhVRSN43O4LUHXjEiD7jwh8Xr75bLdWjs9gPhaTvkNYHIUIFLrj11wv
         0LNh8p50nPpf1fTAD62cJMb8/yjX36U2ru8uZFTk7wm+1fdCpSuPJKjW/g/njSpclxFn
         i5YxPO7fazcJFeyq8cmLqCb0rWCPN87+QZNe1a2xx1ANnbuEYbrCAusNSf7DcuBuz6ZA
         +ayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717508631; x=1718113431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8rRxSZ78eQkzLx/zheEMKx7Iya5NaIt0ajkWAKPjw3Q=;
        b=gfx7F2mHkqSN17FTqxc/HOmjVUKse9YjqwMuGnm0B25u93q0gXYUIDuIE4l5Qtw5fV
         fyoSVbaVVJ/COdCaMG9ICpseQXFF3zYSh3+Pl8tCq42aqhB73Gg6wQsPsizO5RATK6se
         hqeKx7iBmK9/E/1lCHDNrvdN7N/SaHlDom+ePALU8vqDDTD6T9GrDd17gc9AUgJwDihP
         29lsKXaGfH4fG8YtiamCCdtxghLWe0vUKIWVNrlr3J+qgbb5bNHegGbE8DvF5uaQf89H
         6ezKGn62nIP7bxqT/x2LPI7YDq/o+AVEQZbmANUNxFnJfJNlAKzZdMZ2tGXZ1b9fHtU4
         uRJg==
X-Gm-Message-State: AOJu0Yyy8UnXfh5fT1Npmvbs+mJIFunD2H81OUGILmYNlb7adp62nI3l
	Cy7jX78EMMnFmpNZ7Hhb2c8DKnBOOv7DTifZFBIvqFI0UY0abskd
X-Google-Smtp-Source: AGHT+IGQHgUna4Z6WjwUh5TahjQ7d+pIVntBpTtGqRdGzpyi/eL10TyJ4Py8slESLzljDMJS06uThw==
X-Received: by 2002:a17:902:6547:b0:1f3:35ff:ad25 with SMTP id d9443c01a7336-1f6370baef9mr136059975ad.63.1717508630942;
        Tue, 04 Jun 2024 06:43:50 -0700 (PDT)
Received: from localhost ([139.196.161.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63241c279sm83337365ad.295.2024.06.04.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 06:43:50 -0700 (PDT)
From: Jemmy <jemmywong512@gmail.com>
To: longman@redhat.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	jemmy512@icloud.com,
	Jemmy <jemmywong512@gmail.com>
Subject: [PATCH] Improving readability of copy_tree
Date: Tue,  4 Jun 2024 21:43:47 +0800
Message-Id: <20240604134347.9357-1-jemmywong512@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello everyone,

I'm new to Linux kernel development
and excited to make my first contribution.
While working with the copy_tree function,
I noticed some unclear variable names e.g., p, q, r.
I've updated them to be more descriptive,
aiming to make the code easier to understand.

Changes:

p       -> o_parent, old parent
q       -> n_mnt, new mount
r       -> o_mnt, old child
s       -> o_child, old child
parent  -> n_parent, new parent

Thanks for the opportunity to be part of this community!

BR,
Jemmy

Signed-off-by: Jemmy <jemmywong512@gmail.com>
---
 fs/namespace.c | 51 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..b1cf95ddfb87 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1969,7 +1969,7 @@ static bool mnt_ns_loop(struct dentry *dentry)
 struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
 					int flag)
 {
-	struct mount *res, *p, *q, *r, *parent;
+	struct mount *res, *o_parent, *o_child, *o_mnt, *n_parent, *n_mnt;
 
 	if (!(flag & CL_COPY_UNBINDABLE) && IS_MNT_UNBINDABLE(mnt))
 		return ERR_PTR(-EINVAL);
@@ -1977,47 +1977,46 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
 	if (!(flag & CL_COPY_MNT_NS_FILE) && is_mnt_ns_file(dentry))
 		return ERR_PTR(-EINVAL);
 
-	res = q = clone_mnt(mnt, dentry, flag);
-	if (IS_ERR(q))
-		return q;
+	res = n_mnt = clone_mnt(mnt, dentry, flag);
+	if (IS_ERR(n_mnt))
+		return n_mnt;
 
-	q->mnt_mountpoint = mnt->mnt_mountpoint;
+	n_mnt->mnt_mountpoint = mnt->mnt_mountpoint;
 
-	p = mnt;
-	list_for_each_entry(r, &mnt->mnt_mounts, mnt_child) {
-		struct mount *s;
-		if (!is_subdir(r->mnt_mountpoint, dentry))
+	o_parent = mnt;
+	list_for_each_entry(o_mnt, &mnt->mnt_mounts, mnt_child) {
+		if (!is_subdir(o_mnt->mnt_mountpoint, dentry))
 			continue;
 
-		for (s = r; s; s = next_mnt(s, r)) {
+		for (o_child = o_mnt; o_child; o_child = next_mnt(o_child, o_mnt)) {
 			if (!(flag & CL_COPY_UNBINDABLE) &&
-			    IS_MNT_UNBINDABLE(s)) {
-				if (s->mnt.mnt_flags & MNT_LOCKED) {
+			    IS_MNT_UNBINDABLE(o_child)) {
+				if (o_child->mnt.mnt_flags & MNT_LOCKED) {
 					/* Both unbindable and locked. */
-					q = ERR_PTR(-EPERM);
+					n_mnt = ERR_PTR(-EPERM);
 					goto out;
 				} else {
-					s = skip_mnt_tree(s);
+					o_child = skip_mnt_tree(o_child);
 					continue;
 				}
 			}
 			if (!(flag & CL_COPY_MNT_NS_FILE) &&
-			    is_mnt_ns_file(s->mnt.mnt_root)) {
-				s = skip_mnt_tree(s);
+			    is_mnt_ns_file(o_child->mnt.mnt_root)) {
+				o_child = skip_mnt_tree(o_child);
 				continue;
 			}
-			while (p != s->mnt_parent) {
-				p = p->mnt_parent;
-				q = q->mnt_parent;
+			while (o_parent != o_child->mnt_parent) {
+				o_parent = o_parent->mnt_parent;
+				n_mnt = n_mnt->mnt_parent;
 			}
-			p = s;
-			parent = q;
-			q = clone_mnt(p, p->mnt.mnt_root, flag);
-			if (IS_ERR(q))
+			o_parent = o_child;
+			n_parent = n_mnt;
+			n_mnt = clone_mnt(o_parent, o_parent->mnt.mnt_root, flag);
+			if (IS_ERR(n_mnt))
 				goto out;
 			lock_mount_hash();
-			list_add_tail(&q->mnt_list, &res->mnt_list);
-			attach_mnt(q, parent, p->mnt_mp, false);
+			list_add_tail(&n_mnt->mnt_list, &res->mnt_list);
+			attach_mnt(n_mnt, n_parent, o_parent->mnt_mp, false);
 			unlock_mount_hash();
 		}
 	}
@@ -2028,7 +2027,7 @@ struct mount *copy_tree(struct mount *mnt, struct dentry *dentry,
 		umount_tree(res, UMOUNT_SYNC);
 		unlock_mount_hash();
 	}
-	return q;
+	return n_mnt;
 }
 
 /* Caller should check returned pointer for errors */
-- 
2.34.1


