Return-Path: <linux-fsdevel+bounces-15644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85418910FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 03:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E995B1C22EA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Mar 2024 02:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC33469D37;
	Fri, 29 Mar 2024 01:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jmoc2SZv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751869D3A
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Mar 2024 01:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677290; cv=none; b=NuaZdIMlOuJg1dZDuvOZlKP1bPdF7skGMjIxJLLIIyI3ckUi+nioQT4NF1mFEqHmDy2e5PmALWSQIeyGWxT6s0khjG2ntZs5nytwFbR8vKGkNMJpUloFXvBERqDPqmsOBBY/1UKfx5nsRKI+j4dYDDHu3xuHVV2gu3XDBD4iGPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677290; c=relaxed/simple;
	bh=khFObfDZD9RDH2x00diHiavJfq0/SktiZtvPXG5MlzE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nsrM0iA7FUUXW2bG62OcIZeP9hf80ZeOMrPowspeDGJ7c9tOcSOqE+SQynCp8dqS7ehDaz0VRwqMC6+oh8onYd4ni4NHCQjRlrhOwssXF+Bd9c2eXkynofDHe64P5r3CUXXrqSqKxaNwxk4MhyO30T07Zzn3kvJHvtjpGpE2bBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jmoc2SZv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--drosen.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dced704f17cso2711755276.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 18:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711677288; x=1712282088; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NDLJEVuG9Rbj6C1vTwZ9ezw7r88gt9y1LMBKHsbBCE8=;
        b=jmoc2SZvk2aoUv1xz4bPrYSGvddGhft76CPXgi/v7tXp7O5BwobqQIiovVGV+mVsNY
         hd0y/SWSzjjvxR078oLEaPhwChSrO4ySP+34oO0/U9Hm8dzsaRWUE9mlbRWemiyHhS+U
         pblEFhV82fiFoY6eeSt1Dmmuin6UMTycDAlX9N4wfCDNcMFjVUg7sqIT9BxYKUiFAmzT
         GXSyAimRqT8XfuDlKTdxO1FtP5I+xGhb6h7gP20CyRD2+L8fitMe5jTPtcJcPcDoLpi9
         9MvK4xIfGtLifSmtxkLNNp7XTE/dHhnAXM4pkUvRtsLs18S6BNBbTdCFKeXI+Q8j35by
         dUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711677288; x=1712282088;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NDLJEVuG9Rbj6C1vTwZ9ezw7r88gt9y1LMBKHsbBCE8=;
        b=HqmfvpfD9UkgbmgVsHX47ZwEWI18GLHlRLa5bI7N7ZQfr/iSDs0p+TWlzXvh5sKmTA
         XlpBfhraSaeB1CgyXMq6bcV819Lb9oAbDBC2aA5ZUZnR14rFTlq7mQskr78h233ELQR/
         esbfuhp0M1eQZl0gu0eCPUufMPjaxWh+UrR5l4OmbD4hk0Kltqp8SVGz/fMHpGXgGwqV
         FVM2djdBJfRA96ChihAYdswdszMZrZAup0zUk8FkMH/DMkdJjlMv1m4ls9Nqh2C5K+Xv
         8TKdhatXOaLs3r/xEL0DQekGrxsY6pBogsxRAsF3rcElZgXZJkrslsfn978VNI8FHG/+
         3sJw==
X-Forwarded-Encrypted: i=1; AJvYcCWDekNrS39tUaRK2XMs5yu/Vfqqm4rdvP3rIMXCJT+eGXwdbhnmEwZs6CBOGSRlmpVkZHsDORuCwi0MEM1lD4lgcXiufi2QWt8hv/K7Yg==
X-Gm-Message-State: AOJu0YzPFHONj0Voc4T6p5mH4W3JFUjQdo8Ec9XLSTbXZPC1iyHcTxu7
	z1KzFNdMaPzAARIvXzhrUmuJM5N+Oc+6ZTfpDitaXehGRXM1z0DLoBKYLSTmSb9ay4kGx0w3NyQ
	5fQ==
X-Google-Smtp-Source: AGHT+IGAbEDexCw+N2JysnI9m0JGtmH2E2g+ERbDEaavjOuwDP/sU418H9UcdiCecEIveINGY+GMY2/U38o=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:fcce:d6ab:804c:b94b])
 (user=drosen job=sendgmr) by 2002:a05:6902:2481:b0:dd9:2a64:e98a with SMTP id
 ds1-20020a056902248100b00dd92a64e98amr86513ybb.9.1711677288087; Thu, 28 Mar
 2024 18:54:48 -0700 (PDT)
Date: Thu, 28 Mar 2024 18:53:37 -0700
In-Reply-To: <20240329015351.624249-1-drosen@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240329015351.624249-23-drosen@google.com>
Subject: [RFC PATCH v4 22/36] fuse-bpf: Add partial ioctl support
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

This adds passthrough only support for ioctls with fuse-bpf.
compat_ioctls will return -ENOTTY.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/fuse/backing.c | 13 +++++++++++++
 fs/fuse/fuse_i.h  |  2 ++
 fs/fuse/ioctl.c   |  9 +++++++++
 3 files changed, 24 insertions(+)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index b2df2469c29c..884c690becd5 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -1587,6 +1587,19 @@ int fuse_bpf_file_write_iter(ssize_t *out, struct inode *inode, struct kiocb *io
 				iocb, from);
 }
 
+long fuse_backing_ioctl(struct file *file, unsigned int command, unsigned long arg, int flags)
+{
+	struct fuse_file *ff = file->private_data;
+	long ret;
+
+	if (flags & FUSE_IOCTL_COMPAT)
+		ret = -ENOTTY;
+	else
+		ret = vfs_ioctl(ff->backing_file, command, arg);
+
+	return ret;
+}
+
 int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl)
 {
 	struct fuse_file *ff = file->private_data;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index e69f83616909..81639c006ac5 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1651,6 +1651,8 @@ static inline int fuse_bpf_access(int *out, struct inode *inode, int mask)
 
 #endif // CONFIG_FUSE_BPF
 
+long fuse_backing_ioctl(struct file *file, unsigned int command, unsigned long arg, int flags);
+
 int fuse_file_flock_backing(struct file *file, int cmd, struct file_lock *fl);
 ssize_t fuse_backing_mmap(struct file *file, struct vm_area_struct *vma);
 
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 8929dfec4970..d40dace24d2b 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -360,6 +360,15 @@ long fuse_ioctl_common(struct file *file, unsigned int cmd,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+#ifdef CONFIG_FUSE_BPF
+	{
+		struct fuse_file *ff = file->private_data;
+
+		/* TODO - this is simply passthrough, not a proper BPF filter */
+		if (ff->backing_file)
+			return fuse_backing_ioctl(file, cmd, arg, flags);
+	}
+#endif
 	return fuse_do_ioctl(file, cmd, arg, flags);
 }
 
-- 
2.44.0.478.gd926399ef9-goog


