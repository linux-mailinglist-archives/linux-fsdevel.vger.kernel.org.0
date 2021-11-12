Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C19B744E46D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 11:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbhKLKQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 05:16:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234656AbhKLKQC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 05:16:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5080E60F70;
        Fri, 12 Nov 2021 10:13:10 +0000 (UTC)
Date:   Fri, 12 Nov 2021 11:13:07 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Seth Forshee <sforshee@digitalocean.com>,
        Rik van Riel <riel@surriel.com>, kernel-team@fb.com
Subject: Re: [PATCH] fuse: allow CAP_SYS_ADMIN in root userns to access
 allow_other mount
Message-ID: <20211112101307.iqf3nhxgchf2u2i3@wittgenstein>
References: <20211111221142.4096653-1-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211111221142.4096653-1-davemarchevsky@fb.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 11, 2021 at 02:11:42PM -0800, Dave Marchevsky wrote:
> Since commit 73f03c2b4b52 ("fuse: Restrict allow_other to the
> superblock's namespace or a descendant"), access to allow_other FUSE
> filesystems has been limited to users in the mounting user namespace or
> descendants. This prevents a process that is privileged in its userns -
> but not its parent namespaces - from mounting a FUSE fs w/ allow_other
> that is accessible to processes in parent namespaces.
> 
> While this restriction makes sense overall it breaks a legitimate
> usecase for me. I have a tracing daemon which needs to peek into
> process' open files in order to symbolicate - similar to 'perf'. The
> daemon is a privileged process in the root userns, but is unable to peek
> into FUSE filesystems mounted with allow_other by processes in child
> namespaces.
> 
> This patch adds an escape hatch to the descendant userns logic
> specifically for processes with CAP_SYS_ADMIN in the root userns. Such
> processes can already do many dangerous things regardless of namespace,
> and moreover could fork and setns into any child userns with a FUSE
> mount, so it's reasonable to allow them to interact with all allow_other
> FUSE filesystems.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Seth Forshee <sforshee@digitalocean.com>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: kernel-team@fb.com
> ---

If your tracing daemon runs in init_user_ns with CAP_SYS_ADMIN why can't
it simply use a helper process/thread to
setns(userns_fd/pidfd, CLONE_NEWUSER)
to the target userns? This way we don't need to special-case
init_user_ns at all.

> 
> Note: I was unsure whether CAP_SYS_ADMIN or CAP_SYS_PTRACE was the best
> choice of capability here. Went with the former as it's checked
> elsewhere in fs/fuse while CAP_SYS_PTRACE isn't.
> 
>  fs/fuse/dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0654bfedcbb0..2524eeb0f35d 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1134,7 +1134,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  	const struct cred *cred;
>  
>  	if (fc->allow_other)
> -		return current_in_userns(fc->user_ns);
> +		return current_in_userns(fc->user_ns) || capable(CAP_SYS_ADMIN);
>  
>  	cred = current_cred();
>  	if (uid_eq(cred->euid, fc->user_id) &&
> -- 
> 2.30.2
> 
> 
