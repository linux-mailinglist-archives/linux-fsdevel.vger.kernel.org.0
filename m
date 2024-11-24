Return-Path: <linux-fsdevel+bounces-35687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824299D72D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1E46162BD5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BB920A5ED;
	Sun, 24 Nov 2024 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI2opDzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B3920A5DA;
	Sun, 24 Nov 2024 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455881; cv=none; b=kcQ65Da1dwSiCjjmLnsekMCV79+gDDeCmucXYH2C8+lsfR4sNs0OHBLmWKQF+asUubeXgvOY8GifNldNLVMe+kbBNNxrGP850qBVlpId1olM06m7qhoEcmPNVDUWvCezQ3WedNMvdaeyuflArRSGroLkRlkD4FiTQZeGNIVg87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455881; c=relaxed/simple;
	bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhHqXMImRJtBSUrONszImcFkF9xu5k3JTBcz2mra46DIHAGaCMztgBcUO1CSmgW/RveYAB7cspVpgdikPuKq5UYnpkp8VrbCEDUS/KZBjOtnUQgZo3iqE+lqa7/35Fgqrd0Oh9T9FbWQpS/XKDX07IvaGNim7s08v6NupgTchPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI2opDzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7223EC4CED6;
	Sun, 24 Nov 2024 13:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455880;
	bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sI2opDzOgQEi7xC9vj+5EmjCS3qDtfQxzTdESzu6itZdR+vbXESIvYinSUHqjX2hu
	 I1XE4JpgQpPixcSLQSXDo7rvpmiWnc9Loc6JgbsJKT4SvIZPEdpYx6qYqHKOBqxqUA
	 Te7zOO4BbCxzVykNtgpePCKuEQ6CrtWsbElOabMAYTtZHpXlACxuLTrpOq4lAdispV
	 xhKxnXFFXbXeAwg6j06IaJ3xXAvHIdVTdZuK+T3pDkb5dkkUIT2ecHH1PL/OXZtGs0
	 nxT4sgAbe3lhr6RGsj+K7iR9oXpA4rborSqls0wX3rZmFqncfl/JGNxF6z9qn9ncik
	 l7bxMC370jAEA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/26] coredump: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:43:58 +0100
Message-ID: <20241124-work-cred-v1-12-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=929; i=brauner@kernel.org; h=from:subject:message-id; bh=IFLM84NiqCXkwMMafq8E9pIDiDKUxCWKPeY0cpJ2rUw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7687lfLHW+9fNWQ8rBDqaV2iuiTVczhpRyfFHouKNr r33S8tbHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN5IMTI8Ob/e/FgDa6ZLE+7 7Lu+KT3ylpXTub4o19E8cv8KoUdvDzAy/PB4duRBpCrP6b3WG3h03V7JtpdZCv/du6XsTkkVo9E SPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The creds are allocated via prepare_creds() which has already taken a
reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 0d3a65cac546db6710eb1337b0a9c4ec0ffff679..d48edb37bc35c0896d97a2f6a6cc259d8812f936 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -576,7 +576,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	if (retval < 0)
 		goto fail_creds;
 
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	ispipe = format_corename(&cn, &cprm, &argv, &argc);
 
@@ -781,7 +781,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
 	kfree(argv);
 	kfree(cn.corename);
 	coredump_finish(core_dumped);
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 fail_creds:
 	put_cred(cred);
 fail:

-- 
2.45.2


