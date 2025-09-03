Return-Path: <linux-fsdevel+bounces-60091-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D91AAB413F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34A735417B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23002D9EF8;
	Wed,  3 Sep 2025 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hiEE2GIh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDE2D8395
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875350; cv=none; b=mXKMnHFBrIBtdfT7ryJhQKLuRBfrS7kTV6zyTLAu5FcucDqV93gO+MtvtqDD6aEKrIun/ze+IPeFcrU6bi7vhMRx2CXeH17q22ZVHHcq+BhRvifOaB1Q5v+PVAxrLMbrNb9jGdSEw0T/eGlq2FZck4PrD3fRdsHpnftSao0fSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875350; c=relaxed/simple;
	bh=bePqZV/H069gwE4lSt/odTDyhnTOIgQ/+x7on2HLHqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxVATVTyfFtlbd+i3dDCAkf7Px2ik8LpJXqqai+Zh/OanamQYVxy/E+sDYEDiHix/sO7BUmL/nKc6waxCZinElnz8tbNmkhNpaJ2KejH+LVmqekBjkgVw+RrsiB7UsRhwYUI0XjAn17muqTzlCirRDiLs/+PMGKTaU1NsdZxYf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hiEE2GIh; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=cUoocGaUYyzlk1CrasB5Xis0PUs0198KolDlme3tVEs=; b=hiEE2GIhh9FDe1iXCmFC+9hTQP
	MrjfSG0o7aj4i94WFiJxaWGfCI3xJNFjPAKHTo3e5aCYvsu2hHuM5D3H6Eh02AWvJT7q/iDPW/fyo
	5IpY1D6bs03mXNzmyJwuqUM+Dn1Ylc+//3DI6R8RL7fffUDWx58Rp85E/MzxBPsAC//WPMSrWTfMH
	PCPlQurTyWPFjTNAv+ook2gWSOogT7ptJzQyeNaGmrMpvSnQDtIxOHZeWxZWb09IRpm82gQoMkfOC
	v61HrRoIQ44H7WrcnFEF+I0C0V5cjDjnW1wa1+4ystAsB7X7zWBXyGe9Okj6jY5UlZd6Dphff3KZD
	qulKzUBQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX8-0000000ApDb-00SG;
	Wed, 03 Sep 2025 04:55:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 45/65] path_mount(): constify struct path argument
Date: Wed,  3 Sep 2025 05:55:07 +0100
Message-ID: <20250903045537.2579614-46-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

now it finally can be done.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/internal.h  | 2 +-
 fs/namespace.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 38e8aab27bbd..fe88563b4822 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -84,7 +84,7 @@ void mnt_put_write_access_file(struct file *file);
 extern void dissolve_on_fput(struct vfsmount *);
 extern bool may_mount(void);
 
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
diff --git a/fs/namespace.c b/fs/namespace.c
index 894631bcbdbd..3a9db3e84a92 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4018,7 +4018,7 @@ static char *copy_mount_string(const void __user *data)
  * Therefore, if this magic number is present, it carries no information
  * and must be discarded.
  */
-int path_mount(const char *dev_name, struct path *path,
+int path_mount(const char *dev_name, const struct path *path,
 		const char *type_page, unsigned long flags, void *data_page)
 {
 	unsigned int mnt_flags = 0, sb_flags;
-- 
2.47.2


