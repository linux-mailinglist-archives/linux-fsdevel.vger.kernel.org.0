Return-Path: <linux-fsdevel+bounces-78026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBVCDyXdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D802D17EC34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 216383136454
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A5F37D127;
	Mon, 23 Feb 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obY6kXoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E67322B9F;
	Mon, 23 Feb 2026 23:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887808; cv=none; b=cDaCmotZRl31TSjIwWTnFa50eIltjCt2VKF1sIEw9glSBfivnI/n3Q5BBrsxm4C0r2ewXFtIT0f/DiXeXtWQFQkF6qrG/3VsYDWQj09p5Q1V8o71dvG23TSGX8h9Y1x7BJnTsE1ckbtQtM9PUH4rVr2b1Yzew+O4YhHCagRKIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887808; c=relaxed/simple;
	bh=zYUGxBAUGQZ14APtW+9iDcNlDgJEFUVKqwT7Jo3QrRE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JQfcnzRtV3rza6wyXT/tVks9DBjYvdzgEW9JJVGCStC8Fr3ogD3IRLKa2OaYDGpsQWRPOHVxaTk112G8fJPSgXr2GHxARs+FuKBBR73XtKfvRyX5dCYj+GskbCvsiOSb2USHBD1qh0YUvYJVUwHy/L+AebhjAXZB9tU08jeMpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obY6kXoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCB31C116C6;
	Mon, 23 Feb 2026 23:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887807;
	bh=zYUGxBAUGQZ14APtW+9iDcNlDgJEFUVKqwT7Jo3QrRE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=obY6kXoIaAYDtNDpkRYDCL5mYoz6nuKc21xV7xUiVsUivjQztuO189WQS7DxM4Tj9
	 B+7e65rosIUJWGcqhn/Vnz2r4HXjSlZ3ur0S17lqdCFoNn4IBCJwJLmNLNNNcn9Agu
	 xvvntwtg1Ukl2UnFrWVCDgxW9LLFxRovqkM+VpJqr79nNptNXI684jxtLa/Gv1I86K
	 zBVkWWogJ77kZD512QF1MEpJ8SjmFqGd1mV4edwTXtED/cLL3F3uGQnvBxV2m5svUW
	 wXG7QPrmxy/KMM0EtdkoJykn+o22DglVtvLJQMetAuj64Xoh5kHuVwx5slwHnY3spF
	 ik0+L+dDP2j8Q==
Date: Mon, 23 Feb 2026 15:03:27 -0800
Subject: [PATCHSET v7 3/6] libfuse: implement syncfs
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188740769.3941738.15253689862800289077.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78026-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D802D17EC34
X-Rspamd-Action: no action

Hi all,

Implement syncfs in libfuse so that iomap-compatible fuse servers can
receive syncfs commands, and enable fuse servers to transmit inode
flags to the kernel so that it can enforce sync, immutable, and append.
Also enable some of the timestamp update mount options.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * libfuse: add strictatime/lazytime mount options
 * libfuse: set sync, immutable, and append when loading files
---
 include/fuse_common.h |    6 ++++++
 include/fuse_kernel.h |    8 ++++++++
 lib/fuse_lowlevel.c   |    6 ++++++
 lib/mount.c           |   18 ++++++++++++++++--
 4 files changed, 36 insertions(+), 2 deletions(-)


