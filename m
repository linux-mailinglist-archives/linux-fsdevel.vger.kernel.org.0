Return-Path: <linux-fsdevel+bounces-15643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E037B8910F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2631C2285C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA2A69DF4;
	Fri, 29 Mar 2024 01:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wHJkKVjR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943B054F92
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677288; cv=none; b=AUOeWFVK21VlSJzJ3IrPenHbRP+x8vv3/tCBVwKtCs001yZ8T96YGFchYGi3kFXbXq9nvCutBS2zgeKei6b4EtsPPRog52shfa+SLeZy40Ejde1wQoxH82x6LIuXKYizCyVwljIMhP1SkFv6/EVoi5hmM5w598/gJi4SBTZ3x7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677288; c=relaxed/simple;
	bh=bBfAJi/bJf2nD+gd3YqaNeaEuDQ3ztMPp8XYXKoJ52g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A52V1W4d6KmOs4RzlehVHw3rGoIgAxd7ey+2wOEc32XA+Jqi4EUmnEtkhsnvXq95R0Ks+r9SAfVFqKyAVkYvdxvUELnRPidQkZUB+JjHJAJmujadD++jgN0jU7eoMA8QDBNGe7lyZz4VfPrQfutGQ2YPbkhHH/pV+AV5O34rQ70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wHJkKVjR; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so2780924276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677286; x=1712282086; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RHfrMplbbUkEBek0oxfkmQFW+uLxDMPloBNof976q78=;
        b=wHJkKVjRMmLu3l+quU/T1dkRy2eN9n0/f3raXxrUmdxkEBl+F5MjZr/xg38d4MvCqS
         Zs9QTc8jOGKXFRO4lO1MZBy7urTGovN9UqoSDGIj4vkCU6yKuKVfKoMFe23nx7gPicwU
         qTndnx7gWcpxrRQE3Bd68SISe31PeCm+I1cUHij18e1P5B9gpTPn5zi1CCK0q6EzeBqm
         Tc6Q/fcJVszPKaxFXH52l8WwjB31mbv0hsR5M7dzl9cGBNJFiLE8X9zQbPjt7yi13eTb
         +hYrgs/m/hkK3FRhKnopDAs5EHcEA4vG5Ef4vtT6QkBqDzMPAh39LsuLInkr63qWHXkW
         YRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677286; x=1712282086;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RHfrMplbbUkEBek0oxfkmQFW+uLxDMPloBNof976q78=;
        b=OtGgQ1l138GA3QpS64kTXR1njjBz3A1aJaE94HLkJI1wovSRPZ55StrkK8h2jL9N1P
         JbP+Kf6784zcUK/qUSSxxInpb4nxGbgqNkS45bNA/ENbtBL3XtS6boKvCZtrp43stexf
         GFEiKojAmmyyJbXNOpJiTfQsnZFy8t6+Z8S0z/LWmjH8OLPjgiFWkovL4Zfe+8z8CKNZ
         qDdisxXxF/PdiiiWf6eZPheFAziQSY1xtmeYMACBUIJT1+bjNJOEm/JNhd+e5/pbfJTD
         DPCgxWjlpj57sQflDgFNydv4lC2dslu7v8cTOqNVJNaUio+/uFFuSKm0IdNSY+Z171B7
         RpdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXg4JtV8ZyvtACH/w804fHT5sq9x6QZ1zktKvZVAkQhxQF4WIwtlBDvq7mbXKV2+Set+gk/SBiKVTDHQsstYbqg+tQLTXn8Mks8UbAtA==
X-Gm-Message-State: AOJu0Yy89yCzrOFjVNDQPSLQtHZpQv7hEuzbQNeNtN4IwI0kBwhsQPCO
	ogVKufsyTv0i5FGxdhj4/3hlTwkYnpdJrjmXuqpvtzBJwqwG1rLnKbEFLdVzehwFdH57+I9ejlm
	yNQ==
X-Google-Smtp-Source: AGHT+IFbnUa67u4V59nNCnGnTBVkSthpFf64uvZOHCdvmkQja1eGLLGkihEUhtkYy01teYap9rh/yjJgyyU=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:120a:b0:dda:c59c:3953 with SMTP id
 s10-20020a056902120a00b00ddac59c3953mr322226ybu.0.1711677285863; Thu, 28 Mar
 2024 18:54:45 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:36 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-22-drosen@google.com>
Subject: [RFC PATCH v4 21/36] fuse-bpf: Add partial flock support
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
	Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"

This adds passthrough support for flock on fuse-bpf files. It does not
give any control via a bpf filter. The flock will act as though it was
taken on the lower file.

see fuse_test -t32 (flock_test)

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 15 +++++++++++++++
 fs/fuse/file.c    |  9 +++++++--
 fs/fuse/fuse_i.h  |  1 +
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index f18aee297335..b2df2469c29c 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -9,6 +9,7 @@
 #include <linux/bpf_fuse.h>
 #include <linux/fdtable.h>
 #include <linux/file.h>
+#include <linux/filelock.h>
 #include <linux/fs_stack.h>
 #include <linux/namei.h>
 #include <linux/splice.h>
@@ -1586,6 +1587,20 @@ int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *io
 				iocb, from);
 }
 
+int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl)
+{
+	struct fuse_file *ff = file->private_data;
+	struct file *backing_file = ff->backing_file;
+	int error;
+
+	fl->fl_file = backing_file;
+	if (backing_file->f_op->flock)
+		error = backing_file->f_op->flock(backing_file, cmd, fl);
+	else
+		error = locks_lock_file_wait(backing_file, fl);
+	return error;
+}
+
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	int ret;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 46de67810f03..255eb59d04f8 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2676,13 +2676,18 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct inode *inode = file_inode(file);
 	struct fuse_conn *fc = get_fuse_conn(inode);
+	struct fuse_file *ff = file->private_data;
 	int err;
 
+#ifdef CONFIG_FUSE_BPF
+	/* TODO - this is simply passthrough, not a proper BPF filter */
+	if (ff->backing_file)
+		return fuse_file_flock_backing(file, cmd, fl);
+#endif
+
 	if (fc->no_flock) {
 		err = locks_lock_file_wait(file, fl);
 	} else {
-		struct fuse_file *ff = file->private_data;
-
 		/* emulate flock with POSIX locks */
 		ff->flock = true;
 		err = fuse_setlk(file, fl, 1);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 8ae6ad967f95..e69f83616909 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1651,6 +1651,7 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 #endif // CONFIG_FUSE_BPF
 
+int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl);
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
 int fuse_handle_backing(struct fuse_bpf_entry *fbe, struct path *backing_path);
-- 
2.44.0.478.gd926399ef9-goog


