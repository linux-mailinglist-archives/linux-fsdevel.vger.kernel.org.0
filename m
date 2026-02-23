Return-Path: <linux-fsdevel+bounces-78036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAGABdvdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78036-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB817ED81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D63030B045F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB0437E2E7;
	Mon, 23 Feb 2026 23:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DgcHj/9y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7437D11D;
	Mon, 23 Feb 2026 23:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887949; cv=none; b=oZjIiSVGWYkNBjKQsYxZO4l/rvvdxdI56b0GtLNgWUDZyP0//7trhMhbScDxSNsMptNRfhzC6ZUfymI8CznuPph0cTcovmGsFJVBpkbCK/+y4tp0FL0UMzVjRRdBDsRjHu8XbkbxURJs77ncG7VlJnEVq7NfcdZ1/coNuiBdreY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887949; c=relaxed/simple;
	bh=qmkb+SBJYQ8ojwyLEVECmDy0+0kXzeVqkC3Dz1g/9t8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvSuOXTRdU4X72VG4d1IUGxGI5ZwvaBKSIjuM0tksrHhONvI7W6B/BXmzU7dJE/MaSHZhlbrFd/exhv4znRFkuKBbYjCiruQ8JPC5/zcX3XaUvZB+V+LOaKMvU3LV9AO2kgNRurn2rQZgHBNNnwoDmcKiZUj3ueOYqXMA6Lh8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DgcHj/9y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F1C116C6;
	Mon, 23 Feb 2026 23:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887948;
	bh=qmkb+SBJYQ8ojwyLEVECmDy0+0kXzeVqkC3Dz1g/9t8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=DgcHj/9ynx4VkjhPz+O4i93E1O/sBBvylJ+idZ9nm6egUim3FZKLT6nIQn3cNxakM
	 NYkoEln/rYySPbCBHinOkd0OpM4hISeim1KIXTCKEd7T0MDcOLxR1i9vxpyuNT+qR4
	 Hh3qQi5fOgdOpibRsYGVG0XBK7a7m5c18WeXdkuOXM6xkIvh4JHSxWKdSWL54iKaXA
	 GtXtLfiJPKlIkGBUKb8UP4pmqrsSz/4Jw7PiaNPcDnvQRq8x45WmA8o9KtVlB166Rv
	 OUNfkD1BQMUz/xTdJxU+ZRyzFkNCk5KH/5zdKT7V4/ryIBygbw6AZu2mNAAmXEVh1H
	 Y0plMQ4izkS/g==
Date: Mon, 23 Feb 2026 15:05:48 -0800
Subject: [PATCHSET v7 6/8] fuse4fs: run servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745924.3944907.12406087337118974135.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78036-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mconfig.in:url,configure.ac:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7EEB817ED81
X-Rspamd-Action: no action

Hi all,

In this series of the fuse-iomap prototype, we package the newly created
fuse4fs server into a systemd socket service.  This service can be used
by the "mount.service" helper in libfuse to implement untrusted
unprivileged mounts.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse4fs-service-container
---
Commits in this patchset:
 * libext2fs: fix MMP code to work with unixfd IO manager
 * fuse4fs: enable safe service mode
 * fuse4fs: set proc title when in fuse service mode
 * fuse4fs: upsert first file mapping to kernel on open
 * fuse4fs: set iomap backing device blocksize
 * fuse4fs: ask for loop devices when opening via fuservicemount
 * fuse4fs: make MMP work correctly in safe service mode
 * debian: update packaging for fuse4fs service
---
 lib/ext2fs/ext2fs.h         |    1 
 MCONFIG.in                  |    1 
 configure                   |  190 +++++++++++++++++++
 configure.ac                |   54 ++++++
 debian/e2fsprogs.install    |    7 +
 debian/fuse4fs.install      |    3 
 debian/rules                |    3 
 fuse4fs/Makefile.in         |   42 ++++
 fuse4fs/fuse4fs.c           |  421 +++++++++++++++++++++++++++++++++++++++++--
 fuse4fs/fuse4fs.socket.in   |   17 ++
 fuse4fs/fuse4fs@.service.in |   99 ++++++++++
 lib/config.h.in             |    6 +
 lib/ext2fs/mmp.c            |   82 ++++++++
 util/subst.conf.in          |    2 
 14 files changed, 902 insertions(+), 26 deletions(-)
 mode change 100644 => 100755 debian/fuse4fs.install
 create mode 100644 fuse4fs/fuse4fs.socket.in
 create mode 100644 fuse4fs/fuse4fs@.service.in


