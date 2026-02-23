Return-Path: <linux-fsdevel+bounces-78022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKB1Jq7cnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:03:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA28117EB65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 530F630CA554
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B3E37D123;
	Mon, 23 Feb 2026 23:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jR//bVeB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A58F34CFC4;
	Mon, 23 Feb 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887745; cv=none; b=VpsiU2qyEWb/0RezZJ26FLC9GTTq6SRdGoS9xFRpT3bPkSIRRHqJck0tKjwYxh6rgJEOKX+vXf//v5wtMHSUwP6yGNheLklz8Ht9zcRmb5nMv+NCND4t2meS+RApqpAX6iltpr9GD6cBhi3cJq5iMwX0rd6Cwdn0wfvGvHUsmMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887745; c=relaxed/simple;
	bh=6KaccDy0qc01Shk7Rw3tLKK0FXf7DHH/K1gRRlfPkvE=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxluZSlGzIvg/x2dtfpyZ192HDVsitLmMhnZJBfIClRqXeNeVtfxbHW8Ys/lOCSEwu56agfnsW1kA18PCOwahQbXxm/Dkq/KFN/LuTmsFa/RKMd0hhx5kMHFqFBJlg+qu98TAAXXuQ2sAY3kOx0F/iJ4Cx037OxaWVIyp59zA/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jR//bVeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63794C116C6;
	Mon, 23 Feb 2026 23:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887745;
	bh=6KaccDy0qc01Shk7Rw3tLKK0FXf7DHH/K1gRRlfPkvE=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=jR//bVeBA17kQaUZy4v7dbP22aqlwBQwRPSNFHHXnacdCcLVDur0P/f+Mmcf2f49p
	 IIrzYrg4qCGDhQL4AqJV5oEK7IjyYelxDlUC2mKQ03LFZ4hE57rpJV7rUpzrPLl7Pi
	 4HF7E8ONajVYvb2AWTXt+XZmvlcY2Vv+eEkgB/crnA+ICOYV72hKRkH828G2PpmGbR
	 CE9ZitXDj3vqtnJt3cxTg8snjNwRzEq/bLx/65fZvx7RqasNExCwFCPqOjkSmcAWHN
	 UoDapqKFV8gzNtt0kWXemLDv1yw5aXhcIUKhaGnP4bRr8IJqj1G/SwELxiGRYmSzKl
	 Ubj2vrsVdxxqg==
Date: Mon, 23 Feb 2026 15:02:24 -0800
Subject: [PATCHSET v7 8/9] fuse: run fuse servers as a contained service
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736492.3938056.12632921710724088507.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78022-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: EA28117EB65
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
 * fuse: allow privileged mount helpers to pre-approve iomap usage
 * fuse: set iomap backing device block size
---
 fs/fuse/fuse_dev_i.h      |   32 ++++++++++++++++++--
 fs/fuse/fuse_i.h          |    7 ++++
 fs/fuse/fuse_iomap.h      |    5 +++
 include/uapi/linux/fuse.h |    8 +++++
 fs/fuse/dev.c             |   13 ++++----
 fs/fuse/fuse_iomap.c      |   72 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/inode.c           |   18 ++++++++---
 7 files changed, 138 insertions(+), 17 deletions(-)


