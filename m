Return-Path: <linux-fsdevel+bounces-76530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLZaAPt3hWngBwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:11:23 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B40C5FA4D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 06:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E2EC3047BDD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 05:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37362335549;
	Fri,  6 Feb 2026 05:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1IMEstX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E12566F7;
	Fri,  6 Feb 2026 05:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770354504; cv=none; b=BNtA5eNCBIoe5zXLlydOEXnXGUEL1Zxwm3QFIetnxg4G0BDRRIqhbQYTFm5U2UAqlvje2Ke6rY6EqdvK24iSUucy3XYMrnJsienbBbN+IaqBqAF/yN821Qxpx6o8JdkfoyRZdm1GeQS8l9WQMcZu0ClxlYFDE7F6dlOxjNUn1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770354504; c=relaxed/simple;
	bh=5r1188wOZURECbikQQr8y9/QSvjuH4VdpBK6Jgg2LaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFHPOkmoTyd0GO1KgkY9hFcLXdfqqv2ZPV5uxQpcGWMogwLUGSxzfXCtazLxtBPFnhu+bMyATX9lbdCbNWxb+3IV3D/Ntg8O92R6c7/SmxvBINJjfU1h4AGRfHkmVuPqOsH5KatbF5cZgMD6RgIEMKiYCGQTOj1nSF2Hi2q2kD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1IMEstX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7CFC116C6;
	Fri,  6 Feb 2026 05:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770354504;
	bh=5r1188wOZURECbikQQr8y9/QSvjuH4VdpBK6Jgg2LaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g1IMEstXe8FVKUybW18pYvi194FqLBqSFaIfovwOuFNWp/LGxl7eWxRpWxe6fO4ub
	 IugZLBmyuCP4YgjTeX/rukhovXsZ7q/qcT3cUuYq9en2/ZXMTfGBS2ihT4Fo1FdZmq
	 G4sXrKBU6I2b4cAN2v/lZ389oezf7AA9ktXUJ71tv9UOP2k3xQCBXq+LqX2WeVuQla
	 NRbqTAuRtvHh5drXrI4AOzeXajzxVrQkw7acf2zSmJBDfxRFqOPz4ErCjUEYzkQbHO
	 H8xjQgskvSyWKrHHmfk/LCtHR1wwyEWGxM5iVEGhOPdUwuB1iS3Ple0ZH11RRaKnDy
	 SQdkVo63YTJoA==
Date: Thu, 5 Feb 2026 21:08:23 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
Message-ID: <20260206050823.GH1535390@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
 <20260205192011.2087250-1-clm@meta.com>
 <20260206020832.GE7686@frogsfrogsfrogs>
 <91881ad9-62c0-48c1-9cfd-e6cba6ddb587@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91881ad9-62c0-48c1-9cfd-e6cba6ddb587@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76530-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B40C5FA4D5
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 09:52:29PM -0500, Chris Mason wrote:
> On 2/5/26 9:08 PM, Darrick J. Wong wrote:
> > On Thu, Feb 05, 2026 at 11:19:11AM -0800, Chris Mason wrote:
> >> "Darrick J. Wong" <djwong@kernel.org> wrote:
> >>> From: Darrick J. Wong <djwong@kernel.org>
> >>>
> >>> Start implementing the fuse-iomap file I/O paths by adding direct I/O
> >>> support and all the signalling flags that come with it.  Buffered I/O
> >>> is much more complicated, so we leave that to a subsequent patch.
> >>>
> >>
> >> Hi everyone,
> >>
> >> I'm trying out my AI review prompts on a few more trees, and I ran it
> >> on the fuse-iomap-cache branch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache 
> > 
> > I should mention: I appreciate you rolling out the AI reviews by slowly
> > expanding the number of trees you scan for bugs.
> 
> Thanks, I'm trying not to send unsolicited AI unless it feels like it's
> mostly right.  I did discard one false positive, which looked accurate
> but also looked like intended behavior.
> 
> Now that the false positive rate is pretty reasonable, I'll try to
> collect some fs/* Fixes: tagged patches and see if I can teach claude
> how to spot the bugs.  In past kernel-wide scans, it gets ~35%, which is
> better than 0, but not as good as I was hoping for.

<nod> You've found some very good bugs, especially in the fuse-iomap
branch!  At some point I'm going to have to figure out how to run these
tools myself, but until then you're quite welcome to keep scanning my
dev trees. :)

I wonder, have you tried it on non-kernel repos like e2fsprogs (ha!) or
fstests?

> [ ... ]
> 
> >>> +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
> >>> +				 enum fuse_ilock_type type)
> >>> +{
> >>> +	struct inode *inode = file_inode(iocb->ki_filp);
> >>> +
> >>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
> >>> +		switch (type) {
> >>> +		case SHARED:
> >>> +			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
> >>> +		case EXCL:
> >>> +			return inode_trylock(inode) ? 0 : -EAGAIN;
> >>> +		default:
> >>> +			ASSERT(0);
> >>> +			return -EIO;
> >>> +		}
> >>> +
> >>> +		return 0;
> >>> +	}
> >>
> >> This isn't a bug, but the 'return 0;' after the switch statement inside
> >> the IOCB_NOWAIT block is unreachable since every switch case returns.
> > 
> > gcc is too stupid to detect that it's impossible to reach this case and
> > whines about the lack of a return.
> 
> Oh that's great.

I know, right? :(

--D

> -chris
> 

