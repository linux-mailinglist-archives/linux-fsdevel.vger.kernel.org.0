Return-Path: <linux-fsdevel+bounces-58342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFEB2CEF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA6F7562AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063B63054DD;
	Tue, 19 Aug 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cD6x203S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2B4220687;
	Tue, 19 Aug 2025 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640511; cv=none; b=nuUPbwPG1eeo+PyWqPmQ0oyiERAUco7H3KmlXnZ7J2BC2QRydqSG3gDAl9MZ718JA98501+VJVEFIv6qllsVydAfKqF6P8dK7+2yBMOaroFGBMOWrq6sFdOA0uB5ITBvdfOCIT0rwPm4fdA6V6qP+dJ/L59cr7UQr0W0n35GAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640511; c=relaxed/simple;
	bh=gRjtTaJQgCQg4iLt7DACCXcUdygAh1cA8bBXzSnuB/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DvBXMN++luTLBJa4jIoNiL3ajKUGO3PTKkhBtHcN9nZVX87qMVH3xML4OGNOYaTSygAbgkV+skWSNoZbcRaNGVnLa9OkhV8txU0jCHXWvNtbOTkA9V1Ft8vEptw/jHBsxfowWXBHDZcuNZPB/p7jFoLqMtFFBp95qG71WpyExMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cD6x203S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DAAC113CF;
	Tue, 19 Aug 2025 21:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755640510;
	bh=gRjtTaJQgCQg4iLt7DACCXcUdygAh1cA8bBXzSnuB/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cD6x203SdI5KeE17Bz9o6vUDD4o/uLGZMbnQG7CTynA32xxJn5G7sWzHCaC/ufxDD
	 ijaAWbK/met3XTbK0z90vbG3Jk1t1w89yzUHsouH6VRThw35iW9wQngIQx+PqoJjsN
	 06gSlYHGygWoA1pKJZRCDidRcSxJ8z3BHnv+hpbSZrjzWa66rsPejsJMbDCrzh4b/0
	 nDE+C5XqI5NmuXxKRjvcxaIj5nvIQo3SztfR3mmgVSy13BxQ3numI4KDhoC/1DuqIF
	 5CkYwpLA6dDMsxrLXqSW0HCcS5IJ9YlSKgcMnWl4WTC8qwo522/wluiuV6ywXHIOXO
	 1xDourXu0rrQQ==
Date: Tue, 19 Aug 2025 14:55:10 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
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
Message-ID: <20250819215510.GD7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
 <20250814182022.GW7942@frogsfrogsfrogs>
 <hd3tancdc6pgjka44nwhk6laawnasob44jqagwxawrmxtevihe@2orrcse6xyjx>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hd3tancdc6pgjka44nwhk6laawnasob44jqagwxawrmxtevihe@2orrcse6xyjx>

On Fri, Aug 15, 2025 at 10:06:01AM -0500, John Groves wrote:
> On 25/08/14 11:20AM, Darrick J. Wong wrote:
> > On Thu, Aug 14, 2025 at 04:36:57PM +0200, Miklos Szeredi wrote:
> > > On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > 
> > > > I'm still hoping some common ground would benefit both interfaces.
> > > > Just not sure what it should be.
> > > 
> > > Something very high level:
> > > 
> > >  - allow several map formats: say a plain one with a list of extents
> > > and a famfs one
> > 
> > Yes, I think that's needed.
> 
> Agreed
> 
> > 
> > >  - allow several types of backing files: say regular and dax dev
> > 
> > "block device", for iomap.
> > 
> > >  - querying maps has a common protocol, format of maps is opaque to this
> > >  - maps are cached by a common facility
> > 
> > I've written such a cache already. :)
> 
> I guess I need to take a look at that. Can you point me to the right place?
> 
> > 
> > >  - each type of mapping has a decoder module
> > 
> > I don't know that you need much "decoding" -- for famfs, the regular
> > mappings correspond to FUSE_IOMAP_TYPE_MAPPED.  The one goofy part is
> > the device cookie in each IO mapping: fuse-iomap maps each block device
> > you give it to a device cookie, so I guess famfs will have to do the
> > same.
> > 
> > OTOH you can then have a famfs backed by many persistent memory
> > devices.
> 
> That's handled in the famfs fmaps already. When an fmap is ingested,
> if it references any previously-unknown daxdevs, they get retrieved
> (FUSE_GET_DAXDEV).
> 
> Oversimplifying a bit, I assume that famfs fmaps won't really change,
> they'll just be retrieved by a more flexible method and be preceded
> by a header that identifies the payload as a famfs fmap.

<nod> Well, I suppose fmaps aren't supposed to change much, but I get
the strong sense that Miklos would rather we both use the
FUSE_DEV_IOC_BACKING_OPEN interface...

> > 
> > >  - each type of backing file has a module for handling I/O
> > > 
> > > Does this make sense?
> > 
> > More or less.
> 
> I'm nervous about going for too much generalization too soon here,
> but otherwise yeah.

...and I've tried to make it simple for famfs to pick up the interface.
From the new fuse_backing_open:

	/*
	 * Each _backing_open function should either:
	 *
	 * 1. Take a ref to fb if it wants the file and return 0.
	 * 2. Return 0 without taking a ref if the backing file isn't needed.
	 * 3. Return an errno explaining why it couldn't attach.
	 *
	 * If at least one subsystem bumps the reference count to open it,
	 * we'll install it into the index and return the index.  If nobody
	 * opens the file, the error code will be passed up.  EPERM is the
	 * default.
	 */
	passthrough_res = fuse_passthrough_backing_open(fc, fb);
	iomap_res = fuse_iomap_backing_open(fc, fb);

	if (refcount_read(&fb->count) < 2)
		/* drop the fuse_backing and return one of the res */

So all your famfs_backing_open function has to do is check that fb->file
points to a pmem device.  If so, it sets fb->famfs = 1 and bumps the
fb->count refcount.

Full code here:
https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-attrs_2025-08-19

I'll let the build robots find any facepalm problems and post this whole
series tomorrow.

> > > This doesn't have to be implemented in one go, but for example
> > > GET_FMAP could be renamed to GET_READ_MAP with an added offset and
> > > size parameter.  For famfs the offset/size would be set to zero/inf.
> > > I'd be content with that for now.
> > 
> > I'll try to cough up a RFC v4 next week.
> 
> Darrick, let's try to chat next week to compare notes.
> 
> Based on this thinking, I will keep my rework of GET_FMAP to a minimum
> since that will likely be a new shared message/response. I think that
> part can be merged later in the cycle...

<nod>

--D

