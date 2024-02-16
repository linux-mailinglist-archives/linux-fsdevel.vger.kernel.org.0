Return-Path: <linux-fsdevel+bounces-11861-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6C2858270
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C2F1F22B66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 16:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9113012FF8B;
	Fri, 16 Feb 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxyFyxQd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C25C12FB18
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708100971; cv=none; b=ueQ8VT/fdOa5G30ZqC3QTa1lAXzBCSxdPtTZb3fywMQvTT4a3MyTy76CvKJZaq5oSSwNPD3t+ggmDIbqnwVso79dJlkUhnguLmD6xD/z6VhSiLr5Mnres4YQU9ygROal2/S9J6bwff6Xc5oxQ1yeTdHG8fw4AKe0mqd8v1tpJXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708100971; c=relaxed/simple;
	bh=dvdlmbjlJ3GuRDZvLi0MzRL4py/dv5/OnvQNiFXPi74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FrXs0PZEkrKq2C1Y5KdmliBXh7pFODNJNtQBysqUvpituLdAq0AUEuV4f2/LFXBqhCFJqDCkgmsZ5AJD1VvPWRzrw+utUomYusIraaO0ca8STseRqZH20/QpbT3g2mdzlKcHfG88sse8wZUZEvsf4EwOtEoxKKSbmkG2Ukyd0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HxyFyxQd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708100967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pa/Tudz7G/ijD1sfm+x8tYnDVUPDFcVz5YLbnbE9neI=;
	b=HxyFyxQdCIGrEP3SZ3l66CZ4EcmWXxGfHf2BgyjnoAMZ2493ltk3NySCBuBUEV9Htl5UzD
	/wUE5JKAWWAZf3MRw1UK6YJR84MQOmXs3bz8RbOQW+IeOvDe4QiOQKHs8KP/t6GidmaaLC
	5sBuzo9XPKeWF6rkCevA3Rh27UPMqMc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-bl8TNukyNwWe6ll6Bv5H4Q-1; Fri, 16 Feb 2024 11:29:26 -0500
X-MC-Unique: bl8TNukyNwWe6ll6Bv5H4Q-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55926c118e5so1874293a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 08:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708100964; x=1708705764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pa/Tudz7G/ijD1sfm+x8tYnDVUPDFcVz5YLbnbE9neI=;
        b=efw9X/ADxZ3vvm/5MJYUlykLElBOBFsOeuGQHus4bSp3J74eJkEznLysjWky6ZMTID
         Xjk+ILjnSvSBvDRAZocI5uiZnuiFns5qgexISxJcd4XjBtljyVXurfv0pIu0yPE6yNr8
         PqrVUkXzTG8SAnjebFRzqesEJaSrbdD5VMxfctxB0KcEmslDT2YOQxjcVmFT7kbvDu+G
         g/oTT7zB4XdJdtiLBTdfvUUkcNH60yNSFLL+NVX55ZPU/lBKfNXzbHCOtYHFlhPJFOCE
         ksMuI1ZSqgT/ggDTHUdm3hENIattuEzSQE1H4NCEt+AXV5sqy0dah5uYwrKi1tLQaTAL
         WWkA==
X-Forwarded-Encrypted: i=1; AJvYcCVqo5e9doOiWN/l9N13bCn0r8VokfarUhSopyuRp4j50BQPy6RMhI03xMTrREwqmofFETxYv+PI2wvgbPgaTm9qHPkAmZ/pYjh2O3e0eg==
X-Gm-Message-State: AOJu0YxMPWIYVcU7Jzn3+Fg6C9a7UhY967/VnAIbrb/BRWZoBWK4eVPx
	1m0S1HXiy02UY2QesryAM7Mliw6SaUkUCpDztmEvJQnw4LI7124hFPwAFB0SpSa9hMn/eK5QucB
	qsUCcJa1mgBNqa0yIYtFGWMGzYYSum2IcJfj65nh3ubg6HhJm+Y1jVLBKrTvsrQ==
X-Received: by 2002:aa7:ce09:0:b0:564:154:6802 with SMTP id d9-20020aa7ce09000000b0056401546802mr883581edv.40.1708100964660;
        Fri, 16 Feb 2024 08:29:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4jRXgtyh73ev3q/+fw3PvRMngLjahNFvkiBdPMAbULHS6c6Fgzuo2+wM7TJ0hQ9xOZBksAw==
X-Received: by 2002:aa7:ce09:0:b0:564:154:6802 with SMTP id d9-20020aa7ce09000000b0056401546802mr883574edv.40.1708100964330;
        Fri, 16 Feb 2024 08:29:24 -0800 (PST)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id b17-20020aa7d491000000b00563ffa219b5sm119760edr.97.2024.02.16.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 08:29:24 -0800 (PST)
Date: Fri, 16 Feb 2024 17:29:23 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Dave Chinner <david@fromorbit.com>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, chandan.babu@oracle.com, djwong@kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH v4 13/25] xfs: introduce workqueue for post read IO work
Message-ID: <5frc5j7vce6q3hfjmhow3dk7zmmndzxjdxvda4uqjociws7x52@4rjglu2e3x7d>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
 <20240212165821.1901300-14-aalbersh@redhat.com>
 <Zc6MHxQ0PTJ7Qck0@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc6MHxQ0PTJ7Qck0@dread.disaster.area>

On 2024-02-16 09:11:43, Dave Chinner wrote:
> On Mon, Feb 12, 2024 at 05:58:10PM +0100, Andrey Albershteyn wrote:
> > As noted by Dave there are two problems with using fs-verity's
> > workqueue in XFS:
> > 
> > 1. High priority workqueues are used within XFS to ensure that data
> >    IO completion cannot stall processing of journal IO completions.
> >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> >    path is a potential filesystem livelock/deadlock vector.
> > 
> > 2. The fsverity workqueue is global - it creates a cross-filesystem
> >    contention point.
> > 
> > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > work.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > ---
> >  fs/xfs/xfs_aops.c  | 15 +++++++++++++--
> >  fs/xfs/xfs_linux.h |  1 +
> >  fs/xfs/xfs_mount.h |  1 +
> >  fs/xfs/xfs_super.c |  9 +++++++++
> >  4 files changed, 24 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
> > index 7a6627404160..70e444c151b2 100644
> > --- a/fs/xfs/xfs_aops.c
> > +++ b/fs/xfs/xfs_aops.c
> > @@ -548,19 +548,30 @@ xfs_vm_bmap(
> >  	return iomap_bmap(mapping, block, &xfs_read_iomap_ops);
> >  }
> >  
> > +static inline struct workqueue_struct *
> > +xfs_fsverity_wq(
> > +	struct address_space	*mapping)
> > +{
> > +	if (fsverity_active(mapping->host))
> > +		return XFS_I(mapping->host)->i_mount->m_postread_workqueue;
> > +	return NULL;
> > +}
> > +
> >  STATIC int
> >  xfs_vm_read_folio(
> >  	struct file		*unused,
> >  	struct folio		*folio)
> >  {
> > -	return iomap_read_folio(folio, &xfs_read_iomap_ops, NULL);
> > +	return iomap_read_folio(folio, &xfs_read_iomap_ops,
> > +				xfs_fsverity_wq(folio->mapping));
> >  }
> >  
> >  STATIC void
> >  xfs_vm_readahead(
> >  	struct readahead_control	*rac)
> >  {
> > -	iomap_readahead(rac, &xfs_read_iomap_ops, NULL);
> > +	iomap_readahead(rac, &xfs_read_iomap_ops,
> > +			xfs_fsverity_wq(rac->mapping));
> >  }
> 
> Ok, Now I see how this workqueue is specified, I just don't see
> anything XFS specific about this, and it adds complexity to the
> whole system by making XFS special.
> 
> Either the fsverity code provides a per-sb workqueue instance, or
> we use the global fsverity workqueue. i.e. the filesystem itself
> should not have to supply this, nor should it be plumbed into
> generic iomap IO path.
> 
> We already do this with direct IO completion to use a
> per-superblock workqueue for defering write completions
> (sb->s_dio_done_wq), so I think that is what we should be doing
> here, too. i.e. a generic per-sb post-read workqueue.
> 
> That way iomap_read_bio_alloc() becomes:
> 
> +#ifdef CONFIG_FS_VERITY
> +	if (fsverity_active(inode)) {
> +		bio = bio_alloc_bioset(bdev, nr_vecs, REQ_OP_READ, gfp,
> +					&iomap_fsverity_bioset);
> +		if (bio) {
> +			bio->bi_private = inode->i_sb->i_postread_wq;
> +			bio->bi_end_io = iomap_read_fsverity_end_io;
> +		}
> +		return bio;
> +	}
> 
> And we no longer need to pass a work queue through the IO stack.
> This workqueue can be initialised when we first initialise fsverity
> support for the superblock at mount time, and it would be relatively
> trivial to convert all the fsverity filesytsems to use this
> mechanism, getting rid of the global workqueue altogether.

Thanks, haven't thought about that. I will change it.

-- 
- Andrey


