Return-Path: <linux-fsdevel+bounces-47130-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 365C2A99951
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693E9461FB4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B0926A0B1;
	Wed, 23 Apr 2025 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+51yhMk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9F72676D5;
	Wed, 23 Apr 2025 20:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439548; cv=none; b=AbWpTN6TLvSZl3jDX4ONrYYTFQMXnT0p958gulhbOnrkrsHvIYnKu5YHrpkq/UY7K5aJ0E2qJmgJ2JnBu/jn+6WuNeSs6gKJsIVt6lMl/tSIMwsJCi+yHHvMRc8rS2RNlKUYRqXN1om1gyiIu+wLGS8dMGNfp/n2U0N7WpVS4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439548; c=relaxed/simple;
	bh=Hjyfm1RDvnrb3r506AIGW33tNSvbha+9sei4TDw4B1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQGYIpD1FVJijeFf9vkV2gMjPtWbpvhjFxdHciFZL6+PKxh4zmiC3xtOkpyaGIxYzYNsmsdjcHLl4plkJcUpPc6PRcANoFCZDOUkgSEKCyQqDbxbDYQw3+Jf47AhbUWCKhqI8qzoeJqwJiX7XPzmtDWbyJU/PBd2VNUVZfw6Y1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+51yhMk; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-401be80368fso75087b6e.1;
        Wed, 23 Apr 2025 13:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745439546; x=1746044346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g4Ay+yxjyvrecwm+hKWiGn1hvCte1K1DikL5dI6YUSI=;
        b=I+51yhMkWpGBn4W94ykbCDPRempOHgibaJPBj4itAhmrYlGF7CoKhdGSSbWWoLfznC
         2gAnVVeOhXMyg0bt/U2qd4mjRcGADOQWu1m+4pqsDMvVqvpgYV+1h0JjLQgV99Z+JhmI
         PuX/wj1RYQavj0Eq6YOYY4FNjkIyCrAx3sgsyvAcK0somdw++4LqmsScoEksPkzhCW3o
         6v/orlEkw+gviAMaoYg227EAnS92UgePEfMjaTE5geKxs6U8GD4sn4KZu5vIl+zHR4gz
         hmkjDq7glnbpjGv8Rg/qcx+ZG1ojt2faqJgCOpQYw0W8MLtzdJG3a7IL3Vji/tvpglUD
         +/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439546; x=1746044346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g4Ay+yxjyvrecwm+hKWiGn1hvCte1K1DikL5dI6YUSI=;
        b=NQxIUZAnA4mW8stgQ2iDm2yLBj4+4HcF9uMCY1u/lq2zAljA/9AZM5cFcO5O63MLQx
         zkQxgVUIwYtUYxhXbd3mZs21V2RnFlk1klZ0Jh7B+nJKRdTrP4mlRC+CFFY5NB3yoH5V
         bSOyls2b9ybFPlATADZ4O3A+041qNC+f2XiuMEGzLmQ5vOeSF0nyMO/vSNZhZlzAEn5G
         lF8llXAndnVHgQ5YQMlruZDhEmuvizhtmxa9NB6gMt5JtRVxJx4WVCled9Qo7kV0wKUF
         KslnYIPl6vvFc5+/u4p2ixj8RYCChUPzrYUdcZU6qFVJcHCGsgg5zsLRK49MQewg7p4y
         TWKA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Gj3vrms3LO5LyEwxr+o6eEQUgC8a6KLWQBjNmEhHnLZoPNPR0/8KmQF6kusV8xsGJUs8D4P/B/I=@vger.kernel.org, AJvYcCWZXWFz4wBIvlQ7zc7G4FymeDc8CStfuondxnA4Cb6NQAeOlm/aMdT4Vm5DvnBO1vxXU0IhNhteZg5z4AWY@vger.kernel.org, AJvYcCWnibpx9HBUPf1HHngTqNCowhZuThTg0NWHItDLK7M0QEHpvTorvgk3xeIEdrCa101y6PT20Je5438GRc70VA==@vger.kernel.org, AJvYcCXzJ2gv3kwHjNJIpjQmuTAfBR5ym9twJd/CPjzfburZZk/Uh0oTAoEa/IPqkvLWLY9ZAWoBm2DrTSGJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy9rznmEQ+iW8XVCqYmRbhhAwi4P3fpR+c/Q1XdquzVo4bv95U
	pgwWDuSs7rSA8r3Pxx2Zg4VxLKuL8pxtCUbOZtlFDwHNxzheSGRK
X-Gm-Gg: ASbGncuQ8sZPBIfH+7puBz0ko1mHuDxZuBVe6lKYG2m02gI4A+QipPcpUn/8qhR3JA5
	5Kgc0ZQUC5h2o54SblStWG2vcJyr4XDaIIxK+zF1I1KZY5vk0IBN0xh2/GfQ3XYsUQqAcEz9Sn/
	1w0yLOmv5glxKvFggoM9gLGDY5/pYWsEjRPBJ1nUyRPQoi2whBqJJODbXJOgNzzoK0mZTn+LEoQ
	Ku5V4cWgK2Ev+U4PZHpe1zZ9BYadusKI+AW6/RJn4RfYrFiCTeFyQSbVfUHXt1zH8g06wUBb/gP
	kIFQ+rbbPZHbE6x8QHIK5FQPUOJLNVGDhRo9nxSQSebiiJtWhk07r6HmpCFY5+fEYiOIoLs=
X-Google-Smtp-Source: AGHT+IEoll/IipbPMTUh46dRuaEBH4kvJbYYprGZYgOTzElLJasG3TcogRN8wLTOCXAPApRgQMleOQ==
X-Received: by 2002:a05:6808:1c0a:b0:400:fa6b:5dfb with SMTP id 5614622812f47-401eb3d2997mr176263b6e.36.1745439545564;
        Wed, 23 Apr 2025 13:19:05 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:44cc:5f45:d31b:d18f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401bf09a0a3sm2721677b6e.42.2025.04.23.13.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:19:05 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 23 Apr 2025 15:19:02 -0500
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 11/19] famfs_fuse: Basic famfs mount opts
Message-ID: <4lknmgdq4d6xlmejrddwumpxuwog3l5iwtmoaet7w6swbtc37i@33xmye5u3g5a>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-12-john@groves.net>
 <CAJnrk1a40QE+8q-PTTP6GgpDO9d9i_biuN8zk-KSEEiK7S34kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1a40QE+8q-PTTP6GgpDO9d9i_biuN8zk-KSEEiK7S34kA@mail.gmail.com>

On 25/04/22 06:51PM, Joanne Koong wrote:
> On Sun, Apr 20, 2025 at 6:34 PM John Groves <John@groves.net> wrote:
> >
> > * -o shadow=<shadowpath>
> > * -o daxdev=<daxdev>
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/fuse_i.h |  8 +++++++-
> >  fs/fuse/inode.c  | 25 ++++++++++++++++++++++++-
> >  2 files changed, 31 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index b2c563b1a1c8..931613102d32 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -580,9 +580,11 @@ struct fuse_fs_context {
> >         unsigned int blksize;
> >         const char *subtype;
> >
> > -       /* DAX device, may be NULL */
> > +       /* DAX device for virtiofs, may be NULL */
> >         struct dax_device *dax_dev;
> >
> > +       const char *shadow; /* famfs - null if not famfs */
> > +
> >         /* fuse_dev pointer to fill in, should contain NULL on entry */
> >         void **fudptr;
> >  };
> > @@ -938,6 +940,10 @@ struct fuse_conn {
> >         /**  uring connection information*/
> >         struct fuse_ring *ring;
> >  #endif
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       char *shadow;
> > +#endif
> >  };
> >
> >  /*
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 5c6947b12503..7f4b73e739cb 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -766,6 +766,9 @@ enum {
> >         OPT_ALLOW_OTHER,
> >         OPT_MAX_READ,
> >         OPT_BLKSIZE,
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       OPT_SHADOW,
> > +#endif
> >         OPT_ERR
> >  };
> >
> > @@ -780,6 +783,9 @@ static const struct fs_parameter_spec fuse_fs_parameters[] = {
> >         fsparam_u32     ("max_read",            OPT_MAX_READ),
> >         fsparam_u32     ("blksize",             OPT_BLKSIZE),
> >         fsparam_string  ("subtype",             OPT_SUBTYPE),
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       fsparam_string("shadow",                OPT_SHADOW),
> > +#endif
> >         {}
> >  };
> >
> > @@ -875,6 +881,15 @@ static int fuse_parse_param(struct fs_context *fsc, struct fs_parameter *param)
> >                 ctx->blksize = result.uint_32;
> >                 break;
> >
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       case OPT_SHADOW:
> > +               if (ctx->shadow)
> > +                       return invalfc(fsc, "Multiple shadows specified");
> > +               ctx->shadow = param->string;
> > +               param->string = NULL;
> > +               break;
> > +#endif
> > +
> >         default:
> >                 return -EINVAL;
> >         }
> > @@ -888,6 +903,7 @@ static void fuse_free_fsc(struct fs_context *fsc)
> >
> >         if (ctx) {
> >                 kfree(ctx->subtype);
> > +               kfree(ctx->shadow);
> >                 kfree(ctx);
> >         }
> >  }
> > @@ -919,7 +935,10 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
> >         else if (fc->dax_mode == FUSE_DAX_INODE_USER)
> >                 seq_puts(m, ",dax=inode");
> >  #endif
> > -
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       if (fc->shadow)
> > +               seq_printf(m, ",shadow=%s", fc->shadow);
> > +#endif
> >         return 0;
> >  }
> >
> > @@ -1825,6 +1844,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
> >         sb->s_root = root_dentry;
> >         if (ctx->fudptr)
> >                 *ctx->fudptr = fud;
> > +
> > +#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> > +       fc->shadow = kstrdup(ctx->shadow, GFP_KERNEL);
> > +#endif
> 
> Since this is kstrdup-ed, I think you meant to also kfree this in
> fuse_conn_put() when the last refcount on fc gets dropped?

Good catch Joanne! That's queued in my "-next" branch.

Thanks,
John


