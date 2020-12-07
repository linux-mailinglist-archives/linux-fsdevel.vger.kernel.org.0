Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940F92D1E60
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Dec 2020 00:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLGX3y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 18:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgLGX3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:29:54 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBAEC061749;
        Mon,  7 Dec 2020 15:29:14 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmPwC-00HHdx-Bc; Mon, 07 Dec 2020 23:29:00 +0000
Date:   Mon, 7 Dec 2020 23:29:00 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        criu@openvz.org, bpf@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Andy Lavr <andy.lavr@gmail.com>
Subject: Re: [PATCH v2 15/24] proc/fd: In proc_readfd_common use
 task_lookup_next_fd_rcu
Message-ID: <20201207232900.GD4115853@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-15-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120231441.29911-15-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:14:32PM -0600, Eric W. Biederman wrote:
> When discussing[1] exec and posix file locks it was realized that none
> of the callers of get_files_struct fundamentally needed to call
> get_files_struct, and that by switching them to helper functions
> instead it will both simplify their code and remove unnecessary
> increments of files_struct.count.  Those unnecessary increments can
> result in exec unnecessarily unsharing files_struct which breaking
> posix locks, and it can result in fget_light having to fallback to
> fget reducing system performance.
> 
> Using task_lookup_next_fd_rcu simplifies proc_readfd_common, by moving
> the checking for the maximum file descritor into the generic code, and
> by remvoing the need for capturing and releasing a reference on
> files_struct.
> 
> As task_lookup_fd_rcu may update the fd ctx->pos has been changed
> to be the fd +2 after task_lookup_fd_rcu returns.


> +	for (fd = ctx->pos - 2;; fd++) {
>  		struct file *f;
>  		struct fd_data data;
>  		char name[10 + 1];
>  		unsigned int len;
>  
> -		f = files_lookup_fd_rcu(files, fd);
> +		f = task_lookup_next_fd_rcu(p, &fd);

Ugh...  That makes for a massive cacheline pingpong on task_lock -
instead of grabbing/dropping task_lock() once in the beginning, we do
that for every damn descriptor.

I really don't like this one.  If anything, I would rather have
a helper that would collect a bunch of pairs (fd,mode) into an
array and have lookups batched into it.  With the loop in that
sucker grabbing a reasonable amount into a local array, then
doing proc_fill_cache() for each collected.
