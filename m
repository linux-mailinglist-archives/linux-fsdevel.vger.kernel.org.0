Return-Path: <linux-fsdevel+bounces-21944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E3390FBA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 05:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0EC282DEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 03:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD041EA91;
	Thu, 20 Jun 2024 03:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aO6OxvGe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BED4DDBB
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718853835; cv=none; b=D3O97hcyg+pPBCVQ0yE4PUzJosfwMeJkxBMhoFJX6m5C+7kb0lBk6fzvOIpokuKa0kffXRMyY+YqyewBGLanNKjR9DaQ2qXKU2RbDLzl7ZidXAC4deOxqtaNxaEUmbjnmGtqDTkrrhkOWBWtUCItFB9j0GFCwbP+zaWOVCFv+Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718853835; c=relaxed/simple;
	bh=XFcBbVLb/moX1F1VBE8Xzahn5thGytFy/GXt7dbbMFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E+Pdn7Xd9rVFj61kN9oPSGpv5NIvxZl3yzUqJfb7Ib9ZPj4HRUCqxtr6b0/h3WBOr6ixt1laJKQ0YzBWobitmBUMOMCE4dtzJZTV9MzTrwETLhS51qcPUCmNGU8cqonEduOpu6dcGbO0bsMbUOLPbm5qA2qggU6hyslJEkB8RRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aO6OxvGe; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: viro@zeniv.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718853831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U4hYVIA6yQ2MONsCKt5U/6Cm9Ie2DwTEa6j9RLjLJdo=;
	b=aO6OxvGeYfmnteld4qR4vHnaEEGayn2lxvfnyqniovj11v36kzQfepm/BgRH7Om9UggVDF
	fj+V5+9LdCLt/XqjCrk9qRdvZvcNFhpiL/JpvW4RUd0uOevUJVdSxrS2rcVdrp7aBlJplg
	LjDONSu94rKyMyNh0rkXJW3wrD8At38=
X-Envelope-To: brauner@kernel.org
X-Envelope-To: jaegeuk@kernel.org
X-Envelope-To: chao@kernel.org
X-Envelope-To: miklos@szeredi.hu
X-Envelope-To: jack@suse.cz
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-f2fs-devel@lists.sourceforge.net
X-Envelope-To: youling.tang@linux.dev
X-Envelope-To: tangyouling@kylinos.cn
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Youling Tang <youling.tang@linux.dev>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	youling.tang@linux.dev,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH 1/3] fs: Export in_group_or_capable()
Date: Thu, 20 Jun 2024 11:23:33 +0800
Message-Id: <20240620032335.147136-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Export in_group_or_capable() as a VFS helper function.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/attr.c          | 2 --
 fs/inode.c         | 1 +
 include/linux/fs.h | 2 ++
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 960a310581eb..825007d5cda4 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -17,8 +17,6 @@
 #include <linux/filelock.h>
 #include <linux/security.h>
 
-#include "internal.h"
-
 /**
  * setattr_should_drop_sgid - determine whether the setgid bit needs to be
  *                            removed
diff --git a/fs/inode.c b/fs/inode.c
index 3a41f83a4ba5..e0815acc5abb 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2538,6 +2538,7 @@ bool in_group_or_capable(struct mnt_idmap *idmap,
 		return true;
 	return false;
 }
+EXPORT_SYMBOL(in_group_or_capable);
 
 /**
  * mode_strip_sgid - handle the sgid bit for non-directories
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 0283cf366c2a..c375a4af7b11 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1926,6 +1926,8 @@ void inode_init_owner(struct mnt_idmap *idmap, struct inode *inode,
 extern bool may_open_dev(const struct path *path);
 umode_t mode_strip_sgid(struct mnt_idmap *idmap,
 			const struct inode *dir, umode_t mode);
+bool in_group_or_capable(struct mnt_idmap *idmap,
+			 const struct inode *inode, vfsgid_t vfsgid);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.34.1


