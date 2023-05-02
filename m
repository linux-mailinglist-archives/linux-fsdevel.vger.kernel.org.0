Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B496F4AA9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 21:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjEBT4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 15:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEBT4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 15:56:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319A41735
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 12:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683057366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMs73NusrIc3WnWcdl7Fx0I1f6axuQqjUOBlJwm9l/c=;
        b=Zi9yqxZfswtHpozcQb6rCoYep0XvjfQDO9h9pNB393O8ZFDEXdZKw0uZ6uIqWmJX4EfNaz
        uXPyxckWcuu/FvFGs11zsZVb8CyVCl/rP7xCD6L3bExLrdyahAbLHH4DQM996KZE9MYr6f
        FFMZ7bf0R9612ss10YmFPcKD2rwvbAA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-pHBg26pUOea2cWuITsTWXQ-1; Tue, 02 May 2023 15:56:03 -0400
X-MC-Unique: pHBg26pUOea2cWuITsTWXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 65A3F3815F69;
        Tue,  2 May 2023 19:56:02 +0000 (UTC)
Received: from [10.22.10.239] (unknown [10.22.10.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEBEB2166B26;
        Tue,  2 May 2023 19:56:01 +0000 (UTC)
Message-ID: <9e149289-c1c0-3297-145d-ad3a890056ac@redhat.com>
Date:   Tue, 2 May 2023 15:56:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 3/3] cgroup: Do not take css_set_lock in
 cgroup_show_path
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-4-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230502133847.14570-4-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/23 09:38, Michal Koutný wrote:
> /proc/$pid/mountinfo may accumulate lots of entries (causing frequent
> re-reads of whole file) or lots cgroupfs entries alone.
> The cgroupfs entries rendered with cgroup_show_path() may increase/be
> subject of css_set_lock contention causing further slowdown -- not only
> mountinfo rendering but any other css_set_lock user.
>
> We leverage the fact that mountinfo reading happens with namespace_sem
> taken and hierarchy roots thus cannot be freed concurrently.
>
> There are three relevant nodes for each cgroupfs entry:
>
>          R ... cgroup hierarchy root
>          M ... mount root
>          C ... reader's cgroup NS root
>
> mountinfo is supposed to show path from C to M.
>
> Current's css_set (and linked root cgroups) are stable under
> namespace_sem, therefore current_cgns_cgroup_from_root() doesn't need
> css_set_lock.
>
> When the path is assembled in kernfs_path_from_node(), we know that:
> - C kernfs_node is (transitively) pinned via current->nsproxy,
> - M kernfs_node is pinned thanks to namespace_sem,
> - path C to M is pinned via child->parent references (this holds also
>    when C and M are in distinct subtrees).
>
> Streamline mountinfo rendering a bit by relieving css_set_lock and add
> careful notes about that.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   kernel/cgroup/cgroup.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 32d693a797b9..e2ec6f0028be 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1407,12 +1407,18 @@ static inline struct cgroup *__cset_cgroup_from_root(struct css_set *cset,
>   	struct cgroup *res_cgroup = NULL;
>   
>   	if (cset == &init_css_set) {
> +		/* callers must ensure root stability */
>   		res_cgroup = &root->cgrp;
>   	} else if (root == &cgrp_dfl_root) {
>   		res_cgroup = cset->dfl_cgrp;
>   	} else {
>   		struct cgrp_cset_link *link;
> -		lockdep_assert_held(&css_set_lock);
> +		/* cset's cgroups are pinned unless they are root cgroups that
> +		 * were unmounted.  We look at links to !cgrp_dfl_root
> +		 * cgroup_root, either lock ensures the list is not mutated
> +		 */
> +		lockdep_assert(lockdep_is_held(&css_set_lock) ||
> +			       lockdep_is_held_type(&namespace_sem, -1));
Again lockdep_is_held(&namespace_sem) is good enough.

>   
>   		list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
>   			struct cgroup *c = link->cgrp;
> @@ -1438,8 +1444,6 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
>   	struct cgroup *res = NULL;
>   	struct css_set *cset;
>   
> -	lockdep_assert_held(&css_set_lock);
> -
>   	/* namespace_sem ensures `root` stability on unmount */
>   	lockdep_assert(lockdep_is_held_type(&namespace_sem, -1));
>   
> @@ -1905,10 +1909,8 @@ int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
>   	if (!buf)
>   		return -ENOMEM;
>   
> -	spin_lock_irq(&css_set_lock);
>   	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
>   	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
> -	spin_unlock_irq(&css_set_lock);
>   
>   	if (len >= PATH_MAX)
>   		len = -ERANGE;
Cheers,
Longman

