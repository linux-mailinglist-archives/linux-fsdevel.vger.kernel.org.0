Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A77216BD6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGLlJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 07:41:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37729 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGLlI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:41:08 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jslyC-0003t7-Fn; Tue, 07 Jul 2020 11:41:04 +0000
Date:   Tue, 7 Jul 2020 13:41:03 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Laight <David.Laight@ACULAB.COM>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Matt Denton <mpdenton@google.com>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Robert Sesek <rsesek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 1/7] net/scm: Regularize compat handling of
 scm_detach_fds()
Message-ID: <20200707114103.lkfbt3kdtturp42z@wittgenstein>
References: <20200706201720.3482959-1-keescook@chromium.org>
 <20200706201720.3482959-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706201720.3482959-2-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 01:17:14PM -0700, Kees Cook wrote:
> Duplicate the cleanups from commit 2618d530dd8b ("net/scm: cleanup
> scm_detach_fds") into the compat code.
> 
> Move the check added in commit 1f466e1f15cf ("net: cleanly handle kernel
> vs user buffers for ->msg_control") to before the compat call, even
> though it should be impossible for an in-kernel call to also be compat.
> 
> Correct the int "flags" argument to unsigned int to match fd_install()
> and similar APIs.
> 
> Regularize any remaining differences, including a whitespace issue,
> a checkpatch warning, and add the check from commit 6900317f5eff ("net,
> scm: fix PaX detected msg_controllen overflow in scm_detach_fds") which
> fixed an overflow unique to 64-bit. To avoid confusion when comparing
> the compat handler to the native handler, just include the same check
> in the compat handler.
> 
> Fixes: 48a87cc26c13 ("net: netprio: fd passed in SCM_RIGHTS datagram not set correctly")
> Fixes: d84295067fc7 ("net: net_cls: fd passed in SCM_RIGHTS datagram not set correctly")
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---

Thanks. Just a comment below.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  include/net/scm.h |  1 +
>  net/compat.c      | 55 +++++++++++++++++++++--------------------------
>  net/core/scm.c    | 18 ++++++++--------
>  3 files changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 1ce365f4c256..581a94d6c613 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -37,6 +37,7 @@ struct scm_cookie {
>  #endif
>  };
>  
> +int __scm_install_fd(struct file *file, int __user *ufd, unsigned int o_flags);
>  void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
>  void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm);
>  int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *scm);
> diff --git a/net/compat.c b/net/compat.c
> index 5e3041a2c37d..27d477fdcaa0 100644
> --- a/net/compat.c
> +++ b/net/compat.c
> @@ -281,39 +281,31 @@ int put_cmsg_compat(struct msghdr *kmsg, int level, int type, int len, void *dat
>  	return 0;
>  }
>  
> -void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
> +static int scm_max_fds_compat(struct msghdr *msg)
>  {
> -	struct compat_cmsghdr __user *cm = (struct compat_cmsghdr __user *) kmsg->msg_control;
> -	int fdmax = (kmsg->msg_controllen - sizeof(struct compat_cmsghdr)) / sizeof(int);
> -	int fdnum = scm->fp->count;
> -	struct file **fp = scm->fp->fp;
> -	int __user *cmfptr;
> -	int err = 0, i;
> +	if (msg->msg_controllen <= sizeof(struct compat_cmsghdr))
> +		return 0;
> +	return (msg->msg_controllen - sizeof(struct compat_cmsghdr)) / sizeof(int);
> +}
>  
> -	if (fdnum < fdmax)
> -		fdmax = fdnum;
> +void scm_detach_fds_compat(struct msghdr *msg, struct scm_cookie *scm)
> +{
> +	struct compat_cmsghdr __user *cm =
> +		(struct compat_cmsghdr __user *)msg->msg_control;
> +	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
> +	int fdmax = min_t(int, scm_max_fds_compat(msg), scm->fp->count);

Just a note that SCM_RIGHTS fd-sending is limited to 253 (SCM_MAX_FD)
fds so min_t should never ouput > SCM_MAX_FD here afaict.

> +	int __user *cmsg_data = CMSG_USER_DATA(cm);
> +	int err = 0, i;
>  
> -	for (i = 0, cmfptr = (int __user *) CMSG_COMPAT_DATA(cm); i < fdmax; i++, cmfptr++) {
> -		int new_fd;
> -		err = security_file_receive(fp[i]);
> +	for (i = 0; i < fdmax; i++) {
> +		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
>  		if (err)
>  			break;
> -		err = get_unused_fd_flags(MSG_CMSG_CLOEXEC & kmsg->msg_flags
> -					  ? O_CLOEXEC : 0);
> -		if (err < 0)
> -			break;
> -		new_fd = err;
> -		err = put_user(new_fd, cmfptr);
> -		if (err) {
> -			put_unused_fd(new_fd);
> -			break;
> -		}
> -		/* Bump the usage count and install the file. */
> -		fd_install(new_fd, get_file(fp[i]));
>  	}
>  
>  	if (i > 0) {
>  		int cmlen = CMSG_COMPAT_LEN(i * sizeof(int));
> +
>  		err = put_user(SOL_SOCKET, &cm->cmsg_level);
>  		if (!err)
>  			err = put_user(SCM_RIGHTS, &cm->cmsg_type);
> @@ -321,16 +313,19 @@ void scm_detach_fds_compat(struct msghdr *kmsg, struct scm_cookie *scm)
>  			err = put_user(cmlen, &cm->cmsg_len);
>  		if (!err) {
>  			cmlen = CMSG_COMPAT_SPACE(i * sizeof(int));
> -			kmsg->msg_control += cmlen;
> -			kmsg->msg_controllen -= cmlen;
> +			if (msg->msg_controllen < cmlen)
> +				cmlen = msg->msg_controllen;
> +			msg->msg_control += cmlen;
> +			msg->msg_controllen -= cmlen;
>  		}
>  	}
> -	if (i < fdnum)
> -		kmsg->msg_flags |= MSG_CTRUNC;
> +
> +	if (i < scm->fp->count || (scm->fp->count && fdmax <= 0))

I think fdmax can't be < 0 after your changes? scm_max_fds() guarantees
that fdmax is always >= 0 and min_t() guarantees that fdmax <= scm->fp->count.
So the check should technically be :)

if (i < scm->fp->count || scm->fp->count && fdmax == 0)

> +		msg->msg_flags |= MSG_CTRUNC;
>  
>  	/*
> -	 * All of the files that fit in the message have had their
> -	 * usage counts incremented, so we just free the list.
> +	 * All of the files that fit in the message have had their usage counts
> +	 * incremented, so we just free the list.
>  	 */
>  	__scm_destroy(scm);
>  }
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 875df1c2989d..6151678c73ed 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -280,7 +280,7 @@ void put_cmsg_scm_timestamping(struct msghdr *msg, struct scm_timestamping_inter
>  }
>  EXPORT_SYMBOL(put_cmsg_scm_timestamping);
>  
> -static int __scm_install_fd(struct file *file, int __user *ufd, int o_flags)
> +int __scm_install_fd(struct file *file, int __user *ufd, unsigned int o_flags)
>  {
>  	struct socket *sock;
>  	int new_fd;
> @@ -319,29 +319,29 @@ static int scm_max_fds(struct msghdr *msg)
>  
>  void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm)
>  {
> -	struct cmsghdr __user *cm
> -		= (__force struct cmsghdr __user*)msg->msg_control;
> -	int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
> +	struct cmsghdr __user *cm =
> +		(__force struct cmsghdr __user *)msg->msg_control;
> +	unsigned int o_flags = (msg->msg_flags & MSG_CMSG_CLOEXEC) ? O_CLOEXEC : 0;
>  	int fdmax = min_t(int, scm_max_fds(msg), scm->fp->count);
>  	int __user *cmsg_data = CMSG_USER_DATA(cm);
>  	int err = 0, i;
>  
> +	/* no use for FD passing from kernel space callers */
> +	if (WARN_ON_ONCE(!msg->msg_control_is_user))
> +		return;
> +
>  	if (msg->msg_flags & MSG_CMSG_COMPAT) {
>  		scm_detach_fds_compat(msg, scm);
>  		return;
>  	}
>  
> -	/* no use for FD passing from kernel space callers */
> -	if (WARN_ON_ONCE(!msg->msg_control_is_user))
> -		return;
> -
>  	for (i = 0; i < fdmax; i++) {
>  		err = __scm_install_fd(scm->fp->fp[i], cmsg_data + i, o_flags);
>  		if (err)
>  			break;
>  	}
>  
> -	if (i > 0)  {
> +	if (i > 0) {
>  		int cmlen = CMSG_LEN(i * sizeof(int));
>  
>  		err = put_user(SOL_SOCKET, &cm->cmsg_level);
> -- 
> 2.25.1
> 
