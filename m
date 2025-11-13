Return-Path: <linux-fsdevel+bounces-68258-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A2EC57995
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 630C83A2352
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7BB9355800;
	Thu, 13 Nov 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKiVTqUQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34799350A15;
	Thu, 13 Nov 2025 13:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039025; cv=none; b=Fx/pCpJ5SXS3Y1Rj87CwURyi19ve6aiDyofBF1xNkJ2NLFbVr9dYl0FrabvWcBips36mgCdsT/ccBKC1XVWdYVSRTIZQI87hn9+xI/N2YlsEBM62vgjr0vsfTghjfXqs8+ZxP7syLsQ7/Rkw/9qarbnbLPyA5BnTV5hwQVewlzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039025; c=relaxed/simple;
	bh=vStKPD52MPAL2JU7+zmgdoLS+Ugvolo/PV4hOqG/IIk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpN3IfEDKr8/7wukFmsNfPfNu33WrVpuVznd4hpu4gYr27JRga3RD+Tqd3oz91kcab6Ch4+XarFyMKdK9JQpg9JZrhhIJzPJ5qbpgFv5RZbdBo2Kla8ekUZNXICQz2mMlAGc5Vco+PX+MEiXZImvdWPtXz2UWI4bSmXuE5iDJyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKiVTqUQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 743A5C4CEF1;
	Thu, 13 Nov 2025 13:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039024;
	bh=vStKPD52MPAL2JU7+zmgdoLS+Ugvolo/PV4hOqG/IIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mKiVTqUQRsTdtmwvx3vn+QoQOmganQTdo/7sxOgk6Tu5cbvgC2rCW/3KwTKKjkWQC
	 ljIw8oxDgkVEt1WGyXho3WCxw5Qf8PXTyNW9MozQs4nXU4stn+SHQxonYkhXzJ4109
	 NZ0vhLFtvV16/Fgf/naDuuaBfJwggTMz4sTHC9qQSL5+/lMlT2reR6F/amH2PA0UIz
	 DCa9Yz42unTdukn6ATTu8Hlu+gyjTQeSDBrO3wgQfWtuqBtbWeqbkDv0Cz8uszlwVi
	 jsc1idUnpphOwNta23B2KRurbBuIurbbLqjq1cSYg9DfNFsuCr/ztrhRFL6MdW6k+M
	 QqLk8d+AQggpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:02:01 +0100
Subject: [PATCH RFC 41/42] ovl: port ovl_fill_super() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-41-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vStKPD52MPAL2JU7+zmgdoLS+Ugvolo/PV4hOqG/IIk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvinKf3xNyN0X9y5JxPzb/VCoOLlj5r+FrqcItLZ
 sYdl+tXOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyJ47hn+LhLWqz6mVyTkkE
 f1q3tDf6meA39x9nWBSj/2qq7XHSW8Pwz+5nC8+HOzI38mcqlbzmmMz4dc3ciEtCHqsue4cKBKU
 vYQYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 6876406c120a..260b393a1916 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1545,7 +1545,6 @@ static int do_ovl_fill_super(struct super_block *sb, struct ovl_fs *ofs,
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
-	const struct cred *old_cred = NULL;
 	struct cred *cred;
 	int err;
 
@@ -1563,11 +1562,8 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!cred)
 		goto out_err;
 
-	old_cred = ovl_override_creds(sb);
-
-	err = do_ovl_fill_super(sb, ofs, fc);
-
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(sb)
+		err = do_ovl_fill_super(sb, ofs, fc);
 
 out_err:
 	if (err) {

-- 
2.47.3


