Return-Path: <linux-fsdevel+bounces-18465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2648B9309
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 03:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2151F2246A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 01:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACE12B93;
	Thu,  2 May 2024 01:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="HizvQYYw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD1011184
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714612269; cv=none; b=IVfXcxwaYM+4agL7dIGww5jriMeF0iPLmqy+is0oFIxWD/ktLsTNoq3c1/eenoMEYVraQcNmJb99OHh3NGW5OPjPm8LXVDJ4VXikQAtwSbBEaxBETuwhqhYfM6XE0qywF2Trgs7rPXvsSlpiqmU/2wNyYmYvJ6aIvKhqBa8IWrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714612269; c=relaxed/simple;
	bh=goGnx7+o0cvrtydIDAhojJQ/cmld+QqZebwaXWoS2ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtPTvYEi+jFP83G67rGpM6SEXV/bN4/5ak0Toh0940jySZtCosCp0vTbxcRqBjEhfPagz8XWf7T65ULA90EFNZO35vamyLWJSK0P5zetaiwTvgM7dqYB6omDpf2Id1yEuAKmSwj7nEFx0GqytNVSATfJY9eY5qbKI5iSPcHkuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=HizvQYYw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e5c7d087e1so63581155ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 May 2024 18:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1714612267; x=1715217067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cTmHTn+EDFvVBp/uyb7cTt66Oy+JEt94l4VC8Lg3nkQ=;
        b=HizvQYYw2Vk/8lTkUD9rgJxIJ4rRQszigVSXO925Q/ViWXwPDpvBITXu+XzWF20o6L
         0Djz/fjB+kR2wF+Hhx6wY5f2z7wfmqiUsEK5/MamyQGFuoNrLtdTlFFRGQAuzgaR0j1Q
         OFRbNIstCFhbaLvtcfH4hPEz9xy8z/IcvWbhnjETX8M9m57yE+wF/x9QjXsKgDLXAIrk
         tzvVi9RkT3t6UaCESlEHSWojWbgNo5MyICfMkMGgvD4lxkgTNWWJ1xQwx80drWaapT3b
         tP4JvZtdjc00oeNiS5YbRwIPTc+C8aN7XJEoz1UliNlO+jD9LXaoE7ETeImzhOQAt2Pa
         EARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714612267; x=1715217067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTmHTn+EDFvVBp/uyb7cTt66Oy+JEt94l4VC8Lg3nkQ=;
        b=qX7M+X0SrMkXZ9KPGlev2f8k6s+05ARyY2VqGdRveUb5e7NLuq31f35U7EcoSMXYIW
         hO0aFPSMEXpkWsG5ENiptf8LLbvj63WRmbOx8M155QY0F6VOQtAEABBxxpdfiT1IFwxa
         vna+RcDxsd9roJ+XE4FoY9crx2jMiGXUKeDD0L9eodNF4TiLsz3S9/1ZdRrRIFdqo7k6
         Cvhr+993xEG93sQg1aMFGRAiPMzDuFYOjDaaaInpA1YCo8rpQ9XHLritQeHgLZk56AAW
         CiiI4Nd8uWjdgHnyg7vw2aBMYhj0BhPmG2GyooIJu3Fa7kGv38Gkiq81PjH1a+S1xZaL
         dEzA==
X-Forwarded-Encrypted: i=1; AJvYcCVztebVojwejJbCOIMcIhdwlD5ZDuRy03Rol/sY7iQ3a5C8iObbXv2NRgUUgb6angeGnFDrXe/qy9R9uQNCnCmjPQr3VJyWeNZptFGrHw==
X-Gm-Message-State: AOJu0Ywh38kjY05pwl8Tpd6BDC4o1RvQIUSxViNHeIzp3+/cFSbjGQpA
	zKzekpWVGfQjlpKktU4McbJGKspJwUcwIpi72ZFI/ssP3MN1Rixxc4a5+KMSnio=
X-Google-Smtp-Source: AGHT+IG2tMNTomS3ZqyWOINVPtwBWTHlZFdEmCLTkAdgm8tukRJkLC5VAwUJPVsGDfNYzBUOMRcRmg==
X-Received: by 2002:a17:902:ed01:b0:1e8:674b:d10f with SMTP id b1-20020a170902ed0100b001e8674bd10fmr426300pld.41.1714612266683;
        Wed, 01 May 2024 18:11:06 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id b18-20020a170903229200b001eb2e6b14e0sm9671431plh.126.2024.05.01.18.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 18:11:06 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1s2KyV-000N8D-2i;
	Thu, 02 May 2024 11:11:03 +1000
Date: Thu, 2 May 2024 11:11:03 +1000
From: Dave Chinner <david@fromorbit.com>
To: John Garry <john.g.garry@oracle.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, chandan.babu@oracle.com,
	willy@infradead.org, axboe@kernel.dk, martin.petersen@oracle.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
	linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
Subject: Re: [PATCH v3 09/21] xfs: Do not free EOF blocks for forcealign
Message-ID: <ZjLoJ4FeSbsb/hch@dread.disaster.area>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-10-john.g.garry@oracle.com>
 <ZjF2jjtsA/C6ajtb@dread.disaster.area>
 <833f5821-a928-441f-848f-3a846111dcb7@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833f5821-a928-441f-848f-3a846111dcb7@oracle.com>

On Wed, May 01, 2024 at 09:30:37AM +0100, John Garry wrote:
> On 30/04/2024 23:54, Dave Chinner wrote:
> > On Mon, Apr 29, 2024 at 05:47:34PM +0000, John Garry wrote:
> > > For when forcealign is enabled, we want the EOF to be aligned as well, so
> > > do not free EOF blocks.
> > 
> > This is doesn't match what the code does. The code is correct - it
> > rounds the range to be trimmed up to the aligned offset beyond EOF
> > and then frees them. The description needs to be updated to reflect
> > this.
> 
> ok, fine
> 
> > 
> > > 
> > > Signed-off-by: John Garry <john.g.garry@oracle.com>
> > > ---
> > >   fs/xfs/xfs_bmap_util.c | 7 ++++++-
> > >   1 file changed, 6 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> > > index 19e11d1da660..f26d1570b9bd 100644
> > > --- a/fs/xfs/xfs_bmap_util.c
> > > +++ b/fs/xfs/xfs_bmap_util.c
> > > @@ -542,8 +542,13 @@ xfs_can_free_eofblocks(
> > >   	 * forever.
> > >   	 */
> > >   	end_fsb = XFS_B_TO_FSB(mp, (xfs_ufsize_t)XFS_ISIZE(ip));
> > > -	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1)
> > > +
> > > +	/* Do not free blocks when forcing extent sizes */
> > > +	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1)
> > 
> > I see this sort of check all through the remaining patches.
> > 
> > Given there are significant restrictions on forced alignment,
> > shouldn't this all the details be pushed inside the helper function?
> > e.g.
> > 
> > /*
> >   * Forced extent alignment is dependent on extent size hints being
> >   * set to define the alignment. Alignment is only necessary when the
> >   * extent size hint is larger than a single block.
> >   *
> >   * If reflink is enabled on the file or we are in always_cow mode,
> >   * we can't easily do forced alignment.
> >   *
> >   * We don't support forced alignment on realtime files.
> >   * XXX(dgc): why not?
> 
> There is no technical reason to not be able to support forcealign on RT,
> AFAIK. My idea is to support RT after non-RT is supported.
> 
> >   */
> > static inline bool
> > xfs_inode_has_forcealign(struct xfs_inode *ip)
> > {
> > 	if (!(ip->di_flags & XFS_DIFLAG_EXTSIZE))
> > 		return false;
> > 	if (ip->i_extsize <= 1)
> > 		return false;
> > 
> > 	if (xfs_is_cow_inode(ip))
> > 		return false;
> 
> Could we just include this in the forcealign validate checks? Currently we
> just check CoW extsize is zero there.

Checking COW extsize is zero doesn't tell us anything useful about
whether the inode might have shared extents, or that the filesystem
has had the sysfs "always cow" debug knob turned on. That changes
filesystem behaviour at mount time and has nothing to do with the
on-disk format constraints.

And now that I think about it, checking for COW extsize is
completely the wrong thing to do because it doesn't get used until
an extent is shared and a COW trigger is hit. So the presence of COW
extsize has zero impact on whether we can use forced alignment or
not.

IOWs, we have to check for shared extents or always cow here,
because even a file with correctly set up forced alignment needs to
have forced alignment disabled when always_cow is enabled. Every
write is going to use the COW path and AFAICT we don't support
forced alignment through that path yet.

> 
> > 	if (ip->di_flags & XFS_DIFLAG_REALTIME)
> > 		return false;
> 
> We check this in xfs_inode_validate_forcealign()

That's kinda my point - we have a random smattering of different
checks at different layers and in different contexts. i.e.  There's
no one function that performs -all- the "can we do forced alignment"
checks that allow forced alignment to be used. This simply adds all
those checks in the one place and ensures that even if other code
gets checks wrong, we won't use forcealign inappropriately.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

