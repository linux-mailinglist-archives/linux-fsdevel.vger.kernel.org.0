Return-Path: <linux-fsdevel+bounces-39906-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B396CA19C6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 02:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEB3AD8EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C43D146A79;
	Thu, 23 Jan 2025 01:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Dm86EaJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F86E1EA65;
	Thu, 23 Jan 2025 01:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737596808; cv=none; b=HndlS2/BR/JKGTObUwXPF3wxm17x79XchazNYYz/U6YJvjE4/4gSLTVrjlkgXbCkM4UP6oP85z0e2OGYcutgp5UYwgw2Po3Va8I43TCDG4qXJQZgUSnYVx+dGyiZ2a58tyojHbDiwkgY54Ed+bFEHRC0TZbPTtfDk+nTKgUSmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737596808; c=relaxed/simple;
	bh=kqFfX1nPZXJZNNKbEnE+/GNLUWhf5phXSz/N3PFAcVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm9Zi7oaz7Si/M7il905jgHVZ1TCJRA5U5vqZ6bAIesAaCyDMyl8W1NdReJP6UGF6tWRawuSg8sTt5ATV3APQwXn6PcxonKFgLWP227k+YnDWtmrIM1EdEuuwCahwTBEWvyOfxPFyqJ72gMiMH/RNwXNcRyS2aA2s7BV6Hhfcd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Dm86EaJT; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/KyGJPYFIJ6kdYhT9qcSpG/tCgyIASfflXizlRjFIS0=; b=Dm86EaJTGI2difOy5rxiE3bmCb
	Qp1Hog/PaaGU3REU2eI4PNKlrhQGpMBrPCRCTy4Pf37LfVGAi9S2TdFeuqrWE+2X5dfBhPXkI7lFb
	k0Z+cIuBEuvcxdmsDbK4NjPrkKs5EbH4IPkcgzLj6Gx/6pUbMXlOjIkynd5VSazs3jVgi4thHlBxc
	z4fKsV6vRzaQ1vhjfoXEhKTbMGNuNhHo81VQ8y7r/Cw6TW0swHIeMIxualzV9jMHW9ekZWHYDkYBo
	/bMsx19Cm7LL0jGwYo/mBK2pWhTuD9Pw+IMonIxgSG8zydn00I+cZALn1oCLR8E2f4n7rOuxBbqIf
	20BSZ+CA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tamIv-00000008F2r-00XY;
	Thu, 23 Jan 2025 01:46:45 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: agruenba@redhat.com,
	amir73il@gmail.com,
	brauner@kernel.org,
	ceph-devel@vger.kernel.org,
	dhowells@redhat.com,
	hubcap@omnibond.com,
	jack@suse.cz,
	krisman@kernel.org,
	linux-nfs@vger.kernel.org,
	miklos@szeredi.hu,
	torvalds@linux-foundation.org
Subject: [PATCH v3 12/20] exfat_d_revalidate(): use stable parent inode passed by caller
Date: Thu, 23 Jan 2025 01:46:35 +0000
Message-ID: <20250123014643.1964371-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
References: <20250123014511.GA1962481@ZenIV>
 <20250123014643.1964371-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... no need to bother with ->d_lock and ->d_parent->d_inode.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/namei.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index e3b4feccba07..61c7164b85b3 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -34,8 +34,6 @@ static inline void exfat_d_version_set(struct dentry *dentry,
 static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 			      struct dentry *dentry, unsigned int flags)
 {
-	int ret;
-
 	if (flags & LOOKUP_RCU)
 		return -ECHILD;
 
@@ -59,11 +57,7 @@ static int exfat_d_revalidate(struct inode *dir, const struct qstr *name,
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
 
-	spin_lock(&dentry->d_lock);
-	ret = inode_eq_iversion(d_inode(dentry->d_parent),
-			exfat_d_version(dentry));
-	spin_unlock(&dentry->d_lock);
-	return ret;
+	return inode_eq_iversion(dir, exfat_d_version(dentry));
 }
 
 /* returns the length of a struct qstr, ignoring trailing dots if necessary */
-- 
2.39.5


