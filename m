Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DF9545118
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 17:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiFIPme (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 11:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240677AbiFIPme (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:42:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D562FD71;
        Thu,  9 Jun 2022 08:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CQ7kxoNc1J/3qfbnkk7ichwcTqyCEF4/bJOjjfrta9o=; b=W3mzh0N4UsbyfO2VQy7s3AC1QV
        flEJsL7jDSolareMiBm+pVDVNPwSR10mtOxwh++Ygt6fsO3oVSUGL5dnRmeoggG78FYCr8nEVlmhM
        2cn0wjiYW5bZu7A3plzJclfhAWlIcXIRb9e68tp0kJGGGobtlFk+/CiSyQSoYqpQSZjTVFhDwlTre
        kX1yI0Jx27rUsQLutuPiQQXE56Zx+rELx5SOpnQ8PLVdsKgMA5pMBLCj2E5QTYyxWKEijrUrXjl+k
        dlvDf6PotFA2uZIdstzEg3c1qdft0ZJtcmDoJYfOhxnryXSqhfEE5TqratNTKVarMaZQU1P7Acwim
        e4yuK4QA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzKIf-002lL5-3l; Thu, 09 Jun 2022 15:42:21 +0000
Date:   Thu, 9 Jun 2022 08:42:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>,
        Kees Cook <keescook@chromium.org>, Jia He <hejianet@gmail.com>,
        Pan Xinhui <xinhui@linux.vnet.ibm.com>,
        Thomas Huth <thuth@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        willy@infradead.org, duanxiongchun@bytedance.com,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: [PATCH v3] sysctl: handle table->maxlen robustly for proc_dobool
Message-ID: <YqIU3U+l1EDy7OgZ@bombadil.infradead.org>
References: <20220525065050.38905-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525065050.38905-1-songmuchun@bytedance.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please Cc the original authors of code if sending some follow up
possible enhancements.

On Wed, May 25, 2022 at 02:50:50PM +0800, Muchun Song wrote:
> Setting ->proc_handler to proc_dobool at the same time setting ->maxlen
> to sizeof(int) is counter-intuitive, it is easy to make mistakes in the
> future (When I first use proc_dobool() in my driver, I assign
> sizeof(variable) to table->maxlen.  Then I found it was wrong, it should
> be sizeof(int) which was very counter-intuitive). 

How did you find this out? If I change fs/lockd/svc.c's use I get
compile warnings on at least x86_64.

> For robustness,
> rework proc_dobool() robustly. 

You mention robustness twice. Just say something like:

To help make things clear, make the logic used by proc_dobool() very
clear with regards to its requirement with working with bools.

> So it is an improvement not a real bug
> fix.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Iurii Zaikin <yzaikin@google.com>
> ---
> v3:
>  - Update commit log.
> 
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

Should this be a separate patch? What about the rest of the kernel?
I see it is only used once so the one commit should mention that also.

Or did chaning this as you have it now alter the way the kernel
treats this sysctl? All these things would be useful to clarify
in the commit log.

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

Previously do_proc_douintvec() is called, and that checks if table->data
is NULL previously before reading it and if so bails on
__do_proc_dointvec() as follows:

        if (!tbl_data || !table->maxlen || !*lenp || (*ppos && !write)) {
		*lenp = 0;
		return 0;
	}

Is it possible to have table->data be NULL? I think that's where the
above check comes from.

And, so if it was false but not NULL, would it never do anything?

You can use lib/test_sysctl.c for this to proove / disprove correct
functionality.

> +	unsigned int val = READ_ONCE(*data);
> +	int ret;
> +
> +	/* Do not support arrays yet. */
> +	if (table->maxlen != sizeof(bool))
> +		return -EINVAL;

This is a separate change, and while I agree with it, as it simplifies
our implementation and we don't want to add more array crap support,
this should *alone* should be a separate commit.

> +
> +	tmp.maxlen = sizeof(val);

Why even set this as you do when we know it must be sizeof(bool)?
Or would this break things given do_proc_douintvec() is used?

> +	tmp.data = &val;
> +	ret = do_proc_douintvec(&tmp, write, buffer, lenp, ppos, NULL, NULL);

Ugh, since we are avoiding arrays and we are only dealing with bools
I'm inclined to just ask we simpify this a bool implementation which
does something like do_proc_do_bool() but without array and is optimized
just for bools.

The current hoops to read this code is simplly irritating

  Luis

> +	if (ret)
> +		return ret;
> +	if (write)
> +		WRITE_ONCE(*data, val ? true : false);
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.11.0
> 
