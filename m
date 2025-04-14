Return-Path: <linux-fsdevel+bounces-46393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E92A8859E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 16:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8842C16CC81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6402BCF70;
	Mon, 14 Apr 2025 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rCkGwboE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340662BCF5D
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641041; cv=none; b=AG5x0iKYycEkr6uRDD0KC1uBAcz8BHNVOPYHQkTfJ5GVcGFXSgCsJvMUxjs334sQy6BH/zprhwAI2Ln+bo1pkRfaoC2AobBJAlpTD2RaNNU5auFM+/AGGRSSNk811hwHg70z8sTZ/nH69LlzuASZtAIbbBTWz3toa6aYPtEJWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641041; c=relaxed/simple;
	bh=2VkEa1qYknZs7hu6iEjaWvXt2Z8kyC/88IVQ5v1JOsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pbP+thyrqr4S2sHBZflHVUseQZtMRkCJJbXJX7AMlIkQSrjdO4OoaPAg/kHGaQo5q7mxx9SvWgUHqeZ4iv6O5IJ1njxFb+iRu1IGyztT6v91hUz6klWr52cybyXUZwgsI19PzyXrJdeIxKDiA40j8yUhO66Q/iJaw8CwK68qy0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rCkGwboE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=k9dStyk2bdzx102PwVmEi66RNiSvPSnMQOHNxWrtzEY=; b=rCkGwboEF29GKMj8Wg2/0ADYEc
	yhiIW9mlytoOLMgA714mJvcQX7sxo05/QrxJznpc+rRqNJ7UuGVTa+QPUqiHLiNGbZFzPB7ghLpt/
	FlJ4IIzwLkcfTpsSgedwLvdkHgA8MfMcWEvapJOKLPYNpWsUyRY6yBR5yFi9YpR20axQGhbciBU5Y
	amGMmwGRuUuE041N+R7DEXIEW5dD4lj0a8YB3wkP9uckm7a2O5UjdEkOgGTdz9t0WRXo9ZxNLIcf3
	4QIzFXaIM1BCTxNU5dLAK4nzIk/4FfzBnaboSKPTmbZ91hRbVYlsR8oBw2vFiDkJTk2LL8AWxQPtX
	7p5MgPtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4KpZ-00000008Fav-1hM7;
	Mon, 14 Apr 2025 14:30:37 +0000
Date: Mon, 14 Apr 2025 15:30:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Ian Kent <raven@themaw.net>
Subject: Re: bad things when too many negative dentries in a directory
Message-ID: <Z_0cDYDi4unWYveL@casper.infradead.org>
References: <CAJfpegs+czRD1=s+o5yNoOp13xH+utQ8jQkJ9ec5283MNT_xmg@mail.gmail.com>
 <20250411-rennen-bleichen-894e4b8d86ac@brauner>
 <CAJfpegvaoreOeAMeK=Q_E8+3WHra5G4s_BoZDCN1yCwdzkdyJw@mail.gmail.com>
 <Z_k81Ujt3M-H7nqO@casper.infradead.org>
 <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2334928cfdb750fd71f04c884eeb9ae29a382500.camel@HansenPartnership.com>

On Mon, Apr 14, 2025 at 10:07:09AM -0400, James Bottomley wrote:
> On Fri, 2025-04-11 at 17:01 +0100, Matthew Wilcox wrote:
> > On Fri, Apr 11, 2025 at 05:40:08PM +0200, Miklos Szeredi wrote:
> > > However, hundreds of millions of negative dentries can be created
> > > rather efficiently without unlink, though this one probably doesn't
> > > happen under normal circumstances.
> > 
> > Depends on your userspace.  Since we don't have union directories,
> > consider the not uncommon case of having a search path A:B:C. 
> > Application looks for D in directory A, doesn't find it, creates a
> > negative dentry. Application looks for D in directory B, creates a
> > negative dentry. Application looks for D in directory C, doesn't find
> > it, so it creates it. Now we have two negative dentries and one
> > positive dentry.
> 
> If an application does an A:B:C directory search pattern it's usually
> because it doesn't directly own the file location and hence suggests
> that other applications would also be looking for it, which would seem
> to indicate, if the search pattern gets repeated, that the two negative
> dentries do serve a purpose.

Not in this case.  It's doing something like looking in /etc/app.d
/usr/share/app/defaults/ and then /var/run/app/ .  Don't quote me on the
exact paths, or suggest alternatives based on these names; it's been a
few years since I last looked.  But I can assure you no other app is
looking at these dentries; they're looked up exactly once.

> > And for some applications, the name "D" is going to be unique, so the
> > negative dentries have _no_ further use.  The application isn't even
> > going to open C/D again.  If there's no memory pressure, we can build
> > up billions of dentries.  I believe the customer is currently echoing
> > 2 to /proc/sys/vm/drop-caches every hour.
> 
> So this is an application that's the sole owner of D (i.e. sole
> controller of the entire path) yet it still does a search for it, why
> is that (if it's something like to update the location, it would be
> better served by first looking in the default location before searching
> others)?  The problem is the pattern exactly matches the shared file
> one above so there doesn't seem to be a heuristic way to distinguish
> them.

Everything works fine when there's memory pressure.  The problem is that
negative dentry growth is only constrained by available memory; there's
no reclaim of negative dentries which haven't been looked at in seconds
or minutes.

