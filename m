Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC16F29A25D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Oct 2020 02:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504140AbgJ0BuD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 21:50:03 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45018 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504116AbgJ0BuC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 21:50:02 -0400
Received: by mail-qk1-f194.google.com with SMTP id s14so10362711qkg.11;
        Mon, 26 Oct 2020 18:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MkBL9kxBLfwKS6bNUgGvrFCUEtAsRRukONV85cWDUo=;
        b=rywBgHtMkuYcOIAx0/eM0hJdL79pLHetO0IABCHPLSfzmPUgt7EUYlKTKKAqI0FN0J
         UREI1vUMa/y5nIRYiDgJVt17ZQ5ZRa6D2i+JK6KPSwSm+M/kpwRPYdrSk/B2VsSQY+xq
         iT7fMX8hRIt/9FjUZnVXeXFSiBey807KHUJKL3uaa9gC03O+S0nGaL/2crDjxEiVyPmw
         iTXTETwfahJM4Mn3PIaNgOrs5cFsHnIjFGK/pyY4w5HeHsSgm4ltobzJCAq2mW8l1kGh
         cLfN3gfL1HIVwuF3FB45g8IjVYM32JDk8NHu3ia1U+R28ZrrWXj6NRY4ktpAipmJ70uB
         g0cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MkBL9kxBLfwKS6bNUgGvrFCUEtAsRRukONV85cWDUo=;
        b=KMSoHjkIu1KuqY/x+5ihJljAAFQ6GvHE9x9E8ZX4hSwnM+zIzLJ7bBnMkIZ6INfEWX
         ekikWfyCu0vmH9XU4xjVW2hA1n3yZt54P4oFcM9BF0uAjuL0m4G0tkYuJ9Vin/AlV0nm
         72OtD3dhwkzee4adw9hU9IeFONqg3X0zY7MvL53RD5RT/gq43lyQuRfU4qCQbkfOc4bC
         pTJyLaUagbQOrwRAWtpjziWw5MHsosMPNL5mrAGvuMronmYySqVX/5FLQU/NVyvX+KKk
         PfBgCiImMau6FvcpHpsGAC6bnlBm0hmyfXNjrVjYLn/jfpJeAQDmsYiSM6eFcvOq0lxR
         4w0Q==
X-Gm-Message-State: AOAM531k5qs/Mvf2SaPn0yxNXqYNN9w7/MDAldB4jrNUR8yKQ1j8BfXB
        qYN/LDKbdJvqyBkKo3VKbeQ=
X-Google-Smtp-Source: ABdhPJxyHu+J3aVKWSpNlK35L0dNRNF6ZsDE6zT4ZHnfX80nmN8o01G5PAI6bC2nl5AfmOOKjmETWg==
X-Received: by 2002:ae9:e709:: with SMTP id m9mr19494855qka.397.1603763401118;
        Mon, 26 Oct 2020 18:50:01 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45d1:2600::3])
        by smtp.gmail.com with ESMTPSA id 6sm1570qtz.31.2020.10.26.18.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 18:50:00 -0700 (PDT)
Date:   Mon, 26 Oct 2020 18:49:59 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] seq_file: fix clang warning for NULL pointer arithmetic
Message-ID: <20201027014959.GC368335@ubuntu-m3-large-x86>
References: <20201026215321.3894419-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026215321.3894419-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 26, 2020 at 10:52:56PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang points out that adding something to NULL is notallowed
> in standard C:
> 
> fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>                 return NULL + !*ppos;
>                        ~~~~ ^
> fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>         return NULL + (*pos == 0);
> 
> Rephrase the function to do the same thing without triggering that
> warning. Linux already relies on a specific binary representation
> of NULL, so it makes no real difference here. The instance in
> kernfs was copied from single_start, so fix both at once.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  fs/kernfs/file.c | 2 +-
>  fs/seq_file.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index f277d023ebcd..b55e6ef4d677 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -124,7 +124,7 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  		 * The same behavior and code as single_open().  Returns
>  		 * !NULL if pos is at the beginning; otherwise, NULL.
>  		 */
> -		return NULL + !*ppos;
> +		return (void *)(uintptr_t)!*ppos;
>  	}
>  }
>  
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 31219c1db17d..d456468eb934 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -526,7 +526,7 @@ EXPORT_SYMBOL(seq_dentry);
>  
>  static void *single_start(struct seq_file *p, loff_t *pos)
>  {
> -	return NULL + (*pos == 0);
> +	return (void *)(uintptr_t)(*pos == 0);
>  }
>  
>  static void *single_next(struct seq_file *p, void *v, loff_t *pos)
> -- 
> 2.27.0
> 
