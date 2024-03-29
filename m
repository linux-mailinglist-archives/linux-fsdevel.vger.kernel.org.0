Return-Path: <linux-fsdevel+bounces-15632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F48910C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A423828C4AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3233D3B8;
	Fri, 29 Mar 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Q3cKsRZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF0B3D3BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677264; cv=none; b=DRWO2uR5nyznNQYHdIkHE69S/03xP4lvvyJ57AvTt2nJQQJ0F6x3Y9o3gH7R7OnzFAosoXEjP5g5SLj2foKsvyPsih+J0e8XHK/DJlHEQCbRp4iFHZbVK4iMfSQZyPgFQH/8esOVlwrEDBDQGcroKm0LbuTPl9DEDrIK7AezFb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677264; c=relaxed/simple;
	bh=fvczagys3eeKlVoeCdtC8aX8ILYO2cwo2aEBbr60QNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n3K/8X065YMw3B2HxHqmATSg5LHi+9kQi/HlLN4ES5f9HulNVgvgzAXCKRkRwa/x4S1/IxVLr2Z6BJOhIwzFxcB5p1x1vlVXj2CWIejwBvla+7RhFYPWi5JL+Erz093axriOzP+iVooW4PciroQt/4V/iEg9TrsasChRKT5jX+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Q3cKsRZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd62fa20fso30387807b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677261; x=1712282061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RN40RVFAgvwoqdUJunI82ty/5fzSZehhGVy3k+SOK50=;
        b=4Q3cKsRZW9AkZtU5EdHpgZ4ObNUKH7d0fjZr4czVLSa+vVY4e1BSdqntdLokO+T+J8
         JA+ZUDp7/qUU3vIXH1IuzUODnp7PFyJtO/0l2tTaiGfQj+OoI6jdal8qNTHlJr4zkspv
         4reQV6kDN4d9cqy9kBzna0vT5Vn6lZIjCyckVQfUmuOEPdnCp6iG8FTMjDyFRdlPIaTJ
         GPbJUn0KsetvsfLFKO2v42y45YAQqCq+icSSsVOBh0AmPBSwQXbevSTVGA+rfZggFTHM
         ZElBdktoNJpCJqauTSiYeaHtR6ATUp9/gziSi9fbUgnWWDoBkOUEyiQnQaHDEo712m5B
         eLug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677261; x=1712282061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RN40RVFAgvwoqdUJunI82ty/5fzSZehhGVy3k+SOK50=;
        b=OStf+M09jGIsKs8lviqGGDwS1DLYVLydmAA4NWMf0x9PzwOD6YZy2/5lFAYH78CNUu
         QpCQaIrnlWWKCm8Sxo1w1XPO/mUR75BuOOCJSY+GRIJeXlDbv3NHpJdtfAn37R71rV3N
         3TGSMldI9IkbkSpfraFfWleRfGU33LXX+qBQ92as9kT2fLx5cNcdGPPUb5nNMXeDuLd3
         ImaSgtLqft5vutHlg/Zu9HrmvNlhFCglI1RnRJWaqg4XYGQoD/i3ckuhglIEtrFP6cVZ
         OthkkZNX55YJeqW75JqZl7G53MTjw+sqFkdw3CqShl5zgyg4H0P8WSAAHk+a7IXF/Mb7
         H1BA==
X-Forwarded-Encrypted: i=1; AJvYcCWaXZU3oxHRRldNhkINfb+jVZb/zd4TEwr2lEGX1BTWHA2+Hy44raOP+Cr6ujR4xRu0Y4dUqNYuPZziGeZd4koIeIIrm4Av64cjxjgKwg==
X-Gm-Message-State: AOJu0YyfyyDtF2p0bdraAWQ2yUFO2081tz7LNo8BDEVqz7BxTYsiRKan
	rPovKSs3/HB2d6I5/gXtC81rJBMlNKJalR3hB3j/LLHSbwxgXlA2IJ0JhM6XDVt8hzwSpwCKFLG
	vrQ==
X-Google-Smtp-Source: AGHT+IGuOQt8Snd/P6ofj2gX/JcTFHrD/nXa6QfIFbIPo49OngK3DoVwSGK+2/UzTDKaYsETWaFnfy3xB1Q=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a0d:efc5:0:b0:614:fa:c912 with SMTP id
 y188-20020a0defc5000000b0061400fac912mr269078ywe.1.1711677261512; Thu, 28 Mar
 2024 18:54:21 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:25 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-11-drosen@google.com>
Subject: [RFC PATCH v4 10/36] fuse-bpf: Add support for fallocate
From: Daniel Rosenberg <drosen@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Daniel Rosenberg <drosen@google.com>, Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds backing support for FUSE_FALLOCATE

Signed-off-by: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Paul Lawrence <paullawrence@google.com>
---
 fs/fuse/backing.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/file.c    |  3 +++
 fs/fuse/fuse_i.h  |  6 +++++
 3 files changed, 69 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 04cb0c0c10b0..4a22465ecdef 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -340,6 +340,66 @@ ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 	return ret;
 }
 
+static int fuse_file_fallocate_initialize_in(struct bpf_fuse_args *fa,
+					     struct fuse_fallocate_in *in,
+					     struct file *file, int mode, loff_t offset, loff_t length)
+{
+	struct fuse_file *ff = file->private_data;
+
+	*in = (struct fuse_fallocate_in) {
+		.fh = ff->fh,
+		.offset = offset,
+		.length = length,
+		.mode = mode,
+	};
+
+	*fa = (struct bpf_fuse_args) {
+		.info = (struct bpf_fuse_meta_info) {
+			.opcode = FUSE_FALLOCATE,
+			.nodeid = ff->nodeid,
+		},
+		.in_numargs = 1,
+		.in_args[0].size = sizeof(*in),
+		.in_args[0].value = in,
+	};
+
+	return 0;
+}
+
+static int fuse_file_fallocate_initialize_out(struct bpf_fuse_args *fa,
+					      struct fuse_fallocate_in *in,
+					      struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+static int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
+				       struct file *file, int mode, loff_t offset, loff_t length)
+{
+	const struct fuse_fallocate_in *ffi = fa->in_args[0].value;
+	struct fuse_file *ff = file->private_data;
+
+	*out = vfs_fallocate(ff->backing_file, ffi->mode, ffi->offset,
+			     ffi->length);
+	return 0;
+}
+
+static int fuse_file_fallocate_finalize(struct bpf_fuse_args *fa, int *out,
+					struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return bpf_fuse_backing(inode, struct fuse_fallocate_in, out,
+				fuse_file_fallocate_initialize_in,
+				fuse_file_fallocate_initialize_out,
+				fuse_file_fallocate_backing,
+				fuse_file_fallocate_finalize,
+				file, mode, offset, length);
+}
+
 /*******************************************************************************
  * Directory operations after here                                             *
  ******************************************************************************/
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index b3cae6e677f8..0ab882e1236a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3032,6 +3032,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		(!(mode & FALLOC_FL_KEEP_SIZE) ||
 		 (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_ZERO_RANGE)));
 
+	if (fuse_bpf_file_fallocate(&err, inode, file, mode, offset, length))
+		return err;
+
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 24f453d162ae..7a6cebecd00f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1439,6 +1439,7 @@ int parse_fuse_bpf_entry(struct fuse_bpf_entry *fbe, int num_entries);
 #ifdef CONFIG_FUSE_BPF
 
 int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *file, loff_t offset, int whence);
+int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length);
 int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags);
 int fuse_bpf_access(int *out, struct inode *inode, int mask);
 
@@ -1449,6 +1450,11 @@ static inline int fuse_bpf_lseek(loff_t *out, struct inode *inode, struct file *
 	return 0;
 }
 
+static inline int fuse_bpf_file_fallocate(int *out, struct inode *inode, struct file *file, int mode, loff_t offset, loff_t length)
+{
+	return 0;
+}
+
 static inline int fuse_bpf_lookup(struct dentry **out, struct inode *dir, struct dentry *entry, unsigned int flags)
 {
 	return 0;
-- 
2.44.0.478.gd926399ef9-goog


