Return-Path: <linux-fsdevel+bounces-19351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554358C376C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 18:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 098211F21221
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2024 16:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111AB46430;
	Sun, 12 May 2024 16:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HDRJ4irU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE731C683
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715530616; cv=none; b=nCQ4gpdaaBFJ/+7piH4IDbO2ZtmvZ6oSRPhNGp62TrLklXRP9C2LQL9Bbr5afa8zNv7yIFwG6HmXDrnjTJ0vRK7Zo53/7aK/PWlvFQYQEBwMr+B1Essp4WlZaRoKekIb56gVFWs0ZKUV0flpeZ1O7f0ZYHx4sMNV6/TbmcWTbos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715530616; c=relaxed/simple;
	bh=eWVVWX5i9ZJSuWPjNqc5938CsSyTdoxuDErnUcclfQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rvcv9lxOIeNjh37uhVdCP5JzRE1gfIfNMYHHqbhakdoZ1H3KeSMY2hKq7nFY0Dr3XZwShwTUl1CVjKcw+R2rHU9W4VRoMA3p4EM4AuKSW3QiEixPRwJaaOxPJhvsLKIgOv/TJ77uSrRj52KILvNbb8VyvSw/5rZTlZCkSehwOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HDRJ4irU; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oBEon2b2+axgp+aHLR7d7VWTivz1GrTRimVxtDCF0Ng=; b=HDRJ4irU1+WKJm6l42vynW9jMI
	DYGgN69+DBxR3lqa8EwRQuPrL/URrwDXEjwauXbr9Rvgd751M7qZMzAoxQmkthkaT2doQrYx1HqnZ
	QRw5l7A0gYrjOTO9UJV0MLEHd+n71X8+Q+Wh+NCK44Fc96YNPiQKgSKPQFCO0nR4hTBkqDwSeWL5+
	J8dDRBIJVJ4r7A3BkVBBtbo5McyA0HAd2IDgCFRdfl+Z8UEX9lyxkZN6xejbAn709CMchlutV/zQ4
	A2mxf+2na29Hv1nUSzm//dMu+ViPUTA1z8Fsz3agmdx3a/YX2rpi/ty5f6D0muKfR4evHa2/5ot6C
	8onYHQXQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s6BsO-004cnv-1m;
	Sun, 12 May 2024 16:16:40 +0000
Date: Sun, 12 May 2024 17:16:40 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, brauner@kernel.org,
	jack@suse.cz, laoar.shao@gmail.com, linux-fsdevel@vger.kernel.org,
	longman@redhat.com, walters@verbum.org, wangkai86@huawei.com,
	willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240512161640.GI2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4320c051be326ddeaeba44c4d209ccf7c2a3502.camel@HansenPartnership.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, May 12, 2024 at 11:45:44AM -0400, James Bottomley wrote:
> On Sat, 2024-05-11 at 20:28 +0100, Al Viro wrote:
> > On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:
> > 
> > > so we have another level of locking going on, and my patch only
> > > moved
> > > the dcache pruning outside the lock of the directory we're removing
> > > (not outside the lock of the directory that contains the removed
> > > directory).
> > > 
> > > And that outside lock is the much more important one, I bet.
> > 
> > ... and _that_ is where taking d_delete outside of the lock might
> > take an unpleasant analysis of a lot of code.
> 
> Couldn't you obviate this by doing it from a workqueue?  Even if the
> directory is recreated, the chances are most of the negative dentries
> that were under it will still exist and be removable by the time the
> workqueue runs.

Eviction in general - sure
shrink_dcache_parent() in particular... not really - you'd need to keep
dentry pinned for that and that'd cause all kinds of fun for umount
d_delete() - even worse (you don't want dcache lookups to find that
sucker after rmdir(2) returned success to userland).

