Return-Path: <linux-fsdevel+bounces-19380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B30EE8C4279
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 15:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DF61F2111A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 May 2024 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4B153500;
	Mon, 13 May 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MH+6mWZC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9539B1E497
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 May 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608137; cv=none; b=aeZizMSQI1kXd51r6IRoH7cME38B0w87PN8yDWFpsWdaT1dq3pKvtx2qLFRRr33JPtGI7d3qClXGMo2a0fGRVnRCPhwM9Vs4wt7JyYznNgpPOgM7mm5hdQYxYWoqkWUrOKrjMAqfOdZaHkoJZAolLtoGmpdRHnml3KItIvl89pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608137; c=relaxed/simple;
	bh=g8z7UFTxX/7vUArj2ZXiBPeHN8OeRmFhtx+ZcqZTQ78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfOZDSRb6sR1VDYFHWdu2BZotsFHh0634smDy8nE9NiKsUL9kEfggBzryo7SVr4IHd1jZs1QRuln1rI0r/BaFwHbqU/EBoDZMLspWqR0FgeHfId8XM2ZdzkYoWN47QTgz3qP0hdYgPITN8hz4hbfxBV/oSfWFDPbdh+kNuDYubw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MH+6mWZC; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([50.204.89.32])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 44DDmH5r018950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715608100; bh=xIZ7baSf22Boq6kXiuiRGM8wj+D8UzYJlxuD6mlLHcU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MH+6mWZCoHwx/5Zm/7taWE21mXRTUajxBKH8105lZg9fgpBxE7DtnGtqZ7sasqvey
	 4w/nk/lp3CddpU9HfhqPBM+7IooMsFaJjK/0TOzsTys8dIqDikWqPyVqmPRK6tSjGa
	 t66gFZXlZMjenUCUK/vtUWn23gMQwrRsh2gbAl/ykm8CR8ykEYL+FixV3dS5gX08lr
	 1icMpKQf1aNDhQZijdPFEwxWNpWGCQI2je3nVvZ/eJQEDjAHt/0n05goTnI7DW1LQd
	 iCBEk0sXDWQc6o0pGJyQ623AMNb1q8e03SgIkhutGKcYUKbrRuGjYai8qCQ2vtyTiU
	 WForj97BDEz1w==
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D5809340282; Mon, 13 May 2024 09:48:16 -0400 (EDT)
Date: Mon, 13 May 2024 07:48:16 -0600
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        lsf-pc@lists.linux-foundation.org, xfs <linux-xfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Chandan Babu R <chandan.babu@oracle.com>, Jan Kara <jack@suse.cz>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [Lsf-pc] XFS BoF at LSFMM
Message-ID: <20240513134816.GB520598@mit.edu>
References: <CAB=NE6V_TqhQ0cqSdnDg7AZZQ5ZqzgBJHuHkjKBK0x_buKsgeQ@mail.gmail.com>
 <CAOQ4uxj8qVpPv=YM5QiV5ryaCmFeCvArFt0Uqf29KodBdnbOaw@mail.gmail.com>
 <ZjxZttSUzFTd_UWc@infradead.org>
 <CAOQ4uxhpZ-+Fgrx_LDAO-K5wHaUghPfvGePLVpNaZZza1Wpvrg@mail.gmail.com>
 <20240509155528.GN360919@frogsfrogsfrogs>
 <CAOQ4uxiX=O8NhonBv2Yt6nu4ZiqTLBUZg+M5r0T-ZO5LC=a2dQ@mail.gmail.com>
 <20240509174745.GO360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509174745.GO360919@frogsfrogsfrogs>

On Thu, May 09, 2024 at 10:47:45AM -0700, Darrick J. Wong wrote:
> > > Ritesh and Ted and Jan and I were chatting during the ext4 concall just
> > > now.  Could we have a 30 minute iomap bof at 2:30pm followed by the XFS
> > > bof after that?  That would give us some time to chat with hch about
> > > iomap (and xfs) direction before he has to leave.
> > >
> > > Alternately, we could announce a lunchtime discussion group on Monday
> > > following Ritesh's presentation about iomap.  That could fit everyone's
> > > schedule better?  Also everyone's braincaches will likely be warmer.
> > 
> > Seems to me that there will be a wider interest in iomap BoF
> > Not sure what you mean by lunchtime discussion.
> 
> Monday 90-minute lunch is posted as being in "Grand ballroom C", so I
> would tell everyone to come find the table(s) I'm sitting at for a
> discussion over lunch.  We can move out to a hallway after everyone's
> done eating.
> 
> > We can move Willy's GFP_NOFS talk to 15:30 and have the iomap BoF
> > after Ritesh's session.
> 
> <shrug> If you like, though I don't think it's totally necessary.  But
> you might have a better idea of what the venue is like than I do, so
> I'll let you make that call. :)

How did we decide to resolve this?  If we have the iomap BOF at
2:30pm, with a hard stop at 3:00pm, that would work for everyone
including Cristoph.

Or we can try to get all of the people interested in talking about
iomap at lunch on Wednesday.

Or we could do something that requires a lot more juggling of slots,
which I'll leave to the track leads.  :-)

All of these ideas work for me.


As far as scheduling per-file system BOF's, I'd like to claim the slot
immediately after XFS for an ext4 BOF, it that would be OK.

Thanks,

						- Ted

