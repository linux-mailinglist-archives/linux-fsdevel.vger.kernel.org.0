Return-Path: <linux-fsdevel+bounces-57944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940BAB26EBD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B759A277FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B398224AEF;
	Thu, 14 Aug 2025 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBXbrvd8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A095A31984D;
	Thu, 14 Aug 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755195623; cv=none; b=jnVhIyg+qE9Tl7wuPfYsbgA5uZFXOzpVwtg3VswKSc/B5+yTfNNnXiIY03LX+u7QciDOr5NlcSRBlrbMzmwN2hdlJc7D0zym6Fo9Z6qYSSCbB5XwYDlEcDi8w/+JvWcbqhXEgMw2dG9Yxqo/AQT7uqKvjfYPZQ6LD5TGK8MrSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755195623; c=relaxed/simple;
	bh=raA5mgHX49Og9zxCoT0axbjpHFKlU/Lyr1Jq4CFdBGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU3CXeXPtosQ5Q8nJkYDBJnB+TiC+83NfUJF0HEq1LOKM3t0GC1++I061FzeIAMxb7+E6Rd/5zppPwtsKmSLEFX6iK04Zzv1cj9N7rwwr4s/61+oEKZP51zHBY3rYgrJUIxYibLy4g3JXwJ1hSS+xD58lzj4WNUvNdiiaOpAvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBXbrvd8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED18DC4CEED;
	Thu, 14 Aug 2025 18:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755195623;
	bh=raA5mgHX49Og9zxCoT0axbjpHFKlU/Lyr1Jq4CFdBGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SBXbrvd8D42BZledxMiDxd6Xp0bn/A5ZXqJmvpasnGfELCZc47s41BywHN51KHpu2
	 CUcaMpHzAybOWQRDDtAVytvNEF1eQjHZ2sfAVT3GDcawBAGP5VJZ8FKQZ2AHXOapx/
	 kYzUIN76/a1Hcua3mPIpleRM23XdtIRxpEEBWTQSFgN7Tkobj/kTCBJ61ch6D8aF3W
	 k4JaX4KaIDmY99E0BNDe6kdVP5qHH3kVdyC/BUPPe/Cw6F67SScEjOOOCRedzLEqgv
	 fxdpO0MDGDIJDGBkuz8LwYVZvV9PHT0pd5Mtga1HzPjMqPAGxDp1f4MplMpgsdDUuu
	 i7+wP8aMg7tew==
Date: Thu, 14 Aug 2025 11:20:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Bernd Schubert <bschubert@ddn.com>,
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <20250814182022.GW7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>

On Thu, Aug 14, 2025 at 04:36:57PM +0200, Miklos Szeredi wrote:
> On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > I'm still hoping some common ground would benefit both interfaces.
> > Just not sure what it should be.
> 
> Something very high level:
> 
>  - allow several map formats: say a plain one with a list of extents
> and a famfs one

Yes, I think that's needed.

>  - allow several types of backing files: say regular and dax dev

"block device", for iomap.

>  - querying maps has a common protocol, format of maps is opaque to this
>  - maps are cached by a common facility

I've written such a cache already. :)

>  - each type of mapping has a decoder module

I don't know that you need much "decoding" -- for famfs, the regular
mappings correspond to FUSE_IOMAP_TYPE_MAPPED.  The one goofy part is
the device cookie in each IO mapping: fuse-iomap maps each block device
you give it to a device cookie, so I guess famfs will have to do the
same.

OTOH you can then have a famfs backed by many persistent memory
devices.

>  - each type of backing file has a module for handling I/O
> 
> Does this make sense?

More or less.

> This doesn't have to be implemented in one go, but for example
> GET_FMAP could be renamed to GET_READ_MAP with an added offset and
> size parameter.  For famfs the offset/size would be set to zero/inf.
> I'd be content with that for now.

I'll try to cough up a RFC v4 next week.

--D

> Thanks,
> Miklos
> 
> >
> > Thanks,
> > Miklos
> 

