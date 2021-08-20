Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFA23F32A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 20:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhHTSAi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 14:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbhHTSAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:00:37 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C3AC061757
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:59:59 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so9722635pje.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 10:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hV/OGCjTsmyJ4MPFYCjl0sprLkVN4d1F0n2nUgBqznw=;
        b=RiVtcrMyITD54xjU0s7VnZLJsQ06+A8+OzDMELmgNUTRxMEGc45yFq5oRjO3J6rLli
         iXUrEU0ZfiMG89fudKNqj1RyBoe8YCwLR/FsXXnXWblXMd0Ili7gCYeh83TeBf2KG2zm
         Epx9kOFw/2VNlkcByHMrluvzhDuY2xqsqVTw03wUfuwYIehjbkN+wZYlg27BzlpdTRhW
         OrL8g0Q0kpqKJZ9JZWIJ2BZVGRaueamOCIf3tdPMc8Xm6DmPOL8I+dLVW+ncGJ4AS/qi
         6I+IdOKLkCAC3ShgZ36fOnMlmoCLghCehxywbmdUgieKl0UHkdHVRdC7rLvTQSKwFLRV
         gPYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hV/OGCjTsmyJ4MPFYCjl0sprLkVN4d1F0n2nUgBqznw=;
        b=FQAzzHzcxM87Y1E3raAxarzkSFQJ+XSO2v6Jd60VPuuculW+LAkRSKpDMDtwCgHXrw
         +MnsVl/iLvuGrhQhrAbwwoC44jIGuZZjxF/4E/BZVV4iMlGhriLCS0hXoTR7l3fX1Dyg
         5SCVLJ2//J45qMCgkaHcb8bjKcqkGQhB3p92TX1reafwlurfNzIzWm0JpnS1OJyctXiy
         sOPGKKnh7RcnSSzoIJpkiXAUoeLMq/6a3otJyyaftHKxEPBVn3r59IRc+oxqkJlS+zZA
         Im3wZnRGtaWugDTFCMWpqXmQU9GD/4l8grxGHbYXS7fRGSY79ZVcIZLZ7b2FOONnOTpP
         c1Ug==
X-Gm-Message-State: AOAM5313lDfDEnP/iGortFHIn6lVgXC1SAYNoUZzFavqILtLtzAzKLuR
        eLeBDM5jPfREk0s4G94BwoTIUg==
X-Google-Smtp-Source: ABdhPJwpg8wIE/Ks5GtPJb0/AsmfQ6f3DTxhniOhFH2E01gbiJde8MGKSdN+lqI0BhmbPPo/oRmaKA==
X-Received: by 2002:a17:902:bf09:b029:12c:d762:96c with SMTP id bi9-20020a170902bf09b029012cd762096cmr17327338plb.15.1629482399191;
        Fri, 20 Aug 2021 10:59:59 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4387])
        by smtp.gmail.com with ESMTPSA id bo14sm6819443pjb.1.2021.08.20.10.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 10:59:58 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:59:56 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v10 09/14] btrfs: add BTRFS_IOC_ENCODED_WRITE
Message-ID: <YR/tnL4EcO++1uWb@relinquished.localdomain>
References: <cover.1629234193.git.osandov@fb.com>
 <497af8b97838225920491f9146d9f65b6539e2d2.1629234193.git.osandov@fb.com>
 <bb47ef73-0f9c-55b2-c916-5774a3fe5278@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb47ef73-0f9c-55b2-c916-5774a3fe5278@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:44:26PM +0300, Nikolay Borisov wrote:
> 
> 
> On 18.08.21 г. 0:06, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The implementation resembles direct I/O: we have to flush any ordered
> > extents, invalidate the page cache, and do the io tree/delalloc/extent
> > map/ordered extent dance. From there, we can reuse the compression code
> > with a minor modification to distinguish the write from writeback. This
> > also creates inline extents when possible.
> > 
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> <snip>
> 
> >   * Add an entry indicating a block group or device which is pinned by a
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 7a0a9c752624..13a0a65c6a43 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -103,6 +103,8 @@ struct btrfs_ioctl_encoded_io_args_32 {
> >  
> >  #define BTRFS_IOC_ENCODED_READ_32 _IOR(BTRFS_IOCTL_MAGIC, 64, \
> >  				       struct btrfs_ioctl_encoded_io_args_32)
> > +#define BTRFS_IOC_ENCODED_WRITE_32 _IOW(BTRFS_IOCTL_MAGIC, 64, \
> > +					struct btrfs_ioctl_encoded_io_args_32)
> >  #endif
> >  
> >  /* Mask out flags that are inappropriate for the given type of inode. */
> > @@ -4992,6 +4994,102 @@ static int btrfs_ioctl_encoded_read(struct file *file, void __user *argp,
> >  	return ret;
> >  }
> >  
> > +static int btrfs_ioctl_encoded_write(struct file *file, void __user *argp,
> > +				     bool compat)
> > +{
> > +	struct btrfs_ioctl_encoded_io_args args;
> > +	struct iovec iovstack[UIO_FASTIOV];
> > +	struct iovec *iov = iovstack;
> > +	struct iov_iter iter;
> > +	loff_t pos;
> > +	struct kiocb kiocb;
> > +	ssize_t ret;
> > +
> > +	if (!capable(CAP_SYS_ADMIN)) {
> > +		ret = -EPERM;
> > +		goto out_acct;
> > +	}
> > +
> > +	if (!(file->f_mode & FMODE_WRITE)) {
> > +		ret = -EBADF;
> > +		goto out_acct;
> > +	}
> > +
> > +	if (compat) {
> > +#if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
> > +		struct btrfs_ioctl_encoded_io_args_32 args32;
> > +
> > +		if (copy_from_user(&args32, argp, sizeof(args32))) {
> > +			ret = -EFAULT;
> > +			goto out_acct;
> > +		}
> > +		args.iov = compat_ptr(args32.iov);
> > +		args.iovcnt = args.iovcnt;
> > +		memcpy(&args.offset, &args32.offset,
> > +		       sizeof(args) -
> > +		       offsetof(struct btrfs_ioctl_encoded_io_args, offset));
> > +#else
> > +		return -ENOTTY;
> > +#endif
> > +	} else {
> > +		if (copy_from_user(&args, argp, sizeof(args))) {
> > +			ret = -EFAULT;
> > +			goto out_acct;
> > +		}
> > +	}
> > +
> > +	ret = -EINVAL;
> > +	if (args.flags != 0)
> > +		goto out_acct;
> > +	if (memchr_inv(args.reserved, 0, sizeof(args.reserved)))
> > +		goto out_acct;
> > +	if (args.compression == BTRFS_ENCODED_IO_COMPRESSION_NONE &&
> > +	    args.encryption == BTRFS_ENCODED_IO_ENCRYPTION_NONE)
> 
> Do you intend on supporting encrypted data writeout in the future, given
> that in btrfs_do_encoded_write EINVAL is returned if the data to be
> written is encrypted? If not then this check could be moved earlier to
> fail fast.

We probably want to support it at some point in the future, yes.

> > @@ -5138,9 +5236,13 @@ long btrfs_ioctl(struct file *file, unsigned int
> >  		return fsverity_ioctl_measure(file, argp);
> >  	case BTRFS_IOC_ENCODED_READ:
> >  		return btrfs_ioctl_encoded_read(file, argp, false);
> > +	case BTRFS_IOC_ENCODED_WRITE:
> > +		return btrfs_ioctl_encoded_write(file, argp, false);
> >  #if defined(CONFIG_64BIT) && defined(CONFIG_COMPAT)
> >  	case BTRFS_IOC_ENCODED_READ_32:
> >  		return btrfs_ioctl_encoded_read(file, argp, true);
> > +	case BTRFS_IOC_ENCODED_WRITE_32:
> > +		return btrfs_ioctl_encoded_write(file, argp, true);
> >  #endif
> >  	}
> >  
> > diff --git a/fs/btrfs/ordered-data.c b/fs/btrfs/ordered-data.c
> > index 550c34fa0e6d..180f302dee93 100644
> > --- a/fs/btrfs/ordered-data.c
> > +++ b/fs/btrfs/ordered-data.c
> > @@ -521,9 +521,15 @@ void btrfs_remove_ordered_extent(struct btrfs_inode *btrfs_inode,
> >  	spin_lock(&btrfs_inode->lock);
> >  	btrfs_mod_outstanding_extents(btrfs_inode, -1);
> >  	spin_unlock(&btrfs_inode->lock);
> > -	if (root != fs_info->tree_root)
> > -		btrfs_delalloc_release_metadata(btrfs_inode, entry->num_bytes,
> > -						false);
> > +	if (root != fs_info->tree_root) {
> > +		u64 release;
> > +
> > +		if (test_bit(BTRFS_ORDERED_ENCODED, &entry->flags))
> > +			release = entry->disk_num_bytes;
> > +		else
> > +			release = entry->num_bytes;
> > +		btrfs_delalloc_release_metadata(btrfs_inode, release, false);
> > +	}
> >  
> >  	percpu_counter_add_batch(&fs_info->ordered_bytes, -entry->num_bytes,
> >  				 fs_info->delalloc_batch);
> > diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
> > index 0feb0c29839e..04588ccad34c 100644
> > --- a/fs/btrfs/ordered-data.h
> > +++ b/fs/btrfs/ordered-data.h
> > @@ -74,6 +74,8 @@ enum {
> >  	BTRFS_ORDERED_LOGGED_CSUM,
> >  	/* We wait for this extent to complete in the current transaction */
> >  	BTRFS_ORDERED_PENDING,
> > +	/* RWF_ENCODED I/O */
> 
> nit: RWF_ENCODED is no longer, we simply have ioctl-based encoded io. So
> this needs to be renamed to avoid confusion for people not necessarily
> faimilar with the development history of the feature.

Good catch, thanks.
