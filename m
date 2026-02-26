Return-Path: <linux-fsdevel+bounces-78488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAY2NRJSoGnriAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:00:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 450AC1A71FB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 15:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 777023081252
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767F239C658;
	Thu, 26 Feb 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdsJAtPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FDF39B4AD
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113820; cv=none; b=UDJDbuduigx9frTFh6mrLSW1fXxCLlqKyQXlx4oCZappGUKgrq37vyyPrnOwc9bNpWKQS+Ap+kaWbZnHUEceHs9AHetBqrOXtf7U3q+41rvwY7R3yE4s+2ix0oTjuNqaHdafLWZXtXVvltClIU5hra44MYr42l3+nyq7kguoqg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113820; c=relaxed/simple;
	bh=XuIhUtbMGvbqbacU/iJ3K5GDXl3LDdiVUG58PHLoxOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X5kRIF8KvvjkPb3Mk20MX1Olu91et/XMHx1UbEVaky4JER/qL2IsfnL0XiktiizLyo7p8EBT4eASojPj30BAKn1uLS6DxzoTvZKsoSp5ysIwZZlJD4YdqqDZXDoogSk/l5SB+oqchPETo4SeUieYJMMqeSjLvXWCvgp/5sVFdhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdsJAtPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 125DCC116C6;
	Thu, 26 Feb 2026 13:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113819;
	bh=XuIhUtbMGvbqbacU/iJ3K5GDXl3LDdiVUG58PHLoxOk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kdsJAtPaViuWELgXA8iAr5KhwzwSi0PCXmh9aE7nN7jtmNLkxJhW6NpBmrfcmkrXp
	 raL9LYOhJ0Gmv8y5OTIKATEntHiYy9OKNQveFO7bCLrRgoHkZ0OhZydJRvZQx97Xx0
	 OZtSSy7vyPq8NRqdJCkbZl05sx2rkifR1K5Rsi9fhs6nWBCdzpSU6y+Ej7LRO2jmB1
	 0y1H8q6d/Je2aZtuDfUoWqAIRRd43ygZBCQh4PJvVYMCl2lV5O7M6OuMXUEeo52Xo0
	 aQnfIZSDHsB3TbQYcNMZKH2heaX/sw9ikDi/VW2XBnyXOk086hZYg9czi3hM41zlMK
	 lHYIx+l2T6q0g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 26 Feb 2026 14:50:10 +0100
Subject: [PATCH 2/4] nsfs: tighten permission checks for handle opening
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-work-visibility-fixes-v1-2-d2c2853313bd@kernel.org>
References: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
In-Reply-To: <20260226-work-visibility-fixes-v1-0-d2c2853313bd@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=889; i=brauner@kernel.org;
 h=from:subject:message-id; bh=XuIhUtbMGvbqbacU/iJ3K5GDXl3LDdiVUG58PHLoxOk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQu8J9auc7g021voR+SvltnN5bcXrzr67wfezUWbNjhv
 P7vNK++aR2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATeRXMyDCnREKUrW/mcb7X
 Rxlyrbwk61grTgu8XRTxQjjmW0hr/EqGv5JnVuTzuwh5fODbuGqOqeTF3WtFHtmExK+eMNU+zmD
 hVGYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-78488-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[stable.kernel.org:query timed out];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 450AC1A71FB
X-Rspamd-Action: no action

Even privileged services should not necessarily be able to see other
privileged service's namespaces so they can't leak information to each
other. Use may_see_all_namespaces() helper that centralizes this policy
until the nstree adapts.

Fixes: 5222470b2fbb ("nsfs: support file handles")
Cc: stable@kernel.org # v6.18+
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index be36c10c38cf..c215878d55e8 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -627,7 +627,7 @@ static struct dentry *nsfs_fh_to_dentry(struct super_block *sb, struct fid *fh,
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-	if (owning_ns && !ns_capable(owning_ns, CAP_SYS_ADMIN)) {
+	if (owning_ns && !may_see_all_namespaces()) {
 		ns->ops->put(ns);
 		return ERR_PTR(-EPERM);
 	}

-- 
2.47.3


