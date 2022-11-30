Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D61263D668
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Nov 2022 14:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbiK3NPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Nov 2022 08:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiK3NPI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Nov 2022 08:15:08 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2816B56D4B;
        Wed, 30 Nov 2022 05:15:08 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id C695B21ACC;
        Wed, 30 Nov 2022 13:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1669814106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=78kBTVjk9NN3b//OL4d2dPMzsmFl6kOFvw+wnxdUvC0=;
        b=CJ5yMJnrkOzf4sfqOWKQ1oSbCwMifCAwlufTAq1pWndcvZ5cAeOuB0nUqN676FKRXuNrLs
        VanShgHoCm8feQxtJEpumXrdKUFYdFlrhjNoHTeVkyWn3K/SDlL9mo3hqvI/V/M59IYJW1
        bgTi/RkuuLd/q/bmdszcfp1VvqnOwSE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C39C1331F;
        Wed, 30 Nov 2022 13:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id V0ynJVpXh2OuVwAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 30 Nov 2022 13:15:06 +0000
Date:   Wed, 30 Nov 2022 14:15:06 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     chengkaitao <pilgrimtao@gmail.com>
Cc:     tj@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        corbet@lwn.net, roman.gushchin@linux.dev, shakeelb@google.com,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        cgel.zte@gmail.com, ran.xiaokai@zte.com.cn,
        viro@zeniv.linux.org.uk, zhengqi.arch@bytedance.com,
        ebiederm@xmission.com, Liam.Howlett@oracle.com,
        chengzhihao1@huawei.com, haolee.swjtu@gmail.com, yuzhao@google.com,
        willy@infradead.org, vasily.averin@linux.dev, vbabka@suse.cz,
        surenb@google.com, sfr@canb.auug.org.au, mcgrof@kernel.org,
        sujiaxun@uniontech.com, feng.tang@intel.com,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcontrol: protect the memory in cgroup from being
 oom killed
Message-ID: <Y4dXWsaLKRwJvWEY@dhcp22.suse.cz>
References: <20221130070158.44221-1-chengkaitao@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130070158.44221-1-chengkaitao@didiglobal.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 30-11-22 15:01:58, chengkaitao wrote:
> From: chengkaitao <pilgrimtao@gmail.com>
> 
> We created a new interface <memory.oom.protect> for memory, If there is
> the OOM killer under parent memory cgroup, and the memory usage of a
> child cgroup is within its effective oom.protect boundary, the cgroup's
> tasks won't be OOM killed unless there is no unprotected tasks in other
> children cgroups. It draws on the logic of <memory.min/low> in the
> inheritance relationship.

Could you be more specific about usecases? How do you tune oom.protect
wrt to other tunables? How does this interact with the oom_score_adj
tunining (e.g. a first hand oom victim with the score_adj 1000 sitting
in a oom protected memcg)?

I haven't really read through the whole patch but this struck me odd.

> @@ -552,8 +552,19 @@ static int proc_oom_score(struct seq_file *m, struct pid_namespace *ns,
>  	unsigned long totalpages = totalram_pages() + total_swap_pages;
>  	unsigned long points = 0;
>  	long badness;
> +#ifdef CONFIG_MEMCG
> +	struct mem_cgroup *memcg;
>  
> -	badness = oom_badness(task, totalpages);
> +	rcu_read_lock();
> +	memcg = mem_cgroup_from_task(task);
> +	if (memcg && !css_tryget(&memcg->css))
> +		memcg = NULL;
> +	rcu_read_unlock();
> +
> +	update_parent_oom_protection(root_mem_cgroup, memcg);
> +	css_put(&memcg->css);
> +#endif
> +	badness = oom_badness(task, totalpages, MEMCG_OOM_PROTECT);

the badness means different thing depending on which memcg hierarchy
subtree you look at. Scaling based on the global oom could get really
misleading.

-- 
Michal Hocko
SUSE Labs
