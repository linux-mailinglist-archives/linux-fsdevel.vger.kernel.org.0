Return-Path: <linux-fsdevel+bounces-78028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPacBuPcnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B240117EB9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B70E3301C573
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D3B37D12B;
	Mon, 23 Feb 2026 23:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UpI772UX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EA7330B22;
	Mon, 23 Feb 2026 23:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887839; cv=none; b=aFU8O2WYXbi8lvvlr+mv/AVjbd9uAXq2uVmHSTZtN5PnG2K9j1DZ4aRNoDiHODAihulrIYorzwKbB6zTT84I7jDPmvDKgD4UcUPGGp5hzOMij+byNq5/h2y+Ej55DMzt5DHFn9Ilw65XgzLOAO4FKKB53I4eZjQlEv6ZXPh+reU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887839; c=relaxed/simple;
	bh=ZM/OlRDmd00KCo3Het/kb7CP3Z0mwSRFYcG7IK3QxE4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V4TShXIv6+XeSeS3ozf385OdXqbxixyckEJRaBRXAL/yzDJtfcBQMHVbWSK93SyCUQCKhsUTNF3szpNLIg53/KrPMBpDxzzlDmT4Cbd9bIgbKSb+ef+M3IuEWgbXfwEQzz2w4oA+LqVZQlBamJqQk+NvWDs4UZow8mtyH2vzvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UpI772UX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4FDC116C6;
	Mon, 23 Feb 2026 23:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887839;
	bh=ZM/OlRDmd00KCo3Het/kb7CP3Z0mwSRFYcG7IK3QxE4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=UpI772UXsSKKvpolDWdys7Kx6XkRmapLuIKrU4pq5qdA2tIwYBesUPv14KNH1hGXE
	 80Yb4C29PutPwO/GKuKCUWGkHMCKdpKPtfnJ8CFbQlNRFxP6YQcsub4omLRofqnX4C
	 q+Na9o02983+HJoNsHxhN0iTJWcDd8ZoB/L9xqscmq5UHyX7hQDeMrlpxZqmPd3XIn
	 isGmBJH8TaTOqcCttKDkaipn/yXKPDSrF4pqAZ2wS7/QjaOxh2/nlu+VCx02qQSgRH
	 8MPzyS92ZpiAONATMDciK/xOHSW+rFw8WLYPgeZ9gazQ1zA5v0jQC8HVwu7/WYM69A
	 MPFUgASPA0zig==
Date: Mon, 23 Feb 2026 15:03:58 -0800
Subject: [PATCHSET v7 5/6] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188741298.3942122.15899633653835028664.stgit@frogsfrogsfrogs>
In-Reply-To: <20260223224617.GA2390314@frogsfrogsfrogs>
References: <20260223224617.GA2390314@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78028-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B240117EB9B
X-Rspamd-Action: no action

Hi all,

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.  As part of the delegation, add a new ioctl allowing any process
with an open fusedev fd to ask for permission for anyone with that
fusedev fd to use iomap.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-service-container
---
Commits in this patchset:
 * libfuse: add systemd/inetd socket service mounting helper
 * libfuse: integrate fuse services into mount.fuse3
 * libfuse: delegate iomap privilege from mount.service to fuse services
 * libfuse: enable setting iomap block device block size
 * fuservicemount: create loop devices for regular files
---
 include/fuse_kernel.h       |    8 
 include/fuse_lowlevel.h     |   22 +
 include/fuse_service.h      |  170 +++++++
 include/fuse_service_priv.h |  127 +++++
 lib/fuse_i.h                |    5 
 util/mount_service.h        |   41 ++
 doc/fuservicemount3.8       |   32 +
 doc/meson.build             |    3 
 include/meson.build         |    4 
 lib/fuse_lowlevel.c         |   16 +
 lib/fuse_service.c          |  848 +++++++++++++++++++++++++++++++++
 lib/fuse_service_stub.c     |   91 ++++
 lib/fuse_versionscript      |   15 +
 lib/helper.c                |   53 ++
 lib/meson.build             |   14 +
 lib/mount.c                 |   57 ++
 meson.build                 |   36 +
 meson_options.txt           |    6 
 util/fuservicemount.c       |   66 +++
 util/meson.build            |   13 -
 util/mount.fuse.c           |   58 +-
 util/mount_service.c        | 1100 +++++++++++++++++++++++++++++++++++++++++++
 22 files changed, 2749 insertions(+), 36 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c


