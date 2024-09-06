Return-Path: <linux-fsdevel+bounces-28850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B472696F6FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 16:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8F9B26C1E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD81D31A9;
	Fri,  6 Sep 2024 14:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hoeKX/32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427001D3189
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633314; cv=none; b=e8oKRrxlgMCm3a60KCfSAmJcw3JZzHjYg02etlqMnfOF8GkGJKbD4QN38le0+KahFGwrTuNwEDSqreIyT0mYXBv/mnsN7DRqO55qp9GwE2Yf7k8tpz09Lo+fHC+bPjFuF87VvmwXCSGy2Vyidl/5mgJL/L7Kv21iCbsN4ZrlDjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633314; c=relaxed/simple;
	bh=534DgAJ0D8qJtVjjpSo8v98NEf5nHaEOPP1nax1XHpw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e3aocwNrmi8tQoRXBw1Uws1ogjoOWNQrt+UzbK6cgstR8RpeV8N1ya/tD50VzHEDrdd+8dyb14+ZLiDWan873GUi8o8Sru09YbksGTsljO1Ne3Z7dmr3hblMVRQ4v1LNiF3fPZX2olCYcGk4Klg4Hh2SRcLsV6cFtRGq/hYXnBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=hoeKX/32; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 507B93F5B8
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Sep 2024 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1725633310;
	bh=RmZbkiefQJov/K5sBneAkkza7xrJwBfUJ2uOjsmm8Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=hoeKX/323CqPQQ2u/lrIILaw/IjqF0Pr7zDE2C+TkcoXvr6apnBLievrdHYFw6Uc+
	 or06a3xua/eBV1/Pn2WS7YSy7qsSn7Yn2sxuq4/9iScANvnczYDH+HXdVL4G3GUiM0
	 VlXfwEhjsv8jEMGESE7QneKwdXrpwy116EzkSc12aNWKPLooC7ieQoZl/hUMEI3HsV
	 J75my+V2XGuZKHDgg+orG34XUO6FQv0DM1sLlvhjKQci70iCv4y7MpwHhNDCSmncxa
	 zU1Gl31bMWj2GLPXe8wyH0o9W2JPoV9LnToZCHuUJoqcchJHGHmnL5KBcYLxlu0PgI
	 /iG6N5GQJovWg==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5343a54e108so2090113e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2024 07:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633309; x=1726238109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmZbkiefQJov/K5sBneAkkza7xrJwBfUJ2uOjsmm8Fs=;
        b=aLaxNUsSdAnS3l7utB88GhdrUx0NEFEeAD3v0GuI0mr0dJxMHHnJ+SnZ7BLcJnddj+
         mIubagTQka7J5BZgsZ+ZWd6vTYdPvvB71T2MO9hM4x/vLpuh5mmptdwJXBG5acdDAdYr
         WBu3rtf7j3Xp3VkkBHasFJp+s1ouneq3Oucxq5y9C2lmkj6fN7sXGGW9OziAD5QLmDqL
         QeZXh9lOw8IPA4lzy3ThCUx0gUnDD7c5GmyPhIce1Xoi8aNNW828BXAjPuV6rqPqnKQo
         ZZPKV3sCSGW1gAqkRmYczYmvXxCxS/cwYulvjWRS1E5UjGda4kG8ePZ2UFWkb+ooYYB4
         YDyw==
X-Forwarded-Encrypted: i=1; AJvYcCUzod/NE87eeoaKTnkjWycBx8u0oMjTxFD2NXP3yJg4I3BfRhL76LbJNMv1EkBi5kktdcxH/NpnEbmPszFp@vger.kernel.org
X-Gm-Message-State: AOJu0YwgBu5yxVk8EHH4QHD9aCCURrhaoj7sr8ouBE8N3D9JCO8TzIpl
	GryizBn/VkV2uLBMFCAtJe7PLh6+4BDanVqXA8bmGllMPRgsQfTfVwXbeOmt80gAdz0N0XotZXu
	5RcjZ//Ne0RvtE0Q9XDN0HH2tMeNacKdsHcDRgrJlA0HRL1YIy7PtgJ7Xlae1QkWol4n105IZJs
	Tx9bA=
X-Received: by 2002:a05:6512:3d09:b0:530:b871:eb9a with SMTP id 2adb3069b0e04-536588067b5mr2251701e87.47.1725633308741;
        Fri, 06 Sep 2024 07:35:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83mvznC7hs+nx8gK/BrkaCD9AoiB5al3t+MVykimwEDs6U9Y3xZBKl0YrkESBcyajurROkg==
X-Received: by 2002:a05:6512:3d09:b0:530:b871:eb9a with SMTP id 2adb3069b0e04-536588067b5mr2251678e87.47.1725633308238;
        Fri, 06 Sep 2024 07:35:08 -0700 (PDT)
Received: from amikhalitsyn.. ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236cee0sm281787466b.101.2024.09.06.07.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:35:07 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: mszeredi@redhat.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] fs/fuse: convert to use invalid_mnt_idmap
Date: Fri,  6 Sep 2024 16:34:53 +0200
Message-Id: <20240906143453.179506-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240906143453.179506-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should convert fs/fuse code to use a newly introduced
invalid_mnt_idmap instead of passing a NULL as idmap pointer.

Suggested-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/dev.c    | 47 +++++++++++++++++++++++------------------------
 fs/fuse/dir.c    |  6 +++---
 fs/fuse/fuse_i.h |  2 +-
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 04a6490a587c..e42b2f38d35f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -114,7 +114,11 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 {
 	struct fuse_conn *fc = fm->fc;
 	struct fuse_req *req;
+	bool no_idmap = (fm->sb->s_iflags & SB_I_NOIDMAP);
+	kuid_t fsuid;
+	kgid_t fsgid;
 	int err;
+
 	atomic_inc(&fc->num_waiting);
 
 	if (fuse_block_alloc(fc, for_background)) {
@@ -148,29 +152,24 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	if (for_background)
 		__set_bit(FR_BACKGROUND, &req->flags);
 
-	if ((fm->sb->s_iflags & SB_I_NOIDMAP) || idmap) {
-		kuid_t idmapped_fsuid;
-		kgid_t idmapped_fsgid;
+	/*
+	 * Keep the old behavior when idmappings support was not
+	 * declared by a FUSE server.
+	 *
+	 * For those FUSE servers who support idmapped mounts,
+	 * we send UID/GID only along with "inode creation"
+	 * fuse requests, otherwise idmap == &invalid_mnt_idmap and
+	 * req->in.h.{u,g}id will be equal to FUSE_INVALID_UIDGID.
+	 */
+	fsuid = no_idmap ? current_fsuid() : mapped_fsuid(idmap, fc->user_ns);
+	fsgid = no_idmap ? current_fsgid() : mapped_fsgid(idmap, fc->user_ns);
+	req->in.h.uid = from_kuid(fc->user_ns, fsuid);
+	req->in.h.gid = from_kgid(fc->user_ns, fsgid);
 
-		/*
-		 * Note, that when
-		 * (fm->sb->s_iflags & SB_I_NOIDMAP) is true, then
-		 * (idmap == &nop_mnt_idmap) is always true and therefore,
-		 * mapped_fsuid(idmap, fc->user_ns) == current_fsuid().
-		 */
-		idmapped_fsuid = idmap ? mapped_fsuid(idmap, fc->user_ns) : current_fsuid();
-		idmapped_fsgid = idmap ? mapped_fsgid(idmap, fc->user_ns) : current_fsgid();
-		req->in.h.uid = from_kuid(fc->user_ns, idmapped_fsuid);
-		req->in.h.gid = from_kgid(fc->user_ns, idmapped_fsgid);
-
-		if (unlikely(req->in.h.uid == ((uid_t)-1) ||
-			     req->in.h.gid == ((gid_t)-1))) {
-			fuse_put_request(req);
-			return ERR_PTR(-EOVERFLOW);
-		}
-	} else {
-		req->in.h.uid = FUSE_INVALID_UIDGID;
-		req->in.h.gid = FUSE_INVALID_UIDGID;
+	if (no_idmap && unlikely(req->in.h.uid == ((uid_t)-1) ||
+				 req->in.h.gid == ((gid_t)-1))) {
+		fuse_put_request(req);
+		return ERR_PTR(-EOVERFLOW);
 	}
 
 	return req;
@@ -619,7 +618,7 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 		__set_bit(FR_BACKGROUND, &req->flags);
 	} else {
 		WARN_ON(args->nocreds);
-		req = fuse_get_req(NULL, fm, true);
+		req = fuse_get_req(&invalid_mnt_idmap, fm, true);
 		if (IS_ERR(req))
 			return PTR_ERR(req);
 	}
@@ -641,7 +640,7 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fm->fc->iq;
 
-	req = fuse_get_req(NULL, fm, false);
+	req = fuse_get_req(&invalid_mnt_idmap, fm, false);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 491e112819be..54104dd48af7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1093,7 +1093,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 		if (fc->no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
-		err = fuse_rename_common((flags & RENAME_WHITEOUT) ? idmap : NULL,
+		err = fuse_rename_common((flags & RENAME_WHITEOUT) ? idmap : &invalid_mnt_idmap,
 					 olddir, oldent, newdir, newent, flags,
 					 FUSE_RENAME2,
 					 sizeof(struct fuse_rename2_in));
@@ -1102,7 +1102,7 @@ static int fuse_rename2(struct mnt_idmap *idmap, struct inode *olddir,
 			err = -EINVAL;
 		}
 	} else {
-		err = fuse_rename_common(NULL, olddir, oldent, newdir, newent, 0,
+		err = fuse_rename_common(&invalid_mnt_idmap, olddir, oldent, newdir, newent, 0,
 					 FUSE_RENAME,
 					 sizeof(struct fuse_rename_in));
 	}
@@ -1127,7 +1127,7 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
-	err = create_new_entry(NULL, fm, &args, newdir, newent, inode->i_mode);
+	err = create_new_entry(&invalid_mnt_idmap, fm, &args, newdir, newent, inode->i_mode);
 	if (!err)
 		fuse_update_ctime_in_cache(inode);
 	else if (err == -EINTR)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index b2c7834f21b5..e6cc3d552b13 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1153,7 +1153,7 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 
 static inline ssize_t fuse_simple_request(struct fuse_mount *fm, struct fuse_args *args)
 {
-	return __fuse_simple_request(NULL, fm, args);
+	return __fuse_simple_request(&invalid_mnt_idmap, fm, args);
 }
 
 static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
-- 
2.34.1


