Return-Path: <linux-fsdevel+bounces-29831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A54E97E788
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 10:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4531C21223
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D0B1940AB;
	Mon, 23 Sep 2024 08:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1d+rmBW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD9B5F873;
	Mon, 23 Sep 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727080119; cv=none; b=Qm2GXaGLlyJlrBS6wE4dupri2unGH9ruqkmp3EYf03aCfOAWr7+XMSgFm/gsa+pVCOUPqqoF567U50j8Qp1b64EPJikahTu1uJVUNBYGgPBnmoEpzlWpPOd6WCiJWpl3op7POMkoyttLEdlBacB06QG1YbqUb2B9U0jC4aoVBc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727080119; c=relaxed/simple;
	bh=/Sa7lQaX9/x3svQU8zx0hWvczjR7gWzw8ZBmgZHFzaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U2C3wbMGM3U25Yg+qGF57J6Y0Y5kg+7mS4TzEGORP9fXUFWdvcPz0byCdcpAxw73q4IKXRs0g+GV1/CkbOq0tMmVaHutC+L2zum5+wtRFtjKhOvRauC0iiakrgUD8XJYsAc2skXPdhxktWVGF93PwUPEQ9DeVuiEmqEKv2NlMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1d+rmBW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8d60e23b33so543599966b.0;
        Mon, 23 Sep 2024 01:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727080116; x=1727684916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJPMWZh8qR0z0ZmaykiUTlKaa8/iEazwFZpeOOK2vlA=;
        b=j1d+rmBW3UG/jXYWDkQUcQyVzPHcvhiiU/GIBO9nfM3lnvwGgIvAong8kt0gy4RMO7
         mJALv0/dmc/s9XjxdMqd2YSxFbrjn6WE7ZBdgugEUVDsaBjex9TkLpxlqvFMf9SRIzxz
         xKTl/+g4vqDC7gW0UN8A7E8iM5mTL92K+cBVKfBSnE+fEaLrcckT3UgwHd83jyy3DY0Y
         5HbrMfrdrGGLvwwo4RtIncDrRhd/tvFwafxxfiBz8WgDeDhcDD3atOlmukdAfHtjM0oH
         1CMN/SPnChArisK/M/T93uvQamc/8agGRwwsZ5UzTd88H7wu9T/qxB2M9F2iKhUfgULV
         v+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727080116; x=1727684916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJPMWZh8qR0z0ZmaykiUTlKaa8/iEazwFZpeOOK2vlA=;
        b=Mzt1Xu2hWLKz7jzuc7Zi6P0kAu+LZrYZgSBNY3nKUcGG4bJFZVVrKozj8iK9qg+OZc
         iF6b2b+KIsVyIdyKUKjrfCV0dj2yJTct6Ab9WR1hdKZRRem4tMnW37I1O+RI8jV4Hem4
         0AV4IX4LO+P5nRL6PQ/KA4Ag3zMhrA5+veHog/rLidHLrKor1ro2TixrJ/MsWW8//037
         +pFX6Fik5S1A+nDTWGa0zq+zgWpjOM2LKjW2XRFXJp5B/u/RcpYAoyxNWoz5sspkKb5j
         3a316BNx1A681XvnyOezdUEqfhRPv7Wz3XES/wnnkFFm8+BEIGEzY+O4WOcCKl5NAFO6
         wfQg==
X-Forwarded-Encrypted: i=1; AJvYcCVjH8Vtt1jJH0uJybGwPptBDl1eloaZoCxtYB0rEoqQFTOjgquFp08j7bsSkkGpLzvfRx5/1/GYs/nX39hA@vger.kernel.org, AJvYcCWRg303sWR+/aQ4RSKjgt1jdGcr4UJDWWHk2FW2zPhsOkL0hkXFmm0/HSrQBKipBURPCR46MbavNN5S@vger.kernel.org
X-Gm-Message-State: AOJu0YwoUd45SX0HL8WRDg9KUhh7hzJV8aIsxnOLRV9VaJAdYgix5644
	STdO6FkLOdHuLNjXdfBppnDRbLm4MH1gmJZj+sv5n1WIZdXmO6BF
X-Google-Smtp-Source: AGHT+IFn3I9YYRP2xW2azjbkHDromLeH1J87KFzkMTlXTajuQbBe19JVLq0GPg/T+aMDgZX/cp0qQw==
X-Received: by 2002:a17:907:d85b:b0:a8d:2d2e:90e6 with SMTP id a640c23a62f3a-a90d5839345mr946358166b.60.1727080115709;
        Mon, 23 Sep 2024 01:28:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90cbc7122esm512948866b.124.2024.09.23.01.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 01:28:35 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] fs: open_by_handle_at() support for decoding "explicit connectable" file handles
Date: Mon, 23 Sep 2024 10:28:29 +0200
Message-Id: <20240923082829.1910210-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240923082829.1910210-1-amir73il@gmail.com>
References: <20240923082829.1910210-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach open_by_handle_at(2) about the type format of "explicit connectable"
file handles that were created using the AT_HANDLE_CONNECTABLE flag to
name_to_handle_at(2).

When decoding an "explicit connectable" file handles, name_to_handle_at(2)
should fail if it cannot open a "connected" fd with known path, which is
accessible (to capable user) from mount fd path.

Note that this does not check if the path is accessible to the calling
user, just that it is accessible wrt the mount namesapce, so if there
is no "connected" alias, or if parts of the path are hidden in the
mount namespace, open_by_handle_at(2) will return -ESTALE.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 6c87f1764235..68e59141f67b 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -247,7 +247,13 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 
 	if (!(ctx->flags & HANDLE_CHECK_SUBTREE) || d == root)
 		retval = 1;
-	WARN_ON_ONCE(d != root && d != root->d_sb->s_root);
+	/*
+	 * exportfs_decode_fh_raw() does not call acceptable() callback with
+	 * a disconnected directory dentry, so we should have reached either
+	 * mount fd directory or sb root.
+	 */
+	if (ctx->fh_flags & EXPORT_FH_DIR_ONLY)
+		WARN_ON_ONCE(d != root && d != root->d_sb->s_root);
 	dput(d);
 	return retval;
 }
@@ -346,10 +352,19 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
-	if (f_handle.handle_flags) {
+	if (f_handle.handle_flags & ~EXPORT_FH_USER_FLAGS) {
 		retval = -EINVAL;
 		goto out_path;
 	}
+	/*
+	 * If handle was encoded with AT_HANDLE_CONNECTABLE, verify that we
+	 * are decoding an fd with connected path, which is accessible from
+	 * the mount fd path.
+	 */
+	ctx.fh_flags |= f_handle.handle_flags;
+	if (ctx.fh_flags & EXPORT_FH_CONNECTABLE)
+		ctx.flags |= HANDLE_CHECK_SUBTREE;
+
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
-- 
2.34.1


