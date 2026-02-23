Return-Path: <linux-fsdevel+bounces-78020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG4QD4TcnGkrLwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:02:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7017EB22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA1C5306D894
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57F537D121;
	Mon, 23 Feb 2026 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibII9DNt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDEC3793D5;
	Mon, 23 Feb 2026 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887714; cv=none; b=DGToGiOZ1vUv5q1bH8bqYMqzB3LTHe/adypH2DtRXoXI1Qb+wWetfSQU5y5aDe66S2Xp1vfjg4W5LAizIk3eEK0nODDwKi9DSjyzK+xA0piHn1ieKs/EQVuK4cQSafaJQ3yTu+kW0tJIjJLs+929osf64q4TOahWW40aXWaKnrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887714; c=relaxed/simple;
	bh=HNzjiYS49TpmpEftdTXqNK0ZxbVEl1HShY7RAtreUJ8=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azwy+DVDyzAKuheEtqBj2sVM5S5IlmfOeFSAXgAJawRKq5ZGTJpAhzIHm/t2esRja62NECh17lpFpwqpsQSbxvYyHXqr62bboz0zO9BMOE+PIQUCBFLPgVTqe3s8cqegs62Oq+GX63VMksNQFTCksiGHmVfioPJ9OIWV6zv1Bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibII9DNt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA1C116C6;
	Mon, 23 Feb 2026 23:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887714;
	bh=HNzjiYS49TpmpEftdTXqNK0ZxbVEl1HShY7RAtreUJ8=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ibII9DNt5GUvZFpMAI2uo2lH0Sxo40imHjd4YGvw3002d/khTakR3jYyjt71OLdJe
	 emFGTyC8V5+zvPuVg9K4p76U5wFvNwwWxkPGz52wEIigTNhdkPfNz0BEPpjt6v69Je
	 IV2yy1fzqM08AGmhqg7kuab+r5hdl2t3p8UZBwxwtFh0OsW0oYBvk1kOITN9md0wsL
	 IRPcit05UDV2LXqcfEalir28RkrrmRgkl9gAYhoofE3XcNyIGg2UeMM6RIVybY/mAW
	 kxZCV1LI++KE1DV1XXG7GAUPfxypzfnAFLNO20WfoLN+OHx6/V8T0vlTgaQTrIBy72
	 E9xsipx780qQQ==
Date: Mon, 23 Feb 2026 15:01:53 -0800
Subject: [PATCHSET v7 6/9] fuse: handle timestamps and ACLs correctly when
 iomap is enabled
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: joannelkoong@gmail.com, bpf@vger.kernel.org, bernd@bsbernd.com,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <177188735474.3937167.17022266174919777880.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-78020-lists,linux-fsdevel=lfdr.de];
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
X-Rspamd-Queue-Id: D6E7017EB22
X-Rspamd-Action: no action

Hi all,

When iomap is enabled for a fuse file, we try to keep as much of the
file IO path in the kernel as we possibly can.  That means no calling
out to the fuse server in the IO path when we can avoid it.  However,
the existing FUSE architecture defers all file attributes to the fuse
server -- [cm]time updates, ACL metadata management, set[ug]id removal,
and permissions checking thereof, etc.

We'd really rather do all these attribute updates in the kernel, and
only push them to the fuse server when it's actually necessary (e.g.
fsync).  Furthermore, the POSIX ACL code has the weird behavior that if
the access ACL can be represented entirely by i_mode bits, it will
change the mode and delete the ACL, which fuse servers generally don't
seem to implement.

IOWs, we want consistent and correct (as defined by fstests) behavior
of file attributes in iomap mode.  Let's make the kernel manage all that
and push the results to userspace as needed.  This improves performance
even further, since it's sort of like writeback_cache mode but more
aggressive.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs
---
Commits in this patchset:
 * fuse: enable caching of timestamps
 * fuse: force a ctime update after a fileattr_set call when in iomap mode
 * fuse: allow local filesystems to set some VFS iflags
 * fuse_trace: allow local filesystems to set some VFS iflags
 * fuse: cache atime when in iomap mode
 * fuse: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse_trace: let the kernel handle KILL_SUID/KILL_SGID for iomap filesystems
 * fuse: update ctime when updating acls on an iomap inode
 * fuse: always cache ACLs when using iomap
---
 fs/fuse/fuse_i.h          |    1 +
 fs/fuse/fuse_trace.h      |   87 +++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/fuse.h |    8 ++++
 fs/fuse/acl.c             |   30 +++++++++++++---
 fs/fuse/dir.c             |   38 ++++++++++++++++----
 fs/fuse/file.c            |   18 ++++++---
 fs/fuse/fuse_iomap.c      |   12 ++++++
 fs/fuse/inode.c           |   19 +++++++---
 fs/fuse/ioctl.c           |   68 +++++++++++++++++++++++++++++++++++
 fs/fuse/readdir.c         |    5 ++-
 10 files changed, 262 insertions(+), 24 deletions(-)


