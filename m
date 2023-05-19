Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BB970A04A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 22:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjESUJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 16:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjESUJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 16:09:39 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C869DFE;
        Fri, 19 May 2023 13:09:37 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ae7dd22ea1so318145ad.1;
        Fri, 19 May 2023 13:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684526977; x=1687118977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwOKloDvg1ZNDK0LMlCuSHhq2VpDE8rvC2g5Zyq0mFU=;
        b=IDMI0MkQWwmRtH+x509w+/BPnxWTe3AE3KbZB+OI3Eg0WWfrTTYkhzPtTw0HF0VvYJ
         gekS5GIjDEfyhTAnOmZLVvjE5quxBlqIbqqUtlmVIX6DWpRT3btGAnw4GddVCw/99IP8
         h63e1D0c7B3qrMpuI4S1oE8Z2eq6EbIrCsFMeHODzn8F2+GqHC4bwXPehQKQYDLIUEwJ
         6cIWG/YdOjD0u8QDcP0L4tJU3gdzop/ZQzh6fg6zA0NvVipHANn07Uxqom5MC9OeH/FH
         SluzyMCVd3e8NJ1OqsrRKmt/op4enl/BnXu6L4VkI1o0i1tLuvUyOAfIv64TdBFw8FzB
         5Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684526977; x=1687118977;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwOKloDvg1ZNDK0LMlCuSHhq2VpDE8rvC2g5Zyq0mFU=;
        b=h0+BMzeZTf7yaPqyv7wQPmfV3EFY4eyFd+fr+/tm5/3Rtw45QDM/WHnmK1qQnIhxh1
         GJSxnBg57w0zeF1cwPvZBhWLYHi97uxMg3J5uZMJdh7YtJl5LsusfVqVoAWgt87cIuFi
         9D9l1jNwX3BoAx/9ZGOyWUu3iBEfikMbWr67BcZ59w3k3hwhThmMsmRV6SxfFQDT1bnt
         yEyn4VUF/nNb4JhJUWhN6abJrY1UPieWXdKYzXXYOOqChtIa30ll5Ap0rV6h4NGq+ZjP
         RHKkQLqcJkkrc3F84DQMK38sAHY7RUBXYh9G9pLHDx5C3OEpkGFuuYWWk+foDH5Z1oa6
         jOqw==
X-Gm-Message-State: AC+VfDwJpIkqMdKzwJRQ6RzKi96N/ydi39zOzzagH6Fej2l2w4OB+O7A
        GKbSxGKfSR3tSIqmTjNVcZM=
X-Google-Smtp-Source: ACHHUZ7i2KZvjhivH8RjcXk11sX3CRJecRzRPWEjQs2sKE/OSBKvSX643EBdIgg4MQtih8JG3bYQdg==
X-Received: by 2002:a17:902:ec8a:b0:1a9:6467:aa8d with SMTP id x10-20020a170902ec8a00b001a96467aa8dmr4014866plg.1.1684526977070;
        Fri, 19 May 2023 13:09:37 -0700 (PDT)
Received: from ip-172-31-38-16.us-west-2.compute.internal (ec2-52-37-71-140.us-west-2.compute.amazonaws.com. [52.37.71.140])
        by smtp.gmail.com with ESMTPSA id p17-20020a170902ead100b001ac8cd5ecd6sm40769pld.65.2023.05.19.13.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:09:36 -0700 (PDT)
Date:   Fri, 19 May 2023 20:09:35 +0000
From:   Alok Tiagi <aloktiagi@gmail.com>
To:     viro@zeniv.linux.org.uk, willy@infradead.org, brauner@kernel.org,
        David.Laight@aculab.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, hch@infradead.org, tycho@tycho.pizza,
        aloktiagi@gmail.com
Subject: Re: [RFC v5 2/2] seccomp: replace existing file in the epoll
 interface by a new file injected by the syscall supervisor.
Message-ID: <ZGfXf8c3MwUe/qCe@ip-172-31-38-16.us-west-2.compute.internal>
References: <20230429054955.1957024-1-aloktiagi@gmail.com>
 <20230429054955.1957024-2-aloktiagi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429054955.1957024-2-aloktiagi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Apr 29, 2023 at 05:49:55AM +0000, aloktiagi wrote:
> Introduce a mechanism to replace a file linked in the epoll interface by a new
> file injected by the syscall supervisor by using the epoll provided
> eventpoll_replace_file() api.
> 
> Also introduce a new addfd flag SECCOMP_ADDFD_FLAG_REPLACE_REF to allow the supervisor
> to indicate that it is interested in getting the original file replaced by the
> new injected file.
> 
> We have a use case where multiple IPv6 only network namespaces can use a single
> IPv4 network namespace for IPv4 only egress connectivity by switching their
> sockets from IPv6 to IPv4 network namespace. This allows for migration of
> systems to IPv6 only while keeping their connectivity to IPv4 only destinations
> intact.
> 
> Today, we achieve this by setting up seccomp filter to intercept network system
> calls like connect() from a container in a syscall supervisor which runs in an
> IPv4 only network namespace. The syscall supervisor creates a new IPv4 connection
> and injects the new file descriptor through SECCOMP_NOTIFY_IOCTL_ADDFD replacing
> the original file descriptor from the connect() call. This does not work for
> cases where the original file descriptor is handed off to a system like epoll
> before the connect() call. After a new file descriptor is injected the original
> file descriptor being referenced by the epoll fd is not longer valid leading to
> failures. As a workaround the syscall supervisor when intercepting connect()
> loops through all open socket file descriptors to check if they are referencing
> the socket attempting the connect() and replace the reference with the to be
> injected file descriptor. This workaround is cumbersome and makes the solution
> prone to similar yet to be discovered issues.
> 
> The above change will enable us remove the workaround in the syscall supervisor
> and let the kernel handle the replacement correctly.
> 
> Signed-off-by: aloktiagi <aloktiagi@gmail.com>
> ---
>  include/uapi/linux/seccomp.h                  |   1 +
>  kernel/seccomp.c                              |  35 +++++-
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 102 ++++++++++++++++++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/seccomp.h b/include/uapi/linux/seccomp.h
> index 0fdc6ef02b94..0a74dc5d967f 100644
> --- a/include/uapi/linux/seccomp.h
> +++ b/include/uapi/linux/seccomp.h
> @@ -118,6 +118,7 @@ struct seccomp_notif_resp {
>  /* valid flags for seccomp_notif_addfd */
>  #define SECCOMP_ADDFD_FLAG_SETFD	(1UL << 0) /* Specify remote fd */
>  #define SECCOMP_ADDFD_FLAG_SEND		(1UL << 1) /* Addfd and return it, atomically */
> +#define SECCOMP_ADDFD_FLAG_REPLACE_REF	(1UL << 2) /* Update replace references */
>  
>  /**
>   * struct seccomp_notif_addfd
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index cebf26445f9e..5b1b265b30d9 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -19,6 +19,7 @@
>  #include <linux/audit.h>
>  #include <linux/compat.h>
>  #include <linux/coredump.h>
> +#include <linux/eventpoll.h>
>  #include <linux/kmemleak.h>
>  #include <linux/nospec.h>
>  #include <linux/prctl.h>
> @@ -1056,6 +1057,7 @@ static u64 seccomp_next_notify_id(struct seccomp_filter *filter)
>  static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_knotif *n)
>  {
>  	int fd;
> +	struct file *old_file = NULL;
>  
>  	/*
>  	 * Remove the notification, and reset the list pointers, indicating
> @@ -1064,8 +1066,30 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
>  	list_del_init(&addfd->list);
>  	if (!addfd->setfd)
>  		fd = receive_fd(addfd->file, addfd->flags);
> -	else
> +	else {
> +		int ret = 0;
> +		if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_REPLACE_REF) {
> +			old_file = fget(addfd->fd);
> +			if (!old_file) {
> +				fd = -EBADF;
> +				goto error;
> +			}
> +			ret = eventpoll_replace_file(old_file, addfd->file, addfd->fd);
> +			if (ret < 0) {
> +				fd = ret;
> +				goto error;
> +			}
> +		}
>  		fd = receive_fd_replace(addfd->fd, addfd->file, addfd->flags);
> +		/* In case of error restore all references */
> +		if (fd < 0 && addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_REPLACE_REF) {
> +			ret = eventpoll_replace_file(addfd->file, old_file, addfd->fd);
> +			if (ret < 0) {
> +				fd = ret;
> +			}
> +		}
> +	}
> +error:
>  	addfd->ret = fd;
>  
>  	if (addfd->ioctl_flags & SECCOMP_ADDFD_FLAG_SEND) {
> @@ -1080,6 +1104,9 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
>  		}
>  	}
>  
> +	if (old_file)
> +		fput(old_file);
> +
>  	/*
>  	 * Mark the notification as completed. From this point, addfd mem
>  	 * might be invalidated and we can't safely read it anymore.
> @@ -1613,12 +1640,16 @@ static long seccomp_notify_addfd(struct seccomp_filter *filter,
>  	if (addfd.newfd_flags & ~O_CLOEXEC)
>  		return -EINVAL;
>  
> -	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND))
> +	if (addfd.flags & ~(SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_SEND |
> +			    SECCOMP_ADDFD_FLAG_REPLACE_REF))
>  		return -EINVAL;
>  
>  	if (addfd.newfd && !(addfd.flags & SECCOMP_ADDFD_FLAG_SETFD))
>  		return -EINVAL;
>  
> +	if (!addfd.newfd && (addfd.flags & SECCOMP_ADDFD_FLAG_REPLACE_REF))
> +		return -EINVAL;
> +
>  	kaddfd.file = fget(addfd.srcfd);
>  	if (!kaddfd.file)
>  		return -EBADF;
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 61386e499b77..3ece9407c6a9 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -47,6 +47,7 @@
>  #include <linux/kcmp.h>
>  #include <sys/resource.h>
>  #include <sys/capability.h>
> +#include <sys/epoll.h>
>  
>  #include <unistd.h>
>  #include <sys/syscall.h>
> @@ -4179,6 +4180,107 @@ TEST(user_notification_addfd)
>  	close(memfd);
>  }
>  
> +TEST(user_notification_addfd_with_epoll_replace)
> +{
> +	char c;
> +	pid_t pid;
> +	long ret;
> +	int optval;
> +	socklen_t optlen = sizeof(optval);
> +	int status, listener, fd;
> +	int efd, sfd[4];
> +	struct epoll_event e;
> +	struct seccomp_notif_addfd addfd = {};
> +	struct seccomp_notif req = {};
> +	struct seccomp_notif_resp resp = {};
> +
> +	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
> +	ASSERT_EQ(0, ret) {
> +		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> +	}
> +
> +	listener = user_notif_syscall(__NR_getsockopt,
> +				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
> +
> +	/* Create two socket pairs sfd[0] <-> sfd[1] and sfd[2] <-> sfd[3] */
> +	ASSERT_EQ(socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[2]), 0);
> +
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (pid == 0) {
> +		if (socketpair(AF_UNIX, SOCK_STREAM, 0, &sfd[0]) != 0)
> +			exit(1);
> +
> +		efd = epoll_create(1);
> +		if (efd == -1)
> +			exit(1);
> +
> +		e.events = EPOLLIN;
> +		if (epoll_ctl(efd, EPOLL_CTL_ADD, sfd[0], &e) != 0)
> +			exit(1);
> +
> +		/*
> +		 * fd will be added here to replace an existing one linked
> +		 * in the epoll interface.
> +		 */
> +		if (getsockopt(sfd[0], SOL_SOCKET, SO_DOMAIN, &optval,
> +		       &optlen) != USER_NOTIF_MAGIC)
> +			exit(1);
> +
> +		/*
> +		 * Write data to the sfd[3] connected to sfd[2], but due to
> +		 * the swap, we should see data on sfd[0]
> +		 */
> +		if (write(sfd[3], "w", 1) != 1)
> +			exit(1);
> +
> +		if (epoll_wait(efd, &e, 1, 0) != 1)
> +			exit(1);
> +
> +		if (read(sfd[0], &c, 1) != 1)
> +			exit(1);
> +
> +		if ('w' != c)
> +			exit(1);
> +
> +		if (epoll_ctl(efd, EPOLL_CTL_DEL, sfd[0], &e) != 0)
> +			exit(1);
> +
> +		close(efd);
> +		close(sfd[0]);
> +		close(sfd[1]);
> +		close(sfd[2]);
> +		close(sfd[3]);
> +		exit(0);
> +	}
> +
> +	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
> +
> +	addfd.srcfd = sfd[2];
> +	addfd.newfd = req.data.args[0];
> +	addfd.id = req.id;
> +	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD | SECCOMP_ADDFD_FLAG_REPLACE_REF;
> +	addfd.newfd_flags = O_CLOEXEC;
> +
> +	/*
> +	 * Verfiy we can install and replace a file that is linked in the
> +	 * epoll interface. Replace the socket sfd[0] with sfd[2]
> +	 */
> +	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
> +	EXPECT_EQ(fd, req.data.args[0]);
> +
> +	resp.id = req.id;
> +	resp.error = 0;
> +	resp.val = USER_NOTIF_MAGIC;
> +	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
> +
> +	/* Wait for child to finish. */
> +	EXPECT_EQ(waitpid(pid, &status, 0), pid);
> +	EXPECT_EQ(true, WIFEXITED(status));
> +	EXPECT_EQ(0, WEXITSTATUS(status));
> +}
> +
>  TEST(user_notification_addfd_rlimit)
>  {
>  	pid_t pid;
> -- 
> 2.34.1
> 

thoughts on this?

- Alok 
