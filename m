Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93AD4B5D19
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 22:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiBNVlg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 16:41:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiBNVla (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:41:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2431AF2A;
        Mon, 14 Feb 2022 13:41:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2BA614AB;
        Mon, 14 Feb 2022 21:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BD9EC340F0;
        Mon, 14 Feb 2022 21:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644874880;
        bh=PIdf2fTE/JbbJZPbCMEI4xkJ/6UtHxaqNLp2TxjzPVQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=f/q76W49+5AYJc/EBJA1jdPq2br+g+tNRm2EOEfVGRLl9WPp5Dy+0eL87BHctxrre
         w8cAyno4f/oXQlUd3ts/9c9DjDCNoPgpeToRdo5YQ0qzd1OadZ1sAPRZVOWq5sKEJN
         iv61aUPZ6ZZ7blt3wcWQ7JNtU2Y3i7nUOK45vXar3KViAqE4tL7iegO18fgLGBR2XE
         ffLc2RRveFCWT5XLIJtOxwsQ4uiOq9M1gF4Plr+fq8k7O0gJNKLBHXG9n+9bBBprmb
         e1yfNYZOvCi8Hlv6sildSpBmg0DTxTa70s+6Kzj+FyCDplmMsFIH1cwsmZh5xMAWbS
         w5JqQCd3x9Y/A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id DFF345C0388; Mon, 14 Feb 2022 13:41:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:41:19 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Chris Mason <clm@fb.com>, Giuseppe Scrivano <gscrivan@redhat.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Message-ID: <20220214214119.GD4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220214190549.GA2815154@paulmck-ThinkPad-P17-Gen-1>
 <C88FC9A7-D6AD-4382-B74A-175922F57852@fb.com>
 <20220214194440.GZ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220214155536.1e0da8b6@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214155536.1e0da8b6@imladris.surriel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 14, 2022 at 03:55:36PM -0500, Rik van Riel wrote:
> On Mon, 14 Feb 2022 11:44:40 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > On Mon, Feb 14, 2022 at 07:26:49PM +0000, Chris Mason wrote:
> 
> > Moving from synchronize_rcu() to synchronize_rcu_expedited() does buy
> > you at least an order of magnitude.  But yes, it should be possible to
> > get rid of all but one call per batch, which would be better.  Maybe
> > a bit more complicated, but probably not that much.
> 
> It doesn't look too bad, except for the include of ../fs/mount.h.
> 
> I'm hoping somebody has a better idea on how to deal with that.
> Do we need a kern_unmount() variant that doesn't do the RCU wait,
> or should it get a parameter, or something else?
> 
> Is there an ordering requirement between the synchronize_rcu call
> and zeroing out n->mq_mnt->mnt_ls?
> 
> What other changes do we need to make everything right?
> 
> The change below also fixes the issue that to-be-freed items that
> are queued up while the free_ipc work function runs do not result
> in the work item being enqueued again.
> 
> This patch is still totally untested because the 4 year old is
> at home today :)

I agree that this should decrease grace-period latency quite a bit
more than does my patch, so here is hoping that it does work.  ;-)

							Thanx, Paul

> diff --git a/ipc/namespace.c b/ipc/namespace.c
> index 7bd0766ddc3b..321cbda17cfb 100644
> --- a/ipc/namespace.c
> +++ b/ipc/namespace.c
> @@ -17,6 +17,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/sched/task.h>
>  
> +#include "../fs/mount.h"
>  #include "util.h"
>  
>  static struct ucounts *inc_ipc_namespaces(struct user_namespace *ns)
> @@ -117,10 +118,7 @@ void free_ipcs(struct ipc_namespace *ns, struct ipc_ids *ids,
>  
>  static void free_ipc_ns(struct ipc_namespace *ns)
>  {
> -	/* mq_put_mnt() waits for a grace period as kern_unmount()
> -	 * uses synchronize_rcu().
> -	 */
> -	mq_put_mnt(ns);
> +	mntput(ns->mq_mnt);
>  	sem_exit_ns(ns);
>  	msg_exit_ns(ns);
>  	shm_exit_ns(ns);
> @@ -134,11 +132,19 @@ static void free_ipc_ns(struct ipc_namespace *ns)
>  static LLIST_HEAD(free_ipc_list);
>  static void free_ipc(struct work_struct *unused)
>  {
> -	struct llist_node *node = llist_del_all(&free_ipc_list);
> +	struct llist_node *node;
>  	struct ipc_namespace *n, *t;
>  
> -	llist_for_each_entry_safe(n, t, node, mnt_llist)
> -		free_ipc_ns(n);
> +	while ((node = llist_del_all(&free_ipc_list))) {
> +		llist_for_each_entry(n, node, mnt_llist)
> +			real_mount(n->mq_mnt)->mnt_ns = NULL;
> +
> +		/* Wait for the last users to have gone away. */
> +		synchronize_rcu();
> +
> +		llist_for_each_entry_safe(n, t, node, mnt_llist)
> +			free_ipc_ns(n);
> +	}
>  }
>  
>  /*
> 
