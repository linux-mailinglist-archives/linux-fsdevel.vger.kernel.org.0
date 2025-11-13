Return-Path: <linux-fsdevel+bounces-68378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 45361C5A2C6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D58C84F2B24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4B932720A;
	Thu, 13 Nov 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CUoxB1yl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEA325709;
	Thu, 13 Nov 2025 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069570; cv=none; b=AYwsfSDG5KroNlVxzs8c1D+ssvEkkYnufkbwJVMsQYqR8CyKrGW/6CRHmin/RrRkSo4jLcMRQaGH4ijD8J9ZhnFuecnq76cBEDf5rtVmdcc9spBdartPTnanvjXLjsraTSk+97RDmcCCKESycD7X2CCEHjxZNWNl+pVxsR8O5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069570; c=relaxed/simple;
	bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXgtGIZfQiQ9Hx8a/o5zNB5MSY3az+dm9Icx5teu6dP/SrSa5VJS8y4Z/j8anzid3232u+pJcEQ0a0OVaiTpC6xdFoBt7DcaBpBhMq3hhTHV7OkI05w5JKK85j1w2Wnid8YugQGODN6j7uy4zgmP7iDqUeoyQFSW+JeULYNQ0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CUoxB1yl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD165C19422;
	Thu, 13 Nov 2025 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069570;
	bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CUoxB1yl2ERXfnJDL35mh/RWH4pHAmyhDIJS+AcpRHxcSVgouPhHrWsc69VY9/SJW
	 rEXlDvCtiSNUaT8xsVVGuk37uXPIOPRPbObkJoLelBPuZOhJyscPrXlLCX9G5FPhob
	 h40Y0dRqS3BsZOOqXlsxIAHLUIi4Vda92pvnC3k0KnKrDFpd+Cds1I3sGqvpocF3h2
	 63Yi8xuxRMoVxid07YGFtME2bFvB5MGmztzKJt1f7bPY4gqOwvNfkLAK4QyAavKq/4
	 gXLipoFGRnajNBT3pPjaekRvdghEjI672jzELWYIyRybpYQc2VoKqaFMR1vhSO/r2D
	 5PcFTrsLGpNLw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:05 +0100
Subject: [PATCH v3 22/42] ovl: port ovl_maybe_validate_verity() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-22-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=871; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zjyw0/rgGCcNg2hOnV2dZIPmB08RELaA6DQ8h6k7QFA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YXr/Zl6mcNerShyxtLPCz97S+u7399tefig1/z3W
 34+q7Tk6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI4kqGfwaNFxKsf62Y1Ln3
 sNeVGJO3rkuWib861bT4qXrlots/brYyMvT4Oy03yAngmC1XpSP/b2vc7qM37z/OnsjuayQ4PWb
 tITYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index e93bcc5727bc..dbacf02423cb 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -979,15 +979,10 @@ static int ovl_maybe_validate_verity(struct dentry *dentry)
 		return err;
 
 	if (!ovl_test_flag(OVL_VERIFIED_DIGEST, inode)) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
-
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_validate_verity(ofs, &metapath, &datapath);
 		if (err == 0)
 			ovl_set_flag(OVL_VERIFIED_DIGEST, inode);
-
-		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3


