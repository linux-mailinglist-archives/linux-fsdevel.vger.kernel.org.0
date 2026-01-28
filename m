Return-Path: <linux-fsdevel+bounces-75707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOmNGg/ceWmX0QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75707-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 10:51:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DE9F03A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 10:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3704730058F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 09:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E034D3A9;
	Wed, 28 Jan 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNaYgSeQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5292FF169;
	Wed, 28 Jan 2026 09:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769593863; cv=none; b=gNcg5wqRSJXyny6tcZYH6L5/NMDQMnnI0tbZtlZVHo6dh6BJq0bwzwO5abDeti6ut4Cn93fbFS8+Pmyju20YMj6hBOxNK72wqoUsaV8kmn7BIh/xWpWztLtoG6TflUPsV/0d59jHTbxZsVKfUVGRDh12/CkVhMKZBMq64jLLzeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769593863; c=relaxed/simple;
	bh=d8FCYBbyEcRDcsvKBvHb9kc2mz26ZS+2oVeQswS5PPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvDqL9QJ7lJQUbs7KzuSQnaP+lhGeVJoRCESUl50h5d6A+e2BFbaT24fsRT5U6afIdqj6OrEYnwg/ol/X+JXIZKr5U57ETlru5eFkqyGkoAS9shqWBYTAqFthVSRzwuRs85sL1waKjRTI+iTY3njYxxebfxyghIDAuaUKwoCQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNaYgSeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF55C4CEF1;
	Wed, 28 Jan 2026 09:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769593862;
	bh=d8FCYBbyEcRDcsvKBvHb9kc2mz26ZS+2oVeQswS5PPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hNaYgSeQzxJZBAs1VTBOlDcPLXOObVpqfp7jYlt4gZuMHykwu1I5ScXD6IxVu3jzE
	 vUGqTazMCrKxrKXcTB1tPjRJwhd6/1Qkd7VH1eoYgc/a7tC+j2hURVK8V1Wk2dH2S0
	 +L63f0S7I8cCNN0Q9PRR1qdgwwfX4wlnpY63Ev89/6Mban/7Ov7p8AdjTaXaGIDPtj
	 1JjddJSzj3bDlHGwj0B1JEemIG0/G4hj9NtamNLHDTjgVBr/yLER+l+yvRNrD21DFp
	 L9F++mxUc2tRoyNgYZSK6q+/TYiHAW2ERkwncXQxmeA33w/lJ/HL2foWMHVdMP/Rcc
	 sSf/VH1VUVRQA==
Date: Wed, 28 Jan 2026 10:50:57 +0100
From: Carlos Maiolino <cem@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Qu Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: bounce buffer direct I/O when stable pages are required v3
Message-ID: <aXnb17nHHog9z6tC@nidhogg.toxiclabs.cc>
References: <20260126055406.1421026-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126055406.1421026-1-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75707-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nidhogg.toxiclabs.cc:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F40DE9F03A
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 06:53:31AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> [note to maintainers:  we're ready to merge I think, and Christian
> already said he'd do on Friday.  If acceptable to everyone I'd like
> to merge it through the block tree, or topic branch in it due to
> pending work on top of this]

FWIW, no problems from my side with this approach.

Carlos

> 
> this series tries to address the problem that under I/O pages can be
> modified during direct I/O, even when the device or file system require
> stable pages during I/O to calculate checksums, parity or data
> operations.  It does so by adding block layer helpers to bounce buffer
> an iov_iter into a bio, then wires that up in iomap and ultimately
> XFS.
> 
> The reason that the file system even needs to know about it, is because
> reads need a user context to copy the data back, and the infrastructure
> to defer ioends to a workqueue currently sits in XFS.  I'm going to look
> into moving that into ioend and enabling it for other file systems.
> Additionally btrfs already has it's own infrastructure for this, and
> actually an urgent need to bounce buffer, so this should be useful there
> and could be wire up easily.  In fact the idea comes from patches by
> Qu that did this in btrfs.
> 
> This patch fixes all but one xfstests failures on T10 PI capable devices
> (generic/095 seems to have issues with a mix of mmap and splice still,
> I'm looking into that separate), and make qemu VMs running Windows,
> or Linux with swap enabled fine on an XFS file on a device using PI.
> 
> Performance numbers on my (not exactly state of the art) NVMe PI test
> setup:
> 
>   Sequential reads using io_uring, QD=16.
>   Bandwidth and CPU usage (usr/sys):
> 
>   | size |        zero copy         |          bounce          |
>   +------+--------------------------+--------------------------+
>   |   4k | 1316MiB/s (12.65/55.40%) | 1081MiB/s (11.76/49.78%) |
>   |  64K | 3370MiB/s ( 5.46/18.20%) | 3365MiB/s ( 4.47/15.68%) |
>   |   1M | 3401MiB/s ( 0.76/23.05%) | 3400MiB/s ( 0.80/09.06%) |
>   +------+--------------------------+--------------------------+
> 
>   Sequential writes using io_uring, QD=16.
>   Bandwidth and CPU usage (usr/sys):
> 
>   | size |        zero copy         |          bounce          |
>   +------+--------------------------+--------------------------+
>   |   4k |  882MiB/s (11.83/33.88%) |  750MiB/s (10.53/34.08%) |
>   |  64K | 2009MiB/s ( 7.33/15.80%) | 2007MiB/s ( 7.47/24.71%) |
>   |   1M | 1992MiB/s ( 7.26/ 9.13%) | 1992MiB/s ( 9.21/19.11%) |
>   +------+--------------------------+--------------------------+
> 
> Note that the 64k read numbers look really odd to me for the baseline
> zero copy case, but are reproducible over many repeated runs.
> 
> The bounce read numbers should further improve when moving the PI
> validation to the file system and removing the double context switch,
> which I have patches for that will sent out soon.
> 
> Changes since v2:
>  - add a BIO_MAX_SIZE constant and use it
>  - remove a pointless repeated page_folio call
>  - fix a comment typo
>  - add a new comment about copying to a pinned iter
> 
> Changes since v1:
>  - spelling fixes
>  - add more details to some commit messages
>  - add a new code comment about freeing the bio early in the I/O
>    completion handler
> 
> Diffstat:
>  block/bio.c               |  332 ++++++++++++++++++++++++++++------------------
>  block/blk-lib.c           |    9 -
>  block/blk-merge.c         |    8 -
>  block/blk.h               |   11 -
>  fs/iomap/direct-io.c      |  191 ++++++++++++++------------
>  fs/iomap/ioend.c          |    8 +
>  fs/xfs/xfs_aops.c         |    8 -
>  fs/xfs/xfs_file.c         |   41 +++++
>  include/linux/bio.h       |   26 +++
>  include/linux/blk_types.h |    3 
>  include/linux/iomap.h     |    9 +
>  include/linux/uio.h       |    3 
>  lib/iov_iter.c            |   98 +++++++++++++
>  13 files changed, 507 insertions(+), 240 deletions(-)
> 

