Return-Path: <linux-fsdevel+bounces-11513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB50C85432F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4021F285B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 07:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99BA11739;
	Wed, 14 Feb 2024 06:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qh9Rk2Fv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2085125A1;
	Wed, 14 Feb 2024 06:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707893984; cv=none; b=JGSSlGFhmus0PIpEUaZRTEajGYxa/jHMx4T6yK2M2cjYkCSGd6BUPvgFFrjuGm9Yfw5WjhmgcvD7fNyJhW8ESbHcfbP8zMIHSfXFNTJ8n7ZzlQKwjmbf95KeM1H9mBnqt/GWlkSuVgK2ZFJJa2YfsKQJcx3G59SwREh+zmsr9pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707893984; c=relaxed/simple;
	bh=CS45QcVTT2orYhyYWwHGZgci25zetj2poa2oQoA+Qkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGHrBSfAfFmo/Fi5VSE/J2NkvFDgBw1/wlO6DdD2K/lKay8QLwf5xcXhJ3y9NtuvmHKT7OJtM7wOD5PAiWdJifsDCTBJk9Y48HGnfb5At/rVZQrUinJyhiS8Pp1RDpCfJvARZYKrcLZeWgiuFnQ7D8888nDXBtH8FVy/xKCRLic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qh9Rk2Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0546CC433C7;
	Wed, 14 Feb 2024 06:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707893983;
	bh=CS45QcVTT2orYhyYWwHGZgci25zetj2poa2oQoA+Qkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qh9Rk2FvW4tWlAWdz0iYDcgsCcNhqHDodBRSm2Ahxxogpbd+1FwGwI+oPZPtk2YXt
	 XcXI3kcrT2Gc0TKHUFNK3hQ0VqgTtmfEUjPtLuhjJbnNo+2z2YAQHtrghbVMCMzSeQ
	 XyffkRKeIyHUohBlM/+8e3ex4T2LzDh/eVeZQjc8=
Date: Wed, 14 Feb 2024 07:59:40 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lukas Wunner <lukas@wunner.de>, Dan Williams <dan.j.williams@intel.com>,
	Arnd Bergmann <arnd@arndb.de>, Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>, linux-arch@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Message-ID: <2024021418-diving-subduing-6e34@gregkh>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <20240213062559.GA27364@wunner.de>
 <c0a08e00-e7b5-48ac-a152-3068ab0c9e15@efficios.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0a08e00-e7b5-48ac-a152-3068ab0c9e15@efficios.com>

On Tue, Feb 13, 2024 at 02:46:05PM -0500, Mathieu Desnoyers wrote:
> On 2024-02-13 01:25, Lukas Wunner wrote:
> > On Mon, Feb 12, 2024 at 11:30:58AM -0500, Mathieu Desnoyers wrote:
> > > In preparation for checking whether the architecture has data cache
> > > aliasing within alloc_dax(), modify the error handling of virtio
> > > virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
> > > non-fatal.
> > > 
> > > Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > > Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> > 
> > That's a v4.0 commit, yet this patch uses DEFINE_FREE() which is
> > only available in v6.6 but not any earlier stable kernels.
> 
> I asked this question to Greg KH before creating this patch, and his
> answer was to implement my fix for master, and stable kernels would take
> care of backporting all the required dependencies.

That is correct.

> Now if I look at latest 6.1, 5.15, 5.10, 5.4, 4.19 stable kernels,
> none seem to have include/linux/cleanup.h today. But I suspect that
> sooner or later relevant master branch fixes will require stable
> kernels to backport cleanup.h, so why not do it now ?

Yes, eventually we will need to backport cleanup.h to the older kernel
trees, I know of many patches "in flight" that are using it, so it's not
unique to this one at all, so this is fine to have.

Remember, make changes for Linus's tree, don't go through any gyrations
to make things special for stable releases, that's something to only
consider later on, if you want to.  stable kernels should have no affect
on developers OTHER than a simple cc: stable tag on stuff that they know
should be backported, unless they really want to do more than that,
that's up to them.

thanks,

greg k-h

