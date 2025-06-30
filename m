Return-Path: <linux-fsdevel+bounces-53384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E49A9AEE440
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 18:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2B257AE8BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 16:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C729550F;
	Mon, 30 Jun 2025 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSDXf2Bx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B66F292B24
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 16:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300441; cv=none; b=FcwAgFM4eq+fgWKQkc5ao/yfQA35Ud06terD6w+pbdrX90PHGRHXLHKR5V/VgM+sfzSIM+gDowaqZboX7bseXOok0e5dzSpbJ81wOvfjHT629ZDlExNPJnwmQ2Q5zB/0av0dn5ucjZlZR+C8vAMS+XGd5LVAgO8LKRDwZyBKq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300441; c=relaxed/simple;
	bh=IwADuJENyczf/bwBuYPIR4rrw/CJ1prOrfW5cqesY5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a8AE4MpAU2MtKN9Pye7Lewsj1NtjwEXxVtHKxsGHJW5X3SbbU+riSRZa4UbvkSdMGgOawe5JAW7bcSUd0Rb+sFAGhwVyACrfj8OEHQy/IXmSwjcRF3MUaSXeLYUW0piSvZ0x80vs+VyNNVTpVdhwjCRXdR5TYJLvAJ0Acke2Pzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSDXf2Bx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751300438;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlL+qFUOPnhKYJXl/arb34Hj2cUvdXFZcSDvCm6FshI=;
	b=BSDXf2BxDmQcbc7xit41eQGOXn+fKGfe+EPxnfMGAN3VnHL8atv13HOCdyoT7/X2QShq/3
	U0jLnmAawfv48Myg3gbz+WrAaoQQ6HqlNdK/f8X0mbWL1EssBpLmaIS37L+Ti5JRdZL3yJ
	OZhNxfobSIG12/gStkZBD5lYdx3U0Qc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-8HggiBmOO4GYS85Fz7ieqQ-1; Mon, 30 Jun 2025 12:20:36 -0400
X-MC-Unique: 8HggiBmOO4GYS85Fz7ieqQ-1
X-Mimecast-MFC-AGG-ID: 8HggiBmOO4GYS85Fz7ieqQ_1751300435
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4530ec2c87cso15205895e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 09:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751300435; x=1751905235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlL+qFUOPnhKYJXl/arb34Hj2cUvdXFZcSDvCm6FshI=;
        b=KTxfDQz4VsaeNX/bs0zswIIUErtGbXjzhqtWko8PZuqYa+0x0S9/SMvOxFgPHFuGHb
         qeQ+Pj7LKEOjyTbxm7gr1tOqMVkyrdP/Lk1gcknaQ3FGHYnKkrpB2zPCm8CthkO6myna
         yPpOvzljXeVThSc/MxYTXfpKBK1UuVzXotivPYog+CJWeW/uS4Zomfh3521hcAa+yOSu
         d53cl5qUBKJFpXqULfG+MieuUSuH4YB1fkhaWn9kdt3bLZTKigfnrbrlxGrG2/WxP7ux
         4jqfKoH/pVK3vUROSecXW/zd6Mht+NT7zaY9TDJ9MhecA67kwMDQo3/xQXE8GD1Q73Hu
         JegA==
X-Forwarded-Encrypted: i=1; AJvYcCUPmaUUqo4rIlkbgnnGqpgrjTGbBV30i0psZbEGC3fzf1zI51s/MOnICGJaDGr3j1Bc+gHcYkEk9BjKv4VX@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa0+mH4ppr4b5s5FBlXVzGRLmbQSP10lNG3OXB3pVcttJadINd
	aZCL9UqC2w/iA3BbaJknC4c7t4U72sUlcXQ8q1EraU1wG0a3Atc6KfHxXJC5ugXDv1P9ZcoSErC
	Cgb/LMri0nxIl9Sfl+dqMdY3mL9KeyL7qYU7cPhBb8n/gT76VvtUTjsD2fptirt+okQ==
X-Gm-Gg: ASbGncsE4p5IUM30uktNhoDViB1XbLmy4N3aPcmRDKhCJgTqhPHCTMVslZ6Y+pShmxu
	ExLY+6gYVyX7quTSCWYZhkDZC0xmaFINYRov13k/0Adbk1BfOEE8ovKORE4HjdgAmigS5tj40jF
	nSY9LXKXxhpmrORlBy+DIx4xC+A+0wW0H847ulE88IF2bEUaOyHhjvTuaK5RuOJrHQiWA81hP6k
	uh/CF5vOmPPAXQw2yWXhp/F1Hnb2fygHP87O+lXA1ghcUhEPadKCNvLBAidmRyvtoFzZtAXKl9T
	XE8qKgN/rKbqPiGZEu4Hy5EfSdX2
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr145675535e9.4.1751300434960;
        Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0mlgM2WuBIj0NGAO7JpYDWypMZ7nhIDOKUHExDDi9JTWtN36FkNXEpiG/WFqMOZqsmfA9XA==
X-Received: by 2002:a05:600c:4ed3:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4538f244121mr145675185e9.4.1751300434446;
        Mon, 30 Jun 2025 09:20:34 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538233c1easm168769245e9.3.2025.06.30.09.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 09:20:33 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 30 Jun 2025 18:20:14 +0200
Subject: [PATCH v6 4/6] fs: make vfs_fileattr_[get|set] return -EOPNOSUPP
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250630-xattrat-syscall-v6-4-c4e3bc35227b@kernel.org>
References: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
In-Reply-To: <20250630-xattrat-syscall-v6-0-c4e3bc35227b@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Casey Schaufler <casey@schaufler-ca.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
 selinux@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3358; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=IwADuJENyczf/bwBuYPIR4rrw/CJ1prOrfW5cqesY5Q=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMpJ2en+qD5NXqUucEMbfvf3H22r17tAf/0/fjdsaf
 U5u8crGl5s6SlkYxLgYZMUUWdZJa01NKpLKP2JQIw8zh5UJZAgDF6cATORUFiPD6u3Sewp/NG2b
 tVPL4QNj7k2l1J5t+vvM4lviFD/6OvFoMTLcKsnetPxBseFWzV/7Vhf92JD/dMKHlSE7FWuMv/1
 eZT2DHwBb9Uul
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

Future patches will add new syscalls which use these functions. As
this interface won't be used for ioctls only, the EOPNOSUPP is more
appropriate return code.

This patch converts return code from ENOIOCTLCMD to EOPNOSUPP for
vfs_fileattr_get and vfs_fileattr_set. To save old behavior translate
EOPNOSUPP back for current users - overlayfs, encryptfs and fs/ioctl.c.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/ecryptfs/inode.c  |  8 +++++++-
 fs/file_attr.c       | 12 ++++++++++--
 fs/overlayfs/inode.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 493d7f194956..a55c1375127f 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -1126,7 +1126,13 @@ static int ecryptfs_removexattr(struct dentry *dentry, struct inode *inode,
 
 static int ecryptfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	return vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
+	int rc;
+
+	rc = vfs_fileattr_get(ecryptfs_dentry_to_lower(dentry), fa);
+	if (rc == -EOPNOTSUPP)
+		rc = -ENOIOCTLCMD;
+
+	return rc;
 }
 
 static int ecryptfs_fileattr_set(struct mnt_idmap *idmap,
diff --git a/fs/file_attr.c b/fs/file_attr.c
index be62d97cc444..4e85fa00c092 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -79,7 +79,7 @@ int vfs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 	int error;
 
 	if (!inode->i_op->fileattr_get)
-		return -ENOIOCTLCMD;
+		return -EOPNOTSUPP;
 
 	error = security_inode_file_getattr(dentry, fa);
 	if (error)
@@ -229,7 +229,7 @@ int vfs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry,
 	int err;
 
 	if (!inode->i_op->fileattr_set)
-		return -ENOIOCTLCMD;
+		return -EOPNOTSUPP;
 
 	if (!inode_owner_or_capable(idmap, inode))
 		return -EPERM;
@@ -271,6 +271,8 @@ int ioctl_getflags(struct file *file, unsigned int __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (err == -EOPNOTSUPP)
+		err = -ENOIOCTLCMD;
 	if (!err)
 		err = put_user(fa.flags, argp);
 	return err;
@@ -292,6 +294,8 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 			fileattr_fill_flags(&fa, flags);
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
+			if (err == -EOPNOTSUPP)
+				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
@@ -304,6 +308,8 @@ int ioctl_fsgetxattr(struct file *file, void __user *argp)
 	int err;
 
 	err = vfs_fileattr_get(file->f_path.dentry, &fa);
+	if (err == -EOPNOTSUPP)
+		err = -ENOIOCTLCMD;
 	if (!err)
 		err = copy_fsxattr_to_user(&fa, argp);
 
@@ -324,6 +330,8 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 		if (!err) {
 			err = vfs_fileattr_set(idmap, dentry, &fa);
 			mnt_drop_write_file(file);
+			if (err == -EOPNOTSUPP)
+				err = -ENOIOCTLCMD;
 		}
 	}
 	return err;
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 6f0e15f86c21..096d44712bb1 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -721,7 +721,7 @@ int ovl_real_fileattr_get(const struct path *realpath, struct fileattr *fa)
 		return err;
 
 	err = vfs_fileattr_get(realpath->dentry, fa);
-	if (err == -ENOIOCTLCMD)
+	if (err == -EOPNOTSUPP)
 		err = -ENOTTY;
 	return err;
 }

-- 
2.47.2


