Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B3B36444B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 15:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241635AbhDSN0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 09:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242068AbhDSNZQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:25:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2843A61363;
        Mon, 19 Apr 2021 13:20:23 +0000 (UTC)
Date:   Mon, 19 Apr 2021 15:20:20 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <20210419132020.ydyb2ly6e3clhe2j@wittgenstein>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:22:25AM +1000, Matthew Bobrowski wrote:
> Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> allows userspace applications to control whether a pidfd is to be
> returned instead of a pid for `struct fanotify_event_metadata.pid`.
> 
> FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> pidfd API is currently restricted to only support pidfd generation for
> thread-group leaders. Attempting to set them both when calling
> fanotify_init(2) will result in -EINVAL being returned to the
> caller. As the pidfd API evolves and support is added for tids, this
> is something that could be relaxed in the future.
> 
> If pidfd creation fails, the pid in struct fanotify_event_metadata is
> set to FAN_NOPIDFD(-1). Falling back and providing a pid instead of a
> pidfd on pidfd creation failures was considered, although this could
> possibly lead to confusion and unpredictability within userspace
> applications as distinguishing between whether an actual pidfd or pid
> was returned could be difficult, so it's best to be explicit.
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
>  include/linux/fanotify.h           |  2 +-
>  include/uapi/linux/fanotify.h      |  2 ++
>  3 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9e0c1afac8bd..fd8ae88796a8 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	struct fanotify_info *info = fanotify_event_info(event);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>  	struct file *f = NULL;
> -	int ret, fd = FAN_NOFD;
> +	int ret, pidfd, fd = FAN_NOFD;
>  	int info_type = 0;
>  
>  	pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	metadata.vers = FANOTIFY_METADATA_VERSION;
>  	metadata.reserved = 0;
>  	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> -	metadata.pid = pid_vnr(event->pid);
> +
> +	if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> +		pid_has_task(event->pid, PIDTYPE_TGID)) {
> +		/*
> +		 * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> +		 * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> +		 * blindly lifted without pidfds for threads actually being
> +		 * supported.
> +		 */
> +		WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +
> +		pidfd = pidfd_create(event->pid, 0);
> +		if (unlikely(pidfd < 0))
> +			metadata.pid = FAN_NOPIDFD;
> +		else
> +			metadata.pid = pidfd;

I'm not a fan of overloading fields (Yes, we did this for the _legacy_
clone() syscall for CLONE_PIDFD/CLONE_PARENT_SETTID but in general it's
never a good idea if there are other options, imho.).
Could/should we consider the possibility of adding a new pidfd field to
struct fanotify_event_metadata?

Christian
