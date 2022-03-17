Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EED4DD17C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Mar 2022 00:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiCQXw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 19:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiCQXwY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DD442B1209;
        Thu, 17 Mar 2022 16:51:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09546135C;
        Thu, 17 Mar 2022 23:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D9DC340E9;
        Thu, 17 Mar 2022 23:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647561062;
        bh=c5eoa7XecUk0qot+FwjPKZfT8TI4sQLGAehXwg8J1K8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oopVa0BAXrDMEKaNLsKFU0IN7quVxZGL8VjtKsp/HPcMyKTUFICek5K3+6YmMioil
         GQbiJmnXhz2lfDO+k+pYgTtLKpZebKFOCDtUZmEDUNkI9xnaen9trRAKRDI+u8gaaV
         9UGCX78YgwQ9lGVGWmyxgUXp2wqs3kSmxviMwB9w=
Date:   Thu, 17 Mar 2022 16:51:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair,
 RCU)
Message-Id: <20220317165100.2755c5ae6a3a08b7ecb06181@linux-foundation.org>
In-Reply-To: <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
        <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
        <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
        <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 16 Mar 2022 21:52:44 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> >> In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
> >>                  from ../include/linux/compiler.h:248,
> >>                  from ../include/linux/kernel.h:20,
> >>                  from ../include/linux/cpumask.h:10,
> >>                  from ../include/linux/energy_model.h:4,
> >>                  from ../kernel/sched/fair.c:23:
> >> ../include/linux/psi.h: In function ‘cgroup_move_task’:
> >> ../include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type ‘struct css_set’
> >>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
> >>                                     ^~~~
> > 
> > Works For Me.  I tried `make x86_64_defconfig' and `make i386_defconfig' too.
> > 
> > Can you please share that .config, or debug a bit?
> 
> $ make ARCH=um SUBARCH=x86_64 defconfig
> 

I still can't reproduce this :(

> This fixes the build error for me when CONFIG_PSI=n.

I have CONFIG_PSI=n

> ---
>  include/linux/psi.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- mmotm-2022-0316-1742.orig/include/linux/psi.h
> +++ mmotm-2022-0316-1742/include/linux/psi.h
> @@ -53,6 +53,9 @@ static inline int psi_cgroup_alloc(struc
>  static inline void psi_cgroup_free(struct cgroup *cgrp)
>  {
>  }
> +
> +#include <linux/cgroup-defs.h>
> +
>  static inline void cgroup_move_task(struct task_struct *p, struct css_set *to)
>  {
>  	rcu_assign_pointer(p->cgroups, to);

Nothing in -next touches psi.h so I am unable to determine which patch
needs fixing :(
