Return-Path: <linux-fsdevel+bounces-66808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB601C2CCD2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 16:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2824652C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0032AACB;
	Mon,  3 Nov 2025 14:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3MQpftP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C37327786;
	Mon,  3 Nov 2025 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181879; cv=none; b=ZRN7LzuuEtEsZvq2iMdHEnlBhnUXLfCqDK3NNWNMY7idZS+5ylZhyWe2oT8SGiNx17jwn1xNQce+uaBBhqF4D17tmcqMcw3jjluKlwBXxKxBwoluRXai8ss7NxpxhsfA4FRQ0cIvjoCcfc2Qh8zScskQu2sP2vr0pJdYa+uRfJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181879; c=relaxed/simple;
	bh=2r6XwBdE0iLPZEXMmxkQmO5kEwjt0ojjL2pn4vmivn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CiEOJT4GbZ53DhZG+d1kgXDJ5562PxsjmG+Rh3wFILmNw2hPKkZXCZkBYxnn1lp7k3lnUp2xJcHUZn7biFMPrNTK0GqUlkDm8sPQcjlZOt0T40MABQT0LywEK1ExCjuoemoOCpqupAEjrYmtQdxqmVvD6Hi4YKSPGnwvWeviYJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3MQpftP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA4FAC116B1;
	Mon,  3 Nov 2025 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762181878;
	bh=2r6XwBdE0iLPZEXMmxkQmO5kEwjt0ojjL2pn4vmivn4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=s3MQpftPaJnXwoXay0TuEM3GQOP0qNMElUdNNxQ3VSDTxJNZ0o1pxV7Zah//h9Fb0
	 takiJgBfHtw+6pAcLl89M8RFgURS9kFwrEYk14tB6nEwBelMY130P3bDkvOLCicHmw
	 09WwSQh4BIPrkpTz2XIPKE12kmNnAUXjzCwilzjR5HZ+yUIVcSF+Df41oQHXTWerxH
	 5i+vHTmB2SepfDbTuCJJIUOzQJBrkgcqu/jq5Kt+LyOm+5x0laSTeAhxNqEQNy8Q2Q
	 fWKohrWZBXsLOmlGIMndvFJfdSnwUUf3idT27CiY6e5LJUJ5cnpiJhAAZVGkrPOcbU
	 uGherGB3g2jfQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 15:57:29 +0100
Subject: [PATCH 03/12] sev-dev: use prepare credential guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-prepare_creds-v1-3-b447b82f2c9b@kernel.org>
References: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
In-Reply-To: <20251103-work-creds-guards-prepare_creds-v1-0-b447b82f2c9b@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2r6XwBdE0iLPZEXMmxkQmO5kEwjt0ojjL2pn4vmivn4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyHHrxwK71ZMbFrb8PXdDnFNW5cZDbLmClQoSdmGlD7
 Q+eG/JrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS+paRYVnc2SvG9W9cb94p
 X/jDLzJdxCEix9Jyxs2bJ5/K32Du2snIsKG7mMPzwtmtrcccj8pMXvlDwWv94tPnYh9n3Zs97Wl
 OJiMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the prepare credential guard for allocating a new set of
credentials.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index c5e22af04abb..09e4c9490d58 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -268,15 +268,16 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	get_fs_root(init_task.fs, &root);
 	task_unlock(&init_task);
 
-	cred = prepare_creds();
+	CLASS(prepare_creds, cred)();
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
+
 	cred->fsuid = GLOBAL_ROOT_UID;
 	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
 
-	put_cred(revert_creds(old_cred));
+	revert_creds(old_cred);
 
 	return fp;
 }

-- 
2.47.3


