Return-Path: <linux-fsdevel+bounces-35039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ECF9D04AD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D64881F219CA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2024 16:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DAB1DA612;
	Sun, 17 Nov 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI2rzMx1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB2223AD;
	Sun, 17 Nov 2024 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731861448; cv=none; b=OmcwlWCcsY+rCqhoAXYAupiIxr3DBKkvS/oXll59J5KEuyzce1UssexIfeRey0rKQvkFFbkvxsQBnEuP18N/rzq7RZpJxoabZnW6G8kOAMyYyrXut4wu0pv2WFHDl++1C0Xy8TqIjquLtt+KpkEq+GjTPRnwQ5Ik9EqhK8gb1iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731861448; c=relaxed/simple;
	bh=kpcEm9Mcf2J+wvBZe8UhQb7yknm1sbdvWP697oKorXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gHi81Ja4i47pL7mw1Dpxle7BdCDobvIRI6CKzpoDGcW1vhyeMVcn3BpBrD5SJmzEnEO8Wd9CitRguW0JEg/m5UlUmHb3nqXLEOCL16TTpZ65k455lze7N0RHWjNlG9HA9abDghPl1LcwK/HhaXjdcYVbs2Xy8Fa9bwVCzHUVxKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI2rzMx1; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20cdb889222so20695365ad.3;
        Sun, 17 Nov 2024 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731861446; x=1732466246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vMA9g0ieQb4FGXI4tL0EeYX61YRjSAvl7fcI+5lcUls=;
        b=iI2rzMx1/VoHOyJh6oWGwjFTOLepx2zXhnxZyWqApMw0fRAgbrmLI1z0utOBtnGO++
         dKfasvf5+du9X8KV22AoPrAfKA4ry6UgZz6C86/tf8QvU3FRTuMKVwEsN8r4NmvBEEbm
         CDM5pfKqvuXckx/5g5Tg+v5BdOuounlnV1c+FYjJaXdR4/YLGDck4Ey9hbIMVVPmkhUx
         tI1oNxv3y4NjjC4gTH8/+RebMWZLpFkXj3dc0sFTgO/kiVxlF2bi18JVZdPBr5U38/49
         o/73Gjxuq+9ZXeMtWcZPmVp+jKcjJfl7H5PNH3GRLp1P7UM9+iyngQF0QrUGfRRjxGBN
         5+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731861446; x=1732466246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vMA9g0ieQb4FGXI4tL0EeYX61YRjSAvl7fcI+5lcUls=;
        b=qebJa1/O6bPIjLz7V4muk8slo6DcLFf9cEaZewRzmF/8Zitb8xkmd/7dA5hAbABzlk
         Sd/UCflkxq+/T66ry9Kn5M6eQtkJ5roiHfEfEVsDl4vW7PrJwNBeq/y+PtfslKbenjaa
         d3GMK+cqiexZpXkkHEyy4+rjqkj7QH0hSZC87WyTaCL3nOPFi+you5ap/jrL8QYIrj9W
         wYXI7WQlEF+/I6/iJXWB5Q+FuiRvKzCI2vqN9dnk9lG1ZgW7xWQqq48KH2dcSpiauoD1
         vPUFhlYY/cNbjjutns5VG3xPzx2oMDwzhg4bvIAJDHMZnrYmUCrbct2xhCg7+SIv9eyd
         xYGA==
X-Forwarded-Encrypted: i=1; AJvYcCU8XOGTez3hSUa/EReYLtwi4XzEQE0NCDxjuymXSyTzGUC3YkcrkqeNG2H8uwQl7tCn3HvJp33X7CGke/8q@vger.kernel.org, AJvYcCXQ6c9xMSMsu5W625xU28cvz2YKeAQ2S0N8R5QUudVOOKpVcH+EKnlSPDDGWngal4ofl9M5/wqPDhcXPnYg@vger.kernel.org, AJvYcCXrSJz8bnaEMBti3ZsBGVxhpFVTMxst3/on0lnrlt1XZFQ73ANSSGXsLKr6mOS4Plf5qKAt8AD4@vger.kernel.org
X-Gm-Message-State: AOJu0YwXw1BOIJrTsx3w0DTji07FUX/6AyhPpJuIhF0QSiWmH2vg3HqU
	06SrFBcHNczKvmpWVt3DdKKT3ldcozqoopaU8rqYfxIr/xxxYQ0mSzsDFR4p
X-Google-Smtp-Source: AGHT+IG9fJrqcgbGd0VodBFM6O+os4m+kvXOMWizLW61sT7ZDTjxAvlh8SbyOR1T30+uHGNzLZYZ+Q==
X-Received: by 2002:a17:903:11c9:b0:20c:d428:adf4 with SMTP id d9443c01a7336-211d0ecb083mr148289215ad.38.1731861445980;
        Sun, 17 Nov 2024 08:37:25 -0800 (PST)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ea2a3fe8a5sm3272519a91.13.2024.11.17.08.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2024 08:37:25 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] fs: prevent data-race due to missing inode_lock when calling vfs_getattr
Date: Mon, 18 Nov 2024 01:37:19 +0900
Message-Id: <20241117163719.39750-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many filesystems lock inodes before calling vfs_getattr, so there is no
data-race for inodes. However, some functions in fs/stat.c that call
vfs_getattr do not lock inodes, so the data-race occurs.

Therefore, we need to apply a patch to remove the long-standing data-race
for inodes in some functions that do not lock inodes.

Cc: <stable@vger.kernel.org>
Fixes: da9aa5d96bfe ("fs: remove vfs_statx_fd")
Fixes: 0ef625bba6fb ("vfs: support statx(..., NULL, AT_EMPTY_PATH, ...)")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/stat.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..da532b611aa3 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -220,13 +220,21 @@ EXPORT_SYMBOL(vfs_getattr);
  */
 int vfs_fstat(int fd, struct kstat *stat)
 {
+	const struct path *path;
+	struct inode *inode;
 	struct fd f;
 	int error;
 
 	f = fdget_raw(fd);
 	if (!fd_file(f))
 		return -EBADF;
-	error = vfs_getattr(&fd_file(f)->f_path, stat, STATX_BASIC_STATS, 0);
+
+	path = &fd_file(f)->f_path;
+	inode = d_backing_inode(path->dentry);
+
+	inode_lock_shared(inode);
+	error = vfs_getattr(path, stat, STATX_BASIC_STATS, 0);
+	inode_unlock_shared(inode);
 	fdput(f);
 	return error;
 }
@@ -248,7 +256,11 @@ int getname_statx_lookup_flags(int flags)
 static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
+	struct inode *inode = d_backing_inode(path->dentry);
+
+	inode_lock_shared(inode);
 	int error = vfs_getattr(path, stat, request_mask, flags);
+	inode_unlock_shared(inode);
 
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
 		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
--

