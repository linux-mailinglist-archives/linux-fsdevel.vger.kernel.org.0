Return-Path: <linux-fsdevel+bounces-57943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B72B26E9D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 20:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66289B802FE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Aug 2025 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E585319864;
	Thu, 14 Aug 2025 18:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEj06vMH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE848319841;
	Thu, 14 Aug 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755194713; cv=none; b=OVDTI5G2F+f1f+WH+46EtGDa+w18BkeGuGfFLCqBa107AKp79zgKKhJbOWnv605CvGnRS/VFUb3vprtirw2sPmypWVFj7qGKW0qrTC/lBMcMfkStLtE4F+u60ZhpDhYEE5doOkITbs1qGr5QFa/sWn5xF/K9CwbidKHRi+3mjow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755194713; c=relaxed/simple;
	bh=XcO2ZEADFwBfK6kPEWOR8tIjaxQkyjMynvJHLUKTg8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RvmBF6D2e+X0z0EOR3ei7qhTc5w6H5ThbLQtClsKx+mSY2UlNrzHDFgxwX9zIfU454av7BwQyMiqACWOXHuk4EXiXmkAhqSgCprThitgMO4SC4wdtClJrEpADaQoGYTyQ5ivjGWV2h++hnFFlsfcgq64eiWUqgEzt6idriDtT8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEj06vMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99FE2C4CEED;
	Thu, 14 Aug 2025 18:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755194712;
	bh=XcO2ZEADFwBfK6kPEWOR8tIjaxQkyjMynvJHLUKTg8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eEj06vMH1nQfwpU1V+P3jkjBWcHIiYZphKlnN4NnBf4JofA/Nawf0Aqgfa4Am8Hid
	 18h9T03E7YRMCgnw/qmFEQwgTMfbhZNaAcj0FXUY0MEukRXd625/4eJi9lqTtJ5P6U
	 z/xmMPYyBgsX4eplbTmM+AgroA2Ae+cc+H9jZqAjk9nxVT9KXFC9Afzi1zAweqdXoA
	 Y3B30bhyGWGpWr2Mafxe/kBnGDALPvD5P1lOwnGaPczf6aoT2xGYpGrpGU2oSw8OZB
	 KJVtTpdX8M9d3DpBWgn/qV5fHoH9CtV847eb/oXTNSLYE8idadchk1zHfMrfig/fTJ
	 Z/CtkKdFgtGMA==
Date: Thu, 14 Aug 2025 11:05:12 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Miklos Szeredi <miklos@szeredb.hu>,
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
Message-ID: <20250814180512.GV7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>

On Thu, Aug 14, 2025 at 03:36:26PM +0200, Miklos Szeredi wrote:
> On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
> >
> > Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> > retrieve and cache up the file-to-dax map in the kernel. If this
> > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> 
> Nothing to do at this time unless you want a side project:  doing this
> with compound requests would save a roundtrip (OPEN + GET_FMAP in one
> go).
> 
> > GET_FMAP has a variable-size response payload, and the allocated size
> > is sent in the in_args[0].size field. If the fmap would overflow the
> > message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> > specifies the size of the fmap message. Then the kernel can realloc a
> > large enough buffer and try again.
> 
> There is a better way to do this: the allocation can happen when we
> get the response.  Just need to add infrastructure to dev.c.
> 
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 6c384640c79b..dff5aa62543e 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -654,6 +654,10 @@ enum fuse_opcode {
> >         FUSE_TMPFILE            = 51,
> >         FUSE_STATX              = 52,
> >
> > +       /* Famfs / devdax opcodes */
> > +       FUSE_GET_FMAP           = 53,
> > +       FUSE_GET_DAXDEV         = 54,
> 
> Introduced too early.
> 
> > +
> >         /* CUSE specific operations */
> >         CUSE_INIT               = 4096,
> >
> > @@ -888,6 +892,16 @@ struct fuse_access_in {
> >         uint32_t        padding;
> >  };
> >
> > +struct fuse_get_fmap_in {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> 
> As noted, passing size to server really makes no sense.  I'd just omit
> fuse_get_fmap_in completely.
> 
> > +
> > +struct fuse_get_fmap_out {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> > +
> >  struct fuse_init_in {
> >         uint32_t        major;
> >         uint32_t        minor;
> > @@ -1284,4 +1298,8 @@ struct fuse_uring_cmd_req {
> >         uint8_t padding[6];
> >  };
> >
> > +/* Famfs fmap message components */
> > +
> > +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> > +
> 
> Hmm, Darrick's interface gets one extents at a time.   This one tries
> to get the whole map in one go.
> 
> The single extent thing can be inefficient even for plain block fs, so
> it would be nice to get multiple extents.  The whole map has an

The fuse/iomap series adds a mapping upsertion "notification" that the
fuse server can use to prepopulate mappings in the kernel so that it
doesn't have to call back to the server for reads and pure overwrites.
Maybe it would be useful to be able to upsert mappings for more than a
single file range, but so far it hasn't been necessary.

> artificial limit that currently may seem sufficient but down the line
> could cause pain.
> 
> I'm still hoping some common ground would benefit both interfaces.
> Just not sure what it should be.

It's possible that famfs could use the mapping upsertion notification to
upload mappings into the kernel.  As far as I can tell, fuse servers can
send notifications even when they're in the middle of handling a fuse
request, so the famfs daemon's ->open function could upload mappings
before completing the open operation.

As for the other use of FMAP (uploading a description of striping data
from which one can construct mappings) ... I don't know what to say
about that.  That one isn't so useful for block filesystems. :)

(onto the next reply)

--D

