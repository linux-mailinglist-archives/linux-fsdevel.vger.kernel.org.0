Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFE5318BD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 22:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiEWTnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiEWTlC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 15:41:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EA75D64A
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 12:33:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so174034pjr.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NVlDB1s2Fp2J9VDbXvgnpB1s+l1LaAHQJIkv95Bbp4U=;
        b=AaPjm62hzgtHtsCiRk8NxmY0FjLUROgL0G36RUr8lfkeaA2wUD5eina47R/s7YJt6E
         pHrVK15DGCRLPBjz7KXMDl+GxHAjpaDRUfe6nAoKnf6DM9yyExZGmd2Eewy6tJSocNl+
         mkmGP1ENSTHRKb0gMJcXJsGXMhOJUbyTYF/qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NVlDB1s2Fp2J9VDbXvgnpB1s+l1LaAHQJIkv95Bbp4U=;
        b=uqDPh2Uu+04OlgJ98L3Bq8VDbBZ59KYjDXJRtYmy9ZQrHoP3aCmqcCVh+poQL8K7mJ
         E3Fi208/jcn/cKGCEMvQ4BMwBJsppq6+KW4wF7ErROno9DLhGK/+aC+wXNaqHdBMqDUc
         1GI1Luffqa5xi+DkVZDnkJ5Z6j+T0MLIMYkd7pvJzws12BzP283fscQqadfxj/UPh2wO
         DoE0TxLLBrHCAqkVmJ6GzYMg+O08h55SK5UDHBTFh7YTBhVL3fEaIoBHJixTs6VcL3ZH
         TpaF+fFvBctcfvn3O4t7GvPiy9IsulkPqkRsGFYn8gix5fDpyWKzLsg6SgZP3cEe3HSS
         ++AA==
X-Gm-Message-State: AOAM530lvkoLiPNhzPLLFKfWF5tMyd77Bl7g6OeXPuXPYAsl8eIpZFGT
        voYNtlpsvDa1eawXuKoe6gCqMpLpTc4tnA==
X-Google-Smtp-Source: ABdhPJyrw40mQ/7xNmPTJBBnF6TdtovH/QjNKowLyGB0h5EmZKiLK0YHQtEUVSMAn+MKVewMfm3OyA==
X-Received: by 2002:a17:90b:1a81:b0:1e0:3314:2447 with SMTP id ng1-20020a17090b1a8100b001e033142447mr538738pjb.121.1653334436133;
        Mon, 23 May 2022 12:33:56 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm74596pjb.16.2022.05.23.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:33:55 -0700 (PDT)
Date:   Mon, 23 May 2022 12:33:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v2] sysctl: handle table->maxlen properly for proc_dobool
Message-ID: <202205231233.EE3AB926@keescook>
References: <20220522052624.21493-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220522052624.21493-1-songmuchun@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 01:26:24PM +0800, Muchun Song wrote:
> Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> to sizeof(int) is counter-intuitive, it is easy to make mistakes.  For
> robustness, fix it by reimplementing proc_dobool() properly.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> ---
> v2:
>  - Reimplementing proc_dobool().
> 
>  fs/lockd/svc.c  |  2 +-
>  kernel/sysctl.c | 38 +++++++++++++++++++-------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 59ef8a1f843f..6e48ee787f49 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -496,7 +496,7 @@ static struct ctl_table nlm_sysctls[] = {
>  	{
>  		.procname	= "nsm_use_hostnames",
>  		.data		= &nsm_use_hostnames,
> -		.maxlen		= sizeof(int),
> +		.maxlen		= sizeof(nsm_use_hostnames),
>  		.mode		= 0644,
>  		.proc_handler	= proc_dobool,
>  	},

This hunk is fine -- it's a reasonable fix-up.

> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index e52b6e372c60..50a2c29efc94 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -423,21 +423,6 @@ static void proc_put_char(void **buf, size_t *size, char c)
>  	}
>  }
>  
> -static int do_proc_dobool_conv(bool *negp, unsigned long *lvalp,
> -				int *valp,
> -				int write, void *data)
> -{
> -	if (write) {
> -		*(bool *)valp = *lvalp;
> -	} else {
> -		int val = *(bool *)valp;
> -
> -		*lvalp = (unsigned long)val;
> -		*negp = false;
> -	}
> -	return 0;
> -}
> -
>  static int do_proc_dointvec_conv(bool *negp, unsigned long *lvalp,
>  				 int *valp,
>  				 int write, void *data)
> @@ -708,16 +693,31 @@ int do_proc_douintvec(struct ctl_table *table, int write,
>   * @lenp: the size of the user buffer
>   * @ppos: file position
>   *
> - * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
> - * values from/to the user buffer, treated as an ASCII string.
> + * Reads/writes up to table->maxlen/sizeof(bool) bool values from/to
> + * the user buffer, treated as an ASCII string.
>   *
>   * Returns 0 on success.
>   */
>  int proc_dobool(struct ctl_table *table, int write, void *buffer,
>  		size_t *lenp, loff_t *ppos)
>  {
> -	return do_proc_dointvec(table, write, buffer, lenp, ppos,
> -				do_proc_dobool_conv, NULL);
> +	struct ctl_table tmp = *table;
> +	bool *data = table->data;
> +	unsigned int val = READ_ONCE(*data);
> +	int ret;
> +
> +	/* Do not support arrays yet. */
> +	if (table->maxlen != sizeof(bool))
> +		return -EINVAL;
> +
> +	tmp.maxlen = sizeof(val);
> +	tmp.data = &val;
> +	ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);
> +	if (ret)
> +		return ret;
> +	if (write)
> +		WRITE_ONCE(*data, val ? true : false);
> +	return 0;
>  }

This part I don't understand -- it just inlines do_proc_dobool_conv(),
and I think detracts from readability.

-- 
Kees Cook
