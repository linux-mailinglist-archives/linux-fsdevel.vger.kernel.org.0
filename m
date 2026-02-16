Return-Path: <linux-fsdevel+bounces-77283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DUeE6sdk2mM1gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3918143E59
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 14:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21E84308DC72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 13:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC95A3115A2;
	Mon, 16 Feb 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiPhr6vn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752130F552;
	Mon, 16 Feb 2026 13:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771248768; cv=none; b=Je+3EYx7YvnrJXcEQVQAN0RAqmnNIYiY0m5Mk5bccB4mzoRIzqaxXhETzYct56Aygntu21zi8vHigwQ+r9F5XWOhr35K/7992zWNwfbY29W793AbpUZTjipv44SqKUWKARCpqpCvmwGV4aCRwbu0V5pzyxWnBCSDpH85zsRCh68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771248768; c=relaxed/simple;
	bh=UGS1CMJ2ZqHjOV5UFVesoa2erJ7ZK4K3eqstwjrfN6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a18LQeHCzbIkFOtBqBw4iTNrjtqvuIqiimg9D2kknN0JSNbjkGko4ZTf2OBMg7N614pBKivG+0x20A9N+3rGlus9dqBXDc3dUqOdr0J7EN/mbMR0bXwNTf+HeHmqbrtLqV1bKi353rggDHPKRz7ShOluJxaHnBeWb5fTsl0QLLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiPhr6vn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26B7C19423;
	Mon, 16 Feb 2026 13:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771248768;
	bh=UGS1CMJ2ZqHjOV5UFVesoa2erJ7ZK4K3eqstwjrfN6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TiPhr6vn5MwWVSkOJv3YQl6S+YMB3GTyKrqaBvoIHCOVFVlId5zQ51AYLutQPHDNM
	 hEE37rv7bajB/M8roxxMiv+JcR4Dv87prqre4Re+6uLLj4/gV7NVVYSOtNyxAJ2q2T
	 mI1+iVb5sRdT6hybvU1q1a6FZK13ieKXJIa5c24VNOw8IRdM6t4sh3apUfmvVeWszK
	 9JpwsGvTrks93gn24gx05ZCSCoUPOvl6bDV4Ugip7ehjkdc2DDU+ta89hyBoBMiMsp
	 V3M/6wdbAciIt6MDl9acNM1+IrEPlEh6ZAodpyeYNhNtd9+RvyG7bT3G1baMhS9wGe
	 WtO5stfcFvORA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 16 Feb 2026 14:32:04 +0100
Subject: [PATCH 08/14] xattr: switch xattr_permission() to switch statement
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-work-xattr-socket-v1-8-c2efa4f74cb7@kernel.org>
References: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
In-Reply-To: <20260216-work-xattr-socket-v1-0-c2efa4f74cb7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
 linux-mm@kvack.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Tejun Heo <tj@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Jann Horn <jannh@google.com>, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182; i=brauner@kernel.org;
 h=from:subject:message-id; bh=UGS1CMJ2ZqHjOV5UFVesoa2erJ7ZK4K3eqstwjrfN6M=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWROlom7r3xTgsWCs13dmLdvkdeWCf9iTmy2fslg9iVwN
 tdipjcPOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyo4uRoctEMG7jo3uVzvs8
 3/HZrSnvMPGYJ3W90fNWyQG297WpZxn+V75jVduyUZ/vfIbm8ee8ckdDSgMmPxaYkR79/Zxx5dI
 JvAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77283-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F3918143E59
X-Rspamd-Action: no action

Simplify the codeflow by using a switch statement that switches on
S_IFMT.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/xattr.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index c4db8663c32e..328ed7558dfc 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -152,12 +152,20 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 	 * privileged users can write attributes.
 	 */
 	if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN)) {
-		if (!S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-			return xattr_permission_error(mask);
-		if (S_ISDIR(inode->i_mode) && (inode->i_mode & S_ISVTX) &&
-		    (mask & MAY_WRITE) &&
-		    !inode_owner_or_capable(idmap, inode))
+		switch (inode->i_mode & S_IFMT) {
+		case S_IFREG:
+			break;
+		case S_IFDIR:
+			if (!(inode->i_mode & S_ISVTX))
+				break;
+			if (!(mask & MAY_WRITE))
+				break;
+			if (inode_owner_or_capable(idmap, inode))
+				break;
 			return -EPERM;
+		default:
+			return xattr_permission_error(mask);
+		}
 	}
 
 	return inode_permission(idmap, inode, mask);

-- 
2.47.3


