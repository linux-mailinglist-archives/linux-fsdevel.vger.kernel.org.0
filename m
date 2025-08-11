Return-Path: <linux-fsdevel+bounces-57420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD799B2146B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 20:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC92A3A7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A00238C16;
	Mon, 11 Aug 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFvW6WU3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCB224891;
	Mon, 11 Aug 2025 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937060; cv=none; b=DhKL9mrrIGRC+MpZdpCLPzf4A04Gyv81Rnj2Pzv25m0LVJROuqhbtjnkMIf9+/VWSmpz+R2wOXB+HETTdNIrLtZGrTiJmhUmRU8iaJaZePpfuvOb3heqDo0rDp2gF69rAvurBJS5aGC6K0mG71vFFB70iq9CYWDgUp3b7Y5fBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937060; c=relaxed/simple;
	bh=xk8qaiErmfTGhxRgj9XAM40WAN3dsm5MjAETZq/bFWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewjhR8RwraQ4vT14sbUrle+yxOGADGPk2CkWzABUchcP19eb1hL+RTv5ScRjq76D+QfdQTLdnxGHvNLrOWteJiUcyj9VvW1V7fmHiWdYe7VS6kyWYjO/kmTkLFB+AEJhYuf1prYOyYpvNGSlNJzENMOWbD5XgzHFxSEjEzzZ4BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFvW6WU3; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-30b71d5cc03so2173248fac.3;
        Mon, 11 Aug 2025 11:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754937057; x=1755541857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=erUZxz/3YKb6AzciSl87N1qVga0MvtNzwF8QlCkJO6o=;
        b=QFvW6WU3lgM6P2wijhOmXo0qcXF+io6JNG7854YLpujDhyjrb8dI/Rf6JL3WS82bQP
         nrP8hKLjATEQk/XqdD2FC92YTCVlkBw4sjxZCxyR/TfWW3seym14kgb6wi9G6oJS37zl
         cC4RLpKIorsT47uH2SUc9WUhVfWm6LSIzbj9fAl656ybTNuk6bUQ83ZslHdbDinXw1rx
         RZLQh1TxS1WkHGOLWtk0n5bxdcaHAnvxixIS6o/rlF70pS1Ival5JRNValbBwGaEvdD0
         mZ7rRgIsf1QpAX2q+OdWRAmZZ169JCvtmaEmiVLM/bZql0GhNIqPNtCjakW7zBaRNBOA
         y0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937057; x=1755541857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=erUZxz/3YKb6AzciSl87N1qVga0MvtNzwF8QlCkJO6o=;
        b=oo6IJeJwPqlLqPeprQTVZgpBWEDBoPTUN6OKVA8GRx36Dd21esfl1SNYegwqbtqFaO
         mz8BLqKhWXTucM467n6k0sxXCJsnuqSXKx7AdD18q1OvB5WYymWEVX4zpB/9JNxGXS3K
         H+b7kZDMR32eEpvFyP8tbUyLBDLGS3Nw8NaVyg9sft00dcv4BmxU25Hg98g19JmqmdX5
         ci4eVnQZXvFXva1j26iyquRdxzTx2PtAOw05BA08v9R0rg4Ydu8+BsF+VhhRst2PQqEb
         A0Mvl5m9pqkmZAZ7zDFqePWXAlBHpcsdadKYfrUAU7NVZLg7Kvh/rdmOQedV+S4Qh6L+
         E41w==
X-Forwarded-Encrypted: i=1; AJvYcCUZHfOi5fNuffONqKZLrJUGT1baLrvzlMcAjaVYwQoHRGSM6JWqawwgm1gz+ICu06dRMHo9sdft58i4@vger.kernel.org, AJvYcCVRwA/CZMlZqhj4cG8cIrKd3CLVJWA8EAiAcF/FYTGx/1UhoR2IDm+JOxLUgj7keAjV4Vgy3icIAus=@vger.kernel.org, AJvYcCXZrU08wFR/oKbRmae1uzxCkdHbCuqukcViu43RxYlJJ4GsP7UDzeB2mDkm1yLDVvvUE12WszfnXMiTYA46@vger.kernel.org, AJvYcCXlQ3pfbvaOmTj1IMhsy/f8oWBgRbXrVTtN1xPuNVvqHQhmJmdYeh3mvA2ajiRf15WkBRDwdulYMSQkSRpK1A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBM60ybjEwUU3z8DkupVY5gVO2d6J0Jfvidcn3usdvBjwUUrMl
	zln49tgCrsPWZT+igMethtXCERAdnzBDMLS67y1CQYUm3aeSXBJwoVLG
X-Gm-Gg: ASbGnctfgCiDoA8kuHZiLIc1xTiEuMGHUfzAoPdAMCqyUsPHhho9kZnQQZjmTvaw7X6
	okgxtRn4/b6nXE1SpdCAKU73K51tULJN2zTJid7InkGLsJuLtqSp15bz3fBubw9o+TNQAnYPRCf
	1a/qLzHQ6MrHuIGnzpJobzO+SPn8eHDeCGtsTks9/13ZMVfTD0LwyxL0KxpSEyIFNW5EQ5H7LxC
	SmU9nui2E/lSVxYfAI+PchCGHI41aF9VGRfkYn36miXGTg8saoBn7DOnKCPtNe6Bfl3wOBOTmrq
	8S1QAnqLNe0YCbyuwPBkyIxc8Vs97iRtugPPKqxDu9s9sEnEO5q9zHzFT9izuaC3Ch6gDMaIUZJ
	qJqKuqr75p9e/toi8PwQ7UrwNFA1h9PnaFgq/
X-Google-Smtp-Source: AGHT+IFeSQ0skn1obsPdMuUc/I2OxHhwHFM3A2M1joHpdeeawx5gSo3o7y+eUrVN/gXuAHlP6eMhag==
X-Received: by 2002:a05:6870:479b:b0:307:3d5:713f with SMTP id 586e51a60fabf-30c210da176mr9357342fac.19.1754937056701;
        Mon, 11 Aug 2025 11:30:56 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:b420:5f86:575e:74a8])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-307a7390b47sm7916818fac.21.2025.08.11.11.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:30:55 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 11 Aug 2025 13:30:53 -0500
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
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC V2 10/18] famfs_fuse: Basic fuse kernel ABI enablement for
 famfs
Message-ID: <z2yuwgzsbbirtfmr2rkgbq3yhjtvihumdxp4bvwgkybikubhgp@lfjfhlvtckmr>
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

On 25/07/10 08:32PM, John Groves wrote:
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

Review: the famfs fuse server directs the kernel to provide access to raw
(memory) devices, so it should should be required to have have the
CAP_SYS_RAWIO capability. fs/fuse needs to detect this at init time,
and fail the connection/mount if the capability is missing.

I initially attempted to do this verification in process_init_reply(), but
that doesn't run in the fuse server process context.

I am now checking the capability in fuse_send_init(), and not advertising
the FUSE_DAX_FMAP capability (in in_args->flags[2]) unless the server has 
CAP_SYS_RAWIO.

That requires that process_init_reply() reject FUSE_DAX_FMAP from a server
if FUSE_DAX_FMAP was not set in in_args->flags[2]. process_init_reply() was
not previously checking the in_args, but no big deal - this works.

This leads to an apparent dilemma in libfuse. In fuse_lowlevel_ops->init(),
I should check for (flags & FUSE_DAX_IOMAP), and fail the connection if
that capability is not on offer. But fuse_lowlevel_ops->init() doesn't
have an obvious way to fail the connection. 

How should I do that? Hoping Bernd, Amir or the other libfuse people may 
have "the answer" (tm).

And of course if any of this doesn't sound like the way to go, let me know...

Thanks!
John


