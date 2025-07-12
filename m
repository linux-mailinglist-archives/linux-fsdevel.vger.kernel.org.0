Return-Path: <linux-fsdevel+bounces-54749-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AEEB02981
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 07:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3785868D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 05:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFD210F53;
	Sat, 12 Jul 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/ctmFCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923604C7F;
	Sat, 12 Jul 2025 05:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752299646; cv=none; b=F4NCAB5Da3Jdiqp480oNeGBwL+Byn/uhIDytILhkraMn0D12p5ScKwgXgV+lil/XV5GOSccEUDbgLH13ANL8fELksSxHSQ4XvWORZTUUW9CCcTySJcbR9CjrhqcP44AjNdEXT8aMMgT0ToO1wamrCk+amOigWZDyOnveA4j+cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752299646; c=relaxed/simple;
	bh=rFWl3Q13e5QPMxcRC35Ux1buXtJYF88GSwwmW4kTpLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXMm40vW3K+A3R6/K16aq8Sh3uD1Qf0kcavKPeuV+Grpdd59ZGEUQz3KstP4S1Hq1uF4sYYkwXw8fb2iH+uY8gp0x6PkIdx4TuyAaajCoXbUBx6bLyydotXwfPX9+LIxbnYD4chJO7zCccte1OgEn1B8IKEbuM4NMoN7VJJ/yVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/ctmFCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B65C4CEEF;
	Sat, 12 Jul 2025 05:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752299646;
	bh=rFWl3Q13e5QPMxcRC35Ux1buXtJYF88GSwwmW4kTpLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/ctmFCpHYpKeqGDCdCFR36u2S2ySZVT6jp5O5E7FlOasj+1TMXaYp4DFVJZtTncZ
	 6JWUH0rN1ghDoNaTE4u2fZ5ZGcvPmVWHz0l6GaICRTGvoixkZ1VYpZbt4g8AyIyd+N
	 UjfUZbLXKiuKVnnOJNLPUV+kD9ptmHy7yc1qZfIk4zdU6D9uX9xu4Iji46TiZkXUZN
	 VqtbGkKLgKIfTLZUZGZd7d5mPawtDpQcos+QV+GyqK2zDM4J9MTZQOklAGsfMWzWME
	 8zLVNcQhoyhmiKQJIdwJMCC1usVoMPekZxLT4sd6xIrreIOsF5QW57b93eth1Ctsvj
	 eBeiv4uBKaMuQ==
Date: Fri, 11 Jul 2025 22:54:05 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
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
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
Message-ID: <20250712055405.GK2672029@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs>
 <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>

On Fri, Jul 11, 2025 at 10:28:20AM -0500, John Groves wrote:
> On 25/07/08 08:59PM, Darrick J. Wong wrote:
> > On Thu, Jul 03, 2025 at 01:50:25PM -0500, John Groves wrote:
> > > * -o shadow=<shadowpath>
> > 
> > What is a shadow?
> > 
> > > * -o daxdev=<daxdev>
> 
> Derp - OK, that's a stale commit message. Here is the one for the -next
> version of this patch:
> 
>     famfs_fuse: Basic famfs mount opt: -o shadow=<shadowpath>
> 
>     The shadow path is a (usually tmpfs) file system area used by the famfs 
>     user space to commuicate with the famfs fuse server. There is a minor 
>     dilemma that the user space tools must be able to resolve from a mount 
>     point path to a shadow path. The shadow path is exposed via /proc/mounts, 
>     but otherwise not used by the kernel. User space gets the shadow path 
>     from /proc/mounts...

Ah.  A service directory, of sorts.

> > And, uh, if there's a FUSE_GET_DAXDEV command, then what does this mount
> > option do?  Pre-populate the first element of that set?
> > 
> > --D
> > 
> 
> I took out -o daxdev, but had failed to update the commit msg.
> 
> The logic is this: The general model requires the FUSE_GET_DAXDEV message /
> response, so passing in the primary daxdev as a -o arg creates two ways to
> do the same thing.
> 
> The only initial heartburn about this was one could imagine a case where a
> mount happens, but no I/O happens for a while so the mount could "succeed",
> only to fail later if the primary daxdev could not be accessed.
> 
> But this can't happen with famfs, because the mount procedure includes 
> creating "meta files" - .meta/.superblock and .meta/.log and accessing them
> immediately. So it is guaranteed that FUSE_GET_DAXDEV will be sent right away,
> and if it fails, the mount will be unwound.

<nod> 

--D

> Thanks Darrick!
> John
> 
> <snip>
> 
> 

