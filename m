Return-Path: <linux-fsdevel+bounces-54743-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E06B0296C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 06:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BD37B930E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Jul 2025 04:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9AB1FBEA6;
	Sat, 12 Jul 2025 04:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0BMtoPg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FE1A3154;
	Sat, 12 Jul 2025 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752295758; cv=none; b=cZkoP04NLAEwB8f27KOyuW1YWv/qydM9V4VrdwKLeIPnP1UQ4kunuX3P4Yl9vgfP1Lxg40rlGaww4hYM4VRwYTbZap4RWKs5x2smFSa9av2d5eeqGrMRPo6Wbw9xVCPA0YwR661kP1gpfb17wqt9HowlC5PJPLMAPpk36N8ApRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752295758; c=relaxed/simple;
	bh=QSrbaUGJjKRHtW5d5mhtB/XfLm+GVoyVMz4UYy+b9Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH4xFH8kOUD9x8wc4hPkXER2+kNpgGPvKM202VRV1gu0IRlrm0D+w6DmnJIixJYpMMVAN/KVa5fs2FKtd5uavT0xtSunEn2ScHrouflYAdU0htNrTh9OnetBRuAhfGjTvSE+10PvH1H7RAI/y4MlF+duCkwvp5O6eY83cRUN5xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0BMtoPg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84BA7C4CEEF;
	Sat, 12 Jul 2025 04:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752295757;
	bh=QSrbaUGJjKRHtW5d5mhtB/XfLm+GVoyVMz4UYy+b9Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0BMtoPgPdLXtlpOahnHdpsTh5YS53WXiQe74uXwV6MwJVyIhRdO56QLioMYT5xyi
	 2eZ84Wjy3ZUQpCwX2f+pYLZo0jp4g7/D3b6PHXI712dkbXEzZPcWvaiCiofY0HT8p1
	 rbI/MbsclQrDAqRV5phD0bqFs7kP/lrakjTzx9/EyJEcp2ukfdIkASGAm/zyL/SaNE
	 rEeHfW1ayr6Y3YsQYR+rU+TEsWcuQjuAWDc1ewXv6Vv4WfHBjImyTPVnBj32gwcf0W
	 oViJg1QFnHqkTWe0S/frbmEK4R04oZ1GaRxOSrYmM5ZaGIAVQQD3zcHviqdITIuIuv
	 rYOZe7+wKyADw==
Date: Fri, 11 Jul 2025 21:49:16 -0700
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
Message-ID: <20250712044916.GJ2672029@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
 <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
 <20250707173942.GC2672029@frogsfrogsfrogs>
 <ueepqz3oqeqzwiidk2wlf3f7enxxte4ws27gtxhakfmdiq4t26@cvfmozym5rme>
 <20250709015348.GD2672029@frogsfrogsfrogs>
 <wam2qo5r7tbpf4ork5qcdqnw4olhfpkvlqpnbuqpwfhrymf3dq@hw3frnbadhk7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wam2qo5r7tbpf4ork5qcdqnw4olhfpkvlqpnbuqpwfhrymf3dq@hw3frnbadhk7>

On Thu, Jul 10, 2025 at 08:32:13PM -0500, John Groves wrote:
> On 25/07/08 06:53PM, Darrick J. Wong wrote:
> > On Tue, Jul 08, 2025 at 07:02:03AM -0500, John Groves wrote:
> > > On 25/07/07 10:39AM, Darrick J. Wong wrote:
> > > > On Fri, Jul 04, 2025 at 08:39:59AM -0500, John Groves wrote:
> > > > > On 25/07/04 09:54AM, Amir Goldstein wrote:
> > > > > > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > > > > > >
> > > > > > > * FUSE_DAX_FMAP flag in INIT request/reply
> > > > > > >
> > > > > > > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> > > > > > >   famfs-enabled connection
> > > > > > >
> > > > > > > Signed-off-by: John Groves <john@groves.net>
> > > > > > > ---
> > > > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > > > >  fs/fuse/inode.c           | 14 ++++++++++++++
> > > > > > >  include/uapi/linux/fuse.h |  4 ++++
> > > > > > >  3 files changed, 21 insertions(+)
> > > > > > >
> > > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > > index 9d87ac48d724..a592c1002861 100644
> > > > > > > --- a/fs/fuse/fuse_i.h
> > > > > > > +++ b/fs/fuse/fuse_i.h
> > > > > > > @@ -873,6 +873,9 @@ struct fuse_conn {
> > > > > > >         /* Use io_uring for communication */
> > > > > > >         unsigned int io_uring;
> > > > > > >
> > > > > > > +       /* dev_dax_iomap support for famfs */
> > > > > > > +       unsigned int famfs_iomap:1;
> > > > > > > +
> > > > > > 
> > > > > > pls move up to the bit fields members.
> > > > > 
> > > > > Oops, done, thanks.
> > > > > 
> > > > > > 
> > > > > > >         /** Maximum stack depth for passthrough backing files */
> > > > > > >         int max_stack_depth;
> > > > > > >
> > > > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > > > index 29147657a99f..e48e11c3f9f3 100644
> > > > > > > --- a/fs/fuse/inode.c
> > > > > > > +++ b/fs/fuse/inode.c
> > > > > > > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > > > > > >                         }
> > > > > > >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> > > > > > >                                 fc->io_uring = 1;
> > > > > > > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > > > > > > +                           flags & FUSE_DAX_FMAP) {
> > > > > > > +                               /* XXX: Should also check that fuse server
> > > > > > > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > > > > > > +                                * since it is directing the kernel to access
> > > > > > > +                                * dax memory directly - but this function
> > > > > > > +                                * appears not to be called in fuse server
> > > > > > > +                                * process context (b/c even if it drops
> > > > > > > +                                * those capabilities, they are held here).
> > > > > > > +                                */
> > > > > > > +                               fc->famfs_iomap = 1;
> > > > > > > +                       }
> > > > > > 
> > > > > > 1. As long as the mapping requests are checking capabilities we should be ok
> > > > > >     Right?
> > > > > 
> > > > > It depends on the definition of "are", or maybe of "mapping requests" ;)
> > > > > 
> > > > > Forgive me if this *is* obvious, but the fuse server capabilities are what
> > > > > I think need to be checked here - not the app that it accessing a file.
> > > > > 
> > > > > An app accessing a regular file doesn't need permission to do raw access to
> > > > > the underlying block dev, but the fuse server does - becuase it is directing
> > > > > the kernel to access that for apps.
> > > > > 
> > > > > > 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
> > > > > 
> > > > > I *think* that's checking the capabilities of the app that is accessing the
> > > > > file, and not the fuse server. But I might be wrong - I have not pulled very
> > > > > hard on that thread yet.
> > > > 
> > > > The init reply should be processed in the context of the fuse server.
> > > > At that point the kernel hasn't exposed the fs to user programs, so
> > > > (AFAICT) there won't be any other programs accessing that fuse mount.
> > > 
> > > Hmm. It would be good if you're right about that. My fuse server *is* running
> > > as root, and when I check those capabilities in process_init_reply(), I
> > > find those capabilities. So far so good.
> > > 
> > > Then I added code to my fuse server to drop those capabilities prior to
> > > starting the fuse session (prctl(PR_CAPBSET_DROP, CAP_SYS_RAWIO) and 
> > > prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN). I expected (hoped?) to see those 
> > > capabilities disappear in process_init_reply() - but they did not disappear.
> > > 
> > > I'm all ears if somebody can see a flaw in my logic here. Otherwise, the
> > > capabilities need to be stashed away before the reply is processsed, when 
> > > fs/fuse *is* running in fuse server context.
> > > 
> > > I'm somewhat surprised if that isn't already happening somewhere...
> > 
> > Hrm.  I *thought* that since FUSE_INIT isn't queued as a background
> > command, it should still execute in the same process context as the fuse
> > server.
> > 
> > OTOH it also occurs to me that I have this code in fuse_send_init:
> > 
> > 	if (has_capability_noaudit(current, CAP_SYS_RAWIO))
> > 		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO | FUSE_IOMAP_PAGECACHE;
> > 	...
> > 	ia->in.flags = flags;
> > 	ia->in.flags2 = flags >> 32;
> > 
> > which means that we only advertise iomap support in FUSE_INIT if the
> > process running fuse_fill_super (which you hope is the fuse server)
> > actually has CAP_SYS_RAWIO.  Would that work for you?  Or are you
> > dropping privileges before you even open /dev/fuse?
> 
> Ah - that might be the answer. I will check if dropped capabilities 
> disappear in fuse_send_init. If so, I can work with that - not advertising 
> the famfs capability unless the capability is present at that point looks 
> like a perfectly good option. Thanks for that idea!

I thought of another twist -- what about a fuse server that runs with no
special privilege and is passed an open fd to a dax/block device?  Maybe
you're right that we need no explicit capability checks -- an open fd is
sufficient.

> > Note: I might decide to relax that approach later on, since iomap
> > requires you to have opened a block device ... which implies that the
> > process had read/write access to start with; and maybe we're ok with
> > unprivileged fuse2fs servers running on a chmod 666 block device?
> > 
> > <shrug> always easier to /relax/ the privilege checks. :)
> 
> My policy on security is that I'm against it...
> 
> > 
> > > > > > 3. Darrick mentioned the need for a synchronic INIT variant for his work on
> > > > > >     blockdev iomap support [1]
> > > > > 
> > > > > I'm not sure that's the same thing (Darrick?), but I do think Darrick's
> > > > > use case probably needs to check capabilities for a server that is sending
> > > > > apps (via files) off to access extents of block devices.
> > > > 
> > > > I don't know either, Miklos hasn't responded to my questions.  I think
> > > > the motivation for a synchronous 
> > > 
> > > ?
> > 
> > ..."I don't know what his motivations for synchronous FUSE_INIT are."
> > 
> > I guess I fubard vim. :(
> 
> So I'm not alone...
> 
> > 
> > > > As for fuse/iomap, I just only need to ask the kernel if iomap support
> > > > is available before calling ext2fs_open2() because the iomap question
> > > > has some implications for how we open the ext4 filesystem.
> > > > 
> > > > > > I also wonder how much of your patches and Darrick's patches end up
> > > > > > being an overlap?
> > > > > 
> > > > > Darrick and I spent some time hashing through this, and came to the conclusion
> > > > > that the actual overlap is slim-to-none. 
> > > > 
> > > > Yeah.  The neat thing about FMAPs is that you can establish repeating
> > > > patterns, which is useful for interleaved DRAM/pmem devices.  Disk
> > > > filesystems don't do repeating patterns, so they'd much rather manage
> > > > non-repeating mappings.
> > > 
> > > Right. Interleaving is critical to how we use memory, so fmaps are designed
> > > to support it.
> > > 
> > > Tangent: at some point a broader-than-just-me discussion of how block devices
> > > have the device mapper, but memory has no such layout tools, might be good
> > > to have. Without such a thing (which might or might not be possible/practical),
> > > it's essential that famfs do the interleaving. Lacking a mapper layer also
> > > means that we need dax to provide a clean "device abstraction" (meaning
> > > a single CXL allocation [which has a uuid/tag] needs to appear as a single
> > > dax device whether or not it's HPA-contiguous).
> > 
> > Well it's not as simple as device-mapper, where we can intercept struct
> > bio and remap/split it to our heart's content.  I guess you could do
> > that with an iovec...?  Would be sorta amusing if you could software
> > RAID10 some DRAM. :P
> 
> SW RAID, and mapper in general, has a "store and forward" property (or maybe
> "store, transmogrify, and forward") that doesn't really work for memory. 
> It's vma's (and files) that can remap memory address regions. Layered vma's 
> anyone? I need to think about whether that's utter nonsense, or just mostly 
> nonsense.

Oh but the ability to transmogrify is the key benefit of store and
forward!  Suppose you have to jack into some Klingon battle cruiser...

--D

> Continuing to think about this...
> 
> Thanks!
> John
> 
> 
> 

