Return-Path: <linux-fsdevel+bounces-52040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E13F6ADEB88
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CED5B188EF45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 12:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532A72DFF33;
	Wed, 18 Jun 2025 12:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX0a02Sq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D072556E;
	Wed, 18 Jun 2025 12:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248875; cv=none; b=oIOOHr8qHV3AhzAkI5kEnsXUJD7jJusBO+78mJAQ2/FVLatzTp59V+j/yio0apwtag7V8Prs1wl5e/qloD3D+4keI9OlHVdcv9pLTesFCVX/pEZnlA9Ocj6SMO0R5T2/ONWwdm8vdMCVgF3bTjr9HEUnNS4aA2lsQK5rP4VfQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248875; c=relaxed/simple;
	bh=UXuER4/rBN6wrX7f+s4UJRoHXUB8UAEoia+k8w0FVHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o30GKbUmicBSCYh9zuwocwvgD0t5/OBx0ounHCqT8lCeh2XDI4WY1QxbIUJScnBUowvPsEHnxtvB0wHIMODqmB9wkoLR3fgvxifnNeJlDexnosB5NMh3cB5TBaE+t4rYu0e1AbE3hjVOLPp2aSwwFJOrs2ylLVVulJ5D9L6ijTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX0a02Sq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b440afa7so68372645ad.0;
        Wed, 18 Jun 2025 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750248873; x=1750853673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWwTPNhC8S5jicfmYKheC+H1AbftgEz+KM7Kz0AjTw=;
        b=UX0a02SqTEtwZ0lep7cMO7exwdfg8tVwGk0xneEX9YZ9YWpVDjnAp/IO9GUll/rngo
         tP5qFT1LHSR5D5B8MwptHcudB2WV50oQlYheMvUtLFOHEGfUwngcDmbeSVt6v7mSv1uS
         DBGuKR4FMB1aRiKiZFwACujuUevLkkslMWpe8BmByrkOPs6Dr/2A9InejjB6kv+6NBLH
         PQ+FPNpoQzkMzbvfHv0D55E1Waczt/TdGAA/asbrOnklefLzcFg3x37JyvGoOfug1n/D
         G2tPrkBoHvcIwzgf/FxH8/W6aaB1vjKKUTL5GgViDYhs26BmCXOJmciee5OCaX80YgnW
         PeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750248873; x=1750853673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5YWwTPNhC8S5jicfmYKheC+H1AbftgEz+KM7Kz0AjTw=;
        b=CiB3qLuTKyU+d/EHReOtO0H1XmUUErYHVwawjeFjhDuqPt55eEQu2T17FGwgpbgWkC
         Yquof+1MhBThyjy3InLFGdEOGCoaHACh8jsckv+th20hQ6d9aY/WmrU/tIzNN5u4EHnK
         MsL8/K/jy0mpIFe/9+IHnfLYrC8IvLnpgQqlt8I84jkfGgCjBfiPGPDfLhC6Yn1Rjg/U
         BCJuF7E9jKEpTqHh8QRkTIfie5lsVsXtt9czxivNOxspcp7sjuQu/TFi+c/P+MiNCBMM
         Ce+FZxWK/0PAq/ZACn6MdwZ3guFuaAfGQGh0GinKN+TImWZFm4KRFWo4JRYGadwy/VMd
         JDsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWOSe/gMWoXvTU8CTOq258rUhxKg4jiJFzbaWIbeD6PCxtZyg4tGctN+QlkSEWW5x+cp9BXSLTOo1lEH04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlz0PEe7S+5r662fLsvWm4VF9UqGGAcso+om/Ta9YLaxtW0EkY
	f9/Vc/85N+fw/HTxp9dsNVf0Ra/lfmAjMy33WBjMi8izqtvsX+6cO92eFqGCaQ==
X-Gm-Gg: ASbGncvQn7Ndv7TMxQzTRxheO5ME/Ics9HP/9OcsAal+Yu5uJD/Kava34m2xPFts8wX
	Z2M+XYyjHH3nC9Jkmq9VHoIHAuhMBGjcGeDVjPXZxLKiGCWVUcKOyQg5zFAhpCqgLMO1tTLPsyD
	/rrDPrlQA8qlQPvKpcDwpBV//+OXvOVRYVf+XgLTPMzrwEu/Siu8YXjLmWWCFU76Fl0uKCs5MnZ
	GZ4wIFaxigBFTdOe9vEOURbLLjEOp7qG6i8N0K/Bc4r4MUcvsWMEnGH431wGUlWsNlckiIyOTZj
	lNjIIxqfWcB8XHu0GzC5BsbzZ6j/wSvHyhHyGphFp3fPEUpVDsbpTYv1cJqhmYCRasDfH3gUzg=
	=
X-Google-Smtp-Source: AGHT+IEgEpsABEmvaXoUngLUPNeRtFBJ40NcjW0HUiclHgoNV8nD2SkoJe17VGpcgcQMtK7tOG9WEA==
X-Received: by 2002:a17:902:ccc8:b0:234:a992:96d8 with SMTP id d9443c01a7336-2366b34e98fmr298466135ad.19.1750248873483;
        Wed, 18 Jun 2025 05:14:33 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de78176sm98751285ad.96.2025.06.18.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 05:14:33 -0700 (PDT)
From: alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinliang Zheng <alexjlzheng@tencent.com>
Subject: [PATCH] fs: fix the missing export of vfs_statx() and vfs_fstatat()
Date: Wed, 18 Jun 2025 20:14:29 +0800
Message-ID: <20250618121429.188696-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jinliang Zheng <alexjlzheng@tencent.com>

After commit 09f1bde4017e ("fs: move vfs_fstatat out of line"), the two
symbols vfs_statx() and vfs_fstatat() are no longer visible to the kernel
module.

The above patches does not explain why the export of these two symbols is
stopped, and exporting these two kernel symbols does not affect the
functionality of the above patch.

In fact, getting the length of a file in a kernel module is a useful
operation. For example, some kernel modules used for security hardening may
need to know the length of a file in order to read it into memory for
verification.

There is no reason to prohibit kernel module developers from doing this.
So this patch fixes that by reexporting vfs_statx() and vfs_fstatat().

Fixes: 09f1bde4017e ("fs: move vfs_fstatat out of line")
Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
---
 fs/stat.c          | 4 +++-
 include/linux/fs.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index f95c1dc3eaa4..e844a1a076d7 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -338,7 +338,7 @@ static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
  *
  * 0 will be returned on success, and a -ve error code if unsuccessful.
  */
-static int vfs_statx(int dfd, struct filename *filename, int flags,
+int vfs_statx(int dfd, struct filename *filename, int flags,
 	      struct kstat *stat, u32 request_mask)
 {
 	struct path path;
@@ -361,6 +361,7 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 	}
 	return error;
 }
+EXPORT_SYMBOL(vfs_statx);
 
 int vfs_fstatat(int dfd, const char __user *filename,
 			      struct kstat *stat, int flags)
@@ -377,6 +378,7 @@ int vfs_fstatat(int dfd, const char __user *filename,
 
 	return ret;
 }
+EXPORT_SYMBOL(vfs_fstatat);
 
 #ifdef __ARCH_WANT_OLD_STAT
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..c9497da6b459 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3550,6 +3550,8 @@ extern const struct inode_operations simple_symlink_inode_operations;
 
 extern int iterate_dir(struct file *, struct dir_context *);
 
+int vfs_statx(int dfd, struct filename *filename, int flags,
+		struct kstat *stat, u32 request_mask);
 int vfs_fstatat(int dfd, const char __user *filename, struct kstat *stat,
 		int flags);
 int vfs_fstat(int fd, struct kstat *stat);
-- 
2.49.0


