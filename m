Return-Path: <linux-fsdevel+bounces-49310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 699CCABA670
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 May 2025 01:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87CFC7B262A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 23:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BCE280032;
	Fri, 16 May 2025 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8OkA7p3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770ED15665C;
	Fri, 16 May 2025 23:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747437468; cv=none; b=fXUaqUiz5TNyYkWKgjYHYmNGypjgx5nwX4X1jPr8UWILFWujWia0hYPBt4AvUEmw6gwfizl4NZ/UmzgNP5ImXVaiKgBOd+5ZbMSOsOBJo/UQaAreTr6Q8QXRZGKUP2kHlHZTxIcrUaQ4fi3oYuX58mfrWsqNNrRMXIWpPUDyYE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747437468; c=relaxed/simple;
	bh=9QGCU7pQ1CQOC/QLX0rCKLUdZNG8/Rw7HmMWOTN97fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjol4Ly32mugiaSFgCL7ylVxN6I47wmCBKRR5axzWHN5VZGiIm4xI11aWaNqI9pT5Tb8N6RaqyVc6mw9EuBgWET95qajsa5jIw28UFernJKCaCR+QtLECi9Nc2+o+8ol7vVVDtsUr/07o7coFfiLnzSZhQrH551zKxCN2KfBWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8OkA7p3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9775C4CEE4;
	Fri, 16 May 2025 23:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747437467;
	bh=9QGCU7pQ1CQOC/QLX0rCKLUdZNG8/Rw7HmMWOTN97fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b8OkA7p3XHFQnWkhDZHSvdhBzeJvX2JWajy6uk7rAqdnI8TISnS1C0kUOVHwzAwf6
	 /t0JOfPD3nXLY06c8Eiq44LxQiwiS8nLRIBmDmEn2XNeMpw2Tfd1U9lQit+Wy1EL9r
	 6UzybNl8RZcQXn4fh/B8NO6U/Q0AunkgLh2q7wvF+/Z4GtY2gbJRFEaoNYVmNgPdc+
	 IWMHOkhcvx3en+Vtwn1/8l0JT6qDMsTRjnpbXnE14b2oyY/PDf/lHxf/J+OuygeWYd
	 xqIy8fwO+ID5o2/YuJt+HJBDdvWn5867w4MzKnuTskhWhVd2+wMXDALPxHKgZq8V7D
	 5PdG1wNlZxa4g==
Date: Fri, 16 May 2025 16:17:47 -0700
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
	Luis Henriques <luis@igalia.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jeff Layton <jlayton@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <20250516231747.GB9730@frogsfrogsfrogs>
References: <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
 <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
 <20250508155644.GM1035866@frogsfrogsfrogs>
 <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>
 <20250515020624.GP1035866@frogsfrogsfrogs>
 <CAJfpegsKf8Zog3Q6Vd1kBmD6anLSdyYyxy4BjD-dvcyWOyr4QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegsKf8Zog3Q6Vd1kBmD6anLSdyYyxy4BjD-dvcyWOyr4QQ@mail.gmail.com>

On Fri, May 16, 2025 at 12:06:44PM +0200, Miklos Szeredi wrote:
> On Thu, 15 May 2025 at 04:06, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > Yeah, it's confusing.  The design doc tries to clarify this, but this is
> > roughly what we need for fuse:
> >
> > FUSE_IOMAP_OP_WRITE being set means we're writing to the file.
> > FUSE_IOMAP_OP_ZERO being set means we're zeroing the file.
> > Neither of those being set means we're reading the file.
> >
> > (3 different operations)
> 
> Okay, I get why these need to be distinct cases.
> 
> Am I right that the only read is sanely cacheable?

That depends on the filesystem.  Old filesystems (e.g. the ones that
don't support out of place writes or unwritten extents) most likely can
cache mappings for writes and zeroing.  Filesystems with static mappings
(like zonefs which are convenient wrappers around hardware) can cache
most everything too.

My next step for this prototype is to go build a real cache and make
fuse2fs manage the cache, which puts the filesystem in charge of
maintaining the cache however is appropriate for the design.

> > FUSE_IOMAP_OP_DIRECT being set means directio, and it not being set
> > means pagecache.
> >
> > (and one flag, for 6 different types of IO)
> 
> Why does this make a difference?

Different allocation strategies -- we can use delayed allocation for
pagecache writes, whereas with direct writes we must have real disk
space.

> Okay, maybe I can imagine difference allocation strategies.  Which
> means that it only matters for the write case?

Probably.  I don't see why a directio read would be any different from a
pageacache read(ahead) but the distinction exists for the in-kernel
iomap callers.

> > FUSE_IOMAP_OP_REPORT is set all by itself for things like FIEMAP and
> > SEEK_DATA/HOLE.
> 
> Which should again always be the same as the read case, no?

Not entirely -- if the fuse driver is doing weird caching things with
file data blocks, a read requires it to invalidate its own cache,
whereas it needn't do anything for a mapping report.  fuse2fs is guilty
of this, because it does ... crazy things.

Also for now I don't support read/write to inline data files, though I
think it would be possible to use the FUSE_READ/FUSE_WRITE for that...
as soon as I find a filesystem where inline data for regular files isn't
a giant trash fire and can be QAd properly.

--D

