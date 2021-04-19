Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58AB36420E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 14:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhDSMvK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 08:51:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239228AbhDSMvI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 08:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C5AB26100A;
        Mon, 19 Apr 2021 12:50:36 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:50:33 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] pidfd_create(): remove static qualifier and declare
 pidfd_create() in linux/pid.h
Message-ID: <20210419125033.udjmsq3npmss26pv@wittgenstein>
References: <cover.1618527437.git.repnop@google.com>
 <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:22:09AM +1000, Matthew Bobrowski wrote:
> With the idea to have fanotify(7) return pidfds within a `struct
> fanotify_event_metadata`, pidfd_create()'s scope is to increased so
> that it can be called from other subsystems within the Linux
> kernel. The current `static` qualifier from its definition is to be
> removed and a new function declaration for pidfd_create() is to be
> added to the linux/pid.h header file.
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>  include/linux/pid.h | 1 +
>  kernel/pid.c        | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index fa10acb8d6a4..af308e15f174 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -78,6 +78,7 @@ struct file;
>  
>  extern struct pid *pidfd_pid(const struct file *file);
>  struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags);
> +int pidfd_create(struct pid *pid, unsigned int flags);
>  
>  static inline struct pid *get_pid(struct pid *pid)
>  {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index ebdf9c60cd0b..91c4b6891c15 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -553,7 +553,7 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
>   * Return: On success, a cloexec pidfd is returned.
>   *         On error, a negative errno number will be returned.
>   */
> -static int pidfd_create(struct pid *pid, unsigned int flags)

> +int pidfd_create(struct pid *pid, unsigned int flags)

Can you please add a comment to the kernel doc mentioning that this
helper is _not_ intended to be exported to modules? I don't want drivers
to get the idea that it's ok to start returning pidfds from everywhere
just yet.

And I think we should add sm like

	if (flags & ~(O_NONBLOCK | O_CLOEXEC | O_RDWR))
		return -EINVAL;

in pidfd_open() so future callers don't accidently create pidfds with
random flags we don't support.

Christian
