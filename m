Return-Path: <linux-fsdevel+bounces-15527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67E3890033
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 14:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F64F1C2581E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2417FBA9;
	Thu, 28 Mar 2024 13:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LbYyslbN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47151224D0
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Mar 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632614; cv=none; b=QOui++FGKEGrW7cIImyQJUp2YxL4furi/KWkdAnihL5xkLlErYj8uwlNbEzGsJ3hABG686TDdkoXe2/krXJiuYmeVHzEUeIF4u9qZiTUS4miCjWilVgleuaZsBosUzuRjxp9KMx8dqqCSwGNC1hvjRGSseBoHDE7P2/YRZmN1kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632614; c=relaxed/simple;
	bh=SZm0aqInQumL7udymCHu6AfBmuAcSm+oLsEgV2TFilQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EN7lG8UH2rY7mLAVL4uPACXaQjXuHDLNVSW1wqbdkQ5B1ZXXSPFyia6e9LJ2fXLnYIpYcmNabDkhs8gPSORu4eS1nZnQJ7lw/JvrCnvNv2EYnEtFdIqix9s96hiMn0X9ZQZ8HwGPYo3BcrN5pESOveiqOSG4O0Z9SsdngqDZik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LbYyslbN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Odfc0Qo0hwkeagIRidcjcDJsqpZPBZdeOyDYmPrEp30=; b=LbYyslbN+YAXidU1tYdH+E1yfp
	SSXoIbbtCEznvpLS58lgUhKB9zVFzFyX0xPZHtjVBY9qlVam9GMg6HoJnOGHsmh8yQdnjM9bMJ+6H
	4GOuZJHrxvia7k4ev/M3JSxQMwzL1IshXbmuCxSXcDK4SxoaMHvBb8JjgNpSSw+mBG2eoTBiFM+jJ
	tCHqlHc6ThDP3jb4Zv12YJ3TgRuvzyPqjVdgN0eKtv70htLA6PPdW5vq5kZoPddHWqRIUF/vcEVWz
	kGmhSOzCZjGHXgdTbgX288y585CcOO39szl4eldC4RXRBcytUTt212DbjkeR199KOp38ME9tzvl5Y
	pKubLoFg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpppZ-00000006Q9f-176h;
	Thu, 28 Mar 2024 13:30:09 +0000
Date: Thu, 28 Mar 2024 13:30:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: RFC: asserting an inode is locked
Message-ID: <ZgVw4fVVLLGnG_8u@casper.infradead.org>
References: <ZgTL4jrUqIgCItx3@casper.infradead.org>
 <CAOQ4uxjK2Dcv0oDo5K6Z6QevapViR_mPFD_+wXu1GaufXs42WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjK2Dcv0oDo5K6Z6QevapViR_mPFD_+wXu1GaufXs42WA@mail.gmail.com>

On Thu, Mar 28, 2024 at 08:14:32AM +0200, Amir Goldstein wrote:
> On Thu, Mar 28, 2024 at 3:46 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > I have this patch in my tree that I'm thinking about submitting:
> >
> > +static inline void inode_assert_locked(const struct inode *inode)
> > +{
> > +       rwsem_assert_held(&inode->i_rwsem);
> > +}
> > +
> > +static inline void inode_assert_locked_excl(const struct inode *inode)
> > +{
> > +       rwsem_assert_held_write(&inode->i_rwsem);
> > +}
> >
> > Then we can do a whole bunch of "replace crappy existing assertions with
> > the shiny new ones".
> >
> > @@ -2746,7 +2746,7 @@ struct dentry *lookup_one_len(const char *name, struct den
> > try *base, int len)
> >         struct qstr this;
> >         int err;
> >
> > -       WARN_ON_ONCE(!inode_is_locked(base->d_inode));
> > +       inode_assert_locked(base->d_inode);
> >
> > for example.
> >
> > But the naming is confusing and I can't think of good names.
> >
> > inode_lock() takes the lock exclusively, whereas inode_assert_locked()
> > only checks that the lock is held.  ie 1-3 pass and 4 fails.
> >
> > 1.      inode_lock(inode);              inode_assert_locked(inode);
> > 2.      inode_lock_shared(inode);       inode_assert_locked(inode);
> > 3.      inode_lock(inode);              inode_assert_locked_excl(inode);
> > 4.      inode_lock_shared(inode);       inode_assert_locked_excl(inode);
> >
> > I worry that this abstraction will cause people to write
> > inode_assert_locked() when they really need to check
> > inode_assert_locked_excl().  We already had/have this problem:
> > https://lore.kernel.org/all/20230831101824.qdko4daizgh7phav@f/
> >
> > So how do we make it that people write the right one?
> > Renaming inode_assert_locked() to inode_assert_locked_shared() isn't
> > the answer because it checks that the lock is _at least_ shared, it
> > might be held exclusively.
> >
> > Rename inode_assert_locked() to inode_assert_held()?  That might be
> > enough of a disconnect that people would not make bad assumptions.
> > I don't have a good answer here, or I'd send a patch to do that.
> > Please suggest something ;-)
> >
> 
> Damn, human engineering is hard...
> 
> I think that using inode_assert_held() would help a bit, but people may
> still use it after inode_lock().
> 
> How about always being explicit?
> 
> static inline void inode_assert_locked(const struct inode *inode, bool excl)
> {
>         if (excl)
>                 rwsem_assert_held_write(&inode->i_rwsem);
>         else
>                 rwsem_assert_held(&inode->i_rwsem);
> }
> 
> and change inode_is_locked() to also be explicit while at it, to nudge
> replacing all the existing weak assertion with inode_assert_locked().

I liked this idea when I first read it, but now I'm not so sure.

	inode_assert_locked(base->d_inode, false);

wait, what does 'false' mean?  Is that "must be write locked" or
is it "can be read locked only"?  And introducing enums or defines
to replace true/false doesn't really get us anywhere because we're
still looking for a word that means "at least read locked" rather than
"exactly read locked".

We don't have this problem in MM because we have mmap_read_lock() and
mmap_write_lock(), so mmap_assert_locked() and mmap_assert_write_locked()
are natural.  I totally understand the FS aversion to the read/write
terminology ("You need a read lock to do writes?"), but the real problem
is that it's not inode_lock_excl().  I don't know that we want to
replace all 337 occurrences of inode_lock() with inode_lock_excl() and 
all 485 occurrences of inode_unlock() with inode_unlock_excl().

