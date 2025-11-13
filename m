Return-Path: <linux-fsdevel+bounces-68315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A0C58E1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2F4B3A238E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C93624A6;
	Thu, 13 Nov 2025 16:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmN1knSB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AC52F5316;
	Thu, 13 Nov 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051890; cv=none; b=Kbowgt+H0ckXs9zF3a0gupW/AF65+rtoWaKHyTXA+1fH2NgVFDq4jVcPWrrAibsrMxHoeQpmnv61Ex16wXiMewobH5uy6n9KJ5uPSIYLBkJoxkNYhiO9/ZK7h8za1RfLN6Gek18QVqRATmZcx3nT27bAnscKQLgvUisILMBOCkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051890; c=relaxed/simple;
	bh=W/DqeeIcK6GazQCricaLbDQV0gL23WnHpeFTOhOoUc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=upQGQ0c83L9KnLZ1FwGC/0FkdirP06XSqxQX9dsKNR++mbZ1FwP6BdaNeMnkOrTWgsU7H+/QopItTxM+f1oAxnaN7e8iDs0XKjmYqwRDKdCGgibPxAYzfVHMoS/Bjkwqtl/1gkGt6NvChwjhLLehXTeILAUIG43HRL3r1wnE0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmN1knSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327C1C4CEF1;
	Thu, 13 Nov 2025 16:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051890;
	bh=W/DqeeIcK6GazQCricaLbDQV0gL23WnHpeFTOhOoUc0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DmN1knSBAfacY+ovxLMQRZz2uycJwnTg/56ni/LvuRUdIvOHlCzeXxE2BoPVfqtly
	 EYUqdvHf7evXP8kEGH4dG5j+oi5KMygjWhNiH81sYA+FyISwJ7BnAH0KPOBLq66gCe
	 Sj1CtfjwwJlaj9IQTgwDQIejHpXX6DexX5yRseg6asZdx7k0KT9bGmNQ6+t6matu44
	 c7WudcvS/j5/pVTEYzp7RPgIt//MCyVgXgx1U+A2i8GdmcBaN6XEKKVoLgHYVD7qKS
	 g8deWGKeYKxwAgiBEJxa7IZ1Go3cro0IPlgPmy64g2js4GR2M6TZdfjuyGCXeC7lV/
	 JJMJo5Ow3fsSA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:27 +0100
Subject: [PATCH v2 22/42] ovl: port ovl_maybe_validate_verity() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-22-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=821; i=brauner@kernel.org;
 h=from:subject:message-id; bh=W/DqeeIcK6GazQCricaLbDQV0gL23WnHpeFTOhOoUc0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbo5rfxnePNOj2bq7xedGXV/D4cGuAi8W2PBwMq4j
 te5mEuwo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ3yxgZVpiXNekayCwPye7t
 D3mYfKsn+oVib93rvT+2Bk74PG2CFSPDtiDnrA//riuVeBiqKPKtEjjLOnfxGaV6l+8iE2588nb
 hAQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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


