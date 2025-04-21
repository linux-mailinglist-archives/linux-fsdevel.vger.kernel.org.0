Return-Path: <linux-fsdevel+bounces-46851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846EBA957A3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 22:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87983AA31C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 20:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A511F0E49;
	Mon, 21 Apr 2025 20:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSZ1vasp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCD1D89F0;
	Mon, 21 Apr 2025 20:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745269082; cv=none; b=C1Et+nVe2vtRrugeg44adXAoo7tCDgkPHMrlrNms5QjhUVpETqdkzwlPNwOB+Wb+1+u2xusYF3uEHDjvEy1Qmy/y3bLsyDfRHGVvzF4UuivSPjdgY4X2R7w+gcjCZCt08HT8E0KwLFh1rbCV422sWoxdH3lNywQXRdJaeUIJ6Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745269082; c=relaxed/simple;
	bh=7pdH9UOfVfuFbbn9mahzEXs7vahfUfV9abHAxtaRBDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBD61LgYgKuX2z93Uxq+DqjeCgTV1JVc03w4mcXKzjDbqwt6vSUVOORFjYvRkgAQwsq3dUS4+l/X+ETwYbALL27As328nig0K/22xUICN2bXKaCrxiPsJv8CjOD5uGXLcmWHQA18GIMF0O4i20JR4pDhoQPGTcHyghhE1TtIxN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSZ1vasp; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72c0b4a038fso2448714a34.0;
        Mon, 21 Apr 2025 13:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745269080; x=1745873880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1OdjLW6crwFiXOwMGrZBFM5IVgmkv8//EKkYeYlw9o=;
        b=aSZ1vaspZs7YHuWA0zGUI579iz0Y69WvwK+BKkDOSp9dXO6C478jk6fMYA8VTTLtA/
         7bIjWH5lJ5ZrTzET88krk5YoaieCjpgr91JdFo2s+c8GCn0Ljf2pCBgd8t8UYHcKtO6N
         wu/84yFfF7WmYPtt/ZlrjzEsiTove9B7wndB6Dg36E07Yqb10Psv1jZnWik7CXONDw36
         XPPJ+GonWxruQhKvy5T8xMjw2pYyHntwQmgV5WdttvvIlC7IVIp28szLWOEdQspye87v
         xL4EEUOUJ5ntN1kFIrKfezQOXUkHxaKzZ92S95KDTFFT62FJiSqiMKCyIRhyxSFHzUc8
         k4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745269080; x=1745873880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T1OdjLW6crwFiXOwMGrZBFM5IVgmkv8//EKkYeYlw9o=;
        b=RoSv33gNMq78XsZl2cVXTUIvlFPlGqqpqq+p9UO82VFe34K1X8KnqzPoyuWuigzn0i
         REquol24OGQerWYTHrKdlPB5hEv96FwrcdjOhVgruebAFGl5Hwah/KVrFPeu4KUQP0uo
         YhRP6rkDZ2FtUQaktIrquJt7z2FeawVrJsQkPKtj/PqY/JglJ94hvYMwFidEBIaIrSad
         MtI/KaE8A/AY8JOmkzTuepaQ2aWax+DG4zHyIIbFpfa2vnRo4JCFuKUywyN+FTcfFOnS
         oUo/WFQeSqqwnITqjqMhazoyeAP62XmwzR7l+4Ff1QxDdu1QKL6mmOMqzLlAkTRBO5cd
         bhKA==
X-Forwarded-Encrypted: i=1; AJvYcCUQqHnK0cS05BrvGZSoAkqF61MLzFEdM3u4xJKSZRfbvl23sTnOEvZ2Q6A+6jAVHwt/b2uY/ThWp1A=@vger.kernel.org, AJvYcCWTlePQQuQLOLlkYe/bTDkcI3LmrCNivj8q/JFnIlJqfpUaM1v/md6R2/KgBpHGjQsOF7qaKW7kfu1v@vger.kernel.org, AJvYcCWm8T+h42i5Ab2vhGCJ83YCp9jZyTjuGvUVOXxJXD32Q/iqDOrBvKjcKMS6jqFabKMkatXfRf8yaQa8Uc65@vger.kernel.org, AJvYcCWy8rsKa6aLVU+HASoncKdI7xLedNvF9yVTWBr+upINdd/15GHG7+0JKt4F1Obac6QuUcCLZBSb2Jiu8NkyKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrIIuzcEITr+u9JnbqG1uUIuNjrQa1zzb6X4yNrEo98vZJ/dAZ
	51McLWbqJQIGy8sVgZvcLcQGiZib4b4QDmrLxJzSpNC8VcH49sHK
X-Gm-Gg: ASbGncumZuSrb+YWdDpg9YHJyJqSm1vmLT0OM67/hYSdLE7GuHevpJqlz2Gvjnmv5Ht
	RtnuSn3BC42HtgvWynvQgwhGKC8MLcBl2HrAI/hQ0xZJkAB7obYShls9MO5z+LzpWFsyusnH7EV
	NLrRV2fHhnJKNHCEgNFmm1F9oZKmLm35EvKmxocoSwOCAVMe4BRHR5Obq3LpcJrjf5wnWq09KKY
	ZOIJg38pVnaYxJ4KHUzJpvHCFsLIlN8ENNtPrwflIyN3HKLZG4peZXqnDJWnL60UpyGFHLwMLPu
	x5B9ILT+fOA6vODDbDB1m+hmtkBX+A3wEcHFs1BiO4Apw3Yb83jT/7FdlS05tvY577kARVs=
X-Google-Smtp-Source: AGHT+IHMdN7/gFi03PEkZIAWvXK0QyaJl9vfIw0jL8mnQREGY3rrDCX2+lnbLjDamLf02BoGJopV2g==
X-Received: by 2002:a05:6830:390f:b0:727:39d7:b0d5 with SMTP id 46e09a7af769-730062290e2mr8959683a34.15.1745269080087;
        Mon, 21 Apr 2025 13:58:00 -0700 (PDT)
Received: from Borg-550.local ([2603:8080:1500:3d89:c191:629b:fde5:2f06])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7300489cd44sm1607261a34.66.2025.04.21.13.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 13:57:59 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Mon, 21 Apr 2025 15:57:57 -0500
From: John Groves <John@groves.net>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredb.hu>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 14/19] famfs_fuse: GET_DAXDEV message and daxdev_table
Message-ID: <6f22k2r6uu4rimplfdna7farx3o2vfwp3korye54tfezemfl3q@hcngav32igrt>
References: <20250421013346.32530-1-john@groves.net>
 <20250421013346.32530-15-john@groves.net>
 <bed14737-9432-4871-a86f-09c6ce59206b@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed14737-9432-4871-a86f-09c6ce59206b@infradead.org>

On 25/04/20 08:43PM, Randy Dunlap wrote:
> Hi,

Hi Randy - thanks for the review!

> 
> On 4/20/25 6:33 PM, John Groves wrote:
> > * The new GET_DAXDEV message/response is enabled
> > * The command it triggered by the update_daxdev_table() call, if there
> >   are any daxdevs in the subject fmap that are not represented in the
> >   daxdev_dable yet.
> > 
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  fs/fuse/famfs.c           | 281 ++++++++++++++++++++++++++++++++++++--
> >  fs/fuse/famfs_kfmap.h     |  23 ++++
> >  fs/fuse/fuse_i.h          |   4 +
> >  fs/fuse/inode.c           |   2 +
> >  fs/namei.c                |   1 +
> >  include/uapi/linux/fuse.h |  15 ++
> >  6 files changed, 316 insertions(+), 10 deletions(-)
> > 
> > diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> > index e62c047d0950..2e182cb7d7c9 100644
> > --- a/fs/fuse/famfs.c
> > +++ b/fs/fuse/famfs.c
> > @@ -20,6 +20,250 @@
> >  #include "famfs_kfmap.h"
> >  #include "fuse_i.h"
> >  
> > +/*
> > + * famfs_teardown()
> > + *
> > + * Deallocate famfs metadata for a fuse_conn
> > + */
> > +void
> > +famfs_teardown(struct fuse_conn *fc)
> 
> Is this function formatting prevalent in fuse?
> It's a bit different from most Linux.
> (many locations throughout the patch set)

I'll check and clean it up if not; function names beginning in column 1 is a
"thing", but I'll normalize to nearby standards.

> 
> > +{
> > +	struct famfs_dax_devlist *devlist = fc->dax_devlist;
> > +	int i;
> > +
> > +	fc->dax_devlist = NULL;
> > +
> > +	if (!devlist)
> > +		return;
> > +
> > +	if (!devlist->devlist)
> > +		goto out;
> > +
> > +	/* Close & release all the daxdevs in our table */
> > +	for (i = 0; i < devlist->nslots; i++) {
> > +		if (devlist->devlist[i].valid && devlist->devlist[i].devp)
> > +			fs_put_dax(devlist->devlist[i].devp, fc);
> > +	}
> > +	kfree(devlist->devlist);
> > +
> > +out:
> > +	kfree(devlist);
> > +}
> > +
> > +static int
> > +famfs_verify_daxdev(const char *pathname, dev_t *devno)
> > +{
> > +	struct inode *inode;
> > +	struct path path;
> > +	int err;
> > +
> > +	if (!pathname || !*pathname)
> > +		return -EINVAL;
> > +
> > +	err = kern_path(pathname, LOOKUP_FOLLOW, &path);
> > +	if (err)
> > +		return err;
> > +
> > +	inode = d_backing_inode(path.dentry);
> > +	if (!S_ISCHR(inode->i_mode)) {
> > +		err = -EINVAL;
> > +		goto out_path_put;
> > +	}
> > +
> > +	if (!may_open_dev(&path)) { /* had to export this */
> > +		err = -EACCES;
> > +		goto out_path_put;
> > +	}
> > +
> > +	*devno = inode->i_rdev;
> > +
> > +out_path_put:
> > +	path_put(&path);
> > +	return err;
> > +}
> > +
> > +/**
> > + * famfs_fuse_get_daxdev()
> 
> Missing " - <short function description>"
> but then it's a static function, so kernel-doc is not required.
> It's up to you, but please use full kernel-doc notation if using kernel-doc.

Thank you - and sorry for being a bit sloppy on this stuff. I'm caching fixes
for all your comments along these lines into a branch for the next version of
the series.

Snipping the rest, but will address it all.

Thanks,
John


