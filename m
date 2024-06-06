Return-Path: <linux-fsdevel+bounces-21098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7A8FE2C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 11:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0959B29ECB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 09:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA848158DA3;
	Thu,  6 Jun 2024 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERE3CvAr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96FC158A04
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Jun 2024 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664581; cv=none; b=qbYGFxFF/MxQxpw1qWrDiO8lxez/TSHlX/zNo2Q+Z4UVO+Hz6RX2n4jrDm7WCXD03FBtpwzxuUSUn7jRptslS6T7rWKqk85TghqjvZnv0PEcXdv9p79jmWpqkg7+BbtO8c8/d802cbP3ODxMZ5n5VSzSbnrk0G02kJ12GZ5M35E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664581; c=relaxed/simple;
	bh=dQ6qrGFQylOjMkDa+4W7SivdQjzeJG4LiAkR6KbcvQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eg1lK5ZAFIGC2o/6lPxUwxbP//FtYmebZja3kpO/r79rA7RaWUxucC3wK4cQwlnOIlilBlPTGe9NrqJvkpqVOJAWNbGTRlc9tFw+8z9qOs7m4ceCXwyxdgngbkkYzo2jydDzzsVnne9mg77xF488vAuLVOE7GwqQsHJGzqcSb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERE3CvAr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f32a3b9491so5672825ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Jun 2024 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717664579; x=1718269379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQ6hjiBYWd826p6EVFtzxCpKH2q4xsNw2rMUVVsE56o=;
        b=ERE3CvAr2VAwi15EBZsRwVSy0FV0JZfBQyajetfJhZhSnVce3ho4MSJSdeb4w+0Yq7
         JKO7FaQF5qTXIw27SwtnXTb8DqFJqTSsmy4ZlemAtkwAdWCgc8Kx9wHyT7rxEdbTp+f7
         cGY9w3QgEzlfCejmbU+aoxvZRCGXIScZsqY5duAXwSd84j+0oo31v6mj0j6yFJAMhS6t
         XL120Ird7ZS57ZLJpfn0/vUphca+KcwfxKgylHZdns8rIO4MlSDUba0y8sVjvkRZapg4
         QXbQk4DZ93WGRtgo+SHqLxsuVYoJ5Zbv4w5pTWe1juAmoc2If9Z7G/Wy0gYCVPepnixZ
         OS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664579; x=1718269379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FQ6hjiBYWd826p6EVFtzxCpKH2q4xsNw2rMUVVsE56o=;
        b=CS2inmCtwbf8vbHKq9ZaaLIjiGWw9W7q4xRi/gpWfUvSln9m6pmQbNZyF8Lmog/tFb
         NbXJM4m40V/N1HDEYnegKfcKJhW3mtqYXCVJ7slCOnGMTSep21nwFSz2ryt2KpDJBKs8
         BfgWWdA2tyjzxn2mj2MTxolmW2TeUF+oT61TnjhMdJy3xYNB8LRDHwjmbrXtcCCp0Go9
         lC7H676h0CeB7ghLzGadCBhZnmw3agH47l30CovyHDlpZEmgGNr9dGLfXVwq8gNiCkKR
         VOkjzC10/cH7w3mJsc5hZMnL/uawi4/f4BOmmrjiKK6rXH/wXb9IMhz5bWrRNuRajobE
         0rvg==
X-Forwarded-Encrypted: i=1; AJvYcCXSDR8vY0azdTXX3i0GR9vgPQ0CNLiwHlxaFN3q+/4JSBRfUDs2+XZLGLSiOLfJeqRKiqvLOyI0qdqMLAwdMaW9aYo0IsJZsSRrudE/nw==
X-Gm-Message-State: AOJu0Yzw4rEfnaElSRHM6FgLZLMt69R0P5PjF6SzW4jRuJUHOMOHsLDS
	Repa0k3Y5X9D1njD80j5PhoOVDJcNr5i8TawdgrEivRCB9PiOyuL
X-Google-Smtp-Source: AGHT+IEF8HberASoXN//tmKrmcSaW43/MrtV393rmNaltcZylnErE5wTjUDpu0xUWkY16LxVgnYWsw==
X-Received: by 2002:a17:903:4053:b0:1f6:3720:ce56 with SMTP id d9443c01a7336-1f6a5a12094mr39551055ad.27.1717664579092;
        Thu, 06 Jun 2024 02:02:59 -0700 (PDT)
Received: from localhost ([139.196.161.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c240sm9742315ad.89.2024.06.06.02.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 02:02:58 -0700 (PDT)
From: Jemmy <jemmywong512@gmail.com>
To: jemmywong512@gmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	jemmy512@icloud.com,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3] Improve readability of copy_tree
Date: Thu,  6 Jun 2024 17:02:54 +0800
Message-Id: <20240606090254.36274-1-jemmywong512@gmail.com>
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
r       -> src_child (direct child of the root being cloning)
p       -> src_parent (parent of src_mnt)
s       -> src_mnt (current mount being copying)
parent  -> dst_parent (parent of dst_child)
q       -> dst_mnt (freshly cloned mount)

Signed-off-by: Jemmy <jemmywong512@gmail.com>
---
 fs/namespace.c | 59 ++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5a51315c6678..0dd43633607b 100644
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


