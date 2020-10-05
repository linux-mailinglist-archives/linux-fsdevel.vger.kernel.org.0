Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEAD2841E0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Oct 2020 23:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgJEVFQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 17:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgJEVFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 17:05:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ACDC0613CE
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2020 14:05:14 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 22so2816191pgv.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2020 14:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S28irEL+s00l76Xd6JezzJDnWUqPSi/xIcPO6jGVw0k=;
        b=i13avUSEFUfkzqcD46Nq22pgh7sreScxeo625UkqLK+daDX8lE4BFXwZCR+i0RWl4j
         kQm9H9aDflprfWtjdjMu/szcbm39wcJ2ojG/5XrIVT5i/zqP2JxIZQoZeRQA5IF5ZQ8c
         QofnFVvrTWOYSLWkSa8Di/OBLzw49kjy9yTGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S28irEL+s00l76Xd6JezzJDnWUqPSi/xIcPO6jGVw0k=;
        b=UvjhXFNaPlCt2JDcJ0rNNssuQtvltkt6G3usn7iqR0St5kDzas71KVjGyhcjtkvLuX
         7UuHaQfsvEWVEQ8y6KimvQJmteMb7PhpEHGrQy7Gghp7LI5EjmT0BrAta9FBDjLjS8dF
         GaeWsbMeTi5tfXnoOWsA0AFZpS1PLvcey322uBx9Hdn0SPmimXV8/R8MVZJzmR3Yglet
         mdXF//lgvnXeYeTpGE2AauW5e2XVcPb4k9uar8gPjuHw+27FmhhUXT//E3SlsoPO117I
         dkLkfoj59IyKG8LmzxQByDZrqpglhTWTG7NuLuZdIP2SSy1YQ6Gu4EwWQPSqBuU0Iwy3
         j9RQ==
X-Gm-Message-State: AOAM531R1B7Ao3/1omkkbzd/HCgXMRpm0DpHMfYV4LfRUl3d73lSHFgT
        60Ne36MzhrL6ANHsJyFymW0n3hwtSlUBkxFR
X-Google-Smtp-Source: ABdhPJz/S0gfoJShrvVKOkjfbJx02Hws0BkXYZdBoTIGEHtSmorXowh1oXM2pwYvKWxA6ebn5AMJEw==
X-Received: by 2002:a63:a510:: with SMTP id n16mr1283040pgf.256.1601931913748;
        Mon, 05 Oct 2020 14:05:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q12sm478376pjd.16.2020.10.05.14.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 14:05:12 -0700 (PDT)
Date:   Mon, 5 Oct 2020 14:05:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel/sysctl.c: drop unneeded assignment in
 proc_do_large_bitmap()
Message-ID: <202010051404.CEE37CD617@keescook>
References: <20201005203749.28083-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201005203749.28083-1-sudipm.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 05, 2020 at 09:37:49PM +0100, Sudip Mukherjee wrote:
> The variable 'first' is assigned 0 inside the while loop in the if block
> but it is not used in the if block and is only used in the else block.
> So, remove the unneeded assignment.

True, but in this case, please move the definition of "first" into the
else block so it in only in scope there.

Thanks!

-Kees

> 
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> The resultant binary stayed same after this change. Verified with
> md5sum which remained same with and without this change.
> 
> $ md5sum kernel/sysctl.o 
> e9e97adbfd3f0b32f83dd35d100c0e4e  kernel/sysctl.o
> 
>  kernel/sysctl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ce75c67572b9..b51ebfd1ba6e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1508,7 +1508,6 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			}
>  
>  			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
> -			first = 0;
>  			proc_skip_char(&p, &left, '\n');
>  		}
>  		left += skipped;
> -- 
> 2.11.0
> 

-- 
Kees Cook
