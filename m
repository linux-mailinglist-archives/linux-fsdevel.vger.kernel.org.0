Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625FF176E20
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 05:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgCCElj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Mar 2020 23:41:39 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33404 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCCElj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:41:39 -0500
Received: by mail-pj1-f65.google.com with SMTP id m7so710272pjs.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Mar 2020 20:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OIF+lnlYM2nHZ+5hN/WpLBOx7gByaLC97gJmvXQCmNc=;
        b=RfQXuKcNk9hwJmHcNM/ykdo2WTuikMLeAoQqW94A5IzhV321EuAANFWSjsG6r7LrpG
         20t5pEVwMzy98MTxZ8u2uHKeL4VTAf/6lQoCuwSyfs6upw6mruIv338un7E0JgRBRBbS
         E0ub5wAd5RW485MsOLy1VOKiaLLZM5Fa6YRDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OIF+lnlYM2nHZ+5hN/WpLBOx7gByaLC97gJmvXQCmNc=;
        b=jeVAYA/ECrdewHlxhShDLRJYT0P8QRoAZFCg6Hu9Ure6z14Ss5F01hInR37tHGa8wS
         b4CKsPOPZbd6HFuxkGAkimvL7x9LvrM4C6QfSB65jXj0uh2wIlaQrV3yYw2ovpys5DbZ
         B3qerPQ7CI845+IdnJUce6cDhIxoHR6/aKDJ3NbCIeZrr7d24NAeFbyMr9zg6RQCHlAt
         NnF1r+aBQzGtT8MmfyXj5hS5FMvGjKETEgavrsx7Mss5tBHCtupBcwiibI48KLeqUAXj
         owxyebtUCWHI/A6KKFGFk9EanPHuGZOv0HEjekqLN3bHpJn2bCIue1VNUZO4A8to1Y4m
         7CTg==
X-Gm-Message-State: ANhLgQ2oCQyK+y+Ewg9D9ytSvpps3DKZNhIfxEY1Z728JHyGAI5CoCE9
        RKz4u2DHGGmUc9tR2CXFllP6yw==
X-Google-Smtp-Source: ADFU+vsd7Eo9A6dkJsYDL/ZbxnknesyWa5rkdzVNc8GdvgllaMLgURZUe65Vn00p0hPHE0d6xSbBfQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr2423171plr.201.1583210496706;
        Mon, 02 Mar 2020 20:41:36 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w128sm22334651pgb.55.2020.03.02.20.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:41:35 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:41:34 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fcntl: Distribute switch variables for initialization
Message-ID: <202003022040.40A32072@keescook>
References: <20200220062243.68809-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200220062243.68809-1-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:22:43PM -0800, Kees Cook wrote:
> Variables declared in a switch statement before any case statements
> cannot be automatically initialized with compiler instrumentation (as
> they are not part of any execution flow). With GCC's proposed automatic
> stack variable initialization feature, this triggers a warning (and they
> don't get initialized). Clang's automatic stack variable initialization
> (via CONFIG_INIT_STACK_ALL=y) doesn't throw a warning, but it also
> doesn't initialize such variables[1]. Note that these warnings (or silent
> skipping) happen before the dead-store elimination optimization phase,
> so even when the automatic initializations are later elided in favor of
> direct initializations, the warnings remain.
> 
> To avoid these problems, move such variables into the "case" where
> they're used or lift them up into the main function body.
> 
> fs/fcntl.c: In function ‘send_sigio_to_task’:
> fs/fcntl.c:738:20: warning: statement will never be executed [-Wswitch-unreachable]
>   738 |   kernel_siginfo_t si;
>       |                    ^~
> 
> [1] https://bugs.llvm.org/show_bug.cgi?id=44916
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping. Can someone pick this up, please?

Thanks!

-Kees

> ---
>  fs/fcntl.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 9bc167562ee8..2e4c0fa2074b 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -735,8 +735,9 @@ static void send_sigio_to_task(struct task_struct *p,
>  		return;
>  
>  	switch (signum) {
> -		kernel_siginfo_t si;
> -		default:
> +		default: {
> +			kernel_siginfo_t si;
> +
>  			/* Queue a rt signal with the appropriate fd as its
>  			   value.  We use SI_SIGIO as the source, not 
>  			   SI_KERNEL, since kernel signals always get 
> @@ -769,6 +770,7 @@ static void send_sigio_to_task(struct task_struct *p,
>  			si.si_fd    = fd;
>  			if (!do_send_sig_info(signum, &si, p, type))
>  				break;
> +		}
>  		/* fall-through - fall back on the old plain SIGIO signal */
>  		case 0:
>  			do_send_sig_info(SIGIO, SEND_SIG_PRIV, p, type);
> 

-- 
Kees Cook
