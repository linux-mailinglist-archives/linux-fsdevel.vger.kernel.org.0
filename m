Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1943BC36
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Oct 2021 23:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239490AbhJZVVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Oct 2021 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhJZVVT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:21:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB0C061745;
        Tue, 26 Oct 2021 14:18:54 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id x192so1526952lff.12;
        Tue, 26 Oct 2021 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TnJ2YRVn5xDp4l5KcZcW6tPRwDMAjXYMkP8cTWZSwa0=;
        b=cFRrZ2grRE8nhwbq07zLQccMhZ8FcSyluojgZX5VnyTxW1YvGgJcA8XKr16suhGoZe
         XVxxnI28MdGNq2YU+0M0XFIFIeY6os3fQRMnyXhpaQnbGGKWG16KYAHnj+2XV+U78OC7
         +yCjLqpYnT59MLqfesVX7ad4eWFregVlqpj1DpY+0yUjQx1BjD37TC6A2t4+S6uHSLo8
         fCzTO4MVd0EcSgxiNIt7r8myO8KJ3wuveS1pq6zdVgrxJFLGn40kbXHoMewqLaZ+Sdyh
         ILH5Bp70G73dzI9389X0NuiAQUt0xY0ZyI6ZL4Evrvgwasx75Ov6W04uArsSr7gaL4YG
         TdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TnJ2YRVn5xDp4l5KcZcW6tPRwDMAjXYMkP8cTWZSwa0=;
        b=2TD+jNv+qzF1jZUDKD/+enNiMMCBKgbJoCg2HPxS9qLVgnx6yiJ8Doj7NJdPj8c50L
         ++Q4h/usnbtb8gaI3BWetIwr1ly1OqR0GuKjlCAFeDNqBAXJB3wxdbGsNDXWw4Hb6Eb+
         NqF80NaDx+5xIu8DeTOXi4ocM0KzNe1R85vgqKy9qnl1RcBs4NPGeknwKO2xgShrQEaW
         MwmRpkvb8Fi5XIfOvuzCYbER6203nBVptoxpM0CmyfBvEFNLRtunGVW5WO8jpszG2gyP
         n+6lDaYqZKyNAmx+tmXBfBsqJVM4FBH9GAF1k5JLOgBbruAQlsrcLFx4AEgHlLadsIjH
         ccww==
X-Gm-Message-State: AOAM53086xSU8LO7Qycsb4Pwjg3cFrUgKfT8GtlfCMjsJ5TlE0PcaWpt
        MXZXmR04uIonfJ2KsDuQLP6rddV9PY0=
X-Google-Smtp-Source: ABdhPJyIKV+JazpZO6gyORKhYS7S+s8uoqHt8p5dCFqYMwi/KUO7LMZs6FczOWNZUAd609/E8Y29Ug==
X-Received: by 2002:ac2:44ad:: with SMTP id c13mr17950336lfm.688.1635283133300;
        Tue, 26 Oct 2021 14:18:53 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id c19sm2110051ljj.130.2021.10.26.14.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 14:18:52 -0700 (PDT)
Date:   Wed, 27 Oct 2021 00:18:51 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/4] fs/ntfs3: Fix fiemap + fix shrink file size (to
 remove preallocated space)
Message-ID: <20211026211851.merrsc662mhzqghm@kari-VirtualBox>
References: <25b9a1b5-7738-7b36-7ead-c8faa7cacc87@paragon-software.com>
 <e206b37a-9d71-67d5-5144-58033036a744@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e206b37a-9d71-67d5-5144-58033036a744@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:58:57PM +0300, Konstantin Komarov wrote:
> Two problems:
> 1. ntfs3_setattr can't truncate preallocated space;
> 2. if allocated fragment "cross" valid size, then fragment splits into two parts:
> - normal part;
> - unwritten part (here we must return FIEMAP_EXTENT_LAST).
> Before this commit we returned FIEMAP_EXTENT_LAST for whole fragment.
> Fixes xfstest generic/092

I do not have time for now to got through more. Maybe you have some
ideas here.

generic/092		[21:16:19][   18.906951] run fstests generic/092 at 2021-10-26 21:16:19
 [21:16:22]- output mismatch (see /results/ntfs3/results-default/generic/092.out.bad)
    --- tests/generic/092.out	2021-08-03 00:08:10.000000000 +0000
    +++ /results/ntfs3/results-default/generic/092.out.bad	2021-10-26 21:16:22.127859289 +0000
    @@ -2,5 +2,6 @@
     wrote 5242880/5242880 bytes at offset 0
     XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
     0: [0..10239]: data
    +1: [10240..20479]: unwritten
     0: [0..10239]: data
     1: [10240..20479]: unwritten

  Argillander

> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/file.c    |  2 +-
>  fs/ntfs3/frecord.c | 10 +++++++---
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 43b1451bff53..5418e5ba64b3 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -761,7 +761,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
>  		}
>  		inode_dio_wait(inode);
>  
> -		if (attr->ia_size < oldsize)
> +		if (attr->ia_size <= oldsize)
>  			err = ntfs_truncate(inode, attr->ia_size);
>  		else if (attr->ia_size > oldsize)
>  			err = ntfs_extend(inode, attr->ia_size, 0, NULL);
> diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
> index 6f47a9c17f89..18842998c8fa 100644
> --- a/fs/ntfs3/frecord.c
> +++ b/fs/ntfs3/frecord.c
> @@ -1964,10 +1964,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  
>  		vcn += clen;
>  
> -		if (vbo + bytes >= end) {
> +		if (vbo + bytes >= end)
>  			bytes = end - vbo;
> -			flags |= FIEMAP_EXTENT_LAST;
> -		}
>  
>  		if (vbo + bytes <= valid) {
>  			;
> @@ -1977,6 +1975,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  			/* vbo < valid && valid < vbo + bytes */
>  			u64 dlen = valid - vbo;
>  
> +			if (vbo + dlen >= end)
> +				flags |= FIEMAP_EXTENT_LAST;
> +
>  			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
>  						      flags);
>  			if (err < 0)
> @@ -1995,6 +1996,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
>  			flags |= FIEMAP_EXTENT_UNWRITTEN;
>  		}
>  
> +		if (vbo + bytes >= end)
> +			flags |= FIEMAP_EXTENT_LAST;
> +
>  		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
>  		if (err < 0)
>  			break;
> -- 
> 2.33.0
> 
> 
> 
