Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8BD129B10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 22:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfLWV0v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 16:26:51 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfLWV0v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 16:26:51 -0500
Received: from p5b2a6d78.dip0.t-ipconnect.de ([91.42.109.120] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ijVDz-0003a4-Q4; Mon, 23 Dec 2019 21:26:47 +0000
Date:   Mon, 23 Dec 2019 22:26:46 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, oleg@redhat.com, luto@amacapital.net,
        viro@zeniv.linux.org.uk, gpascutto@mozilla.com,
        ealvarez@mozilla.com, fweimer@redhat.com, jld@mozilla.com,
        arnd@arndb.de
Subject: Re: [PATCH v6 1/3] vfs, fdtable: Add get_task_file helper
Message-ID: <20191223212645.3qw7my4u4rjihxjf@wittgenstein>
References: <20191223210852.GA25101@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191223210852.GA25101@ircssh-2.c.rugged-nimbus-611.internal>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 23, 2019 at 09:08:55PM +0000, Sargun Dhillon wrote:
> This introduces a function which can be used to fetch a file, given an
> arbitrary task. As long as the user holds a reference (refcnt) to the
> task_struct it is safe to call, and will either return NULL on failure,
> or a pointer to the file, with a refcnt.
> 
> Signed-off-by: Sargun Dhillon <sargun@sargun.me>
> ---
>  fs/file.c            | 22 ++++++++++++++++++++--
>  include/linux/file.h |  2 ++
>  2 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 2f4fcf985079..0ceeb046f4f3 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -706,9 +706,9 @@ void do_close_on_exec(struct files_struct *files)
>  	spin_unlock(&files->file_lock);
>  }
>  
> -static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
> +static struct file *__fget_files(struct files_struct *files, unsigned int fd,
> +				 fmode_t mask, unsigned int refs)
>  {
> -	struct files_struct *files = current->files;
>  	struct file *file;
>  
>  	rcu_read_lock();
> @@ -729,6 +729,11 @@ static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
>  	return file;
>  }
>  
> +static struct file *__fget(unsigned int fd, fmode_t mask, unsigned int refs)
> +{
> +	return __fget_files(current->files, fd, mask, refs);
> +}
> +
>  struct file *fget_many(unsigned int fd, unsigned int refs)
>  {
>  	return __fget(fd, FMODE_PATH, refs);
> @@ -746,6 +751,19 @@ struct file *fget_raw(unsigned int fd)
>  }
>  EXPORT_SYMBOL(fget_raw);
>  
> +struct file *fget_task(struct task_struct *task, unsigned int fd)
> +{
> +	struct file *file = NULL;
> +
> +	task_lock(task);
> +	if (task->files)
> +		file = __fget_files(task->files, fd, 0, 1);
> +
> +	task_unlock(task);

Nit: remove the \n:

task_lock(task);
if (task->files)
	file = __fget_files(task->files, fd, 0, 1);
task_unlock(task);

Christian
