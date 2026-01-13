Return-Path: <linux-fsdevel+bounces-73497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47539D1AED2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 20:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19EEE302069B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069F82FCBE3;
	Tue, 13 Jan 2026 19:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq3isaAN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B403A41;
	Tue, 13 Jan 2026 19:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768330915; cv=none; b=kybG8m+2AYKifuub9dZ54vwz4kclNBc7O2q4exIB1AZubMdWq/UpN3qPl2Cr0oDDE+Y+r2L/6Cmk15sUp5vmgm/oKGVT523PVCRxYlRw5y2ChYMjNRmOs9F8aGQtVxOY8E/yiUW+WrU1psAzz2CY1TlEXh3GTNG49BzkMvEtNHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768330915; c=relaxed/simple;
	bh=vxrGf75fNYl0thFTn7QaJEzU8lpdf9S0ydr1nGFj00c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K4NdzKeRTT+oFX/Lj+3VmGpfUZv3agSi7yO08cpwt0zJJJUGCQtNZ1vHU1ychlCheXq4vAoLAApDmrihmWnvqdxfD9ymWKpE58yta5dsyK30iHRC8KVGyHRPzRmjJsOFwO6zTJsQlB0CQAPoB0NQPXLzOMmWXIY0hPvTtplfSfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq3isaAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04AE0C116C6;
	Tue, 13 Jan 2026 19:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768330915;
	bh=vxrGf75fNYl0thFTn7QaJEzU8lpdf9S0ydr1nGFj00c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq3isaANHbEX8n5wL2axFQtAyCakUFQf4B3+2h+ftqI0zfXtV3NJvn8Dligv6IbcJ
	 MGqfYPFr+wNNEpOHPB5zsLaMI21qEYRnCDNLD84WqQl0JHNmH2WxdAJ2+1497LO5if
	 mdjgWD9P/vCu4cgRFwnTCOISG47XTfNhQL1kN/a+3rHxne3OJT0TTbTHATJf0T0lu0
	 /hYFOi0LlROuoMhH5poeWvs1cG5vLRuqTH72N+rCxMPZztXQk1ANTz/LySrOdkqbCe
	 +3XJU93OJ4ITvFSMa7u5GYs6Yubtr+DOpMwF1xAzOlnVqBL5ITt7ZDCddBAdctvgak
	 sRatOHqXNcOWA==
Date: Tue, 13 Jan 2026 11:01:54 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: cem@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/11] xfs: convey filesystem shutdown events to the
 health monitor
Message-ID: <20260113190154.GC15551@frogsfrogsfrogs>
References: <176826412644.3493441.536177954776056129.stgit@frogsfrogsfrogs>
 <176826412835.3493441.7037634047704901774.stgit@frogsfrogsfrogs>
 <20260113161442.GE4208@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113161442.GE4208@lst.de>

On Tue, Jan 13, 2026 at 05:14:42PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 12, 2026 at 04:34:07PM -0800, Darrick J. Wong wrote:
> > -		/* mount */
> > +		/* shutdown */
> 
> huh?

Oh, heh.  That part of the union isn't needed until this patch, so I'll
move its definition to this patch.

> > @@ -497,14 +498,13 @@ xfs_fs_goingdown(
> >   */
> >  void
> >  xfs_do_force_shutdown(
> > -	struct xfs_mount *mp,
> > -	uint32_t	flags,
> > -	char		*fname,
> > -	int		lnnum)
> > +	struct xfs_mount	*mp,
> > +	uint32_t		flags,
> > +	char			*fname,
> > +	int			lnnum)
> >  {
> > -	int		tag;
> > -	const char	*why;
> > -
> > +	int			tag;
> > +	const char		*why;
> 
> I like this cleanup, but it seems to be entirely unrelated to
> the rest of the patch?

Yeah.  I think it was needed back when xfs_do_force_shutdown actually
had to call xfs_healthmon_get to make the new variables line up, but
now that the change is a oneliner I'll revert these whitspace cleanups.

--D

