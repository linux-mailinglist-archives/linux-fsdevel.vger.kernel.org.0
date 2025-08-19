Return-Path: <linux-fsdevel+bounces-58344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD8B2CF21
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 00:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83AE1583ECE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Aug 2025 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CA13C8EA;
	Tue, 19 Aug 2025 22:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWrjHVR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8CD353347;
	Tue, 19 Aug 2025 22:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755641594; cv=none; b=AytEtATVsadnXc0h6rW89Rl+3genBDpCh7zVBR15IxOjvDuVf2yo8Idm84uDHf9OsCvQrN8sPoFfAyT9ENg/2DBg+ObaIGQnw0JbEFiU/HrylSS2F3F0gs8HY12rXA9CKPkTpK719QRWnmWNhEJAc0ls52DOEl6/EgElDKshx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755641594; c=relaxed/simple;
	bh=VFxI+i2VfitSPQQL35e2MeXqm+Bb2LPPHqOW1EzsTEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdpoKa+T5AavgJF7+JfVWdSrAwYoJRvT9XcMTPsy//l7bXQjeC0X5aFqVhxd8h7sk8GQOi+PgkNcmXh3shYNY3TEhkzpE1ughDatyiT3a096mrHLRik3CFFZQIS4Eqt5s1kU1Icn61qcMLd/hLeOivl83g9dIuVIWWb/7tPG7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWrjHVR5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC9C4CEF1;
	Tue, 19 Aug 2025 22:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755641593;
	bh=VFxI+i2VfitSPQQL35e2MeXqm+Bb2LPPHqOW1EzsTEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWrjHVR5FKke1AOPUpRO50Sds8CKE+RXHD3Tl983RaePzpcAioGZqjRT+OsMIPm1C
	 cpqc+hVsPs0P9g8EgfmwJUIFKCCnn+MhE1KvodHFOaaPiIZTa46krZjOt6PbctxDUN
	 HWh15yNjwtEw/xah5jPfcX9UObgjheGSojIlr7wpNLZMgvm2aFTYKDtkS0njxT8Zqz
	 A04inUILslYdQl1UIPMtSWsRhtFGsHtOcrjGM55nfuUoBw31cG+kbZP7VzK1raAz85
	 mNOwhsM62U308brrG8ncHSMj7YGZEl+N7p4voWc9yK1p9PnAT/AoFfdC4/OYHvE53v
	 n01MKX6sn6uQQ==
Date: Tue, 19 Aug 2025 15:13:12 -0700
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
Message-ID: <20250819221312.GE7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
 <CAJfpegv=ACZchaG-xt0k481W1ZUKb3hWmLi-Js-aKg92d=yObw@mail.gmail.com>
 <mwnzafopjjpcgf3mznua3nphgmhdpiaato5pvojz7uz3bdw57n@zl7x2uz2hkfj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mwnzafopjjpcgf3mznua3nphgmhdpiaato5pvojz7uz3bdw57n@zl7x2uz2hkfj>

On Fri, Aug 15, 2025 at 11:53:16AM -0500, John Groves wrote:
> On 25/08/14 04:36PM, Miklos Szeredi wrote:
> > On Thu, 14 Aug 2025 at 15:36, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > 
> > > I'm still hoping some common ground would benefit both interfaces.
> > > Just not sure what it should be.
> > 
> > Something very high level:
> > 
> >  - allow several map formats: say a plain one with a list of extents
> > and a famfs one
> >  - allow several types of backing files: say regular and dax dev
> >  - querying maps has a common protocol, format of maps is opaque to this
> >  - maps are cached by a common facility
> >  - each type of mapping has a decoder module
> >  - each type of backing file has a module for handling I/O
> > 
> > Does this make sense?
> > 
> > This doesn't have to be implemented in one go, but for example
> > GET_FMAP could be renamed to GET_READ_MAP with an added offset and
> > size parameter.  For famfs the offset/size would be set to zero/inf.
> > I'd be content with that for now.
> 
> Maybe GET_FILE_MAP or GET_FILE_IOMAP if we want to keep overloading 
> the term iomap. Maps are to backing-dev for regular file systems,
> and to device memory (devdax) for famfs - in all cases both read
> and write (when write is allowed).

The calling model for fuse-iomap is the same as fs/iomap -- there's an
IOMAP_BEGIN upcall to get a mapping from the filesystem, and an
IOMAP_END upcall to tell the fuse server whatever it did with the
mapping.  Some filesystems will reserve delayed allocation reservations
in iomap_begin for a pagecache write, and need to cancel those
reservations if the write fails.

For a pagecache write you need both a read and a write mapping because
the caller's file range isn't guaranteed to be fsblock-aligned.  famfs
mappings are a subcase of iomappings -- the read & write mappings are
the same, and they're always FUSE_IOMAP_TYPE_MAPPED.

IOWs, I don't want "GET_FILE_IOMAP" because that's not how iomap works.
(There's a separate FUSE_IOMAP_IOEND to pass along IO completions from
storage)

Given that famfs just calls dax_iomap_rw with an iomap_ops struct, I
seriously wonder if I should just wire up fsdax for RFC v5 and then
let's see how much code famfs actually needs on top of that.

--D

> Thanks,
> John
> 
> 

