Return-Path: <linux-fsdevel+bounces-32146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45899A14C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 123581C221A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7B81D2715;
	Wed, 16 Oct 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jEN01+cD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2013B298
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 21:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729114070; cv=none; b=tgxg01VuNxccT02bOhFX/8DQu+9GzsvsZGa+AeI5IMy4fp/9QVdTf2deT8VxLjYI3LVy49GZ8oAay6NZve8/kU1VOBHVK+Tzdckw13MZ2uYNoq2jHVOfQy33bSk/QVw48PtZk8i6qmDLRZveRfWG4zRVTruCM0NB7gCOKEM0VJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729114070; c=relaxed/simple;
	bh=nYJzvOC2T7whR59bYxUzYTAaPmE0xptCrPJLVRr9CW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpehD9oAUwn8yKJJjateIhWGnDhYhtmI3EKdHm1Yl3WkzW9ZFyx/dU//NCrNt470VycIFCrFYNiA/TqEbvi3W+xqAjC/e+OWr9C3KpTB15Fe68uEzgq3LPcunshQrgxlHgjJIM0mALWvpag9BygqvkA7D+gCxMlZiYhF04iRAM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jEN01+cD; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 16 Oct 2024 14:27:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729114065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H/tA/1ocUtWMaIds/iC4Y3qO3oArcv/xVKZQaL3TzUI=;
	b=jEN01+cDRcz+4WkeNRRKfE/C7fC9yvlfooyl7lFOic2lq+v88fC2SiXr8QI0KGpR1oSpHT
	oKnYchWpERz4v7RWspPS9DpF5ibfk+D7IW0L1TmCO4AW/jiiIpE+FYR6OJOp2rw6cDFO04
	HgC69RuhWYAddBcGrSU+D2XsfpNRSG8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, bernd.schubert@fastmail.fm, jefflexu@linux.alibaba.com, 
	hannes@cmpxchg.org, linux-mm@kvack.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] fuse: remove tmp folio for writebacks and
 internal rb tree
Message-ID: <g5qhetudluazn6phri4kxxa3dgg6diuffh53dbhkxmjixzpk24@slojbhmjb55d>
References: <20241014182228.1941246-1-joannelkoong@gmail.com>
 <20241014182228.1941246-3-joannelkoong@gmail.com>
 <CAJfpegs+txwBQsJf8GhiKoG3VxLH+y9jh8+1YHQds11m=0U7Xw@mail.gmail.com>
 <CAJnrk1a5UaVP0qSKcuww2dhLkeUqdkri_FEyVMAuTtvv3NMu9Q@mail.gmail.com>
 <ntkzydgiju5b5y4w6hzd6of2o6jh7u2bj6ptt24erri3ujkrso@7gbjrat65mfn>
 <CAJfpeguS-xSjmH2ATTp-BmtTgT0iTk2_4EMtnoxPPcepP=BCpQ@mail.gmail.com>
 <tgjnsph6wck3otk2zss326rj6ko2vftlc3r3phznswygbn3dtg@lxn7u3ojszzk>
 <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvd-5h5Fx4=s-UwmbusA9_iLmGkk7+s9buhYQFsN76QNw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 16, 2024 at 08:37:12PM GMT, Miklos Szeredi wrote:
> On Wed, 16 Oct 2024 at 19:52, Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > If I understand you correctly, you are saying fuse server doing wrong
> > things like accessing the files it is serving is not something we need
> > to care about.
> 
> I don't think detecting such recursion is feasible or even generally possible.
> 
> > More specifically all the operations which directly
> > manipulates the folios it is serving (like migration) should be ignored.
> > Is this correct?
> 
> Um, not sure I understand.  If migration can be triggered on fuse
> folios that results in the task that triggered the migration to wait
> on the fuse folio, then that's bad.

Why is it bad? I can understand fuse server getting blocked on fuse
folios is bad but why it is bad for other applications/tasks? I am
wondering network filesystems have to handle similar situation then why
is it bad just for fuse?

> Ignoring fuse folios is the only
> solution that I can see, and that's basically what the current temp
> page copy does.
> 
> Sprinkling mm code with fuse specific conditionals seems the only
> solution if we want to get rid of the temp page thing.  Hopefully
> there aren't too many of those.

It might be a bit more than sprinkling. The reclaim code has to activate
the folio to avoid reclaiming the folio in near future. I am not sure
what we will need to do for move_pages() syscall.

