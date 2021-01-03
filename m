Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B03A2E8DFD
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jan 2021 21:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbhACUCS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 15:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhACUCP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 15:02:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D2C061573;
        Sun,  3 Jan 2021 12:01:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id h205so59824653lfd.5;
        Sun, 03 Jan 2021 12:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cCa9TKEyC5rGu3A3L3tEdGoSG74IuT59v1+UI3oG8JU=;
        b=PJAREXrLHA1yNRh76zt8Q23wa6SOsiCQhQbv4JWyoHKAnRve2KzyEi5XepB9hxC9FX
         4GhUyvIOrwRt+4iNMf2wiereahtuGBOsnGMEcCBNJyr6wSjZMI/l526I9jJ/bDuCYB6U
         oE2GleajDa4gxIpsXsv2GgpWK4zyo9EawdNU3XgnrlvJASZHQHJjBfyl/qNoeFqVTG2c
         zyl2O5M72e4JjtUWGdOg67V3aZbwlQkMjQxG3uyVFpLnTpOwVaRQ8Dd+HN7IhyP7zWw2
         DoDJBJXya7SvR7AugTm2cemFwrhgNFfH5/5/L7QpVc2OBFXyd89XtpYfxygiMNtEsEjd
         Ywgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cCa9TKEyC5rGu3A3L3tEdGoSG74IuT59v1+UI3oG8JU=;
        b=V0uG0eVkJiWoYidy/9kL/1sOsI9csFLgbPUUALFeWbsMvKMMWTN7Om4UEB/e6JzFt9
         I8dnxVgAXRWyFWqRIQ0BEJCkCQRzhTkTc3ljXUmFPlDpkG/ZIBdMJWMXt/C7mOeE+6HY
         O7AIsg7QpF5n0Hd4OFmfQHZ6n5wz/w1GcHPwfW1zRKD8/qu63Tv5ze8beBN2hobvCMy0
         FG+DjXi2EwISPkYDxKzGY9SCyKWnrkpZ2C8WopXqZIQ1pj46oc1A1rpW797t9OVtS+w7
         GKWwz3efJ8bNX4meup9siX503LsmXfAKVQ3gHODjAEGKN1HQWaCiYawZk/ZcZqWrePlZ
         cDOg==
X-Gm-Message-State: AOAM533xHIZSuLm0+a/6YlDfO2UeJ0YEsTQbo17FfLF6n0R8NJuSnZ44
        +cSEMe7Jysa2mJZdBTIXhl6WXCV/S85x8w==
X-Google-Smtp-Source: ABdhPJzZJCegF8+DW10QEPXa6WFGH0psdX64w3MYnMlL/cRkPm+fbgmeEL7vXKKcfWiP9Gzfnh7gUw==
X-Received: by 2002:a2e:9214:: with SMTP id k20mr35104255ljg.45.1609704092872;
        Sun, 03 Jan 2021 12:01:32 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id k21sm8445977ljb.43.2021.01.03.12.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jan 2021 12:01:32 -0800 (PST)
Date:   Sun, 3 Jan 2021 22:01:30 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, willy@infradead.org, rdunlap@infradead.org,
        joe@perches.com, mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 10/10] fs/ntfs3: Add MAINTAINERS
Message-ID: <20210103200130.w5xanettrm5p6fzd@kari-VirtualBox>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-11-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-11-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:24:01PM +0300, Konstantin Komarov wrote:
> This adds MAINTAINERS
> 
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 546aa66428c9..1a990aa2985d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12674,6 +12674,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
>  F:	Documentation/filesystems/ntfs.rst
>  F:	fs/ntfs/
>  
> +NTFS3 FILESYSTEM
> +M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> +S:	Supported
> +W:	http://www.paragon-software.com/
> +F:	Documentation/filesystems/ntfs3.rst
> +F:	fs/ntfs3/
> +
 
I think if this get merged it will need mailing list (L:) where to sent
patches. And also three location (L:). Someone needs to figure this out
if is ok to use ntfs mailing list. I do not have answers but I hope that
we get conversation going.

Can you also tell how do you plan to be maintainer. Do you regulary
check patches, review them and so on? Does more than you review patches
from Paragon?

