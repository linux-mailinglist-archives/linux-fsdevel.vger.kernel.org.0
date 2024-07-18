Return-Path: <linux-fsdevel+bounces-23947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E559350D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 18:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DFA2821AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Jul 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF45145336;
	Thu, 18 Jul 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="C0r8YI/f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1C3B784;
	Thu, 18 Jul 2024 16:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721321109; cv=none; b=OakChMDmIjnmgoquzFn+Fqhiq8GB711piG4G0QmTvY+oZNO3TczKr+ZvxbDG8j8fa0Xa1QhrlwdwJj//svyRN77m97aT5nAnn2qeMbilgMdsmZTTyuSnNeXWGFQ5Hc/S/UGhIsnmgAsQ3CsfrdUDJFPJSjeOTFUO76IZgDKM2RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721321109; c=relaxed/simple;
	bh=MH4Q4XVP/39bjBRKGYVnf68mFPvP2t7C9VKeg2k4XlY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Q3FuNA4Uc3smtcQ+NolJhwhMgZJsUNYGoFTYxUXe7mFz5Cl4TaTUmt+dPr7BmRYCCt/vOLMh+yBHPOlEnzumeRRY+fvKeOgR+fi1CMuL9lvIoGdB5FIFxp69CAgk+apefOiFj8Wfd8jGmpies7aNLiq2M38vm/DIPIW+DTelML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=C0r8YI/f; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1721320800; bh=069pD/YAJpfQ8jHaMRThKwpeiyzyE+NfLH9us2kGFnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C0r8YI/fbHI6J5vBnWJ+1ioNdVphtdLLL1M6E12q3hVVxMEfdGRWncSVjtW2yhLYN
	 KTDnnRPHr2KSvk5QmF6+iisQyZOeUFrFs1u3aVrmKahMusIrTPH44SvLYlSnyPWTMg
	 YnZA5sK86MiMsqYfvhppVVd0+I6BL9BnYGMcBOqA=
Received: from ubuntu.. ([175.167.155.224])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 6A9A8008; Fri, 19 Jul 2024 00:26:41 +0800
X-QQ-mid: xmsmtpt1721320001tea7nkyxk
Message-ID: <tencent_2FCF6CC9E10DC8A27AE58A5A0FE4FCE96D0A@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIe5TtchEP1Gp8rYBvef4royzorLuTkiPosYdx5ym8rPEm1qbY9oj
	 DsjTALFofYnriSpdeW8ItMrmpIpNBoDYUG0XGlGw6zH3jzt/FzxnB3GlFE+AzCJ3tkyiczSOkYPE
	 jLwR8HJXzupNi/t0w2x8kIpUHY6+UBPe6piGEW7wf3J6nDmQUd7o2sIW8uTuoPpMNlhQvzXmI4G7
	 8fgjlyzKO2MkF+oOfILbEA+8TGFDhslJXjWPTAyiLBhx8n3AjPrsYkceeVeF+i5J+7jIyIj0xJKA
	 zd9SwJmwFHE5qoZf5GPgvN7KGc4IOjpNAsTWOhQNZwL5zZnfdO8qSGE+DqD8oGhHCvsPHsb9cQyM
	 NMC7Q2TzrAQrUFp++Ny8Wg4smZ6I3UOKXF8c5SMyxJYd0ZSLd2gwwy6ysdFk40ol3U3c0cY5BUt6
	 Ok4FPGLBYSto8fYJXVjY3sJ0pI/ZSbowxI363j41Bi1/QJwsZxX/86RdJsBbpX2kybR3QZ1JpjXH
	 z/ItoRQzuROPHNkQb8gSTvvZPjuW5wxZ92zYYT0OU5S+3Issa+LnNBQ2T8yT0CQd77GbLz9oqbGK
	 o8M+hiePa/LoVlRFVcWfsWkfPpv3R0EjUomiwKbNW9Yv3sZPoe5fc4cxlY4n0TRUrf12Oaa0B7C6
	 xASl36oPoAtczpy2E4+JFvFub30A+N+b+/cU6fAKyDrGdToIt3rZDRQkYivdENZwrPogRT9gD+mh
	 sVXs2LGrLvMoBSAc/yf9W7N0hGDqEuSxmtV8TskkQs95vjZUbGawHTtJfFhTv3MRPNoUutaxsJfy
	 0QoDAJLqbpOZcsQnoZfgtb+VI8tQqnZfP1kYljO2YLq3JYuKy6swPZfo5zCg3b2/nZb1BsR6NOTE
	 RYQQwmJjg9z4P2DM3d+uKmXdVxzAqxVUltvT3Lzkm7X2cwNGXxaBP8VICbCCI3zpriwxDMDuu9xZ
	 VPZ70PpXyazaWEH/pL6vHeGEfaUn5F24NUDbe49eWlv+jRSPNE/Hw8UOhxxKvniYCmBfZasFY=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Congjie Zhou <zcjie0802@qq.com>
To: linux-kernel@vger.kernel.org
Cc: zcjie0802@qq.com,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz
Subject: [PATCH v4] vfs: correct the comments of vfs_*() helpers
Date: Fri, 19 Jul 2024 00:25:45 +0800
X-OQ-MSGID: <20240718162545.11435-1-zcjie0802@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com>
References: <tencent_3A7366F414667EE52C073850077331ADC709@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

correct the comments of vfs_*() helpers in fs/namei.c, including:
1. vfs_create()
2. vfs_mknod()
3. vfs_mkdir()
4. vfs_rmdir()
5. vfs_symlink()

All of them come from the same commit:
6521f8917082 "namei: prepare for idmapped mounts"

The @dentry is actually the dentry of child directory rather than
base directory(parent directory), and thus the @dir has to be
modified due to the change of @dentry.

Signed-off-by: Congjie Zhou <zcjie0802@qq.com>
---
It has been more than one month since my last email but no response, 
so I make some changes and resend it.

 fs/namei.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3a4c40e12..5512cb10f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3248,9 +3248,9 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
@@ -4047,9 +4047,9 @@ EXPORT_SYMBOL(user_path_create);
 /**
  * vfs_mknod - create device node or file
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
- * @mode:	mode of the new device node or file
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child device node
+ * @mode:	mode of the child device node
  * @dev:	device number of device to create
  *
  * Create a device node or file.
@@ -4174,9 +4174,9 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 /**
  * vfs_mkdir - create directory
  * @idmap:	idmap of the mount the inode was found from
- * @dir:	inode of @dentry
- * @dentry:	pointer to dentry of the base directory
- * @mode:	mode of the new directory
+ * @dir:	inode of the parent directory
+ * @dentry:	dentry of the child directory
+ * @mode:	mode of the child directory
  *
  * Create a directory.
  *
@@ -4256,8 +4256,8 @@ SYSCALL_DEFINE2(mkdir, const char __user *, pathname, umode_t, mode)
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
@@ -4537,8 +4537,8 @@ SYSCALL_DEFINE1(unlink, const char __user *, pathname)
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


