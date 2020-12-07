Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976142D1D43
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 23:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgLGWXX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 17:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727550AbgLGWXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 17:23:23 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADA4C061749;
        Mon,  7 Dec 2020 14:22:42 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmOta-00HGtb-Lj; Mon, 07 Dec 2020 22:22:14 +0000
Date:   Mon, 7 Dec 2020 22:22:14 +0000
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
        KP Singh <kpsingh@chromium.org>
Subject: Re: [PATCH v2 01/24] exec: Move unshare_files to fix posix file
 locking during exec
Message-ID: <20201207222214.GA4115853@ZenIV.linux.org.uk>
References: <87r1on1v62.fsf@x220.int.ebiederm.org>
 <20201120231441.29911-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120231441.29911-1-ebiederm@xmission.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:14:18PM -0600, Eric W. Biederman wrote:
> @@ -1805,8 +1808,12 @@ static int bprm_execve(struct linux_binprm *bprm,
>  	bprm->file = file;
>  	/*
>  	 * Record that a name derived from an O_CLOEXEC fd will be
> -	 * inaccessible after exec. Relies on having exclusive access to
> -	 * current->files (due to unshare_files above).
> +	 * inaccessible after exec.  This allows the code in exec to
> +	 * choose to fail when the executable is not mmaped into the
> +	 * interpreter and an open file descriptor is not passed to
> +	 * the interpreter.  This makes for a better user experience
> +	 * than having the interpreter start and then immediately fail
> +	 * when it finds the executable is inaccessible.
>  	 */
>  	if (bprm->fdpath &&
>  	    close_on_exec(fd, rcu_dereference_raw(current->files->fdt)))

We do not have rcu_read_lock() here.  What would happen if
	* we get fdt
	* another thread does e.g. dup2() with target descriptor greater than
the current size
	* old fdt gets copied and (RCU-delayed) freed
	* nobody is holding rcu_read_lock(), so it gets really freed
	* we read a bitmap from the already freed sucker

It's a narrow window, but on SMP KVM it's not impossible to hit; if you
have preemption enabled, the race window is not so narrow even when
running on bare metal.  In the mainline it is safe, but only because
the damn thing is guaranteed to be _not_ shared with any other thread
(which is what the comment had been about).  Why not simply say
	if (bprm->fdpath && get_close_on_exec(fd))
anyway?
