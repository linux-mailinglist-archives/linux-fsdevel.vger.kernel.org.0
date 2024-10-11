Return-Path: <linux-fsdevel+bounces-31675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C90999F89
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 11:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0A286E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 09:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9F620C499;
	Fri, 11 Oct 2024 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZHFh+RQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B216620B1E6;
	Fri, 11 Oct 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728637233; cv=none; b=OBxqW9FBDve7QBzEr57Jl1VUZc3woNBmoWAxSXF5LTHZr9RJag0OBAkK7xUlNth3z36vxlNIqSWSuCzLRoetyd25aeVuok/upqoMs60KEIuXRxmZ6YpUn9rlzbcYffEQ5yEOTAIT/4miAuRQQnXjTFGj4MBcO6O7hk4AntKnDSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728637233; c=relaxed/simple;
	bh=Nax2AtUdXVVk99rKmk0WjhWoAiQmsaXVkwNsUcPGNxk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BsDhmTZKnroC0EbzdhQaz7ymqEdesgfBTCuSs4T+/FIzVTxcv32LgMvxfNXAwVQ7WwSjh63Ea8ROOMyUohqKCKh97zbJVW3TWD0jPzK5DduFd1hkFj4pjAYOmPb8ZWz/uGEM2Rc6Q1Lh2Y4tcjJ+Lw3KO/UEmyyloQwEeyL6slY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZHFh+RQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c42f406e29so2126845a12.2;
        Fri, 11 Oct 2024 02:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728637230; x=1729242030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mlo3ULNgO8c4NC/nfO/Vuar4ajtr+hLPgASSMxV2JcI=;
        b=MZHFh+RQlbbsOwZgcwpYcHyNtYg3YB8DfL/Jc9gS+4gGZa7NmTDNxvLfDPLIVgO3bh
         ePbbAzwqcaValYiMYwA7V505lLuXq31jI1KU55dk7fhGBiGk8ndMH2tyL2D5Nmxquzes
         eG6lLbLgLBmoDVBlrnvTwMHG2CVEZywgkoVUIlm0H4H9OzzVpcKPBeE6MfwafzTcv6lV
         pk2thmQtDa8UOwbo5se+kwWqBSI3A/kZb9VXDLiYG7gcgzPUMeGIJTgAOPD1im2iwATF
         rClTjzbhCG2Yx9ufh0pJ5B/cLlSyfINxvr+zg1IjBRuIwTTkKTnD81TJQB/wgbEcjb/4
         md5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728637230; x=1729242030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mlo3ULNgO8c4NC/nfO/Vuar4ajtr+hLPgASSMxV2JcI=;
        b=GKqoXPsA3VU1ybRB0Bf3TYhpnI/I/H+MtqfXcqSYheP7oj4tP2VR+jC02G6P5OlOPO
         tWwlfFZp7cOYH4KO7beqc/QxhnPm9GHldaX3Uml4WshPpMdKv+/dJFfrccqYHkhYjmed
         ZC1oZEQfIiYV0HRjBmfjaHVE3mLyzTeKEAAbOHRjd3ya4b2BQvktcqxw6Oa1AXrd+8Zk
         jSFCCAD/+I1D1DZP8uXCc9VttkuQDDKwRPO4TNatrKtlxLZIWmfFDcjrnEOdR9jJ39cf
         KnasJnPBm7bQcqL5nGzc6axyGPNrusGcT1JtFHqa2dAEBpgAehV5sYCWl/NkOzIVbG3k
         mivA==
X-Forwarded-Encrypted: i=1; AJvYcCU8E3a8rls8NJqE3rc63FYzOyR1odhmi04zgK/c28eXG2FqQcVuaiVZ2y6sOvVm0AwctlPYr3EMNCXqwp1r@vger.kernel.org, AJvYcCXxIBGMxDgxyUzAqk1T0v3i0l21P6qM4/ihpF/s8y9MQ52Wg6rvEPiTQFuivc6jQ1FT/whbdg7zafFD@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmW8MMEr58DCmhssSHMwT1rs+P/AXaLjFgqq/3yNa3XNRyIEk
	WY5C5H/z0+Q5V8VZI6ruGVetyUa9O/sT4HSn0bEEil2WHMkEahFjf3FdRonP
X-Google-Smtp-Source: AGHT+IHGsawZ/k7vNRlJs2vc+Ajbp9uzfZGjsYmtz/VtdCm6gZsrlV8+e/+h0RuzJXMYgZS303tKfQ==
X-Received: by 2002:a17:907:948e:b0:a99:451b:38fe with SMTP id a640c23a62f3a-a99b93c8be7mr146498766b.26.1728637229548;
        Fri, 11 Oct 2024 02:00:29 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a7ec5697sm189606066b.22.2024.10.11.02.00.28
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
Subject: [PATCH v4 2/3] fs: name_to_handle_at() support for "explicit connectable" file handles
Date: Fri, 11 Oct 2024 11:00:22 +0200
Message-Id: <20241011090023.655623-3-amir73il@gmail.com>
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

nfsd encodes "connectable" file handles for the subtree_check feature,
which can be resolved to an open file with a connected path.
So far, userspace nfs server could not make use of this functionality.

Introduce a new flag AT_HANDLE_CONNECTABLE to name_to_handle_at(2).
When used, the encoded file handle is "explicitly connectable".

The "explicitly connectable" file handle sets bits in the high 16bit of
the handle_type field, so open_by_handle_at(2) will know that it needs
to open a file with a connected path.

old kernels will now recognize the handle_type with high bits set,
so "explicitly connectable" file handles cannot be decoded by
open_by_handle_at(2) on old kernels.

The flag AT_HANDLE_CONNECTABLE is not allowed together with either
AT_HANDLE_FID or AT_EMPTY_PATH.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fhandle.c               | 48 ++++++++++++++++++++++++++++++++++----
 include/linux/exportfs.h   |  2 ++
 include/uapi/linux/fcntl.h |  1 +
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 218511f38cbb..8339a1041025 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -31,6 +31,14 @@ static long do_sys_name_to_handle(const struct path *path,
 	if (!exportfs_can_encode_fh(path->dentry->d_sb->s_export_op, fh_flags))
 		return -EOPNOTSUPP;
 
+	/*
+	 * A request to encode a connectable handle for a disconnected dentry
+	 * is unexpected since AT_EMPTY_PATH is not allowed.
+	 */
+	if (fh_flags & EXPORT_FH_CONNECTABLE &&
+	    WARN_ON(path->dentry->d_flags & DCACHE_DISCONNECTED))
+		return -EINVAL;
+
 	if (copy_from_user(&f_handle, ufh, sizeof(struct file_handle)))
 		return -EFAULT;
 
@@ -45,7 +53,7 @@ static long do_sys_name_to_handle(const struct path *path,
 	/* convert handle size to multiple of sizeof(u32) */
 	handle_dwords = f_handle.handle_bytes >> 2;
 
-	/* we ask for a non connectable maybe decodeable file handle */
+	/* Encode a possibly decodeable/connectable file handle */
 	retval = exportfs_encode_fh(path->dentry,
 				    (struct fid *)handle->f_handle,
 				    &handle_dwords, fh_flags);
@@ -67,8 +75,23 @@ static long do_sys_name_to_handle(const struct path *path,
 		 * non variable part of the file_handle
 		 */
 		handle_bytes = 0;
-	} else
+	} else {
+		/*
+		 * When asked to encode a connectable file handle, encode this
+		 * property in the file handle itself, so that we later know
+		 * how to decode it.
+		 * For sanity, also encode in the file handle if the encoded
+		 * object is a directory and verify this during decode, because
+		 * decoding directory file handles is quite different than
+		 * decoding connectable non-directory file handles.
+		 */
+		if (fh_flags & EXPORT_FH_CONNECTABLE) {
+			handle->handle_type |= FILEID_IS_CONNECTABLE;
+			if (d_is_dir(path->dentry))
+				fh_flags |= FILEID_IS_DIR;
+		}
 		retval = 0;
+	}
 	/* copy the mount id */
 	if (unique_mntid) {
 		if (put_user(real_mount(path->mnt)->mnt_id_unique,
@@ -109,15 +132,30 @@ SYSCALL_DEFINE5(name_to_handle_at, int, dfd, const char __user *, name,
 {
 	struct path path;
 	int lookup_flags;
-	int fh_flags;
+	int fh_flags = 0;
 	int err;
 
 	if (flag & ~(AT_SYMLINK_FOLLOW | AT_EMPTY_PATH | AT_HANDLE_FID |
-		     AT_HANDLE_MNT_ID_UNIQUE))
+		     AT_HANDLE_MNT_ID_UNIQUE | AT_HANDLE_CONNECTABLE))
+		return -EINVAL;
+
+	/*
+	 * AT_HANDLE_FID means there is no intention to decode file handle
+	 * AT_HANDLE_CONNECTABLE means there is an intention to decode a
+	 * connected fd (with known path), so these flags are conflicting.
+	 * AT_EMPTY_PATH could be used along with a dfd that refers to a
+	 * disconnected non-directory, which cannot be used to encode a
+	 * connectable file handle, because its parent is unknown.
+	 */
+	if (flag & AT_HANDLE_CONNECTABLE &&
+	    flag & (AT_HANDLE_FID | AT_EMPTY_PATH))
 		return -EINVAL;
+	else if (flag & AT_HANDLE_FID)
+		fh_flags |= EXPORT_FH_FID;
+	else if (flag & AT_HANDLE_CONNECTABLE)
+		fh_flags |= EXPORT_FH_CONNECTABLE;
 
 	lookup_flags = (flag & AT_SYMLINK_FOLLOW) ? LOOKUP_FOLLOW : 0;
-	fh_flags = (flag & AT_HANDLE_FID) ? EXPORT_FH_FID : 0;
 	if (flag & AT_EMPTY_PATH)
 		lookup_flags |= LOOKUP_EMPTY;
 	err = user_path_at(dfd, name, lookup_flags, &path);
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 5e14d4500a75..4ee42b2cf4ab 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -169,6 +169,8 @@ struct fid {
 #define FILEID_USER_FLAGS(type) ((type) & FILEID_USER_FLAGS_MASK)
 
 /* Flags supported in encoded handle_type that is exported to user */
+#define FILEID_IS_CONNECTABLE	0x10000
+#define FILEID_IS_DIR		0x20000
 #define FILEID_VALID_USER_FLAGS	(0)
 
 /**
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87e2dec79fea..56ff2100e021 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -153,6 +153,7 @@
 					   object identity and may not be
 					   usable with open_by_handle_at(2). */
 #define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
+#define AT_HANDLE_CONNECTABLE	0x002	/* Request a connectable file handle */
 
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
-- 
2.34.1


