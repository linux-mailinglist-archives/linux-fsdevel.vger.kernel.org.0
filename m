Return-Path: <linux-fsdevel+bounces-48772-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9311AAB4536
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 21:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09F44189D925
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 19:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59924298CD5;
	Mon, 12 May 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="amOLDhpl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009512571A8;
	Mon, 12 May 2025 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747079511; cv=none; b=M8hAZK1rlKNMqcmLfDeV2stla9HoShaBOlgehgq1CVP5CMB3lPxsIqZ/PTBXr48oKx04MF220iBdUTOnz/qAmH70sn+OfpgSyRYinTeACSu5lMRek7hulOInXblcNBdKB7afvGKHdPGd3UQGoS7KUboUViDZaugKBLtSaQG8ZU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747079511; c=relaxed/simple;
	bh=gzPsO0UrZDgI9iXYum4r5I7+OTPZxIA5JzksCAF1yrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WIa7fys6JxRupAZfcp6svVknJdWP1p3ulaQrdXKGh+xQSBC43tVkAQNawqdGaQxZ/5u3ZVdqTIE7SgDBk8KDlZd527QxjognAO05xMhn2peVuoNbhFMhYlSxQnyAPfYLH6I2ltPcv7HtHYUE+7MHUUizikn75z6pDs074mWSKTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=amOLDhpl; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c172f1de1so2780919a34.3;
        Mon, 12 May 2025 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747079509; x=1747684309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUkjMRzK3wxS4oootv0crIxPWYrPZ4z6gtzYbFkCOlI=;
        b=amOLDhplrgLRBlCYuNTIS6m7TXhd5P2T+wvOfFelgDMsa+xkzabostPJx1RiA43zoJ
         uufUye2S58VCrhibeTgO2JfCoY/JH8pey/+P85VxbQQARWj/3uuX1XLZerp2t8g6Ibbu
         wlR5i663ieaET3jQc0vPwO1e1+e6vQIa4Op5kRSjsjYzAfCrR+nay7wRNbFXzRpBHP/Y
         sj/B594L2XngqsNdpKFdCkIz2tIEdju7JWoiFMQnEMWGsNi8w9dWzP+9t20R9OmGfXk/
         2+rGxQBqfgNRpUa7ferwv9n6x1AAbz03YTApT8sCDc8pIFPmH4VWaLneZgf0GZWTYIUW
         MIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747079509; x=1747684309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nUkjMRzK3wxS4oootv0crIxPWYrPZ4z6gtzYbFkCOlI=;
        b=rb4PtpUWhuU2OEjNsMTXtMWJAYvsdxEAkHIABunTB58r943Jm9VFTiS/Okrk0oECQd
         Y5DIjzblRgGDjRYK5rjamxTURXcSNH3xelXtBbtFzG/f7wi4RD+pqK93d6geFI7WoCQ1
         tmslE7v59+yG3qKWPiK55eGFJClhYoDC5kpdlUApS3MhNaW1SgU17D1fFnChE565yNAx
         eM7eJV661gbpifumDb/0HDnX9d+tQNOqb/UkJ0PKlOsmnx45j4p/EFx0VoBfjhCOICPj
         QROWnBAW7PMANwfeBqml5cXP4HbCbCW5q4y5vi/bywKOXH6L9hFqwcAU43j6qXAo37cB
         ONOA==
X-Forwarded-Encrypted: i=1; AJvYcCUhvkrZBilfPahgyKvme5UAJFo3g7Vtd4uEkT5GzpXg57gJNT+aonAAWxDCsV6QFR4PpigveEd9RlM=@vger.kernel.org, AJvYcCUnuYTVDiZsfBCfwrSmWq6OhuLtUlhOAXLVM1oYcs30DmAUr5qEr2NSDcKh/8AEQYVqxVwiG9rew6KqHuQ2@vger.kernel.org, AJvYcCUu73+lWWak8el+qFwPvMXe1/Ra/BYBruFuN6vhuBD70T8cz3ed/rkX+f9XnSADXeOqi8fbwRDuzG5AsLoz9g==@vger.kernel.org, AJvYcCXUlM4ZH2opS8ypJLrpsb2H5rNshiFw3GQfboMcnHhaWxVl9Q0eFjrdE2+R3rBLzjbltc9LceuzbNGQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdR5MWLOnIDaLf0C9GeFnFCYIrBsZ+Lp7R+8R4lnEoFAPk6Ct
	FV5IbhQy1YssejEil4RvTN+Piwno4H+Ztib+/TYeTmwIU5QCih4R
X-Gm-Gg: ASbGncujUVru/Fz0rkVAeOdqyrM8bCAaKS2kj65giqesSx5zE7hR8S5mJkY6RUNCdal
	EjdlTa2aEL8z1unv016/jz25DgYvwlws90U45TOun9VZuoBvGQCBBDdVgvUHQTU2tL2FpR4Km1m
	NVmVPblzn2UVFVX0/AYdBvujjKAQSs2F0ah5jg+MrXFmQSCHNczI5QvgOCCeh7XStuLBdP4lw7i
	YvoLwQBnHIhXFCGVm57akhRMuNqWAFB65zSUbBwSDrCU406YLqCy47CO0UDI77lTe9BKKvDDhas
	GsgG1mqkTgEeLRVN3x0l73nQAcLVmRYcXZNSVu3QDseRYfLGm5s9ZsJZDqoMPEixrg==
X-Google-Smtp-Source: AGHT+IEAeXjZiozlRYEM0gARp0zQzeR/jbozJkUKlmzreQdwjSlhfL93jt9YN6NYGu8g494ESdu3sw==
X-Received: by 2002:a05:6830:4903:b0:72a:1d2a:4acf with SMTP id 46e09a7af769-73226aaed7fmr9385724a34.17.1747079508876;
        Mon, 12 May 2025 12:51:48 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:f16b:b065:d67a:e0f7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73356c72943sm1353348a34.3.2025.05.12.12.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 12:51:47 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 12 May 2025 14:51:45 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
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
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, john@groves.net
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
Message-ID: <aytnzv4tmp7fdvpgxdfoe2ncu7qaxlp2svsxiskfnrvdnknhmp@uu4ifgc6aj34>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs>
 <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs>
 <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>

On 25/05/06 06:56PM, Miklos Szeredi wrote:
> On Mon, 28 Apr 2025 at 21:00, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> > <nod> I don't know what Miklos' opinion is about having multiple
> > fusecmds that do similar things -- on the one hand keeping yours and my
> > efforts separate explodes the amount of userspace abi that everyone must
> > maintain, but on the other hand it then doesn't couple our projects
> > together, which might be a good thing if it turns out that our domain
> > models are /really/ actually quite different.
> 
> Sharing the interface at least would definitely be worthwhile, as
> there does not seem to be a great deal of difference between the
> generic one and the famfs specific one.  Only implementing part of the
> functionality that the generic one provides would be fine.

Agreed. I'm coming around to thinking the most practical approach would be
to share the GET_FMAP message/response, but to add a separate response
format for Darrick's use case - when the time comes. In this patch set, 
that starts with 'struct fuse_famfs_fmap_header' and is followed by the 
approriate extent structures, serialized in the message. Collectively 
that's an fmap in message format.

Side note: the current patch set sends back the logically-variable-sized 
fmap in a fixed-size message, but V2 of the series will address that; 
I got some help from Bernd there, but haven't finished it yet.

So the next version of the patch set would, say, add a more generic first
'struct fmap_header' that would indicate whether the next item would be
'struct fuse_famfs_fmap_header' (i.e. my/famfs metadata) or some other
to be codified metadata format. I'm going here because I'm dubious that
we even *can* do grand-unified-fmap-metadata (or that we should try).

This will require versioning the affected structures, unless we think
the fmap-in-message structure can be opaque to the rest of fuse. @miklos,
is there an example to follow regarding struct versioning in 
already-existing fuse structures?

> 
> > (Especially because I suspect that interleaving is the norm for memory,
> > whereas we try to avoid that for disk filesystems.)
> 
> So interleaved extents are just like normal ones except they repeat,
> right?  What about adding a special "repeat last N extent
> descriptions" type of extent?

It's a bit more than that. The comment at [1] makes it possible to understand
the scheme, but I'd be happy to talk through it with you on a call if that
seems helpful.

An interleaved extent stripes data spread across N memory devices in raid 0
format; the space from each device is described by a single simple extent 
(so it's contigous), but it's not consumed contiguously - it's consumed in 
fixed-sized chunks that precess across the devices. Notwithstanding that I 
couldn't explain it very well when we talked about it at LPC, I think I 
could make it pretty clear in a pretty brief call now.

In any case, you have my word that it's actually quite elegant :D
(seriously, but also with a smile...)

> 
> > > But the current implementation does not contemplate partially cached fmaps.
> > >
> > > Adding notification could address revoking them post-haste (is that why
> > > you're thinking about notifications? And if not can you elaborate on what
> > > you're after there?).
> >
> > Yeah, invalidating the mapping cache at random places.  If, say, you
> > implement a clustered filesystem with iomap, the metadata server could
> > inform the fuse server on the local node that a certain range of inode X
> > has been written to, at which point you need to revoke any local leases,
> > invalidate the pagecache, and invalidate the iomapping cache to force
> > the client to requery the server.
> >
> > Or if your fuse server wants to implement its own weird operations (e.g.
> > XFS EXCHANGE-RANGE) this would make that possible without needing to
> > add a bunch of code to fs/fuse/ for the benefit of a single fuse driver.
> 
> Wouldn't existing invalidation framework be sufficient?
> 
> Thanks,
> Miklos

My current thinking is that Darrick's use case doesn't need GET_DAXDEV, but
famfs does. I think Darrick's use case has one backing device, and that should
be passed in at mount time. Correct me if you think that might be wrong.

Famfs doesn't necessarily have just one backing dev, which means that famfs
could pass in the *primary* backing dev at mount time, but it would still
need GET_DAXDEV to get the rest. But if I just use GET_FMAP every time, I
only need one way to do this.

I'll add a few more responses to Darrick's reply...

Thanks,
John

[1] https://github.com/cxl-micron-reskit/famfs-linux/blob/c57553c4ca91f0634f137285840ab25be8a87c30/fs/fuse/famfs_kfmap.h#L13


