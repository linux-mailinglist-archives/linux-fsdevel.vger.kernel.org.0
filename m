Return-Path: <linux-fsdevel+bounces-79545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KZUNJUSqmnFKgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F42194E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Mar 2026 00:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EAEF3026B61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 23:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9517236C0D7;
	Thu,  5 Mar 2026 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB1g9v7Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FBA36C0BA;
	Thu,  5 Mar 2026 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772753472; cv=none; b=PMiqWys2CoYLrgJ287sJM8SAyTIYYM61ZAKvpfbSXkjzHG7qTVfrGKy6wEu21w/ZDUNHxcEeOyuYq/b/+m302cM4VInb+E/PgKursxCiv6H9iTzdBlH0uc8HPejmrPVlrhQEaVxFyl8dGrAxG718lwhsOT/uWVNin3KD04gUt4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772753472; c=relaxed/simple;
	bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mVY4Q/eDSVjRcxjIbM42bmThly5bQiRHQX7MXvgvFObpX6qUUJ5bH3+tje0+yoJWkYRNLcnJ7EMLeTbfwRbrxSOBkvM23yXH8Kp8aWpwpmpyGjYDiEW2oui2eOfqnCPgKrlB2WKAq+FGXxGUiBDpUBgjJNO/9cTCNv3s1K7oC3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB1g9v7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E557EC19423;
	Thu,  5 Mar 2026 23:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772753472;
	bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KB1g9v7YNo2cA5LeGftvekrvEjpF6FqnB/NDLsnF04wG4bVMhWyWdenXwEi8YzdTu
	 Zzlqr2sA2PSNBJGSE2dO7HGMYE5QMCTdfM7l+Ys8wHsOXWf4n+uy7j+ysrNq9Ft12x
	 E9E+1G84CYzF+0weUXpW3yrI2yHDUGsShw5bsSkVycnPjwS8mmBEM8BPhED1C9SH5B
	 /noyRtjci8xfFDs+tElqlvDKZ8BSTXna1KOfugtOV89pbGA+vpqs9w6/vkIJoDwR/O
	 PuCeFwWTaRRucpcVuEnupg7RdWnGZ963iBNYyC3GD9eSaC/gh8FhxIKiC5+nym62KS
	 kHP4m0EuHuw0Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 06 Mar 2026 00:30:23 +0100
Subject: [PATCH RFC v2 20/23] devtmpfs: create private mount namespace
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260306-work-kthread-nullfs-v2-20-ad1b4bed7d3e@kernel.org>
References: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
In-Reply-To: <20260306-work-kthread-nullfs-v2-0-ad1b4bed7d3e@kernel.org>
To: linux-fsdevel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>, 
 Tejun Heo <tj@kernel.org>, Jann Horn <jannh@google.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=792; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LEkYCP2B26VM04U/Xfgf30JgLqLChdLWXV57GkA2dNs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSuEuJy3csm/W8Rm6p7/AmmpRdiQlncdVk1zu9vY5s+q
 b76wb6ZHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJ/sjI0GGnvvropTn2jgrR
 Wb+PfNr4r5Mhdsq9g5VLnMykY7U3/GH4Z/Ql2HF5yPGL0r+05m77fWXG5zgLzq0e76cEmpcd0s9
 MZQQA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Queue-Id: 831F42194E8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79545-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Kernel threads are located in a completely isolated nullfs mount.
Make it possible for a kthread to create a private mount namespace so it
can mount private filesystem instances. This is only used by devtmpfs.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/base/devtmpfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index b1c4ceb65026..246ac0b331fe 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -413,7 +413,7 @@ static noinline int __init devtmpfs_setup(void *p)
 {
 	int err;
 
-	err = ksys_unshare(CLONE_NEWNS);
+	err = kthread_mntns();
 	if (err)
 		goto out;
 	err = init_mount("devtmpfs", "/", "devtmpfs", DEVTMPFS_MFLAGS, NULL);

-- 
2.47.3


