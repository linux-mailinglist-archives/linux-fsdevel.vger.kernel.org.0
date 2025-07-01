Return-Path: <linux-fsdevel+bounces-53525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C62DAEFC59
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 16:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8B923A5022
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EB0275B07;
	Tue,  1 Jul 2025 14:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f92531qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90358275110;
	Tue,  1 Jul 2025 14:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380180; cv=none; b=LwmA0R+Pd+fZDaIqiLdVEewvH/X8tKhWR4SrMovwGRjT8h5nIAlriO8uCPz94d73JSVuBcCM6sSAJH5BnehpRm2nojhKDpje2tO/M7VqWY1KjMPkAVesuQ/SWMiXREGciPuZ6JVHW1wLZQZK3YENFTMK/nz7U4kPycnOaZPkOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380180; c=relaxed/simple;
	bh=u+7jLdaxklCNm99/QEJRzEh7lXDxhvWCt0GoeyHhj0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mV3DkYJvd0hpDeEGYY5ZQC8rKCkkl932D6aroxsiDLhqXI+PjbNZIyqqJ2F13Fn36+JoC1lW9Sw/iVNqtL0mdgc5TOwU6Znl143nUTXmff3RfdVjiRZRdzTMdTXbdp3ePf3d+gTVl20U7gyeh9wmi5R48totWuaV2IcS0DE/uSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f92531qi; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60768f080d8so7119933a12.1;
        Tue, 01 Jul 2025 07:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751380176; x=1751984976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7zowFqFPTLPJ5j2t4wBY1Xc+w1PTy87NaipT8Nx5uXk=;
        b=f92531qihAXTfcSYeKHpadhebN0b4LLERoNPRZzHQhDmvk8RDyQ69mLxk8kOrcQkeB
         FjLA6RwUoqH/PN2qpqbnMQWrld/Y0be04Ys+v46kGOFufKtTGEa9wL+sP7K/5As3AscY
         6VNieALj82o7zGT8ok0Tq8yfK/aqOigsFHZ8PSGcuoP8Mjxa1giBbea/k6YVzloNNoEg
         UqA0ZAr70YCyMZON5LgPJxcF2HZukqhYV+kp1po5WpJ+WSwtbhVRpH8Tlq6YPqUwvE4r
         /1OS/MOrezlsydYYjGxlOKqS++XHuRyjO+EzRl2lb/wr26XUGzUkzdorjrxXAMI2l/v3
         +Qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380176; x=1751984976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zowFqFPTLPJ5j2t4wBY1Xc+w1PTy87NaipT8Nx5uXk=;
        b=Vbucv6xGuD8NboHYpDikDD6+t3HCOQuUxJFHfXojDEq2xfyAB0RYC98e0wV8gq8WP8
         8//sGAyhTmJOs4H1Hu8+uiwUeiMVVB5YXCBp5Exe11+VFkz2ONsJ1jJC2Q1aRRdg8aiQ
         uxvzkiC+OG8FJWX4PSWi1ZSvsR/T/SxQJzVFKn+/XGghsOnwHPf3XiPGrCM2GsnoPkqU
         819UAXwi0vV9/VRGPm1Fnc8Gb81LSsngmgugG9E+32X5NGixkOm+pXCtavSOvdYf5HYO
         dNvWUEHSTkuEyoRFndrf5WjiHcTTPricxk50F5RxFiO9RK96qQrC+4Zsp4xFwh0KB3+s
         jYdw==
X-Forwarded-Encrypted: i=1; AJvYcCUYE6zMIffjPmySNQZJP+juz9vrePvKQOvacPrHSx++/wivO4luE7H46oNBtaikOyiEbKS9JhDUsutucoUDnw==@vger.kernel.org, AJvYcCWyEEuFGQgTBlnqmkfT1RtPvWXMsBWNWetteMx5vrSqE/kiDxr0bNe5/sQuhufALYh87dFr/jEh2mIWosA3@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc3RQZH3aB8ZpJB9vhLvbJNyhHR5vrpaXwesmOpJ2o6JBBnfdq
	useJ246klrkuAR+rSQXRo8nXSiC4x0TD5JrMruJzECeAorRDrHJOVNy1
X-Gm-Gg: ASbGnct5NRhWKhjhKU6Aru9P2ZaG4rKa0beyT+90AgQTVj2gcxUW31OLJG9DXcC4ne5
	KiY/f1yq4BhibRnfIYeBAWUqU8c9i4m1G65RViRKY30Mlr25nOAG4MbSKQwfJkAMWTace1uG25W
	JzPhSH8pqFnkIFBmasb0k5J++zqKDkIil+Bag/nWWNXbznsN/cg0wOG9wRzzjd1Zd1nJ89ADdh3
	NRLLUo0rptG21T6AYO9UAmKQyqiw7Xg3Y4WrzDRasxFyDyYozXL4Bza14yioAsY2+UaSRCagciq
	YkFWozJpHMbN77vfqcnFg1klHgaJx2p6TJBCCGicu+3jbG0EnvTjgJXuVzqWJ8Hmhg/2nuAaSJV
	o0wpwyxa0hIkpwWwSVS01xv/IDf29YNqSu7QrkA17BVQPj55urv2Z
X-Google-Smtp-Source: AGHT+IGeP014hPU9yFU9px0QE/pq6Jbx83QznLG5doaDAOjeHCG8b/Wy9tdiWLBXc57imezvKpVBGA==
X-Received: by 2002:a05:6402:2811:b0:601:f3f1:f10e with SMTP id 4fb4d7f45d1cf-60c88b280aamr15945734a12.5.1751380175228;
        Tue, 01 Jul 2025 07:29:35 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319fd60sm7434702a12.38.2025.07.01.07.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:29:34 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrey Albershteyn <aalbersh@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Subject: [PATCH] fuse: return -EOPNOTSUPP from ->fileattr_[gs]et() instead of -ENOTTY
Date: Tue,  1 Jul 2025 16:29:30 +0200
Message-ID: <20250701142930.429547-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As part of changing calling convenstion of ->fileattr_[gs]et()
to return -EOPNOTSUPP and fix related overlayfs code.

Fixes: 5b0a414d06c3 ("ovl: fix filattr copy-up failure")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

As part of Andrey's work on the new file_[gs]etattr() syscalls,
I noticed that we have this oddity in overlayfs copy up.

I think that overlayfs checks for -ENOTTY from the days that it called
vfs_ioctl() and we do not need that anymore, so I'd rather move the
conversion into fuse to align with the new vfs calling conventiions.

After the calling convention change, the conversion in
ovl_real_fileattr_get() is going to go away, so I've asked Christian
to apply this change with the file_[gs]etattr() syscalls series.

WDYT?

Thanks,
Amir.


 fs/fuse/ioctl.c        | 4 ++++
 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/inode.c   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 2d9abf48828f..f2692f7d5932 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -536,6 +536,8 @@ int fuse_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
 
+	if (err == -ENOTTY)
+		err = -EOPNOTSUPP;
 	return err;
 }
 
@@ -572,5 +574,7 @@ int fuse_fileattr_set(struct mnt_idmap *idmap,
 cleanup:
 	fuse_priv_ioctl_cleanup(inode, ff);
 
+	if (err == -ENOTTY)
+		err = -EOPNOTSUPP;
 	return err;
 }
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index d7310fcf3888..2c646b7076d0 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -178,7 +178,7 @@ static int ovl_copy_fileattr(struct inode *inode, const struct path *old,
 	err = ovl_real_fileattr_get(old, &oldfa);
 	if (err) {
 		/* Ntfs-3g returns -EINVAL for "no fileattr support" */
-		if (err == -ENOTTY || err == -EINVAL)
+		if (err == -EOPNOTSUPP || err == -EINVAL)
 			return 0;
 		pr_warn("failed to retrieve lower fileattr (%pd2, err=%i)\n",
 			old->dentry, err);
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6f0e15f86c21..92754749f316 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -722,7 +722,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
 
 	err = vfs_fileattr_get(realpath->dentry, fa);
 	if (err == -ENOIOCTLCMD)
-		err = -ENOTTY;
+		err = -EOPNOTSUPP;
 	return err;
 }
 
-- 
2.43.0


