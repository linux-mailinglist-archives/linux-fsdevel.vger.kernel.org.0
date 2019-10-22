Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08106E02CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388099AbfJVLYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 07:24:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:60080 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387645AbfJVLYu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 07:24:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 55868BA3D;
        Tue, 22 Oct 2019 11:24:47 +0000 (UTC)
Date:   Tue, 22 Oct 2019 13:24:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Christie <mchristi@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, martin@urbackup.org,
        Damien.LeMoal@wdc.com
Subject: Re: [PATCH] Add prctl support for controlling PF_MEMALLOC V2
Message-ID: <20191022112446.GA8213@dhcp22.suse.cz>
References: <20191021214137.8172-1-mchristi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021214137.8172-1-mchristi@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 21-10-19 16:41:37, Mike Christie wrote:
> There are several storage drivers like dm-multipath, iscsi, tcmu-runner,
> amd nbd that have userspace components that can run in the IO path. For
> example, iscsi and nbd's userspace deamons may need to recreate a socket
> and/or send IO on it, and dm-multipath's daemon multipathd may need to
> send IO to figure out the state of paths and re-set them up.
> 
> In the kernel these drivers have access to GFP_NOIO/GFP_NOFS and the
> memalloc_*_save/restore functions to control the allocation behavior,
> but for userspace we would end up hitting a allocation that ended up
> writing data back to the same device we are trying to allocate for.

Which code paths are we talking about here? Any ioctl or is this a
general syscall path? Can we mark the process in a more generic way?
E.g. we have PF_LESS_THROTTLE (used by nfsd). It doesn't affect the
reclaim recursion but it shows a pattern that doesn't really exhibit
too many internals. Maybe we need PF_IO_FLUSHER or similar?

> This patch allows the userspace deamon to set the PF_MEMALLOC* flags
> with prctl during their initialization so later allocations cannot
> calling back into them.

TBH I am not really happy to export these to the userspace. They are
an internal implementation detail and the userspace shouldn't really
care. So if this is really necessary then we need a very good argumnets
and documentation to make the usage clear.
 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> ---
> 
> V2:
> - Use prctl instead of procfs.
> - Add support for NOFS for fuse.
> - Check permissions.
> 
>  include/uapi/linux/prctl.h |  8 +++++++
>  kernel/sys.c               | 44 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> index 7da1b37b27aa..6f6b3af6633a 100644
> --- a/include/uapi/linux/prctl.h
> +++ b/include/uapi/linux/prctl.h
> @@ -234,4 +234,12 @@ struct prctl_mm_map {
>  #define PR_GET_TAGGED_ADDR_CTRL		56
>  # define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
>  
> +/* Control reclaim behavior when allocating memory */
> +#define PR_SET_MEMALLOC			57
> +#define PR_GET_MEMALLOC			58
> +#define PR_MEMALLOC_SET_NOIO		(1UL << 0)
> +#define PR_MEMALLOC_CLEAR_NOIO		(1UL << 1)
> +#define PR_MEMALLOC_SET_NOFS		(1UL << 2)
> +#define PR_MEMALLOC_CLEAR_NOFS		(1UL << 3)
> +
>  #endif /* _LINUX_PRCTL_H */
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a611d1d58c7d..34fedc9fc7e4 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2486,6 +2486,50 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
>  			return -EINVAL;
>  		error = GET_TAGGED_ADDR_CTRL();
>  		break;
> +	case PR_SET_MEMALLOC:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		if (arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		switch (arg2) {
> +		case PR_MEMALLOC_SET_NOIO:
> +			if (current->flags & PF_MEMALLOC_NOFS)
> +				return -EINVAL;
> +
> +			current->flags |= PF_MEMALLOC_NOIO;
> +			break;
> +		case PR_MEMALLOC_CLEAR_NOIO:
> +			current->flags &= ~PF_MEMALLOC_NOIO;
> +			break;
> +		case PR_MEMALLOC_SET_NOFS:
> +			if (current->flags & PF_MEMALLOC_NOIO)
> +				return -EINVAL;
> +
> +			current->flags |= PF_MEMALLOC_NOFS;
> +			break;
> +		case PR_MEMALLOC_CLEAR_NOFS:
> +			current->flags &= ~PF_MEMALLOC_NOFS;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		break;
> +	case PR_GET_MEMALLOC:
> +		if (!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +
> +		if (arg2 || arg3 || arg4 || arg5)
> +			return -EINVAL;
> +
> +		if (current->flags & PF_MEMALLOC_NOIO)
> +			error = PR_MEMALLOC_SET_NOIO;
> +		else if (current->flags & PF_MEMALLOC_NOFS)
> +			error = PR_MEMALLOC_SET_NOFS;
> +		else
> +			error = 0;
> +		break;
>  	default:
>  		error = -EINVAL;
>  		break;
> -- 
> 2.20.1
> 

-- 
Michal Hocko
SUSE Labs
