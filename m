Return-Path: <linux-fsdevel+bounces-57533-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DEDB22DF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 18:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB8C170934
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E981F2FA0F0;
	Tue, 12 Aug 2025 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfJy6j4K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5BC23D7CF;
	Tue, 12 Aug 2025 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016654; cv=none; b=jRVzBaBMdtDNmYBI/KnCR+zL7OR1dH/SWySvHP4QFt6wduYusrWV/Z3XyjS37Q/MMKUfX0ttnN0edgA3TIHkhjH06n8f6p7wKQ/eAg0i1MyKicEc7akqMsd8doCLlrhoG8WLxOTpfwPjT69W3CQw9e2PYyCJbcbpQN8i8x5+lLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016654; c=relaxed/simple;
	bh=1LB3sQUcUTaY7w8V2P9L+qNDuPdWsQ0wWN2BJLOvNmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOJ5nq6bi/vv+2W/LC7IFup8iE99ENIOG4pHB5h+SK5tIrplyFrogEaqeFQ9ftiTlUyWe/4TmaZSRNd6HO7sxBi4Rnbj9wmOWBg5gAhCH4CRjqO5nd/hBQ+pvaMUewmxLeTCBPbBWTCuztVANZXZIZXa9t6j/EBVfneL0dUEtCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfJy6j4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89936C4CEF1;
	Tue, 12 Aug 2025 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755016653;
	bh=1LB3sQUcUTaY7w8V2P9L+qNDuPdWsQ0wWN2BJLOvNmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KfJy6j4KkfFeebnA9BSAnLlnIckfhzhg9lYw3ZuK2N27U6XVi2Pv+M72SLzJQV62Z
	 Pv5qN+NtdnEQIF8wEfapGW8QB1d3e2gAwfzTg73XcSxkooIDLbJEkemyBl7b20NH/1
	 WUHB/fUmTNK+2IVLZAJQWj1GjfnuamGnKCHwFRChrFfgkvHE0aVnjkVwEqq1kRZjdb
	 4nH9cTQONP7bHctTLPvI/qcOoFUdUDBZ8JXmnRKdsHn4E20wgH572JfopSXAkinMZn
	 8eWvE5W2cVyRYq/cHgT10b/qBueTYsn0hw3AjTyBvNYHkyKMKdfbD8iaTUg/1soyHm
	 KhD95htVxRh0g==
Date: Tue, 12 Aug 2025 09:37:33 -0700
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
Message-ID: <20250812163733.GF7942@frogsfrogsfrogs>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
 <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
 <20250707173942.GC2672029@frogsfrogsfrogs>
 <ueepqz3oqeqzwiidk2wlf3f7enxxte4ws27gtxhakfmdiq4t26@cvfmozym5rme>
 <20250709015348.GD2672029@frogsfrogsfrogs>
 <wam2qo5r7tbpf4ork5qcdqnw4olhfpkvlqpnbuqpwfhrymf3dq@hw3frnbadhk7>
 <z2yuwgzsbbirtfmr2rkgbq3yhjtvihumdxp4bvwgkybikubhgp@lfjfhlvtckmr>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <z2yuwgzsbbirtfmr2rkgbq3yhjtvihumdxp4bvwgkybikubhgp@lfjfhlvtckmr>

On Mon, Aug 11, 2025 at 01:30:53PM -0500, John Groves wrote:
> On 25/07/10 08:32PM, John Groves wrote:
> > On 25/07/08 06:53PM, Darrick J. Wong wrote:
> > > On Tue, Jul 08, 2025 at 07:02:03AM -0500, John Groves wrote:
> > > > On 25/07/07 10:39AM, Darrick J. Wong wrote:
> > > > > On Fri, Jul 04, 2025 at 08:39:59AM -0500, John Groves wrote:
> > > > > > On 25/07/04 09:54AM, Amir Goldstein wrote:
> > > > > > > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > > > > > > >
> > > > > > > > * FUSE_DAX_FMAP flag in INIT request/reply
> > > > > > > >
> > > > > > > > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> > > > > > > >   famfs-enabled connection
> > > > > > > >
> > > > > > > > Signed-off-by: John Groves <john@groves.net>
> > > > > > > > ---
> > > > > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > > > > >  fs/fuse/inode.c           | 14 ++++++++++++++
> > > > > > > >  include/uapi/linux/fuse.h |  4 ++++
> > > > > > > >  3 files changed, 21 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > > > index 9d87ac48d724..a592c1002861 100644
> > > > > > > > --- a/fs/fuse/fuse_i.h
> > > > > > > > +++ b/fs/fuse/fuse_i.h
> > > > > > > > @@ -873,6 +873,9 @@ struct fuse_conn {
> > > > > > > >         /* Use io_uring for communication */
> > > > > > > >         unsigned int io_uring;
> > > > > > > >
> > > > > > > > +       /* dev_dax_iomap support for famfs */
> > > > > > > > +       unsigned int famfs_iomap:1;
> > > > > > > > +
> > > > > > > 
> > > > > > > pls move up to the bit fields members.
> > > > > > 
> > > > > > Oops, done, thanks.
> > > > > > 
> > > > > > > 
> > > > > > > >         /** Maximum stack depth for passthrough backing files */
> > > > > > > >         int max_stack_depth;
> > > > > > > >
> > > > > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > > > > index 29147657a99f..e48e11c3f9f3 100644
> > > > > > > > --- a/fs/fuse/inode.c
> > > > > > > > +++ b/fs/fuse/inode.c
> > > > > > > > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > > > > > > >                         }
> > > > > > > >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> > > > > > > >                                 fc->io_uring = 1;
> > > > > > > > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > > > > > > > +                           flags & FUSE_DAX_FMAP) {
> > > > > > > > +                               /* XXX: Should also check that fuse server
> > > > > > > > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > > > > > > > +                                * since it is directing the kernel to access
> > > > > > > > +                                * dax memory directly - but this function
> > > > > > > > +                                * appears not to be called in fuse server
> > > > > > > > +                                * process context (b/c even if it drops
> > > > > > > > +                                * those capabilities, they are held here).
> > > > > > > > +                                */
> > > > > > > > +                               fc->famfs_iomap = 1;
> > > > > > > > +                       }
> > > > > > > 
> > > > > > > 1. As long as the mapping requests are checking capabilities we should be ok
> > > > > > >     Right?
> > > > > > 
> > > > > > It depends on the definition of "are", or maybe of "mapping requests" ;)
> > > > > > 
> > > > > > Forgive me if this *is* obvious, but the fuse server capabilities are what
> > > > > > I think need to be checked here - not the app that it accessing a file.
> > > > > > 
> > > > > > An app accessing a regular file doesn't need permission to do raw access to
> > > > > > the underlying block dev, but the fuse server does - becuase it is directing
> > > > > > the kernel to access that for apps.
> > > > > > 
> > > > > > > 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
> > > > > > 
> > > > > > I *think* that's checking the capabilities of the app that is accessing the
> > > > > > file, and not the fuse server. But I might be wrong - I have not pulled very
> > > > > > hard on that thread yet.
> > > > > 
> > > > > The init reply should be processed in the context of the fuse server.
> > > > > At that point the kernel hasn't exposed the fs to user programs, so
> > > > > (AFAICT) there won't be any other programs accessing that fuse mount.
> > > > 
> > > > Hmm. It would be good if you're right about that. My fuse server *is* running
> > > > as root, and when I check those capabilities in process_init_reply(), I
> > > > find those capabilities. So far so good.
> > > > 
> > > > Then I added code to my fuse server to drop those capabilities prior to
> > > > starting the fuse session (prctl(PR_CAPBSET_DROP, CAP_SYS_RAWIO) and 
> > > > prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN). I expected (hoped?) to see those 
> > > > capabilities disappear in process_init_reply() - but they did not disappear.
> > > > 
> > > > I'm all ears if somebody can see a flaw in my logic here. Otherwise, the
> > > > capabilities need to be stashed away before the reply is processsed, when 
> > > > fs/fuse *is* running in fuse server context.
> > > > 
> > > > I'm somewhat surprised if that isn't already happening somewhere...
> > > 
> > > Hrm.  I *thought* that since FUSE_INIT isn't queued as a background
> > > command, it should still execute in the same process context as the fuse
> > > server.
> > > 
> > > OTOH it also occurs to me that I have this code in fuse_send_init:
> > > 
> > > 	if (has_capability_noaudit(current, CAP_SYS_RAWIO))
> > > 		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO | FUSE_IOMAP_PAGECACHE;
> > > 	...
> > > 	ia->in.flags = flags;
> > > 	ia->in.flags2 = flags >> 32;
> > > 
> > > which means that we only advertise iomap support in FUSE_INIT if the
> > > process running fuse_fill_super (which you hope is the fuse server)
> > > actually has CAP_SYS_RAWIO.  Would that work for you?  Or are you
> > > dropping privileges before you even open /dev/fuse?
> > 
> > Ah - that might be the answer. I will check if dropped capabilities 
> > disappear in fuse_send_init. If so, I can work with that - not advertising 
> > the famfs capability unless the capability is present at that point looks 
> > like a perfectly good option. Thanks for that idea!
> 
> Review: the famfs fuse server directs the kernel to provide access to raw
> (memory) devices, so it should should be required to have have the
> CAP_SYS_RAWIO capability. fs/fuse needs to detect this at init time,
> and fail the connection/mount if the capability is missing.
> 
> I initially attempted to do this verification in process_init_reply(), but
> that doesn't run in the fuse server process context.
> 
> I am now checking the capability in fuse_send_init(), and not advertising
> the FUSE_DAX_FMAP capability (in in_args->flags[2]) unless the server has 
> CAP_SYS_RAWIO.
> 
> That requires that process_init_reply() reject FUSE_DAX_FMAP from a server
> if FUSE_DAX_FMAP was not set in in_args->flags[2]. process_init_reply() was
> not previously checking the in_args, but no big deal - this works.
> 
> This leads to an apparent dilemma in libfuse. In fuse_lowlevel_ops->init(),
> I should check for (flags & FUSE_DAX_IOMAP), and fail the connection if
> that capability is not on offer. But fuse_lowlevel_ops->init() doesn't
> have an obvious way to fail the connection. 

Yeah, I really wish it did.  I particularly wish that it had a way to
negotiate all the FUSE_INIT stuff before libfuse daemonizes and starts
up the event loop.  Well, not all of it -- by the time we get to
FUSE_INIT we've basically decided to commit to mounting.

For fuseblk servers this is horrible, because the kernel needs to be
able to open the block device with O_EXCL during the mount() process,
which means you actually have to be able to (re)open the block device
from op_init, which can fail.  Unless there's a way to drop O_EXCL from
an open fd?

The awful way that I handle failure in FUSE_INIT is to call
fuse_session_exit, but that grossly leaves a dead mount in its place.

Hey wait, is this what Mikulas was talking about when he mentioned
synchronous initialization?

For iomap I created a discovery ioctl so that you can open /dev/fuse and
ask the kernel about the iomap functionality that it supports, and you
can exit(1) without creating a fuse session.  The one goofy problem with
that is that there's a TOCTOU race if someone else does echo N >
/sys/module/fuse/parameters/enable_iomap, though fuse4fs can always
fall back to non-iomap mode.

--D

> How should I do that? Hoping Bernd, Amir or the other libfuse people may 
> have "the answer" (tm).
> 
> And of course if any of this doesn't sound like the way to go, let me know...
> 
> Thanks!
> John
> 
> 

