Return-Path: <linux-fsdevel+bounces-66738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D92DC2B5EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005913A176C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 11:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061D230748E;
	Mon,  3 Nov 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwSwtBJN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48210306B35;
	Mon,  3 Nov 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169242; cv=none; b=RJJdcWyr4A2FGgO7PJ6sYS89uMwwQrhCCG0rN8KsVmyuTOMtfmAhjS6VMiK2p5w0REOgrM327AtLti4cQ3gDZjpdTtJ6SbWGdDHE42CcpJ2+v5rFiNC7pOPSOCjQFpk7+MfIAgBSb1NpyKNvUMY/N1jmRNgQAF2DGYMuWUwLjsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169242; c=relaxed/simple;
	bh=AQ/Nv+Gm1iyA4MT1Cr+T/3KGkzWrrlBvcUFCgBNnIOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H/e1OBh67+UTWtrppRN4C/NM6DNhBkrhJqPs+9PKOa8WKHkb/X+BIXmQhIgmPuOf3azFEcRekKitvtYxKq6BqIezugZdi3eMlmfocmdI2u+tEq5w4F8kx95vf1XkqjOkoGM2PnVqAKGdkrur5KdJoMU0GVo1ox4a/AQz75LsTWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwSwtBJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4BFC116C6;
	Mon,  3 Nov 2025 11:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169241;
	bh=AQ/Nv+Gm1iyA4MT1Cr+T/3KGkzWrrlBvcUFCgBNnIOc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mwSwtBJNrczmBeLlfXA5znjbKF562UqPh69bEu98DZ5XRywF891sJAKAL7N7Gg2+w
	 DB1h3pjxaVeeJBv3r961WONcu6m9YzhdpFb7vuefHWS16ZOhQCejJwH4OWnG4vBduW
	 6pPLAELxrWssqj4wrKct4I6KpAjrWpFyXBP0vXWhUSUCbOZT0a0GyBd0qaL6w4heK1
	 IMjF0/0GbHnKk9wL2jspcIyNQr2koBxUd5HJSK0KfPYo+CZkTCzzp7QYZZ+XQU+/YF
	 sGtJimvYvKECLQII6gkpylUAUqISFS62sDoYUuyQfOWLqmxpuxV3VL1B6MaRsGpLMM
	 uqMEtsDtsY3Vg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:53 +0100
Subject: [PATCH 05/16] backing-file: use credential guards for splice read
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-5-a3e156839e7f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=970; i=brauner@kernel.org;
 h=from:subject:message-id; bh=AQ/Nv+Gm1iyA4MT1Cr+T/3KGkzWrrlBvcUFCgBNnIOc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGw/4lX90OxD2/XgZRU3XBsyapnSRLz73uuFJzSdy
 FHuyTvXUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFTLxgZTr4N3npssUFilvmv
 iJMN6fdkjL//OFtaeaP49bfWg7u58xj+iuVXbjG7k7XtT/70zS/bDXP36c1mMZ+1PyBx08u41wn
 GnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 9bea737d5bef..8ebc62f49bad 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -283,15 +283,13 @@ ssize_t backing_file_splice_read(struct file *in, struct kiocb *iocb,
 				 unsigned int flags,
 				 struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(in->f_mode & FMODE_BACKING)))
 		return -EIO;
 
-	old_cred = override_creds(ctx->cred);
-	ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred)
+		ret = vfs_splice_read(in, &iocb->ki_pos, pipe, len, flags);
 
 	if (ctx->accessed)
 		ctx->accessed(iocb->ki_filp);

-- 
2.47.3


