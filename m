Return-Path: <linux-fsdevel+bounces-15655-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAEB89112E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166431C28B4B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2213BC0D;
	Fri, 29 Mar 2024 01:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhIZlclk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF2013AD29
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677316; cv=none; b=HV8l6zBHdK4JM8N7hNUvma0JxVKGu32A44eB4XZhF8sebqnJ3qM2zpGemdpOaslov0skesj8E3VAIdXVIej3ypPD60NNyegrQx3JfweLp2AwMcQMLKzZefMyAUlEgjlw2C9uVYypJin1Tf5ZheLJBRXUkxmmwMPZpf4h0rHFiTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677316; c=relaxed/simple;
	bh=sqy3xAPgmjgOiWHaXJZZi1ooyhcDWUkMY7GvNQ4f4EQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HfFeejWTM2hB1NRSD7YkduU3hd0nNMHJnlO8Cw4hRpur+FlMXIGVAsQOAWKwPzl1VgFvUt338nYzFVmG2dtLZq6YN8HWNbg0CxLAv0rOnEJUOpCZCy4GJBC8ds+lgHVx9g4Az+HDC7yM2Tsfrr6zGRGT2CSU97nJ4IK9o68pkD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhIZlclk; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a08eb0956so25469497b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677313; x=1712282113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dc0/1tSRu57hk2+lOEsBiEE+YFsUFGOWDNxYukZQ2Us=;
        b=EhIZlclkOK4/1KI15NEBKCSrzt0al0Nnw5GpN9W8hi/5riwvqUchqEa3ci7OUcSTtz
         6hAimfpK/aleBDLJcmkirbm0XDaiwqmWkJ/L1R/CILT/El41vZP5rspLH0UGp6Bw2Vee
         ewBXUYGFvoDEDJLthGvXd4ORV/Dx1tIrmp0CyVtkBn3dPhEPxOcmpso/SKS6SJLVh946
         ygJXRXyF/kqJXrvfVayGZ0WDIwZV6niMgA8HNkcD6wuBPSyjwtslzmq/eSmwgXYAeNeY
         ufJiwELyKhoFZtRkguNdCcVm5UXZJbdI9qBwvJT73rS2vbHcIYaGpDkSveirt916NyvX
         27+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677313; x=1712282113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dc0/1tSRu57hk2+lOEsBiEE+YFsUFGOWDNxYukZQ2Us=;
        b=Xll2N4uBOE0w4SqVzid55h9lJlYalWLX+5MM0iAET1vI02RjKdxfQOP//FWv1fBLls
         Npo4syeQDVf3tVLMGIdYw/AVLyZAX7Ix5tE+hIJjRRjSxQW+92MdaevIJf4NQvTl0vQK
         EU9m2qdwsiEnmeMESnEluFbdPcxnBvdl1jQAMKZvcZdjvQQl+8SljWLRcpvZAF0IugSd
         tUWEuCbvFgebU5lA53l9WnSiKAtlAC7Fr9fSsl8YmWte2RPCeG1KipKODN07JbF469wl
         piPm9qEko0sxae8e/2OWbSrCaS6LQlqSfjCT0SO09F/DIHcRyBA2yhYT7IbZgard1xv0
         KvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWwiDkssooCTwAA8/8qHpPJu1bNhuKEqS9AwRNDm66YDdnMYo4tkQoffgOPsZ6qf1tZF5fooUD5hZ6DecD1ILI7sWqL6ekUOeVhUkMsSA==
X-Gm-Message-State: AOJu0Yy0p5efdaZ62Y4EiSDEZT19KZPcD5D/oCPOd4tMA2RGLANPaDLq
	4PFwkq62tx5zkw5kZQSyK7eFDcwgW/Iobx0xdwDuujJO4XzQQSjgH5zBiFmZ56dZcuqS/mnA91I
	tFw==
X-Google-Smtp-Source: AGHT+IFKaOhfB8pTm+iz3QIKSOTOmM9kTS5fpl2hYAvm7gIXStf1F4lwEArEBONetKY1pkXKJrMPSbPJmmo=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:220e:b0:dc7:865b:22c6 with SMTP id
 dm14-20020a056902220e00b00dc7865b22c6mr86787ybb.8.1711677313466; Thu, 28 Mar
 2024 18:55:13 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:48 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-34-drosen@google.com>
Subject: [RFC PATCH v4 33/36] fuse-bpf: Add default filter op
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

Add a default bpf func to call if the specific one is not present.
Useful if you wish to track when different ops are handled.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c        | 136 +++++++++++++++++++++------------------
 include/linux/bpf_fuse.h |   2 +
 include/uapi/linux/bpf.h |   1 +
 3 files changed, 77 insertions(+), 62 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 9227e62b8734..ec554a2bc93f 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -244,6 +244,12 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
 						&fa.info, &feo);	\
 		else							\
 			bpf_next = BPF_FUSE_CONTINUE;			\
+		if (bpf_next == BPF_FUSE_CALL_DEFAULT) {		\
+			if (fuse_ops->default_filter)			\
+				bpf_next = fuse_ops->default_filter(&fa.info); \
+			else						\
+				bpf_next = BPF_FUSE_CONTINUE;		\
+		}							\
 		if (bpf_next < 0) {					\
 			error = bpf_next;				\
 			break;						\
@@ -283,6 +289,12 @@ static inline void bpf_fuse_free_alloced(struct bpf_fuse_args *fa)
 		fa.info.opcode |= FUSE_POSTFILTER;			\
 		if (bpf_next == BPF_FUSE_POSTFILTER)			\
 			bpf_next = call_postfilter(fuse_ops, &fa.info, &feo);\
+		if (bpf_next == BPF_FUSE_CALL_DEFAULT) {		\
+			if (fuse_ops->default_filter)			\
+				bpf_next = fuse_ops->default_filter(&fa.info); \
+			else						\
+				bpf_next = BPF_FUSE_CONTINUE;		\
+		}							\
 		if (bpf_next < 0) {					\
 			error = bpf_next;				\
 			break;						\
@@ -611,7 +623,7 @@ static int fuse_open_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *
 		if (ops->opendir_prefilter)
 			return ops->opendir_prefilter(meta, &open->in);
 	}
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -625,7 +637,7 @@ static int fuse_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 		if (ops->opendir_postfilter)
 			return ops->opendir_postfilter(meta, &open->in, &open->out);
 	}
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_open_backing(struct bpf_fuse_args *fa, int *out,
@@ -767,7 +779,7 @@ static int fuse_create_open_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta
 {
 	if (ops->create_open_prefilter)
 		return ops->create_open_prefilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_create_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -775,7 +787,7 @@ static int fuse_create_open_postfilter(struct fuse_ops *ops, struct bpf_fuse_met
 {
 	if (ops->create_open_postfilter)
 		return ops->create_open_postfilter(meta, &args->in, &args->name, &args->entry_out, &args->open_out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_open_file_backing(struct inode *inode, struct file *file)
@@ -931,7 +943,7 @@ static int fuse_release_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->release_prefilter)
 		return ops->release_prefilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_release_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -939,7 +951,7 @@ static int fuse_release_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->release_postfilter)
 		return ops->release_postfilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_releasedir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -947,7 +959,7 @@ static int fuse_releasedir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_
 {
 	if (ops->releasedir_prefilter)
 		return ops->releasedir_prefilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_releasedir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -955,7 +967,7 @@ static int fuse_releasedir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta
 {
 	if (ops->releasedir_postfilter)
 		return ops->releasedir_postfilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_release_backing(struct bpf_fuse_args *fa, int *out,
@@ -1022,7 +1034,7 @@ static int fuse_flush_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->flush_prefilter)
 		return ops->flush_prefilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_flush_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1030,7 +1042,7 @@ static int fuse_flush_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->flush_postfilter)
 		return ops->flush_postfilter(meta, args);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_flush_backing(struct bpf_fuse_args *fa, int *out, struct file *file, fl_owner_t id)
@@ -1102,7 +1114,7 @@ static int fuse_lseek_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->lseek_prefilter)
 		return ops->lseek_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_lseek_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1110,7 +1122,7 @@ static int fuse_lseek_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->lseek_postfilter)
 		return ops->lseek_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_lseek_backing(struct bpf_fuse_args *fa, loff_t *out,
@@ -1217,7 +1229,7 @@ static int fuse_copy_file_range_prefilter(struct fuse_ops *ops, struct bpf_fuse_
 {
 	if (ops->copy_file_range_prefilter)
 		return ops->copy_file_range_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_copy_file_range_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1225,7 +1237,7 @@ static int fuse_copy_file_range_postfilter(struct fuse_ops *ops, struct bpf_fuse
 {
 	if (ops->copy_file_range_postfilter)
 		return ops->copy_file_range_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_copy_file_range_backing(struct bpf_fuse_args *fa, ssize_t *out, struct file *file_in,
@@ -1303,7 +1315,7 @@ static int fuse_fsync_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->fsync_prefilter)
 		return ops->fsync_prefilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1311,7 +1323,7 @@ static int fuse_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->fsync_postfilter)
 		return ops->fsync_postfilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_fsync_backing(struct bpf_fuse_args *fa, int *out,
@@ -1376,7 +1388,7 @@ static int fuse_dir_fsync_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_i
 {
 	if (ops->dir_fsync_prefilter)
 		return ops->fsync_prefilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_dir_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1384,7 +1396,7 @@ static int fuse_dir_fsync_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_
 {
 	if (ops->dir_fsync_postfilter)
 		return ops->dir_fsync_postfilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 int fuse_bpf_dir_fsync(int *out, struct inode *inode, struct file *file, loff_t start, loff_t end, int datasync)
@@ -1466,7 +1478,7 @@ static int fuse_getxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->getxattr_prefilter)
 		return ops->getxattr_prefilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_getxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1474,7 +1486,7 @@ static int fuse_getxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_i
 {
 	if (ops->getxattr_postfilter)
 		return ops->getxattr_postfilter(meta, &args->in, &args->name, &args->value, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_getxattr_backing(struct bpf_fuse_args *fa, int *out,
@@ -1580,7 +1592,7 @@ static int fuse_listxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_i
 {
 	if (ops->listxattr_prefilter)
 		return ops->listxattr_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_listxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1588,7 +1600,7 @@ static int fuse_listxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_
 {
 	if (ops->listxattr_postfilter)
 		return ops->listxattr_postfilter(meta, &args->in, &args->value, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_listxattr_backing(struct bpf_fuse_args *fa, ssize_t *out, struct dentry *dentry,
@@ -1701,7 +1713,7 @@ static int fuse_setxattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->setxattr_prefilter)
 		return ops->setxattr_prefilter(meta, &args->in, &args->name, &args->value);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_setxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1709,7 +1721,7 @@ static int fuse_setxattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_i
 {
 	if (ops->setxattr_postfilter)
 		return ops->setxattr_postfilter(meta, &args->in, &args->name, &args->value);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_setxattr_backing(struct bpf_fuse_args *fa, int *out, struct dentry *dentry,
@@ -1777,7 +1789,7 @@ static int fuse_removexattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta
 {
 	if (ops->removexattr_prefilter)
 		return ops->removexattr_prefilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_removexattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1785,7 +1797,7 @@ static int fuse_removexattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_met
 {
 	if (ops->removexattr_postfilter)
 		return ops->removexattr_postfilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_removexattr_backing(struct bpf_fuse_args *fa, int *out,
@@ -1904,7 +1916,7 @@ static int fuse_file_read_iter_prefilter(struct fuse_ops *ops, struct bpf_fuse_m
 {
 	if (ops->read_iter_prefilter)
 		return ops->read_iter_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_file_read_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -1912,7 +1924,7 @@ static int fuse_file_read_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_
 {
 	if (ops->read_iter_postfilter)
 		return ops->read_iter_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 // TODO: use backing-file.c
@@ -2044,7 +2056,7 @@ static int fuse_write_iter_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_
 {
 	if (ops->write_iter_prefilter)
 		return ops->write_iter_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_write_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2052,7 +2064,7 @@ static int fuse_write_iter_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta
 {
 	if (ops->write_iter_postfilter)
 		return ops->write_iter_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_file_write_iter_backing(struct bpf_fuse_args *fa, ssize_t *out,
@@ -2232,7 +2244,7 @@ static int fuse_file_fallocate_prefilter(struct fuse_ops *ops, struct bpf_fuse_m
 {
 	if (ops->file_fallocate_prefilter)
 		return ops->file_fallocate_prefilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_file_fallocate_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2240,7 +2252,7 @@ static int fuse_file_fallocate_postfilter(struct fuse_ops *ops, struct bpf_fuse_
 {
 	if (ops->file_fallocate_postfilter)
 		return ops->file_fallocate_postfilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_file_fallocate_backing(struct bpf_fuse_args *fa, int *out,
@@ -2339,7 +2351,7 @@ static int fuse_lookup_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->lookup_prefilter)
 		return ops->lookup_prefilter(meta, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_lookup_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2347,7 +2359,7 @@ static int fuse_lookup_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->lookup_postfilter)
 		return ops->lookup_postfilter(meta, &args->name, &args->out, &args->bpf_entries);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_lookup_backing(struct bpf_fuse_args *fa, struct dentry **out, struct inode *dir,
@@ -2603,7 +2615,7 @@ static int fuse_mknod_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->mknod_prefilter)
 		return ops->mknod_prefilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_mknod_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2611,7 +2623,7 @@ static int fuse_mknod_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->mknod_postfilter)
 		return ops->mknod_postfilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_mknod_backing(struct bpf_fuse_args *fa, int *out,
@@ -2773,7 +2785,7 @@ static int fuse_mkdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->mkdir_prefilter)
 		return ops->mkdir_prefilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_mkdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2781,7 +2793,7 @@ static int fuse_mkdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->mkdir_prefilter)
 		return ops->mkdir_postfilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 int fuse_bpf_mkdir(int *out, struct inode *dir, struct dentry *entry, umode_t mode)
@@ -2827,7 +2839,7 @@ static int fuse_rmdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->rmdir_prefilter)
 		return ops->rmdir_prefilter(meta, name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rmdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -2835,7 +2847,7 @@ static int fuse_rmdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->rmdir_postfilter)
 		return ops->rmdir_postfilter(meta, name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rmdir_backing(struct bpf_fuse_args *fa, int *out,
@@ -3020,7 +3032,7 @@ static int fuse_rename2_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->rename2_prefilter)
 		return ops->rename2_prefilter(meta, &args->in, &args->old_name, &args->new_name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rename2_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3028,7 +3040,7 @@ static int fuse_rename2_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->rename2_postfilter)
 		return ops->rename2_postfilter(meta, &args->in, &args->old_name, &args->new_name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rename2_backing(struct bpf_fuse_args *fa, int *out,
@@ -3124,7 +3136,7 @@ static int fuse_rename_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->rename_prefilter)
 		return ops->rename_prefilter(meta, &args->in, &args->old_name, &args->new_name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rename_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3132,7 +3144,7 @@ static int fuse_rename_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->rename_postfilter)
 		return ops->rename_postfilter(meta, &args->in, &args->old_name, &args->new_name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_rename_backing(struct bpf_fuse_args *fa, int *out,
@@ -3195,7 +3207,7 @@ static int fuse_unlink_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->unlink_prefilter)
 		return ops->unlink_prefilter(meta, name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_unlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3203,7 +3215,7 @@ static int fuse_unlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->unlink_postfilter)
 		return ops->unlink_postfilter(meta, name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_unlink_backing(struct bpf_fuse_args *fa, int *out, struct inode *dir, struct dentry *entry)
@@ -3300,7 +3312,7 @@ static int fuse_link_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *
 {
 	if (ops->link_prefilter)
 		return ops->link_prefilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3308,7 +3320,7 @@ static int fuse_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->link_postfilter)
 		return ops->link_postfilter(meta, &args->in, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 
@@ -3433,7 +3445,7 @@ static int fuse_getattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->getattr_prefilter)
 		return ops->getattr_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_getattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3441,7 +3453,7 @@ static int fuse_getattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->getattr_postfilter)
 		return ops->getattr_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 /* TODO: unify with overlayfs */
@@ -3597,7 +3609,7 @@ static int fuse_setattr_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->setattr_prefilter)
 		return ops->setattr_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_setattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3605,7 +3617,7 @@ static int fuse_setattr_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->setattr_postfilter)
 		return ops->setattr_postfilter(meta, &args->in, &args->out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_setattr_backing(struct bpf_fuse_args *fa, int *out,
@@ -3680,7 +3692,7 @@ static int fuse_statfs_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->statfs_prefilter)
 		return ops->statfs_prefilter(meta);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_statfs_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3688,7 +3700,7 @@ static int fuse_statfs_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->statfs_postfilter)
 		return ops->statfs_postfilter(meta, out);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_statfs_backing(struct bpf_fuse_args *fa, int *out,
@@ -3801,7 +3813,7 @@ static int fuse_get_link_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->get_link_prefilter)
 		return ops->get_link_prefilter(meta, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_get_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3809,7 +3821,7 @@ static int fuse_get_link_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_i
 {
 	if (ops->get_link_postfilter)
 		return ops->get_link_postfilter(meta, &args->name);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_get_link_backing(struct bpf_fuse_args *fa, const char **out,
@@ -3907,7 +3919,7 @@ static int fuse_symlink_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->symlink_prefilter)
 		return ops->symlink_prefilter(meta, &args->name, &args->path);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_symlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -3915,7 +3927,7 @@ static int fuse_symlink_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->symlink_postfilter)
 		return ops->symlink_postfilter(meta, &args->name, &args->path);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_symlink_backing(struct bpf_fuse_args *fa, int *out,
@@ -4047,7 +4059,7 @@ static int fuse_readdir_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->readdir_prefilter)
 		return ops->readdir_prefilter(meta, &args->in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_readdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -4055,7 +4067,7 @@ static int fuse_readdir_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_in
 {
 	if (ops->readdir_postfilter)
 		return ops->readdir_postfilter(meta, &args->in, &args->out, &args->buffer);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 struct fusebpf_ctx {
@@ -4223,7 +4235,7 @@ static int fuse_access_prefilter(struct fuse_ops *ops, struct bpf_fuse_meta_info
 {
 	if (ops->access_prefilter)
 		return ops->access_prefilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_access_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_info *meta,
@@ -4231,7 +4243,7 @@ static int fuse_access_postfilter(struct fuse_ops *ops, struct bpf_fuse_meta_inf
 {
 	if (ops->access_postfilter)
 		return ops->access_postfilter(meta, in);
-	return BPF_FUSE_CONTINUE;
+	return BPF_FUSE_CALL_DEFAULT;
 }
 
 static int fuse_access_backing(struct bpf_fuse_args *fa, int *out, struct inode *inode, int mask)
diff --git a/include/linux/bpf_fuse.h b/include/linux/bpf_fuse.h
index 15646ba59c41..0747790c47ec 100644
--- a/include/linux/bpf_fuse.h
+++ b/include/linux/bpf_fuse.h
@@ -86,6 +86,8 @@ static inline unsigned bpf_fuse_arg_size(const struct bpf_fuse_arg *arg)
 }
 
 struct fuse_ops {
+	uint32_t (*default_filter)(const struct bpf_fuse_meta_info *meta);
+
 	uint32_t (*open_prefilter)(const struct bpf_fuse_meta_info *meta,
 				struct fuse_open_in *in);
 	uint32_t (*open_postfilter)(const struct bpf_fuse_meta_info *meta,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 46c1a3e3166d..fe8b485c9335 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7467,6 +7467,7 @@ struct bpf_iter_num {
 #define BPF_FUSE_USER_PREFILTER		2
 #define BPF_FUSE_POSTFILTER		3
 #define BPF_FUSE_USER_POSTFILTER	4
+#define BPF_FUSE_CALL_DEFAULT		5
 
 /* Op Code Filter values for BPF Programs */
 #define FUSE_OPCODE_FILTER	0x0ffff
-- 
2.44.0.478.gd926399ef9-goog


