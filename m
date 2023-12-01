Return-Path: <linux-fsdevel+bounces-4613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78528801495
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 21:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 076B8B209E1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C425584C7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 20:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="fAKASPLf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D34FA;
	Fri,  1 Dec 2023 12:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1D5xr00pbiSNnKNOHUpq8cAEaHYrXB6SCLvSNPHwawM=; b=fAKASPLf9dHbjlb2R7a8gezz4n
	gW9YY2U3ykkdBE2DBpU3rZ0svwUxRIlYHO8gY2YjDareO54fwHnSzd38e0YBJLW713aS3MfrYEBJR
	UolNfS5Xrx0U5GpOunewG19gHI6yQArE94NAY1NnKgIB1YPSCMwJQrZZjfBknGWwODKpazRdHMtaU
	M3GCt51XbEx40VkOkedV7jkQQLhNnqATRcJBu3tzXevZTe9p9asoHmYhUIlif3NVTFCeHwd+S+tn/
	m0UwBtwxzgTvLU22oW7TKmow0f4IacANB1xOegJlGZ1esEg4CqGHoQoMGXjGYcZitY22E+zao7oUC
	GnxGBEyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r99kk-0060OH-2H;
	Fri, 01 Dec 2023 20:04:47 +0000
Date: Fri, 1 Dec 2023 20:04:46 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, linux-doc@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [viro-vfs:work.dcache2] [__dentry_kill()]  1b738f196e:
 stress-ng.sysinfo.ops_per_sec -27.2% regression
Message-ID: <20231201200446.GA1431056@ZenIV>
References: <202311300906.1f989fa8-oliver.sang@intel.com>
 <20231130075535.GN38156@ZenIV>
 <ZWlBNSblpWghkJyW@xsang-OptiPlex-9020>
 <20231201040951.GO38156@ZenIV>
 <20231201065602.GP38156@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201065602.GP38156@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Dec 01, 2023 at 06:56:03AM +0000, Al Viro wrote:
> On Fri, Dec 01, 2023 at 04:09:51AM +0000, Al Viro wrote:
> > On Fri, Dec 01, 2023 at 10:13:09AM +0800, Oliver Sang wrote:
> > 
> > > > Very interesting...  Out of curiosity, what effect would the following
> > > > have on top of 1b738f196e?
> > > 
> > > I applied the patch upon 1b738f196e (as below fec356fd0c), but seems less
> > > useful.
> > 
> > I would be rather surprised if it fixed anything; it's just that 1b738f196e
> > changes two things - locking rules for __dentry_kill() and, in some cases,
> > the order of dentry eviction in shrink_dentry_list().  That delta on top of
> > it restores the original order in shrink_dentry_list(), leaving pretty much
> > the changes in lock_for_kill()/dput()/__dentry_kill().
> > 
> > Interesting...  Looks like there are serious changes in context switch
> > frequencies, but I don't see where could that have come from...
> 
> In principle it could be an effect of enforcing the ordering between __dentry_kill()
> of child and parent, but if that's what is going on... we would've seen
> more iterations of loop in shrink_dcache_parent() and/or d_walk() calls in
> it having more work to do.  But... had that been what's going on, wouldn't we
> see some of those functions in the changed part of profile?  
> 
> I'll try to split that thing into a series of steps, so we could at least narrow
> the effect down, but that'll have to wait until tomorrow ;-/

OK, a carved-up series (on top of 1b738f196e^) is in #carved-up-__dentry_kill
That's 9 commits, leading to something close to 1b738f196e+patch you've tested
yesterday; could you profile them on your reproducers?  That might give some
useful information about the nature of the regression...

