Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01902196ACA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Mar 2020 05:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbgC2DRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 23:17:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54674 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgC2DRJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 23:17:09 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIORa-00590g-4E; Sun, 29 Mar 2020 03:17:02 +0000
Date:   Sun, 29 Mar 2020 04:17:02 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH (repost)] umh: fix refcount underflow in
 fork_usermode_blob().
Message-ID: <20200329031702.GB23230@ZenIV.linux.org.uk>
References: <2a8775b4-1dd5-9d5c-aa42-9872445e0942@i-love.sakura.ne.jp>
 <20200312143801.GJ23230@ZenIV.linux.org.uk>
 <a802dfd6-aeda-c454-6dd3-68e32a4cf914@i-love.sakura.ne.jp>
 <85163bf6-ae4a-edbb-6919-424b92eb72b2@i-love.sakura.ne.jp>
 <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b846b1f-a231-4f09-8c37-6bfb0d1e7b05@i-love.sakura.ne.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:51:34AM +0900, Tetsuo Handa wrote:

> diff --git a/fs/exec.c b/fs/exec.c
> index db17be51b112..ded3fa368dc7 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1761,11 +1761,17 @@ static int __do_execve_file(int fd, struct filename *filename,
>  	check_unsafe_exec(bprm);
>  	current->in_execve = 1;
>  
> -	if (!file)
> +	if (!file) {
>  		file = do_open_execat(fd, filename, flags);
> -	retval = PTR_ERR(file);
> -	if (IS_ERR(file))
> -		goto out_unmark;
> +		retval = PTR_ERR(file);
> +		if (IS_ERR(file))
> +			goto out_unmark;
> +	} else {
> +		retval = deny_write_access(file);
> +		if (retval)
> +			goto out_unmark;
> +		get_file(file);
> +	}

I still don't like it.  The bug is real, but... *yeccchhhh*

First of all, this assignment to "file" is misguiding -
assignment to bprm->file would've been a lot easier to
follow.  Furthermore, the damn thing already has much
too confusing cleanup logics.

Why is
out:
        if (bprm->mm) {
                acct_arg_size(bprm, 0);
                mmput(bprm->mm);
        }
done on failure exit in this function and not in free_bprm(),
while dropping bprm->file is in free_bprm()?

Note that flush_old_exec() will zero bprm->mm (after it transfers
the damn thing into current->mm), so we are fine here.  And getting
rid of that thing in __do_execve_file() simplifies the logics
in there, especially if you take everything from this
        if (!file)
up to
        retval = exec_binprm(bprm);
into a new function.  All those goto out_unmark/goto out turn
into plain returns.  And in __do_execve_file() we are left with
        ....
        current->in_execve = 1;
	retval = this_new_helper(whatever it needs passed to it);
        current->fs->in_exec = 0;
        current->in_execve = 0;
	if (!retval) {
		/* execve succeeded */
		rseq_execve(current);
		acct_update_integrals(current);
		task_numa_free(current, false);
	}
out_free:
        free_bprm(bprm);
        kfree(pathbuf);
out_files:
        if (displaced)
                put_files_struct(displaced);
out_ret:
        if (filename)
                putname(filename);
        return retval;
which is a lot easier to follow.  Especially if we lift the logics
for freeing pathbuf into free_bprm() as well (will need a flag there,
for "does ->filename need to be freed?").  And I really wonder if
sched_exec() is called in the right place - what's special about the
point after opening the binary to be and setting bprm->file to what
we got?
