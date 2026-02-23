Return-Path: <linux-fsdevel+bounces-78037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDVgMuvdnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF9717ED9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64BB830B172C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502737E2E7;
	Mon, 23 Feb 2026 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoVu2nMA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B3C37D134;
	Mon, 23 Feb 2026 23:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887964; cv=none; b=FsikpYoyZRimWapC8M347swHMBS4pvFtUKaqDmF7MhaSc1hlDpF3kJEZPAhCaK7r3JVUSAB9X7TUpBj8hJpTUA6l9g6PiiA12levzCBdCO1fUGxu4OIZ68Ny73bPqsFXBF0UrmC6u2plKv7wMFSGlI+MdAjcfpvH4XdxelDxNoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887964; c=relaxed/simple;
	bh=ZGGJaGQVR3YHi+Nb0zQmXD4NbwM9BLrexoPk8/daqj0=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGQkxPcns5fdQoiRyo67st0Ed2JFTu8NKjbfb+HVP1pTQvy1a8cb/AZIEogGVJdIDllOmBuXbvSaA1bd83OZTlVfNYBNwuFgBSj8jcgOsogrfN1JVilZvRlSyXCnuyrDZB60FCwVnDsBI3wHEpY3qDBu+IUd9wwlQe6uR7e++Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoVu2nMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4F4C116C6;
	Mon, 23 Feb 2026 23:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887964;
	bh=ZGGJaGQVR3YHi+Nb0zQmXD4NbwM9BLrexoPk8/daqj0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=YoVu2nMAXE3UkkrrzQMZBo0jav3hpYGR7Y4qBdkGhQ+J2RE48DP49F9kl31GIKa5L
	 68LTjHpADQ+3T1m2pMU8XyOoDTabCjum2fooDVkcPCftAE4Axe5osxlYlsw3gGdB8r
	 0ojcMSAWqhUWYq7g7dyWhnUbqOutIoP85v+1vHCp7DVFnoBvXbYC272RPJsVPdr8Fl
	 yJS7IZ+7xXZatAOhWohGMVm9kocrU9t3C1wT1oZqxcRJEDONmrQ93BgjQLmYBKtKic
	 eUOir0+jt0Ti04wGabwtYMICeK94Agbou2BC+X/D1G4Ioq1y/Ty+tCyP2WzuDWuIKI
	 Eaf0WdKJm5iqw==
Date: Mon, 23 Feb 2026 15:06:03 -0800
Subject: [PATCHSET v7 7/8] fuse4fs: reclaim buffer cache under memory pressure
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, miklos@szeredi.hu, bernd@bsbernd.com,
 joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <177188746221.3945260.11225620337508354203.stgit@frogsfrogsfrogs>
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
	TAGGED_FROM(0.00)[bounces-78037-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EF9717ED9F
X-Rspamd-Action: no action

Hi all,

Having a static buffer cache limit of 32MB is very conservative.  When
there's plenty of free memory, evicting metadata from the cache isn't
actually a good idea, so we'd like to let it grow to handle large
working sets.  However, we also don't want to OOM the kernel or (in the
future) the fuse4fs container cgroup, so we need to listen for memory
reclamation events in the kernel.

The solution to this is to open the kernel memory pressure stall
indicator files, configure an event when too much time is spent waiting
for reclamation, and to trim the buffer cache when the events happen.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

Comments and questions are, as always, welcome.

e2fsprogs git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/e2fsprogs.git/log/?h=fuse4fs-memory-reclaim
---
Commits in this patchset:
 * libsupport: add pressure stall monitor
 * fuse2fs: only reclaim buffer cache when there is memory pressure
 * fuse4fs: enable memory pressure monitoring with service containers
 * fuse2fs: flush dirty metadata periodically
---
 lib/support/psi.h       |   66 ++++++
 fuse4fs/Makefile.in     |    2 
 fuse4fs/fuse4fs.c       |  263 +++++++++++++++++++++-
 lib/support/Makefile.in |    4 
 lib/support/iocache.c   |   19 ++
 lib/support/psi.c       |  557 +++++++++++++++++++++++++++++++++++++++++++++++
 misc/Makefile.in        |    2 
 misc/fuse2fs.c          |  196 ++++++++++++++++-
 8 files changed, 1089 insertions(+), 20 deletions(-)
 create mode 100644 lib/support/psi.h
 create mode 100644 lib/support/psi.c


