Return-Path: <linux-fsdevel+bounces-13249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A489886DA9D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 05:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6BDC1C22731
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A46481DE;
	Fri,  1 Mar 2024 04:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wN9leVmh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B63FE54
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709266729; cv=none; b=QstzAimi9UjaL+JoC4wWEUYDbUSAK5Lhr6fyi3/a39oiV9U0RQ0Lyh1XFkO6bTisDSExOUs+uEg/vL+eoqMVIY56SKlJfTER1grLFUwZL7HuvVXTV/62zx/jHoAzr+tsZ5Z5B3aNSaNdfbHO02Zt+nQb8Ab2/AJNFRJlW5F6Xiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709266729; c=relaxed/simple;
	bh=QJgYk2wOo/4j9zDbt1nhktKq+ggDsutSU3Zh6LCGv1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk7exsx61oW7xWwdhIST3XqR/NI6IfG1JiQEZxgss3WVrk4/D3OzgkliHzWgPLZoPfmPXLE/ToAmPZNFqRbmaQGdeeSgGJyicRBuTM6nchnhPE9/RANOQ7fTwhiW/pNXDbx3w0Xouh6QMBLo5TFetL38eUoA+ioP+2CdnuJPtng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wN9leVmh; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 29 Feb 2024 23:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709266725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EISxu23Q77/3CUFc4vXXHXQtBH9TF3gbFBwFkoR5QsY=;
	b=wN9leVmh+Q7W3amvqJ2/HDLUCgacVtvKQB5NgJnfPoryaCmuXMM0ZJaqHoAHXqOYlQd3MH
	9xyJp1icAk6oQ12UUK+uxQ/JrYSQ4I//cLxrKf0mcgTxH0z67j0GfXZrlKWRzZQ4it0Iy0
	AJp12BladDMuBcbwPtTbHH310oZSs/4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Matthew Wilcox <willy@infradead.org>, Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <jprg3gjjbofdkbeui5idtqzhqy3scuxznqnarwmnipfghk5qvk@qpokv27zln2h>
References: <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
 <ZeFCFGc8Gncpstd8@casper.infradead.org>
 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
 <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
 <3bykct7dzcduugy6kvp7n32sao4yavgbj2oui2rpidinst2zmn@e5qti5lkq25t>
 <vpyvfmlr2cc6oyinf676zgc7mdqbbul2mq67kvkfebze3f4ov2@ucp43ej3dlrh>
 <170926614942.24797.13632376785557689080@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170926614942.24797.13632376785557689080@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 01, 2024 at 03:09:09PM +1100, NeilBrown wrote:
> No.  You warn and DON'T fail the allocation.  Just like lockdep warns of
> possible deadlocks but lets you continue.
> These will be found in development (mostly) and changed to use
> __GFP_RETRY_MAYFAIL and have appropriate error-handling paths.

And when an allocation happens that cannot be satisfied without killing
everything off? You do realize there are _lots_ of allocations where
userspace has control over the size of the allocation, via e.g. obscure
ioctls that ask for a buffer to be filled?

