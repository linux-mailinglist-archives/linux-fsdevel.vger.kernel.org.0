Return-Path: <linux-fsdevel+bounces-47271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE886A9B237
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C76541B8569B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3731DF97C;
	Thu, 24 Apr 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZa6MpPp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11F54315C;
	Thu, 24 Apr 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508519; cv=none; b=a1clfs6i6WCOzZCpWHo12ewEQwukM6aX10HkzOHpYa3fUZoaCGTu5lo8sJzA6/IuRdpXjOfcwFqtF4n+mGkicvAnQC5KeXuRau5x/ncN2gRBhSLkyHdp9+omt9kzHYBO1nv7zqs/pq7GS+fqPGl3tlpoeWeM/2GJ0TELryfqJjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508519; c=relaxed/simple;
	bh=7i67DHTTp0mD9qhweNExe/vd7EB2jhk7sH0q8SWYgGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBcRSsMTyZByVnKMzHlx3nQHEeY5mR5Zyh01FU/NR4ZdBvyeVAWcn7YgQEPAxJGGrySVePs85/mDkUt75zyKBTEYbA/9mjxIUz70G5O5FPnsCR7jyWU96VgeA3UcS7z46aLBQeQ2EhtznUWWEfztFvzVflKvOTR+gT5IRnc/vgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZa6MpPp; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c55500d08cso123660785a.0;
        Thu, 24 Apr 2025 08:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745508516; x=1746113316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hxUaLc+eAAOlr10PhVJK/e76IalwRfvS586Oa3BeZcE=;
        b=UZa6MpPpUUf6CIAP4OUYJFTU/f15c4LyeVd2hqjsLeh32z9mLIXFOa2PoFsDS837I+
         8z+/ST40n7WO4+JupU3tPVcjStWzrqOtX5xbzFQ3KAnHXKJYgzDVLU9cnNBvrYsoTtsB
         +dkxNVx3QNZPK35FGvMFbl2JA+iit2SpRPkxRimQevq8BYQMss7mnRf9VjlZnsNcEoG/
         krPcUNJRX6JIJKbKiQliKg+3WDVXFLQcoYNIyO3fgzOd58KE07IQWWVoJw8OQz5//dN6
         bbSczN6whInWa4KX4okQgG5llhXnSQM7Lfascwa1ddcgcIl8vPanI8rPAx/zQ8GIFPUl
         QQTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745508516; x=1746113316;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hxUaLc+eAAOlr10PhVJK/e76IalwRfvS586Oa3BeZcE=;
        b=gjPeW38+gNkwqOUvAN15hUG3MS4mvVNBHorpEXXLj2P3L4qbm3CnXnXt4ATkAHjrHQ
         RcC5k8zYdL2q8A4eXAKLbbBNG6RyppXBeYsboI+wpI+BGZJZiCIPTQNSwM2t4SyErtrX
         HXkff+Ngd55oF4O8W8bNKyZwdF7CznmK6c3EMGnZk/RaHlICdKM9oijVwNiqek710JP/
         e4FeLYGlQbO25APVfoq8c4tEvSzC3zC6AB1TAeQWufDlG6PMvsnAOqdYWUSoxpLW5I7u
         XTNYtZlZZsjiuPiHUTKoD9OnBuMVpDVcHzKWPzev1d5/sQJ5DxhiRcQjYHdgsIq1iGoa
         ktHw==
X-Forwarded-Encrypted: i=1; AJvYcCU/uPFP2jF2RunWORcbSnoS4KIvS49qQJ3Z92eG5r2RmNlrpavZmY8x3kDDyURRU+zNT7GpXYR33lDh4fY2@vger.kernel.org, AJvYcCUVRVuLYOPGmk1fjrdboznUSYsLx0z7RY8rv2e7MIM6GBT86rUgKlFxQddEu7Jl07wyqfqCvLrVOeKRBdT2@vger.kernel.org, AJvYcCX7K1AqMOnDaE/OBJLd7nyIrNnAoukq2xOBCJyKrNYjiRRbXWrwWD6kYJf4u9mss50sdSItbs+t2A==@vger.kernel.org, AJvYcCXUZqhgWaThiDghSHjo2w+UxRCK+bGv+nCCoy7AZZG8LNPNQze62aDdRbzDm3wQ70KS0Bm70aN2C9K7y5KmhTAIXgculxa1@vger.kernel.org
X-Gm-Message-State: AOJu0YzPHlBb/OMzWHXRoqgUN3OeHOCiCDF5LAtKmCgu79jcD1PwZCDw
	V0wajeP8HGDuteiWtV1rLVl6FXuyeluA3dBnX14jdme8erjwB+5OhVow02Q+
X-Gm-Gg: ASbGncuXhfFqvSKIniVs4W4fLw5mslHRaNaukx3t935ZBgboiv1dhTZRSH6gs+/+VJp
	DDb0MWAu6s3O9epxWUt/qZ0mfxAq2DQ4xucsFuHU4Ws9ADzNDg9/mK+xZNKsP2fu86/4kR1AuHd
	MKw6AKlIGAv5Z99dAWi2rtpYdJ5Voo/SMW5dXIFuMtIpkeD7CiAgDCgss31SgkHOJmi9/aHtijv
	eBAFz29P8sn30HKzHxrctogLA3AgYV4Izf5x2OxWtN1ptZmTmRFa3nXHMO1XlwEyuMqqRFJlJh6
	YBT3kpV+w7JgkdGMt1lPBOnBoSLAJ7Zci7ToPiGs+h0wAxlqdtzXR72K6xIIRKCqDWiFhtwOHOA
	VAi1g+5G/3/d5FUq7eNHRSK8gBy52rmLzMJxHX4um15768hTNjJ4HTUJEQiEwvz5WyzhI
X-Google-Smtp-Source: AGHT+IHuVep7wcdvkBt64FmXooKgNcSCpYuvYwk+/ttIsu2FF0Lr5ouXgL7PRcjfHKFl1Bw+Ee36aA==
X-Received: by 2002:a05:620a:4382:b0:7c9:50a6:8595 with SMTP id af79cd13be357-7c956f0026fmr485281385a.28.1745508516460;
        Thu, 24 Apr 2025 08:28:36 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c958c948a6sm99295085a.18.2025.04.24.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 08:28:36 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: 
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs/xattr.c: fix simple_xattr_list to always include security.* xattrs
Date: Thu, 24 Apr 2025 11:28:20 -0400
Message-ID: <20250424152822.2719-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vfs has long had a fallback to obtain the security.* xattrs from the
LSM when the filesystem does not implement its own listxattr, but
shmem/tmpfs and kernfs later gained their own xattr handlers to support
other xattrs. Unfortunately, as a side effect, tmpfs and kernfs-based
filesystems like sysfs no longer return the synthetic security.* xattr
names via listxattr unless they are explicitly set by userspace or
initially set upon inode creation after policy load. coreutils has
recently switched from unconditionally invoking getxattr for security.*
for ls -Z via libselinux to only doing so if listxattr returns the xattr
name, breaking ls -Z of such inodes.

Before:
$ getfattr -m.* /run/initramfs
<no output>
$ getfattr -m.* /sys/kernel/fscaps
<no output>
$ setfattr -n user.foo /run/initramfs
$ getfattr -m.* /run/initramfs
user.foo

After:
$ getfattr -m.* /run/initramfs
security.selinux
$ getfattr -m.* /sys/kernel/fscaps
security.selinux
$ setfattr -n user.foo /run/initramfs
$ getfattr -m.* /run/initramfs
security.selinux
user.foo

Link: https://lore.kernel.org/selinux/CAFqZXNtF8wDyQajPCdGn=iOawX4y77ph0EcfcqcUUj+T87FKyA@mail.gmail.com/
Link: https://lore.kernel.org/selinux/20250423175728.3185-2-stephen.smalley.work@gmail.com/
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 fs/xattr.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 02bee149ad96..2fc314b27120 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1428,6 +1428,15 @@ static bool xattr_is_trusted(const char *name)
 	return !strncmp(name, XATTR_TRUSTED_PREFIX, XATTR_TRUSTED_PREFIX_LEN);
 }
 
+static bool xattr_is_maclabel(const char *name)
+{
+	const char *suffix = name + XATTR_SECURITY_PREFIX_LEN;
+
+	return !strncmp(name, XATTR_SECURITY_PREFIX,
+			XATTR_SECURITY_PREFIX_LEN) &&
+		security_ismaclabel(suffix);
+}
+
 /**
  * simple_xattr_list - list all xattr objects
  * @inode: inode from which to get the xattrs
@@ -1460,6 +1469,17 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	if (err)
 		return err;
 
+	err = security_inode_listsecurity(inode, buffer, remaining_size);
+	if (err < 0)
+		return err;
+
+	if (buffer) {
+		if (remaining_size < err)
+			return -ERANGE;
+		buffer += err;
+	}
+	remaining_size -= err;
+
 	read_lock(&xattrs->lock);
 	for (rbp = rb_first(&xattrs->rb_root); rbp; rbp = rb_next(rbp)) {
 		xattr = rb_entry(rbp, struct simple_xattr, rb_node);
@@ -1468,6 +1488,10 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
 
+		/* skip MAC labels; these are provided by LSM above */
+		if (xattr_is_maclabel(xattr->name))
+			continue;
+
 		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
 		if (err)
 			break;
-- 
2.49.0


