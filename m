Return-Path: <linux-fsdevel+bounces-58346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 398DAB2CF62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77D27AAB30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0BC221FDC;
	Tue, 19 Aug 2025 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmY26AHp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A91C84BC;
	Tue, 19 Aug 2025 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755642731; cv=none; b=lLWZG06Lt9Sv2Ry0yJfri0gyHwWvh0NkRqWZx7js+ceIbpqO5uh7EKSR0vBEf5M2RmykJtF0N/GqnaZ3muse31kUVvCmyCLNk0XnM3Jbo14Uv9X5b1QJH7qoOZCxUE/z9bQMOHhXqvbpILsIinHOiSGv7okT3NfNROueHQztlBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755642731; c=relaxed/simple;
	bh=mD//8dQjZOWAJVPd7Y7oWJF/jHOwj2BWK4aKM58JE9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p2Xq8oyRM8jaJjIUNtLnwS/4B0WM7EzmjhAhXgMC8mB+d3E85VnQF7Mb+kYa25aV6rPwcfXzuu7HKDRNJXiP/y4XmJJBu/HrL+Dtvgg6bOZdXzcAFfA+m2YeqNQxw/61q3Zsj6h2fjK+y20wg2nHDnPwiWsYAp47CabxmmXq3JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmY26AHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FCBC4CEF1;
	Tue, 19 Aug 2025 22:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755642730;
	bh=mD//8dQjZOWAJVPd7Y7oWJF/jHOwj2BWK4aKM58JE9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MmY26AHpeXN2C0P0Xni2rYaYuw4Yc1pHL7MjWwMvabwhX58XyMatN5pg8IKzJAitX
	 w+uiULHAlrw7rZPcewRPj3P5Np1UZNsXvjHGhi+3ESeNAwmhhiNB9qlnbzuO32P+3/
	 a3rLddMNjCPJqC+5xMGMeiZW78mUnpmcaIN2IOC2W74/fq5hNvzvKUSjphRxdzUfgK
	 QIU/NnVgoowsGnSdnQr1yp7uwlYL/y8qfWHWvoog96/q0kWpm6K+OX6yKX+12dKV+h
	 R/QsXUcytOVBA74Z9U3dYZkzZVJqrym1FsfEaszAw84zCoR6Ry/CFEeC8KTLQn/kA9
	 w0JicfTzp6x3Q==
Date: Tue, 19 Aug 2025 15:32:10 -0700
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
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <20250819223210.GG7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <20250814171941.GU7942@frogsfrogsfrogs>
 <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
 <vfg7t7dzqjf6g6374wavesakk332n4dqabgokw4xobsar5jnxm@m7xfan6vhyty>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vfg7t7dzqjf6g6374wavesakk332n4dqabgokw4xobsar5jnxm@m7xfan6vhyty>

On Sat, Aug 16, 2025 at 11:22:49AM -0500, John Groves wrote:
> On 25/08/14 08:25PM, Miklos Szeredi wrote:
> > On Thu, 14 Aug 2025 at 19:19, Darrick J. Wong <djwong@kernel.org> wrote:
> > > What happens if you want to have a fuse server that hosts both famfs
> > > files /and/ backing files?  That'd be pretty crazy to mix both paths in
> > > one filesystem, but it's in theory possible, particularly if the famfs
> > > server wanted to export a pseudofile where everyone could find that
> > > shadow file?
> > 
> > Either FUSE_DEV_IOC_BACKING_OPEN detects what kind of object it has
> > been handed, or we add a flag that explicitly says this is a dax dev
> > or a block dev or a regular file.  I'd prefer the latter.
> > 
> > Thanks,
> > Miklos
> 
> I have future ideas of famfs supporting non-dax-memory files in a mixed
> namespace with normal famfs dax files. This seems like the simplest way 
> to relax the "files are strictly pre-allocated" rule. But I think this 
> is orthogonal to how fmaps and backing devs are passed into the kernel. 
> 
> The way I'm thinking about it, the difference would be handled in
> read/write/mmap. Taking fuse_file_read_iter as the example, the code 
> currently looks like this:
> 
> 	if (FUSE_IS_VIRTIO_DAX(fi))
> 		return fuse_dax_read_iter(iocb, to);
> 	if (fuse_file_famfs(fi))
> 		return famfs_fuse_read_iter(iocb, to);
> 
> 	/* FOPEN_DIRECT_IO overrides FOPEN_PASSTHROUGH */
> 	if (ff->open_flags & FOPEN_DIRECT_IO)
> 		return fuse_direct_read_iter(iocb, to);
> 	else if (fuse_file_passthrough(ff))
> 		return fuse_passthrough_read_iter(iocb, to);
> 	else
> 		return fuse_cache_read_iter(iocb, to);
> 
> If the famfs fuse servert wants a particular file handled via another 
> mechanism -- e.g. READ message to server or passthrough -- the famfs 
> fuse server can just provide an fmap that indicates such.  Then 
> fuse_file_famfs(fi) would return false for that file, and it would be 
> handled through other existing mechanisms (which the famfs fuse 
> server would have to handle correctly).
> 
> Famfs could, for example, allow files to be created as generic or
> passthrough, and then have a "commit" step that allocated dax memory, 
> moved the data from a non-dax into dax, and appended the file to the 
> famfs metadata log - flipping the file to full-monty-famfs (tm). 
> Prior to the "commit", performance is less but all manner of mutations 
> could be allowed.
> 
> So I don't think this looks very be hard, and it's independent of the 
> mechanism by which fmaps get into the kernel.

This is one thing I wasn't planning -- iomap files are always that, and
there's no fallback to any of the other IO strategies.  The pagecache
handling parts of iomap require things such as i_rwsem controlling
access to a file no matter how many places it's hardlinked, and
timestamp/mode/acl handling working more or less the same way they do in
xfs and ext4.  iomap isn't all that congruent with the way that the
other IO paths (passthrough, writeback_cache, and "directio" files)
work.

Though to undercut my own point partially, sending an "inline data"
mapping to the kernel causes it to call FUSE_READ/FUSE_WRITE and then
you can inject whatever IO path you want.  OTOH the iomap inlinedata
paths are ... not well tested for pos > 0.

--D

> Regards,
> John
> 
> 
> 

