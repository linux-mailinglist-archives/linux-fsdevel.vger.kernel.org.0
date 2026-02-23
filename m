Return-Path: <linux-fsdevel+bounces-78024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPtxE//cnGl/LwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A540617EBC9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 00:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C18312B1D7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7884D37D124;
	Mon, 23 Feb 2026 23:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Baqa2pS7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0352C322B9F;
	Mon, 23 Feb 2026 23:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887777; cv=none; b=XbvG1EsKVLRs6Ek/4EqbkMlQEwh9m3C3ZfcVgWVXK7GBg6mwN3PORi6KUPpBgImViOhRtYjrTNmAVOk0QYHhM35GWco6RvVcfv16PE1YKGQWtrx13csBciJMcTbuUrSnNtlhvNBjSBmO7mCFWQKqvTBWp2NWzJtL841C0iX2vN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887777; c=relaxed/simple;
	bh=Kk/15/vglEwp/q6XDg/+grl9ZfdoXYhXdEEH+AUN0ec=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JA27HV5hrXhNDHBkiNWfBli5XblMfxqCnzdgglImor87aOIZ5Ci09XcMp5XHLQSPTtZck4zfwrl4f0TXmuT6Gfmc29m5xcwIiPNLYCXalrkbCHBf6KtWeEcJW7kMheMbonL3VUekh6yKhj/dKD0VXxyfKueqFL9oOAH1sV9448M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Baqa2pS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFB3C116C6;
	Mon, 23 Feb 2026 23:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887776;
	bh=Kk/15/vglEwp/q6XDg/+grl9ZfdoXYhXdEEH+AUN0ec=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Baqa2pS7K1C7MM1pOfRUxzgwBjNySFxdpzG7EfXJe1C8mFzim1ORacDv5SUY2Y5n4
	 aydlLsF0OAsEb/SKDvanLt/16BM9i/hoV/YdTgHzwcJyY083SJKifVGdHctAcUtN6Q
	 WbUE+vaGiGQX25m0r5vkLNJq2jGlPxri8yGhKHnv9TKTdcvEXD3tWXJaN10KyiXyju
	 bzwEigb5KYHuoQwrVYDwp7UzY1ELwIQST2ypH0PAYmn6J9i3WsuE5zy7KJ+s//EiEj
	 i2OiEvTdgbdtzYXsyuTPYrKxPnw33uvJEWA4vnjjryMvHta7Z8sk4qY3m05fL0adeE
	 iV3qgcDHNQujw==
Date: Mon, 23 Feb 2026 15:02:56 -0800
Subject: [PATCHSET v7 1/6] libfuse: allow servers to use iomap for better file
 IO performance
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: bernd@bsbernd.com, miklos@szeredi.hu, neal@gompa.dev,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bpf@vger.kernel.org, joannelkoong@gmail.com
Message-ID: <177188739839.3940670.15233996351019069073.stgit@frogsfrogsfrogs>
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
	FREEMAIL_CC(0.00)[bsbernd.com,szeredi.hu,gompa.dev,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-78024-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meson.build:url]
X-Rspamd-Queue-Id: A540617EBC9
X-Rspamd-Action: no action

Hi all,

This series connects libfuse to the iomap-enabled fuse driver in Linux to get
fuse servers out of the business of handling file I/O themselves.  By keeping
the IO path mostly within the kernel, we can dramatically improve the speed of
disk-based filesystems.  This enables us to move all the filesystem metadata
parsing code out of the kernel and into userspace, which means that we can
containerize them for security without losing a lot of performance.

If you're going to start using this code, I strongly recommend pulling
from my git trees, which are linked below.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D

kernel git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-fileio
---
Commits in this patchset:
 * libfuse: bump kernel and library ABI versions
 * libfuse: wait in do_destroy until all open files are closed
 * libfuse: add kernel gates for FUSE_IOMAP
 * libfuse: add fuse commands for iomap_begin and end
 * libfuse: add upper level iomap commands
 * libfuse: add a lowlevel notification to add a new device to iomap
 * libfuse: add upper-level iomap add device function
 * libfuse: add iomap ioend low level handler
 * libfuse: add upper level iomap ioend commands
 * libfuse: add a reply function to send FUSE_ATTR_* to the kernel
 * libfuse: connect high level fuse library to fuse_reply_attr_iflags
 * libfuse: support enabling exclusive mode for files
 * libfuse: support direct I/O through iomap
 * libfuse: don't allow hardlinking of iomap files in the upper level fuse library
 * libfuse: allow discovery of the kernel's iomap capabilities
 * libfuse: add lower level iomap_config implementation
 * libfuse: add upper level iomap_config implementation
 * libfuse: add low level code to invalidate iomap block device ranges
 * libfuse: add upper-level API to invalidate parts of an iomap block device
 * libfuse: add atomic write support
 * libfuse: allow disabling of fs memory reclaim and write throttling
 * libfuse: create a helper to transform an open regular file into an open loopdev
 * libfuse: add swapfile support for iomap files
 * libfuse: add lower-level filesystem freeze, thaw, and shutdown requests
 * libfuse: add upper-level filesystem freeze, thaw, and shutdown events
---
 include/fuse.h          |  102 ++++++++
 include/fuse_common.h   |  143 +++++++++++
 include/fuse_kernel.h   |  147 ++++++++++++
 include/fuse_loopdev.h  |   27 ++
 include/fuse_lowlevel.h |  305 ++++++++++++++++++++++++
 lib/fuse_i.h            |    4 
 ChangeLog.rst           |    5 
 include/meson.build     |    4 
 lib/fuse.c              |  591 +++++++++++++++++++++++++++++++++++++++++++----
 lib/fuse_loopdev.c      |  403 ++++++++++++++++++++++++++++++++
 lib/fuse_lowlevel.c     |  560 +++++++++++++++++++++++++++++++++++++++++++--
 lib/fuse_versionscript  |   23 ++
 lib/meson.build         |    7 -
 meson.build             |   13 +
 14 files changed, 2251 insertions(+), 83 deletions(-)
 create mode 100644 include/fuse_loopdev.h
 create mode 100644 lib/fuse_loopdev.c


