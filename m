Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B02ACA0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 02:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgKJBIU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Nov 2020 20:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKJBIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Nov 2020 20:08:19 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9709C0613CF;
        Mon,  9 Nov 2020 17:08:19 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id 11so9977575qkd.5;
        Mon, 09 Nov 2020 17:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jfYrdTPKMZbK96SOWjVC+rX+6K1DHm/KzMlUaGqdCkw=;
        b=pUdpifgoK3w/lahMuT6WcZmrX4aQ2ovlJSJoTrIARtJQbPBh83RGgcVvTlBrAsaUV5
         u8Vk+QKxnbN7lKUsNHc4qJxvQq3P2iPRLc4GFr7foKh/io6u6OlPuBetXNzJdFMYUwcB
         SUfer6LTAEtgrkjvorvT+2Vg5kW082G8yBNdg8M3c1EhYm3l8A1zBWbRBSIgaC0BvfS8
         CG0Os63C5a0pOtHwc6FF2Gl6eS+0yecZPNb/a58bWNx7yj7+xunAZeUNGDFUXcgorjTV
         lRlnHSxKw4LHtbs241np/7yGP77pdl7x305N2DAIcJaI+pyn2Fn3aTcRcPGH12u17m1m
         d0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfYrdTPKMZbK96SOWjVC+rX+6K1DHm/KzMlUaGqdCkw=;
        b=hLTL4HXhQoANiBkURr+Jo9c29pL9HDNFd54BFhXxpdhizFGyptelhNvwg18orp50Ve
         72Dy7I2M0UKWb/aJaYjIaGIFGvJ/LXI9Lg5scvCyFn73uCS2ztN4cCErA40kZUO/PJe0
         sKIfZtqBjs+B1pWnNSQaaUsVnwmJaON/naAAeaaL5Lg+cotnnzLJlDT57WN2IKCcNiUh
         aRpQ1nZrvHLipkNweoKrIvLEvV+DjEoOrWm4oyi6jWKyYduewTrVPyEKBz9U/+5Mg4oG
         IGDZyrwKHhPsMaOdkJQEQdv9La1XffzSQQJP9FGKrOqS9zlSWyE/OoWne3lfWkvVLSJe
         8ndA==
X-Gm-Message-State: AOAM533iNhjIj7FFNqBDEhk//mwagrWdIQ1sdiREX1UwTt/aHpaqw7zQ
        ftwZjfITCctb19S3SpEec10=
X-Google-Smtp-Source: ABdhPJzJVAFILxIYtGbynUNUhQHwI2fH9uUHuUb1MdMFmdDbiekSZtZNli0tzavpO8qg98IXWDJc+A==
X-Received: by 2002:a37:8c9:: with SMTP id 192mr7524631qki.428.1604970498896;
        Mon, 09 Nov 2020 17:08:18 -0800 (PST)
Received: from ubuntu-m3-large-x86 ([2604:1380:45f1:1d00::1])
        by smtp.gmail.com with ESMTPSA id k3sm6774156qtj.84.2020.11.09.17.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 17:08:18 -0800 (PST)
Date:   Mon, 9 Nov 2020 18:08:16 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sysctl: move local variable in proc_do_large_bitmap() to
 proper scope
Message-ID: <20201110010816.GA2018112@ubuntu-m3-large-x86>
References: <20201109071107.22560-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109071107.22560-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 09, 2020 at 08:11:07AM +0100, Lukas Bulwahn wrote:
> make clang-analyzer caught my attention with:
> 
>   kernel/sysctl.c:1511:4: warning: Value stored to 'first' is never read \
>   [clang-analyzer-deadcode.DeadStores]
>                           first = 0;
>                           ^
> 
> Commit 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap") introduced
> proc_do_large_bitmap(), where the variable first is only effectively used
> when write is false; when write is true, the variable first is only used in
> a dead assignment.
> 
> So, simply remove this dead assignment and put the variable in local scope.
> 
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change to object code.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> applies cleanly on v5.10-rc3 and next-20201106
> 
> Luis, Kees, Iurii, please pick this minor non-urgent clean-up patch.
> 
>  kernel/sysctl.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index ce75c67572b9..cc274a431d91 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1423,7 +1423,6 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			 void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	int err = 0;
> -	bool first = 1;
>  	size_t left = *lenp;
>  	unsigned long bitmap_len = table->maxlen;
>  	unsigned long *bitmap = *(unsigned long **) table->data;
> @@ -1508,12 +1507,12 @@ int proc_do_large_bitmap(struct ctl_table *table, int write,
>  			}
>  
>  			bitmap_set(tmp_bitmap, val_a, val_b - val_a + 1);
> -			first = 0;
>  			proc_skip_char(&p, &left, '\n');
>  		}
>  		left += skipped;
>  	} else {
>  		unsigned long bit_a, bit_b = 0;
> +		bool first = 1;
>  
>  		while (left) {
>  			bit_a = find_next_bit(bitmap, bitmap_len, bit_b);
> -- 
> 2.17.1
> 
