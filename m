Return-Path: <linux-fsdevel+bounces-19337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7288C33D2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 23:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69133281C89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 21:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCA21A04;
	Sat, 11 May 2024 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bemWBGJR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC06C8F3
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 21:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715462248; cv=none; b=uHvTXbxdyyTZ7OcTa0eunZ/CQAQsrJ70lOCZjBsrQMjEAtSTumuKJxBzVC7I9I66wagfTRk0qbpTzl2dooCQKq/Yi09JgQbZOEUiukqDZArFxRSuJ6G5OGNPAsoLc8J7GwSdBdo1tA1SJBBZe1VcZNOrOgBDTb8thDNfyOnJwnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715462248; c=relaxed/simple;
	bh=YQuQGCr4jHjlZnfZfXlJRPDfUPOX5ycSNFyngSb6jm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhlzispRYOTCFM14h4bbjHZylYXc4prH5HbvX+sDT83cMy1yqZbhcLjM6AOFvT0LIyKbAFpJiA0vg9cBNJd9cIeYIH/MxYcF3QfyG/OvNF0Cv8x6pK2y0q9u+ap4FOYTLC0DeRtYMGnJzqT7SdGX+1HZkGraeXYw0duWCw+VwAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bemWBGJR; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8YIC+xpxGIvo+ln/Q3vJoOySW1VChRXPdWCQ3HYtlnk=; b=bemWBGJRm6/4EjwECEeDOgoIVu
	HvEc2BkHvHmYbDXNoemnwx2orRCDorkTjkM81wSDq/wE74hIzWmzSyiFcbuzSMeRhgoZDC77jtAPT
	NzLzO66ib4m8WgHfDWBpDAQgaF50/BZa+eF7yhrWYI4dnlLfi6EBLagB7S1Lvqx9jmxiIs3glfhfy
	vbaFhvpH3Ttk3q2lhq1yetZ/N6hrQNjeslHai0hait2aP+gd3ZQ7iDEC6t9wTrBEwl70MU10RZUhO
	SoDKOMyp2tD268Beb1Uv7+wr9wDsnf/e6kDj/7hsDFyVA/znRh5DU7tdFb7qtojni2h2vH8Rv+476
	SPKe0PJw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5u5l-003szk-1d;
	Sat, 11 May 2024 21:17:17 +0000
Date: Sat, 11 May 2024 22:17:17 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240511211717.GE2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <CAHk-=wi7BtsC7wvTqnYOtAiWzM2Q5tK=TG=V=7D6SKfbzhoCKw@mail.gmail.com>
 <20240511203143.GD2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240511203143.GD2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 11, 2024 at 09:31:43PM +0100, Al Viro wrote:
> On Sat, May 11, 2024 at 12:55:29PM -0700, Linus Torvalds wrote:
> > On Sat, 11 May 2024 at 12:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:
> > > >
> > > > And that outside lock is the much more important one, I bet.
> > >
> > > ... and _that_ is where taking d_delete outside of the lock might
> > > take an unpleasant analysis of a lot of code.
> > 
> > Hmm. It really shouldn't matter. There can only be negative children
> > of the now deleted directory, so there are no actual effects on
> > inodes.
> > 
> > It only affects the d_child list, which is protected by d_lock (and
> > can be modified outside of the inode lock anyway due to memory
> > pressure).
> > 
> > What am I missing?
> 
> fsnotify and related fun, basically.  I'll need to redo the analysis,
> but IIRC there had been places where correctness had been guaranteed
> by the fact that this had been serialized by the lock on parent.

As an aside, I'd really love to see d_rehash() gone - the really old nest
of users is gone (used to be in nfs), but there's still a weird corner case
in exfat + a bunch in AFS.  Life would be simpler if those had been gone -
many correctness proofs around dcache have unpleasant warts dealing with
that crap.  Not relevant in this case, but it makes analysis harder in
general...

