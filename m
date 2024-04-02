Return-Path: <linux-fsdevel+bounces-15904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A888959B0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 18:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E171C21533
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0314B072;
	Tue,  2 Apr 2024 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbeoKSgR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67394132C38;
	Tue,  2 Apr 2024 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075132; cv=none; b=VZbJGOUEcPRIjeQOgcRPVJN8Vtx6EkdfnSMAH57P/U2oFqA9osfg4AitIoc3XLf9ITlGJtXuUKLa2wx9+XBE0GOyxBu0jNcx9EdRS1HGd1my4EiY0MGgGID7u9BD9FrU77CkjeMMyLygev/xHExc5S/nAzFHq2Yn+Qy66OoNbmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075132; c=relaxed/simple;
	bh=CpXBpfFI2tLnM2I0IN8ckZC2Oo+13p2Q4UbLIpch8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoMY+eRJuGbsd3wZpzDkzT/n+ohpBMK+pBg10mooPuUzvqbwwCoP+2UIU8z0Muq3dOa4bphyMklkRLf+0LN6Mia3iEqWUZ+9N1d3wyZ4dZd2qRopV5BDPYNL/eJ4t9Ufp16RO4xlDH9rZQ3uTrAmynDNTKf31bXq3UxfY3GKTbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbeoKSgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B43C433C7;
	Tue,  2 Apr 2024 16:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712075130;
	bh=CpXBpfFI2tLnM2I0IN8ckZC2Oo+13p2Q4UbLIpch8mU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DbeoKSgR018ET+3izr9ejq3qRxnlX0IqKyZVvVe8Hths/vhvuE5aWjyiBuzcyO7H+
	 tS5l8p9nPD8NmLvg6zjVLXCT/qrzVArucAu5k359v+7WbpYHoLH8lJx1NEXZcTz6OT
	 sGJirbn5ypdXo7N9dIuIWNJIPcOZYG4CM/GWyD0E1nhpiwHVvSTZXAk8iPkegbDRDk
	 JNA2Wv8ScjU0ZOqkpodJj9stgNrhig6OTOy9IMYFIiVYfQkx+k1TSuJH8fppvKwI/A
	 ZjHdYS35O8QRs5IA98R/Omy8XZRJ5yjKsMh89hX3u1kMachUcaU1ix0KAzTkdiD2Jj
	 7GHb3pPtVCHyw==
Date: Tue, 2 Apr 2024 09:25:30 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 01/29] xfs: use unsigned ints for non-negative quantities
 in xfs_attr_remote.c
Message-ID: <20240402162530.GZ6390@frogsfrogsfrogs>
References: <171175868489.1988170.9803938936906955260.stgit@frogsfrogsfrogs>
 <171175868577.1988170.1326765772903298581.stgit@frogsfrogsfrogs>
 <nx4hkurupibsk7fgxeh3qhdpeheyewazgay3whw5r55immgbia@6s253r4inkxn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nx4hkurupibsk7fgxeh3qhdpeheyewazgay3whw5r55immgbia@6s253r4inkxn>

On Tue, Apr 02, 2024 at 11:51:55AM +0200, Andrey Albershteyn wrote:
> On 2024-03-29 17:36:19, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > In the next few patches we're going to refactor the attr remote code so
> > that we can support headerless remote xattr values for storing merkle
> > tree blocks.  For now, let's change the code to use unsigned int to
> > describe quantities of bytes and blocks that cannot be negative.
> > 
> > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > ---
> >  fs/xfs/libxfs/xfs_attr_remote.c |   54 ++++++++++++++++++++-------------------
> >  fs/xfs/libxfs/xfs_attr_remote.h |    2 +
> >  2 files changed, 28 insertions(+), 28 deletions(-)
> > 
> > 
> > diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
> > index a8de9dc1e998a..c778a3a51792e 100644
> > --- a/fs/xfs/libxfs/xfs_attr_remote.c
> > +++ b/fs/xfs/libxfs/xfs_attr_remote.c
> > @@ -47,13 +47,13 @@
> >   * Each contiguous block has a header, so it is not just a simple attribute
> >   * length to FSB conversion.
> >   */
> > -int
> > +unsigned int
> >  xfs_attr3_rmt_blocks(
> > -	struct xfs_mount *mp,
> > -	int		attrlen)
> > +	struct xfs_mount	*mp,
> > +	unsigned int		attrlen)
> >  {
> >  	if (xfs_has_crc(mp)) {
> > -		int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
> > +		unsigned int buflen = XFS_ATTR3_RMT_BUF_SPACE(mp, mp->m_sb.sb_blocksize);
> >  		return (attrlen + buflen - 1) / buflen;
> >  	}
> >  	return XFS_B_TO_FSB(mp, attrlen);
> > @@ -122,9 +122,9 @@ __xfs_attr3_rmt_read_verify(
> 
> fsbsize in xfs_attr3_rmt_verify()?

Ah, yes, good catch.  Fixed.

> Otherwise, looks good to me:
> Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

Thanks!

--D

> -- 
> - Andrey
> 
> 

