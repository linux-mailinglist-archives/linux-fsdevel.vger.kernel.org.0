Return-Path: <linux-fsdevel+bounces-68550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE77C5F870
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 23:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 149B14E045B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 22:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB8530AD13;
	Fri, 14 Nov 2025 22:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHfi3zbR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B5224D6;
	Fri, 14 Nov 2025 22:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763160334; cv=none; b=kOk6BJgbcZlJXTS1ve1XY1+Zozql432t3bR08VfcEzicBccnfXLLvSbMdpF4SNQn422BkY/FwwwANMLQKClS+spCVmFBJ/AFe0eNz7ST3ybXIJK1ZJjpjkBd2FulfIeYBUL/eKciTrDkezuVFblsLIIxvoMOlbv9Q6oFj0EfeLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763160334; c=relaxed/simple;
	bh=vaMIHLhnRzt8Lo6YHHVk9qCGAOn1oDyMUGx14+6kzSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SubWD0UK0LF8fKTKSfa5A1bwpsGb6PlWfW5eTviKYFLalwXRclx38zySKzZx9SB70eiEwWF9Dx5WYefiwRU8kYIHAvUJPJ4PgQqv+e3gvtbFkogrFunU0BmMeLm2qgpRAznyhhOxCc9aj4WrRAY74drmdzfljoeoqQaH9+GadZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHfi3zbR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845DDC4CEF8;
	Fri, 14 Nov 2025 22:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763160333;
	bh=vaMIHLhnRzt8Lo6YHHVk9qCGAOn1oDyMUGx14+6kzSY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bHfi3zbRV5wDKSZOmFlZv39jcJU82tPAcR8bXzqGloxAdQ5Ojrg8xzQH8DpKlpv2g
	 dG5GuPO6AfvAu5fd3kesV3izkV0hErK1twKZHXecG6dLBiyt1s176aWv1n9hezskAD
	 Fx0+M8Q+uvjYfSjYZoRRZyu9AzyexR2m9sJefdhK2DI8ejDLL+XPNr5HkaKyB5i8tR
	 8qiE4TEPsQUGaZKzCIfEIzEiuEYhOwUsODIDubC4YBZe+VC8kE4mkiVmXsBE5+MnwT
	 os0m+Pz24WdEQfYTbGGXftB095UrkzVlZHIcEDmzjfcM4yPAlNyssFpGq1zATVcG34
	 hLsSkuGyI0q3g==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 23:45:23 +0100
Subject: [PATCH 2/5] ovl: port ovl_copy_up_workdir() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-copyup-v1-2-ea3fb15cf427@kernel.org>
References: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-copyup-v1-0-ea3fb15cf427@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1259; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vaMIHLhnRzt8Lo6YHHVk9qCGAOn1oDyMUGx14+6kzSY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKb+RouLpYjkvt9WXpkh96LkunuZ18E7R584uy2NY/3
 2aHM9ys7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI6VWGv6IxYbOf5AWWXboY
 l/pcSszk51NusW1c5T8iH+z+m3394D6Gf0qvb8mszbDedlHw/JV3d/hktr78t1Gd44mZGdu2948
 Z77EAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Remove the complicated struct ovl_cu_creds dance and use our new copy up
cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index cc77498fa8ca..665c5f24e228 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -792,7 +792,6 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	struct inode *inode;
 	struct path path = { .mnt = ovl_upper_mnt(ofs) };
 	struct dentry *temp, *upper, *trap;
-	struct ovl_cu_creds cc;
 	int err;
 	struct ovl_cattr cattr = {
 		/* Can't properly set mode on creation because of the umask */
@@ -801,14 +800,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.link = c->link
 	};
 
-	err = ovl_prep_cu_creds(c->dentry, &cc);
-	if (err)
-		return err;
+	scoped_class(copy_up_creds, copy_up_creds, c->dentry) {
+		if (IS_ERR(copy_up_creds))
+			return PTR_ERR(copy_up_creds);
 
 		ovl_start_write(c->dentry);
 		temp = ovl_create_temp(ofs, c->workdir, &cattr);
 		ovl_end_write(c->dentry);
-	ovl_revert_cu_creds(&cc);
+	}
 
 	if (IS_ERR(temp))
 		return PTR_ERR(temp);

-- 
2.47.3


