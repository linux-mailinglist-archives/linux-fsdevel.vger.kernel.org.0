Return-Path: <linux-fsdevel+bounces-54016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A8AFA168
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 21:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46B51BC2E6A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2BF21858A;
	Sat,  5 Jul 2025 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWVVhANd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806074BE1;
	Sat,  5 Jul 2025 19:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751743671; cv=none; b=PfICckfrIO6E0StyUI7KyLc+sankj5f2PP7VH2fwGEd7fX2NrG3zV1xH8dtXphN7Yq08ZA5s5svDfVKaSpAhfvuoBW4VC1eZe0tGoZy6xXgfFLUzGNLADFtwhGf2enXHub1g1zCL6BOwLKOXUmFOOMi9Y6CEtmF1WK0I8qgfrCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751743671; c=relaxed/simple;
	bh=noCGX8JTMgk+VkhE3ajHW0gmlbUMW2TalG2eHJ7gQio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkvT7t1yvIsZm/2zx2FwNGjoxABZ4NEa5NeeK1eRdcsLafG9FcGtyiJCu79LZMHaS002sVsOsiuO0qWV8G3AcBIii0MRiaG7q/KjaxtVXqqbRtesN1kPa65f12FxDjb0kmU7sSnhmg6F7mGlQCWh7+Tzn17VVv20Z9OPmCE/G9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWVVhANd; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2da3c572a0bso1664078fac.3;
        Sat, 05 Jul 2025 12:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751743668; x=1752348468; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Uvi3Ssl9dhbiyb7WG5zZNIM65dwWn2BHeyM8ec+zc8=;
        b=AWVVhANdrekj55Kn2rJMbKCt0u1KDNOQ+5du4nAYqgS+LNrn2Nml5IQv5i0hVzpOD/
         SqvUqJrtdMa5ZeXChJBgM36q3ONv//VdHYvhxl/W4r/41cpkA60mdCZv4uEpwZCJSEMz
         Dw3GvyVAZr9dOJEqpDMQ4Qzpkz3KjB21ErFkQxVo1IymUXAO0LHVqlKIbNhLUo5qMzJq
         c6/XKxuz4te+o1IllsYulyeY+x8VORAKs5GkU13WQCl+TkKaSCQiG7mCFpbHoKrSNRcA
         C9retiz8Eati9DueUYuHuv4fyW2xVldWDSboWYJ7M6PRa9H74R0wjowQGN6oNqAvas52
         a6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751743668; x=1752348468;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Uvi3Ssl9dhbiyb7WG5zZNIM65dwWn2BHeyM8ec+zc8=;
        b=ogQcQ1X8LXuiZP8hC72f3CCKkJjh/Z2Vj/0RZey3DH3I+d+PFBhy1CoMhfvPAENLBY
         hFTYpjUn3BgBEfTjlAU5FHwDyhqaZFiNltNHym2iNydTjxwzp8JBVCFo1wUynrX62gD6
         Nskblkac3FaLEliG4wVu0XzMaA92kOQLLA/BTEkBEJD5ljvQjL/S5hdn83F+oPVGzVq5
         ORxVILDj2ygANph7CHqjoJVUnqu3ymiqOoENUZeOEluZWxvaeCIGEBWicpgtQnIVtRTj
         Z7VWCDWTYrjk6Uz0rm0cZ2tkYqiEmARpjeW3qlY2ZI7Jg0CHUxHURm0EQC0ntcjbyfBf
         6xMg==
X-Forwarded-Encrypted: i=1; AJvYcCUaMDIGbV+6sTfYvl/93tkrvSVPUr3nxa4gOV+zOOOpQdsv88uctt1W/nouUKq9CICdrSSqmqFwB7g=@vger.kernel.org, AJvYcCVP66nDn5iAiRvMDug7ngneKkukJSevypMWlPx4ylpKf4v4akh2FF6E1Cyk6X39AdAf0mksfKNDkVzI9e5kDA==@vger.kernel.org, AJvYcCVwBns4uXLLZs/xOYpQiCxLavTZD/ZExe1z6u1NKsUmabd8DF/DOfI5TRZ6fwmK03fHRRgekvv2brNv@vger.kernel.org, AJvYcCWMYostwlkjMlgEDUfHGOvBocO6mrJBEO8X+SX8naPEVJuaL4Ap3RI2g22DcZa1l81h10qZCSTVby8oHc6m@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgi0ZYHe7O7jmiP69/1MuEevEQg85AVO3WLmds9OwcreNf16zI
	HxtIw6dTkDx21AVoKqxPW6OJ36P4tRrpdI3ioV61H5pdp2mhPMbd0MWP
X-Gm-Gg: ASbGncvV4p8R77o2nP5/ZfgRSXJds6mzaHTRrdYkBJBfcJglbJZ33YO9rYHfRqvdMpi
	mdiPVqu8dDFeg+kKkE3kKA6S18usGgURKeIeZlv/9h5VMf71S0fJu8mo9B6NdznY9bfD84T6rbl
	R+f7NzT3CPtUzSIh4n/XDzctFfJgZTrqOk2M3+BEZNkKHUr1udQHUkTdSV9W77piMaYBjPaA1XY
	VsQ63Zb7amO8vukh/2JQ4v82J7d8e7c5NtIIynCBRUpPnwHuhbxw7whBJDk8k+z1hBCoIawgP40
	qOIWIgKaRDVkrSlEzugzQoGLlufLRbC/tDinBJVknCecmw8u5MPm/xu7Sm1PJi6GYvoWoeEfSgH
	J
X-Google-Smtp-Source: AGHT+IH5/ekfod+dK4/TpB2Sd1DQKASQYJbwHuxsumDvUc8YMsc2FL7gyW2TpiM3j94mzw4K5mpHqw==
X-Received: by 2002:a05:6870:ae08:b0:29e:3c8d:61a0 with SMTP id 586e51a60fabf-2f7afcf1e5emr2212398fac.8.1751743668059;
        Sat, 05 Jul 2025 12:27:48 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:5c68:c378:f4d3:49a4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f7902dbf5dsm1226132fac.48.2025.07.05.12.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:27:47 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 5 Jul 2025 14:27:45 -0500
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC V2 13/18] famfs_fuse: Create files with famfs fmaps
Message-ID: <custjjqmvxt2u3wfjztwjdxvdxr6vbpvcoptt4vvv2itt7d2os@zqg5es4g7xmf>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-14-john@groves.net>
 <CAOQ4uxgFoEByjaJPQv_QGMzGHLx=1hZvQcYjxM_ZZi_D063HEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgFoEByjaJPQv_QGMzGHLx=1hZvQcYjxM_ZZi_D063HEg@mail.gmail.com>

On 25/07/04 11:01AM, Amir Goldstein wrote:
> On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> >
> > On completion of GET_FMAP message/response, setup the full famfs
> > metadata such that it's possible to handle read/write/mmap directly to
> > dax. Note that the devdax_iomap plumbing is not in yet...
> >
> > Update MAINTAINERS for the new files.
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  MAINTAINERS               |   9 +
> >  fs/fuse/Makefile          |   2 +-
> >  fs/fuse/famfs.c           | 360 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/famfs_kfmap.h     |  63 +++++++
> >  fs/fuse/file.c            |  15 +-
> >  fs/fuse/fuse_i.h          |  16 +-
> >  fs/fuse/inode.c           |   2 +-
> >  include/uapi/linux/fuse.h |  56 ++++++
> >  8 files changed, 518 insertions(+), 5 deletions(-)
> >  create mode 100644 fs/fuse/famfs.c
> >  create mode 100644 fs/fuse/famfs_kfmap.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c0d5232a473b..02688f27a4d0 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8808,6 +8808,15 @@ F:       Documentation/networking/failover.rst
> >  F:     include/net/failover.h
> >  F:     net/core/failover.c
> >
> > +FAMFS
> > +M:     John Groves <jgroves@micron.com>
> > +M:     John Groves <John@Groves.net>
> > +L:     linux-cxl@vger.kernel.org
> > +L:     linux-fsdevel@vger.kernel.org
> > +S:     Supported
> > +F:     fs/fuse/famfs.c
> > +F:     fs/fuse/famfs_kfmap.h
> > +
> 
> I suggest to follow the pattern of MAINTAINERS sub entries
> FILESYSTEMS [EXPORTFS]
> FILESYSTEMS [IOMAP]
> 
> and call this sub entry
> FUSE [FAMFS]
> 
> to order it following FUSE entry
> 
> Thanks,
> Amir.

Done, and queued to -next

Thanks,
John


