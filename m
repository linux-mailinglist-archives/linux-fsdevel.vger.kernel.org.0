Return-Path: <linux-fsdevel+bounces-78018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QF2+K07cnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0794217EAE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4F2D530177AF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3D037D122;
	Mon, 23 Feb 2026 23:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQkpX15A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A2334C35;
	Mon, 23 Feb 2026 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887683; cv=none; b=fr29I2IY8ns+8R4WSLaooleVr7SmuAFpaEcjThnCmZUm/Zqf23SBS90Flu/A1zcpWO6jd6ILqZjNbmgs0Kdowrpe5x7q8AdS0aKS1gmoNQrgAFPE8xQh/PClu+ba/mcrpa0ePiw7PJcbHBokD6X0nVhb4ZYI1hqZifcqS9fYJ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887683; c=relaxed/simple;
	bh=J2GYy2oqRLB8i+m2CEpU9vpL6TfRHkQI5sZM1/M+3GY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LM37g7nvSz5BlJCAfeHz/ipKk7T68Y6gQJYv4y/hSYgjSgSXJojscJc+IEuRj8+hs2doKydqJMQiPuFyOJ/+WtHPF4s5QggQU8eLPGQmgyOWeTCMwsXOJdDMwWeRhh/gnV9m5JbPMnjGnOeA37R4Fi3QQ+Ev5267lnGLxUC2tP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQkpX15A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E86C116C6;
	Mon, 23 Feb 2026 23:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887682;
	bh=J2GYy2oqRLB8i+m2CEpU9vpL6TfRHkQI5sZM1/M+3GY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=eQkpX15AIF2dZ87WFSxzybTfk9Xs4F2neJgma7s+nPuCO6DiwH4L346oGkDZE1V/D
	 2bW0nP7t/iUw8hOgTPYNRFzUAkPHLpRY4IphaR9QeF6SOFbSSznx5D3n6jcZ6yCLIz
	 QobVDxDmMhVBs5CV3c9zzn0UXS9rTHzc3l5w0cwcEiUigQcY7DW4kbYu3HWnkY1Gko
	 Tkw2m8fvaDcXIYPfXnrNHqqr7pg3hrFdLnBEeEhAPwhIryxly6GiU1OSusgKpfSraR
	 raW97Hw1jZRBcMsD793V8ZUU+rIahUARZ2r/NWYdC87vbHDyrCKlp6U4jDGz8rq36c
	 tQ1rzMAc8orNA==
Date: Mon, 23 Feb 2026 15:01:22 -0800
Subject: [PATCHSET v7 4/9] fuse: allow servers to use iomap for better file IO
 performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, joannelkoong@gmail.com, bpf@vger.kernel.org,
 bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Message-ID: <177188734044.3935739.1368557343243072212.stgit@frogsfrogsfrogs>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78018-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0794217EAE9
X-Rspamd-Action: no action

Hi all,

This series connects fuse (the userspace filesystem layer) to fs-iomap
to get fuse servers out of the business of handling file I/O themselves.
By keeping the IO path mostly within the kernel, we can dramatically
improve the speed of disk-based filesystems.  This enables us to move
all the filesystem metadata parsing code out of the kernel and into
userspace, which means that we can containerize them for security
without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * fuse: implement the basic iomap mechanisms
 * fuse_trace: implement the basic iomap mechanisms
 * fuse: make debugging configurable at runtime
 * fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse_trace: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add new iomap devices
 * fuse: enable SYNCFS and ensure we flush everything before sending DESTROY
 * fuse: clean up per-file type inode initialization
 * fuse: create a per-inode flag for setting exclusive mode.
 * fuse: create a per-inode flag for toggling iomap
 * fuse_trace: create a per-inode flag for toggling iomap
 * fuse: isolate the other regular file IO paths from iomap
 * fuse: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse_trace: implement basic iomap reporting such as FIEMAP and SEEK_{DATA,HOLE}
 * fuse: implement direct IO with iomap
 * fuse_trace: implement direct IO with iomap
 * fuse: implement buffered IO with iomap
 * fuse_trace: implement buffered IO with iomap
 * fuse: use an unrestricted backing device with iomap pagecache io
 * fuse: implement large folios for iomap pagecache files
 * fuse: advertise support for iomap
 * fuse: query filesystem geometry when using iomap
 * fuse_trace: query filesystem geometry when using iomap
 * fuse: implement fadvise for iomap files
 * fuse: invalidate ranges of block devices being used for iomap
 * fuse_trace: invalidate ranges of block devices being used for iomap
 * fuse: implement inline data file IO via iomap
 * fuse_trace: implement inline data file IO via iomap
 * fuse: allow more statx fields
 * fuse: support atomic writes with iomap
 * fuse_trace: support atomic writes with iomap
 * fuse: disable direct fs reclaim for any fuse server that uses iomap
 * fuse: enable swapfile activation on iomap
 * fuse: implement freeze and shutdowns for iomap filesystems
---
 fs/fuse/fuse_i.h          |   73 +
 fs/fuse/fuse_iomap.h      |  109 ++
 fs/fuse/fuse_iomap_i.h    |   45 +
 fs/fuse/fuse_trace.h      |  974 ++++++++++++++++++
 include/uapi/linux/fuse.h |  235 ++++
 fs/fuse/Kconfig           |   48 +
 fs/fuse/Makefile          |    1 
 fs/fuse/backing.c         |   47 +
 fs/fuse/dev.c             |   42 +
 fs/fuse/dir.c             |  141 ++-
 fs/fuse/file.c            |  122 ++
 fs/fuse/fuse_iomap.c      | 2371 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |  180 +++
 fs/fuse/iomode.c          |    1 
 fs/fuse/trace.c           |    3 
 15 files changed, 4321 insertions(+), 71 deletions(-)
 create mode 100644 fs/fuse/fuse_iomap.h
 create mode 100644 fs/fuse/fuse_iomap_i.h
 create mode 100644 fs/fuse/fuse_iomap.c


