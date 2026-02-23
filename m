Return-Path: <linux-fsdevel+bounces-78104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGw7A3/hnGnCLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B74DF17F437
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2052730670A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E6337F755;
	Mon, 23 Feb 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHudbhKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD1737C11B;
	Mon, 23 Feb 2026 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889013; cv=none; b=oiiHG+fJZblT5ci3sAhSM6zEcYNR9TAa42w0lm2vLDZ8EsZJ6D2u2Wp0zl/72QtoZeEk1B4HE6Dmu9k61377RroncpiHdku0KcJCzUycdRxt/fEenAhlNE3oqVVgdx6IrjFvmTUMmm8qbaFsBybCX1xL75EzEnyuMDPQsE6Rlso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889013; c=relaxed/simple;
	bh=nuf3QmyBILckZ1Pf9VT72we/H3KEh64qSMboYQ8Bn4I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ajf/Dn4ijFfjahbATGNfWfBE/hZ9eF2bWeGol1E2ESHmGA4CUcmYSE91vJJVB8jOaAyq0fMVkCka6dMUIpniDySAgYY+KJtWLwx5/K/vJQ0Fxxfvxoxg2ndRsIh/drqxWqk7/i2ZqQcyA/snq5cVR5p6F0gznuWrh1OiG1Yax6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHudbhKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C656DC19421;
	Mon, 23 Feb 2026 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889012;
	bh=nuf3QmyBILckZ1Pf9VT72we/H3KEh64qSMboYQ8Bn4I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DHudbhKw/8E6docyT9Ur8OnPc+8dZdNVQbuwUEzBITKTVxF/2dznq/c8MzO1VM/Zd
	 r7eqIbnb0W/j486I3uxZ1uaIGfYrFxWNn8jjWngG7T0ZhCSBZCG4A2OTjTlyS2Oag3
	 qkSpvkQ+O654JhiKbj+GmhKdTIMGI7xR6tmq0j7NFjbQ8eF5SsyhUqYfLq8UcPrWfG
	 TyX9ozrkEtToeQ8SaGV9D81iuk+7I+d2arzPJrtfadxhH7XnzAf7lw4OQX6rm+DtKT
	 4uYFLj7sXw4EWByqWWXf0iQIoDWBHE4C5fZ85uHzlthNfA9tKVdWOMu4RNSfU5h3r/
	 OVM9cGud+JKFA==
Date: Mon, 23 Feb 2026 15:23:32 -0800
Subject: [PATCH 12/12] fuse: enable iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736284.3937557.8344378038031610480.stgit@frogsfrogsfrogs>
In-Reply-To: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
References: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78104-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B74DF17F437
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Remove the guard that we used to avoid bisection problems.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.c |    3 ---
 1 file changed, 3 deletions(-)


diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 8fad9278293bff..74bd18bb4009c6 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -70,9 +70,6 @@ MODULE_PARM_DESC(debug_iomap, "Enable debugging of fuse iomap");
 
 bool fuse_iomap_enabled(void)
 {
-	/* Don't let anyone touch iomap until the end of the patchset. */
-	return false;
-
 	/*
 	 * There are fears that a fuse+iomap server could somehow DoS the
 	 * system by doing things like going out to lunch during a writeback


