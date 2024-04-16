Return-Path: <linux-fsdevel+bounces-17001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C48A5F24
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 02:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C1FF281846
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 00:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461AA816;
	Tue, 16 Apr 2024 00:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GtDRPPde"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB717E
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Apr 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713226680; cv=none; b=M9PzItVX7eCmOeLPbMfOVvGIDStorc+t9zsifT0rXAEP8xK/b4CB/wMAdnZ8pTcO8LVr4P1IkYmqfwA2+SIm9O9loNAC97y8Q5eklvIU7kB7qlIDjmcbPkk88Em2OJnNTvOlXN1YKRuTg4bIJk8RWaobrgf/97gX6v7lGho80xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713226680; c=relaxed/simple;
	bh=3/B7vWRvtl8aIFH3hKbhQRfODs9XZZsKXmwpTHvU13w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Oo73mY1I8m/D95rrQ2OC96r8nd55P5/LXRbvLTm2Zoo3j/954qcuaQTGrRYNfT9Jh0IVOaAW1EjbRV7YWs+1HN+6/CTa3GWGc/SHCkZWe63rFClbvEBw9V/We8WwCFabVjimKYHH07H4O6TW3+B1T5GW7CcnHDFJIhahz8jZyuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GtDRPPde; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so6878222276.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Apr 2024 17:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713226678; x=1713831478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDPBbN30ZyY8UoIY8djlTeTTFaUIobcz6dPBP5TgibQ=;
        b=GtDRPPdem0XsBnL8eoI0MT+wVkrLoGT6pas4rDA/VBhY0ZFM630vG4OKq7C846BLnb
         8/+0kvVTx7nija4ezjCMKxeXVd/yKcnHbqXJ+V3sFzvZZeQnA1pQyxysReky6ebvGKHG
         QpjfuAqE9Da1fBjGSNvMCaYfLAOAaqEYbi9oqwGM7S+ypMuUZqZwzdM1tuHnLysywgFp
         MWMxAqCL8HIsExzpHVW3FPNKyG+bf92+rWubrlDsLz+HBk3lOn2M7/c69CuwfpXXCxI7
         IRdUzUuURdQJcaDOXZhG++wcLG9M4ABgchQ/o1GMoorUviByUJIj1FLsmTJBao54b3wj
         8r8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713226678; x=1713831478;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NDPBbN30ZyY8UoIY8djlTeTTFaUIobcz6dPBP5TgibQ=;
        b=kPPp1As6ro0WOhBW2qYt4jzsZutZYU8RFt3QRt44cH7BdqIrsj4L7OPC9RApcIWALe
         NM48iHlciLGjnAiDAZ2rdqyOWlrMFY7uaIMhfQrcfwu02KDLpp6WkWXMstDKsNdGRxrc
         DGdzjPkov8jkoJSMPPa6lMsGv+xgYC2RTqBT+Xiy5wrylLjd915EfAC/PJzdSIYP1f5N
         uKTR9Da6DN6rg7hhPDV+f+YfhBSTaYvazvVH+4XcEXDvQY5Bzw7qSJtLGV7C8Lyl7yss
         nxlaO2CbSDOHjkLpEEbb44HTL8IPg2cfx2pyREOmXE+s925bzExbsKnhs1EU3T87ykM1
         FNCw==
X-Gm-Message-State: AOJu0Yxgme1q0wrhhp69JTtju5KV4hSgWkhQj/GwiLO8Oo4QOp44TJtU
	kSdSuHdC+4pihTOmzZZySzuABxNg+w5G6PH0WeRSfsNDiusogSJ8LvHwjm39FQXNPKPoY9v6mkA
	/+gRZMudpQrSC4itOn9PA6Q==
X-Google-Smtp-Source: AGHT+IEFs8S7fF1QpMnQnAC+kmqFQmfo80Y1WQ0kEcu5yg8AmrzI1xpvYGzVs0pY7o3M8wl96F5ZI35J1UHXIXplQg==
X-Received: from richardfung.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a5c])
 (user=richardfung job=sendgmr) by 2002:a05:6902:709:b0:dcc:50ca:e153 with
 SMTP id k9-20020a056902070900b00dcc50cae153mr3880572ybt.7.1713226678341; Mon,
 15 Apr 2024 17:17:58 -0700 (PDT)
Date: Tue, 16 Apr 2024 00:16:39 +0000
In-Reply-To: <20240328205822.1007338-1-richardfung@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240416001639.359059-1-richardfung@google.com>
Subject: [PATCH v2] fuse: Add initial support for fs-verity
From: Richard Fung <richardfung@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, 
	fsverity@lists.linux.dev, ynaffit@google.com, 
	Richard Fung <richardfung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This adds support for the FS_IOC_ENABLE_VERITY and FS_IOC_MEASURE_VERITY
ioctls. The FS_IOC_READ_VERITY_METADATA is missing but from the
documentation, "This is a fairly specialized use case, and most fs-verity
users won=E2=80=99t need this ioctl."

Signed-off-by: Richard Fung <richardfung@google.com>
---
 fs/fuse/ioctl.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 726640fa439e..01638784972a 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -8,6 +8,7 @@
 #include <linux/uio.h>
 #include <linux/compat.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
=20
 static ssize_t fuse_send_ioctl(struct fuse_mount *fm, struct fuse_args *ar=
gs,
 			       struct fuse_ioctl_out *outarg)
@@ -118,6 +119,63 @@ static int fuse_copy_ioctl_iovec(struct fuse_conn *fc,=
 struct iovec *dst,
 }
=20
=20
+/* For fs-verity, determine iov lengths from input */
+static long fuse_setup_verity_ioctl(unsigned int cmd, unsigned long arg,
+				    struct iovec *iov, unsigned int *in_iovs)
+{
+	switch (cmd) {
+	case FS_IOC_MEASURE_VERITY: {
+		__u16 digest_size;
+		struct fsverity_digest __user *uarg =3D
+				(struct fsverity_digest __user *)arg;
+
+		if (copy_from_user(&digest_size, &uarg->digest_size,
+				sizeof(digest_size)))
+			return -EFAULT;
+
+		if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
+			return -EINVAL;
+
+		iov->iov_len =3D sizeof(struct fsverity_digest) + digest_size;
+		break;
+	}
+	case FS_IOC_ENABLE_VERITY: {
+		struct fsverity_enable_arg enable;
+		struct fsverity_enable_arg __user *uarg =3D
+				(struct fsverity_enable_arg __user *)arg;
+		const __u32 max_buffer_len =3D FUSE_MAX_MAX_PAGES * PAGE_SIZE;
+
+		if (copy_from_user(&enable, uarg, sizeof(enable)))
+			return -EFAULT;
+
+		if (enable.salt_size > max_buffer_len ||
+				enable.sig_size > max_buffer_len)
+			return -ENOMEM;
+
+		if (enable.salt_size > 0) {
+			iov++;
+			(*in_iovs)++;
+
+			iov->iov_base =3D u64_to_user_ptr(enable.salt_ptr);
+			iov->iov_len =3D enable.salt_size;
+		}
+
+		if (enable.sig_size > 0) {
+			iov++;
+			(*in_iovs)++;
+
+			iov->iov_base =3D u64_to_user_ptr(enable.sig_ptr);
+			iov->iov_len =3D enable.sig_size;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+	return 0;
+}
+
+
 /*
  * For ioctls, there is no generic way to determine how much memory
  * needs to be read and/or written.  Furthermore, ioctls are allowed
@@ -227,6 +285,12 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd=
, unsigned long arg,
 			out_iov =3D iov;
 			out_iovs =3D 1;
 		}
+
+		if (cmd =3D=3D FS_IOC_MEASURE_VERITY || cmd =3D=3D FS_IOC_ENABLE_VERITY)=
 {
+			err =3D fuse_setup_verity_ioctl(cmd, arg, iov, &in_iovs);
+			if (err)
+				goto out;
+		}
 	}
=20
  retry:
--=20
2.44.0.683.g7961c838ac-goog


