Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F0E1D47BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 10:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEOIGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726714AbgEOIGa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 04:06:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D1AC05BD09
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:06:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id hi11so599142pjb.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 01:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jG2zPlUjuy3TaHmBjzz54CmTcwOEHnFNJYuMRLsgt3o=;
        b=DUoew+YPlBJlFGhJMGcpvILcRmegBRmwn4SG3fljK7KRjGVaf+NbqI92muMsHhxSzd
         uoD3o+TE+gzuBuLRMXyeGXGh/xmzjhB0YkePh8Qst7glNg/dJ9vLFvlTK+c+5GA2/Kb1
         YMiG3vnsDsll6LQA876jclVWLpEEl50gQNWrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jG2zPlUjuy3TaHmBjzz54CmTcwOEHnFNJYuMRLsgt3o=;
        b=Sk2gfWSGm6D7ZWGllhHV0G063D8EBI7ouMYiukgSrvEaonnCgzAcCIoL2SHVKWTl9x
         ygndctt5DWMTTww8ClsihV7ivTIa7LMaH5iao2pMDQsoHDGqUKWv9K1dOV8wlm6V2ASr
         viTZ5wQMN6orZoN7EyLO2kPlVlG2rgOZavdBU8k95BdrifZO9OdvNlJmeKDkRKhTx0Dw
         EhYYBPNo/I0QFvuuXXEIMBXA0X+Bb/pcIme2xrrk5CPy0Vhkz0RPHEC7X6xNKsGdQTFu
         zD5uMwOQxmFwnKiQOvA/17s8xYHAEu7IYTbKC5HCVtgtIsY1VuCgk5c7RixclQo5kpKW
         k5Yw==
X-Gm-Message-State: AOAM530IR4C4wGyAwILFXEiI+TvhHUhPPfuCwJqxRsoShZ8l+UEatUyY
        R6JjqDS73RQzr2Y3TPiRcP/LAg==
X-Google-Smtp-Source: ABdhPJwivc3rrGEJYMaQgUVSdU6qrOT33KMO3Id4LWhkBY0GN66928/qLjX4HIpzdr1su8//lFZRIg==
X-Received: by 2002:a17:902:6b4a:: with SMTP id g10mr2398745plt.141.1589529989396;
        Fri, 15 May 2020 01:06:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e11sm1105913pgs.41.2020.05.15.01.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 01:06:28 -0700 (PDT)
Date:   Fri, 15 May 2020 01:06:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
Message-ID: <202005150105.33CAEEA6C5@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
> Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
> used in both sysctl_writes_strict and hung_task_warnings.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  fs/proc/proc_sysctl.c     | 2 +-
>  include/linux/sysctl.h    | 1 +
>  kernel/hung_task_sysctl.c | 3 +--
>  kernel/sysctl.c           | 3 +--

How about doing this refactoring in advance of the extraction patch?

>  4 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index b6f5d45..acae1fa 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -23,7 +23,7 @@
>  static const struct inode_operations proc_sys_dir_operations;
>  
>  /* shared constants to be used in various sysctls */
> -const int sysctl_vals[] = { 0, 1, INT_MAX };
> +const int sysctl_vals[] = { 0, 1, INT_MAX, -1 };
>  EXPORT_SYMBOL(sysctl_vals);
>  
>  /* Support for permanently empty directories */
> diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> index 02fa844..6d741d6 100644
> --- a/include/linux/sysctl.h
> +++ b/include/linux/sysctl.h
> @@ -41,6 +41,7 @@
>  #define SYSCTL_ZERO	((void *)&sysctl_vals[0])
>  #define SYSCTL_ONE	((void *)&sysctl_vals[1])
>  #define SYSCTL_INT_MAX	((void *)&sysctl_vals[2])
> +#define SYSCTL_NEG_ONE	((void *)&sysctl_vals[3])

Nit: let's keep these value-ordered? i.e. -1, 0, 1, INT_MAX.

-- 
Kees Cook
