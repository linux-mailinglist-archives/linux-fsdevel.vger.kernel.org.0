Return-Path: <linux-fsdevel+bounces-71769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 640CACD14DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 19:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95AA230EEB91
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 18:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B3347FF4;
	Fri, 19 Dec 2025 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I2dAHbn5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6129B346A11;
	Fri, 19 Dec 2025 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166209; cv=none; b=YV5zzJLtyZRAYChwFoS6A7Ix+7mdb9iCqzzCiO3bCPTb8AJ2n16XRbqXN4YthnXITqu3dEAGCM2P0nRy/EQVn8xUxqd3UsxtRb6He3S66jmpOigfbAnqN8ONbIW/4nO2ogWz7ErVnHjhJJbQJn2heRfyvD2CfgMo1xt4aC1XdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166209; c=relaxed/simple;
	bh=o2THcKPo45z5soGXRcN2mbZHgWmy2NNFFA3LWEdNAII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pqCavgFj528QIeT/nrWnLoRUSsysMM/13dbCa14F3gZP3uReLwmQA+SkqySzt8sFMjH/PVAZPocGpIkncpbfZZVYMIFpMJm9khyR6nLavhmtuJ3/+yJZc38OeoTG4Ru49BuRxJYzWlYWWTR3/nanbW95rJv81yei9jM53GeNL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I2dAHbn5; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SUoJ2Z89QW3dSM6PxQOR2ZbZPL+zegxwu/TizFfaWoY=; b=I2dAHbn5FR84Rhr73Mlon61yhD
	MEg1qGs73DpcWFcv+eAF+ljTydZGDOgLTJKvl1ZFJNFOsFNwWeVecQD3njc90QmmnDlGqrRv2GHM4
	CzuWhhexrEKQiA/55Vzgm8Ez9qDqA2lU2XTkQZ9cm6gMpm1Wsq/0dNK+zDE2FuZnC8XNoqItaHx7Z
	ho+R63gpU8iyFai6s8vqWUjToAJu8x3/s6kDXh5PtTzZ8sRAnmZIICQIZOknxT6kd6NvhMQtYdJ33
	XYO9kLc/gqO0cNhqS3TPC4YBrxKXlISQ3IceWrJ2Bf/2Zoml1kLVHBf3IgfJUtUdddpvyZVR/Ctfv
	QjxS+FVQ==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vWeVZ-00EjFk-On; Fri, 19 Dec 2025 18:43:17 +0100
From: Luis Henriques <luis@igalia.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>
Cc: mszeredi@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Luis Henriques <luis@igalia.com>
Subject: [PATCH] fuse: add missing iput() in fuse_lookup() error path
Date: Fri, 19 Dec 2025 17:43:09 +0000
Message-ID: <20251219174310.41703-1-luis@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The inode use count needs to be dropped in the fuse_lookup() error path,
when there's an error returned by d_splice_alias().

(While there, remove extra white spaces before labels.)

Fixes: 5835f3390e35 ("fuse: use d_materialise_unique()")
Signed-off-by: Luis Henriques <luis@igalia.com>
---
 fs/fuse/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4b6b3d2758ff..75032b947a13 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -636,7 +636,7 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 	newent = d_splice_alias(inode, entry);
 	err = PTR_ERR(newent);
 	if (IS_ERR(newent))
-		goto out_err;
+		goto out_iput;
 
 	entry = newent ? newent : entry;
 	entry->d_time = epoch;
@@ -649,9 +649,9 @@ static struct dentry *fuse_lookup(struct inode *dir, struct dentry *entry,
 		fuse_advise_use_readdirplus(dir);
 	return newent;
 
- out_iput:
+out_iput:
 	iput(inode);
- out_err:
+out_err:
 	return ERR_PTR(err);
 }
 

