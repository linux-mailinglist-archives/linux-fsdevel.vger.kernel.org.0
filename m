Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCF853FB0F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jun 2022 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240862AbiFGKTE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jun 2022 06:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240860AbiFGKTC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:19:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2560AA7
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jun 2022 03:19:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 689F11F897;
        Tue,  7 Jun 2022 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1654597140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nteAd4L7pxGcp8qsJvxionM7fWKKEQRJZ5RArLcShnU=;
        b=sl0KZabsJtzXwxclt9SWvsTJhpbj3shUlbztQbvH+KGFft07qQF6nYYGhavuwEvceRKGwk
        VrxLJ4w+m6ING3DovKqlOoX51r6If4RQFruZnilqchRpgEDbr5sWr7naTg0nyaQ+D+792i
        YS0VlMI8lHjdXc1xnouyAjfN+ZajOjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1654597140;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nteAd4L7pxGcp8qsJvxionM7fWKKEQRJZ5RArLcShnU=;
        b=ZDu8vZ265xqL7RaScSfhhm7Etw7yZ+E05dpbx4c7vPkYnY0hVF+qNcG1VvzGk7SaVPD4EW
        GiQ6WJvd01ZCNiDg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 43C732C141;
        Tue,  7 Jun 2022 10:19:00 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9B7DA0633; Tue,  7 Jun 2022 12:18:59 +0200 (CEST)
Date:   Tue, 7 Jun 2022 12:18:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 3/9] struct file: use anonymous union member for rcuhead
 and llist
Message-ID: <20220607101859.omvms4hiksxnvjyq@quack3.lan>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <Yp7PtAl5fuh/hqhS@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yp7PtAl5fuh/hqhS@zeniv-ca.linux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 07-06-22 04:10:28, Al Viro wrote:
> Once upon a time we couldn't afford anon unions; these days minimal
> gcc version had been raised enough to take care of that.

This patch misses your Signed-off-by but otherwise it looks good to me.
Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file_table.c    | 16 ++++++++--------
>  include/linux/fs.h |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 5424e3a8df5f..b989e33aacda 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -45,7 +45,7 @@ static struct percpu_counter nr_files __cacheline_aligned_in_smp;
>  
>  static void file_free_rcu(struct rcu_head *head)
>  {
> -	struct file *f = container_of(head, struct file, f_u.fu_rcuhead);
> +	struct file *f = container_of(head, struct file, f_rcuhead);
>  
>  	put_cred(f->f_cred);
>  	kmem_cache_free(filp_cachep, f);
> @@ -56,7 +56,7 @@ static inline void file_free(struct file *f)
>  	security_file_free(f);
>  	if (!(f->f_mode & FMODE_NOACCOUNT))
>  		percpu_counter_dec(&nr_files);
> -	call_rcu(&f->f_u.fu_rcuhead, file_free_rcu);
> +	call_rcu(&f->f_rcuhead, file_free_rcu);
>  }
>  
>  /*
> @@ -142,7 +142,7 @@ static struct file *__alloc_file(int flags, const struct cred *cred)
>  	f->f_cred = get_cred(cred);
>  	error = security_file_alloc(f);
>  	if (unlikely(error)) {
> -		file_free_rcu(&f->f_u.fu_rcuhead);
> +		file_free_rcu(&f->f_rcuhead);
>  		return ERR_PTR(error);
>  	}
>  
> @@ -341,13 +341,13 @@ static void delayed_fput(struct work_struct *unused)
>  	struct llist_node *node = llist_del_all(&delayed_fput_list);
>  	struct file *f, *t;
>  
> -	llist_for_each_entry_safe(f, t, node, f_u.fu_llist)
> +	llist_for_each_entry_safe(f, t, node, f_llist)
>  		__fput(f);
>  }
>  
>  static void ____fput(struct callback_head *work)
>  {
> -	__fput(container_of(work, struct file, f_u.fu_rcuhead));
> +	__fput(container_of(work, struct file, f_rcuhead));
>  }
>  
>  /*
> @@ -374,8 +374,8 @@ void fput(struct file *file)
>  		struct task_struct *task = current;
>  
>  		if (likely(!in_interrupt() && !(task->flags & PF_KTHREAD))) {
> -			init_task_work(&file->f_u.fu_rcuhead, ____fput);
> -			if (!task_work_add(task, &file->f_u.fu_rcuhead, TWA_RESUME))
> +			init_task_work(&file->f_rcuhead, ____fput);
> +			if (!task_work_add(task, &file->f_rcuhead, TWA_RESUME))
>  				return;
>  			/*
>  			 * After this task has run exit_task_work(),
> @@ -384,7 +384,7 @@ void fput(struct file *file)
>  			 */
>  		}
>  
> -		if (llist_add(&file->f_u.fu_llist, &delayed_fput_list))
> +		if (llist_add(&file->f_llist, &delayed_fput_list))
>  			schedule_delayed_work(&delayed_fput_work, 1);
>  	}
>  }
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 9ad5e3520fae..6a2a4906041f 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -924,9 +924,9 @@ static inline int ra_has_index(struct file_ra_state *ra, pgoff_t index)
>  
>  struct file {
>  	union {
> -		struct llist_node	fu_llist;
> -		struct rcu_head 	fu_rcuhead;
> -	} f_u;
> +		struct llist_node	f_llist;
> +		struct rcu_head 	f_rcuhead;
> +	};
>  	struct path		f_path;
>  	struct inode		*f_inode;	/* cached value */
>  	const struct file_operations	*f_op;
> -- 
> 2.30.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
