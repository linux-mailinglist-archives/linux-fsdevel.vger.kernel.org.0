Return-Path: <linux-fsdevel+bounces-9190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C580783EB8E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 08:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2221C219AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 07:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1D61D698;
	Sat, 27 Jan 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMIGHA/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E18134BC;
	Sat, 27 Jan 2024 07:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339109; cv=none; b=c9i3twCoDVrwxAOowSw3TWfYcODXVFx9V6637h39urlJWT+xmdlTcqNTdWT0EOu5aoPIq1ZxYSbLCYK+suR2afDVee+nolInVq6gm7HlIBydhmpFGAbB7psWLc4AfsXX1GldNbMjsRESBqHX1kw+EspaUaKFHEklsG+s5c4V4cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339109; c=relaxed/simple;
	bh=ForPykU7IwFx2c1CLmNnFixuMgi+ep01OHJkD8/dsQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFvW0vq4Hh5Ub0xbuYLCH2BW6tILql+lt+VwWRRkHi0uslW1zgfOna3QyiAkfg1UWShhM01OsG1RMS6FCC3Ghdn27hqsJNJ+yPmEnruUbarI+oY2IqekGrXj5Hf3Y6BkGJMcxCVDQxT+LV8xOB+guNAv0Y4GK4hr8W4x7eu6yfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMIGHA/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C19C433C7;
	Sat, 27 Jan 2024 07:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706339108;
	bh=ForPykU7IwFx2c1CLmNnFixuMgi+ep01OHJkD8/dsQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMIGHA/jRSUgkbd3OAZWX3lax3BmYcyT1+dqFBKGmWyJ3k79Zl7yA74B8UwxNbDC3
	 VoQvGbhhzKfhyPh5i+IqL0LUFCFVSiHIGlK+9MvFcps05gPX9KnhhpqX+jadG9Sgz0
	 +Hjbwv7JhuqRmsFgIYxdWvkb4QNAkrKQa6F3nRj8nAm8WABWS/yS41Vho3Y0VBWAmf
	 r0L1J6LnOsN2lhW0PTYfi/X3T5cWc+M1utSPGC03PJAa9FNL6wl59gxWWPrq6j4kQD
	 5zlB91Qwa/RRdv7WqEX5damNjqiaznV9ii9d/wbBFtHBhXXQSENVdWtDS+7CKmWo2O
	 9Qk3l5TBid1aw==
Date: Fri, 26 Jan 2024 23:05:06 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Yangtao Li <frank.li@vivo.com>, linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, vishal.moola@gmail.com,
	linux-mm@kvack.org, Adam Manzanares <a.manzanares@samsung.com>,
	Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
	linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: Support enhanced hot/cold data separation for f2fs
Message-ID: <20240127070506.GC11935@sol.localdomain>
References: <Y4ZaBd1r45waieQs@casper.infradead.org>
 <20221130124804.79845-1-frank.li@vivo.com>
 <Y4d0UReDb+EmUJOz@casper.infradead.org>
 <Y5D8wYGpp/95ShTV@bombadil.infradead.org>
 <ZbLI63UHBErD6_L2@casper.infradead.org>
 <ZbLKl25vxw0eTzGE@bombadil.infradead.org>
 <ZbQdkiwEs8o4h807@casper.infradead.org>
 <ZbQk1WqGgwgoMbg3@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbQk1WqGgwgoMbg3@bombadil.infradead.org>

On Fri, Jan 26, 2024 at 01:32:05PM -0800, Luis Chamberlain wrote:
> On Fri, Jan 26, 2024 at 09:01:06PM +0000, Matthew Wilcox wrote:
> > On Thu, Jan 25, 2024 at 12:54:47PM -0800, Luis Chamberlain wrote:
> > > On Thu, Jan 25, 2024 at 08:47:39PM +0000, Matthew Wilcox wrote:
> > > > On Wed, Dec 07, 2022 at 12:51:13PM -0800, Luis Chamberlain wrote:
> > > > > Me and Pankaj are very interested in helping on this front. And so we'll
> > > > > start to organize and talk every week about this to see what is missing.
> > > > > First order of business however will be testing so we'll have to
> > > > > establish a public baseline to ensure we don't regress. For this we intend
> > > > > on using kdevops so that'll be done first.
> > > > > 
> > > > > If folks have patches they want to test in consideration for folio /
> > > > > iomap enhancements feel free to Cc us :)
> > > > > 
> > > > > After we establish a baseline we can move forward with taking on tasks
> > > > > which will help with this conversion.
> > > > 
> > > > So ... it's been a year.  How is this project coming along?  There
> > > > weren't a lot of commits to f2fs in 2023 that were folio related.
> > > 
> > > The review at LSFMM revealed iomap based filesystems were the priority
> > > and so that has been the priority. Once we tackle that and get XFS
> > > support we can revisit which next fs to help out with. Testing has been
> > > a *huge* part of our endeavor, and naturally getting XFS patches up to
> > > what is required has just taken a bit more time. But you can expect
> > > patches for that within a month or so.
> > 
> > Is anyone working on the iomap conversion for f2fs?
> 
> It already has been done for direct IO by Eric as per commit a1e09b03e6f5
> ("f2fs: use iomap for direct I/O"), not clear to me if anyone is working
> on buffered-io. Then f2fs_commit_super() seems to be the last buffer-head
> user, and its not clear what the replacement could be yet.
> 
> Jaegeuk, Eric, have you guys considered this?
> 

Sure, I've *considered* that, along with other requested filesystem
modernization projects such as converting f2fs to use the new mount API and
finishing ext4's conversion to iomap.  But, I haven't had time to work on these
projects, nor to get very involved in f2fs beyond what's needed to maintain the
fscrypt and fsverity support.  I'm not anywhere close to a full-time filesystem
developer.  I did implement the f2fs iomap direct I/O support two years ago
because it made the fscrypt direct I/O support easier.  Note that these types of
changes are fairly disruptive, and there were bugs that resulted from my
patches, despite my best efforts.  It's necessary for someone to get deeply
involved in these types of changes and follow them all the way through.

- Eric

