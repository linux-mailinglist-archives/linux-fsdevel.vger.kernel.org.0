Return-Path: <linux-fsdevel+bounces-51482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FD3AD71EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 15:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB5617DD81
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 13:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9825B31F;
	Thu, 12 Jun 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrvFWeeo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766D1F3FF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749734776; cv=none; b=Z770weGoFizDm4iJmGsMcdLZXGlF5aBrE7pO4ajJCLOymaRnZxbrrj0PCj49Ux1MyTD97PiC1UsPox0uSYn7p25J4OzjRUhaJpkd38tIwithtIL4Pjimiqyjui0ogC+QSwemoygZbFHVfUFb4kLexghK3+HYnwnfuaYm3p3gbrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749734776; c=relaxed/simple;
	bh=gciPNJdN7RCM0H9bvRoPVD9FPukGeSj3Pq8pFSm34tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZDvDYhnNleNJ0aOrhk+LFyjropJrtvsygIZ4g+8ORFX2cgOdBaB7L0JsCu5iF+nEEzylP++px942MXo5rwKJ/olbSvq8POubMGHZK6h40vvE1pEtMVtrq0XfYYJIRjZvKQ/6NTwi3/FXnvmxeDObLNbobrF8u7UCjpq89XCZ+GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrvFWeeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D316C4CEEE;
	Thu, 12 Jun 2025 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749734776;
	bh=gciPNJdN7RCM0H9bvRoPVD9FPukGeSj3Pq8pFSm34tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WrvFWeeo7qSCG7Hvk0Rbzsjq3v7E79uPvLlwyIEcWklme0BZJzOhqbauTJuxUzBsN
	 hqmWyrSAKyEFTrEGJyAQcAz6od3RzfhNvuLphO5Db+BW27guxMWAcglitjbPjKxCwg
	 2PXHYYizCc3rP9mVVKmmNyLFxl3VWYD67EbwdGecYeWYzsVgEbbwFiU7b4O7jvq8Si
	 otcQLM0+JaDgxuz0m++nOuCQTGUlUuDQ/LBjSfvMvnIINREWBAbapRgL+NnwHF6JZH
	 3J/QQ4yECCA3YyS8AXY0s5NrGc/fbGw8eZ3IDZeOk7JqYooz1JEzwFzVihkJFUudt2
	 NEvYH1zoIGa+A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 12 Jun 2025 15:25:36 +0200
Subject: [PATCH 22/24] coredump: order auto cleanup variables at the top
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-work-coredump-massage-v1-22-315c0c34ba94@kernel.org>
References: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
In-Reply-To: <20250612-work-coredump-massage-v1-0-315c0c34ba94@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gciPNJdN7RCM0H9bvRoPVD9FPukGeSj3Pq8pFSm34tw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR4XXUPCGozmT+tudX7y1TzzZkpthOv7s0WWNKX0t2vd
 7b00L2lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOZPIPhf8n/vy/j9zHMi07s
 amBhkWC9/j1VbP2TGOM69mAP8a/2Xxn+ynPwaKv5ORVFqucedZpqftyi+/fJRa79+bOX7HIOjjP
 gBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

so they're easy to spot.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/coredump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index d469ee290246..5b88a4be558f 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1081,14 +1081,14 @@ static void coredump_cleanup(struct core_name *cn, struct coredump_params *cprm)
 
 void vfs_coredump(const kernel_siginfo_t *siginfo)
 {
+	struct cred *cred __free(put_cred) = NULL;
+	size_t *argv __free(kfree) = NULL;
 	struct core_state core_state;
 	struct core_name cn;
 	struct mm_struct *mm = current->mm;
 	struct linux_binfmt * binfmt;
 	const struct cred *old_cred;
-	struct cred *cred __free(put_cred) = NULL;
 	int retval = 0;
-	size_t *argv __free(kfree) = NULL;
 	int argc = 0;
 	struct coredump_params cprm = {
 		.siginfo = siginfo,

-- 
2.47.2


