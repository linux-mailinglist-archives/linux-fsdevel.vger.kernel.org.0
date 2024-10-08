Return-Path: <linux-fsdevel+bounces-31355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EC1995345
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 17:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2D528252F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2024 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A71E0DD1;
	Tue,  8 Oct 2024 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hajbIByl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7301E0497;
	Tue,  8 Oct 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400889; cv=none; b=fEyONEW4+klrAbdNam/34gUVNC4zF1z9nqiBk3JrS/5zr2Qexboo8yhK7Zmqj4mvO5gFcMPPnlosBNEx/YFT+n5lnF/DHpPJOwIEPuayGo5KtaFvPGzEk9pfI17h2s6chqdre45equrXXKrfjq28CF3aykZKx0THRHzNwQawi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400889; c=relaxed/simple;
	bh=kp69Yv7ejdvXL4Ldvgcq2UBSJul9TjQhTDOv91togkk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0f5NOnd4WfWSYEyVwnbLjffQg8qHB2m5dIMoboZBHaxVsJiDUHk9ZZpCOn0nwDeGwhLEllRoHIVm26WUmLMCMaQtXmM9az2tx8WWo79Pk+6N6RbIrjgShNr/Ai+IUVls5Cs+ZCTLUOJ9snUz2uIPiHFADWjb7te1+Wb3r9Jqdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hajbIByl; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a99650da839so188170166b.2;
        Tue, 08 Oct 2024 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400886; x=1729005686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUaVCNUqnT5/rCf5Nw/LoDvlRy744S45/gp8iReu32s=;
        b=hajbIBylte4UT6EJT+7k1OgX/JKg5GcpZcLyDnz/OhguAvvVKyfr+UY3rT0IIA0hdV
         yAWD7RniYhIc0DZRhhV7SfnaXRiWrXJWJsW9smSS/8A2pS2+99y88HDqMoRs+nM4fzAw
         HQe/51VN7Jm/A2bngeZqtcxImHOG1GBn+6cM4GBAF2/2ustGSGvkE+atqczPy3QAeWQK
         CQQb6AKp50MnN5jX5duASfzzo6G7VzchDUcgLglsZBjjxZK2lg0VMM3h5lRGSLFQjWYE
         ZsUGSoUFsL3j66kMWrwWVPByhwStRrbaWzVC1QNNY+CJEhri13yW68kXRFROI+PrwuWU
         DUaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400886; x=1729005686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUaVCNUqnT5/rCf5Nw/LoDvlRy744S45/gp8iReu32s=;
        b=V0hL+AYHCGhGXtJv14BGhhb+JgxpegwYp9VJWfQkDx/UAkTD8lhrFAWbnb/wIrouAJ
         /yzEmYcFv8P60r+1+WTbeX09+T2dTPlEv6bEc7n0jPOm/dSvoV7uDR/E2Kk9T7On7Qj/
         jluzBO8nlAVF2KcHvdCtPadpeiqOOussrobbuglMCmurfHvRI1jS31z79ZCUKDY3Ljuo
         cC/NB7e+1fipQsiK4wd/ch8YexZ5VVGkJ9SEJy8LPtqQNX6mrUB0JW7n1RmG8mbV9Oej
         R/rvoObGw7acXwmxrJY/cNVLYtTISmAxqk65ybuQXFg8LN6k/ZPUeYWfm2E1OdWpPGXb
         bDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWAKV0Lt5bNkJL42ghNVl/7F8py2Szfda1TkVkeJ0C84Gm9756n3XTLAsBkP4YcdswTAyn3M4aBUtp2@vger.kernel.org, AJvYcCXtA55/hSUsHaPmnGO1M5lwg5Z6bQwEpucc5lCflMzGfZ+ZEixtyQAjIZW6JW7bs4Pad0q3fgFVrcp51N4O@vger.kernel.org
X-Gm-Message-State: AOJu0YzlLWvhvosb1ibI39oKxjhbi5GfrAEkDSHXyUEEbVDbTmxq0Xej
	T7iv24mAwvljN4DYnEQGLxyF9JFlBebi7HhtznYT+dVEyW19I9Rb
X-Google-Smtp-Source: AGHT+IGcsyyD4YdkuViiyU+yF0XQWcisTO+FxN5+4pNU7PZcWpUJe2plgPi+bKQ76/06v1djAbRnew==
X-Received: by 2002:a17:907:868e:b0:a99:462c:8728 with SMTP id a640c23a62f3a-a99462c8b7fmr1092425166b.3.1728400885441;
        Tue, 08 Oct 2024 08:21:25 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99384f8258sm487910466b.16.2024.10.08.08.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:21:24 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v3 3/3] fs: open_by_handle_at() support for decoding "explicit connectable" file handles
Date: Tue,  8 Oct 2024 17:21:18 +0200
Message-Id: <20241008152118.453724-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008152118.453724-1-amir73il@gmail.com>
References: <20241008152118.453724-1-amir73il@gmail.com>
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
 fs/fhandle.c             | 20 +++++++++++++++++++-
 include/linux/exportfs.h |  2 +-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 7b4c8945efcb..6a5458c3c6c9 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -246,7 +246,13 @@ static int vfs_dentry_acceptable(void *context, struct dentry *dentry)
 
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
@@ -349,6 +355,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
+
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
@@ -364,6 +371,17 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		goto out_handle;
 	}
 
+	/*
+	 * If handle was encoded with AT_HANDLE_CONNECTABLE, verify that we
+	 * are decoding an fd with connected path, which is accessible from
+	 * the mount fd path.
+	 */
+	if (f_handle.handle_type & FILEID_IS_CONNECTABLE) {
+		ctx.fh_flags |= EXPORT_FH_CONNECTABLE;
+		ctx.flags |= HANDLE_CHECK_SUBTREE;
+	}
+	if (f_handle.handle_type & FILEID_IS_DIR)
+		ctx.fh_flags |= EXPORT_FH_DIR_ONLY;
 	/* Filesystem code should not be exposed to user flags */
 	handle->handle_type &= ~FILEID_USER_FLAGS_MASK;
 	retval = do_handle_to_path(handle, path, &ctx);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 230b0e1d669d..a48d4c94ff74 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -171,7 +171,7 @@ struct fid {
 /* Flags supported in encoded handle_type that is exported to user */
 #define FILEID_IS_CONNECTABLE	0x10000
 #define FILEID_IS_DIR		0x40000
-#define FILEID_VALID_USER_FLAGS	(0)
+#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
 
 #define FILEID_USER_TYPE_IS_VALID(type) \
 	(!(FILEID_USER_FLAGS(type) & ~FILEID_VALID_USER_FLAGS))
-- 
2.34.1


