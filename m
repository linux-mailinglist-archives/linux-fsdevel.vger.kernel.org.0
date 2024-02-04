Return-Path: <linux-fsdevel+bounces-10207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A20848A98
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 03:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219D528772C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Feb 2024 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1846110A1E;
	Sun,  4 Feb 2024 02:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AZCOjPLC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2B749C;
	Sun,  4 Feb 2024 02:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707013065; cv=none; b=jfLvxtTpc6wWAPQCaFJHwQBPXlmgwHTynKLLVJHED+eo70cVw1n/fYZfJJhlRP/WOmqhvEvx5XXALi2DzZ4k3/REpawENCsp2/VyFCB8y/KyxfCapT+7Qov/oX1ATm5LYRDGpTBS+Fac1uCkSdM+ZIW+9db+5vSri6dGW+acatQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707013065; c=relaxed/simple;
	bh=gXEyVGfpVHTOGscWWhhgTHNWTU3KHsLHDUa7ooHXJ5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KVOcfaACsb3SCUT9GSk7g9N7fyNSzlV7nHvR6f2ljwjj4yEuMvf2O3BQERIVmWf7AB+wFtF0NFJpQlaxesCZQgAFC+Iwb69e5NUCx3AR/3B6kwVIQhKzcQO+ZOKkflrx4J76RFh0Pr6weRRLj+PrxtSldHcsofpRvgA3qF6xbLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AZCOjPLC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=iVQFpkDCs9bj7WoZx+TN7eoBXzYpcdd2k1cx6KhK2YE=; b=AZCOjPLCvnzbtVNGM2vVDCasqK
	x2oOq7AbqjQtdx49CbQbf3ISp5j4Qjov/GCNC9krD+rtADL0gq4WJa6RtZDJnrwZi6CoszxXme8V1
	9lsLsLsYd/Uyi09TVPGmavjzvmZ5f7wUu/Qdt4FRfjXBLGZ8cwe8MlBWDYdmBJ8v5xJM/hk8MNFrZ
	fTImNAv++iorzdLcnASa8Iu39QmdHty+M+wvWFHQXsib4yViHV/GrchrzNbLYduCYN/MGYg0C1KkA
	X7GIedptDhXNj+CL9F6y4Mf0WLhWdo3H1Zhoe2eTgE+VlqdZZfAX+PLi/NGJ95aBojiuNI2No5CYz
	beFWXBjw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rWS4j-004rDi-2X;
	Sun, 04 Feb 2024 02:17:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-cifs@vger.kernel.org
Subject: [PATCH 12/13] cifs_get_link(): bail out in unsafe case
Date: Sun,  4 Feb 2024 02:17:38 +0000
Message-Id: <20240204021739.1157830-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

->d_revalidate() bails out there, anyway.  It's not enough
to prevent getting into ->get_link() in RCU mode, but that
could happen only in a very contrieved setup.  Not worth
trying to do anything fancy here unless ->d_revalidate()
stops kicking out of RCU mode at least in some cases.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/smb/client/cifsfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e902de4e475a..630e74628dfe 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1172,6 +1172,9 @@ const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
 {
 	char *target_path;
 
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
 	target_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!target_path)
 		return ERR_PTR(-ENOMEM);
-- 
2.39.2


