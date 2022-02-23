Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6924C0771
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 02:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiBWBxr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 20:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiBWBxp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:53:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1131140D0;
        Tue, 22 Feb 2022 17:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nmGsASxqb+MnOtoYYKQXZIHbO3GwaQFoOdkWm5jmoJM=; b=0grOYvbRLMyeInOqRpatTB4kDK
        ylgquovMXA8rYNOxk9VD4QnAgxpfiyrHH0kQ61vvyVmSkGDouDDXPU9h5LjB5x/GdOxzlaH6GttMC
        gBfraw6yLi6VzblPb8IMdOyZWsMwQE9sRc6eCoD0uAKFLRtqx5H/lhvVW6nTF/X2AUO5qbjaKlmLz
        DjmJ7LAQvElNBDBXBYarMFxUe/lEdZw2u9BURRYPSRFUOKeLKkPhT7k1Uo5+EHpSMKKLX/vM+8rz9
        mqjbWjB7BVfMemt94RBD7hsdyiv4jcoTSbt5Wn3EvcVILGtV/V0tax9hqqm9T3PkuKX4u5YeDHLgn
        3q9rTCXA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nMgpv-00CDXW-M3; Wed, 23 Feb 2022 01:52:59 +0000
Date:   Tue, 22 Feb 2022 17:52:59 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Wei Xiao <xiaowei66@huawei.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, keescook@chromium.org,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, young.liuyang@huawei.com,
        zengweilin@huawei.com, nixiaoming@huawei.com
Subject: Re: [PATCH] ftrace: move sysctl_ftrace_enabled to ftrace.c
Message-ID: <YhWTezoFrIOEWXBZ@bombadil.infradead.org>
References: <20220223012311.134314-1-xiaowei66@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223012311.134314-1-xiaowei66@huawei.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:23:11AM +0800, Wei Xiao wrote:
> This moves ftrace_enabled to trace/ftrace.c.

Hey Wei, thanks for you patch!
                                                                                                                                                                                              
This does not explain how this is being to help with maitenance as
otherwise this makes kernel/sysctl.c hard to maintain and we also tend
to get many conflicts. It also does not explain how all the filesystem
sysctls are not gone and that this is just the next step, moving slowly
the rest of the sysctls. Explaining this in the commit log will help
patch review and subsystem maintainers understand the conext / logic
behind the move.
                                                                                                                                                                                              
I'd be more than happy to take this if ftrace folks Ack. To avoid conflicts
I can route this through sysctl-next which is put forward in particular
to avoid conflicts across trees for this effort. Let me know.

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9feb197b2da..4a5b4d6996a4 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7846,7 +7846,8 @@ static bool is_permanent_ops_registered(void)
>  	return false;
>  }
>  
> -int
> +#ifdef CONFIG_SYSCTL
> +static int

Is the ifdef really needed? It was not there before, ie, does
ftrace not depend on sysctls? I don't see a direct relationship
but I do wonder if its implicit.

>  ftrace_enable_sysctl(struct ctl_table *table, int write,
>  		     void *buffer, size_t *lenp, loff_t *ppos)
>  {
> @@ -7889,3 +7890,22 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
>  	mutex_unlock(&ftrace_lock);
>  	return ret;
>  }
> +
> +static struct ctl_table ftrace_sysctls[] = {
> +	{
> +		.procname       = "ftrace_enabled",
> +		.data           = &ftrace_enabled,
> +		.maxlen         = sizeof(int),
> +		.mode           = 0644,
> +		.proc_handler   = ftrace_enable_sysctl,
> +	},
> +	{}
> +};
> +
> +static int __init ftrace_sysctl_init(void)
> +{
> +	register_sysctl_init("kernel", ftrace_sysctls);
> +	return 0;
> +}
> +late_initcall(ftrace_sysctl_init);
> +#endif

There's other __init calls already on ftrace, would this be better
placed in one of them, and then have this be a no-op iff we determine
ftrace can be built without sysctls and then have a no-op for when
sysctls are disabled.

  Luis
