Return-Path: <linux-fsdevel+bounces-43759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ED1A5D5AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 06:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17D7F3B80A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 05:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A59C1DF975;
	Wed, 12 Mar 2025 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICeOF2ep"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082C1172A;
	Wed, 12 Mar 2025 05:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741758252; cv=none; b=LjE8705rIPCfMogmJIicxK0CqbQJS8IS5AhKFPZDdVFhLSGkrgi9A8peRIQieZ9u6zx+ICAKDZIyfkHuuR2RoTusfqG9ID/tWWke8Azq4dsVGngxg7WjfmSYFihi9R1+uNZ15WmM8AI1IZwA+e1j4qmHzgTDNpADmGTgeAZuVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741758252; c=relaxed/simple;
	bh=xZJOc5XyyMym8hnBaWHbYKIhBmxjzcDArBveIIsMQaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lp/Qt0EkbmBzZLXYUO4h6Vfbpogu4hhJsjS+gWg8tL3/7uEAoD6XRdEKrKZNcbI+dtnsQYoiYV+4vgycGMyf91bB9H6vECul/eepHGlGnhSr/axm222Trgtqfuqg6SLb7bfsPLsN3ac/r9x8aoG65QL11ufBFj//vr6NCjw2ZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICeOF2ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F770C4CEE3;
	Wed, 12 Mar 2025 05:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741758251;
	bh=xZJOc5XyyMym8hnBaWHbYKIhBmxjzcDArBveIIsMQaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ICeOF2epMNoffeQ3REYCIW93hpTuJ2Sj4xX0l2wWnvQWl6oEOKD8dyiYJgHNexqfH
	 kwmoltpD4B4hjxY4VJ8rtKV00O5gfg+O11VC02S9n6VqlSwJZ3ATubAwqzPl11nj53
	 HXIGdEQ8AjcSNSbu7dOugnu6tp8myqa/9ZexcN59FMbbG/moBfpsXLeVMQlLpSNVtC
	 wp7zwmWI5h2FPeJvfvHx4rY+0mqVSqtZvMIH2KsOPhk+q8XnBbNvvOsYwJEc0dH7r2
	 bCLp2GzVEZjOQaay5zOlb4RJbAmYrKmu1BTxRdHrOL/D8bi9ihKW3YgT1k1PKPKXuv
	 0eKWlA7+ygwOg==
Date: Tue, 11 Mar 2025 22:44:09 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: liwang@redhat.com, brauner@kernel.org, hare@suse.de,
	willy@infradead.org, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	ltp@lists.linux.it, lkp@intel.com, oliver.sang@intel.com,
	oe-lkp@lists.linux.dev, gost.dev@samsung.com, p.raghav@samsung.com,
	da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE limit
Message-ID: <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de>
 <Z9Edl05uSrNfgasu@bombadil.infradead.org>
 <20250312054053.GA12234@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312054053.GA12234@lst.de>

On Wed, Mar 12, 2025 at 06:40:53AM +0100, Christoph Hellwig wrote:
> On Tue, Mar 11, 2025 at 10:37:27PM -0700, Luis Chamberlain wrote:
> > > If you need extra per-driver validatation, do it in the driver.
> > 
> > Are you suggesting we just move back the PAGE_SIZE check,
> 
> PAGE_SIZE now is a consumer (i.e. file system) limitation.  Having
> a flag in the provider (driver) does not make sense.
> 
> > or to keep
> > the checks for the block driver limits into each driver?
> 
> Most drivers probably don't have a limit other than than that implicit
> by the field width used for reporting.  So in general the driver should
> not need any checks.  The only exceptions might be for virtual drivers
> where the value comes from userspace, but even then it is a bit doubtful.

Alrighty, so silly tests just need to be updated. If a hang is reported,
we can look into it, or just add block driver checks / limitations.

  Luis

