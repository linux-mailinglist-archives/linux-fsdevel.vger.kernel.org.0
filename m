Return-Path: <linux-fsdevel+bounces-79297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPk5Fbl4p2kshwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:11:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB021F8C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 01:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F5153128FDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 00:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA141242D60;
	Wed,  4 Mar 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKehSAVu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F821FCFFC
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Mar 2026 00:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583015; cv=none; b=NF6FRptzowf/tV66Oea6/k2zOluqCGwu2crAXqMMTTIMPqK4WKEgPAeIEXpW4UwybjS8lF7su6tPYF7dTNY+9wY6w0zgqS84etp69UbLIBm13e3L0+JC+XtgpOH8nib4z5oK8UhoXYg2RBNcWxjW9Twb+Zvr4qixHCOgSK/FWhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583015; c=relaxed/simple;
	bh=sOhKbisWaxdxNs1DLXSvelFshcvHFsV9Pm9yLXTVTw8=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=lCTckz3+btd7iFFPdR1U7630EWmO1Pl0KOG47arvYeJSuSu3R8Yw/3QLc762Fc3RdHdtKdJ1u8SUJ3c4hGgejrfFSts3OCEVry3YMVbAfCl3DA1vUPKGPwVGmu9Unw3CF5k2uYqtZ3rDHx8syeghCL2LRHwuUGLzoLEQqeNc2OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKehSAVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2917C2BCB1;
	Wed,  4 Mar 2026 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772583014;
	bh=sOhKbisWaxdxNs1DLXSvelFshcvHFsV9Pm9yLXTVTw8=;
	h=Date:Subject:From:To:Cc:From;
	b=tKehSAVuAX+NzoTzNH+IXtpKMTHKFEPBJEzUSyEm+G/AymkefGVRWfC0LI6S2BK+L
	 X0aKy94OE3Q2D1fn14Op052DJOgNwghSz6L20QKhg6nVdkvmL9REN8mgqTqe0iwoQ6
	 a6/VpHWY21oi64GxcciOiIGVj5FpY1/VQgdGWDZmhXAPU6PQvanX7YVcXAogjsUT6w
	 t+/P0Gj5toUVm0Q4PqI7BNojV5N6jLQYiE1lv4MXhh0ZkTP3vCysTIS88503OY57Bm
	 lq8wsBz1MB8YLNM8bxhDlf5Qc9aSkQoYOZnQQmvjV2yTsjPXBhEHxWhRaALmy2r9Sx
	 2ExyXAto+r9dg==
Date: Tue, 03 Mar 2026 16:10:13 -0800
Subject: [PATCHSET v8] libfuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: miklos@szeredi.hu, neal@gompa.dev, joannelkoong@gmail.com,
 linux-fsdevel@vger.kernel.org, bernd@bsbernd.com
Message-ID: <177258266040.1161627.14968799557253463876.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AFB021F8C0B
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
	FREEMAIL_CC(0.00)[szeredi.hu,gompa.dev,gmail.com,vger.kernel.org,bsbernd.com];
	TAGGED_FROM(0.00)[bounces-79297-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi all,

This patchset defines the necessary communication protocols and library
code so that users can mount fuse servers that run in unprivileged
systemd service containers.  That in turn allows unprivileged untrusted
mounts, because the worst that can happen is that a malicious image
crashes the fuse server and the mount dies, instead of corrupting the
kernel.

Bernd indicated that he might be interested in looking at the fuse
system service containment patches sooner than later, so I've separated
them from the iomap stuff and here we are.  With this patchset, we can
at least shift fuse servers to contained systemd services, albeit
without any of the performance improvements of iomap.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * libfuse: add systemd/inetd socket service mounting helper
 * libfuse: integrate fuse services into mount.fuse3
 * example/service_ll: create a sample systemd service fuse server
---
 include/fuse_service.h       |  180 +++++++
 include/fuse_service_priv.h  |  118 +++++
 lib/fuse_i.h                 |    5 
 util/mount_service.h         |   41 ++
 doc/fuservicemount3.8        |   32 +
 doc/meson.build              |    3 
 example/meson.build          |    7 
 example/service_ll.c         |  823 +++++++++++++++++++++++++++++++++
 example/service_ll.socket.in |   16 +
 example/service_ll@.service  |   99 ++++
 include/meson.build          |    4 
 lib/fuse_service.c           |  859 ++++++++++++++++++++++++++++++++++
 lib/fuse_service_stub.c      |   91 ++++
 lib/fuse_versionscript       |   15 +
 lib/helper.c                 |   53 ++
 lib/meson.build              |   14 +
 lib/mount.c                  |   57 ++
 meson.build                  |   37 +
 meson_options.txt            |    6 
 util/fuservicemount.c        |   66 +++
 util/meson.build             |   13 -
 util/mount.fuse.c            |   58 +-
 util/mount_service.c         | 1056 ++++++++++++++++++++++++++++++++++++++++++
 23 files changed, 3617 insertions(+), 36 deletions(-)
 create mode 100644 include/fuse_service.h
 create mode 100644 include/fuse_service_priv.h
 create mode 100644 util/mount_service.h
 create mode 100644 doc/fuservicemount3.8
 create mode 100644 example/service_ll.c
 create mode 100644 example/service_ll.socket.in
 create mode 100644 example/service_ll@.service
 create mode 100644 lib/fuse_service.c
 create mode 100644 lib/fuse_service_stub.c
 create mode 100644 util/fuservicemount.c
 create mode 100644 util/mount_service.c


