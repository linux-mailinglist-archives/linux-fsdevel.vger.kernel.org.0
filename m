Return-Path: <linux-fsdevel+bounces-78038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPKFCPjdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D73A217EDCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7527309021F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAB537E2E5;
	Mon, 23 Feb 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shXIkTgZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D733783BB;
	Mon, 23 Feb 2026 23:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887980; cv=none; b=XI5H7iS0Tr3QLs2ZjtCqvB+ZZoZu5zd1c6+UEIZ6+QtYhDs8Bl4mVzvhqvNn/T5mp23zb8ZsVuNtywaAVGO++vCsiyjGjZKSBiq7TEFN0ExpFhamRGJKw3/V1mpdNVugzN7IIVh9dJngbO2XBgSDHXe/qvVx0yzPWAZuDQu5c4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887980; c=relaxed/simple;
	bh=S0TIIHQbWoh3WRThQgH3A+tB+LKNoGPamg4ZaFOYtw4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYKenRvVoq3+T3VuWd/9Qw8LlA+3lo6a//5PH3HtYS3Ti0tUXFvMh3wfCfd3Hgrl4dgb72mqfH6nAOVV66bS4Zi6sOGE1KXyX3LYyT++rOJPovaDIdS3syP/LsLVJlSpYTjRx5trc3SCFbQC+1uL3oSu9W72ceR7yeS2erGrAt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shXIkTgZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BB7C19421;
	Mon, 23 Feb 2026 23:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887980;
	bh=S0TIIHQbWoh3WRThQgH3A+tB+LKNoGPamg4ZaFOYtw4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=shXIkTgZnrBF1z9o+iUbSURvvNeOkAbAABwtssarraunPudkNDN+u8TT6N5S1jyJM
	 x4KMJe7cgdS78k2GUOZPTLp579Nx/EMUuxLSEeTJXkxnWsvLdayq7p4kjRVZf//G15
	 DaqHC/Y0fWsjlQQAs+42YDVZHQHYxBj0SjxAI1bJhtAGy3SHPdU5BrPjvECDo5JV6R
	 60pLCbJ/foVCLA/JiqkM1wZWNv6AaN4lszejkp+mqZYV4AOfsT+x55cqZNrjjn4qKC
	 uAjSGhMu/XkprOx0P/aeJchttOHBOrhy8A5l6D1gNCW/1oDYAWdThqKODDnJwTho33
	 8VFHhbAN0va7A==
Date: Mon, 23 Feb 2026 15:06:19 -0800
Subject: [PATCHSET RFC 8/8] fuse: allow fuse servers to upload iomap BPF
 programs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev, john@groves.net
Message-ID: <177188746460.3945469.14760426500960341844.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev,groves.net];
	TAGGED_FROM(0.00)[bounces-78038-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mconfig.in:url,configure.ac:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D73A217EDCF
X-Rspamd-Action: no action

Hi all,

There are certain fuse servers that might benefit from the ability to
upload a BPF program into the kernel to respond to ->iomap_begin
requests instead of upcalling the fuse server itself.

For example, consider a fuse server that abstracts a large amount of
storage for use as intermediate storage by programs.  If the storage is
striped across hardware devices (e.g. RAID0 or interleaved memory
controllers) then the iomapping pattern will be completely regular but
the mappings themselves might be very small.

Performance for large IOs will suck if it is necessary to upcall the
fuse server every time we cross a mapping boundary.  The fuse server can
try to mitigate that hit by upserting mappings ahead of time, but
there's a better solution for this usecase: BPF programs.

In this case, the fuse server can compile a BPF program that will
compute the mapping data for a given request and upload the program.
This avoids the overhead of cache lookups and server upcalls.  Note that
the BPF verifier still imposes instruction count and complexity limits
on the uploaded programs.

Note that I embraced and extended some code from Joanne, but at this
point I've modified it so heavily that it's not really the original
anymore.  But she still gets credit for coming up with the idea and
engaging me in flinging prototypes around.

More recently, this patchset has changed strategies -- instead of
compiling a static BPF program with very limited functionality, we
instead compile it on the fly, which allows for dynamic behavior.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-bpf

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse-iomap-bpf
---
Commits in this patchset:
 * fuse4fs: add dynamic iomap bpf prototype which will break FIEMAP
 * fuse4fs: wire up caching examples to fuse iomap bpf program
 * fuse4fs: adjust test bpf program to deal with opaque inodes
---
 fuse4fs/fuse4fs_bpf.h |   54 +++++++
 MCONFIG.in            |    5 +
 configure             |  188 +++++++++++++++++++++++
 configure.ac          |   94 +++++++++++
 fuse4fs/Makefile.in   |   22 ++-
 fuse4fs/fuse4fs.c     |   92 +++++++++++
 fuse4fs/fuse4fs_bpf.c |  404 +++++++++++++++++++++++++++++++++++++++++++++++++
 lib/config.h.in       |   12 +
 8 files changed, 869 insertions(+), 2 deletions(-)
 create mode 100644 fuse4fs/fuse4fs_bpf.h
 create mode 100644 fuse4fs/fuse4fs_bpf.c


