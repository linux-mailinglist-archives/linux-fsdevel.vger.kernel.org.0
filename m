Return-Path: <linux-fsdevel+bounces-19705-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD9F8C8FAE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 07:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E9F283105
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 May 2024 05:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D627D8F70;
	Sat, 18 May 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbCEFVYD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8C21FAA;
	Sat, 18 May 2024 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716009790; cv=none; b=hMM1GLp+Lfo0AG2kiUxLaUk7StG5SyrJ/6LsajFDeXXAYVfQtIKQe37iF5naQMkeY0YAQYUUwsvQhwO2SDnQ56Ej0zZu/Vdx6J6EvuamUwTL0w1mo5JusFTff0f/cuiLKT4HfFZe9EmROUzokxoKu6QsA5/HpI92bFTj/TWkDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716009790; c=relaxed/simple;
	bh=DeoWO0mutiliegPt+y8MrU8BJk+Myi8ZfHV9a/r4mRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfxjO9qPwmLWrL1kNWbvhlB2UdHnQHC0/YpZKQRpB8gzFvPCSj/S0dhHWYzUICXlFYQ1/oY9O78pqvqENCrt/nq4vcq1jDF5vDsHbYrq37nMEXqNT2li6kH6Cg2FkopTAwuVx0MfpQf1/T8/HrChCi+Kes0O6BIwGcEJmgTgUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sbCEFVYD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Euwcm65mnr00g5NnHfcDpjoG3V7LDS3rY2DNT47gNPs=; b=sbCEFVYDeYC7W/rUIR8jBfte5u
	z6Z2sswC0Om9tIUTlORDD6kyCXXZxBvsqTUgZR5QXYeaeqNr15Lx27EdEvwd/AZK8H6UtcRHUuIl4
	U37o4fbPw8hHyCePMdxa5zqqaOYshuZE594RN4EO2KicFiFQq4uByvPzOeil6RbcLBzeZBaSjrVga
	vp81RXHdY7K9K67/hQeGXqEGfh1rAXJalRBqw1hSUTaDuyV4j2U7MD/EwlgcI3EJipDqZEJ4CqTxR
	DMcVeWIzoUDQ+fOS/YvGfWVnE7ibbO+HShFPEel18Yc7I/cl98Ls8L6G0pfNxUzkZ78sqbBRICMpF
	Fg2W6/lA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s8CXA-0000000Dhxo-32YG;
	Sat, 18 May 2024 05:23:04 +0000
Date: Sat, 18 May 2024 06:23:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: switch timespec64 fields in inode to discrete
 integers
Message-ID: <Zkg7OCSYJ7rzv6_D@casper.infradead.org>
References: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517-amtime-v1-1-7b804ca4be8f@kernel.org>

On Fri, May 17, 2024 at 08:08:40PM -0400, Jeff Layton wrote:
> For reference (according to pahole):
> 
>     Before:	/* size: 624, cachelines: 10, members: 53 */
>     After: 	/* size: 616, cachelines: 10, members: 56 */

Smaller is always better, but for a meaningful improvement, we'd want
to see more.  On my laptop running a Debian 6.6.15 kernel, I see:

inode_cache        11398  11475    640   25    4 : tunables    0    0    0 : slabdata    459    459      0

so there's 25 inodes per 4 pages.  Going down to 632 is still 25 per 4
pages.  At 628 bytes, we get 26 per 4 pages.  Ar 604 bytes, we're at 27.
And at 584 bytes, we get 28.

Of course, struct inode gets embedded in a lot of filesystem inodes.
xfs_inode         142562 142720   1024   32    8 : tunables    0    0    0 : slabdata   4460   4460      0
ext4_inode_cache      81     81   1184   27    8 : tunables    0    0    0 : slabdata      3      3      0
sock_inode_cache    2123   2223    832   39    8 : tunables    0    0    0 : slabdata     57     57      0

So any of them might cross a magic boundary where we suddenly get more
objects per slab.

Not trying to diss the work you've done here, just pointing out the
limits for anyone who's trying to do something similar.  Or maybe
inspire someone to do more reductions ;-)

