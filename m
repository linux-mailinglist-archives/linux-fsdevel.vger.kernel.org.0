Return-Path: <linux-fsdevel+bounces-78138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHEDOQfknGlNMAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DE17F97F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 769B630D3804
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE13137F8CE;
	Mon, 23 Feb 2026 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ym9J92lp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A16337F72C;
	Mon, 23 Feb 2026 23:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889544; cv=none; b=uYRCAOPgjPBLqz6Nm+42uPJPl66WOjN3Iz8LmiURtgsOX0oFKDfMowaK6Omb+aOFfGIp2ao/qrv1ZmMiMllzfrjgTOcWE7UdG6/eiD8UpsWyexj6scbu9FtmTUoBlX5dzfdSWVnIgbPC6zEYcnF2xtoIrqmypDP5wY+bcRgI5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889544; c=relaxed/simple;
	bh=FH6ODyJsYUv8YKrVXc31OxDGkjUJjRlW6xBoMclfkSI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h4ps3UR2gxTbL6bbE/m3w3fbH9jmaqN/AK/fNlsOUn2cOSXrORK7PhqwU4QQlQPETNPiy9O+PeH7AsOx6ntQTBqEk6923CVtOJpZdkHcXjZpjS+i2zRdxzX2uvSYFABRZWxkLiPzgLxsGp7NXYdRhJKtgSlcJrozdHyZuKFlCtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ym9J92lp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09420C116C6;
	Mon, 23 Feb 2026 23:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889544;
	bh=FH6ODyJsYUv8YKrVXc31OxDGkjUJjRlW6xBoMclfkSI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ym9J92lpnPMaJ9ex1ZTUIJ3FHO20tR/emgJS/XlYMVzI+GVRk9UtiYgdmZ4SIhhGD
	 Nd1ljVDlHnxSBQdgGLHPBoaY+i/tnYlQ0eSmhxETI2ij7TDutQCFHPmWgKbiAKCydx
	 hW4tNhNHRHqtA31JInoKOlpBfozBjOkzYucxDzVWCm/bGko+G4cTZYsjxvtdEzBY0G
	 3H/RfdnMOU7uFo2uqjdYcLJcHYzPeAa3armmPV6SIxCKEDjygBLq+YEamxydqsEyH0
	 MCIWvlOd8NhisKWCuOa9EEBVIeEgG1lhn7qQUmKGfT8R6Fu69YEGln2nrcLUb7dyqK
	 bfADbO6IEylFw==
Date: Mon, 23 Feb 2026 15:32:23 -0800
Subject: [PATCH 1/2] libfuse: add strictatime/lazytime mount options
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740792.3941738.13720566344426625617.stgit@frogsfrogsfrogs>
In-Reply-To: <177188740769.3941738.15253689862800289077.stgit@frogsfrogsfrogs>
References: <177188740769.3941738.15253689862800289077.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78138-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: 638DE17F97F
X-Rspamd-Action: no action

From: Darrick J. Wong <djwong@kernel.org>

fuse+iomap leaves the kernel completely in charge of handling
timestamps.  Add the lazytime and strictatime mount options so that
fuse+iomap filesystems can take advantage of those options.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/mount.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


diff --git a/lib/mount.c b/lib/mount.c
index c82fd4c293ce66..1b20c4eab92d46 100644
--- a/lib/mount.c
+++ b/lib/mount.c
@@ -117,9 +117,16 @@ static const struct fuse_opt fuse_mount_opts[] = {
 	FUSE_OPT_KEY("dirsync",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("noatime",			KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nodiratime",		KEY_KERN_FLAG),
-	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("symfollow",		KEY_KERN_FLAG),
 	FUSE_OPT_KEY("nosymfollow",		KEY_KERN_FLAG),
+#ifdef MS_LAZYTIME
+	FUSE_OPT_KEY("lazytime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nolazytime",		KEY_KERN_FLAG),
+#endif
+#ifdef MS_STRICTATIME
+	FUSE_OPT_KEY("strictatime",		KEY_KERN_FLAG),
+	FUSE_OPT_KEY("nostrictatime",		KEY_KERN_FLAG),
+#endif
 	FUSE_OPT_END
 };
 
@@ -189,11 +196,18 @@ static const struct mount_flags mount_flags[] = {
 	{"noatime", MS_NOATIME,	    1},
 	{"nodiratime",	    MS_NODIRATIME,	1},
 	{"norelatime",	    MS_RELATIME,	0},
-	{"nostrictatime",   MS_STRICTATIME,	0},
 	{"symfollow",	    MS_NOSYMFOLLOW,	0},
 	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
 #ifndef __NetBSD__
 	{"dirsync", MS_DIRSYNC,	    1},
+#endif
+#ifdef MS_LAZYTIME
+	{"lazytime",	    MS_LAZYTIME,	1},
+	{"nolazytime",	    MS_LAZYTIME,	0},
+#endif
+#ifdef MS_STRICTATIME
+	{"strictatime",	    MS_STRICTATIME,	1},
+	{"nostrictatime",   MS_STRICTATIME,	0},
 #endif
 	{NULL,	    0,		    0}
 };


