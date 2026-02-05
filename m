Return-Path: <linux-fsdevel+bounces-76501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBlMH1kohWkk9QMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:31:37 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866FF85A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 00:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43F113010514
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 23:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C71633C182;
	Thu,  5 Feb 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKDB32HS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF551482E8;
	Thu,  5 Feb 2026 23:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770334282; cv=none; b=gsE0J67bT/us9Io+ofxtwrPeEGkm3xGCx0Ihs2QJjJlBVEX9BBjlJS/38/iYnwgWaU1zRFQ/WTnV5Li1RaNCBLnZgPK6EYXR+fAKNga5dDftHuZlXHjBX7xU5+SJwHp3wIkHn0Hgg5DOm0HOaPH8xkI0eM9+DxFQqWXY+/o27F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770334282; c=relaxed/simple;
	bh=iCDgJoiD5xz25rrxLG1jdG7Q+jqN/Ke5+qD+/CUNwhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5ptqSK4KwrdNOy8NwiU1Mhg0pgMv/0Llc1v830rRIdScA/71cYZjX6RgwZqCr8CPjx4tf4JqGObJP5qCF3ZEkhLtFMGEukMit1EjRVbbRShMX9ulHbuTDdREYSaMu/6hlYboPmzQ12Jc28tJO5vK3gSeBS+6XdOFfAVmmcR4oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKDB32HS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BEDC4CEF7;
	Thu,  5 Feb 2026 23:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770334282;
	bh=iCDgJoiD5xz25rrxLG1jdG7Q+jqN/Ke5+qD+/CUNwhA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rKDB32HSkZG6QLIDxvpdAcPV+ahCPGdHSaiEB5/YIdUbudCPNvN/cDUsmzf/8C6nz
	 KTOTdloUH5nXrD2irZSyrsrX607ozTLgspwu2rkRCZTdLTijJ6fUcvtAVnmpD2Y/n0
	 AncJz7hcZZeRDthIRK/u24V4cGtuNr8GKATi4QF7a6i7PwW2E4cow2PejQzyGba0VD
	 4TjTy/eUe3D8hlGyuEWF9FD3vcV+6Og8n04DZEb+hADA/nov99VFRMo7ft21Ue41uT
	 WPm8IYkD8BBsJCXg+y0fYDT5+8kMVrcvrMqSWOy3rK0eVSwEw43oStD2N6Rzt0ZDAv
	 1dNvLQcpBAypQ==
Date: Thu, 5 Feb 2026 15:31:21 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
	neal@gompa.dev, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/31] fuse: implement the basic iomap mechanisms
Message-ID: <20260205233121.GD7686@frogsfrogsfrogs>
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810371.1424854.3010195280915622081.stgit@frogsfrogsfrogs>
 <20260205192550.2124130-1-clm@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205192550.2124130-1-clm@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76501-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2866FF85A5
X-Rspamd-Action: no action

On Thu, Feb 05, 2026 at 11:22:44AM -0800, Chris Mason wrote:
> "Darrick J. Wong" <djwong@kernel.org> wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Implement functions to enable upcalling of iomap_begin and iomap_end to
> > userspace fuse servers.
> > 
> 
> Hi everyone,
> 
> I'm trying out my AI review prompts on a few more trees, and I ran it
> on the fuse-iomap-cache branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache
> 
> This was the latest email lore could find, apologies if I grabbed the wrong one.
> 
> Hopefully the review below is useful, please let me know if there are places it
> has gone wildly wrong.  I kept the header to make it obvious exactly which
> commit I'd run through:
> 
> (I don't fully understand why it calls out commit b3f5bd5243, looks like
> it's probably just the last place that changes nearby code)
> 
> commit 99dffae5966f9647a430fa4c9198e2d2dacae172
> Author: Darrick J. Wong <djwong@kernel.org>
> 
> fuse: implement the basic iomap mechanisms
> 
> Implement functions to enable upcalling of iomap_begin and iomap_end to
> userspace fuse servers.
> 
> > diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
> > new file mode 100644
> > index 0000000000000..d1c2c2e1e68b8
> > --- /dev/null
> > +++ b/fs/fuse/fuse_iomap.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,430 @@
> 
> [ ... ]
> 
> > +/* Convert a mapping from the server into something the kernel can use */
> > +static inline void fuse_iomap_from_server(struct iomap *iomap,
> > +					  const struct fuse_iomap_io *fmap)
> > +{
> > +	iomap->addr = fmap->addr;
> > +	iomap->offset = fmap->offset;
> > +	iomap->length = fmap->length;
> > +	iomap->type = fuse_iomap_type_from_server(fmap->type);
> > +	iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
> > +	iomap->bdev = NULL; /* XXX */
> > +}
> > +
> > +/* Convert a mapping from the kernel into something the server can use */
> > +static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
> > +					const struct iomap *iomap)
> > +{
> > +	fmap->addr = fmap->addr;
>                      ^^^^
> 
> Does fmap->addr get the wrong value here? Looking at
> fuse_iomap_from_server() just above, it correctly does iomap->addr =
> fmap->addr. This function appears to have the reverse bug, assigning
> fmap->addr to itself instead of fmap->addr = iomap->addr. The other
> fields (offset, length, type, flags) all correctly copy from iomap.
> 
> This would cause fuse_iomap_end() to send uninitialized or garbage data
> in the addr field when calling fuse_iomap_to_server(&inarg.map, iomap).
> 
> This bug persists unfixed through commit b3f5bd524315 later in the
> series.

Yep, that's a copy-paste error from above; good catch!

--D

> > +	fmap->offset = iomap->offset;
> > +	fmap->length = iomap->length;
> > +	fmap->type = fuse_iomap_type_to_server(iomap->type);
> > +	fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
> > +	fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
> > +}
> 
> 

