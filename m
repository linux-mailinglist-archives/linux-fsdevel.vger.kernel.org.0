Return-Path: <linux-fsdevel+bounces-78023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOPlBencnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78023-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A967117EBA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 179E131203B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354E837D13E;
	Mon, 23 Feb 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXpTH9W6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E796334C35;
	Mon, 23 Feb 2026 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887761; cv=none; b=nSLS0oFE8U7XoiNOW9PkQzhieKiFCON0AI/mpaFM25pzmw5qaRYaUvShJwy83ZZdAOEjcmsr662TCIwc9gV0ap8vJRIy4J+0XGEWm/cZfDFl44OgBV8OPchD6Fgj8JGwViZVvT+UvSERnS6Fv7vZ5B4u+CyXH9tLl0UYON+mNL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887761; c=relaxed/simple;
	bh=icioDdUw7adyz75g3/0RUCgFlwco5oQ9dEvohY1Znys=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hm3g66+sR/qJU2zUFR2JFqtQu87ZlWoXYBrRpQf38EGlKpi0WfcMo45SaYnEjaTQalThW997HCu9n+y/FnlOoB/rHPblKXil2eJWdY3mF1KES4pxpxZnPUGA31OYOKmR3ezyx1MVm7lBnVynzaJc1r7c9EVyfO7aGGDLTIPOaXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXpTH9W6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FCAC116C6;
	Mon, 23 Feb 2026 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887761;
	bh=icioDdUw7adyz75g3/0RUCgFlwco5oQ9dEvohY1Znys=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=JXpTH9W6YUC0Fdd1F/WHRUy6ErrdnlzSsa9dRVkRntNnslKEO70oq4Eb4tIScdQuB
	 W+Muqt61S2pscZd/jPbsY7BsiLkPmpUn19DP1C8JqATHHpdeKwMZ5yjfFtXi9RG4IF
	 x/OddPLOULMS37GhlOWIcsyQCOkIbetl7BftQiKTa5URxL3sxCOvOmkSKClIU+wYXt
	 S9XpTNJ2k4Y2RCLRdX5SLLIPBmiV+N4+wH1CMevI8Hb83SMcxPRy53cqP5lHEm7WXh
	 cnvBXZJ+CsTbbgfA1t5yYM7mMApvbgC+Ojf1/zmRQtGOfO891CUoq8Wffo7TlP0h9Z
	 MF2OK80LIt08w==
Date: Mon, 23 Feb 2026 15:02:40 -0800
Subject: [PATCHSET RFC 9/9] fuse: allow fuse servers to upload iomap BPF
 programs
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: bpf@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org,
 john@groves.net, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188736765.3938194.6770791688236041940.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,groves.net,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78023-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A967117EBA9
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

Now with kfuncs to manage the cache, and some ability to restrict
memory access from within the BPF program.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-bpf
---
Commits in this patchset:
 * fuse: enable fuse servers to upload BPF programs to handle iomap requests
 * fuse_trace: enable fuse servers to upload BPF programs to handle iomap requests
 * fuse: prevent iomap bpf programs from writing to most of the system
 * fuse: add kfuncs for iomap bpf programs to manage the cache
 * fuse: make fuse_inode opaque to iomap bpf programs
---
 fs/fuse/fuse_i.h         |    5 
 fs/fuse/fuse_iomap_bpf.h |  123 ++++++++++++
 fs/fuse/fuse_iomap_i.h   |    6 +
 fs/fuse/fuse_trace.h     |   53 +++++
 fs/fuse/Makefile         |    4 
 fs/fuse/fuse_iomap.c     |   17 +-
 fs/fuse/fuse_iomap_bpf.c |  464 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c          |    7 +
 fs/fuse/trace.c          |    1 
 kernel/bpf/btf.c         |    1 
 10 files changed, 676 insertions(+), 5 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap_bpf.h
 create mode 100644 fs/fuse/fuse_iomap_bpf.c


