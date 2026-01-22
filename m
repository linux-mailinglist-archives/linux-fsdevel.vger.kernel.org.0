Return-Path: <linux-fsdevel+bounces-75012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KE53JmcFcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:09:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F1A65BDB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A15AD6A8122
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E233F23AD;
	Thu, 22 Jan 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMb8lRA4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326103EDAB1
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078942; cv=none; b=anbsVJOX17Z9jFdyltF5UOwkMGKeRmMtyToxs8J0eUnWCx5dzr7Mc0KsRuffLu5NO4rNgead94pUKeNaLrEkmQORJLMDfkx9XNH8v5xqHrqMGkF1Y9GKc+jctmXHCmIKnzLvcnitjlubhr3evzQxF3IRlGSCWtpvBkspUkYqPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078942; c=relaxed/simple;
	bh=q6rvAuThfFofcVLlcoc2seQw0GKn9QEt15arZOxmVx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9kuNdJ7F7IeWGpOcjubi0Kqu5+ofasqzNDJ4fUSnMg3QgPMff6ws8N+HH84AMscOlabu3CGUFRXID+nQkXc2HPKupO9nKA5w7C6r2n+Yz8B6P04peTEpiOBA4Am4Fp8xBAMpkIQvp68J/X/drNUHUUqezOHJJ0VLqhqxm0ZjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMb8lRA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82CDC19424;
	Thu, 22 Jan 2026 10:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078941;
	bh=q6rvAuThfFofcVLlcoc2seQw0GKn9QEt15arZOxmVx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMb8lRA44OMc5BZ65/BGkNtnxYt1pQkpo3/lNcwGb4H8dZXv9/Yb+2oLbH0/WRkqm
	 O1W6rbjlOgHdPK1xUtMI0VDYEKWSC4UzPnxl099ufGB7KdI1YgeY+NkglWdx0AWxMy
	 EqqqvTYhDBD3CVmoeLiTvvKQdakB+ABrt+icuh927frhDGUSBtUBzVepMqkmO0cUWU
	 i/6rPci63bXgpnFo5ZJnSkebE8k+r0aEcAzr7B5tjJthMF3fawEmXfBV7LMUDc9bJv
	 1uDdf77PEs85A58gE3AVT9ha/IaRz49FQdwEGyFgJy0iZVAloQFofnvtzye7PDVnzR
	 pUxp5X7g5QR4g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:46 +0100
Subject: [PATCH 1/7] mount: start iterating from start of rbtree
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-1-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=brauner@kernel.org;
 h=from:subject:message-id; bh=q6rvAuThfFofcVLlcoc2seQw0GKn9QEt15arZOxmVx8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMcxQbl2x/vy/R5aXv9e8+/Or4sVitZvv+Hrsl0z3P
 NXj9OLK545SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ5AYy/Pc1DzifI5mr7Dwt
 guudnovWJ3MhJc1TKf2aUp9TCrWfnWBkWFCfqc5y/88ra697X1b++2+U2XZi0twKl9f5izo11Dv
 +MgMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-75012-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 50F1A65BDB
X-Rspamd-Action: no action

If the root of the namespace has an id that's greater than the child
we'd not find it. Handle that case.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 59557019e422..695ea0c37a7b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5645,14 +5645,14 @@ static int grab_requested_root(struct mnt_namespace *ns, struct path *root)
 	if (mnt_ns_empty(ns))
 		return -ENOENT;
 
-	first = child = ns->root;
-	for (;;) {
-		child = listmnt_next(child, false);
-		if (!child)
-			return -ENOENT;
-		if (child->mnt_parent == first)
+	first = ns->root;
+	for (child = node_to_mount(ns->mnt_first_node); child;
+	     child = listmnt_next(child, false)) {
+		if (child != first && child->mnt_parent == first)
 			break;
 	}
+	if (!child)
+		return -ENOENT;
 
 	root->mnt = mntget(&child->mnt);
 	root->dentry = dget(root->mnt->mnt_root);

-- 
2.47.3


