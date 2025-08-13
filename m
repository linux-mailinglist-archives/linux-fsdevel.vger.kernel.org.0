Return-Path: <linux-fsdevel+bounces-57696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED085B24A2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A473AA774
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3E2E716D;
	Wed, 13 Aug 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdtbrgDf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE782E5427;
	Wed, 13 Aug 2025 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755090428; cv=none; b=LMEKQuxlMcwVl4ePtB3IUjDyfGneFUfD804E5QfZ3Mbkd40eJrprhP1bGD0VSEZgBrwkeoJjseEn5cgkIRc3Wzd9GH2iyG8LRBt8D5urjTw8xfbk1a+OeUeoOa4lIgGpFuc/BMaYvtQqmVUoacMQLNNlAYkQPeBqmlBiQNhJz90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755090428; c=relaxed/simple;
	bh=xNQyMQhgRS/pQv6n/1m5097qSZXjptp0FiHi+pt1qKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zy+0uIWAYcQU6X39tZ51kEMzdK4ei5FRF+pgDh+RYh/z/7u9p/ni/ilPJUyjt/t10F+n6wOqHOcBmZDyyHj8caJNoN2Bj88iPra+3tTCICswVW3UE/dZqAe/pTougL+PgD5Z2G65Sc0i85l7nMIDdZKW+ir2AjQpZiaTmgMjEDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdtbrgDf; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-741518e14d4so1810050a34.3;
        Wed, 13 Aug 2025 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755090425; x=1755695225; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1YudBw7MAQTXi6TXZdwDXGn3+WTymY6q/wDnBxH1+I=;
        b=ZdtbrgDftIMj3ShqS3lU67MOhySPrytSLc4jdYfkG85egQrlwhBvPTP+01rfFK3YdS
         iKd1cXEJ7nyWZwmPd+RUV6Ut3AbWTXcatFaluyjBvjji86SIvW2+GJYBpn3Mh/THmGC8
         Cg/RZ9ojvaR0NEq6nvTHbrGDO3R8DKfJJSFVW4+Z8CtMKWm4drQGydYyLd3AoORDUr6f
         uw3a9WjXk3kqreknbKRJbSjTDULHxLPpHZEuPkwW5xpzqHReOa+M0ydcpHZ9f1ZFFdvw
         NYfoS4JEv4wIVen5nKQotGUhZ7k4f5SF6C38O9WI5/hW4L8l/H1WRvjnPZGfelRe9z+q
         Hfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755090425; x=1755695225;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1YudBw7MAQTXi6TXZdwDXGn3+WTymY6q/wDnBxH1+I=;
        b=CpUAVrX8kzeTpF2yi6wi4j6V9MPIr+L4SGK0oGngZYFsxRRrnDRPSsmh2w0LMQjPSv
         y4bl759Yl4TY88jaXMu84vf6RyiHvy9BzUbL0Gup0vcGUiNxMnwmv6PDD723fqsukc0J
         nNHDa82lfNQ85c4NLNyMQUYE+VRp6x0qyt+BubMj0I8xfBrMw7gPgcGDSbCcByYftsxf
         PLLtfF5Z6SOiQqKlWVEaC6CLL5AOLtpkmo1AGKA9k9UD+UN9s22Te+RdfPAeDFKOiEZz
         7/MB5/y0xwmh9tNiLDmvjAIKnZe0yWQnUgPvIZSS8kWsWwWYlCsIgO7zDGBEDaParPlV
         6soA==
X-Forwarded-Encrypted: i=1; AJvYcCUcLTswSlRwYbBRO0XlOVX0oMtr/kiCdA1LwSkpzTO7cpm3gvdXR5/ub/DNSinS8EexleyzUFc/z6I=@vger.kernel.org, AJvYcCW4gVrDo/reepOiq4VpafqOXV7y13vfnEr+7bZeySSzz7aF8VFeuvllVRVbH4RQML3qY69EsCVUxVrt@vger.kernel.org, AJvYcCWFTaZ9L3QIoiTF3leclAGNmhZjqLebgglHl7uPWAr2IGI9LcEWH+LjtWl3Lzxl/kTE+agl842d8jVQhm3E@vger.kernel.org, AJvYcCXiaRJQp3Zrsq54sYhyDIAoEHZ2mkHs8uV5TQpqRQBvb4295mjFaw6F4SexS9r7JXrgnkn4QXk3rtIB0soX4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuXL6FrQ6fwM0B2A/VGlWG9Q7ceQBpm4hNGc12dbu2q+RHoZ9
	C2orljT14pLhTk7lg2KSeExOv64Rd9jo6u5xF4hZIu0HtZEb2tn3wilK
X-Gm-Gg: ASbGncu5jxOhCWAc3M45fs3muylOrEOLkZyoxfD7TZNeJA0Rq8iyXF6qb6f7UFxMtSX
	rngzc3ZByRrbDfzrZiVTDxrdXd6z1+snu+/xHI7nEB7VjrrGA3lkxrbjCGqyRk/8rwat95zXygZ
	V792Smm7ODv5Qra1zecju8YRdkMasuX1HoEsXYuH7WLFkMtxPKLeZq/0D3Lbs6Ctm3ehM/yEIyP
	wu5EbNncr6yaKyEbwTFGfLcp0ApMKFSn4D6ZJfxNb6LVUDLsW1kj4x3f03C99Xs92t8KOCZFgjG
	8zCLIc+OJLMYGAwzWXTHu/f6UkORrt2TuFcbsPc2b3+h/s6MuozbIIyUn6w601hXVUGiQ4hBZ1V
	Qpd4iKILq3CUWoLvXhBA6TpkvixLWyYZV+kvU
X-Google-Smtp-Source: AGHT+IFv30iQu2EjwFvGj4tST22eOwRpygmljio/eFQP244BeJM8t7/xZHQY4INgg8wGK62SBpnI5w==
X-Received: by 2002:a05:6830:65c4:20b0:73e:93dd:1f56 with SMTP id 46e09a7af769-74375498502mr1373565a34.13.1755090424285;
        Wed, 13 Aug 2025 06:07:04 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:39e1:a7d8:41fa:d365])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7436f9900ddsm850526a34.46.2025.08.13.06.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:07:03 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 13 Aug 2025 08:07:00 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	Dan Williams <dan.j.williams@intel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
Message-ID: <ewnlhaur3un32iq25zfvwqwju2pku5i56cuiijs572uige5z3z@d66k24dep4fi>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
 <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
 <20250707173942.GC2672029@frogsfrogsfrogs>
 <ueepqz3oqeqzwiidk2wlf3f7enxxte4ws27gtxhakfmdiq4t26@cvfmozym5rme>
 <20250709015348.GD2672029@frogsfrogsfrogs>
 <wam2qo5r7tbpf4ork5qcdqnw4olhfpkvlqpnbuqpwfhrymf3dq@hw3frnbadhk7>
 <z2yuwgzsbbirtfmr2rkgbq3yhjtvihumdxp4bvwgkybikubhgp@lfjfhlvtckmr>
 <20250812163733.GF7942@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250812163733.GF7942@frogsfrogsfrogs>

On 25/08/12 09:37AM, Darrick J. Wong wrote:
> On Mon, Aug 11, 2025 at 01:30:53PM -0500, John Groves wrote:
> > On 25/07/10 08:32PM, John Groves wrote:
> > > On 25/07/08 06:53PM, Darrick J. Wong wrote:
> > > > On Tue, Jul 08, 2025 at 07:02:03AM -0500, John Groves wrote:
> > > > > On 25/07/07 10:39AM, Darrick J. Wong wrote:
> > > > > > On Fri, Jul 04, 2025 at 08:39:59AM -0500, John Groves wrote:
> > > > > > > On 25/07/04 09:54AM, Amir Goldstein wrote:
> > > > > > > > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > > > > > > > >
> > > > > > > > > * FUSE_DAX_FMAP flag in INIT request/reply
> > > > > > > > >
> > > > > > > > > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> > > > > > > > >   famfs-enabled connection
> > > > > > > > >
> > > > > > > > > Signed-off-by: John Groves <john@groves.net>
> > > > > > > > > ---
> > > > > > > > >  fs/fuse/fuse_i.h          |  3 +++
> > > > > > > > >  fs/fuse/inode.c           | 14 ++++++++++++++
> > > > > > > > >  include/uapi/linux/fuse.h |  4 ++++
> > > > > > > > >  3 files changed, 21 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > > > > > > index 9d87ac48d724..a592c1002861 100644
> > > > > > > > > --- a/fs/fuse/fuse_i.h
> > > > > > > > > +++ b/fs/fuse/fuse_i.h
> > > > > > > > > @@ -873,6 +873,9 @@ struct fuse_conn {
> > > > > > > > >         /* Use io_uring for communication */
> > > > > > > > >         unsigned int io_uring;
> > > > > > > > >
> > > > > > > > > +       /* dev_dax_iomap support for famfs */
> > > > > > > > > +       unsigned int famfs_iomap:1;
> > > > > > > > > +
> > > > > > > > 
> > > > > > > > pls move up to the bit fields members.
> > > > > > > 
> > > > > > > Oops, done, thanks.
> > > > > > > 
> > > > > > > > 
> > > > > > > > >         /** Maximum stack depth for passthrough backing files */
> > > > > > > > >         int max_stack_depth;
> > > > > > > > >
> > > > > > > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > > > > > > index 29147657a99f..e48e11c3f9f3 100644
> > > > > > > > > --- a/fs/fuse/inode.c
> > > > > > > > > +++ b/fs/fuse/inode.c
> > > > > > > > > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > > > > > > > >                         }
> > > > > > > > >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> > > > > > > > >                                 fc->io_uring = 1;
> > > > > > > > > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > > > > > > > > +                           flags & FUSE_DAX_FMAP) {
> > > > > > > > > +                               /* XXX: Should also check that fuse server
> > > > > > > > > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > > > > > > > > +                                * since it is directing the kernel to access
> > > > > > > > > +                                * dax memory directly - but this function
> > > > > > > > > +                                * appears not to be called in fuse server
> > > > > > > > > +                                * process context (b/c even if it drops
> > > > > > > > > +                                * those capabilities, they are held here).
> > > > > > > > > +                                */
> > > > > > > > > +                               fc->famfs_iomap = 1;
> > > > > > > > > +                       }
> > > > > > > > 
> > > > > > > > 1. As long as the mapping requests are checking capabilities we should be ok
> > > > > > > >     Right?
> > > > > > > 
> > > > > > > It depends on the definition of "are", or maybe of "mapping requests" ;)
> > > > > > > 
> > > > > > > Forgive me if this *is* obvious, but the fuse server capabilities are what
> > > > > > > I think need to be checked here - not the app that it accessing a file.
> > > > > > > 
> > > > > > > An app accessing a regular file doesn't need permission to do raw access to
> > > > > > > the underlying block dev, but the fuse server does - becuase it is directing
> > > > > > > the kernel to access that for apps.
> > > > > > > 
> > > > > > > > 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
> > > > > > > 
> > > > > > > I *think* that's checking the capabilities of the app that is accessing the
> > > > > > > file, and not the fuse server. But I might be wrong - I have not pulled very
> > > > > > > hard on that thread yet.
> > > > > > 
> > > > > > The init reply should be processed in the context of the fuse server.
> > > > > > At that point the kernel hasn't exposed the fs to user programs, so
> > > > > > (AFAICT) there won't be any other programs accessing that fuse mount.
> > > > > 
> > > > > Hmm. It would be good if you're right about that. My fuse server *is* running
> > > > > as root, and when I check those capabilities in process_init_reply(), I
> > > > > find those capabilities. So far so good.
> > > > > 
> > > > > Then I added code to my fuse server to drop those capabilities prior to
> > > > > starting the fuse session (prctl(PR_CAPBSET_DROP, CAP_SYS_RAWIO) and 
> > > > > prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN). I expected (hoped?) to see those 
> > > > > capabilities disappear in process_init_reply() - but they did not disappear.
> > > > > 
> > > > > I'm all ears if somebody can see a flaw in my logic here. Otherwise, the
> > > > > capabilities need to be stashed away before the reply is processsed, when 
> > > > > fs/fuse *is* running in fuse server context.
> > > > > 
> > > > > I'm somewhat surprised if that isn't already happening somewhere...
> > > > 
> > > > Hrm.  I *thought* that since FUSE_INIT isn't queued as a background
> > > > command, it should still execute in the same process context as the fuse
> > > > server.
> > > > 
> > > > OTOH it also occurs to me that I have this code in fuse_send_init:
> > > > 
> > > > 	if (has_capability_noaudit(current, CAP_SYS_RAWIO))
> > > > 		flags |= FUSE_IOMAP | FUSE_IOMAP_DIRECTIO | FUSE_IOMAP_PAGECACHE;
> > > > 	...
> > > > 	ia->in.flags = flags;
> > > > 	ia->in.flags2 = flags >> 32;
> > > > 
> > > > which means that we only advertise iomap support in FUSE_INIT if the
> > > > process running fuse_fill_super (which you hope is the fuse server)
> > > > actually has CAP_SYS_RAWIO.  Would that work for you?  Or are you
> > > > dropping privileges before you even open /dev/fuse?
> > > 
> > > Ah - that might be the answer. I will check if dropped capabilities 
> > > disappear in fuse_send_init. If so, I can work with that - not advertising 
> > > the famfs capability unless the capability is present at that point looks 
> > > like a perfectly good option. Thanks for that idea!
> > 
> > Review: the famfs fuse server directs the kernel to provide access to raw
> > (memory) devices, so it should should be required to have have the
> > CAP_SYS_RAWIO capability. fs/fuse needs to detect this at init time,
> > and fail the connection/mount if the capability is missing.
> > 
> > I initially attempted to do this verification in process_init_reply(), but
> > that doesn't run in the fuse server process context.
> > 
> > I am now checking the capability in fuse_send_init(), and not advertising
> > the FUSE_DAX_FMAP capability (in in_args->flags[2]) unless the server has 
> > CAP_SYS_RAWIO.
> > 
> > That requires that process_init_reply() reject FUSE_DAX_FMAP from a server
> > if FUSE_DAX_FMAP was not set in in_args->flags[2]. process_init_reply() was
> > not previously checking the in_args, but no big deal - this works.
> > 
> > This leads to an apparent dilemma in libfuse. In fuse_lowlevel_ops->init(),
> > I should check for (flags & FUSE_DAX_IOMAP), and fail the connection if
> > that capability is not on offer. But fuse_lowlevel_ops->init() doesn't
> > have an obvious way to fail the connection. 
> 
> Yeah, I really wish it did.  I particularly wish that it had a way to
> negotiate all the FUSE_INIT stuff before libfuse daemonizes and starts
> up the event loop.  Well, not all of it -- by the time we get to
> FUSE_INIT we've basically decided to commit to mounting.
> 
> For fuseblk servers this is horrible, because the kernel needs to be
> able to open the block device with O_EXCL during the mount() process,
> which means you actually have to be able to (re)open the block device
> from op_init, which can fail.  Unless there's a way to drop O_EXCL from
> an open fd?
> 
> The awful way that I handle failure in FUSE_INIT is to call
> fuse_session_exit, but that grossly leaves a dead mount in its place.
> 
> Hey wait, is this what Mikulas was talking about when he mentioned
> synchronous initialization?
> 
> For iomap I created a discovery ioctl so that you can open /dev/fuse and
> ask the kernel about the iomap functionality that it supports, and you
> can exit(1) without creating a fuse session.  The one goofy problem with
> that is that there's a TOCTOU race if someone else does echo N >
> /sys/module/fuse/parameters/enable_iomap, though fuse4fs can always
> fall back to non-iomap mode.
> 
> --D

Thanks Darrick.

Hmm - synchronous init would be nice.

I tried calling fuse_session_exit(), but the broken mount was not an
improvement over a can't-do-I/O mount - which I get if the kernel rejects 
the capability currently known as FUSE_DAX_FMAP due to lack of CAP_SYS_RAWIO.

In my case, I think letting the mount complete with FUSE_DAX_FMAP rejected
is easier to detect and cleanup than a fuse_session_exit() aborted mount.

Famfs mount is a cli operation that does a sequence of stuff before and after
the fork/exec of the famfs fuse server. That fork/exec can't really return 
an error in the conventional sense, so I'm stuck diagnosing whether the 
mount is good (which I already do, but it's a WIP). 

I already have to poll for the .meta files to appear (superblock and log), 
and that can be adapted pretty easily to check whether they can be read 
correctly (which they can't if famfs doesn't have daxdev access).

If mount was synchronous, I'd still need to give the fork/exec enough time
to fail and then detect that. That would probably be cleaner, but not by
a huge amount.

Thanks,
John

<snip>


