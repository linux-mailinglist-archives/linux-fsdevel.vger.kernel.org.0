Return-Path: <linux-fsdevel+bounces-27262-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C13D95FE82
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ED021C21D4A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 01:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AF7BE5D;
	Tue, 27 Aug 2024 01:47:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03918610C;
	Tue, 27 Aug 2024 01:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723276; cv=none; b=JoAz2c+BVEzzGai/WpbJQl9MIab20YtHz0I7mRVe/Z+knTRGAPSgHC9t+uvk7AfaZW1DlSpjpyII3g029WRH3EDVSMek4b6lPL/IKhlYK3Hja6X4UN3BXwCD2RbgxvnRtpeHx9b2mCikNuZTmMgqP95y+wCasxCeKThYKG5JSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723276; c=relaxed/simple;
	bh=dUYOEsfWMAnkyWo+0wuhDOTGO5LAekCPcNa/tcFXLew=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l82IknbBg2SHmSKzu/2WjhEfyBBviJ0URtRU56Q74BZ50fjvaYvlZ8M9q/C42Hsb8TfJknVPpf3Xr+VqNpB5hZx/3FQX4ZxrBxHpCH+pLKgRG4remIonWajFDyHZztuQL2kWGGmbxDsOcF9jRJj22tETLIPNtjQOxg1IJtA3aLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wt9Qv3sNGz1S95q;
	Tue, 27 Aug 2024 09:47:35 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id A8ABA1A016C;
	Tue, 27 Aug 2024 09:47:45 +0800 (CST)
Received: from huawei.com (10.67.174.162) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 27 Aug
 2024 09:47:45 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <brauner@kernel.org>, <jack@suse.cz>, <viro@zeniv.linux.org.uk>,
	<gnoack@google.com>, <mic@digikod.net>
CC: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
	<lihongbo22@huawei.com>
Subject: [RFC PATCH] fs: obtain the inode generation number from vfs directly
Date: Tue, 27 Aug 2024 01:41:08 +0000
Message-ID: <20240827014108.222719-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500022.china.huawei.com (7.185.36.66)

Many mainstream file systems already support the GETVERSION ioctl,
and their implementations are completely the same, essentially
just obtain the value of i_generation. We think this ioctl can be
implemented at the VFS layer, so the file systems do not need to
implement it individually.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/ioctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 64776891120c..dff887ec52c4 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -878,6 +878,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
 	case FS_IOC_GETFSUUID:
 		return ioctl_getfsuuid(filp, argp);
 
+	case FS_IOC_GETVERSION:
+		return put_user(inode->i_generation, (int __user *)argp);
+
 	case FS_IOC_GETFSSYSFSPATH:
 		return ioctl_get_fs_sysfs_path(filp, argp);
 
@@ -992,6 +995,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 		cmd = (cmd == FS_IOC32_GETFLAGS) ?
 			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
 		fallthrough;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		fallthrough;
 	/*
 	 * everything else in do_vfs_ioctl() takes either a compatible
 	 * pointer argument or no argument -- call it with a modified
-- 
2.34.1


