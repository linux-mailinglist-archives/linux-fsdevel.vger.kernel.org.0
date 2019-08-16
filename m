Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5696190563
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2019 18:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfHPQEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Aug 2019 12:04:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:40504 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727441AbfHPQEn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:04:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 713FEAE1C;
        Fri, 16 Aug 2019 16:04:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B6161E4009; Fri, 16 Aug 2019 18:04:42 +0200 (CEST)
Date:   Fri, 16 Aug 2019 18:04:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com, jack@suse.cz,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH] locks: print a warning when mount fails due to lack of
 "mand" support
Message-ID: <20190816160442.GJ3041@quack2.suse.cz>
References: <20190815202718.18595-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815202718.18595-1-jlayton@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 15-08-19 16:27:18, Jeff Layton wrote:
> Since 9e8925b67a ("locks: Allow disabling mandatory locking at compile
> time"), attempts to mount filesystems with "-o mand" will fail.
> Unfortunately, there is no other indiciation of the reason for the
> failure.
> 
> Change how the function is defined for better readability. When
> CONFIG_MANDATORY_FILE_LOCKING is disabled, printk a warning when
> someone attempts to mount with -o mand.
> 
> Also, add a blurb to the mandatory-locking.txt file to explain about
> the "mand" option, and the behavior one should expect when it is
> disabled.
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/mandatory-locking.txt | 10 ++++++++++
>  fs/namespace.c                                  | 11 ++++++++---
>  2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/mandatory-locking.txt b/Documentation/filesystems/mandatory-locking.txt
> index 0979d1d2ca8b..a251ca33164a 100644
> --- a/Documentation/filesystems/mandatory-locking.txt
> +++ b/Documentation/filesystems/mandatory-locking.txt
> @@ -169,3 +169,13 @@ havoc if they lock crucial files. The way around it is to change the file
>  permissions (remove the setgid bit) before trying to read or write to it.
>  Of course, that might be a bit tricky if the system is hung :-(
>  
> +7. The "mand" mount option
> +--------------------------
> +Mandatory locking is disabled on all filesystems by default, and must be
> +administratively enabled by mounting with "-o mand". That mount option
> +is only allowed if the mounting task has the CAP_SYS_ADMIN capability.
> +
> +Since kernel v4.5, it is possible to disable mandatory locking
> +altogether by setting CONFIG_MANDATORY_FILE_LOCKING to "n". A kernel
> +with this disabled will reject attempts to mount filesystems with the
> +"mand" mount option with the error status EPERM.
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 6464ea4acba9..602bd78ba572 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -1643,13 +1643,18 @@ static inline bool may_mount(void)
>  	return ns_capable(current->nsproxy->mnt_ns->user_ns, CAP_SYS_ADMIN);
>  }
>  
> +#ifdef	CONFIG_MANDATORY_FILE_LOCKING
>  static inline bool may_mandlock(void)
>  {
> -#ifndef	CONFIG_MANDATORY_FILE_LOCKING
> -	return false;
> -#endif
>  	return capable(CAP_SYS_ADMIN);
>  }
> +#else
> +static inline bool may_mandlock(void)
> +{
> +	pr_warn("VFS: \"mand\" mount option not supported");
> +	return false;
> +}
> +#endif
>  
>  /*
>   * Now umount can handle mount points as well as block devices.
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
