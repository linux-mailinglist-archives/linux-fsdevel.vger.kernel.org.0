Return-Path: <linux-fsdevel+bounces-78137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F6aL/rjnGn4LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 793A317F978
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3577130CB027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B04537F8CA;
	Mon, 23 Feb 2026 23:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYiyrFea"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA41369980;
	Mon, 23 Feb 2026 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889528; cv=none; b=GpA3CMoOOW0Fjs3DrPCHQGqo+YWg+vYVz2mLc0bPM7ehJ8FrCEL052V+ET5mc6eB+VbHlCwm5J0kjFY8hZGKCuQdyVQSyBZ97/RiHhXcBtxCygvetmpVzdheG7sNUsW+m56IAam8lkSWErJOi/5KEgxL0JOvkt2VLaQSSOR0Rb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889528; c=relaxed/simple;
	bh=c9Y4NQbeJAGNlZ1TUgRQpy+3epgjsb72D3vk+v4IgWs=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PL+8Qjc23wGIeX5Mq6oivdMOF7HP8MqleQPYX1nSs9hLEgzAdWQoI2fVAThBQAfiKGsk97kOh2gtb5ozGl+1ICy95g+tPh6q7auJOWN1rYmp1eCKOG5Rmk8q/6wb8JBCuxtgHvr0/F9Wbgimht04vIu8YKVwA6qYgKUPmCJEHDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYiyrFea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E8C116C6;
	Mon, 23 Feb 2026 23:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889528;
	bh=c9Y4NQbeJAGNlZ1TUgRQpy+3epgjsb72D3vk+v4IgWs=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=iYiyrFeaPX0VsN78GH4Uov5iaW780tbmT45QR98PNI6LyCC3prnQHZH4agVfQCqYg
	 obzl2gX/IUKqfPKHodisTCBZppfv4Ks/c+EC6+mIDGwB5XEXTe9j/YGcL55KdF6c4v
	 pSP608PlFHOu8unkD/1hPUdNQGPhXV+wrNyhZAeyUn6FNUcPOeraIfPGK0B3M8Sk1V
	 2uwAzwKPJKMsIka+ol9eVTHvgFcn0yFpzDnjHGF2g/mcQpabYOGHAwyRcfmqSRkXtC
	 JY7uzPQgatTm4lzBTvBOwsMGqfl2SUVgyCVCKzZ35hE4ukcoyNPxgFYzMqJ8S+aykx
	 L3fN3hHDY49Dw==
Date: Mon, 23 Feb 2026 15:32:07 -0800
Subject: [PATCH 1/1] libfuse: allow root_nodeid mount option
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740582.3941636.4880458250773757289.stgit@frogsfrogsfrogs>
In-Reply-To: <177188740565.3941636.4202428671967258488.stgit@frogsfrogsfrogs>
References: <177188740565.3941636.4202428671967258488.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78137-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 793A317F978
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

Allow this mount option so that fuse servers can configure the root
nodeid if they want to.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |    1 +
 1 file changed, 1 insertion(+)


diff --git a/lib/mount.c b/lib/mount.c
index 7a856c101a7fc4..c82fd4c293ce66 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -100,6 +100,7 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("defcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("rootcontext=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("max_read=",		KEY_KERN_OPT),
+	FUSE_OPT_KEY("root_nodeid=",		KEY_KERN_OPT),
 	FUSE_OPT_KEY("user=",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-n",			KEY_MTAB_OPT),
 	FUSE_OPT_KEY("-r",			KEY_RO),


