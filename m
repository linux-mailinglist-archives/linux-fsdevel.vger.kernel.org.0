Return-Path: <linux-fsdevel+bounces-61977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE64AB81382
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A99AF6271FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 17:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127032FF155;
	Wed, 17 Sep 2025 17:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="W0N5zbha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2F229B18
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Sep 2025 17:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758131036; cv=none; b=kXx8ucWRCuNtTNy98M0Dj1PEch0oJuGM++o9kbVRvMt1j9/HNAayqm9OCKiO8cxYj3QbXPN8VYnAzGlQ2J+gfW58hStel32v2cXG7oYlUc+SpLXs8T9TnkC9WxIVQMsti6Qm7b5TPhhRh/m63NbHc0lsV2JC4RY5kyjGsWz3r30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758131036; c=relaxed/simple;
	bh=mTzbSQfrwv0ktwAc3tVKlpKttHS6ocipL63XYhYBmJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHs7AHLaZLghQDH26paBdHeGJiXkhx+JGO+1vkqwPq9tn1yJJQC2+tHmbkf3nIjxfaOBiyZKlJCpjBZ2+F71q+tu5ZZ6jlruIjZ0wM4QqDAG4U/th8PhWSKFCpddR1boXlE1Ib/AUq7PUT98bvRbDTB0y8hh9gEPCMixJ5M9DwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=W0N5zbha; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mFVoSwzrnGc7DnvSDYD7RlfIAqnxbtLGf1OPdWnH0y0=; b=W0N5zbhasu7AlHiSUZy4j59ZVM
	JHppaRPTMqq/C2JLiCKyfI/R8x0D3HEKRq2UlBjutx5LLY0Wyp9Sli9NHiytosbpOsreRdCixqK5+
	fZxmVUtdcHDMUMmloptzyWKo0ZmhOYxiL+s8NJIvCpDZAU8aT27ch3GUveYnJsVon2ZpBdOrBH5FJ
	I1WR9e0Ek8/itAT34UiMicV0GNNM+NOxUrZvmn5G2UEhS8IjXPE/SkxZeW1tuyB7wpOPvzlfSgGYr
	wha4Sbto1JDy1HFSd8VouKb4n37dhJOBbS0RELWH8g62Ww7t0z7ASjjN1hRplyS+qJyY+nusVxKxq
	aTaMS4kQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uywC6-000000050xY-2cjQ;
	Wed, 17 Sep 2025 17:43:50 +0000
Date: Wed, 17 Sep 2025 18:43:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org,
	NeilBrown <neil@brown.name>
Subject: Re: [PATCH] fuse: prevent exchange/revalidate races
Message-ID: <20250917174350.GW39973@ZenIV>
References: <20250917153031.371581-1-mszeredi@redhat.com>
 <20250917153655.GU39973@ZenIV>
 <CAJfpegsZT4X5sZUyNd9An-LxQQAV=T1AEPUYQJUUX4bZzUwJUg@mail.gmail.com>
 <20250917164148.GV39973@ZenIV>
 <CAJfpegvYJD8UUuukNY7oj7-PSu48y6hXn+iV9iHzrO4fdgWXQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvYJD8UUuukNY7oj7-PSu48y6hXn+iV9iHzrO4fdgWXQw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Sep 17, 2025 at 07:27:25PM +0200, Miklos Szeredi wrote:
> On Wed, 17 Sept 2025 at 18:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Wed, Sep 17, 2025 at 05:42:18PM +0200, Miklos Szeredi wrote:
> > > > ... and if the call of ->d_revalidate() had been with parent locked, you've
> > > > just got a deadlock in that case.
> > >
> > > Why?
> >
> > Because the locking order on directories is "ancestors first"; you are trying
> > to grab an inode that is also a directory and might be anywhere in the tree
> > by that point - that's precisely what you are trying to check, isn't it?
> 
> But if parent is locked, it must not have been renamed, hence
> parent-child relationship holds.

Not if parent is held shared.

