Return-Path: <linux-fsdevel+bounces-67002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA5C32FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 21:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933A418C35FE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 20:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD922EDD70;
	Tue,  4 Nov 2025 20:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6DeQzq8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37C9F9EC;
	Tue,  4 Nov 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762289855; cv=none; b=Em0kJ0wpXDFEbs3EMgkBnrXQ7++3WH8XqRPgSEFapElSfhXWwzhfMzbHhKsi/OGYYV/RJs2qcgZp3S/9MDsMDGU//zCtpnbOaLvJpJuV4oT0rbpl5pDT09eCI0QPjKMHKDwS5hyKcKs4d7Cbr7y0C6XlKdn6S5/V/KSu6RFGQCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762289855; c=relaxed/simple;
	bh=VZ8pueVu7F/jd72Yr8Sq8waEWcfBeS6ArlkTR4dMbyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oS/hFdMSfLUFUe2myEktVPjl0Db7mXLb9DDkVPC94c07oLC5lIpOT5vXrRuhTTGTXq9DuXbqYzINMMauZpg8/u099uVc67dAroQ/IdzFWfM40glNuGU64Um/iCW2j4waujdvDPkkILz8ry5oz+86V8jhoIXFv1Qj17aG9jHz61A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6DeQzq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5C2C4CEF8;
	Tue,  4 Nov 2025 20:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762289855;
	bh=VZ8pueVu7F/jd72Yr8Sq8waEWcfBeS6ArlkTR4dMbyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6DeQzq8ilRr4dV6/9XGrHI9hQgTLpb8ffTmP+DQXhxwgZL0FuyBs2zyeSqTPHl8L
	 5txnBPKzPyBIomptvCNWcmq2mwRUoJInK8hNybfmYssd2gziqNfmKjVAFTB1HmSkck
	 Gwjw4VpaaVJ4OeTG6nwg8A46Fct2Nsd3aM61uOOeYwvoeAzyMENxD4kjj/bT1GzfvP
	 rRL4PIJ1ktFDmbRZiy/BevJRZrPBhJt69nZ+1AH2pXQz1I46WQ/PHaMcLJUmSMBx39
	 SpsntLXAZCe/U/cYKsr5Mi5nr/vY/7sPhxa/WkB5UiKnGgsJC7GNwmXu7NsXSUaEsJ
	 xWWCpQ8MqiYPQ==
Date: Tue, 4 Nov 2025 21:57:30 +0100
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH RFC 8/8] xfs: use super write guard in xfs_file_ioctl()
Message-ID: <20251104-mitglied-ozonwerte-88de46f0b26a@brauner>
References: <20251104-work-guards-v1-0-5108ac78a171@kernel.org>
 <20251104-work-guards-v1-8-5108ac78a171@kernel.org>
 <20251104170845.GK196370@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251104170845.GK196370@frogsfrogsfrogs>

On Tue, Nov 04, 2025 at 09:08:45AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 04, 2025 at 01:12:37PM +0100, Christian Brauner wrote:
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> >  fs/xfs/xfs_ioctl.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> > index a6bb7ee7a27a..f72e96f54cb5 100644
> > --- a/fs/xfs/xfs_ioctl.c
> > +++ b/fs/xfs/xfs_ioctl.c
> > @@ -1408,10 +1408,8 @@ xfs_file_ioctl(
> >  
> >  		trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
> >  
> > -		sb_start_write(mp->m_super);
> > -		error = xfs_blockgc_free_space(mp, &icw);
> > -		sb_end_write(mp->m_super);
> > -		return error;
> > +		scoped_guard(super_write, mp->m_super)
> > +			return xfs_blockgc_free_space(mp, &icw);
> 
> Can we go full on Java?
> 
> #define with_sb_write(sb) scoped_guard(super_write, (sb))
> 
> 	with_sb_write(mp->m_super)
> 		return xfs_blockgc_free_space(mp, &icw);
> 
> I still keep seeing scoped_guard() as a function call, not the sort of
> thing that starts a new block.
> 
> [If I missed the bikeshedding war over this, I'll let this go]

It's an option and what I did for the creds stuff. The thing is thought
that scoped_guard() is more widespread by now and thus probably easier
to grasp for readers that are familiar with it. I'm not married to it.

