Return-Path: <linux-fsdevel+bounces-31676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D97999F8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7786286F09
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2957620CCC5;
	Fri, 11 Oct 2024 09:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUizK+Q9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C081FC8;
	Fri, 11 Oct 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637234; cv=none; b=UMovBfJ9mMubUqQ6pZLknFhjNdlVfFPpVb/uvV35iyX+jgjdfDYLkqxCDAtAfGek03MhhPedt5DAjOMdG1RstyBy0H6ka2/050+P46m4sVwvFFGryPSuEe/Ourt2hpBfot86WiqqmHXehbeNamPvsUNqMTaEVi2uNG9PwXUIojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637234; c=relaxed/simple;
	bh=QfZzpLb04UiSzQ8sv2BVc+rITqtQFDZ0Rag/FVeGwiM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tsbZCcN4lPUG3q8UT5Wnaqtd7qG4a+X9Ky2oOWn0Z0p7qjs/Lqb5NAwdJsyh9EOjEKTzVPAoghQfYYpp78J2LNzNElaGSbfxnF80Psp2c9ltBzFAO6cSe3/g4H1pcV3iUNLrrUT392jtQNkDiKvEbeum2gLTzOkkeosDgpeFQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUizK+Q9; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398b589032so3094075e87.1;
        Fri, 11 Oct 2024 02:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728637231; x=1729242031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPox3TI38Lne0sRREj+Vbmklv8qC3yu1G4Yws0fG520=;
        b=TUizK+Q9O3YEc4efTVa5FCzfSMwFnFgrQIkx5N7lJRZ2oWhF+4+DSvjwGqtfhuzQPa
         QWfn6i2U9wW2384BNOR1iZK5xM43QkP+hhPc0ASpHIKCR4nFt2qms+UFc4jMSW34uEXw
         AwvIWQzoW2WpdzjGUk6DDmmDvw/V4Tii89LIjgH2rUwImDrLivioFhGeflheAeZpyhI7
         tjvy0DnXLxtvVJ3nFKaJTct7NvSoOhZwomRMVjLMHL/gDFttvRSeu+annlHf0F96QXUQ
         RGbcoojYxHnQg9yIRJSB4ZNbl1GTJuMjSvN7xuvoHeDnuKxm/GDPI2ChYaMC+HxKKgxj
         WwiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637231; x=1729242031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPox3TI38Lne0sRREj+Vbmklv8qC3yu1G4Yws0fG520=;
        b=i2uwBE/Cw/1uDiGl5pmeRK3avukA3nOsEbDP3YAnXoJWcQoxcEsq1HtBER/+LU383r
         GTHaOQRJCVWzlRV6aNQIDeKXpICK1lhlqyBXNKN9JCagDuR/JwOWRU82kjHxP80eYhwB
         T4xaoBDQvaTHOdDG0QfBVNyikjbFUSCg/KIA2SyJj8dPLzNWDKmP2ux6jhpuJJjsnOtl
         DFi3l8zmmy9GRHSDNun2KS9qn9Y8xtbvRibBi8wRbayG+hCzw9QU2q7/vWXVsEcCqzrM
         dsuESEWTWogXt/LD7kiis9qqJvLIOuMie1UjhQQfxnTFwTnKpsU4/BVxhxzWknVe0jGK
         fuVg==
X-Forwarded-Encrypted: i=1; AJvYcCVL2OKz4feM/QomkwTd++UR7I/wwN4n+1XqEDe6+Mu/ajQ5IC8aECEE6YRuqZhGwAX4tBfNo7kGADPx@vger.kernel.org, AJvYcCWFNEsTfFZNRYRK06+h4zaqe7t5yjDhkD61xuNB9UoEuAWR8E/H+9fJ0t+R4UG1DmvCRWBjqs0kEMZPZve1@vger.kernel.org
X-Gm-Message-State: AOJu0YxUv9E1Z+IFgKYxSiiiacVclMvp/IuQYqoNV1azFitI7ycFLnqC
	FbVuNxgAyTMaAoOsCnqlQXmULyx+lcBTqOK+l3thI1vuXMLwMX7t
X-Google-Smtp-Source: AGHT+IEm4lBSNsrNMA3CbR0tQ3L9or2EawGWgIb688lSzSFUfMabv/r8mpBBLEKWPInwlWz3JVU0Bw==
X-Received: by 2002:a05:6512:15a0:b0:538:9e36:7b6a with SMTP id 2adb3069b0e04-539da4e29e9mr1227183e87.32.1728637230386;
        Fri, 11 Oct 2024 02:00:30 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec5697sm189606066b.22.2024.10.11.02.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 02:00:29 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v4 3/3] fs: open_by_handle_at() support for decoding "explicit connectable" file handles
Date: Fri, 11 Oct 2024 11:00:23 +0200
Message-Id: <20241011090023.655623-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011090023.655623-1-amir73il@gmail.com>
References: <20241011090023.655623-1-amir73il@gmail.com>
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
index 8339a1041025..75cfd190cd69 100644
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
@@ -350,6 +356,7 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 		retval = -EINVAL;
 		goto out_path;
 	}
+
 	handle = kmalloc(struct_size(handle, f_handle, f_handle.handle_bytes),
 			 GFP_KERNEL);
 	if (!handle) {
@@ -365,6 +372,17 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
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
index 4ee42b2cf4ab..fcab6ab1d38a 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -171,7 +171,7 @@ struct fid {
 /* Flags supported in encoded handle_type that is exported to user */
 #define FILEID_IS_CONNECTABLE	0x10000
 #define FILEID_IS_DIR		0x20000
-#define FILEID_VALID_USER_FLAGS	(0)
+#define FILEID_VALID_USER_FLAGS	(FILEID_IS_CONNECTABLE | FILEID_IS_DIR)
 
 /**
  * struct export_operations - for nfsd to communicate with file systems
-- 
2.34.1


