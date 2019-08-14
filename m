Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9E378D1AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 13:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHNLB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 07:01:56 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44906 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNLBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:01:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id p17so110648948wrf.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Aug 2019 04:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=NGRYaPZ45BRZWNIa21aeYiY76Szc1jOCs/Op2S6T54w=;
        b=RNfgQwCg5U/Fr/N9eZ39S/lOMbElJClOddv602ibouJEhDNWfLiXSiMlyHDn9Fxio4
         WJKsEV0X4a+QoJs9pHiyxQA1ZovmAFFh+ftximot8PRuOiWovTISWYAms0Y0IK44Ep/Q
         q3k2kZ2qRdh+q4FS9sBDn6TiFfZwmuMnLtvF5865EJ+h7YyulZGLygvDJKaoaaTxieXW
         aSNDs9CIoOEHPkO5fWg4eKnSe+9F4/lOYCuk3XUUTm4C5l/NEVsFJy+PS97wHiYvTidx
         AA6hYf2MfZHptl48RaiKhsEmeX9gWLKhxPkzQJSFKhPhPfO4dll/ShGPd/29q/dktVyy
         E4Og==
X-Gm-Message-State: APjAAAWi+MNqOjjGe2tfI5ccWhCh41ftDmlIhFl4M98KePKZUg3hY5kj
        Ok2TQ4NIvKveQSrnkR+xMJp/4fHdj1o=
X-Google-Smtp-Source: APXvYqx2o/5vbO1C2Mh54gC+k3S2ckhjY8e8pBqQSKe0tOSeU5eloxorZnGqPyT3xI0D2V+LtM7MlQ==
X-Received: by 2002:adf:fd82:: with SMTP id d2mr40395664wrr.194.1565780513363;
        Wed, 14 Aug 2019 04:01:53 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id h2sm3048853wmb.28.2019.08.14.04.01.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 04:01:52 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:01:50 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@lst.de, adilger@dilger.ca, jaegeuk@kernel.org,
        darrick.wong@oracle.com, miklos@szeredi.hu, rpeterso@redhat.com,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 4/9] fibmap: Use bmap instead of ->bmap method in
 ioctl_fibmap
Message-ID: <20190814110148.kbp6tplxibrnfpej@pegasus.maiolino.io>
Mail-Followup-To: linux-fsdevel@vger.kernel.org, hch@lst.de,
        adilger@dilger.ca, jaegeuk@kernel.org, darrick.wong@oracle.com,
        miklos@szeredi.hu, rpeterso@redhat.com, linux-xfs@vger.kernel.org
References: <20190808082744.31405-5-cmaiolino@redhat.com>
 <201908090430.yoyXYjeY%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201908090430.yoyXYjeY%lkp@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey folks,

> All errors (new ones prefixed by >>):
> 
>    fs/ioctl.c: In function 'ioctl_fibmap':
> >> fs/ioctl.c:68:10: error: implicit declaration of function 'bmap'; did you mean 'kmap'? [-Werror=implicit-function-declaration]

Any of you guys may have a better idea on how to fix this?

Essentially, this happens when CONFIG_BLOCK is not set, and although I don't
really see a hard requirement to have bmap() exported only when CONFIG_BLOCK is
set, at the same time, I don't see use for bmap() if CONFIG_BLOCK is not set.

So, I'm in a kind of a chicken-egg problem.

I am considering to just remove the #ifdef CONFIG_BLOCK / #endif from the bmap()
declaration. This will fix the warning, and I don't see any side effects. What
you guys think?


>      error = bmap(inode, &block);
>              ^~~~
>              kmap
>    cc1: some warnings being treated as errors
> 
> vim +68 fs/ioctl.c
> 
>     53	
>     54	static int ioctl_fibmap(struct file *filp, int __user *p)
>     55	{
>     56		struct inode *inode = file_inode(filp);
>     57		int error, ur_block;
>     58		sector_t block;
>     59	
>     60		if (!capable(CAP_SYS_RAWIO))
>     61			return -EPERM;
>     62	
>     63		error = get_user(ur_block, p);
>     64		if (error)
>     65			return error;
>     66	
>     67		block = ur_block;
>   > 68		error = bmap(inode, &block);
>     69	
>     70		if (error)
>     71			ur_block = 0;
>     72		else
>     73			ur_block = block;
>     74	
>     75		error = put_user(ur_block, p);
>     76	
>     77		return error;
>     78	}
>     79	
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
Carlos
