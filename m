Return-Path: <linux-fsdevel+bounces-53966-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C48AF9463
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 15:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD223188AB6E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C2B2FCFCB;
	Fri,  4 Jul 2025 13:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfEBFn0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02B1DAC92;
	Fri,  4 Jul 2025 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751636408; cv=none; b=BI8Nz7gl+xnC9+lYVbMSyJAbGmjE+FySsg5yKqB5Ensbo3c5i6rBGgcww/H/rosu1goRxOdtlhSjKlimnhbJuPPyRe8uRvxfPlayuXuMUZ1bHRgwbqGAJDt7lhQtJMxmh9rJTTNyAmhfVQ5UeJZi1I3Y95qwymfzt7VYtV7sP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751636408; c=relaxed/simple;
	bh=x7xVEMSsXXsnT+LLSekeh57Svi1duY+nh1PdFmeqLGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkWgUwixPymdB5aIl3CTHpVNsbIXXwB+y22ASJYQbIxTvNwSJrY1AFJEsmMouFTcKBziXaua03npA5hEPe1F3W9doUrg28tTRT4PzyXImzAceOjmhVDrI4rxcGP/Yo9cAEk6pqUSqLz2QtTIBYulLd5EHSBNb3aJXqBPYA7s8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfEBFn0H; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2ea65f5a0easo726354fac.1;
        Fri, 04 Jul 2025 06:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751636405; x=1752241205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2ggb97YnCGQscprdaRiD3aA04R3MJar4CeMJyfUEVTY=;
        b=XfEBFn0H0srLeTRSPK4w37IW6+b3+oBDhpTgp9SCvVnsXWNkS00K8hcH1YV2ol/Q3O
         LJBECX4gNvNRjI3f5041tgHaQi55k1ImpFXDQsHWfq5FybCGtqfnSYD3hC+DTKy2aQ9q
         7BZqfvDR92hP0/ikKAQ2F0r1fHsJv1cces0Hv39btwOZeQ0U/LFg4Xa64VpQW0cNBCWG
         PLlj2ye2TEub1HWAXeW9ghT/RiBb0ycRzlfVC7FnTdLuHYiDlUG6HQA2eesc/swaRBWE
         trLylb52zRzgT148HUv2jizo9i7zbH+5Ai7T2/ep/RaOQwkLz8S85h9W3kAZuz1VhMTY
         3gKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751636405; x=1752241205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ggb97YnCGQscprdaRiD3aA04R3MJar4CeMJyfUEVTY=;
        b=SMkwwmtHib09y+f3LoZk5uDFkjzNLRpNx4pdabcJqkUrKzgfqoyulyPdqt+SpW91vO
         Co/C3HoO51zA53eulBmtsiaInty/dvX3rduz8SPEfJNYoCb0mVVQJeQsoW9oVaEyjRFz
         EuvRhLvYdva3J/AWJkscwnKvC04PGNSLkdNS4lmiYWkDNuYZb0bpskg7pTG7N5LT7y5X
         +36ICP9Dpxkf8qsnjvbl1HdlkfSpx5TNQgrMeh5tqO3z7eUlXDP/e4MVcLXdyPv98dcy
         0keoyiFwTIlHUofq0eKjR7CUEAIysLJJNxjcOJZywOsKAS6tt0DOvB30Oxd7/q//XGp1
         7U7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd5u1elRgq3ugxvuFE0pMt0Ha47CPjycUk2sqr4XhS0nd1IEUcETAKx2aNcECBTs7ExOQCqxxxxl0=@vger.kernel.org, AJvYcCWZV72f9K7/Wx9Abwb5NTNa4/CY/db9JJv+VeBsVHZEmYZnj/4iB9UrSAV6d22CpVic2NL83NzXBLuLshTM+A==@vger.kernel.org, AJvYcCXUaMpJ8g+AeBA8J/hI1b5vtpaevShpMvdTARUqH4sdaOfntSIO4MEt6YuPx6xyUP30nIU80XD7x2Ka@vger.kernel.org, AJvYcCXXUbOhFk3VqRLG4WhdWrCFSg0C/RhK2QSsRtK0blAc6zsomorDdQ7o6xzTwG7DZi5Ty5y+wQD31U9TwjBT@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7JmbNf5p/OZCfuHKxmo3PmVBdt3Lo0Fdtc3FfaOR0waAd68T
	qK3eObfjDE+74OnZ/AA1hJOe7HhLd/5r/wkkHM/FOv5s8xkg/dZZcNmi
X-Gm-Gg: ASbGncuJvyWmQooERHDrPymvcUtharQTSd2Wd+3jiIjO2lJbIcUrtP3wYZlUd2SDQIl
	2zmtrePq1C254niCNQh3FpTM4zz01Y9vdgzNxmr7v4pTuxB+0nWvJcEd430Alx7FCgBaZfiRevM
	VYhHlUr5QB/HP/NzvzispSQddn2HbRPIybpfx5v83RPZ+KSEwwvDozGwKxOLPUI6Rsk8biKL8JR
	HYVmTQpqbX6A+P96G+o/BnHXRtWAKZyl+QH50lsXKIykbkNDv72v2TdMyaC1wbsV1YIDN0lkfee
	zGpRcltQMvxdbs6DeLYKeShomYxa2ltuFdDDfcoOo0BRbRqNIqgcFCom8LcB7Ngf8iJ9rVUfiQf
	jbUD7YzIB0g==
X-Google-Smtp-Source: AGHT+IHTmverQslNh+Of2OQdfM9KG+sNpKYYyXBNG8W5je+VjCNljcNikA0fXeYMh2Zp5w7wNtcx6A==
X-Received: by 2002:a05:6871:2d02:b0:2b8:b76f:1196 with SMTP id 586e51a60fabf-2f7920cb157mr2219870fac.19.1751636405315;
        Fri, 04 Jul 2025 06:40:05 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:2db1:5c0d:1659:a3c])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f78ff40cd6sm514849fac.11.2025.07.04.06.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 06:40:01 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 4 Jul 2025 08:39:59 -0500
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>, 
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
Message-ID: <yhso6jddzt6c7glqadrztrswpisxmuvg7yopc6lp4gn44cxd4m@my4ajaw47q7d>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-11-john@groves.net>
 <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxi7fvMgYqe1M3_vD3+YXm7x1c4YjA=eKSGLuCz2Dsk0TQ@mail.gmail.com>

On 25/07/04 09:54AM, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> >
> > * FUSE_DAX_FMAP flag in INIT request/reply
> >
> > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> >   famfs-enabled connection
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/fuse_i.h          |  3 +++
> >  fs/fuse/inode.c           | 14 ++++++++++++++
> >  include/uapi/linux/fuse.h |  4 ++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 9d87ac48d724..a592c1002861 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -873,6 +873,9 @@ struct fuse_conn {
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > +       /* dev_dax_iomap support for famfs */
> > +       unsigned int famfs_iomap:1;
> > +
> 
> pls move up to the bit fields members.

Oops, done, thanks.

> 
> >         /** Maximum stack depth for passthrough backing files */
> >         int max_stack_depth;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 29147657a99f..e48e11c3f9f3 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1392,6 +1392,18 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >                         }
> >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> >                                 fc->io_uring = 1;
> > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > +                           flags & FUSE_DAX_FMAP) {
> > +                               /* XXX: Should also check that fuse server
> > +                                * has CAP_SYS_RAWIO and/or CAP_SYS_ADMIN,
> > +                                * since it is directing the kernel to access
> > +                                * dax memory directly - but this function
> > +                                * appears not to be called in fuse server
> > +                                * process context (b/c even if it drops
> > +                                * those capabilities, they are held here).
> > +                                */
> > +                               fc->famfs_iomap = 1;
> > +                       }
> 
> 1. As long as the mapping requests are checking capabilities we should be ok
>     Right?

It depends on the definition of "are", or maybe of "mapping requests" ;)

Forgive me if this *is* obvious, but the fuse server capabilities are what
I think need to be checked here - not the app that it accessing a file.

An app accessing a regular file doesn't need permission to do raw access to
the underlying block dev, but the fuse server does - becuase it is directing
the kernel to access that for apps.

> 2. What's the deal with capable(CAP_SYS_ADMIN) in process_init_limits then?

I *think* that's checking the capabilities of the app that is accessing the
file, and not the fuse server. But I might be wrong - I have not pulled very
hard on that thread yet.

> 3. Darrick mentioned the need for a synchronic INIT variant for his work on
>     blockdev iomap support [1]

I'm not sure that's the same thing (Darrick?), but I do think Darrick's
use case probably needs to check capabilities for a server that is sending
apps (via files) off to access extents of block devices.

> 
> I also wonder how much of your patches and Darrick's patches end up
> being an overlap?

Darrick and I spent some time hashing through this, and came to the conclusion
that the actual overlap is slim-to-none. 

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/linux-fsdevel/20250613174413.GM6138@frogsfrogsfrogs/

Thank you!
John

