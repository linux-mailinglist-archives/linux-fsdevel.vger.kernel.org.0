Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D476D749748
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 10:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233831AbjGFISS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 04:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjGFISP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:18:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD1D1FCD;
        Thu,  6 Jul 2023 01:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ic9S92rG11eB3Mil6OSX84uIjeGI6KbMJWkDNWokDEY=; b=na4q44nbMfZC7izyi5ajSs6ppq
        bGmiaPfc5VPM0or3kB8A+OGoTRZ98DRuhWkPwu9v+PIv4Nl5Y7fwiSkmzoIYr19nFqpFZpqgweKaM
        TzyDub1JFUHz/W1M4AluZuqG+Ahlzdsy9itfLqsHqSnfFKmz6jzkQdD+ocNiKOr84TKlIRGquRitq
        a/nfcmQFW2VM86l23s2BxHC0p1Ix49+Y7CSgMcqpgH91ENR0Kwrs0NDHq1NKKZFbAwcVlLfvY8/xb
        Bj5iXoVeTwgb4jtHYlz0bpJPun29kzy8VGtAJ6+jOzFeTR7A64MG6OhfhHVT68MUU75SD/5Oqk0C9
        OOa76p+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHKAZ-00DWMA-13;
        Thu, 06 Jul 2023 08:16:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DCBBF30005E;
        Thu,  6 Jul 2023 10:16:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C3108212C1709; Thu,  6 Jul 2023 10:16:51 +0200 (CEST)
Date:   Thu, 6 Jul 2023 10:16:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lujialin4@huawei.com,
        lizefan.x@bytedance.com, hannes@cmpxchg.org, mingo@redhat.com,
        ebiggers@kernel.org, oleg@redhat.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/1] sched/psi: use kernfs polling functions for PSI
 trigger polling
Message-ID: <20230706081651.GF2833176@hirez.programming.kicks-ass.net>
References: <20230630005612.1014540-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630005612.1014540-1-surenb@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 29, 2023 at 05:56:12PM -0700, Suren Baghdasaryan wrote:
> Destroying psi trigger in cgroup_file_release causes UAF issues when
> a cgroup is removed from under a polling process. This is happening
> because cgroup removal causes a call to cgroup_file_release while the
> actual file is still alive. Destroying the trigger at this point would
> also destroy its waitqueue head and if there is still a polling process
> on that file accessing the waitqueue, it will step on the freed pointer:
> 
> do_select
>   vfs_poll
>                            do_rmdir
>                              cgroup_rmdir
>                                kernfs_drain_open_files
>                                  cgroup_file_release
>                                    cgroup_pressure_release
>                                      psi_trigger_destroy
>                                        wake_up_pollfree(&t->event_wait)
> // vfs_poll is unblocked
>                                        synchronize_rcu
>                                        kfree(t)
>   poll_freewait -> UAF access to the trigger's waitqueue head
> 
> Patch [1] fixed this issue for epoll() case using wake_up_pollfree(),
> however the same issue exists for synchronous poll() case.
> The root cause of this issue is that the lifecycles of the psi trigger's
> waitqueue and of the file associated with the trigger are different. Fix
> this by using kernfs_generic_poll function when polling on cgroup-specific
> psi triggers. It internally uses kernfs_open_node->poll waitqueue head
> with its lifecycle tied to the file's lifecycle. This also renders the
> fix in [1] obsolete, so revert it.
> 
> [1] commit c2dbe32d5db5 ("sched/psi: Fix use-after-free in ep_remove_wait_queue()")
> 
> Fixes: 0e94682b73bf ("psi: introduce psi monitor")
> Reported-by: Lu Jialin <lujialin4@huawei.com>
> Closes: https://lore.kernel.org/all/20230613062306.101831-1-lujialin4@huawei.com/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Thanks, I'll stuff it in sched/urgent after -rc1.
