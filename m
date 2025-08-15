Return-Path: <linux-fsdevel+bounces-57973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73734B27417
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 02:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 523AF17EC57
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 00:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D982D052;
	Fri, 15 Aug 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ2PvFUa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8FF1B960;
	Fri, 15 Aug 2025 00:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755218322; cv=none; b=UqHoVZcxG4X6dVxePOkwVFldbamDpRpBtijbDQu+9+vWlohrCHyn6vB9eSyicpTFu7pJLobYSL2pJKBooWcham7Rje2rWP0tpACPcpzE9xQGMQaLxvITkLRADFGC6tQJ8AV6GZvVSMq8woNKatZphuQQjp4xM+3PpvDZjfLBBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755218322; c=relaxed/simple;
	bh=Ea9fou7c1vrnx5O99f9GhzFptOQelhwaKbCaMZ5ZMCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oseWraf7Hgab8kfbSJLRZO41PHm4/kRofVFas+zuIZaGXCx6RgwX1cFEHNcnl7y9b+the21j0q+djARbRHn0SwVKbAwpDdmGRCXXfS4ZILj2PzLNL41i4iSUffbZucj5R4StawtNRA3RS0blJZOtWf8gK5vE8METyOnjDmXI7MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZ2PvFUa; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-74381f3a3daso695421a34.1;
        Thu, 14 Aug 2025 17:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755218318; x=1755823118; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8O59GB4USXc4tGmY78iPH5YhwUHKU6zahO+OqK0bSVA=;
        b=gZ2PvFUaGIyHfBEuMayWqNS9gPJFN21bdOAGI968N5wl2Ab4slewTmzgVxzQ7biXqf
         mhoJi85gKfaGGAvPuPuYXV/s1zgvYXm4nr3gfucyTLCCCQSCiYu4bGIqQyBSDmONVhGG
         EtUcZb5/EQLwkROQbv8VJTFsL/Awu595X0z3Diwcs8jgRzkHqD8NkSpHtph7Y+yLfjka
         rZcd4YwV1+62CAjCP+8Zxnffcmq5I7fDz5c3RauTfBdw7cF2+neXe17bDGDpO429Mkta
         2N7kM1bHjJK9GI5UySZpMuX3yf5Jq6oE1yp3wbelZtkNPQO0kiS4xsIvIrbdXhfWNqfW
         W3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755218318; x=1755823118;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O59GB4USXc4tGmY78iPH5YhwUHKU6zahO+OqK0bSVA=;
        b=GWcs6iqFql3GZCES0u/iujIrHX382IKqj/AyaD+9E8U8HMBb/SovQGdIAG4u7pqTW7
         LdQ3DyV5jbOT2SDUAa5SxyLmNFKU58OSEV9kOL6YmhjaUpcvmvND6/naqgQVNWSh/963
         EAYyM7vHg+57X8cwOU7T6wYW+FQV34LTgIYhc2/yZc/5H7I1dE4QpdikAssQdb7p6n+E
         WaqYi+ULx/TXEuV9amOOoNlYXcLNEhXyxpOXj7pPNpz2HEraLubGeYTcppcOQaUajuv+
         KL3LZvKWieeEwW8rVKksR//rresemIV8Ut4Zc86YnIpqklDoLX4N/N6ThqRYHk9bIUGH
         im4A==
X-Forwarded-Encrypted: i=1; AJvYcCV1sQisFGWR6rB4RAFRLiTBzrYDW8gWR/kfkG0L+oS2RlxG3gqiFtGI0NjVEx3/tx8XAW2sGtCyywqnQ7en@vger.kernel.org, AJvYcCV4oIvhuuIl9bWTKj4EvWXcADThNL8Tjs343p9/cFLaqmPFHsDd5eQ3bfzUxHR4ULWKvxZOfBnnek0=@vger.kernel.org, AJvYcCVEzaQm0Hmy0pWxcq9kcIZVh0VFzIUnfecFoMDRtQRDimgI3FU+i/qamZfUOTCKdwWRQiTVOPP4dfSVpqXsCQ==@vger.kernel.org, AJvYcCVl1XhPciZZIxFOF0ifnp935Ce9QTfEFgsTqViM3sBDEAr3MUzjUL/ofCHbh67R+gB5KX9aXeh4/jDF@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmcMGYe7KyQ1YCk+l9EINMOD5Qo6WNS29O7c/rOpaSan3Kad/
	AC2FRxjSDKS6DTSSOI/K0yO6k8c4djqPHUxnC3OMxA19GV9vsJCrsIK7
X-Gm-Gg: ASbGncukFyNf/FulfiIW5TZ1ApjpuyaOUYvzgWZQYonsMYn/U1kjn6LiFvpAYKbGPLO
	uUVodb3YTYg03J/Yo/QCWWfLTd+IUTp8MnTsHCP01AuoCDnVapfwt42945Hi6FumK2mR5E4XI/q
	J6jVwq6OYHyRbxNr1KLM7pOfe5yZkTkoTGXSb67Mmrb+I9N79PON7OBkSCtZybacc322nwHJWp6
	+Jx699VcfzmTWWWV6grkBZ41J2x4cWrBKrllfaqhqyc4HNnNvyIMbAmLUBDmjmpZO3lw3gvk49Y
	Ml6oD7GWVyMnsNYOMbL9gf2Hur+5/G00eJLxbTMreKOo3m133zDM6bTHJsz5U+yVkAkkE/mDLun
	BlacITILu5RXo8wAdGHPSQgFhIAFhGSjDM3f/
X-Google-Smtp-Source: AGHT+IHdBQIMHbjI8HjC4Hs0VHQn/Au/cm0zNwymGKRehv+K7kaOkHcPsH3vTsbvDsKYMT29XFUEsA==
X-Received: by 2002:a05:6830:344a:b0:741:b71b:391c with SMTP id 46e09a7af769-743924362d4mr82234a34.15.1755218318527;
        Thu, 14 Aug 2025 17:38:38 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:c95b:3a76:bbcf:777c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7439203bd13sm33453a34.24.2025.08.14.17.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 17:38:38 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 14 Aug 2025 19:38:36 -0500
From: John Groves <John@groves.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 12/18] famfs_fuse: Plumb the GET_FMAP message/response
Message-ID: <xkr6i7r2vntkl2tigssvmnveepgdipwxewmzdm2xptmsct2odz@eyepa76aepsl>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-13-john@groves.net>
 <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegv6wHOniQE6dgGymq4h1430oc2EyV3OQ2S9DqA20nZZUQ@mail.gmail.com>

On 25/08/14 03:36PM, Miklos Szeredi wrote:
> On Thu, 3 Jul 2025 at 20:54, John Groves <John@groves.net> wrote:
> >
> > Upon completion of an OPEN, if we're in famfs-mode we do a GET_FMAP to
> > retrieve and cache up the file-to-dax map in the kernel. If this
> > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> 
> Nothing to do at this time unless you want a side project:  doing this
> with compound requests would save a roundtrip (OPEN + GET_FMAP in one
> go).

I'm thinking that's an opportunity for improvement after the basic mechanism
is in ;)

> 
> > GET_FMAP has a variable-size response payload, and the allocated size
> > is sent in the in_args[0].size field. If the fmap would overflow the
> > message, the fuse server sends a reply of size 'sizeof(uint32_t)' which
> > specifies the size of the fmap message. Then the kernel can realloc a
> > large enough buffer and try again.
> 
> There is a better way to do this: the allocation can happen when we
> get the response.  Just need to add infrastructure to dev.c.

OK, makes sense. Will take a run at this. Might drop back and go with a hard
limit and relax it later. Famfs fmaps won't grow unbounded near term...

> 
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 6c384640c79b..dff5aa62543e 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -654,6 +654,10 @@ enum fuse_opcode {
> >         FUSE_TMPFILE            = 51,
> >         FUSE_STATX              = 52,
> >
> > +       /* Famfs / devdax opcodes */
> > +       FUSE_GET_FMAP           = 53,
> > +       FUSE_GET_DAXDEV         = 54,
> 
> Introduced too early.

You mean FUSE_GET_DAXDEV I presume (which is not used until 2 patches later? 
Right, will fix.

> 
> > +
> >         /* CUSE specific operations */
> >         CUSE_INIT               = 4096,
> >
> > @@ -888,6 +892,16 @@ struct fuse_access_in {
> >         uint32_t        padding;
> >  };
> >
> > +struct fuse_get_fmap_in {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> 
> As noted, passing size to server really makes no sense.  I'd just omit
> fuse_get_fmap_in completely.

OK, I think I understand; Will rework in v3.

Same idea as "better way" above...

> 
> > +
> > +struct fuse_get_fmap_out {
> > +       uint32_t        size;
> > +       uint32_t        padding;
> > +};
> > +
> >  struct fuse_init_in {
> >         uint32_t        major;
> >         uint32_t        minor;
> > @@ -1284,4 +1298,8 @@ struct fuse_uring_cmd_req {
> >         uint8_t padding[6];
> >  };
> >
> > +/* Famfs fmap message components */
> > +
> > +#define FAMFS_FMAP_MAX 32768 /* Largest supported fmap message */
> > +
> 
> Hmm, Darrick's interface gets one extents at a time.   This one tries
> to get the whole map in one go.
> 
> The single extent thing can be inefficient even for plain block fs, so
> it would be nice to get multiple extents.  The whole map has an
> artificial limit that currently may seem sufficient but down the line
> could cause pain.
> 
> I'm still hoping some common ground would benefit both interfaces.
> Just not sure what it should be.
> 
> Thanks,
> Miklos

At one point Darrick and I discussed retrieving a [file: offset, length] range 
of extents (i.e. request describes what it wants, and reply describes what 
range of the file it covers). I'm not sure it will make sense for famfs to 
retrieve anything but the whole file's map, but I know it might in Darrick's 
case.

I could imagine an update to GET_FMAP (possibly with a differnet name) that 
requests an offset range, and then receives a (possibly different) range that 
is intended to match or exceed the requested range.

It seems like we might be able to share the same command to retrieve extents, 
provided the response starts with a header that allows us to have separate 
(and presumably extensible) payload formats. No doubt Darrick will have 
thoughts on this :D

I don't think we can merge our "fmap" formats; famfs uses either short
extent lists or a format that is efficient for repeating interleave patterns,
and wants to cache the entire fmap.  ...which is not likely to match Darrick's 
pattern, but we might be able to share the same retrieval message/response.

Thanks!
John


