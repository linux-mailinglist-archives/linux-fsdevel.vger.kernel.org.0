Return-Path: <linux-fsdevel+bounces-21757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DB09097B0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 12:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1ABE1F22039
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Jun 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67602381C2;
	Sat, 15 Jun 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EfxIYb2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68D282F4;
	Sat, 15 Jun 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718448045; cv=none; b=m1DsMEkMMT/fQxxYekoJrRIeQ7XSdo+Yyu+3kn+rqTwIeFikvDnsCEMzZb5oMh8ma41NLz7nDy/qLITl50wVXX7IpIcMOPwC9wCQ4zPWWtVG9WVRRAUR10b8RH99EZxfkLYP5sJuEcYWZ8S3DLPPGS9VlBeHqeaWBBtR3/afIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718448045; c=relaxed/simple;
	bh=SYCD/YytL7DNy0ZiT/i6N7krpIWCdNXkNVpVk5PYYZY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Rnh7HlWEbGRg+44a2xJwLfPCoj37lRm5TyB6lt8Tm06N1FjBtO4VxenuIrOOVNL0dOhdC6EMS/A77lkF15QGvIvNN8yO9a/JvA67LeE4xufqzPCiMZH4VlCPmaT3gHzdkXfsDWD3HCvRVq4Egz4SwbmrOyY7LmVCjYY9cCp5EuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EfxIYb2X; arc=none smtp.client-ip=203.205.221.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1718448029; bh=h9ZbyRutdPvXdDMjeryO2qN4mSr/s/9dQx1e05KXDDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfxIYb2XgKlK9s3CTJk/uXBPigDTcVNC4qapj9d+tPHRGNeuCI1YcXHqFdTOdbPeY
	 9pOxr9RgVg2uK3r1roxBjaKG4psQsd5zudKosdq5J3OHuinIB6QtSlDaFei/eTWb1w
	 Oo2rCkcqfF/ZMnlhw8Glx1bGcKEbaOGxQqN5H7eo=
Received: from ubuntu.. ([36.129.28.219])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 8971E254; Sat, 15 Jun 2024 18:34:23 +0800
X-QQ-mid: xmsmtpt1718447663taicd23gl
Message-ID: <tencent_31E8037EA823B9B4D69E390C7AA133257208@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iC64SrTxdBJ7xcvix4drRXcUkDnKmRiN44typURsqVRqgoOq+ol5
	 6cjQjwcnhsSFXuudR9m5O6InWdPlnVItxF1+JQ20jZa0oEKLKARuKAcuUGkwHmOneIg6hbou6skm
	 9VxTgVnMIwhds1x43mkSi/OwJ+uB3Na4r/KssdRbfbeFzqvQTpnpaI/CWXb9G8xAuSHC/yu52wTO
	 z0XhaLrwtz2NgSpeB8cJ1Rjwyt+SQAPwo9MQJqgVnaYPdJeY+xHDjOXeiFXOru4nxqUkg2jrO99c
	 q6NFhm2IY5LsT8roNw0yk3viimzmYpv7vD5JWutwfbX8tiJblxh3KulxO8N7OXmaQ9U2tdhaoVTN
	 uCMFaeNL5v8yj+ibkgGzPWqiqGJYFiwsyQKEV8/6U33K90qaBtu2jawwftHloxE31luuP/lPwONH
	 VlHHypYBgn592uhmy3+e2t6Ka6QhlXJmXRTG7LNkycQKxEK/taSemPehnmaFg8gy25xKS/P7M4WL
	 EUlEWUv4FzbQVzth4afXeSvv5N2Q5MYIl5BLeyF8SBSv6J+BhHW/ZHY0tz7v1AS82B3mAjYB3V/+
	 TS7HFJShrJE2q7ytDxdndocfA3VGL88luBzqQn2uy/LhdPh2pvlf2LW8MKxY0GzypVRUFaAqk+Ut
	 MM1LHTDSxz5n/47Awre7e3uq6SgiRHDhRfh0RQ38sCtqDndoW2rxars3XfLNr2KDWQrGXn1cn/74
	 MQBTNbeeHO1t5k4EiYawUMFX3V8HRyjQNZzBsYcbbqEt96CB6wiXz4OgV4m96ofqTr8JzaTDhHLp
	 hgdsb2WohYYhi3kJEYzksTkRJASH1EMpnIghcYfpVM+PRG5VuqjBca2QPpZmwO2O53qhzj7Yaun5
	 Fj/AszHKcv6hj8mbmZvrgmGo7836rqSU8SWDwtKR4gOX7RlF+d8a6+wVOaawAcBZNL3BoZmyc9l6
	 aU6RNMSl5ZDTdAYyqkxgTeUE0fjjzSvqtJpZeLF/Hsz6WYE8PPsfcze9TIvwd6nVCLBddxxanHqV
	 CdTLN2xQylkuiv6rLg
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Congjie Zhou <zcjie0802@qq.com>
To: zcjie0802@qq.com
Cc: brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3] fs: modify the comments in fs/namei.c
Date: Sat, 15 Jun 2024 18:34:04 +0800
X-OQ-MSGID: <20240615103404.28565-1-zcjie0802@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
References: <tencent_63C013752AD7CA1A22E75CEF6166442E6D05@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify the comments of serveral functions in fs/namei.c, including:
1. vfs_create()
2. vfs_mknod()
3. vfs_mkdir()
4. vfs_rmdir()
5. vfs_symlink()

All of them come from the same commit(6521f8917082 "namei: prepare for idmapped mounts")

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
 V1: modify the wrong comments of vfs_mkdir()
 V2: polish the comments
 V3: modify the wrong comments of other functions similar to vfs_mkdir()

 fs/namei.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa..65347dda7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3175,9 +3175,9 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
- * @mode:	mode of the new file
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child file
+ * @mode:	mode of the child file
  * @want_excl:	whether the file must not yet exist
  *
  * Create a new file.
@@ -3968,9 +3968,9 @@ EXPORT_SYMBOL(user_path_create);
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
- * @mode:	mode of the new device node or file
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child file
+ * @mode:	mode of the child device node or file
  * @dev:	device number of device to create
  *
  * Create a device node or file.
@@ -4095,8 +4095,8 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 /**
  * vfs_mkdir - create directory
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
  * @mode:	mode of the new directory
  *
  * Create a directory.
@@ -4177,8 +4177,8 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
 /**
  * vfs_rmdir - remove directory
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
  *
  * Remove a directory.
  *
@@ -4458,8 +4458,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
 /**
  * vfs_symlink - create symlink
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child symlink file
  * @oldname:	name of the file to link to
  *
  * Create a symlink.
-- 
2.34.1


