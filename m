Return-Path: <linux-fsdevel+bounces-54015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA91EAFA161
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E49716FC3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 19:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F002192EA;
	Sat,  5 Jul 2025 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH6nwMIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A61D5CD7;
	Sat,  5 Jul 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751743076; cv=none; b=qlEOwlFQcrRiIiff43Cj5faT1KXfwqolBGP33fqRTGnaw5cYVHJ4DA6U+GkAvoAXqf7gppzrMy2eYdkMPB/27UTF2tmCtmV/oUq34BfOv/C0spJwXCqWjXMzpuS33c0uBSR4NOBlNur1FgszGdQg8yEhZKXTFVQ8dwAWN/iLlns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751743076; c=relaxed/simple;
	bh=5JfbTDmmRNRU0QSsGXO2ytdUbZn8uJPpIrPMtWAOkpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIucNaRq7YPmPEDNT7RxaEkJ+Auh+69XAB6krdbLAQrMRFB/D/ku51dK3ggXH6M/TmvlHUahZqOISMkdAUd4mumKDD8LANmsJK0gvpDhlAdtR8nc4gbj3+fMyBVQoDD1BXiwgIx6b9DgOqw/vN+sAKtutSNXuh1Ig3IglwXAWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH6nwMIq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2ea08399ec8so1619565fac.1;
        Sat, 05 Jul 2025 12:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751743073; x=1752347873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0tal2TXuoVeMN1NrV/dwk0+DnB3su6E14sOZlFT3SI=;
        b=HH6nwMIq6eFOGaTT7l8FamT5wksdmVthPjkaMv4+Tv6N6VZX7VqR0yAzHzKqrRRqu3
         BRn8fbeg6bfx4DuzIrAlKSqKX5z9YnSLKiWT1nYXESluqAiA+5ICxBaUh/VXKbWyaRv3
         uGnXJPj9bG9emkNL9l7aX7jd2+GxNCjLcNcB95W9jJgkw0RlNI5/4f/G2MtR9g9ASX9Q
         Ct1hM395LYzwoM6v2qc/U1ArBnohP4C4NuYmGadT7RNNiA1iPNqPclQaoXhClqRmaJIq
         MMagYI7Thrsp51D7lyrUcTmgoCMGZNTdJ4Gg0tpzmkCikkuYS/jEmOfINmhQhE5eCMd4
         yisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751743073; x=1752347873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0tal2TXuoVeMN1NrV/dwk0+DnB3su6E14sOZlFT3SI=;
        b=ubvaTfOm7Ma1LD6LAnaKu2D0g/BFsZ+7+QV7l5mikV4nlgYOefJFv/nu3+gJLomHHQ
         vQmyxCcsTui/VVCmT2HTqFyxlYBDlv1X58n0ay21n0zWCEmT7Jq+han59fDoAN3B4v90
         st/vfb+VQTmE9R3p5zmi4wyf0eASwSGUtnDzSmAeKc0iHZLMwHqN73KoltlRloD4uRej
         z0wY9HV+kd5p5y5DPLuS/R+6EU2DOIes+hu9MgrolbeN/Gai4XVeeOwnhXl/G3B23cNZ
         gN/npNdlBf559HBeqsjfsHccIrZRnBghekX/xyqbK/R2y8yv2Egw9tHZCb7V2E50F63k
         bbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgZTbMMs0vJ6cpQEgOv7TgKpGIRDZZVnsGFjOd8z9DAB2KxY215B+cTyfMwpwGcQWhPQ3bmX7jyan3@vger.kernel.org, AJvYcCWQSgajDBGCM43jm/rm6RO9M/w9icQKNippkRSSMoKf8E18kDhNFjbbSwJkkYfsS7VefWoT+xp5OLPbQJxJYA==@vger.kernel.org, AJvYcCXIPYzFKNV53SLEJJtQB8/Ovosj9gAk6hRnrUEDY3G6NnJSE4AxIzBr5mOwevDcneT9LafM4Ez1sqg=@vger.kernel.org, AJvYcCXcTkov0O9vqZY+BoCzHnKpZ+D/F59rBy0coapoBLDUo3nVS66qC3yK0vFjDRzby7hPdYnApOZbk6DFhLQl@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx82SVqV/BpQZQxmh90haWZ5LH5OrHv/qb6HLN0ku51H9JHfiW
	zS+I5kQ+hF+Gk99iS8ljw27LyIIYtYtVNhiSJIbZtgkBhCr3csP/Xfrn
X-Gm-Gg: ASbGncsNKmuEBMCvtrhJ4NP724ODBdl6k/6jxL1yx4pX817Nd1aUKZ/fid2XXM2fFMI
	pgQTGgMTeA6hFAbBkuu2MhmsghhCHgOnq9DN0ewH7oLtJdePPKf+HUCbhGCDZLQkFWkQG3ODkwp
	Kzml+w4iKt/jwmqdAPQjDlGzovcSXQrTXjJo7l3NmT0yAZfHWAYZyADX484K0bM5bgNwckDPq29
	SfWyB0VP9FxMcQzzq9ooEZoXqSVKkjvkQFLkGRyK9p2AZbW1ycTwEyvFxAelhwpZzJ/6Y77hF6w
	nW9Xe7r50zqINzETVJSNvrL3Q4FqgvDVFNGDZ1PKRuXPTRnsv3BjR1u4s4gw6o470eb3ZKJs3pC
	q
X-Google-Smtp-Source: AGHT+IG5/wHt8NNYOAj0VVdS7ApVEHMemzu+FgEfnNgRE5AVwf3j0dSGHQb81nJIQIly3VlVlBvRsg==
X-Received: by 2002:a05:6870:5e0d:b0:2d4:dc79:b8b with SMTP id 586e51a60fabf-2f7afda584dmr2430162fac.10.1751743073028;
        Sat, 05 Jul 2025 12:17:53 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:5c68:c378:f4d3:49a4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f7901a35cesm1243246fac.32.2025.07.05.12.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 12:17:52 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sat, 5 Jul 2025 14:17:50 -0500
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <xyzi6ymuc4wi3byq4t4bjtdbm2xchrf7vrdmrdagpdawjrgvi2@ncdxgkt6dvjw>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAOQ4uxh-qDahaEpdn2Xs9Q7iBTT0Qx577RK-PrZwzOST_AQqUA@mail.gmail.com>
 <c73wbrsbijzlcfoptr4d6ryuf2mliectblna2hek5pxcuxfgla@7dbxympec26j>
 <gwjcw52itbe4uyr2ttwvv2gjain7xyteicox5jhoqjkr23bhef@xfz6ikusckll>
 <CAOQ4uxhnCh_Mm0DGgqwA5Vr4yySgSovesTqbnNH7Y_PXE9fzpg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhnCh_Mm0DGgqwA5Vr4yySgSovesTqbnNH7Y_PXE9fzpg@mail.gmail.com>

On 25/07/05 09:58AM, Amir Goldstein wrote:
> On Sat, Jul 5, 2025 at 2:06 AM John Groves <John@groves.net> wrote:
> >
> > On 25/07/04 03:30PM, John Groves wrote:
> > > On 25/07/04 10:54AM, Amir Goldstein wrote:
> > > > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > > > >
> > > > > Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> > > > > retrieve and cache up the file-to-dax map in the kernel. If this
> > > > > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> > > > >
> > > > > GET_FMAP has a variable-size response payload, and the allocated size
> > > > > is sent in the in_args[0].size field. If the fmap would overflow the
> > > > > message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> > > > > specifies the size of the fmap message. Then the kernel can realloc a
> > > > > large enough buffer and try again.
> > > > >
> > > > > Signed-off-by: John Groves <john@groves.net>
> > > > > ---
> > > > >  fs/fuse/file.c            | 84 +++++++++++++++++++++++++++++++++++++++
> > > > >  fs/fuse/fuse_i.h          | 36 ++++++++++++++++-
> > > > >  fs/fuse/inode.c           | 19 +++++++--
> > > > >  fs/fuse/iomode.c          |  2 +-
> > > > >  include/uapi/linux/fuse.h | 18 +++++++++
> > > > >  5 files changed, 154 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > > > index 93b82660f0c8..8616fb0a6d61 100644
> > > > > --- a/fs/fuse/file.c
> > > > > +++ b/fs/fuse/file.c
> > > > > @@ -230,6 +230,77 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
> > > > >         fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> > > > >  }
> > > > >
> > > > > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > > >
> > > > We generally try to avoid #ifdef blocks in c files
> > > > keep them mostly in h files and use in c files
> > > >    if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > > >
> > > > also #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > > > it a bit strange for a bool Kconfig because it looks too
> > > > much like the c code, so I prefer
> > > > #ifdef CONFIG_FUSE_FAMFS_DAX
> > > > when you have to use it
> > > >
> > > > If you need entire functions compiled out, why not put them in famfs.c?
> > >
> > > Perhaps moving fuse_get_fmap() to famfs.c is the best approach. Will try that
> > > first.
> > >
> > > Regarding '#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)', vs.
> > > '#ifdef CONFIG_FUSE_FAMFS_DAX' vs. '#if CONFIG_FUSE_FAMFS_DAX'...
> > >
> > > I've learned to be cautious there because the latter two are undefined if
> > > CONFIG_FUSE_FAMFS_DAX=m. I've been burned by this.
> 
> Yes, that's a risk, but as the code is shaping up right now,
> I do not foresee FAMFS becoming a module(?)

Yeah, I can't think of a good reason to go that way at this point.

> 
> > >
> > > My original thinking was that famfs made sense as a module, but I'm leaning
> > > the other way now - and in this series fs/fuse/Kconfig makes it a bool -
> > > meaning all three macro tests will work because a bool can't be set to 'm'.
> > >
> > > So to the extent that I need conditional compilation macros I can switch
> > > to '#ifdef...'.
> >
> > Doh. Spirit of full disclosure: this commit doesn't build if
> > CONFIG_FUSE_FAMFS_DAX is not set (!=y). So the conditionals are at
> > risk if getting worse, not better. Working on it...
> >
> 
> You're probably going to need to add stub inline functions
> for all the functions from famfs.c and a few more wrappers
> I guess.
> 
> The right amount of ifdefs in C files is really a matter of judgement,
> but the fewer the better for code flow clarity.
> 
> Thanks,
> Amir.

Right - I've done that now, and it actually looks pretty clean to me.

Thanks!
John


