Return-Path: <linux-fsdevel+bounces-27762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A429639D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAFF51F23295
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314201428E7;
	Thu, 29 Aug 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFGsvsTj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2C640BE5;
	Thu, 29 Aug 2024 05:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724908845; cv=none; b=B2IUoUyamCBFevhgqlunq++27Z8B+UgiceHpb6jpb6zkWl9+gR1xiwWiSHsvrQ0nKTYyC6l3aJg8P0qgpRtPN3xLGYc9y9q7Y0mOI+J84Fy0DE7795KyjtCCKcrV2LPNErwNktvRaOlvyWgr81JbCHle0jvqX3KA/51M0u+ZKqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724908845; c=relaxed/simple;
	bh=LOw1y/5lK6WWdzN+9rCaAqH1+DRP0gltZPjRzyrtxNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9apOb+MD/SQfUjh9xWE8Gya40VLnqBlONjKhlZOccfaYp4ampM54sI+uiMyMhGtC5rE4sWmM91lW8QTlnwwp1ZPA3kZQXwJ4y27u6OaHt8BEq0Kx4BdfHA+cUSAjm9VdqkEo7Gz1vs5Z6qpWkmo7sKBBBO+vvX9z/wsnp+0dlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFGsvsTj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E69CC4CEC1;
	Thu, 29 Aug 2024 05:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724908845;
	bh=LOw1y/5lK6WWdzN+9rCaAqH1+DRP0gltZPjRzyrtxNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NFGsvsTjcEkCkiHjXxDEdHpF9OTFf0cBX92HviFVT+RMHC8+4HSyQjFQU/0Qc1MrM
	 y8rCcJduJmranRNIKVaX6ePUFo6dVYQMO5p2X+4WpyOe0Knxi6wP24Qq1UBDjuph8U
	 PpL2tbKGLS/JzxnM7uUdDkujfTxdIuixDxpzD2PKx1vyNJMFQCZp+71md/bCsqaAcc
	 wPbWTE4FHsLgxMRZokSh21ylcEQc8krfBzniJ+biWk5CrsBiJ5/+Mvrdf4JNSg9bJr
	 BnKwuAQ6whg10++kogu/1ATSElV8Bie2LgCJU0GseH4jNAonTIaMO3wxsWWMTtFwUP
	 Qylck3jJx6OdA==
Date: Wed, 28 Aug 2024 22:20:44 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <20240829052044.GJ6224@frogsfrogsfrogs>
References: <20240827-xfs-fix-wformat-bs-gt-ps-v1-1-aec6717609e0@kernel.org>
 <Zs_vIaw8ESLN2TwY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs_vIaw8ESLN2TwY@casper.infradead.org>

On Thu, Aug 29, 2024 at 04:46:41AM +0100, Matthew Wilcox wrote:
> On Tue, Aug 27, 2024 at 04:15:05PM -0700, Nathan Chancellor wrote:
> > When building for a 32-bit architecture, where 'size_t' is 'unsigned
> > int', there is a warning due to use of '%ld', the specifier for a 'long
> > int':
> > 
> >   In file included from fs/xfs/xfs_linux.h:82,
> >                    from fs/xfs/xfs.h:26,
> >                    from fs/xfs/xfs_super.c:7:
> >   fs/xfs/xfs_super.c: In function 'xfs_fs_fill_super':
> >   fs/xfs/xfs_super.c:1654:1: error: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> >    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> >         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    1655 |                                 mp->m_sb.sb_blocksize, max_folio_size);
> >         |                                                        ~~~~~~~~~~~~~~
> >         |                                                        |
> >         |                                                        size_t {aka unsigned int}
> >   ...
> >   fs/xfs/xfs_super.c:1654:58: note: format string is defined here
> >    1654 | "block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> >         |                                                        ~~^
> >         |                                                          |
> >         |                                                          long int
> >         |                                                        %d
> 
> Do we really need the incredibly verbose compiler warning messages?
> Can't we just say "this is the wrong format specifier on 32 bit"
> and be done with it?

Clearly you haven't f*cked up^W^Wforgotten a comma in an xfs tracepoint
in a while, those will generate 60 pages of helpful diagnostics.

--D

> > Use the proper 'size_t' specifier, '%zu', to resolve the warning.
> > 
> > Fixes: 0ab3ca31b012 ("xfs: enable block size larger than page size support")
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  fs/xfs/xfs_super.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> > index 242271298a33..e8cc7900911e 100644
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1651,7 +1651,7 @@ xfs_fs_fill_super(
> >  
> >  		if (mp->m_sb.sb_blocksize > max_folio_size) {
> >  			xfs_warn(mp,
> > -"block size (%u bytes) not supported; Only block size (%ld) or less is supported",
> > +"block size (%u bytes) not supported; Only block size (%zu) or less is supported",
> >  				mp->m_sb.sb_blocksize, max_folio_size);
> >  			error = -ENOSYS;
> >  			goto out_free_sb;
> > 
> > ---
> > base-commit: f143d1a48d6ecce12f5bced0d18a10a0294726b5
> > change-id: 20240827-xfs-fix-wformat-bs-gt-ps-967f3aa1c142
> > 
> > Best regards,
> > -- 
> > Nathan Chancellor <nathan@kernel.org>
> > 
> > 
> 

