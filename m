Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB94A5078
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 21:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiAaUrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 15:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347931AbiAaUq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:46:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC971C06173D
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 12:46:28 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so293095pjb.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Jan 2022 12:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+BsN29vy50mQ0rcfufEYwcAhhrHDPt+P7YFUglKY9Ds=;
        b=NP1Miv1XqZHNNVJnYWhU3y0QZ5mm3+IM/s7ffE7vxxHdfG+O+MejSqx5VCUdQs+HWQ
         zV3CUOZdBt+TmVv4pxza86qYXQUwO8w2VFAsVBnoXrAQWicVyOo+snzpieC36du4LCrk
         iY/hepaMTVqGB+Jo3JwQeCjCCi0Xw0kkeAqlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BsN29vy50mQ0rcfufEYwcAhhrHDPt+P7YFUglKY9Ds=;
        b=0JwlKnbE5b3sQfcxg+yjgX8H+u9awMmsi99K/2uXaYH2gwriaDuofOJFyfGOJH8vHn
         CuKn53qS9g3SlDzB3+iGBc0Dy6fVx1kOIvDisTG3n/F/JpT2COJA0NH6aI9c/wLV1Bla
         PqzVglEw+AtlIHPES1xlAAUQrechT9sb6+bpqCMBLqkxw0/9jRV+9a22uLf3TuEkNk/R
         Y2g+Wr4ujFZ9RJBDCvO72kX2zPQwsqizmZcu1HCbs+shhlLW/rgFzKxrZehcwvivnQMt
         IkUZdnWFXXOAL1BH3TZT9Pt7391i4E9f05wiO6we/9PJhCjfUqyNwre/ydYW26rnc4EJ
         PAOw==
X-Gm-Message-State: AOAM5338h8NZu7fv+Wc++fYqLfaXymHCoEMkQbaL41OapAnoYDjU+8Va
        qOYRJnCIBJ0FywHuW/469OFkng==
X-Google-Smtp-Source: ABdhPJyJBMWnDx/3gahqXRSRXLulliMQHWttPKN7aRTD1ZMbdG4c5/xeR3hmw/6ZEfG1jFNLUFOYiw==
X-Received: by 2002:a17:902:6a83:: with SMTP id n3mr22115880plk.139.1643661988093;
        Mon, 31 Jan 2022 12:46:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e2sm12576165pgr.52.2022.01.31.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 12:46:27 -0800 (PST)
Date:   Mon, 31 Jan 2022 12:46:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        Ariadne Conill <ariadne@dereferenced.org>,
        Rich Felker <dalias@libc.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/633: adapt execveat() invocations
Message-ID: <202201311245.0B2126B468@keescook>
References: <20220131171023.2836753-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131171023.2836753-1-brauner@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 31, 2022 at 06:10:23PM +0100, Christian Brauner wrote:
> There's a push by Ariadne to enforce that argv[0] cannot be NULL. So far
> we've allowed this. Fix the execveat() invocations to set argv[0] to the
> name of the file we're about to execute.

To be clear, these tests are also trying to launch set-id binaries with
argc == 0, so narrowing the kernel check to only set-id binaries
wouldn't help here, yes?

-Kees

> 
> Cc: Ariadne Conill <ariadne@dereferenced.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Eryu Guan <guaneryu@gmail.com>
> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: fstests@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Link: https://lore.kernel.org/lkml/20220127000724.15106-1-ariadne@dereferenced.org
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 4cf6c3bb..76b559ae 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -3598,7 +3598,7 @@ static int setid_binaries(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 5000, 5000))
> @@ -3726,7 +3726,7 @@ static int setid_binaries_idmapped_mounts(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 15000, 15000))
> @@ -3865,7 +3865,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		if (!switch_userns(attr.userns_fd, 0, 0, false))
> @@ -3924,7 +3924,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		if (!caps_supported()) {
> @@ -3992,7 +3992,7 @@ static int setid_binaries_idmapped_mounts_in_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		if (!switch_userns(attr.userns_fd, 0, 0, false))
> @@ -4150,7 +4150,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		userns_fd = get_userns_fd(0, 10000, 10000);
> @@ -4214,7 +4214,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		userns_fd = get_userns_fd(0, 10000, 10000);
> @@ -4286,7 +4286,7 @@ static int setid_binaries_idmapped_mounts_in_userns_separate_userns(void)
>  			NULL,
>  		};
>  		static char *argv[] = {
> -			NULL,
> +			"",
>  		};
>  
>  		userns_fd = get_userns_fd(0, 10000, 10000);
> 
> base-commit: d8dee1222ecdfa1cff1386a61248e587eb3b275d
> -- 
> 2.32.0
> 

-- 
Kees Cook
