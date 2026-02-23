Return-Path: <linux-fsdevel+bounces-78021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMXTK5ncnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:02:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 478DC17EB50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CFB4309A609
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F7737D125;
	Mon, 23 Feb 2026 23:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlEKWH63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D637D118;
	Mon, 23 Feb 2026 23:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887730; cv=none; b=YuLOCrBN4HuZLudRJBkOQGzI8G8L9+3Q/R+1ONH8wl/4YgDsmytPMHR7eZ3w44dJ0INpqoSUBFXX9QSVq+hozBQ+f5+0TQ+kP3q0VqJUXBl12qzHijeGoysplTBNd2MhkNq8zDq7QeJVsfx6zY7X7uEecB3Gr9a3//WtA+dDFt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887730; c=relaxed/simple;
	bh=rRZa/TjZk1gj1Mqh+GaH7PWF5+nwU/+wpCkzpoCOX9k=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6UP7Q8eJvs3qH+rDCzckxBf9XS/CGESUWVFIe+FhmkxsWJRaYytmKgvLeII28nlTRPtPpRC1PktsULjD0k7r947ghcoXDSep3QXDvFptGSKBxSjEUa0+uiLXi2ZEsP05ZudfTO7xvVShnM8vuuci/0/F0aYqM5Zw62iTUVQ5JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlEKWH63; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B71CEC19421;
	Mon, 23 Feb 2026 23:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887729;
	bh=rRZa/TjZk1gj1Mqh+GaH7PWF5+nwU/+wpCkzpoCOX9k=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=PlEKWH635MpKZS6v9g1z94qoqa0tcKewY4zHcJIBbTgniIqFPuavT9YI19PlVyHAW
	 dcDB5VZNoo7vg37jdUE4VCCYxoAcGXsyNxbd8hQxfHw+7czN7wz8Tjj5E3HUljWymZ
	 y8rlOApiI5wEgYLAcLUaw6k30B07/gzCrt5bSvU6gPZfhymAoWOcd7AvgSqmNOMHdk
	 BW/fD2k0dtNr5BhXCVSAtP1nd01+o2mp7AwGFTWE/dLaD4rNGPpD9HZlDFgpYEAA7u
	 bV49+L/N0aIhMy0ZUYo/h8LJmNjyCp+PeHihVewPYT/QjY11eI9fImqpiINUublSoK
	 BYlKFOvFzbApw==
Date: Mon, 23 Feb 2026 15:02:09 -0800
Subject: [PATCHSET v7 7/9] fuse: cache iomap mappings for even better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735954.3937557.841478048197856035.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78021-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 478DC17EB50
X-Rspamd-Action: no action

Hi all,

This series improves the performance (and correctness for some
filesystems) by adding the ability to cache iomap mappings in the
kernel.  For filesystems that can change mapping states during pagecache
writeback (e.g. unwritten extent conversion) this is absolutely
necessary to deal with races with writes to the pagecache because
writeback does not take i_rwsem.  For everyone else, it simply
eliminates roundtrips to userspace.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
---
Commits in this patchset:
 * fuse: cache iomaps
 * fuse_trace: cache iomaps
 * fuse: use the iomap cache for iomap_begin
 * fuse_trace: use the iomap cache for iomap_begin
 * fuse: invalidate iomap cache after file updates
 * fuse_trace: invalidate iomap cache after file updates
 * fuse: enable iomap cache management
 * fuse_trace: enable iomap cache management
 * fuse: overlay iomap inode info in struct fuse_inode
 * fuse: constrain iomap mapping cache size
 * fuse_trace: constrain iomap mapping cache size
 * fuse: enable iomap
---
 fs/fuse/fuse_i.h           |   11 
 fs/fuse/fuse_iomap.h       |   10 
 fs/fuse/fuse_iomap_cache.h |  121 +++
 fs/fuse/fuse_trace.h       |  445 +++++++++++
 include/uapi/linux/fuse.h  |   41 +
 fs/fuse/Makefile           |    2 
 fs/fuse/dev.c              |   46 +
 fs/fuse/file.c             |   18 
 fs/fuse/fuse_iomap.c       |  533 +++++++++++++
 fs/fuse/fuse_iomap_cache.c | 1797 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/trace.c            |    1 
 11 files changed, 3002 insertions(+), 23 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap_cache.h
 create mode 100644 fs/fuse/fuse_iomap_cache.c


