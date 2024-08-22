Return-Path: <linux-fsdevel+bounces-26741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCF595B85B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465C91F2610F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 14:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C69F1CC153;
	Thu, 22 Aug 2024 14:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b="gtuUB3GY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-gcp.globallogic.com (smtp-gcp.globallogic.com [34.141.19.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DBF1CBEA2;
	Thu, 22 Aug 2024 14:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.141.19.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336791; cv=none; b=doK7LBpS066IaOBIhr5IoeY1Of5pjpYK3fZ+78/9m1CZxSAMwp5KyDIaXQ/PSuJoh25oF+4G09ly/ckLW799YZAOTthD+zCqSsPOgBDudhBT8NwKCwfvLUuh4cdYPBb0BnaH25UVUBU2MsfaO93j38NPWuv4igNPNwWMnffFiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336791; c=relaxed/simple;
	bh=YJcgWbnziyKRxRr1FBzBeoShrhWvBNrpXICScQ0851w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pz+Nq/P43+eR+2HhFg0P/VGojMEXkyrYcVb8M5pViNm/t5RyW8iW1O/v9zkW+gGPzrDrJTIKhY6uy1DgJniXxKOBqsGymgNmq1xcyC7p7RlB74daFNBRkk+i/NKFofjnr9qVL08usjjGaj3+wXhAdkfH4M2k0CZQ4FHMTfHGx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com; spf=pass smtp.mailfrom=globallogic.com; dkim=pass (2048-bit key) header.d=globallogic.com header.i=@globallogic.com header.b=gtuUB3GY; arc=none smtp.client-ip=34.141.19.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=globallogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=globallogic.com
Received: from LWO1-LHP-A14530.synapse.com (unknown [172.22.130.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-gcp.globallogic.com (Postfix) with ESMTPSA id 8909D10ACE21;
	Thu, 22 Aug 2024 14:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=globallogic.com;
	s=smtp-kbp; t=1724336781;
	bh=zQ2mIMR4NFT3ycvil4nrM/oj7F5q3LrHKDGgtxqSRew=;
	h=From:To:Cc:Subject:Date:From;
	b=gtuUB3GY8rJPm19GTvQyBTbi3S7Lde4j+L7ZUyCOzaFZoZZFy3NyiRqE56IXT5bZ/
	 Yfc1AgyVJy2qYOobMpkJUrrALz3hUGWf4aNxf9ocPS9UGcr+07yCxlM2Xqx5rlCBje
	 xqOy6PJVYquiw/jXItgPUP1wtvdmokPsZmAjJfEW8gcdThb5qjxgaVO5KhRDX44Qlo
	 mc4svtbQnxKKCuDWNqTbyNLJisHeOhwxyZ4/BZMFPZAH/8oZRv8b3nAhi1tGYbvRtk
	 uaI4Loj8XaxbtmgLdGAU8KUFWeje6HY4GlDmGV6bkLFN5SY6RpBK6G9o/ezRYfZ02P
	 xH1isjlZvhHPA==
From: sergii.boryshchenko@globallogic.com
To: dushistov@mail.ru
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
Subject: [PATCH] ufs: Remove redundant inode number check from ufs_nfs_get_inode
Date: Thu, 22 Aug 2024 17:26:10 +0300
Message-Id: <20240822142610.129668-1-sergii.boryshchenko@globallogic.com>
X-Mailer: git-send-email 2.25.1
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

Signed-off-by: Sergii Boryshchenko <sergii.boryshchenko@globallogic.com>
---
 fs/ufs/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index bc625788589c..11e8b869e0ba 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -101,9 +101,6 @@ static struct inode *ufs_nfs_get_inode(struct super_block *sb, u64 ino, u32 gene
 	struct ufs_sb_private_info *uspi = UFS_SB(sb)->s_uspi;
 	struct inode *inode;
 
-	if (ino < UFS_ROOTINO || ino > (u64)uspi->s_ncg * uspi->s_ipg)
-		return ERR_PTR(-ESTALE);
-
 	inode = ufs_iget(sb, ino);
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
-- 
2.25.1


