Return-Path: <linux-fsdevel+bounces-35816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB279D878D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2D9B2866CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FD01C8FBA;
	Mon, 25 Nov 2024 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X45tH63I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C7B1B218C;
	Mon, 25 Nov 2024 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543864; cv=none; b=jPGmQ2Greba0++Z4jdqRrTxcQHueDO/t0hr97HfMu2aY1b3XlQeV9pTjnq+20wfV8hcnEvQ+U+abLUbVTn5LvUXqtgukIOW9qZ14XEN1a3CHJRLpNyXRhsGgAjhs6MZm9t2ixRHMYgkbdj5PNhwWDasFv1WnPPMI7jvgoNczDms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543864; c=relaxed/simple;
	bh=vYpQ05179Z6Dqt6CQxkP15YpTonyrb52Yz/uOJlilSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gV6CA4IAX70dhf/cKV4NvUl+pPpF06+yebt8QIjM3QAIvKXVr/Ro7WhRBHEDO7At7NXXi3LxGw2TwOuyNYny7TWzM7dWiXbluLjiP6E/Fv/FnjyNkiibwxBXIGSAdALAxnxOCW01dnmHrYloCKXuJcxcolPY4PA9usHkqeQ157M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X45tH63I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023D3C4CECE;
	Mon, 25 Nov 2024 14:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543864;
	bh=vYpQ05179Z6Dqt6CQxkP15YpTonyrb52Yz/uOJlilSM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X45tH63Iyu9/yilJXyNJLXnqQse5SLeXYlL7q1xD9a3ECRkTTPZAkjaZ/O6idayUa
	 wnFSNRa2HbjptJzeG5fTJ37FvKmSGSLIsV6oxHlu0LMRb94yra31zZ1jIP+2Rjjvd7
	 tRDjk9cR87yDY8KPA00ScQyz2WnuglksHM2QNt9vxGM3mNR0yilBPcLHYSdUqa06ZO
	 UnFScyJAZHSWKxy61LXRjI4l2gWFKGsnZiyXKGtTPGaZwPgMyfoWsB39vEz0EaUfAV
	 cRPxn+jNaYthyrZ8mFPNgeZl/14s9OcydS579xGEDm63HXaMAtoSoA+zLaDTuDl+oA
	 mOyg/XRY2uoow==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:15 +0100
Subject: [PATCH v2 19/29] cifs: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-19-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1008; i=brauner@kernel.org;
 h=from:subject:message-id; bh=vYpQ05179Z6Dqt6CQxkP15YpTonyrb52Yz/uOJlilSM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHqmrteKPVzzu/Lekt2KN2pik9aHJd2+zC5xoirPe
 Fep64p1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNZ2M7IcKW0JqZlvdOen4Lp
 y08/n39t+7sN+TERFj69V3+c3ys1XYGR4XW26+MXZfdDNwmnxTfXL/5/M2rOjoMPZWN4Ck8nZTz
 J5wUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

During module init spnego_cred will be allocated with its own reference
which is only destroyed during module exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/client/cifs_spnego.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifs_spnego.c b/fs/smb/client/cifs_spnego.c
index 3f3a662c76fa43c1e843310cc814427bcfd0e821..af7849e5974ff36619405a12e667e7543bb3926f 100644
--- a/fs/smb/client/cifs_spnego.c
+++ b/fs/smb/client/cifs_spnego.c
@@ -157,9 +157,9 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	sprintf(dp, ";pid=0x%x", current->pid);
 
 	cifs_dbg(FYI, "key description = %s\n", description);
-	saved_cred = override_creds(get_new_cred(spnego_cred));
+	saved_cred = override_creds(spnego_cred);
 	spnego_key = request_key(&cifs_spnego_key_type, description, "");
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 
 #ifdef CONFIG_CIFS_DEBUG2
 	if (cifsFYI && !IS_ERR(spnego_key)) {

-- 
2.45.2


