Return-Path: <linux-fsdevel+bounces-54239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BC2AFCA02
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 14:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E60B37A9C7B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 12:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A1B2DA76D;
	Tue,  8 Jul 2025 12:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMyr/6Jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6343126B08F;
	Tue,  8 Jul 2025 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751976130; cv=none; b=C3qtb2lHWfszcfQDhE4zGhze2s7xs1kAUH2Lrn7h7MPq9LckXsx/l4NkUmMi1aSUvcAW7qWszFPcNzxb//HX8lrdsvFnwsBJB5pIdVIRQeypBDnXByPrudn1JjvMowxJ86CU4LqXbXlBOY7GPiQ/qZckKUsnsUbl1FhRlxe+MKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751976130; c=relaxed/simple;
	bh=Jn8hrsRg86sOLVXHmouC0yMQPqN2iUaDm1mOlavqijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GVTlxj7a1x71wtqqalgaJgpFp8qBn+t2cQNEiJoIp8u5yMLtZQ1MJ/QogcZGEkvieOUN3n91MoYui3GRHsplAmZ36qJTFsSzhsmLIhvc1PcmWGv2yh2YIp2WhEQ7qD8pl5FnyqQMM7Lv3KFWxBoiDnXE7vKwMDNU28zNwAS5hRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZMyr/6Jd; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-72c14138668so1412302a34.2;
        Tue, 08 Jul 2025 05:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751976127; x=1752580927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uGq9fv0o0kRTxTwHbXLzg/jeWoB7j9lh1A3UENkLmc=;
        b=ZMyr/6JdOKDjNPne4UeCPBd3rQS7HHUF9cEsQEZoR9VuHizr2LFIOSIOeI6rZvpGel
         LALDpzC3kl/uvRumqmwfyP+jKn6jBsbjTocNV7b0suHGL1Uob+ZamO3PMcU14TgjHmSo
         Wb5/UX20UdqIgbqZZToTx3+BYfBqf+0V7ZSmGHjaMdybVSbKOetsZu9SpvmcsRmgZ4jp
         FzkaY9Ythk/fKfygruiJ4RPAWSy7xsGopYyIBvJ+9a9Di5oRO8r22z7sTBmxBnnhsA5/
         IqoR0iLqPkwfRADQ+8p3olYaqL7do+B6ivyZCIpa7+ZnYNH7WGKHrkxSi1b5wO4P1acb
         MfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751976127; x=1752580927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2uGq9fv0o0kRTxTwHbXLzg/jeWoB7j9lh1A3UENkLmc=;
        b=mdtaQ72dfSS5rmMsB1SmI9X9KIfE60aiL1B84yeomNp8q0oK58LlWg1P67/Cvw7hZl
         d+cr/zV3KRHCH2eCR+vwyh0QFSb/xHX78TYfQx2LJcwTmVKbqr9nomtvYbNpP52GMhca
         M9kFXvMtNn1Pj3M5cZF29b0HX6USHVcK58X9awB/6qwpSc89PvIC+P+8FWCtqs1E8LoE
         V/h/ucJfCbHGLGzUjQFQqGUjY8FgYmX+aSFSvVAoTXaiGlBs9pra2zj0geP8xvLCwCz/
         bO7LFhA8gMkXseV+mu5X7Jn976GlaNLr2fMkqGSA6Jnxy2bSg1sF1G0dJ1w382PT/OSE
         fYIA==
X-Forwarded-Encrypted: i=1; AJvYcCVYxPsL3jGFR+x31A3N5kENPfAdfmWO4uUpz1cvzZ24kV63kHkYH5uhOiBJ8iGN9qJR3I5BjvDHLP4=@vger.kernel.org, AJvYcCWeBtaSz7XryJ5N/PbJeYmKaaDrr9YSoQtLF+l7MZ0nRGWIdpi4bNLmClP9tCFf3XgjHifdZeyvjuuotzck@vger.kernel.org, AJvYcCWpzwg4wdy84f9DOrDRDOYB8f/2WwK9bOv+rLhtLdCJNxNPSqvVijUCEr/kMnOKsaSde+AGlDyVLZkgj2YR0g==@vger.kernel.org, AJvYcCWrlXU1X+TgBilFGQrlKDZQGR+OhhjO8nf0nwWmPbE3RPEbkt30zMoyAK1WWA+8R8PZOHF+wHRyS/Rk@vger.kernel.org
X-Gm-Message-State: AOJu0YxayKCDLfatQQjvvuzbknexxW9O4rTWnarUWB0cLBqc620ddtNR
	v+r7IG+WiYIDEynXJ+oluDNLoWGVIxFkq9g6sYZ+yB65CeV17R4CKIAr
X-Gm-Gg: ASbGncsGFGSkpA3JtvIjjimuuAQOaGD9q/ZhUEMQB86ZeWCtwyXcSTTH5V826c8+MPG
	pyA9cTL+IxUXioMdSKcbFaJqyh11cC+Qgu+xWABHBccwlHx62FhZaBUF7ghE2TAWbbXOziZ/I6c
	sPdxIcK70T4dg8riUgAodSW3SorUz3pKbpI4skapOXjrzpj5sRoSyHNKCS2ruw2VVP07sMRErMk
	ygMrU8pm4WB3mK1cwW+ZTE2QfyHwgOrepDIZj2pCkoZGTmekfN6AlxEuwuLeYz4aCM7j6BCs/23
	7A0NbcC4BxxcyP0SeWckrRV6nnblNcsQdA3cnlAjbyBkjlg6zNadgLVtcwI5O9YbwLLMaLy6YJ1
	o
X-Google-Smtp-Source: AGHT+IE/EwQcJny5luA2L1jmlPqgPI2OAQPJnI9paMkK4frs6m/TZ8wBkc3niX9u+apPS0vL9gnf0g==
X-Received: by 2002:a05:6808:4442:b0:40b:4208:8440 with SMTP id 5614622812f47-4110de96df3mr2403977b6e.3.1751976126686;
        Tue, 08 Jul 2025 05:02:06 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:a416:8b40:fe30:49a3])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40d02aeed45sm1630594b6e.50.2025.07.08.05.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 05:02:05 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Tue, 8 Jul 2025 07:02:03 -0500
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
Message-ID: <ueepqz3oqeqzwiidk2wlf3f7enxxte4ws27gtxhakfmdiq4t26@cvfmozym5rme>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
 <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
 <20250707173942.GC2672029@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707173942.GC2672029@frogsfrogsfrogs>

On 25/07/07 10:39AM, Darrick J. Wong wrote:
> On Fri, Jul 04, 2025 at 08:39:59AM -0500, John Groves wrote:
> > On 25/07/04 09:54AM, Amir Goldstein wrote:
> > > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > > >
> > > > * FUSE_DAX_FMAP flag in INIT request/reply
> > > >
> > > > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> > > >   famfs-enabled connection
> > > >
> > > > Signed-off-by: John Groves <john@groves.net>
> > > > ---
> > > >  fs/fuse/fuse_i.h          |  3 +++
> > > >  fs/fuse/inode.c           | 14 ++++++++++++++
> > > >  include/uapi/linux/fuse.h |  4 ++++
> > > >  3 files changed, 21 insertions(+)
> > > >
> > > > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > > > index 9d87ac48d724..a592c1002861 100644
> > > > --- a/fs/fuse/fuse_i.h
> > > > +++ b/fs/fuse/fuse_i.h
> > > > @@ -873,6 +873,9 @@ struct fuse_conn {
> > > >         /* Use io_uring for communication */
> > > >         unsigned int io_uring;
> > > >
> > > > +       /* dev_dax_iomap support for famfs */
> > > > +       unsigned int famfs_iomap:1;
> > > > +
> > > 
> > > pls move up to the bit fields members.
> > 
> > Oops, done, thanks.
> > 
> > > 
> > > >         /** Maximum stack depth for passthrough backing files */
> > > >         int max_stack_depth;
> > > >
> > > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > > index 29147657a99f..e48e11c3f9f3 100644
> > > > --- a/fs/fuse/inode.c
> > > > +++ b/fs/fuse/inode.c
> > > > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> > > >                         }
> > > >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> > > >                                 fc->io_uring = 1;
> > > > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > > > +                           flags & FUSE_DAX_FMAP) {
> > > > +                               /* XXX: Should also check that fuse server
> > > > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > > > +                                * since it is directing the kernel to access
> > > > +                                * dax memory directly - but this function
> > > > +                                * appears not to be called in fuse server
> > > > +                                * process context (b/c even if it drops
> > > > +                                * those capabilities, they are held here).
> > > > +                                */
> > > > +                               fc->famfs_iomap = 1;
> > > > +                       }
> > > 
> > > 1. As long as the mapping requests are checking capabilities we should be ok
> > >     Right?
> > 
> > It depends on the definition of "are", or maybe of "mapping requests" ;)
> > 
> > Forgive me if this *is* obvious, but the fuse server capabilities are what
> > I think need to be checked here - not the app that it accessing a file.
> > 
> > An app accessing a regular file doesn't need permission to do raw access to
> > the underlying block dev, but the fuse server does - becuase it is directing
> > the kernel to access that for apps.
> > 
> > > 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?
> > 
> > I *think* that's checking the capabilities of the app that is accessing the
> > file, and not the fuse server. But I might be wrong - I have not pulled very
> > hard on that thread yet.
> 
> The init reply should be processed in the context of the fuse server.
> At that point the kernel hasn't exposed the fs to user programs, so
> (AFAICT) there won't be any other programs accessing that fuse mount.

Hmm. It would be good if you're right about that. My fuse server *is* running
as root, and when I check those capabilities in process_init_reply(), I
find those capabilities. So far so good.

Then I added code to my fuse server to drop those capabilities prior to
starting the fuse session (prctl(PR_CAPBSET_DROP, CAP_SYS_RAWIO) and 
prctl(PR_CAPBSET_DROP, CAP_SYS_ADMIN). I expected (hoped?) to see those 
capabilities disappear in process_init_reply() - but they did not disappear.

I'm all ears if somebody can see a flaw in my logic here. Otherwise, the
capabilities need to be stashed away before the reply is processsed, when 
fs/fuse *is* running in fuse server context.

I'm somewhat surprised if that isn't already happening somewhere...

> 
> > > 3. Darrick mentioned the need for a synchronic INIT variant for his work on
> > >     blockdev iomap support [1]
> > 
> > I'm not sure that's the same thing (Darrick?), but I do think Darrick's
> > use case probably needs to check capabilities for a server that is sending
> > apps (via files) off to access extents of block devices.
> 
> I don't know either, Miklos hasn't responded to my questions.  I think
> the motivation for a synchronous 

?

> 
> As for fuse/iomap, I just only need to ask the kernel if iomap support
> is available before calling ext2fs_open2() because the iomap question
> has some implications for how we open the ext4 filesystem.
> 
> > > I also wonder how much of your patches and Darrick's patches end up
> > > being an overlap?
> > 
> > Darrick and I spent some time hashing through this, and came to the conclusion
> > that the actual overlap is slim-to-none. 
> 
> Yeah.  The neat thing about FMAPs is that you can establish repeating
> patterns, which is useful for interleaved DRAM/pmem devices.  Disk
> filesystems don't do repeating patterns, so they'd much rather manage
> non-repeating mappings.

Right. Interleaving is critical to how we use memory, so fmaps are designed
to support it.

Tangent: at some point a broader-than-just-me discussion of how block devices
have the device mapper, but memory has no such layout tools, might be good
to have. Without such a thing (which might or might not be possible/practical),
it's essential that famfs do the interleaving. Lacking a mapper layer also
means that we need dax to provide a clean "device abstraction" (meaning
a single CXL allocation [which has a uuid/tag] needs to appear as a single
dax device whether or not it's HPA-contiguous).

Cheers,
John


