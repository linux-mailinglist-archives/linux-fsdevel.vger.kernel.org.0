Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2633274F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 14:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhCINhc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 08:37:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:52008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231229AbhCINhY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 08:37:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E1B46650F5;
        Tue,  9 Mar 2021 13:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615297043;
        bh=zS2pYAyshXgLq2yLld4RkUTUIVQfJijL3GDy3c1h90U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XN6WcZODNg9ibjdgtZ4tOM1QYwYRRgfTE8ZQheffRWsRL0QLcEg9yTIdP0lscIhTR
         85ZfcBt1msbAHG9CYXmIBjLgS2WMsDqlNVb1KrkLggVWll0Zfph4dgzg8m4v79XYuF
         Lz7SYyBlgvH5mKvVV6UDWkhopxh16caGTOAH0Eq+RJ/042VN4n1G+JrV9H2Obh8yzK
         N2HAAq46pwWkMwBZwIsFQ7lo8sNl6qmiSaWNy05rNoyTJTgI3uDxvXSEm5npoQnbTk
         Soif9hbZ+SYsN3RJiT6veL4Sepn270IuHIh0Sj3CBZbnEEcmfVPRl+BQXGXwzlcaWx
         WOXk+nCtOTJuw==
Message-ID: <f8c7a7fe8ee7fc1f1a36f35f38cc653d167b25a1.camel@kernel.org>
Subject: Re: [PATCH v3] fs/locks: print full locks information
From:   Jeff Layton <jlayton@kernel.org>
To:     Luo Longjun <luolongjun@huawei.com>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Date:   Tue, 09 Mar 2021 08:37:21 -0500
In-Reply-To: <685386c2840b76c49b060bf7dcea1fefacf18176.1614322182.git.luolongjun@huawei.com>
References: <20210221201024.GB15975@fieldses.org>
         <685386c2840b76c49b060bf7dcea1fefacf18176.1614322182.git.luolongjun@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-02-25 at 22:58 -0500, Luo Longjun wrote:
> Commit fd7732e033e3 ("fs/locks: create a tree of dependent requests.")
> has put blocked locks into a tree.
> 
> So, with a for loop, we can't check all locks information.
> 
> To solve this problem, we should traverse the tree.
> 
> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
> ---
>  fs/locks.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 56 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/locks.c b/fs/locks.c
> index 99ca97e81b7a..ecaecd1f1b58 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2828,7 +2828,7 @@ struct locks_iterator {
>  };
>  
> 
> 
> 
>  static void lock_get_status(struct seq_file *f, struct file_lock *fl,
> -			    loff_t id, char *pfx)
> +			    loff_t id, char *pfx, int repeat)
>  {
>  	struct inode *inode = NULL;
>  	unsigned int fl_pid;
> @@ -2844,7 +2844,11 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	if (fl->fl_file != NULL)
>  		inode = locks_inode(fl->fl_file);
>  
> 
> 
> 
> -	seq_printf(f, "%lld:%s ", id, pfx);
> +	seq_printf(f, "%lld: ", id);
> +
> +	if (repeat)
> +		seq_printf(f, "%*s", repeat - 1 + (int)strlen(pfx), pfx);

Shouldn't that be "%.*s" ?

Also, isn't this likely to end up walking past the end of "pfx" (or even
ending up at an address before the buffer)? You have this below:

    lock_get_status(f, fl, *id, "", 0);

...so the "length" value you're passing into the format there is going
to be -1. It also seems like if you get a large "level" value in
locks_show, then you'll end up with a length that is much longer than
the actual string.

> +
>  	if (IS_POSIX(fl)) {
>  		if (fl->fl_flags & FL_ACCESS)
>  			seq_puts(f, "ACCESS");
> @@ -2906,21 +2910,64 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	}
>  }
>  
> 
> 
> 
> +static struct file_lock *get_next_blocked_member(struct file_lock *node)
> +{
> +	struct file_lock *tmp;
> +
> +	/* NULL node or root node */
> +	if (node == NULL || node->fl_blocker == NULL)
> +		return NULL;
> +
> +	/* Next member in the linked list could be itself */
> +	tmp = list_next_entry(node, fl_blocked_member);
> +	if (list_entry_is_head(tmp, &node->fl_blocker->fl_blocked_requests, fl_blocked_member)
> +		|| tmp == node) {
> +		return NULL;
> +	}
> +
> +	return tmp;
> +}
> +
>  static int locks_show(struct seq_file *f, void *v)
>  {
>  	struct locks_iterator *iter = f->private;
> -	struct file_lock *fl, *bfl;
> +	struct file_lock *cur, *tmp;
>  	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
> +	int level = 0;
>  
> 
> 
> 
> -	fl = hlist_entry(v, struct file_lock, fl_link);
> +	cur = hlist_entry(v, struct file_lock, fl_link);
>  
> 
> 
> 
> -	if (locks_translate_pid(fl, proc_pidns) == 0)
> +	if (locks_translate_pid(cur, proc_pidns) == 0)
>  		return 0;
>  
> 
> 
> 
> -	lock_get_status(f, fl, iter->li_pos, "");
> +	/* View this crossed linked list as a binary tree, the first member of fl_blocked_requests
> +	 * is the left child of current node, the next silibing in fl_blocked_member is the
> +	 * right child, we can alse get the parent of current node from fl_blocker, so this
> +	 * question becomes traversal of a binary tree
> +	 */
> +	while (cur != NULL) {
> +		if (level)
> +			lock_get_status(f, cur, iter->li_pos, "-> ", level);
> +		else
> +			lock_get_status(f, cur, iter->li_pos, "", level);
>  
> 
> 
> 
> -	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> -		lock_get_status(f, bfl, iter->li_pos, " ->");
> +		if (!list_empty(&cur->fl_blocked_requests)) {
> +			/* Turn left */
> +			cur = list_first_entry_or_null(&cur->fl_blocked_requests,
> +				struct file_lock, fl_blocked_member);
> +			level++;
> +		} else {
> +			/* Turn right */
> +			tmp = get_next_blocked_member(cur);
> +			/* Fall back to parent node */
> +			while (tmp == NULL && cur->fl_blocker != NULL) {
> +				cur = cur->fl_blocker;
> +				level--;
> +				tmp = get_next_blocked_member(cur);
> +			}
> +			cur = tmp;
> +		}
> +	}
>  
> 
> 
> 
>  	return 0;
>  }
> @@ -2941,7 +2988,7 @@ static void __show_fd_locks(struct seq_file *f,
>  
> 
> 
> 
>  		(*id)++;
>  		seq_puts(f, "lock:\t");
> -		lock_get_status(f, fl, *id, "");
> +		lock_get_status(f, fl, *id, "", 0);
>  	}
>  }
>  
> 
> 
> 

-- 
Jeff Layton <jlayton@kernel.org>

