Return-Path: <linux-fsdevel+bounces-55051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025FB06AC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 02:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6971713D5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 00:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30D481CD;
	Wed, 16 Jul 2025 00:47:36 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB6F7081C;
	Wed, 16 Jul 2025 00:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752626855; cv=none; b=l4RTmc+ClKOBT6Bam+bhW1yqn63qETs23rVqR1/BgnTyND7MohIIHymyFasr/mgvNXrXGxG5eDX9XllXW+IhMwmxtivmVYd3R8547Va7cThcloTSxtKOULRxItPGvwdQqM4rBHHRZg69bmntoeTaI6CVJVVtsFLsoDGrmmLI1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752626855; c=relaxed/simple;
	bh=ddlFmYjZMQXwue1fRUb11EqRKnu5edA6wHh2g+0Joso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQqfEEzDXZh7nWJHu1XFxQ084W9fxwHFKfrk2Z27oQNkq0ySM+Nw06gfbXUC7kuDoX9+8jQGpDMm32JTVuSzJvdwNzpz5dVB+jy3FCmtjoqjRgNGUu1eCgRALOAPtUvDGZDCwDJyqXj/4GfJuvUs5Qib0+HTS8eRWeveTmVBhag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1ubqJ0-002AAV-ND;
	Wed, 16 Jul 2025 00:47:32 +0000
From: NeilBrown <neil@brown.name>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/21] ovl: narrow the locked region in ovl_copy_up_workdir()
Date: Wed, 16 Jul 2025 10:44:15 +1000
Message-ID: <20250716004725.1206467-5-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
References: <20250716004725.1206467-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In ovl_copy_up_workdir() unlock immediately after the rename.  There is
nothing else in the function that needs the lock.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/overlayfs/copy_up.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index fef873d18b2d..8f8dbe8a1d54 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -829,9 +829,10 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	err = ovl_do_rename(ofs, c->workdir, temp, c->destdir, upper, 0);
+	unlock_rename(c->workdir, c->destdir);
 	dput(upper);
 	if (err)
-		goto cleanup;
+		goto cleanup_unlocked;
 
 	inode = d_inode(c->dentry);
 	if (c->metacopy_digest)
@@ -845,7 +846,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
-	unlock_rename(c->workdir, c->destdir);
 out:
 	ovl_end_write(c->dentry);
 
-- 
2.49.0


