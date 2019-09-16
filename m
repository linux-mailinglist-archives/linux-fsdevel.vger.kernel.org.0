Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64BF6B37DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2019 12:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfIPKOb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Sep 2019 06:14:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37664 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfIPKOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Sep 2019 06:14:30 -0400
Received: by mail-pg1-f194.google.com with SMTP id c17so11804336pgg.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2019 03:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YwusKXBUgyUMXSs68FocspxMjGXcgKSvza9r85FVtq4=;
        b=v6z5y0McOHGn6caqnH2fZHUUguAgMIWn1G5wkZy2mpOO5Vr6+zYEtdp5B1DnXNZlI9
         EZWCcKune2GEpOoZmPN3Fd/xBqTPw3GeDjDHCrTbDGxRkcxQVRvZgaae45tiNWz4egdv
         7aWNYbhwB4cnAhNaDOf89BHHxLVO1IBC/+9uxgIdOe8EFp4mc3LIMT2XcvnaYeRKqQqm
         Yiwb3IyFtUpA4Ev1VKh3dS8+BcwUFt3NgeiHb4dTUF5GGF13r6EgZNvrXUUnviBbd+Wk
         SJ2CKtC8oD+7uODionnjzRsjJjaPai1sErp6OMT7XZ+QlqSV+h0QR24i2CVmFXGruzsq
         R9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YwusKXBUgyUMXSs68FocspxMjGXcgKSvza9r85FVtq4=;
        b=j4E+ycIEQEsMWr/+3sUZ84Icuk89KvmxC+2CxKiaFXMhEvOE6XsJc6X7/JnkhrT735
         wySLbtvCHS0Qpa7rhIXqzfxMN31UBp6cLz3rpDwSrsDa4RyNIbY0usHCtDUKdlOAJY66
         TMhu0LZ8yWyASlduCTesx9VJGXSqHRUcHd9ajj8bwik4RyY6AuWmuEauGVhr1pO9yltb
         F2xj9zsGFf8qo0r4KaPxTtC01xBuua6NGn6yymj3u7axMYWZYjb2TRUF3IoT0aJ/xavC
         hvFuRaYvpNQL+TU36Ta+Q0HducUa0z9VxmPb3h/oWqJFT6tW4bz+IoASmYy3Yfs41dki
         En/g==
X-Gm-Message-State: APjAAAXJMl2v+rZC6cX32zZ7lvNI76Z/Xkv5ImW31dc5nq6PF3mrc/8/
        4YrfyOolDRuBiIFcbua1cus3eOwD2LyC
X-Google-Smtp-Source: APXvYqyL1KqvzAf2ZZKqgFwNVe0gZbGBEQJFslScWmzayJcvvmZjesltSh/2GJG9gQtx2930L95cZw==
X-Received: by 2002:a63:5941:: with SMTP id j1mr55238748pgm.319.1568628864456;
        Mon, 16 Sep 2019 03:14:24 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id j4sm4197326pfn.29.2019.09.16.03.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 03:14:23 -0700 (PDT)
Date:   Mon, 16 Sep 2019 20:14:17 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, hch@infradead.org, darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190916101417.GA4024@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916043741.BCBDEA4054@b06wcsmtp001.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916043741.BCBDEA4054@b06wcsmtp001.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:07:41AM +0530, Ritesh Harjani wrote:
> > @@ -213,12 +214,16 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> >   	struct inode *inode = file_inode(iocb->ki_filp);
> >   	ssize_t ret;
> > 
> > +	if (unlikely(IS_IMMUTABLE(inode)))
> > +		return -EPERM;
> > +
> >   	ret = generic_write_checks(iocb, from);
> >   	if (ret <= 0)
> >   		return ret;
> > 
> > -	if (unlikely(IS_IMMUTABLE(inode)))
> > -		return -EPERM;
> > +	ret = file_modified(iocb->ki_filp);
> > +	if (ret)
> > +		return 0;
> 
> Why not return ret directly, otherwise we will be returning the wrong
> error code to user space. Thoughts?

You're right. I can't remember exactly why I decided to return '0', however
looking at the code once again I don't see a reason why we don't just return
'ret', as any value other than '0' represents a failure in this case
anyway. Thanks for picking that up.
 
> Do you think simplification/restructuring of this API
> "ext4_write_checks" can be a separate patch, so that this patch
> only focuses on conversion of DIO write path to iomap?

Hm, if we split it up so that it comes before this patch then it becomes hairy
in the sense that a whole bunch of other changes would also need to come with
what looks to be such a miniscule modification
i.e. ext4_buffered_write_iter(), ext4_file_write_iter(), etc. Splitting it to
come after just doesn't make any sense. To be honest, I don't really have any
strong opinions around why we shouldn't split it up, nor do I have a strong
opinion around why we should, so I think we should just leave it for now.

> Also, I think we can make the function (ext4_write_checks())
> like below. This way we call for file_modified() only after we
> have checked for write limits, at one place.

No objections and I think it's a good idea.

>   static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter
> *from)
>   {
>           struct inode *inode = file_inode(iocb->ki_filp);
>           ssize_t ret;
> 
>           if (unlikely(IS_IMMUTABLE(inode)))
>                   return -EPERM;
> 
>           ret = generic_write_checks(iocb, from);
>           if (ret <= 0)
> _                 return ret;
>           /*
>            * If we have encountered a bitmap-format file, the size limit
>            * is smaller than s_maxbytes, which is for extent-mapped files.
>            */
>           if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
>                   struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
> 
>                   if (iocb->ki_pos >= sbi->s_bitmap_maxbytes)
>                           return -EFBIG;
>                   iov_iter_truncate(from, sbi->s_bitmap_maxbytes -
> iocb->ki_pos);
>           }
> +
> +         ret = file_modified(iocb->ki_filp);
> +         if (ret)
> +                 return ret;
> +
>           return iov_iter_count(from);
>   }

--<M>--
