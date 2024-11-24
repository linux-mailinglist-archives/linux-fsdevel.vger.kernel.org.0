Return-Path: <linux-fsdevel+bounces-35740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D7B9D793D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 00:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4483FB2426F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 23:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEBF186295;
	Sun, 24 Nov 2024 23:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7pc+v1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB052500BD;
	Sun, 24 Nov 2024 23:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492395; cv=none; b=R8D+YXGohrEm4UB8jP6dGUp3JHLG26ByMah3WXo/XLYXIfi9oewkkYVZQwPMjUll1H2DHrBprbkLnUJO5JHS+dBauIs/wxNA32a6/h7Y5W3xO3bsXmFOjCGudCFVqCwhTRdRvARE4BpjoGH+ZQDNVWk2ePGgpXVAAjThNAkAvbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492395; c=relaxed/simple;
	bh=Bn3wIB2cZG7iCbUeZptMQPOJ0wHetuL4GvocWCpSMP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozj2Ho/n71rwYu+SW+y1Tp1AMeiX+Erb6bXPD/Gjv6kKG15TLPX1LxdNqWfNKrG3tGvQ+g4drshp95i7fjnYj/qrtDaHTTQtyrldzqIIgqz+KPhRbrcvPof16OG3/tThI8PSZlTNwDD912nxUaXUsc3TbpmtymZpoWkRT9RcnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=p7pc+v1O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yU3iZ3r/Hy5FvzBrxYidk8dSZuSKHFfpD0lRlIFTOUU=; b=p7pc+v1O9G0XadgaU2DfxCkcrk
	RFYgeQLHV01dehQ2Vj52X3+WDzTYwx4vMoSsDWzNlp++mrwNlNFMzoqv74BEUBOM24TyAmitkDVU6
	kk4qelHso30jM9XlnLikMOOwve+m+dR47AUwflriLCN9f/VDso6v8na1AdSPVKWyFR72oHFo200bH
	Oibl5jzK3spks4jGn9yW2XcbLioYy/2/VZT3z52fbnMnCSGuw5QpOZJnQJopJKXPcdHiua4T4k0EO
	jOm19Z6exG6QICoDWKmIWvCJa8OU3S7AFioFPVfxCvfIKMxj7IL0XgBihfYygrs2yMUX61u/TuxQ9
	k4fG3EQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFMPd-0000000B5fn-10pV;
	Sun, 24 Nov 2024 23:53:09 +0000
Date: Sun, 24 Nov 2024 23:53:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Mateusz Guzik <mjguzik@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Hao-ran Zheng <zhenghaoran@buaa.edu.cn>, brauner@kernel.org,
	jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	21371365@buaa.edu.cn
Subject: Re: [RFC] metadata updates vs. fetches (was Re: [PATCH v4] fs: Fix
 data race in inode_set_ctime_to_ts)
Message-ID: <Z0O8ZYHI_1KAXSBF@casper.infradead.org>
References: <61292055a11a3f80e3afd2ef6871416e3963b977.camel@kernel.org>
 <20241124094253.565643-1-zhenghaoran@buaa.edu.cn>
 <20241124174435.GB620578@frogsfrogsfrogs>
 <wxwj3mxb7xromjvy3vreqbme7tugvi7gfriyhtcznukiladeoj@o7drq3kvflfa>
 <20241124215014.GA3387508@ZenIV>
 <CAHk-=whYakCL3tws54vLjejwU3WvYVKVSpO1waXxA-vt72Kt5Q@mail.gmail.com>
 <20241124222450.GB3387508@ZenIV>
 <Z0OqCmbGz0P7hrrA@casper.infradead.org>
 <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whxZ=jgc7up5iNBVMhA0HRX2wAKJMNOGA6Ru9Kqb7_eVw@mail.gmail.com>

On Sun, Nov 24, 2024 at 02:43:58PM -0800, Linus Torvalds wrote:
> On Sun, 24 Nov 2024 at 14:34, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Could we just do:
> >
> > again:
> >         nsec = READ_ONCE(inode->nsec)
> >         sec = READ_ONCE(inode->sec)
> >         if (READ_ONCE(inode->nsec) != nsec)
> >                 goto again;
> 
> No. You would need to use the right memory ordering barriers.
> 
> And make sure the writes are in the right order.
> 
> And even then it wouldn't protect against the race in theory, since
> two (separate) time writes could make that nsec check work, even when
> the 'sec' read wouldn't necessarily match *either* of the matching
> nsec cases.

But if we assume that time only goes forwards (ie nobody's calling
utime()), I don't think there's a sequence of updates which let you see
a file time which is newer than the actual time of the file.  I tried
to construct an example, and I couldn't.  eg:

A:	WRITE_ONCE(inode->sec, 5)
A:	WRITE_ONCE(inode->nsec, 950)
A:	WRITE_ONCE(inode->sec, 6)
B:	READ_ONCE(inode->nsec)
B:	READ_ONCE(inode->sec)
A:	WRITE_ONCE(inode->sec, 170)
A:	WRITE_ONCE(inode->sec, 7)
A:	WRITE_ONCE(inode->sec, 950)
B:	READ_ONCE(inode->nsec)

Now we have a time of 6:950 which is never a time that this file had,
but it's intermediate in time between two times that the file _did_
have, so it won't break make.

Or did I not try hard enough to construct a counterexample that
would break make?

(assume the appropriate read/write barriers are in there)

