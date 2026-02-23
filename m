Return-Path: <linux-fsdevel+bounces-78035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHPyEZvdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C50D517ED1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFBC3309D08E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B037E308;
	Mon, 23 Feb 2026 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htTuIbZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7690437E2F9;
	Mon, 23 Feb 2026 23:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887933; cv=none; b=FpVY5igmrg984fh7zZRPgASHm1gJg5OcFDhAc6NCX1TnIGCfhvea1S/SjLP5JCPGwISy6np84ly0u7LPpU9BtAGoYV9he8D465yTsNNA4ZJkIOLNO69Zs7qKmjvuixKMzQ2Q6GGHQ154CuW5pNMiGqJ+gagLA3Lfe5YOVP5VtVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887933; c=relaxed/simple;
	bh=erLnXXKfazJyfXqyTBmDRoDs7EW0FYC/FDwshxrCEvw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f2e1nvjCM5dLXHlL0rG7P5TG8rODBGrmQcq3Y25+RQvpwPyAZLaNGNeuyLUXZ0Mx3YfbmTKXNi4BkwO5lIq0IyedZMt8wsLe6OugBU9zam2HfK+7tzW7RsY6CM6pDEJxwOk+XGD5xbi2SzkAo2YDgOXDyKtgGLnQqyjZk3fmVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htTuIbZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FAE8C2BC86;
	Mon, 23 Feb 2026 23:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887933;
	bh=erLnXXKfazJyfXqyTBmDRoDs7EW0FYC/FDwshxrCEvw=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=htTuIbZl5jCRnLsS9kaUpXQejQuutrqFLijlFPoG4ZP6XE3rQYx7agK+GRoWMmbmL
	 KlwUuGXHsdjYXM5svbRl2XlV87pPyvYQOy2/uRpnmXTSqumJti8rmVMUQaNZXUxr6/
	 bbgDTbxJoqBfM7bOxgA4SXstkzWohwQznk5cBykMm2YaPKVCDtenSyblZ4FCPfaH1x
	 cF78DdcLwX/QFmRuP0bIuOfhCgosFeK6HezZ6ZpIVuzdIIfuIZ6YRkNV6YUall4OYj
	 1sy9u5jGaHgjTzrQes7T7CZGmInhHDEXDOrpDYgKk8EjQKtjgxeL+Ppeh9u+v3H1Eh
	 aci6KoXaIjbQA==
Date: Mon, 23 Feb 2026 15:05:32 -0800
Subject: [PATCHSET v7 5/8] fuse2fs: improve block and inode caching
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188745668.3944626.16408108516155796668.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,szeredi.hu,bsbernd.com,gmail.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78035-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C50D517ED1B
X-Rspamd-Action: no action

Hi all,

This series ports the libext2fs inode cache to the new cache.c hashtable
code that was added for fuse4fs unlinked file support and improves on
the UNIX I/O manager's block cache by adding a new I/O manager that does
its own caching.  Now we no longer have statically sized buffer caching
for the two fuse servers.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse2fs-caching
---
Commits in this patchset:
 * libsupport: add caching IO manager
 * iocache: add the actual buffer cache
 * iocache: bump buffer mru priority every 50 accesses
 * fuse2fs: enable caching IO manager
 * fuse2fs: increase inode cache size
 * libext2fs: improve caching for inodes
---
 lib/ext2fs/ext2fsP.h     |   13 +
 lib/support/cache.h      |    1 
 lib/support/iocache.h    |   17 +
 debugfs/Makefile.in      |    8 
 e2fsck/Makefile.in       |   12 -
 fuse4fs/Makefile.in      |   11 -
 fuse4fs/fuse4fs.c        |    8 
 lib/ext2fs/Makefile.in   |   70 ++--
 lib/ext2fs/inline_data.c |    4 
 lib/ext2fs/inode.c       |  215 ++++++++++---
 lib/ext2fs/io_manager.c  |    3 
 lib/support/Makefile.in  |    6 
 lib/support/cache.c      |   16 +
 lib/support/iocache.c    |  765 ++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in         |   12 -
 misc/fuse2fs.c           |   10 +
 resize/Makefile.in       |   11 -
 tests/fuzz/Makefile.in   |    4 
 tests/progs/Makefile.in  |    4 
 19 files changed, 1068 insertions(+), 122 deletions(-)
 create mode 100644 lib/support/iocache.h
 create mode 100644 lib/support/iocache.c


