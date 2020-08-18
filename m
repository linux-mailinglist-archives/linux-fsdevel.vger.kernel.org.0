Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F243F248322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Aug 2020 12:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHRKg3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Aug 2020 06:36:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39029 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRKgZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:36:25 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k7yyc-0002zb-TF; Tue, 18 Aug 2020 10:36:23 +0000
Date:   Tue, 18 Aug 2020 12:36:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH 08/17] proc/fd: In proc_fd_link use fcheck_task
Message-ID: <20200818103616.u2fht5c6zeeivqg6@wittgenstein>
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org>
 <20200817220425.9389-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200817220425.9389-8-ebiederm@xmission.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 17, 2020 at 05:04:16PM -0500, Eric W. Biederman wrote:
> When discussing[1] exec and posix file locks it was realized that none
> of the callers of get_files_struct fundamentally needed to call
> get_files_struct, and that by switching them to helper functions
> instead it will both simplify their code and remove unnecessary
> increments of files_struct.count.  Those unnecessary increments can
> result in exec unnecessarily unsharing files_struct which breaking
> posix locks, and it can result in fget_light having to fallback to
> fget reducing system performance.
> 
> Using fcheck_task instead of get_files_struct simplifies proc_fd_link by
> removing unnecessary locking, and reference counting.
> 
> [1] https://lkml.kernel.org/r/20180915160423.GA31461@redhat.com
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> ---

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  fs/proc/fd.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/proc/fd.c b/fs/proc/fd.c
> index 4048a87c51ee..abfdcb21cc79 100644
> --- a/fs/proc/fd.c
> +++ b/fs/proc/fd.c
> @@ -141,29 +141,23 @@ static const struct dentry_operations tid_fd_dentry_operations = {
>  
>  static int proc_fd_link(struct dentry *dentry, struct path *path)
>  {
> -	struct files_struct *files = NULL;
>  	struct task_struct *task;
>  	int ret = -ENOENT;
>  
>  	task = get_proc_task(d_inode(dentry));
>  	if (task) {
> -		files = get_files_struct(task);
> -		put_task_struct(task);
> -	}
> -
> -	if (files) {
>  		unsigned int fd = proc_fd(d_inode(dentry));
>  		struct file *fd_file;
>  
> -		spin_lock(&files->file_lock);
> -		fd_file = fcheck_files(files, fd);
> +		rcu_read_lock();
> +		fd_file = fcheck_task(task, fd);
>  		if (fd_file) {
>  			*path = fd_file->f_path;
>  			path_get(&fd_file->f_path);
>  			ret = 0;
>  		}
> -		spin_unlock(&files->file_lock);
> -		put_files_struct(files);
> +		rcu_read_unlock();
> +		put_task_struct(task);
>  	}
>  
>  	return ret;
> -- 
> 2.25.0
> 
