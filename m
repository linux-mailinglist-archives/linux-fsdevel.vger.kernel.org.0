Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE32363F61
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238516AbhDSKOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 06:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238159AbhDSKOI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 06:14:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF431B1EE;
        Mon, 19 Apr 2021 10:13:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B20F91F2C6A; Mon, 19 Apr 2021 12:13:37 +0200 (CEST)
Date:   Mon, 19 Apr 2021 12:13:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     jack@suse.cz, amir73il@gmail.com, christian.brauner@ubuntu.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] pidfd_create(): remove static qualifier and declare
 pidfd_create() in linux/pid.h
Message-ID: <20210419101337.GC8706@quack2.suse.cz>
References: <cover.1618527437.git.repnop@google.com>
 <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14a09477f0b2d62a424b44e0a1f12f32ae3409bb.1618527437.git.repnop@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 16-04-21 09:22:09, Matthew Bobrowski wrote:
> With the idea to have fanotify(7) return pidfds within a `struct
> fanotify_event_metadata`, pidfd_create()'s scope is to increased so
> that it can be called from other subsystems within the Linux
> kernel. The current `static` qualifier from its definition is to be
> removed and a new function declaration for pidfd_create() is to be
> added to the linux/pid.h header file.
> 
> Signed-off-by: Matthew Bobrowski <repnop@google.com>

I'm fine with this but it would be good to get explicit Christian's ack on
this patch (I know he's already agreed with the intent in general).

								Honza

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
>  {
>  	int fd;
>  
> -- 
> 2.31.1.368.gbe11c130af-goog
> 
> /M
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
