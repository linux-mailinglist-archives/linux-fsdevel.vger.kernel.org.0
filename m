Return-Path: <linux-fsdevel+bounces-66741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D91C2B68F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 18B934F94BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED24A3093B8;
	Mon,  3 Nov 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STqrMrI4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC57303A2F;
	Mon,  3 Nov 2025 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169251; cv=none; b=n6H+3VQlqDSP2wu7doRydDT9DFoXPDIpFFrCs0t05qZTsnQlFbXO4AwyHnPnousMirQmGCwk74ponB0Kiq53SCeCQDUWqn2k1JBhzp1Pk2F7YbjqE25khHOCIdoa1YIov5to58HpptzbTxSgwC+NQKM+B8Yx0ijQUkr0Wh/a6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169251; c=relaxed/simple;
	bh=mYlstSLu9EjMbm9NKODOYBWD+LPqr6dAu0tzrPktmzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SMKBpEnOd0GVyl7nUUGnq72XwAqT82r++iGZciqJv3l/GxIinOiOq8EcBP+7UWv93qoX+4hvDgVkCvEYKlUsJPMQg/3tAcN0CiOyWpUQKLSU+8gCwe7UJ/iOFTafqt3WHeOuM8grDSeFIbfTvUVIbox6m+S3kdc0n/+FUSDQ29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STqrMrI4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286ADC4CEE7;
	Mon,  3 Nov 2025 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169250;
	bh=mYlstSLu9EjMbm9NKODOYBWD+LPqr6dAu0tzrPktmzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=STqrMrI4HTdVciHFTQo6X/rWq9AuCwH8cjr9x8+n6+sG8Ivb5pFAr/LHYe5ukSl3Y
	 /xOm63eQeS5pMMZE5xjNg9VDY4XYAN5G6gQqED6X5+od9W9xPQXtK4d8Iv2e02+w0i
	 Wd6O2dhyK3zL3U11rEGhZdsx5Z0pLVA83ls9eVzpGSPPSbL0iICNZDfbyoPPyZ1ZL2
	 0UPGQZun8LiPfvFilfZkttbHKMGAv17ErlWMEg9EcML+jOM4Mv0+FbKtSqZ3hFRVwg
	 e5YDmEPGlN2ZfqtZWOK6oD41JlWuDosnLjx1hNgTh3glvEN5HiztiFysvvXU3DoIe4
	 7GNQ753m8/85w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:56 +0100
Subject: [PATCH 08/16] binfmt_misc: use credential guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-8-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1225; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mYlstSLu9EjMbm9NKODOYBWD+LPqr6dAu0tzrPktmzQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGz/+WIFh9nrxRFbP9Uf+F5deo/n7QrmSybR9YfeC
 tz4fe/fm45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ1OsyMtxbwXNRcorXnde1
 VRofdN8wFEYdEtv4JnqO0e+9GibWf2cz/I/OXytfrjPh+IulfbmKUgKiPxLjXAWTRDaHFx95/kj
 sGDMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/binfmt_misc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a839f960cd4a..558db4bd6c2a 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -782,8 +782,6 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		return PTR_ERR(e);
 
 	if (e->flags & MISC_FMT_OPEN_FILE) {
-		const struct cred *old_cred;
-
 		/*
 		 * Now that we support unprivileged binfmt_misc mounts make
 		 * sure we use the credentials that the register @file was
@@ -791,9 +789,8 @@ static ssize_t bm_register_write(struct file *file, const char __user *buffer,
 		 * didn't matter much as only a privileged process could open
 		 * the register file.
 		 */
-		old_cred = override_creds(file->f_cred);
-		f = open_exec(e->interpreter);
-		revert_creds(old_cred);
+		scoped_with_creds(file->f_cred)
+			f = open_exec(e->interpreter);
 		if (IS_ERR(f)) {
 			pr_notice("register: failed to install interpreter file %s\n",
 				 e->interpreter);

-- 
2.47.3


