Return-Path: <linux-fsdevel+bounces-47131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA6A99964
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 22:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82C47A45EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 20:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1532526B970;
	Wed, 23 Apr 2025 20:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn7/+6qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA619268FF6;
	Wed, 23 Apr 2025 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745439793; cv=none; b=RkyxU2/mRJFAQTokbr1SmRCkXOOHQNkzzK1GLgsIPOjKAZj8/0TzrrTVeTs/TSZ47QuQGOx2RNhaK0qfrMbqxPC2vNF1JilQE5MY8hy45jh7cS/sHaH/iy8LrN2Q/qgDUpQiySzFeMdgZIZPyERhqTHsKKsTdLnngzTP5CpAbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745439793; c=relaxed/simple;
	bh=9FXiIL8sGXQRZbcF0o7E4cI6TAMvfaP3y1StfzQkbXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzjyFmHnFlPPWgutBLHvGL/4Hwd2H7DbtExpUHqjEmxRZjFz2RRSlaEhgshgKPg7Ctg6D8DHzf45VqHCXci0fc7StqyhsrzzgV3Pb1cmhUkehvy3bvYVWP3Q6cTqUWPWRPsssTiWwiM5WCiEgbeAKPh81EsOLpxDE/0oq5XtkFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn7/+6qi; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fea67e64caso170538b6e.2;
        Wed, 23 Apr 2025 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745439791; x=1746044591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97lECeIymX5vGttM40ZC9LxwILKEadxdlNBvDo4t1iE=;
        b=Yn7/+6qi3HsoQgfOj1vPtUL3AiF09BLevy+xjGkOesiDk+lqkbxusm/oefCd9BzOYJ
         i1I8qCH9TIcZkXGorDlyj170XiinQE7/um4iInjgpY63Zj9GT3b/JQK0aRPjVhyNFSxI
         +LF1gBaixlnqvIcTuPSGXSwqDp0YJoZ01zKfJ+qcB/wB6wzMtxhowQg+FwwDjJkAKlPK
         A+mQheZtYXV3OOKxuNOxPGWL8W73R9WK+r+ggEFFTORXCOxsv2vlQ3iaMznvPLCPKq7b
         zniPvazekWv0aW7IgbuVWySqyWHkN2Z+0FK9oLuBESmgQ8QLZ+9pxc2aKN/gUeKXZZ56
         Yuuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745439791; x=1746044591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97lECeIymX5vGttM40ZC9LxwILKEadxdlNBvDo4t1iE=;
        b=P0sPPffJ5JAqH3UTC7/+ExdB4CTCzHMtKeGZi890aIlvSBoq4x8UFuZ0YLX2OCsNOa
         1W8szcOdYxu2+L8yKAxC1j2xuHTTJBUx8r4gOllu4/UC+miGUH036ulCEmyuQK2sm7L7
         qa4ZhIhi8JZZEGt54KZREPNDabnhT0FvjKyiRRI9JIzdlJO+PpDeO7j78rqXWh0l4jbq
         +z/a590mQEMOPqkJeU6thrSmwqPqtpBAmdmBH1nsRmjGAE5rJBwVYPZeKXmoYZnYA0OA
         MUO7QDy6+bZlxzljB+2NTjX81dSEuXmUjMrgqLOLMPoMvZtLVTNox0XdqBw7av8vyaV9
         jTqA==
X-Forwarded-Encrypted: i=1; AJvYcCUUOzv61KHrmWhbkDrdfUR2WKep1Gyp/iAo013/Uvofstlw45wzO0YjX8l0I3zyuWoox8siU4sUNKls8CgU@vger.kernel.org, AJvYcCVhEm0TiumLmIAwYmvFgt5zimidTxWIf+6SA9C85n3RUaAqSFjxZoaXWKuQ98HzU6BoL8XOtMnUloRY@vger.kernel.org, AJvYcCW1fvHxsZrFamFBWH3H0jbZV3almgRnSrJDa3VMTPDdZ2jeysJAG/lEWPFOBuQ7D4b7v+NBx3rwlcQ=@vger.kernel.org, AJvYcCWbQnuTZPytgqvX5ZlHtV+7qJCwyxdLpTRU+faSlc0Tti+8PaU+X/0j33ThvPZF6t1iIIFQO0hgFdCogqzeyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyY7H4CStUG1/7GzqRL4YMm38REYxLpp1+tHCRl8/qj9Aa08ogN
	XNmlfCvY3Mz97ino+YRDzZFzADWYYRcoI+CWkFYHum2GntdHOnpG
X-Gm-Gg: ASbGncs0jyIpwH4t29MjPBf7FSxxpZJrmjxYzDrtA9Gt8Wu33pQoLbB6RYGoMGtLdTU
	S/+kjSJb3qpVgmyymxUzTTJGH65jqINRH+gYM9sdnRUD8kVkq5VQYfZVmMLuZSi4cXXAo7DJK+q
	bEZEFD+XcFH/wXzeuTqbMl7lpxoQh2vHVpeldn5tbokBvTAiFoMZAh01OxlNGmj5aTSjYjb3dm1
	6icetdSPZfP/9Gw7wmneri+9XdanLwKDaVL6ZDScmYljh6VOY04OnRlxmcDnP+xRkGEtILw1yT2
	s+Bxdemz9cc3vlO+yQ7V199oR8pZsLVj0NVD2yljaAlzdUN/HTf3qJCO7jAa
X-Google-Smtp-Source: AGHT+IGEiSY1ULEDyb+dL3+puS1rpFXM4in/5b9Ry3B8H9erXdcwyUm6OyQs+f8oqghalhCsVGHxEQ==
X-Received: by 2002:a05:6808:384a:b0:3f9:56ff:1468 with SMTP id 5614622812f47-401eb2570bamr216304b6e.24.1745439790720;
        Wed, 23 Apr 2025 13:23:10 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:44cc:5f45:d31b:d18f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401becc2294sm2790759b6e.0.2025.04.23.13.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 13:23:10 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 23 Apr 2025 15:23:07 -0500
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
Subject: Re: [RFC PATCH 10/19] famfs_fuse: Basic fuse kernel ABI enablement
 for famfs
Message-ID: <qjwm7z3zr4njddcbnt4dqbl3zof4nck5ovfysdopeogcmizsn7@7fei7dldwe6x>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-11-john@groves.net>
 <CAJnrk1aROUeJY2g8vHtTgVc=mb+1+7jhJE=B3R0qV_=o6jjNTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aROUeJY2g8vHtTgVc=mb+1+7jhJE=B3R0qV_=o6jjNTA@mail.gmail.com>

On 25/04/22 06:36PM, Joanne Koong wrote:
> On Sun, Apr 20, 2025 at 6:34 PM John Groves <John@groves.net> wrote:
> >
> > * FUSE_DAX_FMAP flag in INIT request/reply
> >
> > * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
> >   famfs-enabled connection
> >
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/fuse_i.h          | 3 +++
> >  fs/fuse/inode.c           | 5 +++++
> >  include/uapi/linux/fuse.h | 2 ++
> >  3 files changed, 10 insertions(+)
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index e04d160fa995..b2c563b1a1c8 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -870,6 +870,9 @@ struct fuse_conn {
> >         /* Use io_uring for communication */
> >         unsigned int io_uring;
> >
> > +       /* dev_dax_iomap support for famfs */
> > +       unsigned int famfs_iomap:1;
> > +
> >         /** Maximum stack depth for passthrough backing files */
> >         int max_stack_depth;
> >
> > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > index 29147657a99f..5c6947b12503 100644
> > --- a/fs/fuse/inode.c
> > +++ b/fs/fuse/inode.c
> > @@ -1392,6 +1392,9 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
> >                         }
> >                         if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
> >                                 fc->io_uring = 1;
> > +                       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX) &&
> > +                                      flags & FUSE_DAX_FMAP)
> > +                               fc->famfs_iomap = 1;
> >                 } else {
> >                         ra_pages = fc->max_read / PAGE_SIZE;
> >                         fc->no_lock = 1;
> > @@ -1450,6 +1453,8 @@ void fuse_send_init(struct fuse_mount *fm)
> >                 flags |= FUSE_SUBMOUNTS;
> >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> >                 flags |= FUSE_PASSTHROUGH;
> > +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > +               flags |= FUSE_DAX_FMAP;
> >
> >         /*
> >          * This is just an information flag for fuse server. No need to check
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 5e0eb41d967e..f9e14180367a 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -435,6 +435,7 @@ struct fuse_file_lock {
> >   *                 of the request ID indicates resend requests
> >   * FUSE_ALLOW_IDMAP: allow creation of idmapped mounts
> >   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
> > + * FUSE_DAX_FMAP: kernel supports dev_dax_iomap (aka famfs) fmaps
> >   */
> >  #define FUSE_ASYNC_READ                (1 << 0)
> >  #define FUSE_POSIX_LOCKS       (1 << 1)
> > @@ -482,6 +483,7 @@ struct fuse_file_lock {
> >  #define FUSE_DIRECT_IO_RELAX   FUSE_DIRECT_IO_ALLOW_MMAP
> >  #define FUSE_ALLOW_IDMAP       (1ULL << 40)
> >  #define FUSE_OVER_IO_URING     (1ULL << 41)
> > +#define FUSE_DAX_FMAP          (1ULL << 42)
> 
> There's also a protocol changelog at the top of this file that tracks
> any updates made to the uapi. We should probably also update that to
> include this?

Another good catch, thanks Joanne! Adding that in -next

John


