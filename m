Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812336F4A9A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 21:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjEBTvx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 15:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjEBTvw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 15:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EAF1BFA
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 12:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683057064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0u1c/zI7EG5oA8EEQf+n5SVUWPETfw09W7j85YlQyd0=;
        b=IdzIcJ/kRFV1yYUK4HIdiN69G4b2bLARjoPAnaQ1xn9u9Q2DWxMZp8ReVuiicJ28rJ/qfU
        7+nLBevIfYZujYs18MSsrMXD6yukaQ1642CzeiN4ghkYgwwDfDxkCe9JpQyTuAHQint6Z6
        Ihm8+0KYCvdeqcW1wll8kzBlF/dYy8A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-116-lQVk6mbDNhe49U8jj1AyhQ-1; Tue, 02 May 2023 15:51:01 -0400
X-MC-Unique: lQVk6mbDNhe49U8jj1AyhQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 401FE1C068C2;
        Tue,  2 May 2023 19:51:00 +0000 (UTC)
Received: from [10.22.10.239] (unknown [10.22.10.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 563C6492C13;
        Tue,  2 May 2023 19:50:59 +0000 (UTC)
Message-ID: <0beea9a5-a163-75e2-59c2-2b092fe96d16@redhat.com>
Date:   Tue, 2 May 2023 15:50:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/3] cgroup: Rely on namespace_sem in
 current_cgns_cgroup_from_root explicitly
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
 <20230502133847.14570-3-mkoutny@suse.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230502133847.14570-3-mkoutny@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/2/23 09:38, Michal Koutný wrote:
> The function current_cgns_cgroup_from_root() expects a stable
> cgroup_root, which is currently ensured with RCU read side paired with
> cgroup_destroy_root() called after RCU period.
>
> The particular current_cgns_cgroup_from_root() is called from VFS code
> and cgroup_root stability can be also ensured by namespace_sem. Mark it
> explicitly as a preparation for further rework.
>
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
> ---
>   fs/namespace.c         | 5 ++++-
>   include/linux/mount.h  | 4 ++++
>   kernel/cgroup/cgroup.c | 7 +++----
>   3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 54847db5b819..0d2333832064 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -71,7 +71,10 @@ static DEFINE_IDA(mnt_group_ida);
>   static struct hlist_head *mount_hashtable __read_mostly;
>   static struct hlist_head *mountpoint_hashtable __read_mostly;
>   static struct kmem_cache *mnt_cache __read_mostly;
> -static DECLARE_RWSEM(namespace_sem);
> +DECLARE_RWSEM(namespace_sem);
> +#ifdef CONFIG_LOCKDEP
> +EXPORT_SYMBOL_GPL(namespace_sem);

I don't think fs/namespace.o and kernel/cgroup/cgroup.o can't be built 
into a kernel module. I doubt we need to export it.


> +#endif
>   static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>   static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>   
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 1ea326c368f7..6277435f6748 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -80,6 +80,10 @@ static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
>   	return smp_load_acquire(&mnt->mnt_idmap);
>   }
>   
> +#ifdef CONFIG_LOCKDEP
> +extern struct rw_semaphore namespace_sem;
> +#endif
> +
>   extern int mnt_want_write(struct vfsmount *mnt);
>   extern int mnt_want_write_file(struct file *file);
>   extern void mnt_drop_write(struct vfsmount *mnt);
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 55e5f0110e3b..32d693a797b9 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -1440,13 +1440,12 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
>   
>   	lockdep_assert_held(&css_set_lock);
>   
> -	rcu_read_lock();
> +	/* namespace_sem ensures `root` stability on unmount */
> +	lockdep_assert(lockdep_is_held_type(&namespace_sem, -1));
It will be easier if you just use lockdep_is_held() without the 2nd argment.
>   
>   	cset = current->nsproxy->cgroup_ns->root_cset;
>   	res = __cset_cgroup_from_root(cset, root);
>   
> -	rcu_read_unlock();
> -
>   	return res;
>   }
>   
> @@ -1454,7 +1453,7 @@ current_cgns_cgroup_from_root(struct cgroup_root *root)
>    * Look up cgroup associated with current task's cgroup namespace on the default
>    * hierarchy.
>    *
> - * Unlike current_cgns_cgroup_from_root(), this doesn't need locks:
> + * Relaxed locking requirements:
>    * - Internal rcu_read_lock is unnecessary because we don't dereference any rcu
>    *   pointers.
>    * - css_set_lock is not needed because we just read cset->dfl_cgrp.
Cheers,
Longman

