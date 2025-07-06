Return-Path: <linux-fsdevel+bounces-54031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B54EAFA6AB
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 19:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570EE3AF397
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Jul 2025 17:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68DA288C81;
	Sun,  6 Jul 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNYiNH+2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4FE202960;
	Sun,  6 Jul 2025 17:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751821629; cv=none; b=Y0GaCfJRIkzar1YOPl+EwHA3/BvBd5K7SIK42mCba9O0MNK25Dri/LfxVW8sBYPFg1K/zD8RXx7QJKmJ9wkJsfvawAGQF12iDOXEBEoy3vz0pZlxMZ5AVT9KHoJ7DFvvU8C7/t/Qo2d9G3D7DXw3AwcAMj6jjIZ9UEuJPUYUJwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751821629; c=relaxed/simple;
	bh=V6gT+7sJa2KXWr5XQWhkiaCIBi9O2KT8JuUGcZ8osjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYXiuEMrCzarnJhF5Q9Ct2kS1jIj7EpwLCHiqQ7gtuE/Szq4/j+Hrj7P3u/loCswz1QrIB9+VxEZ3RVpK/D/w2rL4TDsg2C953EOVWNvr/v8iSVmbgC98kPeA+a9O6U02L0GoDZFjTNRZw2BTSRPbIRvC2u8NoFtUt+Mb0+1+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNYiNH+2; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2f3dab2a2a9so2105629fac.2;
        Sun, 06 Jul 2025 10:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751821625; x=1752426425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5IMnY0+1bhAhwOIf3AOBIfK74NdjCp0aIZhFzBuCW0=;
        b=CNYiNH+23yJY96uVsjMwie7jpzsUaG8UUAUIi8uWm1YbuXE0h6PEtaHNNEcQsljcYs
         iWC1hFdH0aQLN7A28CJcYZQRSG9nts0Q2szINe7/vmTcc7rbzBM09x+dwqaLTaAcb6hG
         jxu1aD13BMnMtgoWOXonxpiY+Vv9bmpH52MXh84ZFdfepO+Dosz2Jet0psnpbp2EYu/A
         Yyb3z+lFmAO9ZgFuHDVVKHW+4j2ZVD8soCTMLfosHxWSgHVMLHgT/CVnM2yqgnOGPQVa
         Oj7A5RgMQwBaKVETqRImxPtczViaPPc8qnYBpoh09zGVhJdWzoRL+cKZk/TczIn4CnaY
         0C6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751821625; x=1752426425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5IMnY0+1bhAhwOIf3AOBIfK74NdjCp0aIZhFzBuCW0=;
        b=cPkT2erB2aKMyH/K2/E4SecKsxhJYbs+8jG1sgMvoc9v8FqGfNQkdyKG3WKSUiJGTl
         XTwKAui0XhMT3JRX5hNohrTqEH+jv2qwqqN9DLAwnrbUJsy9Q7NUaVO+IJU8wmeX0n/8
         t9tP+gQvMvF6xOFDzUXaynjoeK0iOOV0mdXPaXm7D6eU9Y+cXtr9JEn4lvBCVKA6hTo7
         ZGgzlTiwLNvlG7t8fJyOulZkEOCEKO0248Ts49bTribUQ+LkQ/1CKkoAO5lbG7Jjbbxk
         n/9yhD2u78NW2soiMoDxq9nHBzLOzKXMdM6DTuKjUzrqU36g9+qe2R9DDq0GTfdc4jNA
         81TA==
X-Forwarded-Encrypted: i=1; AJvYcCV7gDD1+adPwTt6ti31hrbBEn/uWtSJC4Cx88/t0t5O1sFyhkVp7+z22fQN9u9Abk2gF2PjGU/YeAK8XnmU1A==@vger.kernel.org, AJvYcCWcgUbTbAjSa17Yk/w63LrDr2R5X9PM5aZfiFdk9EvBoq950BpH3r++R0XidFNUk3KMWDLoCq+K4ik=@vger.kernel.org, AJvYcCX1/H/eKz4n7GFjqNKJ2T2jz1nclYsL1wqwhEhrG+KSK4fzf8TFsazZWPKi7tZ+T0lZ74NGcXyBbU6UYi3a@vger.kernel.org, AJvYcCX9H8ts/crC1XdemxxKpJZf5RpgayiIoceIx+xJfgnqkuuDg1xW38dGINrkpW3QUWZuUQIVfKZ27RPL@vger.kernel.org
X-Gm-Message-State: AOJu0Yxft5HcmH8Ux+mN27Z2MmdYub9HNAJIbUTTtHDTiRuvf7Apiy/b
	4NZ+8h/iAa5rFwvRV9cvdGZI1yaQ3wdPkgvO/L62Uhxm5DTQviSr5aKy
X-Gm-Gg: ASbGnctLaW0LyMt81LeCQGoqhd+g+IVqKE8Kb1O4LCc3+/x/LLhpMQbXeUkZrrhrd1e
	nto7JWIJbQ6duPeuoInFLvFQR3n1OGpIO3FOZf54jc1CcB8xK+0VAyG5cZ7g/Xv3jQNNP93ygje
	/6aZaL7yuBBoQz6cOMZtu0IdLCVN+hJrk0lHHH6h5XsvYDi0bl4GgnEotvzbhCbags5UvZqc4fj
	O2NqSLhnjxTceyLLkGAc1nrh1gjM/wAhesb42OWA59Ct4MMAB9gMZiX57b1rRbBjd64phWDiUDa
	HI/echnGL/fBRCLO5yRJkYg40foFRtcLJIlmbICLuaY/PlF7XsyzrJZkYXPSqYqFvGqPxJNseVH
	6
X-Google-Smtp-Source: AGHT+IHqUvSCsufD0rlhHmYE4JqiKvJOkr111yzD4PJVNwoY73SE3XB5lbMVDtDTB8FNjR+DpDanXg==
X-Received: by 2002:a05:6870:e08f:b0:2cf:bc73:7bb2 with SMTP id 586e51a60fabf-2f7afdb1d76mr4318616fac.14.1751821624631;
        Sun, 06 Jul 2025 10:07:04 -0700 (PDT)
Received: from groves.net ([2603:8080:1500:3d89:7c8a:3293:5fd3:bd25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2f7901a62f5sm1750012fac.29.2025.07.06.10.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 10:07:03 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Sun, 6 Jul 2025 12:07:01 -0500
From: John Groves <John@groves.net>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
	Amir Goldstein <amir73il@gmail.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC V2 14/18] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <5rw4mc7kqbxic3iunmwz5s3zv4sl2xlw3qdwndtmnxceqsrdyo@uxu252gg5t2a>
References: <20250703185032.46568-1-john@groves.net>
 <20250703185032.46568-15-john@groves.net>
 <20250704142037.00002717@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704142037.00002717@huawei.com>

On 25/07/04 02:20PM, Jonathan Cameron wrote:
> On Thu,  3 Jul 2025 13:50:28 -0500
> John Groves <John@Groves.net> wrote:
> 
> > * The new GET_DAXDEV message/response is enabled
> > * The command it triggered by the update_daxdev_table() call, if there
> >   are any daxdevs in the subject fmap that are not represented in the
> >   daxdev_dable yet.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> 
> More drive by stuff you can ignore for now if you like.

Always appreciated...

> 
> > ---
> >  fs/fuse/famfs.c           | 227 ++++++++++++++++++++++++++++++++++++++
> >  fs/fuse/famfs_kfmap.h     |  26 +++++
> >  fs/fuse/fuse_i.h          |   1 +
> >  fs/fuse/inode.c           |   4 +-
> >  fs/namei.c                |   1 +
> >  include/uapi/linux/fuse.h |  18 +++
> >  6 files changed, 276 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index 41c4d92f1451..f5e01032b825 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> 
> > +/**
> > + * famfs_fuse_get_daxdev() - Retrieve info for a DAX device from fuse server
> > + *
> > + * Send a GET_DAXDEV message to the fuse server to retrieve info on a
> > + * dax device.
> > + *
> > + * @fm:     fuse_mount
> > + * @index:  the index of the dax device; daxdevs are referred to by index
> > + *          in fmaps, and the server resolves the index to a particular daxdev
> > + *
> > + * Returns: 0=success
> > + *          -errno=failure
> > + */
> > +static int
> > +famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
> > +{
> > +	struct fuse_daxdev_out daxdev_out = { 0 };
> > +	struct fuse_conn *fc = fm->fc;
> > +	struct famfs_daxdev *daxdev;
> > +	int err = 0;
> > +
> > +	FUSE_ARGS(args);
> > +
> > +	/* Store the daxdev in our table */
> > +	if (index >= fc->dax_devlist->nslots) {
> > +		pr_err("%s: index(%lld) > nslots(%d)\n",
> > +		       __func__, index, fc->dax_devlist->nslots);
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	args.opcode = FUSE_GET_DAXDEV;
> > +	args.nodeid = index;
> > +
> > +	args.in_numargs = 0;
> > +
> > +	args.out_numargs = 1;
> > +	args.out_args[0].size = sizeof(daxdev_out);
> > +	args.out_args[0].value = &daxdev_out;
> > +
> > +	/* Send GET_DAXDEV command */
> > +	err = fuse_simple_request(fm, &args);
> > +	if (err) {
> > +		pr_err("%s: err=%d from fuse_simple_request()\n",
> > +		       __func__, err);
> > +		/*
> > +		 * Error will be that the payload is smaller than FMAP_BUFSIZE,
> > +		 * which is the max we can handle. Empty payload handled below.
> > +		 */
> > +		goto out;
> > +	}
> > +
> > +	down_write(&fc->famfs_devlist_sem);
> 
> Worth thinking about guard() in this code in general.
> Simplify some of the error paths at least.

Thinking about it. Not sure I'll go there yet; I find the guard macros 
a bit confusing...

> 
> > +
> > +	daxdev = &fc->dax_devlist->devlist[index];
> > +
> > +	/* Abort if daxdev is now valid */
> > +	if (daxdev->valid) {
> > +		up_write(&fc->famfs_devlist_sem);
> > +		/* We already have a valid entry at this index */
> > +		err = -EALREADY;
> > +		goto out;
> > +	}
> > +
> > +	/* Verify that the dev is valid and can be opened and gets the devno */
> > +	err = famfs_verify_daxdev(daxdev_out.name, &daxdev->devno);
> > +	if (err) {
> > +		up_write(&fc->famfs_devlist_sem);
> > +		pr_err("%s: err=%d from famfs_verify_daxdev()\n", __func__, err);
> > +		goto out;
> > +	}
> > +
> > +	/* This will fail if it's not a dax device */
> > +	daxdev->devp = dax_dev_get(daxdev->devno);
> > +	if (!daxdev->devp) {
> > +		up_write(&fc->famfs_devlist_sem);
> > +		pr_warn("%s: device %s not found or not dax\n",
> > +			__func__, daxdev_out.name);
> > +		err = -ENODEV;
> > +		goto out;
> > +	}
> > +
> > +	daxdev->name = kstrdup(daxdev_out.name, GFP_KERNEL);
> > +	wmb(); /* all daxdev fields must be visible before marking it valid */
> > +	daxdev->valid = 1;
> > +
> > +	up_write(&fc->famfs_devlist_sem);
> > +
> > +out:
> > +	return err;
> > +}
> > +
> > +/**
> > + * famfs_update_daxdev_table() - Update the daxdev table
> > + * @fm   - fuse_mount
> > + * @meta - famfs_file_meta, in-memory format, built from a GET_FMAP response
> > + *
> > + * This function is called for each new file fmap, to verify whether all
> > + * referenced daxdevs are already known (i.e. in the table). Any daxdev
> > + * indices that referenced in @meta but not in the table will be retrieved via
> > + * famfs_fuse_get_daxdev() and added to the table
> > + *
> > + * Return: 0=success
> > + *         -errno=failure
> > + */
> > +static int
> > +famfs_update_daxdev_table(
> > +	struct fuse_mount *fm,
> > +	const struct famfs_file_meta *meta)
> > +{
> > +	struct famfs_dax_devlist *local_devlist;
> > +	struct fuse_conn *fc = fm->fc;
> > +	int err;
> > +	int i;
> > +
> > +	/* First time through we will need to allocate the dax_devlist */
> > +	if (!fc->dax_devlist) {
> > +		local_devlist = kcalloc(1, sizeof(*fc->dax_devlist), GFP_KERNEL);
> > +		if (!local_devlist)
> > +			return -ENOMEM;
> > +
> > +		local_devlist->nslots = MAX_DAXDEVS;
> > +
> > +		local_devlist->devlist = kcalloc(MAX_DAXDEVS,
> > +						 sizeof(struct famfs_daxdev),
> > +						 GFP_KERNEL);
> > +		if (!local_devlist->devlist) {
> > +			kfree(local_devlist);
> > +			return -ENOMEM;
> > +		}
> > +
> > +		/* We don't need the famfs_devlist_sem here because we use cmpxchg... */
> > +		if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) != NULL) {
> > +			kfree(local_devlist->devlist);
> > +			kfree(local_devlist); /* another thread beat us to it */
> > +		}
> > +	}
> > +
> > +	down_read(&fc->famfs_devlist_sem);
> > +	for (i = 0; i < fc->dax_devlist->nslots; i++) {
> > +		if (meta->dev_bitmap & (1ULL << i)) {
> Flip for readability.
> 		if (!(meta->dev_bitmap & (1ULL << i))
> 			continue;

I like it - done..

> 
> Or can we use bitmap_from_arr64() and
> for_each_set_bit() to optimize this a little.

Could do, but I feel like that's a bit harder [for me] to read.

> 
> > +			/* This file meta struct references devindex i
> > +			 * if devindex i isn't in the table; get it...
> > +			 */
> > +			if (!(fc->dax_devlist->devlist[i].valid)) {
> > +				up_read(&fc->famfs_devlist_sem);
> > +
> > +				err = famfs_fuse_get_daxdev(fm, i);
> > +				if (err)
> > +					pr_err("%s: failed to get daxdev=%d\n",
> > +					       __func__, i);
> Don't want to surface that error?

I'm thinking on that. Failure to retrieve a dax device is currently
game over for the whole mount (because there is just one of them currently,
and it's retrieved to get access to the superblock and metadata log).
Once additional daxdevs are enabled there will be more nuance, but any
file that references a 'missing' dax device will be non-operative, so
putting something in the log makes sense to me.

I may surface it a bit differently, but I think it needs to surface.

> > +
> > +				down_read(&fc->famfs_devlist_sem);
> > +			}
> > +		}
> > +	}
> > +	up_read(&fc->famfs_devlist_sem);
> > +
> > +	return 0;
> > +}
> > +
> > +/***************************************************************************/
> 
> ?

One of my tics is divider comments. Will probably drop it though ;)

> 
> > diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> > index ce785d76719c..f79707b9f761 100644
> > --- a/fs/fuse/famfs_kfmap.h
> > +++ b/fs/fuse/famfs_kfmap.h
> > @@ -60,4 +60,30 @@ struct famfs_file_meta {
> >  	};
> >  };
> >  
> > +/**
> > + * famfs_daxdev - tracking struct for a daxdev within a famfs file system
> > + *
> > + * This is the in-memory daxdev metadata that is populated by
> > + * the responses to GET_FMAP messages
> > + */
> > +struct famfs_daxdev {
> > +	/* Include dev uuid? */
> > +	bool valid;
> > +	bool error;
> > +	dev_t devno;
> > +	struct dax_device *devp;
> > +	char *name;
> > +};
> > +
> > +#define MAX_DAXDEVS 24
> > +
> > +/**
> > + * famfs_dax_devlist - list of famfs_daxdev's
> 
> Run kernel-doc script over these. It gets grumpy about partial
> documentation.

Thank you... I just did, and fixed a couple of issues it complained about.

> 
> > + */
> > +struct famfs_dax_devlist {
> > +	int nslots;
> > +	int ndevs;
> > +	struct famfs_daxdev *devlist; /* XXX: make this an xarray! */
> > +};
> > +
> >  #endif /* FAMFS_KFMAP_H */
> 
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index ecaaa62910f0..8a81b6c334fe 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -235,6 +235,9 @@
> >   *      - struct fuse_famfs_simple_ext
> >   *      - struct fuse_famfs_iext
> >   *      - struct fuse_famfs_fmap_header
> > + *    - Add the following structs for the GET_DAXDEV message and reply
> > + *      - struct fuse_get_daxdev_in
> > + *      - struct fuse_get_daxdev_out
> >   *    - Add the following enumerated types
> >   *      - enum fuse_famfs_file_type
> >   *      - enum famfs_ext_type
> > @@ -1351,6 +1354,20 @@ struct fuse_famfs_fmap_header {
> >  	uint64_t reserved1;
> >  };
> >  
> > +struct fuse_get_daxdev_in {
> > +	uint32_t        daxdev_num;
> > +};
> > +
> > +#define DAXDEV_NAME_MAX 256
> > +struct fuse_daxdev_out {
> > +	uint16_t index;
> > +	uint16_t reserved;
> > +	uint32_t reserved2;
> > +	uint64_t reserved3; /* enough space for a uuid if we need it */
> 
> Odd place for the comment. If it just refers to reserved3 then nope
> not enough space.  If you mean that and reserved4 then fiar enough
> but that's not obvious as it stands.

Good point. Moved it above in -next

> 
> > +	uint64_t reserved4;
> > +	char name[DAXDEV_NAME_MAX];
> > +};
> > +
> >  static inline int32_t fmap_msg_min_size(void)
> >  {
> >  	/* Smallest fmap message is a header plus one simple extent */
> > @@ -1358,4 +1375,5 @@ static inline int32_t fmap_msg_min_size(void)
> >  		+ sizeof(struct fuse_famfs_simple_ext));
> >  }
> >  
> > +
> Stray change.  Worth a quick scrub to clean these out (even in an RFC) as they just add
> noise to the bits you want people to look at!

Yup, will fix.

BTW, public service announcement: I've discovered the awesomeness of jj
(aka ju jutsu, aka jj-vcs) as a wrapper for git that is great at the kind
of rebase problems that come with factoring and re-factoring patch set
branches. Without jj, more stuff like this would have slipped through ;)

<snip>

Thanks!
John

