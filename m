Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A234DC7C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 14:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbiCQNot (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 09:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234662AbiCQNos (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:44:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D36D5EBF;
        Thu, 17 Mar 2022 06:43:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C48761763;
        Thu, 17 Mar 2022 13:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF95BC340E9;
        Thu, 17 Mar 2022 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647524604;
        bh=ZGwhFr4HMMiHVx6F/dnRpUBbs08BVQzkS3x8lW+YnKw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=NzwiKeaJ+eZMgsLnO3UZb4GnQOeUQzt6QXy9qaN94dGXjNCEZ/QTeoNu+OKWCd+jy
         fLRW8X7E61VI8jSfzuj8K/68zk1XJYUkyEKuONcd0bBXM6hsyzxYnTKKi5GPnYIh03
         6vvEGiY+fLioIBr7P7LBIlcJUx71thHGUAMr24CNAwNX6TOk8aMCl76G57rwHB1Ksf
         IDigUZKfFtWKRRT4LGeSXhny//SJQu2Jhk1BVDY1vr3iotmdd/dgdC0CFPZe1RWyt9
         NGOxBSegOf8pKGcm7rrDw/sQMZdGoypJepNf8brGjD28HvLtom+amC1+5R+bIaRmuS
         MYJnWNh5FdcFg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 715905C0341; Thu, 17 Mar 2022 06:43:24 -0700 (PDT)
Date:   Thu, 17 Mar 2022 06:43:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair, RCU)
Message-ID: <20220317134324.GN4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220317004304.95F89C340E9@smtp.kernel.org>
 <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
 <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
 <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:52:44PM -0700, Randy Dunlap wrote:
> 
> 
> On 3/16/22 21:30, Andrew Morton wrote:
> > On Wed, 16 Mar 2022 21:21:16 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> > 
> >>
> >>
> >> On 3/16/22 17:43, Andrew Morton wrote:
> >>> The mm-of-the-moment snapshot 2022-03-16-17-42 has been uploaded to
> >>>
> >>>    https://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> mmotm-readme.txt says
> >>>
> >>> README for mm-of-the-moment:
> >>>
> >>> https://www.ozlabs.org/~akpm/mmotm/
> >>>
> >>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> >>> more than once a week.
> >>>
> >>> You will need quilt to apply these patches to the latest Linus release (5.x
> >>> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> >>> https://ozlabs.org/~akpm/mmotm/series
> >>
> >>
> >> UML for x86_64, defconfig:
> >>
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
> 
> 
> This fixes the build error for me when CONFIG_PSI=n.

Looks better than my approach of converting cgroup_move_task() to be
a macro.  ;-)

							Thanx, Paul

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
> 
> -- 
> ~Randy
