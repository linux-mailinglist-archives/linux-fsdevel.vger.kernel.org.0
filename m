Return-Path: <linux-fsdevel+bounces-78198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIF6Hu/nnGmNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF64180091
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B941731A0FD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429737FF7F;
	Mon, 23 Feb 2026 23:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="METznMWI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD7377542;
	Mon, 23 Feb 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890468; cv=none; b=Fv5coz7Q9FBCDAzuSxpD+pM0rH4wUkNRUsYb5WACdm/7G9qtcLUR7WkWfZfMXJXJpITFqKUlcf80ElL1lHB5ucxZVPBGQgM0s5p6TY5IKySBah1ZTLTLlXeDFMgO13QOHC2ojzlcjeK+/6ehNZU9aqtGt4nbEQtY71tzassU/Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890468; c=relaxed/simple;
	bh=Y78+slMp+5qzvnZm34CfK8taFmTiOwxvApEUUirPRBI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejTNSezaEUwCGRt2Ie1uyTQR852ayAYbJE8LQqZL6L7mMcqe2vEVKFHoUVz3Lu6WTAL8hpl+SKvJhy3kVjoG0vFDcVlVFncyNc/H5Cu3DukiZUdZjphyAo/pp9+J/RL/zFK0HA84SyKgnK8nqW7d6RI6eDWXv1+63BESXfwxN6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=METznMWI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FECDC116C6;
	Mon, 23 Feb 2026 23:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890468;
	bh=Y78+slMp+5qzvnZm34CfK8taFmTiOwxvApEUUirPRBI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=METznMWIutwAE5E7l92605/fYTEPod4he2Eezex42Qv/X5ZW+ofyBIGIfUeEi3N8c
	 73Yohjf2eKZRmiYu6qLyOYBQoIWXwUUvaCo/p7q2BXA299T4VcebIedJ3QbP5TAN2w
	 QWKx6qNsb5GWsyxQg1sZd21bdmhRlG+IlBhVGFZsovALsnunb/MfZNmCKtFslAHHTz
	 f03fgqzkWDQ0QdpZq3UvYFAvi6zGbEyD9+K3KKhhok12r++klMqwGl0bPp4nBJr0oR
	 VUP+CPl40tp3LUjFyUAkblKehpg13uTu/58Tb4xoKdMdvQiJXSf66l1zH5ctIBJ7d0
	 TSHrY4I+ktLOg==
Date: Mon, 23 Feb 2026 15:47:48 -0800
Subject: [PATCH 6/8] fuse4fs: ask for loop devices when opening via
 fuservicemount
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746063.3944907.1063997145938318266.stgit@frogsfrogsfrogs>
In-Reply-To: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
References: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78198-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1CF64180091
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

When requesting a file, ask the fuservicemount program to transform an
open regular file into a loop device for us, so that we can use iomap
even when the filesystem is actually an image file.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/fuse4fs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index 9d8dfde95e7256..e3d1e080822e16 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -1522,7 +1522,8 @@ static int fuse4fs_service_get_config(struct fuse4fs *ff)
 
 	do {
 		ret = fuse_service_request_file(ff->service, ff->device,
-						open_flags, 0, 0);
+						open_flags, 0,
+						FUSE_SERVICE_REQUEST_FILE_TRYLOOP);
 		if (ret)
 			return ret;
 


