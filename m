Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35D6243B4A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMONa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 10:13:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMON3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:13:29 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F78120675;
        Thu, 13 Aug 2020 14:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597328008;
        bh=niY7dCftLGTSbVYLgzF6IzI/6CkO2mglJBYFB9MOt4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gbSP/S3DP2XVeODGKh+Cl/q3w1ZznI5PHlSNRDrNhDCaLnnmeu+FL8AKGQ9Ux+a17
         A/LWDalmR73MCT4sZIHwEmdHe6vqT8d2KPKLH3Ic2Cq+1z0EF61GHgu77Y+GdncDhi
         cRgPF57XsBS7lW2TnrV9cDYfIfpkwoLtAcpcSjnw=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k6Dyw-001wXd-I7; Thu, 13 Aug 2020 15:13:26 +0100
Date:   Thu, 13 Aug 2020 15:13:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com
Subject: Re: [PATCH v2 2/3] exec: Move S_ISREG() check earlier
Message-ID: <20200813151305.6191993b@why>
In-Reply-To: <20200605160013.3954297-3-keescook@chromium.org>
References: <20200605160013.3954297-1-keescook@chromium.org>
        <20200605160013.3954297-3-keescook@chromium.org>
Organization: Approximate
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: keescook@chromium.org, akpm@linux-foundation.org, viro@zeniv.linux.org.uk, cyphar@cyphar.com, christian.brauner@ubuntu.com, dvyukov@google.com, ebiggers3@gmail.com, penguin-kernel@I-love.SAKURA.ne.jp, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri,  5 Jun 2020 09:00:12 -0700
Kees Cook <keescook@chromium.org> wrote:

Hi Kees,

> The execve(2)/uselib(2) syscalls have always rejected non-regular
> files. Recently, it was noticed that a deadlock was introduced when trying
> to execute pipes, as the S_ISREG() test was happening too late. This was
> fixed in commit 73601ea5b7b1 ("fs/open.c: allow opening only regular files
> during execve()"), but it was added after inode_permission() had already
> run, which meant LSMs could see bogus attempts to execute non-regular
> files.
> 
> Move the test into the other inode type checks (which already look
> for other pathological conditions[1]). Since there is no need to use
> FMODE_EXEC while we still have access to "acc_mode", also switch the
> test to MAY_EXEC.
> 
> Also include a comment with the redundant S_ISREG() checks at the end of
> execve(2)/uselib(2) to note that they are present to avoid any mistakes.
> 
> My notes on the call path, and related arguments, checks, etc:
> 
> do_open_execat()
>     struct open_flags open_exec_flags = {
>         .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
>         .acc_mode = MAY_EXEC,
>         ...
>     do_filp_open(dfd, filename, open_flags)
>         path_openat(nameidata, open_flags, flags)
>             file = alloc_empty_file(open_flags, current_cred());
>             do_open(nameidata, file, open_flags)
>                 may_open(path, acc_mode, open_flag)
> 		    /* new location of MAY_EXEC vs S_ISREG() test */
>                     inode_permission(inode, MAY_OPEN | acc_mode)
>                         security_inode_permission(inode, acc_mode)
>                 vfs_open(path, file)
>                     do_dentry_open(file, path->dentry->d_inode, open)
>                         /* old location of FMODE_EXEC vs S_ISREG() test */
>                         security_file_open(f)
>                         open()
> 
> [1] https://lore.kernel.org/lkml/202006041910.9EF0C602@keescook/
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  fs/exec.c  | 14 ++++++++++++--
>  fs/namei.c |  6 ++++--
>  fs/open.c  |  6 ------
>  3 files changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 30735ce1dc0e..2b708629dcd6 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -139,8 +139,13 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	/*
> +	 * may_open() has already checked for this, so it should be
> +	 * impossible to trip now. But we need to be extra cautious
> +	 * and check again at the very end too.
> +	 */
>  	error = -EACCES;
> -	if (!S_ISREG(file_inode(file)->i_mode))
> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>  		goto exit;
>  
>  	if (path_noexec(&file->f_path))
> @@ -860,8 +865,13 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
>  	if (IS_ERR(file))
>  		goto out;
>  
> +	/*
> +	 * may_open() has already checked for this, so it should be
> +	 * impossible to trip now. But we need to be extra cautious
> +	 * and check again at the very end too.
> +	 */
>  	err = -EACCES;
> -	if (!S_ISREG(file_inode(file)->i_mode))
> +	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode)))
>  		goto exit;
>  
>  	if (path_noexec(&file->f_path))
> diff --git a/fs/namei.c b/fs/namei.c
> index a320371899cf..0a759b68d66e 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2835,16 +2835,18 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>  	case S_IFLNK:
>  		return -ELOOP;
>  	case S_IFDIR:
> -		if (acc_mode & MAY_WRITE)
> +		if (acc_mode & (MAY_WRITE | MAY_EXEC))
>  			return -EISDIR;

This seems to change (break?) the behaviour of syscalls such as execv,
which can now return -EISDIR, whereas the existing behaviour was to
return -EACCES. The man page never hints at the possibility of -EISDIR
being returned, making it feel like a regression.

POSIX (FWIW) also says:

<quote>
[EACCES]
    The new process image file is not a regular file and the
    implementation does not support execution of files of its type.
</quote>

This has been picked up by the Bionic test suite[1], but can just as
easily be reproduced with the following snippet:

$ cat x.c
#include <unistd.h>
#include <stdio.h>
int main(int argc, char *argv[])
{
	execv("/", NULL);
	perror("execv");
	return 0;
}

Before this patch:
$ ./x
execv: Permission denied

After this patch:
$ ./x
execv: Is a directory


Thanks,

	M.

[1] https://android.googlesource.com/platform/bionic/+/master/tests/unistd_test.cpp#1346
-- 
Jazz is not dead. It just smells funny...
