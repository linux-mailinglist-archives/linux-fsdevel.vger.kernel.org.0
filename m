Return-Path: <linux-fsdevel+bounces-74913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LIsGq88cWnKfQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:53:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A245DA3D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 21:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC20C38CB2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB983D3CEB;
	Wed, 21 Jan 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seIeDb45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4D8266576;
	Wed, 21 Jan 2026 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025486; cv=none; b=DUVvKFGeuKhyiaI7EJfpzxZNTuwBLLwn44zBDnkCQhJo785xVFQrRHVptobbtDIvDANeTiYzUaT8pG2bu6bCXAk3QUsBcU5hYS+QeIRNCFK2YSGUj7IKvh8Da6rdPxCSwbrv1F6ROall7C5/EE7iTxTUZxf0yvqKNyCqZmtRnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025486; c=relaxed/simple;
	bh=SNBl8r/pbRZCG1RY6JbZ5jzqxMoWTxTfezH1cYgsxLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyKNHfsuPGZRl23TN1bqooZiaQJwplNCxXR1ZuzVadObi+F9nEiO65YrBKCK+IYJGLnePlnO5FQ2lPnOI3Ew7OAQhdTARXTDXSRm//SlrsfuNBQcdOXc2O4A1RwbWe1Jc7WUbRzeSpkrPO20pq367B+VYZ8Zvya3qvLfn5O4aDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seIeDb45; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B585C4CEF1;
	Wed, 21 Jan 2026 19:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769025486;
	bh=SNBl8r/pbRZCG1RY6JbZ5jzqxMoWTxTfezH1cYgsxLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=seIeDb45gHORXtp0FHpcl97ggAXk/ZchYWyW1BVXj8mdCKBh5z1f6FyMVWtYTsiAF
	 hTU40FRtMWicVCywYCGwX0iL3Dqu6gWscPy4gTLHuWcefB9r+UUr3zYkc4Y6f4darO
	 wtjBf2qifF3sMl4a1B6X+VVw4KsCETIaezPTp6Dg3CkR03G7FQtrY+xsBThhYZJnJQ
	 kGZqgrMwz7CAGQPya8C6mEU5RIFU8EGNN7+9odMnjW9hA7i4XL1p8kXURsrYgyRW94
	 w97BukyQPfKGNLGj4/4P6SQOJ7+8VDyzN82ylkukKkl/L7MaIirjY0hhyWaqMvWSZv
	 1h5v/crwdADiQ==
Date: Wed, 21 Jan 2026 11:58:05 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6.1 11/11] xfs: add media verification ioctl
Message-ID: <20260121195805.GK5945@frogsfrogsfrogs>
References: <176852588473.2137143.1604994842772101197.stgit@frogsfrogsfrogs>
 <176852588776.2137143.7103003682733018282.stgit@frogsfrogsfrogs>
 <20260120041226.GJ15551@frogsfrogsfrogs>
 <20260120071830.GA5686@lst.de>
 <20260120180040.GU15551@frogsfrogsfrogs>
 <20260121070556.GA11882@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121070556.GA11882@lst.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-74913-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 04A245DA3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:05:56AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 20, 2026 at 10:00:40AM -0800, Darrick J. Wong wrote:
> > On Tue, Jan 20, 2026 at 08:18:30AM +0100, Christoph Hellwig wrote:
> > > 
> > > > +		unsigned int	bio_bbcount;
> > > > +		blk_status_t	bio_status;
> > > > +
> > > > +		bio_reset(bio, btp->bt_bdev, REQ_OP_READ);
> > > > +		bio->bi_iter.bi_sector = daddr;
> > > > +		bio_add_folio_nofail(bio, folio,
> > > > +				min(bbcount << SECTOR_SHIFT, folio_size(folio)),
> > > > +				0);
> > > 
> > > You could actually use bio_reuse as you implied in the previous mail here
> > > and save the bio_add_folio_nofail call.  Not really going to make much
> > > of a difference, so:
> > 
> > Hrm.  Is that bio_reuse patch queued for upstream?  Though maybe it'd be
> > easier to make a mental note (ha!) to clean this up once both appear
> > upstream.
> 
> It is queued up in the xfs for-next tree.

Ah, heh.  I'll see if cem merges the series atop his xfs-7.0-merge
branch and send a followup.  As it is I'm already going to ask Linus if
I can remove the old fsnotify error function (and any new callers that
might pop up) right before -rc1.

--D

