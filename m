Return-Path: <linux-fsdevel+bounces-78300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OtnGYL7nWmeSwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:26:58 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 014A418C11F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 20:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CCEC3083CCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 19:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC03ACA6D;
	Tue, 24 Feb 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EdYOvBOV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665D723B61E;
	Tue, 24 Feb 2026 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961214; cv=none; b=mo2hZrgmt/9NYcLBOMM0C1v0EgBrQwHjXipl1yoCCQo4y2/DAVjyHnue4gsOhAYYzmCVoKjrW2BHnMx7YT8rzQkX10DPsZi0BZg0+Ad+J+3VEshHVNLFt6jwyoTEjjOtBe6Dmiighvdvgv26VItvmZn9wYqeFExpExkyBQZj7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961214; c=relaxed/simple;
	bh=AK2nBN3Be9xo4tmnm1/I5Kipk+48q1ddOgsuldsT8Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFlH0wysrcFJ002thcWtfjk0FHtGEHR9tevCLDoT09dbRWvD6zIreUIYoJ/0zQDqSU4fRH3BW4PyKoTzttyBZOp5/i/NJ9A+qkDq/xrgLPeAWW6jy6lnI1x0hVPmvtKjkP/oBTAiVIOGnlFHSI0b+RsseYZGHm5QzPvxOxhAU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EdYOvBOV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1777FC116D0;
	Tue, 24 Feb 2026 19:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771961214;
	bh=AK2nBN3Be9xo4tmnm1/I5Kipk+48q1ddOgsuldsT8Sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdYOvBOVivFcvLiVpJ8ds8URBu/B9ono7DpIKY0V4h7FzQrbXDG6HUFx6RfKDm54q
	 2AXEMkFtKlFatpnbX2uRKNsY5Pp1lSG0GlEfJau4eG8GP79NPX+OOEIDqP6rs5XxEy
	 Z3q1kKRvF449QdZbQEojM2Zpm9Fl3tjmkIDrq6+CGG1MIjNrBw+o8WcHSChyhySq9X
	 ti65sdxE4fT4KOh0BoUqYV8jIZWKHziHcpbF37oObkbgp23Qtjk6ZqCTpzJS0yczCf
	 NtQNunnFyb7RlY05YOIv/984XZHZPklQ5rBwnfBXrNvhoF2TBXlqhX6p0HXof4PbfZ
	 YVY5KDgN/dn+A==
Date: Tue, 24 Feb 2026 11:26:53 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, miklos@szeredi.hu, bpf@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: allow NULL swap info bdev when activating
 swapfile
Message-ID: <20260224192653.GC13829@frogsfrogsfrogs>
References: <177188733433.3935463.11119081161286211234.stgit@frogsfrogsfrogs>
 <177188733484.3935463.443855246947996750.stgit@frogsfrogsfrogs>
 <20260224140118.GB9516@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224140118.GB9516@lst.de>
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78300-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 014A418C11F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 03:01:18PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 23, 2026 at 03:08:08PM -0800, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > All current users of the iomap swapfile activation mechanism are block
> > device filesystems.  This means that claim_swapfile will set
> > swap_info_struct::bdev to inode->i_sb->s_bdev of the swap file.
> > 
> > However, a subsequent patch to fuse will add iomap infrastructure so
> > that fuse servers can be asked to provide file mappings specifically for
> > swap files.
> 
> That sounds pretty sketchy.  How do you make sure that is safe vs
> memory reclaim deadlocks?  Does someone really need this feature?

Err, which part is sketchy, specifically?  This patch that adjusts stuff
in fs/iomap/, or the (much later) patch to fuse-iomap?

If it's the second part (activating swapfiles via fuse-iomap) then I'll
state that fuse-iomap swapfiles work mostly the same way that they do in
xfs: iomap_swapfile_activate calls ->iomap_begin, which calls the fuse
server to get iomappings.  Each iomap is passed to the mm, which
constructs its own internal mapping of swapfile range to disk addresses.
The swap code then submits bios to read/write swapfile contents
directly, which means that there are no upcalls to the fuse server after
the initial activation.

Obviously this means that the fuse server is granting a longterm layout
lease to the kernel swapfile code, so it should reply to
fuse_iomap_begin with a error code if it doesn't want to do that.

I don't know that anyone really needs this feature, but pre-iomap
fuse2fs supports swapfiles, as does any other fuse server that
implements bmap.

--D

