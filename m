Return-Path: <linux-fsdevel+bounces-54154-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FE7AFBA03
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B58A16B63D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3129ACE6;
	Mon,  7 Jul 2025 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPttIjEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35E1C7009;
	Mon,  7 Jul 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751909984; cv=none; b=ClkME5EBTtYCS9tK+svig97wczKIwUiLmbhxLm8WQuH5AFEqG+ptRB3GkXH96XczZia6MQuZkTz4cb7U2FPeQynuv3KMiKZTiFRJYKKJeSlb2L9v58KI6kZefy0P8aexV+MNkI2jtaBF4mNGB6MVyg+0OuPupBUJ+n7ReC4+UUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751909984; c=relaxed/simple;
	bh=l+3iXjYGj1UpOXLJrT43d9M5v15VGrgjIsaEmWHnlnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5H6LxHl4/MYBcqt9UVEoZmhLarUnikTdQ2Qh3pzOTswRa2Cof21lWiopDcoZHs55lcShXdeUS/1IByWVom3Nr96zVCITfuMm7P9evLBNDFAmhpGtbfNCEjaV6Au7PzYphpkEcbdABmXw2M3VSPpgM3y9UBF32enkkaY9Wsf5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPttIjEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A93C4CEE3;
	Mon,  7 Jul 2025 17:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751909982;
	bh=l+3iXjYGj1UpOXLJrT43d9M5v15VGrgjIsaEmWHnlnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HPttIjEnmPAnCKgpeOWt4ktMrN65mudK91LH4ggTI9W1jtedjRId7w5nmq4vHdyTr
	 CEtduZ+pljjwRe6H66Gc5GHT0y7i3zGZ3uCldWnx+wC8sR4+JIDYYbZTNsNWZLXdE2
	 15lWasxQTL4GDer73CwNfUPutq3FS6KcjyVZ3Vkrh7/k93R1GDL3AylQulro2TKFmx
	 kfqsX7Rv2PKmDBdtKF8VGsMAtwhy4xv0dB8erpvX3T4ySF4vY+x9/FfhITDmyiWPEq
	 9fci7JmKqnt7VFb7xgCcljSQXm6wgbFwfa4hm8sWSmN4yEMXyX7j2Z9pFuiRA5mJ8W
	 MRfIeNrPqkppw==
Date: Mon, 7 Jul 2025 10:39:42 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: John Groves <John@groves.net>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
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
	linux-fsdevel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Stefan Hajnoczi <shajnocz@redhat.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Aravind Ramesh <arramesh@micron.com>,
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
Message-ID: <20250707173942.GC2672029@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
 <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>

On Fri, Jul 04, 2025 at 08:39:59AM -0500, John Groves wrote:
> On 25/07/04 09:54AM, Amir Goldstein wrote:
> > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > >
> > > * FUSE_DAX_FMAP flag in INIT request/reply
> > >
> > > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> > >   famfs-enabled connection
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  fs/fuse/fuse_i.h          |  3 +++
> > >  fs/fuse/inode.c           | 14 ++++++++++++++
> > >  include/uapi/linux/fuse.h |  4 ++++
> > >  3 files changed, 21 insertions(+)
> > >
> > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > index 9d87ac48d724..a592c1002861 100644
> > > --- a/fs/fuse/fuse_i.h
> > > +++ b/fs/fuse/fuse_i.h
> > > @@ -873,6 +873,9 @@ struct fuse_conn {
> > >         /* Use io_uring for communication */
> > >         unsigned int io_uring;
> > >
> > > +       /* dev_dax_iomap support for famfs */
> > > +       unsigned int famfs_iomap:1;
> > > +
> > 
> > pls move up to the bit fields members.
> 
> Oops, done, thanks.
> 
> > 
> > >         /** Maximum stack depth for passthrough backing files */
> > >         int max_stack_depth;
> > >
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 29147657a99f..e48e11c3f9f3 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > >                         }
> > >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> > >                                 fc->io_uring = 1;
> > > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > > +                           flags & FUSE_DAX_FMAP) {
> > > +                               /* XXX: Should also check that fuse server
> > > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > > +                                * since it is directing the kernel to access
> > > +                                * dax memory directly - but this function
> > > +                                * appears not to be called in fuse server
> > > +                                * process context (b/c even if it drops
> > > +                                * those capabilities, they are held here).
> > > +                                */
> > > +                               fc->famfs_iomap = 1;
> > > +                       }
> > 
> > 1. As long as the mapping requests are checking capabilities we should be ok
> >     Right?
> 
> It depends on the definition of "are", or maybe of "mapping requests" ;)
> 
> Forgive me if this *is* obvious, but the fuse server capabilities are what
> I think need to be checked here - not the app that it accessing a file.
> 
> An app accessing a regular file doesn't need permission to do raw access to
> the underlying block dev, but the fuse server does - becuase it is directing
> the kernel to access that for apps.
> 
> > 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
> 
> I *think* that's checking the capabilities of the app that is accessing the
> file, and not the fuse server. But I might be wrong - I have not pulled very
> hard on that thread yet.

The init reply should be processed in the context of the fuse server.
At that point the kernel hasn't exposed the fs to user programs, so
(AFAICT) there won't be any other programs accessing that fuse mount.

> > 3. Darrick mentioned the need for a synchronic INIT variant for his work on
> >     blockdev iomap support [1]
> 
> I'm not sure that's the same thing (Darrick?), but I do think Darrick's
> use case probably needs to check capabilities for a server that is sending
> apps (via files) off to access extents of block devices.

I don't know either, Miklos hasn't responded to my questions.  I think
the motivation for a synchronous 

As for fuse/iomap, I just only need to ask the kernel if iomap support
is available before calling ext2fs_open2() because the iomap question
has some implications for how we open the ext4 filesystem.

> > I also wonder how much of your patches and Darrick's patches end up
> > being an overlap?
> 
> Darrick and I spent some time hashing through this, and came to the conclusion
> that the actual overlap is slim-to-none. 

Yeah.  The neat thing about FMAPs is that you can establish repeating
patterns, which is useful for interleaved DRAM/pmem devices.  Disk
filesystems don't do repeating patterns, so they'd much rather manage
non-repeating mappings.

--D

> > 
> > Thanks,
> > Amir.
> > 
> > [1] https://lore.kernel.org/linux-fsdevel/20250613174413.GM6138@frogsfrogsfrogs/
> 
> Thank you!
> John
> 

