Return-Path: <linux-fsdevel+bounces-47465-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2BCA9E5F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 03:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63498170637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34EE157E6B;
	Mon, 28 Apr 2025 01:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CdZyyHMQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E125684;
	Mon, 28 Apr 2025 01:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804916; cv=none; b=CpCKgG1XT+xJIvN0lrT32qMKru1T0a7srXNN8bSXoW+O1h0RtYmHvf7gLIIBe6kVyXycsCA7Tj39tRmidVSELLQptpcfNSVfbWZxqlcFJn00M5X9j5BJbpr99w58VivPBMkVTBKqG30sajnC3Fx5d1k4tj0UaX4ZURm46I5gC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804916; c=relaxed/simple;
	bh=voGcHcuUJxZIvWYp/gqePl+JGxhXrFqBulPecpJwMZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YotPXg+UuV5EK9UgRFJqNbp9sFiNWezEV2ndRfBEgUJ3P+QAcMEvJ3DQlf2ks2+C2nnbfpRzrK351scMLT3Vvo62+NIoctti0rtn/O8sad6ufg7LEfSYYJTjFCM8OwxYHPI5CL276X3r6g46NKb7t0RqBePCh63MEkLZs/r0xzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CdZyyHMQ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3feb3f54339so4517240b6e.1;
        Sun, 27 Apr 2025 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745804913; x=1746409713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOTD9+qJ3DB2cRPCVMYpnlZF0OQvWGQ+PHSchN+vCsg=;
        b=CdZyyHMQWHFKUcuII18LRu7UxDR2AuitkUlBykYFjwmW0UkMPoolk+yzizBUA8PMMB
         6GZ7AxqdFT8VKCFouQ3GpyvT3dupK2/qoWv2b1SJI4GiBmC5c0k8Uy4QAMoMkEhBjFV7
         1AZM8lzqxtKLXXhzYvzYoabUG37vH3OhVHseyUhrmgFfevb20ALxSM3tWKz1Ga6lCfau
         3+IibdHQsjAQZWAmKOUp7Ka9x5pr5VxxjyyU35ESZFVNKxaS6CMyhzjGcXzvzIwV/v9u
         tBAKcnVf8R0ccYMtzkIeIVY1mvYTMRLZY3MGnbbSwjtiPXbMF/aQx6hbWiNIa+7u7JCt
         phdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745804913; x=1746409713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOTD9+qJ3DB2cRPCVMYpnlZF0OQvWGQ+PHSchN+vCsg=;
        b=CsdiJkY1hVf3lPFgObvjJpLYF3kUSiguXZMTeOIS8cxLfdaFd/9Me2rpucD9Mvmb9N
         QiBuWTrOtxpjLq3cncQ1zVWkTd/R6RdeM8bs6pKMlHb1hoIGNkBKeloDyh8ou53JAs5Y
         x3zhIRnlYi7HRqwU30BHsA5jQ0UyvPc0PI4gwFEDhl0087gMReKwQ7cchWCoxjDas89F
         wpI/82V/K2zL9ca9k9eMv7rgtjkmOOiGhUe2KRmvz4vgLgPH0uumstsCEeDRr4LmvWpS
         paqTWdwRfwKqASk46NUE0NdJLi1XKioDuBRNehtqJNwzumsQt6yMg34ZCn3TlgxD9nWe
         ofIg==
X-Forwarded-Encrypted: i=1; AJvYcCUIbd1WvgC287pThNNCXdR1UZyx7w6KtaehsN/kWcYnQrWTDG7FugLjKfgHb07Z0i1ZSBLNNRW9hYpq@vger.kernel.org, AJvYcCUhnUscXKrN4rfP03huYaY+xwy3iwGh+ARjCzLxmuDTfS5UWCOQa64Nshbqiwyl/dJ72J0FjkebLQupr4oL@vger.kernel.org, AJvYcCWFudt6tOpO20NBLyxTu7ASKMuz1MHtVXkRFa+POOcYxPO3j2rxkX73B2xLAzBtVNt0EEz1ZdbaOxM=@vger.kernel.org, AJvYcCWyuv5xWOorCFYK1HIKXXI+/asmfmyHM+1SzJmWVf03cpVAtcLXNutYZnDQ0LkoCnHrp1ktOKXuOlwXf1Eo8Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUY+K9RqVGw7iurijZR1HBEcfMjhbGaEpSk6zKTrU3XOvP+mz
	QwAqfSsT+XIc37/PYlWbTg6UBoLEMzauKJ3xByk6arqSNlC2sd8X
X-Gm-Gg: ASbGncs4IVVuH00u110bzUHKksR2YZpQubyP9DJNg1+tn8SgO8u7V8+kpiUB8BN4qYU
	4PAB0g7hXzNuujjS3Qr3sBLGWoXGgYVOTB+k7yKC4DDbdrE5ssLeu6LZ95I4EtpTTCG6EQ3n0BX
	Eli6BwDi00kQjl2HbxOWPnErskGbBzgzwuKnqAT68TYdPYt7dXuxVw5qkw5xTac+TqQ8LKao7sb
	w6XGKKiGpZrdgXo8CiWe/TQobLZKPB44ptdokiu7pyGFdB4vFWQZy3DQP5PV16uG9fPX7/xo4s5
	MmdSGGcZ7ImKHIk4RRrC82BHMJl2vdbAsRjy4hK2KPEn0ggSARJhTVM=
X-Google-Smtp-Source: AGHT+IGqN3xTf5U+964YoRhK3pXmFW3/L8+DHv6gDtXxO/8dRDPl0vk0yvhPN+naZgspiiBdb3mvUA==
X-Received: by 2002:a05:6808:3319:b0:3fc:7e1:a455 with SMTP id 5614622812f47-401f2877e01mr6528091b6e.2.1745804913012;
        Sun, 27 Apr 2025 18:48:33 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:14de:ab78:90c3:bb9a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401f36b6099sm1325232b6e.44.2025.04.27.18.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 18:48:32 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 27 Apr 2025 20:48:30 -0500
From: John Groves <John@groves.net>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 0@groves.net
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424143848.GN25700@frogsfrogsfrogs>

On 25/04/24 07:38AM, Darrick J. Wong wrote:
> On Thu, Apr 24, 2025 at 08:43:33AM -0500, John Groves wrote:
> > On 25/04/20 08:33PM, John Groves wrote:
> > > On completion of GET_FMAP message/response, setup the full famfs
> > > metadata such that it's possible to handle read/write/mmap directly to
> > > dax. Note that the devdax_iomap plumbing is not in yet...
> > > 
> > > Update MAINTAINERS for the new files.
> > > 
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  MAINTAINERS               |   9 +
> > >  fs/fuse/Makefile          |   2 +-
> > >  fs/fuse/dir.c             |   3 +
> > >  fs/fuse/famfs.c           | 344 ++++++++++++++++++++++++++++++++++++++
> > >  fs/fuse/famfs_kfmap.h     |  63 +++++++
> > >  fs/fuse/fuse_i.h          |  16 +-
> > >  fs/fuse/inode.c           |   2 +-
> > >  include/uapi/linux/fuse.h |  42 +++++
> > >  8 files changed, 477 insertions(+), 4 deletions(-)
> > >  create mode 100644 fs/fuse/famfs.c
> > >  create mode 100644 fs/fuse/famfs_kfmap.h
> > > 
> 
> <snip>
> 
> > > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > > index d85fb692cf3b..0f6ff1ffb23d 100644
> > > --- a/include/uapi/linux/fuse.h
> > > +++ b/include/uapi/linux/fuse.h
> > > @@ -1286,4 +1286,46 @@ struct fuse_uring_cmd_req {
> > >  	uint8_t padding[6];
> > >  };
> > >  
> > > +/* Famfs fmap message components */
> > > +
> > > +#define FAMFS_FMAP_VERSION 1
> > > +
> > > +#define FUSE_FAMFS_MAX_EXTENTS 2
> > > +#define FUSE_FAMFS_MAX_STRIPS 16
> > 
> > FYI, after thinking through the conversation with Darrick,  I'm planning 
> > to drop FUSE_FAMFS_MAX_(EXTENTS|STRIPS) in the next version.  In the 
> > response to GET_FMAP, it's the structures below serialized into a message 
> > buffer. If it fits, it's good - and if not it's invalid. When the
> > in-memory metadata (defined in famfs_kfmap.h) gets assembled, if there is
> > a reason to apply limits it can be done - but I don't currently see a reason
> > do to that (so if I'm currently enforcing limits there, I'll probably drop
> > that.
> 
> You could also define GET_FMAP to have an offset in the request buffer,
> and have the famfs daemon send back the next offset at the end of its
> reply (or -1ULL to stop).  Then the kernel can call GET_FMAP again with
> that new offset to get more mappings.
> 
> Though at this point maybe it should go the /other/ way, where the fuse
> server can sends a "notification" to the kernel to populate its mapping
> data?  fuse already defines a handful of notifications for invalidating
> pagecache and directory links.
> 
> (Ugly wart: notifications aren't yet implemented for the iouring channel)

I don't have fully-formed thoughts about notifications yet; thinking...

If the fmap stuff may be shared by more than one use case (as has always
seemed possible), it's a good idea to think through a couple of things: 
1) is there anything important missing from this general approach, and 
2) do you need to *partially* cache fmaps? (or is the "offset" idea above 
just to deal with an fmap that might otherwise overflow a response size?)

The current approach lets the kernel retrieve and cache simple and 
interleaved fmaps (and BTW interleaved can be multi-dev or single-dev - 
there are current weird cases where that's useful). Also too, FWIW everything
that can be done with simple ext list fmaps can be done with a collection
of interleaved extents, each with strip count = 1. But I think there is a
worthwhile clarity to having both.

But the current implementation does not contemplate partially cached fmaps.

Adding notification could address revoking them post-haste (is that why
you're thinking about notifications? And if not can you elaborate on what
you're after there?).

> 
> --D

Cheers,
John


