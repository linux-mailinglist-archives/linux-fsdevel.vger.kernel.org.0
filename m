Return-Path: <linux-fsdevel+bounces-57952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9ADB26F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF785866F7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C023A9A0;
	Thu, 14 Aug 2025 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COawjIO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC5226D1B;
	Thu, 14 Aug 2025 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755197704; cv=none; b=a0V2vKjrMC631zuKv17OOV5H9tcUnb4/syyc2LECAqfyw+LUHJIyHrMSoFZxuSQcnsQaeD1eQ0uuVNLhFq9g0CPzk/SKPzKet/bxAYhDKmuGHzBzzydnRwY+6He9pjWiOompWhAdGHDHDv85No2IJA6RlKLTXglNS25eynUg060=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755197704; c=relaxed/simple;
	bh=ML7gyTBlqoZ6qkWwloT4fS3WKxzyV5cnqoglB1EVKqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llXvI4fw+ttJ63v+OZtX76vbkrRRm48PlWZDI4CUuoT3b+VFvy/E/HpQjWqgDyH1YTznWWSZhhwNqaxMjWjSl1uz1vqWoVt0X4zTQRsPWeQO4jVKwKowAqwclJqzfrHEbWRcSghP0kYyu/tneZiiVys3Tx4GbmlOHCaqiCUmZSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COawjIO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C301C4CEED;
	Thu, 14 Aug 2025 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755197704;
	bh=ML7gyTBlqoZ6qkWwloT4fS3WKxzyV5cnqoglB1EVKqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COawjIO7o9J1NgHW6Bqw1RtWpjsq0+CgYw1jcEdB0aox3uY4sU20b3lPE+AOzi1Gc
	 Km/nscXlgMIyL1EzF6JTjN7NHDgFZ8Mmgr3p84Ct5MZNP0CRg7vFii5fvxCsj6H10V
	 7zy5v6hgiPR71PzRe0PnuK1lPZIFgvKxdtyIIQ689yh9V4VZvIZk/FKWLyLys8I/1+
	 RhcVamkjhQmI9TJUc6I8+UTujH+7t00UUauzvhIgwrJl77XFO+eZP3h+aeX3b+qcc3
	 bp0VT5xXLcVCckzka3vsqq3at4gW4iYjUZxq/Lu7b76ms8NcbbFN+pzIgNdcSKsohN
	 f/q2aExfeZ8Kg==
Date: Thu, 14 Aug 2025 11:55:03 -0700
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
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <20250814185503.GZ7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <CAJfpegv19wFrT0QFkwFrKbc6KXmktt0Ba2Lq9fZoihA=eb8muA@mail.gmail.com>
 <20250814171941.GU7942@frogsfrogsfrogs>
 <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv8Ta+w4CTb7gvYUTx3kka1-pxcWX_ik=17wteU9XBT1g@mail.gmail.com>

On Thu, Aug 14, 2025 at 08:25:23PM +0200, Miklos Szeredi wrote:
> On Thu, 14 Aug 2025 at 19:19, Darrick J. Wong <djwong@kernel.org> wrote:
> > What happens if you want to have a fuse server that hosts both famfs
> > files /and/ backing files?  That'd be pretty crazy to mix both paths in
> > one filesystem, but it's in theory possible, particularly if the famfs
> > server wanted to export a pseudofile where everyone could find that
> > shadow file?
> 
> Either FUSE_DEV_IOC_BACKING_OPEN detects what kind of object it has
> been handed, or we add a flag that explicitly says this is a dax dev
> or a block dev or a regular file.  I'd prefer the latter.

I don't think it's difficult to do something like:

	if (!fud)
		return -EPERM;

	if (copy_from_user(&map, argp, sizeof(map)))
		return -EFAULT;

	if (IS_ENABLED(CONFIG_FUSE_IOMAP)) {
		ret = fuse_iomap_dev_add(fud->fc, &map);
		if (ret)
			return ret;
	}

	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
		return fuse_backing_open(fud->fc, &map);

	return 0;

I guess the hard part is -- how do we return /two/ device cookies?
Or do we move the backing_files_map out of CONFIG_FUSE_PASSTHROUGH and
then let fuse-iomap/famfs extract the block/dax device from that?
Then the backing_id/device cookie would be the same across a fuse mount.
iomap would have to check that it's being given block devices, but
that's easy.

--D

> Thanks,
> Miklos
> 

