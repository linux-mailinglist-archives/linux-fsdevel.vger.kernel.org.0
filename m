Return-Path: <linux-fsdevel+bounces-27937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A6E964D36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1C31C22428
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDF51B78E1;
	Thu, 29 Aug 2024 17:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeKxBFPL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62F94D8C1;
	Thu, 29 Aug 2024 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724953818; cv=none; b=G2ct782SQYPQtcX2npzL5SIpZZmJ7KkJ/iOxusuBJGMTO2A7oqDRi0fBGHmz3Ra2BTfOObOk+pDus55DkPWmBml/fXvIaSF+9/rXODqUbbaeVZMnc6DBHQpbMKnhWkIWqwEUanDvDsUFnuWDXjJsLyY2krB60XSqhkojIqDtvhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724953818; c=relaxed/simple;
	bh=zIxtJ9K3491BCnPoMEJYZ6DB6YWR4Y5X3dI36QGPn14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saTT93nvZYanJ20o13tKbk0HtqCzTVWNUodR+sPM9WTerHaHBztX7abGQ9PLaXWy8YaM2J84/wietbI7zfjq8cB6qfJFT1rDxnfENpab8IWg0E+ln/KWAuHGJxewZ5lUYlEOOCoYyhZZNmXJJ0WTbd9xy7wtzHui5imwDcdXPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeKxBFPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2332DC4CEC2;
	Thu, 29 Aug 2024 17:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724953817;
	bh=zIxtJ9K3491BCnPoMEJYZ6DB6YWR4Y5X3dI36QGPn14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TeKxBFPLTV3MZVstc8Xe/nBx+rEY878FAStDHetaXIdBlQkcBFjm8idNlRii7Zw18
	 mgXDTlJm+eTqxYoV9rjIEUcmAuwukmQJhmRNXn1UuwjCOMG4NJrFTrLX5IIhFNBHxb
	 g+9YJvnNWosCiymVfiKImtXijURfBEnwgevESjTFFxhDBqgP0hIOmcYIYNMzJ39lL+
	 2ZAwsiw0/P1emW3M1J0cqizz8ZgRuxfhCJgn6hjgAJttFDMqNGGP76TUZiX4sfH8cz
	 cM1SP+IkgJUNdiCx/jvN+iU/Iap6ydplSXC4dBgAMxpx/tBrseBeoRO8FYU8bh2U+S
	 MJTLdL0JgjbhA==
Date: Thu, 29 Aug 2024 10:50:15 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] xfs: Fix format specifier for max_folio_size in
 xfs_fs_fill_super()
Message-ID: <20240829175015.GA3059476@thelio-3990X>
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

Sure, I could have been less verbose. I seem to recall maintainers
desiring the full compiler output at times so that it is easier to see
what the issue is and how the patch fixes the warning but obviously that
is going to vary from maintainer to maintainer. I can send a v2 with
that trimmed if desired or Christian could just axe it when applying if
he really cares? I guess squashing this into the original change would
make this irrelevant too.

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

