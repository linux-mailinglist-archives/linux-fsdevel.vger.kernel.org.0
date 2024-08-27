Return-Path: <linux-fsdevel+bounces-27342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5E49606A5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 12:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E761C228CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 10:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E1E19CD17;
	Tue, 27 Aug 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="tbzD4cQo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-gcp.globallogic.com (smtp-gcp.globallogic.com [34.141.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0701A2FB2;
	Tue, 27 Aug 2024 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.141.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753046; cv=none; b=jsZVg5DfypKr+zaind65QuvbO2Lt9dYLRkzg2kb9Tjzelzg6t5IJTT7sD27svf6SYO6ERsO/8EYsi30BhqyZEUfErQXxOrE7iZX2ifH1og8Qsnod1Zh8vMin9bzJSc4UCXLTbuTL01t1BjE21MDmZTZOBNlOhB8bV7WpRnVLcXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753046; c=relaxed/simple;
	bh=Gifl6uG2+pBROHCiVz5pLLFoNFEfwv3kn+MnL21nlUg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpsXzluO5xVAqKKyvWokqOGLg5HFkw8V/49Ly+txgvnehLa8h9uPTaOcJU0MkaZoZaGUoFVhpb5CpB7IIvVwoia4CxqBAoZqW12pKw/nGaWSsJQ80QuYj7Qy00YW+/m0SXfIdTFpxSzYvgbKtzL5Gze6Eod2nPfW8BwhGTmnnvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=tbzD4cQo; arc=none smtp.client-ip=34.141.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
Received: from LWO1-LHP-A14530.synapse.com (unknown [172.22.130.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gcp.globallogic.com (Postfix) with ESMTPSA id 7E99810ACE2E;
	Tue, 27 Aug 2024 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=smtp-kbp; t=1724753036;
	bh=AUM+KDM8xtma/nTWaue7NB0fJ3DC9m4zT3+ZUb8XZMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tbzD4cQorppmsd/+fOECCQJoSwbn7Oum10zj670Ndkv8HnNbvsBdQ4+kE3asJHTQS
	 EVjPr8BzyfhDsfuGrgWPqcl19m+LdDcQYKMVnJSAV0XM0pNcY1KpssUKaTpkZ1mg5p
	 55oJoQ5hhwkM5NMSZUkn0Bxrp0Mn3sxevAbWbJY9gdTroa42VpCquYe/F1LQXWLvxv
	 ke/aQRqPWV23+cyO/v994ZiaOEB44CuiqxQkPOjkiUT+1WR8OroLE2Qc/eSbhHlv70
	 IU6ePcqhGOLWnPusGoNbB24AfojYQrnK7EdlRchWDTCk1UN7SoWQ4yQQ0oVh0XspvE
	 THFdanWuGw5kQ==
From: sergii.boryshchenko@globallogic.com
To: dushistov@mail.ru
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] ufs: Remove redundant inode number check from ufs_nfs_get_inode
Date: Tue, 27 Aug 2024 13:03:13 +0300
Message-Id: <20240827100313.171877-1-sergii.boryshchenko@globallogic.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240822142610.129668-1-sergii.boryshchenko@globallogic.com>
References: <20240822142610.129668-1-sergii.boryshchenko@globallogic.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>

The `ufs_nfs_get_inode` function contains a check to validate the inode number
(`ino`) against the valid range of inode numbers. However, this check is
redundant because the same validation is already performed in the `ufs_iget`
function, which is called immediately afterward.

By removing this redundant check, we simplify the code and avoid unnecessary
double-checking of the inode number, while still ensuring that invalid inode
numbers are properly handled by the `ufs_iget` function.

This change has no impact on the functionality since `ufs_iget` provides the
necessary validation for all callers.

Changes since v1:
- Removed the unused variable 'uspi' as reported by the kernel test robot.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408261605.ARxTA9jX-lkp@intel.com/
Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
---
 fs/ufs/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..3511d35b7b21 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -98,12 +98,8 @@
 
 static struct inode *ufs_nfs_get_inode(struct super_block *sb, u64 ino, u32 generation)
 {
-	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct inode *inode;
 
-	if (ino < UFS_ROOTINO || ino > (u64)uspi->s_ncg * uspi->s_ipg)
-		return ERR_PTR(-ESTALE);
-
 	inode = ufs_iget(sb, ino);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-- 
2.25.1


