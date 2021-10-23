Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C5D4382FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Oct 2021 11:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbhJWJ7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Oct 2021 05:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhJWJ6k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Oct 2021 05:58:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D06C0611C2;
        Sat, 23 Oct 2021 02:56:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i24so2511397lfj.13;
        Sat, 23 Oct 2021 02:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LXv2Bng4C8uj1DNivI+o5gz96luQJc9s1jkjFvg2HPM=;
        b=FNfLdmxXyGg552hX75/Ju2SLVddrS3u3m2N/LBTcy59HUYPb2JtpHiLmUjAvPlaMxP
         LY3vbPS5xMLnp+Exyqy2PKaInV8DxfpXtAb8neFrZ/GrdFYis0zKrDV2c/bbr2KHJ+Uw
         k18Cpp2YvbBDy37GV73VIgFjEGhKpazb2303L04g7tDXzR84f+PN5+DmDxIBI7rEVbSG
         eVm34SU5GznIsuOJZd+GVJD8bvFdsV2BLg/4HQVNf5z6KPvKR6IcRdyrupj5ZdQjYCtF
         VVLYsr3uIVPtnQ8rVZiHbZANIPbzubXc6c9p4VQ4l1y5rszXTGY82dr6kC9qNydy3md5
         0hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LXv2Bng4C8uj1DNivI+o5gz96luQJc9s1jkjFvg2HPM=;
        b=5XpH4KAg6GZytwuoV+UjaXMVSxD9hJCA+pblzIiTGBcYBW1mXxaYKFl9NROZaz/Ma+
         5iMvgxugBONEP7lfkmbVSRXVjp5N/G72Em7dPvUuy6HKrR5qd+DEfu784OG0GsDnYI0o
         c/7Fh3K4eD4SbIQ8eQb7gq5fBRUDRut4SA3SAx2xD7j4XLjGXLj0Or48xPIIAriBZ1ND
         Mn1+racqAxu08XWhuAfSZ43kPB1QYG+dwYHCdSU1q8G8XbonR/nXhOwiCWjimwM0cj9Z
         4kERzftMxbtSSCDlMFWJQamryZ9OGZ2h7DfknLIMwgvggYiJO9Uq4+6K+V0dALZTm3c+
         hepA==
X-Gm-Message-State: AOAM532fdafGYQ6Oqr6tpES3J3W00A+esT88Wtt4nwFr6KuLnztVJJNi
        ooqk2Ey7GtTnkor0MOShuDD9vUunYJA=
X-Google-Smtp-Source: ABdhPJzh395qQXJTPuGWeDEcS/35igOwFxdh/Pf4A1OMsfPxknPxuIH3cuL+1C6rzTvcjEnKVySFiw==
X-Received: by 2002:a05:6512:926:: with SMTP id f6mr4904456lft.495.1634982961249;
        Sat, 23 Oct 2021 02:56:01 -0700 (PDT)
Received: from kari-VirtualBox ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id v62sm980321lfa.23.2021.10.23.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 02:56:00 -0700 (PDT)
Date:   Sat, 23 Oct 2021 12:55:59 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        hgkamath@hotmail.com
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] fs/ntfs3: Keep preallocated only if option prealloc
 enabled
Message-ID: <20211023095559.ythxb2z2ptdrlr5s@kari-VirtualBox>
References: <09b42386-3e6d-df23-12c2-23c2718f766b@paragon-software.com>
 <aaf41f35-b702-b391-1cff-de4688b3bb65@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaf41f35-b702-b391-1cff-de4688b3bb65@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 22, 2021 at 06:54:31PM +0300, Konstantin Komarov wrote:
> If size of file was reduced, we still kept allocated blocks.
> This commit makes ntfs3 work as other fs like btrfs.
> https://bugzilla.kernel.org/show_bug.cgi?id=214719

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214719
> Fixes: 4342306f0f0d ("fs/ntfs3: Add file operations and implementation")
> 
> Reported-by: Ganapathi Kamath

Add <hgkamath@hotmail.com>

I also added to loop here. Ganapathi can you test if this patch fix your
problem?

> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  fs/ntfs3/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 43b1451bff53..3ac0482c6880 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -494,7 +494,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
>  
>  	down_write(&ni->file.run_lock);
>  	err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run, new_size,
> -			    &new_valid, true, NULL);
> +			    &new_valid, ni->mi.sbi->options->prealloc, NULL);
>  	up_write(&ni->file.run_lock);
>  
>  	if (new_valid < ni->i_valid)
> -- 
> 2.33.0
> 
> 
