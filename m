Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C648C4C07A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Feb 2022 03:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbiBWCNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Feb 2022 21:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiBWCNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:13:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5661436B62;
        Tue, 22 Feb 2022 18:13:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 902A161133;
        Wed, 23 Feb 2022 02:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E3AC340E8;
        Wed, 23 Feb 2022 02:13:05 +0000 (UTC)
Date:   Tue, 22 Feb 2022 21:13:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Wei Xiao <xiaowei66@huawei.com>, mingo@redhat.com,
        keescook@chromium.org, yzaikin@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        young.liuyang@huawei.com, zengweilin@huawei.com,
        nixiaoming@huawei.com
Subject: Re: [PATCH] ftrace: move sysctl_ftrace_enabled to ftrace.c
Message-ID: <20220222211303.402e3e4d@rorschach.local.home>
In-Reply-To: <YhWTezoFrIOEWXBZ@bombadil.infradead.org>
References: <20220223012311.134314-1-xiaowei66@huawei.com>
        <YhWTezoFrIOEWXBZ@bombadil.infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 22 Feb 2022 17:52:59 -0800
Luis Chamberlain <mcgrof@kernel.org> wrote:

> On Wed, Feb 23, 2022 at 09:23:11AM +0800, Wei Xiao wrote:
> > This moves ftrace_enabled to trace/ftrace.c.  
> 
> Hey Wei, thanks for you patch!
>                                                                                                                                                                                               
> This does not explain how this is being to help with maitenance as
> otherwise this makes kernel/sysctl.c hard to maintain and we also tend
> to get many conflicts. It also does not explain how all the filesystem
> sysctls are not gone and that this is just the next step, moving slowly
> the rest of the sysctls. Explaining this in the commit log will help
> patch review and subsystem maintainers understand the conext / logic
> behind the move.
>                                                                                                                                                                                               
> I'd be more than happy to take this if ftrace folks Ack. To avoid conflicts
> I can route this through sysctl-next which is put forward in particular
> to avoid conflicts across trees for this effort. Let me know.

I'm fine with this change going through another tree.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

for your convenience.

> 
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index f9feb197b2da..4a5b4d6996a4 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -7846,7 +7846,8 @@ static bool is_permanent_ops_registered(void)
> >  	return false;
> >  }
> >  
> > -int
> > +#ifdef CONFIG_SYSCTL
> > +static int  
> 
> Is the ifdef really needed? It was not there before, ie, does
> ftrace not depend on sysctls? I don't see a direct relationship
> but I do wonder if its implicit.

I think because the function is now static, and that it now includes the
structure itself, that the #ifdef is added. When I first saw it, I was
a bit uncomfortable with adding more #ifdefs, but for this use case, I
believe it's OK.

> 
> >  ftrace_enable_sysctl(struct ctl_table *table, int write,
> >  		     void *buffer, size_t *lenp, loff_t *ppos)
> >  {
> > @@ -7889,3 +7890,22 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
> >  	mutex_unlock(&ftrace_lock);
> >  	return ret;
> >  }
> > +
> > +static struct ctl_table ftrace_sysctls[] = {
> > +	{
> > +		.procname       = "ftrace_enabled",
> > +		.data           = &ftrace_enabled,
> > +		.maxlen         = sizeof(int),
> > +		.mode           = 0644,
> > +		.proc_handler   = ftrace_enable_sysctl,
> > +	},
> > +	{}
> > +};
> > +
> > +static int __init ftrace_sysctl_init(void)
> > +{
> > +	register_sysctl_init("kernel", ftrace_sysctls);
> > +	return 0;
> > +}
> > +late_initcall(ftrace_sysctl_init);
> > +#endif  
> 
> There's other __init calls already on ftrace, would this be better
> placed in one of them, and then have this be a no-op iff we determine
> ftrace can be built without sysctls and then have a no-op for when
> sysctls are disabled.

I rather have the initcall here, as the other initcalls are special
needs, and not generic functions.

-- Steve
