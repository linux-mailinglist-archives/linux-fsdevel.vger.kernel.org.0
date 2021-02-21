Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09668320BC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Feb 2021 17:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhBUQe5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Feb 2021 11:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229826AbhBUQe4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Feb 2021 11:34:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FCFE60241;
        Sun, 21 Feb 2021 16:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613925255;
        bh=qZx2uLfA8mSrl/SwqY4eAAK7kPKsif5dj+x4dRjxyeU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K98MfVE+5xxgb/kAl3yJaEy2sXUJEgeEuYN6eHGSyzwJveZuJv6Or1Pe8q0OOvxVA
         RnKxTjoWptD4U7fFldOqEFJgpijC+KVz1Cr+h9FnAa6d9apHg/t0pmrbFvihB9JMGf
         nMTJlVc1b9PEU130h10FRkSuwyQ5rL1NmSVWfbP5P4Xg1lwujzg7HUIip3usWsafjX
         Ctkp2T1z+5RGnx9MvMjeCniUxCNuzOZVTsZJtw9jMLwXYNuh35WDRtDGQymoT36RRs
         NxzYfFKA5th/0tV9dwZdDAEVutddCsOG7GgMAF3as7+XdMItkPqeK06NM0SgzZnkwM
         ykgiFcJKfLtwQ==
Message-ID: <da24695f063976573af14e3197a426f444a9ac14.camel@kernel.org>
Subject: Re: [PATCH] fs/locks: print full locks information
From:   Jeff Layton <jlayton@kernel.org>
To:     Luo Longjun <luolongjun@huawei.com>, viro@zeniv.linux.org.uk,
        bfields@fieldses.org, NeilBrown <neilb@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sangyan@huawei.com, luchunhua@huawei.com
Date:   Sun, 21 Feb 2021 11:34:13 -0500
In-Reply-To: <20210220063250.742164-1-luolongjun@huawei.com>
References: <20210220063250.742164-1-luolongjun@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2021-02-20 at 01:32 -0500, Luo Longjun wrote:
> Commit fd7732e033e3 ("fs/locks: create a tree of dependent requests.")
> has put blocked locks into a tree.
> 
> So, with a for loop, we can't check all locks information.
> 
> To solve this problem, we should traverse the tree by DFS.
> 
> Signed-off-by: Luo Longjun <luolongjun@huawei.com>
> ---
>  fs/locks.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 

(cc'ing Neil B.)

It is true that you don't see the full set of blocked locks here like
you used to. This patch doesn't exactly restore the old behavior either
though. You end up with a tree of blocked locks like this in the output
when things are lined up behind a single lock:

1: POSIX  ADVISORY  WRITE 1553 00:21:27 0 EOF
1: -> POSIX  ADVISORY  WRITE 1629 00:21:27 0 EOF
1:  -> POSIX  ADVISORY  WRITE 1577 00:21:27 0 EOF
1:   -> POSIX  ADVISORY  WRITE 1610 00:21:27 0 EOF
1:    -> POSIX  ADVISORY  WRITE 1595 00:21:27 0 EOF
1:     -> POSIX  ADVISORY  WRITE 1568 00:21:27 0 EOF
1:      -> POSIX  ADVISORY  WRITE 1639 00:21:27 0 EOF

That's not necessarily wrong, since that does represent how things are
organized now, but it is different in that before you'd see everything
lined up behind the first lock rather than a chain of them like this.

/proc/locks turns out to be one of the more troublesome parts of this
code, as there really is no guiding design behind it, and it's hard to
know whether changes there will break userland.

The only tool that I know of that _really_ depends on /proc/locks is
lslocks, and I think it should work fine in the face of this patch. So,
I'm inclined to take it, unless anyone has objections.

I'll plan to pull it into -next for now, and this should make v5.13
(unless you think it needs to go in sooner).

Thanks,
Jeff

> diff --git a/fs/locks.c b/fs/locks.c
> index 99ca97e81b7a..1f7b6683ed54 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -2828,9 +2828,10 @@ struct locks_iterator {
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
> +	int i;
>  	unsigned int fl_pid;
>  	struct pid_namespace *proc_pidns = proc_pid_ns(file_inode(f->file)->i_sb);
>  
> 
> 
> 
> @@ -2844,7 +2845,13 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	if (fl->fl_file != NULL)
>  		inode = locks_inode(fl->fl_file);
>  
> 
> 
> 
> -	seq_printf(f, "%lld:%s ", id, pfx);
> +	seq_printf(f, "%lld: ", id);
> +	for (i = 1; i < repeat; i++)
> +		seq_puts(f, " ");
> +
> +	if (repeat)
> +		seq_printf(f, "%s", pfx);
> +
>  	if (IS_POSIX(fl)) {
>  		if (fl->fl_flags & FL_ACCESS)
>  			seq_puts(f, "ACCESS");
> @@ -2906,6 +2913,19 @@ static void lock_get_status(struct seq_file *f, struct file_lock *fl,
>  	}
>  }
>  
> 
> 
> 
> +static int __locks_show(struct seq_file *f, struct file_lock *fl, int level)
> +{
> +	struct locks_iterator *iter = f->private;
> +	struct file_lock *bfl;
> +
> +	lock_get_status(f, fl, iter->li_pos, "-> ", level);
> +
> +	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> +		__locks_show(f, bfl, level + 1);
> +
> +	return 0;
> +}
> +
>  static int locks_show(struct seq_file *f, void *v)
>  {
>  	struct locks_iterator *iter = f->private;
> @@ -2917,10 +2937,10 @@ static int locks_show(struct seq_file *f, void *v)
>  	if (locks_translate_pid(fl, proc_pidns) == 0)
>  		return 0;
>  
> 
> 
> 
> -	lock_get_status(f, fl, iter->li_pos, "");
> +	lock_get_status(f, fl, iter->li_pos, "", 0);
>  
> 
> 
> 
>  	list_for_each_entry(bfl, &fl->fl_blocked_requests, fl_blocked_member)
> -		lock_get_status(f, bfl, iter->li_pos, " ->");
> +		__locks_show(f, bfl, 1);
>  
> 
> 
> 
>  	return 0;
>  }
> @@ -2941,7 +2961,7 @@ static void __show_fd_locks(struct seq_file *f,
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

