Return-Path: <linux-fsdevel+bounces-53997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F5AF9CE0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 02:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25A09587120
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jul 2025 00:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD59475;
	Sat,  5 Jul 2025 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRnG8sLW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CA2CA9;
	Sat,  5 Jul 2025 00:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751673999; cv=none; b=l1oqPFCpwfiyAgMQk0Dg7k06hJOMQuQoPZ8tj1U6YENGMsfOe8BJMhMmAlzAUM7+fj3IDz/L3bjloXNYdCU5N12hPHyrisvFfpw8sGz1+mhxUUssdF6lZkSJVE3sS0rTPblqvXm5OMphfwFRy15a1nyg2yUym0PcvUndWMxGSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751673999; c=relaxed/simple;
	bh=g/709Mz80eEkm8+UShjp6F/2B9qEEZzVuc/3q6jnrzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n41F6mRHeHgtsdCq04ZhpROhoAToCwMzZ3Z55TXJcom8KTO6kcPbF8dC1ze88UpFHuQu78r9KH2PG7xAa/c9Yt8iJRSs0OIH2ApLliHqhVAZsaUBHY+hYDhMiThrisSMfSwjjg9YiW/lMsctF1wOuPysVSbjF/rXXZ3UWmk+GzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRnG8sLW; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6120049f09fso837577eaf.2;
        Fri, 04 Jul 2025 17:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751673996; x=1752278796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TwTWoqkPV7gyMrYquUEBim6LYd65earG3U1YSwgWTMk=;
        b=BRnG8sLWMAz0OdMq77sX3PpFnXIl8ZSXmDWmfV6GIfZV0/l08ppgVJbTMkD/mtK5nC
         ezbWnorwMlYIS65uPCjGVnpTTp9axmIt1snCF8KR+DJRouIOBmllUCq8CwFFtWQ0YETD
         pIyAfC5WtNCydvFDngX9kyVSohL6j2y4LM06HuA4H9d+G7gVQuL113p9QOTomHULcWgq
         4WVtPumjA9D7rKqReBfU+A5inIQyV21WmTsgOOTMhZuZuulz2BnjUe0k+EZXSBkejkC8
         skO8mktP/vvZ4xPwt9jABICBrVg5Nud/qxdv6yro8sZwi+6jtdcQrmOuk6r146MClqoi
         aoFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751673996; x=1752278796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TwTWoqkPV7gyMrYquUEBim6LYd65earG3U1YSwgWTMk=;
        b=k5b/L8P9S9Qjk9H6y5lRvbIaTD8aWdQ+kPALAdRrnyF7XX8Y2pBYtWQVBVkEsQ0vRo
         lVdnhux4Nvlw4bhqr4g1vikhqI4ho3nWPMB/K7NdxuA1DRb67xiORjGtK/y6cKQI+P+V
         sxWmdrUJTiO76rPJl6wKOoI4zVoctCrWzN0tGkRicdhRm3hA4tNc/ZhMbitMGIaG3Sv3
         dn4Zzez3ocpBBqMX80M6UHlQCaZH6Y3Od06SIX8Ugsx39kOBQNrhjUkJKvPsAW2W8268
         KH4kwLJWy4IdIYUmAGlRRHASY26Ob1lUF6HTeakQyM4FJ1iOEu0IFXC7cu05UeugwnD0
         3PdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+D0LCyqiCwDUj3Vjgl+u74bFdMkhb6aAEWgZODn58XjUjyjVHAFgImXIl/Ho7grL10Yo5wF3rRERJ@vger.kernel.org, AJvYcCUXXBUjPO3+vymnRndxCQdSvWAo5dUxy0CKsBb8h5JP0qfk8s6RDjKZZFO+3a7cRycW4fUPZKBS6f+UVepoKw==@vger.kernel.org, AJvYcCWZb+LibihE33sb+8aCtnUkOmF711YFLC+wGAEj/A0EdXUW24CK1wdR2H92siNPA89jP8aEYGPZHis=@vger.kernel.org, AJvYcCWuk2VY1HF2BT8Z+0JkoNjsOUSP79vbxmUON8DCRSOmK5FvTrlcbpqY5kXsNZRnJAXYvlflKf/k6uw3GczJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxHgN3zPB0wsM9WBZh1n1cfsvArA5zNH6nGVV45c5BgfD0DXPYS
	b7D2iTSS7C7jhFU25fXy44UjZPOF8ONr163xF+YbNe+wJrOnXSPae+oe
X-Gm-Gg: ASbGncuNpBj3aQcyI8jgIfpYRmUkMbBJoB8tTZ62q6gEl3yeKhm+03uvo0JRM2/mz6W
	KxuRJbN1JyjmV+Y0tdffs4Os9/vyy26SmeHc77FjgIZ2K8cTtwqXBvgSmzhEyJZ88D+8RRIAaPf
	ZZn9TKwEo+2facNHtV2Rainsr58Si3Hc3cxjX0eWulp453I1FQs+ZvsuR9+d4nzi3Pw+0aRRTaY
	PiLiCT6CcyfWusvxpFSnm/ootrsHLQkvlGEWegiSkcOqMmHlFcpiTywIETVnuKNgGcyk6DxmcxY
	syMJ1O4S1Yk6v1PEhx9S1FlWZYKAj7sL0kXqVyljB/iqIcW0QBizoU2dqnDiOZUJE1s939Q21rN
	a
X-Google-Smtp-Source: AGHT+IGGepiWMq8fUxN8wR+DXLW7IkcNmsN4ClsJREkHtU4D+josD6m97IlCmcwRCouZrTUZPa8LRg==
X-Received: by 2002:a05:6820:2687:b0:611:e31c:5d23 with SMTP id 006d021491bc7-61392b6ebf0mr2741583eaf.4.1751673996244;
        Fri, 04 Jul 2025 17:06:36 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:5cca:28eb:68f3:4778])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73c9f73518fsm570731a34.12.2025.07.04.17.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 17:06:35 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Fri, 4 Jul 2025 19:06:32 -0500
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
Message-ID: <gwjcw52itbe4uyr2ttwvv2gjain7xyteicox5jhoqjkr23bhef@xfz6ikusckll>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAOQ4uxh-qDahaEpdn2Xs9Q7iBTT0Qx577RK-PrZwzOST_AQqUA@mail.gmail.com>
 <c73wbrsbijzlcfoptr4d6ryuf2mliectblna2hek5pxcuxfgla@7dbxympec26j>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c73wbrsbijzlcfoptr4d6ryuf2mliectblna2hek5pxcuxfgla@7dbxympec26j>

On 25/07/04 03:30PM, John Groves wrote:
> On 25/07/04 10:54AM, Amir Goldstein wrote:
> > On Thu, Jul 3, 2025 at 8:51 PM John Groves <John@groves.net> wrote:
> > >
> > > Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> > > retrieve and cache up the file-to-dax map in the kernel. If this
> > > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> > >
> > > GET_FMAP has a variable-size response payload, and the allocated size
> > > is sent in the in_args[0].size field. If the fmap would overflow the
> > > message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> > > specifies the size of the fmap message. Then the kernel can realloc a
> > > large enough buffer and try again.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  fs/fuse/file.c            | 84 +++++++++++++++++++++++++++++++++++++++
> > >  fs/fuse/fuse_i.h          | 36 ++++++++++++++++-
> > >  fs/fuse/inode.c           | 19 +++++++--
> > >  fs/fuse/iomode.c          |  2 +-
> > >  include/uapi/linux/fuse.h | 18 +++++++++
> > >  5 files changed, 154 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > > index 93b82660f0c8..8616fb0a6d61 100644
> > > --- a/fs/fuse/file.c
> > > +++ b/fs/fuse/file.c
> > > @@ -230,6 +230,77 @@ static void fuse_truncate_update_attr(struct inode *inode, struct file *file)
> > >         fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > 
> > We generally try to avoid #ifdef blocks in c files
> > keep them mostly in h files and use in c files
> >    if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > 
> > also #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > it a bit strange for a bool Kconfig because it looks too
> > much like the c code, so I prefer
> > #ifdef CONFIG_FUSE_FAMFS_DAX
> > when you have to use it
> > 
> > If you need entire functions compiled out, why not put them in famfs.c?
> 
> Perhaps moving fuse_get_fmap() to famfs.c is the best approach. Will try that
> first.
> 
> Regarding '#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)', vs.
> '#ifdef CONFIG_FUSE_FAMFS_DAX' vs. '#if CONFIG_FUSE_FAMFS_DAX'...
> 
> I've learned to be cautious there because the latter two are undefined if
> CONFIG_FUSE_FAMFS_DAX=m. I've been burned by this.
> 
> My original thinking was that famfs made sense as a module, but I'm leaning
> the other way now - and in this series fs/fuse/Kconfig makes it a bool - 
> meaning all three macro tests will work because a bool can't be set to 'm'. 
> 
> So to the extent that I need conditional compilation macros I can switch
> to '#ifdef...'.

Doh. Spirit of full disclosure: this commit doesn't build if
CONFIG_FUSE_FAMFS_DAX is not set (!=y). So the conditionals are at
risk if getting worse, not better. Working on it...

<snip>

Thanks,
John


