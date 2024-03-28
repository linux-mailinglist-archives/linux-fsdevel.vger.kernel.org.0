Return-Path: <linux-fsdevel+bounces-15615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5756E890C17
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 21:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57851F2321F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6218B13A3E6;
	Thu, 28 Mar 2024 20:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xva8o5Ou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C2E380
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659521; cv=none; b=XH3DH+4VkqAtEmVqzUE3LL2siErNEZj0Bnb97h/oiOssM0WjLU+iFhdmZehjlWfRO4eW4iWL2f6l13iZNxhHH35/D+fAELPHLerGgLcHdqaqe9bvsi9Gki65DA1rsTDH9DjDyaQA314c7ufmDMHJ/AnQhQnZt1taTtWF1v5qp7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659521; c=relaxed/simple;
	bh=Akavoa5LHiiagv4HNjsJzlvrb9cJAQAAPc2LoX8wx+c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eHKeQp9RRpLPSDkYBR7rsH+QmU3dus0wuszNWMIdgZMMn13xC24gDqgfv9aKj3qk40fqoAvw/O24o1t2Vxt6Yk4yz081X2F6CWLrQnq8sPdnvorhIApZFoM6i3TzWH0NnDMXI3UimhKX7fxMA+rc6by3sbAUYLp0r3LyX8VfjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xva8o5Ou; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--richardfung.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a54004e9fso25796617b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 13:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711659519; x=1712264319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quYoINDaexYeo9/4iduArYsc1a+H7thslsKFbNontv4=;
        b=Xva8o5OukrwJJMz82fSiw1OviEOV9gctsZ90hfmyUyu5TPBVT/7t2kdeValakCEjZ2
         g8wJchU8meZHcPspKSXiAPHsg6UNhgEGNQZMctAQGS2W0gK7Ct4HHY/0xh1lpXajepJq
         XEBa4ZQ0GO7TspJodzqCISTjxuFpi8+GIufWWDA6gF2fHIcb+2bsltlInJyHUOlo9KAc
         XdGC6qn54ayjkKQgLKTnbusME6W637tZjYfF78DRCE0QENOXNRWpS/snYQ/w2TsIgq5+
         q+w/6hdXo8F9cLC1mYLcZnqgxXjmNSHzqqWRzL9shDpXIpuJ/6CaMlf6tIzctZl5lGVD
         d7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659519; x=1712264319;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=quYoINDaexYeo9/4iduArYsc1a+H7thslsKFbNontv4=;
        b=BeoLycDxCUJ1vuCLH9mTvwQznc5ZUWFTYyipgiknwVxK7VTsC4+XPkkMZ1zDKmmVYq
         NwpGxSfz+3rSHcxhS4nFdSuR3zv3rkEQbdn3qUrCJIA47MrfiRIh8wtSeA1W/MzzeciX
         mKcRw3eA5aZEbOy/CczyWE4a0LZ/nF+wYiLayCFjCVbV0mQefN4BW6YyPUKOZ1uoSzHn
         PpJ8v/SK3dHS7EhMINHnaN3xSlDstGnl02pbMTnkuqIr7by9/YLo1VMAOYculxSpKLFN
         atCXkqZ4Y0Hirfrm9wF6tcPRfKsmqEoRiEtLnH+QsOgJLefuUlPoMsbvgiHYfcwHLKKt
         20hA==
X-Gm-Message-State: AOJu0YySgSpJz8y6oKmxiYRNM/8KM4EG+4tWaFKBQBTtQovx4c6ttg6w
	DVDHQtsm9JCTd1LMIuRkWGkGRQghSJ8KBC8DkbmTxgCj311PuvFFirUuEH2q83T3+amVjpNe+ZJ
	hPonXSAhsSohkwuEcEXF6jg==
X-Google-Smtp-Source: AGHT+IGQ86jqI1CsxbIQBoT2xtF87ijB1o+TYc1weMqmh/kTvyb6kxNcptf0PSRI7aIJdwQ0z4ClvPVn2xTBK8JGJw==
X-Received: from richardfung.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2a5c])
 (user=richardfung job=sendgmr) by 2002:a0d:e652:0:b0:611:5f93:12bb with SMTP
 id p79-20020a0de652000000b006115f9312bbmr142502ywe.5.1711659519362; Thu, 28
 Mar 2024 13:58:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 20:58:22 +0000
In-Reply-To: <20240328205822.1007338-1-richardfung@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240328205822.1007338-1-richardfung@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240328205822.1007338-2-richardfung@google.com>
Subject: [PATCH 1/1] fuse: Add initial support for fs-verity
From: Richard Fung <richardfung@google.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, Richard Fung <richardfung@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This adds support for the FS_IOC_ENABLE_VERITY and FS_IOC_MEASURE_VERITY
ioctls. The FS_IOC_READ_VERITY_METADATA is missing but from the
documentation, "This is a fairly specialized use case, and most fs-verity
users won=E2=80=99t need this ioctl."

Signed-off-by: Richard Fung <richardfung@google.com>
---
 fs/fuse/ioctl.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 726640fa439e..a0e86c3de48f 100644
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
@@ -227,6 +228,57 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd=
, unsigned long arg,
 			out_iov =3D iov;
 			out_iovs =3D 1;
 		}
+
+		/* For fs-verity, determine iov lengths from input */
+		switch (cmd) {
+		case FS_IOC_MEASURE_VERITY: {
+			__u16 digest_size;
+			struct fsverity_digest __user *uarg =3D
+		(struct fsverity_digest __user *)arg;
+
+			if (copy_from_user(&digest_size, &uarg->digest_size,
+						 sizeof(digest_size)))
+				return -EFAULT;
+
+			if (digest_size > SIZE_MAX - sizeof(struct fsverity_digest))
+				return -EINVAL;
+
+			iov->iov_len =3D sizeof(struct fsverity_digest) + digest_size;
+			break;
+		}
+		case FS_IOC_ENABLE_VERITY: {
+			struct fsverity_enable_arg enable;
+			struct fsverity_enable_arg __user *uarg =3D
+		(struct fsverity_enable_arg __user *)arg;
+			const __u32 max_buffer_len =3D FUSE_MAX_MAX_PAGES * PAGE_SIZE;
+
+			if (copy_from_user(&enable, uarg, sizeof(enable)))
+				return -EFAULT;
+
+			if (enable.salt_size > max_buffer_len ||
+		enable.sig_size > max_buffer_len)
+				return -ENOMEM;
+
+			if (enable.salt_size > 0) {
+				iov++;
+				in_iovs++;
+
+				iov->iov_base =3D u64_to_user_ptr(enable.salt_ptr);
+				iov->iov_len =3D enable.salt_size;
+			}
+
+			if (enable.sig_size > 0) {
+				iov++;
+				in_iovs++;
+
+				iov->iov_base =3D u64_to_user_ptr(enable.sig_ptr);
+				iov->iov_len =3D enable.sig_size;
+			}
+			break;
+		}
+		default:
+			break;
+		}
 	}
=20
  retry:
--=20
2.44.0.478.gd926399ef9-goog


