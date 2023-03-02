Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C69E6A85D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjCBQIb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 11:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCBQIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 11:08:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85D1517C;
        Thu,  2 Mar 2023 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HSqL9beLg2PNaTxHlSmSPHnAzE7oiF7KGVwpuw7e2uM=; b=aHqzzlg6M+ylBQ0duazrZ2fkJx
        18CNDSnrso3fKAJERciPVirrNNhnQCce/13xqOrIc6kyaDDwK5V1WUJbLtZ9Dp3vLu7srnWFInhUp
        QD5nnM8whbaq8/53Vj8XZ+5h7q2AZL5FVVoW70o8oRRmXkf5M+/C1aHOujPXYpVABeqNPzSGkDiKr
        4cLVSoFGvwGZGj1GNVfg6fZNasQIkY//ua5UlYGtSGEVMwjLwv0BV1BF6DZlS37sUU18HoPtxSMbY
        NWf9Cy9pyt+IUUsIhN4Al8y4BOaL/EovnAl+PK2A/QalIUT8huZWgODVFOu1fkh96SLtukTkGMf+V
        DQDOIaAA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXlTf-002VNw-7k; Thu, 02 Mar 2023 16:08:19 +0000
Date:   Thu, 2 Mar 2023 16:08:19 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        joe.jin@oracle.com
Subject: Re: [PATCH 2/3] kernfs: Use a per-fs rwsem to protect per-fs list of
 kernfs_super_info.
Message-ID: <ZADJ85K6KTb6XiR4@casper.infradead.org>
References: <20230302043203.1695051-1-imran.f.khan@oracle.com>
 <20230302043203.1695051-3-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302043203.1695051-3-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 02, 2023 at 03:32:02PM +1100, Imran Khan wrote:
> Right now per-fs kernfs_rwsem protects list of kernfs_super_info instances
> for a kernfs_root. Since kernfs_rwsem is used to synchronize several other
> operations across kernfs and since most of these operations don't impact
> kernfs_super_info, we can use a separate per-fs rwsem to synchronize access
> to list of kernfs_super_info.
> This helps in reducing contention around kernfs_rwsem and also allows
> operations that change/access list of kernfs_super_info to proceed without
> contending for kernfs_rwsem.
> 
> Signed-off-by: Imran Khan <imran.f.khan@oracle.com>

But you don't remove the acquisition of kernfs_rwsem in
kernfs_notify_workfn(), so I don't see how this helps?

Also, every use of this rwsem is as a writer, so it could/should be a
plain mutex, no?  Or should you be acquiring it for read in
kernfs_notify_workfn()?

>  fs/kernfs/dir.c             | 1 +
>  fs/kernfs/file.c            | 2 ++
>  fs/kernfs/kernfs-internal.h | 1 +
>  fs/kernfs/mount.c           | 8 ++++----
>  4 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index 953b2717c60e6..2cdb8516e5287 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -944,6 +944,7 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
>  	idr_init(&root->ino_idr);
>  	init_rwsem(&root->kernfs_rwsem);
>  	init_rwsem(&root->kernfs_iattr_rwsem);
> +	init_rwsem(&root->kernfs_supers_rwsem);
>  	INIT_LIST_HEAD(&root->supers);
>  
>  	/*
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index e4a50e4ff0d23..b84cf0cd4bd44 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -924,6 +924,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	/* kick fsnotify */
>  	down_write(&root->kernfs_rwsem);
>  
> +	down_write(&root->kernfs_supers_rwsem);
>  	list_for_each_entry(info, &kernfs_root(kn)->supers, node) {
>  		struct kernfs_node *parent;
>  		struct inode *p_inode = NULL;
> @@ -960,6 +961,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  		iput(inode);
>  	}
>  
> +	up_write(&root->kernfs_supers_rwsem);
>  	up_write(&root->kernfs_rwsem);
>  	kernfs_put(kn);
>  	goto repeat;
> diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
> index 3297093c920de..a9b854cdfdb5f 100644
> --- a/fs/kernfs/kernfs-internal.h
> +++ b/fs/kernfs/kernfs-internal.h
> @@ -48,6 +48,7 @@ struct kernfs_root {
>  	wait_queue_head_t	deactivate_waitq;
>  	struct rw_semaphore	kernfs_rwsem;
>  	struct rw_semaphore	kernfs_iattr_rwsem;
> +	struct rw_semaphore	kernfs_supers_rwsem;
>  };
>  
>  /* +1 to avoid triggering overflow warning when negating it */
> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
> index e08e8d9998070..d49606accb07b 100644
> --- a/fs/kernfs/mount.c
> +++ b/fs/kernfs/mount.c
> @@ -351,9 +351,9 @@ int kernfs_get_tree(struct fs_context *fc)
>  		}
>  		sb->s_flags |= SB_ACTIVE;
>  
> -		down_write(&root->kernfs_rwsem);
> +		down_write(&root->kernfs_supers_rwsem);
>  		list_add(&info->node, &info->root->supers);
> -		up_write(&root->kernfs_rwsem);
> +		up_write(&root->kernfs_supers_rwsem);
>  	}
>  
>  	fc->root = dget(sb->s_root);
> @@ -380,9 +380,9 @@ void kernfs_kill_sb(struct super_block *sb)
>  	struct kernfs_super_info *info = kernfs_info(sb);
>  	struct kernfs_root *root = info->root;
>  
> -	down_write(&root->kernfs_rwsem);
> +	down_write(&root->kernfs_supers_rwsem);
>  	list_del(&info->node);
> -	up_write(&root->kernfs_rwsem);
> +	up_write(&root->kernfs_supers_rwsem);
>  
>  	/*
>  	 * Remove the superblock from fs_supers/s_instances
> -- 
> 2.34.1
> 
