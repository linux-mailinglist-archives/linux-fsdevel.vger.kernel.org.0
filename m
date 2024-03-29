Return-Path: <linux-fsdevel+bounces-15627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17DB8910B1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01107B234FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 01:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B81DA52;
	Fri, 29 Mar 2024 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uCjZBU7q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF6374C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677253; cv=none; b=PhEw18dEXLlVgC+2Eu96LKmsGSCZ0DVIs2oaF7jTtawEncn+To+QwpAHCTyWh/2pKJHClNsHlxR5dZLaTYXDj/o6CTC3JWhkdQXuCmTPjm3gLu/jKBSxdtAB31uyC/k5Zacs/J/zUcUseVQN33zVd4BYNkPabHRqmluycW5M54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677253; c=relaxed/simple;
	bh=Ib5M0mE4oOOU/5nwAtZYmwkWiH40UcIcM9efdJ1OU34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a2hHOk5oVUu700Eq3CSHViISwkQ1H6OQzZ/0CYKmLxK6xRxOjBl5DOCYw+Bza9q2YkPghiU9be5lGvxSaosR2RpzK4fnl+Y/v81n6eoXWpGydrHDEh7GJo51BBl91UZW609uVdJeWmx1bM92ekzqId7V7nYtGtaqQwzrliR5KUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uCjZBU7q; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso2517914276.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677250; x=1712282050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rxMPvHmZ0NJBpckZ6zd2n+WU0SbXQuOXvLdtYgKifzc=;
        b=uCjZBU7qN3mc0RtSMPWB1HF43nsmquKuWZwCiMPQmW1bNx5+Yr86QSapo54ubxdWHm
         FnEvwZPTRGQW3aUHyh5+pxDyz/QcKv2V8P+P7h5osplxGCmSVRJ+WZx8rQBApuYD7lZ/
         qrN/GDyIYtJOTQufZUehG5iYJX7r8IoUJ5LoCxJE9vna58PpT+vWgzJM52qe3WkB28b+
         w+6GRKI8xy/8z5ZWWlxlslpn6clmPK9xqnme043p97zou5witIEteQrCLW4Kh8bvlEcO
         MR+gY9WeW6Q/gYEBrlwi0JvcIaqnAuNrUvXmEiD//xC22Ena2Uz5t9cwrWuNt69ix4h2
         5LxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677250; x=1712282050;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rxMPvHmZ0NJBpckZ6zd2n+WU0SbXQuOXvLdtYgKifzc=;
        b=bc+6q5/cQH8rlGodo1w184jf3tEyy4Ak/yfWozX4YRhw9uU4lN2u/qSNn4tR1fCqJX
         J7YRWoDopkkkHQvbrweAqWe9s/8gnrfGPa9AhW84/FlBr7/IM7Ww3qaUiq7LOq3HuDFz
         IoKvFawBeQ1GzuwYtd3Dop1w8dGQlKcVT4xxTVqBBiGz2uV/4uhshOjrKkzSgr6nzODP
         m9NezHyajO3f18DD3a8+auHW2G5IXXjAev0Cw37HIkBUap76dcglA5jcU6qf9kBOfIxb
         Qd04DO5tMeixeaamiEqhY3jdqcnLQOP/SLkGXzl8vmK49NAlzZk9UU/4cTTDhQmDox+f
         TMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJWw+OSq7QQtBbQvgsCK4kNGlRlE/mXbz+PBMqeXsLla1DSUGQpCQg9qSTdSQkK1oWzrTYk7rNWvIEtJFtxfeLhvTZKRdCnMqDDcjdjA==
X-Gm-Message-State: AOJu0Ywn56Xhpl7jWHtaNr3f8O8XRjuwPtDB95S9Y6tLECfpWv+A7vwQ
	b+W5frV/vaUTO3v159MV8T8jGF6adCowh6yipIVE+56yeQQjDF1+1aydj761jgTVtpV7IzGGeTu
	xSg==
X-Google-Smtp-Source: AGHT+IHmTiZP61Xdw5I4MgZP6S1EGzBAU27OWO+ECrGNgj9iXk3fTSjTU3SpedzKrf2XxG9PXneBv/rj30E=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2291:b0:dc7:42:ecd with SMTP id
 dn17-20020a056902229100b00dc700420ecdmr315101ybb.6.1711677250595; Thu, 28 Mar
 2024 18:54:10 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:20 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-6-drosen@google.com>
Subject: [RFC PATCH v4 05/36] fuse-bpf: Add ioctl interface for /dev/fuse
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

This introduces an alternative method of responding to fuse requests.
Lookups supplying a backing fd or bpf will need to call through the
ioctl to ensure there can be no attempts to fool priveledged processes
into inadvertantly performing other actions.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/dev.c             | 56 ++++++++++++++++++++++++++++++++-------
 fs/fuse/fuse_i.h          |  1 +
 include/uapi/linux/fuse.h |  1 +
 3 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b413e0bfd61c..e51ec198af3f 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1016,18 +1016,19 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 
 /* Copy the fuse-bpf lookup args and verify them */
 #ifdef CONFIG_FUSE_BPF
-static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+static int fuse_copy_lookup(struct fuse_copy_state *cs, unsigned via_ioctl, void *val, unsigned size)
 {
 	struct fuse_bpf_entry_out *fbeo = (struct fuse_bpf_entry_out *)val;
 	struct fuse_bpf_entry *feb = container_of(fbeo, struct fuse_bpf_entry, out[0]);
 	int num_entries = size / sizeof(*fbeo);
 	int err;
 
-	if (size && size % sizeof(*fbeo) != 0)
+	if (size && (size % sizeof(*fbeo) != 0 || !via_ioctl))
 		return -EINVAL;
 
 	if (num_entries > FUSE_BPF_MAX_ENTRIES)
 		return -EINVAL;
+
 	err = fuse_copy_one(cs, val, size);
 	if (err)
 		return err;
@@ -1036,7 +1037,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 	return err;
 }
 #else
-static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size)
+static int fuse_copy_lookup(struct fuse_copy_state *cs, unsigned via_ioctl, void *val, unsigned size)
 {
 	return fuse_copy_one(cs, val, size);
 }
@@ -1045,7 +1046,7 @@ static int fuse_copy_lookup(struct fuse_copy_state *cs, void *val, unsigned size
 /* Copy request arguments to/from userspace buffer */
 static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing, unsigned is_lookup)
+			  int zeroing, unsigned is_lookup, unsigned via_ioct)
 {
 	int err = 0;
 	unsigned i;
@@ -1055,7 +1056,7 @@ static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
 		if (i == numargs - 1 && argpages)
 			err = fuse_copy_pages(cs, arg->size, zeroing);
 		else if (i == numargs - 1 && is_lookup)
-			err = fuse_copy_lookup(cs, arg->value, arg->size);
+			err = fuse_copy_lookup(cs, via_ioct, arg->value, arg->size);
 		else
 			err = fuse_copy_one(cs, arg->value, arg->size);
 	}
@@ -1333,7 +1334,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	err = fuse_copy_one(cs, &req->in.h, sizeof(req->in.h));
 	if (!err)
 		err = fuse_copy_args(cs, args->in_numargs, args->in_pages,
-				     (struct fuse_arg *) args->in_args, 0, 0);
+				     (struct fuse_arg *) args->in_args, 0, 0, 0);
 	fuse_copy_finish(cs);
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
@@ -1872,7 +1873,8 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
 		lastarg->size -= diffsize;
 	}
 	return fuse_copy_args(cs, args->out_numargs, args->out_pages,
-			      args->out_args, args->page_zeroing, args->is_lookup);
+			      args->out_args, args->page_zeroing, args->is_lookup,
+			      args->via_ioctl);
 }
 
 /*
@@ -1882,7 +1884,7 @@ static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
  * it from the list and copy the rest of the buffer to the request.
  * The request is finished by calling fuse_request_end().
  */
-static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
+static ssize_t fuse_dev_do_write(struct fuse_dev *fud, bool from_ioctl,
 				 struct fuse_copy_state *cs, size_t nbytes)
 {
 	int err;
@@ -1954,6 +1956,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (!req->args->page_replace)
 		cs->move_pages = 0;
 
+	req->args->via_ioctl = from_ioctl;
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
@@ -1992,7 +1995,7 @@ static ssize_t fuse_dev_write(struct kiocb *iocb, struct iov_iter *from)
 
 	fuse_copy_init(&cs, 0, from);
 
-	return fuse_dev_do_write(fud, &cs, iov_iter_count(from));
+	return fuse_dev_do_write(fud, false, &cs, iov_iter_count(from));
 }
 
 static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
@@ -2073,7 +2076,7 @@ static ssize_t fuse_dev_splice_write(struct pipe_inode_info *pipe,
 	if (flags & SPLICE_F_MOVE)
 		cs.move_pages = 1;
 
-	ret = fuse_dev_do_write(fud, &cs, len);
+	ret = fuse_dev_do_write(fud, false, &cs, len);
 
 	pipe_lock(pipe);
 out_free:
@@ -2286,6 +2289,33 @@ static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 	return 0;
 }
 
+// Provides an alternate means to respond to a fuse request
+static int fuse_handle_ioc_response(struct fuse_dev *dev, void *buff, uint32_t size)
+{
+	struct fuse_copy_state cs;
+	struct iovec *iov = NULL;
+	struct iov_iter iter;
+	int res;
+
+	if (size > PAGE_SIZE)
+		return -EINVAL;
+	iov = (struct iovec *) __get_free_page(GFP_KERNEL);
+	if (!iov)
+		return -ENOMEM;
+
+	iov->iov_base = buff;
+	iov->iov_len = size;
+
+	iov_iter_init(&iter, READ, iov, 1, size);
+	fuse_copy_init(&cs, 0, &iter);
+
+
+	res = fuse_dev_do_write(dev, true, &cs, size);
+	free_page((unsigned long) iov);
+
+	return res;
+}
+
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 			   unsigned long arg)
 {
@@ -2319,6 +2349,12 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		fdput(f);
 		break;
 	default:
+		if (_IOC_TYPE(cmd) == FUSE_DEV_IOC_MAGIC
+				&& _IOC_NR(cmd) == _IOC_NR(FUSE_DEV_IOC_BPF_RESPONSE(0))
+				&& _IOC_DIR(cmd) == _IOC_WRITE) {
+			res = fuse_handle_ioc_response(fuse_get_dev(file), (void *) arg, _IOC_SIZE(cmd));
+			break;
+		}
 		res = -ENOTTY;
 		break;
 	}
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ac61f08fd85d..dd62e78e474c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -336,6 +336,7 @@ struct fuse_args {
 	bool may_block:1;
 	bool is_ext:1;
 	bool is_lookup:1;
+	bool via_ioctl:1;
 	struct fuse_in_arg in_args[3];
 	struct fuse_arg out_args[2];
 	void (*end)(struct fuse_mount *fm, struct fuse_args *args, int error);
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 0c0a9a8b5c26..74bc15e1d0b7 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1075,6 +1075,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_BPF_RESPONSE(N) _IOW(FUSE_DEV_IOC_MAGIC, 125, char[N])
 
 struct fuse_lseek_in {
 	uint64_t	fh;
-- 
2.44.0.478.gd926399ef9-goog


