Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3142716EECC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2020 20:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgBYTN4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 14:13:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40753 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgBYTN4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:13:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so182457plp.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2020 11:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ME7tWI2LujE/1u8Qe8IEwBIu2j1OAynNsNQIKSwMuLw=;
        b=eWXt/u8b8fCzzSFzEkjV2jR+M+0OEtsb4UmEFYJawmxPzlvXE+9kfRckuHqTOxDvK5
         6Qtx1/95jBXrXTDplrgHdAGbi100OCxBHblIjpFp2ZIpBI1S3VDJs7PjP+C0QgLz9/3y
         aLTc6udDiKEAfHcyIPLdpcBy/nuYzEmWHVVDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ME7tWI2LujE/1u8Qe8IEwBIu2j1OAynNsNQIKSwMuLw=;
        b=MmsOvMTgqoFm7PwP5gRt1LGvMSFpbcrzy1FIrHk0nhbTfl1jX/NgKnEhtOm8Y1CeHG
         l1fyd1qemiT/w70SVqJtW5EeZBo6OuP017ARHzdJVtbuDjUH56wArYzj6CR/7p/Kn1iv
         R+ngzQDOyH1iXKOW9r2tBzQ/Laotwy6412jLOVSgTtu1minfSfXuDGubRspcf6N4P8tF
         Z03OBdmvhz615rGN2VGs02uSQAg0tkRrFUKhIO2hoGe0nmpUN2ACfysG2Jz8SE2ZI6l7
         2SbzzSEwTnDi49Ok9/Ho6Y4q51c1n/rIQxhMr7WHaIYVM4eUxZqsZH5me+5Vcuy4F9ke
         cHYw==
X-Gm-Message-State: APjAAAXIaCWhuc7+lV8oIy+wo2qr1RHsiVkVoe08Mpat5Ds13lGYyZI0
        Ug/CrudmLHDyPHnpQxjSHdd6sg==
X-Google-Smtp-Source: APXvYqyL3bI9ySms9CphLhoNldtzN+RYD//HIyuoeOVLv5UO2o6xAGdKHFtS1o0HJaPOFDTFHn43wQ==
X-Received: by 2002:a17:902:c693:: with SMTP id r19mr3175plx.25.1582658035520;
        Tue, 25 Feb 2020 11:13:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s206sm18888208pfs.100.2020.02.25.11.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:13:54 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:13:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     qiwuchen55@gmail.com
Cc:     anton@enomsg.org, ccross@android.com, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH 1/2] pstore/platform: fix potential mem leak if
 pstore_init_fs failed
Message-ID: <202002251113.BF80CEAEB@keescook>
References: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581068800-13817-1-git-send-email-qiwuchen55@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:46:39PM +0800, qiwuchen55@gmail.com wrote:
> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> There is a potential mem leak when pstore_init_fs failed,
> since the pstore compression maybe unlikey to initialized
> successfully. We must clean up the allocation once this
> unlikey issue happens.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Thanks! Applied to for-next/pstore.

-Kees

> ---
>  fs/pstore/platform.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
> index d896457..114dbdf15 100644
> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -822,10 +822,10 @@ static int __init pstore_init(void)
>  	allocate_buf_for_compression();
>  
>  	ret = pstore_init_fs();
> -	if (ret)
> -		return ret;
> +	if (ret < 0)
> +		free_buf_for_compression();
>  
> -	return 0;
> +	return ret;
>  }
>  late_initcall(pstore_init);
>  
> -- 
> 1.9.1
> 

-- 
Kees Cook
