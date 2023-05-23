Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A39370DAC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbjEWKm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236243AbjEWKmz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:42:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46513133;
        Tue, 23 May 2023 03:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCC14630F6;
        Tue, 23 May 2023 10:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EB8C433D2;
        Tue, 23 May 2023 10:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684838572;
        bh=dAZtfPEcdx8w0xksIc+4VYD58Jm8oMxQ7+S7bRplZvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc34T6TA2Jylxa+Ta17oKWHKcRWTtyg7v2ias+mVnUeGa6ugVmCGvGQBzxYBOBsnB
         gVR8bMa+mAb/WmZBAJg4ZHPAQ2lJgy5r/HWYoS1qTIWV7SORr49MZxUzhIN2LkQ7k4
         h2gCx3ek59wOr/O+LFTOpCQhvbXw+OrWCwXSIAQ4DjUvaJI+cZAOeKsnOOmK+h4inJ
         bve2yOEnB29XSuZUjPe686uTQO6OQajO+gMeiz429QS1MKh9QXJEuwOs6aTTiroEGa
         WMKJd1eOsA7UJBH8COgqfZsl7uTMdscQ8GmfjbyYAYj+UqAG2S0CQuIatxOWFZDFTK
         E692WpXj+M8Mw==
Date:   Tue, 23 May 2023 12:42:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Chinner <dchinner@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Jiri Wiesner <jwiesner@suse.de>
Subject: Re: [RFC PATCH 2/3] cgroup: Rely on namespace_sem in
 current_cgns_cgroup_from_root explicitly
Message-ID: <20230523-radar-gleich-781fd4006057@brauner>
References: <20230502133847.14570-1-mkoutny@suse.com>
 <20230502133847.14570-3-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230502133847.14570-3-mkoutny@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 02, 2023 at 03:38:46PM +0200, Michal Koutný wrote:
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
>  fs/namespace.c         | 5 ++++-
>  include/linux/mount.h  | 4 ++++
>  kernel/cgroup/cgroup.c | 7 +++----
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 54847db5b819..0d2333832064 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -71,7 +71,10 @@ static DEFINE_IDA(mnt_group_ida);
>  static struct hlist_head *mount_hashtable __read_mostly;
>  static struct hlist_head *mountpoint_hashtable __read_mostly;
>  static struct kmem_cache *mnt_cache __read_mostly;
> -static DECLARE_RWSEM(namespace_sem);
> +DECLARE_RWSEM(namespace_sem);
> +#ifdef CONFIG_LOCKDEP
> +EXPORT_SYMBOL_GPL(namespace_sem);
> +#endif
>  static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
>  static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
>  
> diff --git a/include/linux/mount.h b/include/linux/mount.h
> index 1ea326c368f7..6277435f6748 100644
> --- a/include/linux/mount.h
> +++ b/include/linux/mount.h
> @@ -80,6 +80,10 @@ static inline struct mnt_idmap *mnt_idmap(const struct vfsmount *mnt)
>  	return smp_load_acquire(&mnt->mnt_idmap);
>  }
>  
> +#ifdef CONFIG_LOCKDEP
> +extern struct rw_semaphore namespace_sem;
> +#endif

Nope, we're not putting namespace_sem in a header. The code it protects
is massively sensitive and it interacts with mount_lock and other locks.
This stays private to fs/namespace.c as far as I'm concerned.
