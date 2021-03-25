Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4EA3494CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhCYPAq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Mar 2021 11:00:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:37092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhCYPA1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Mar 2021 11:00:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24CB9AA55;
        Thu, 25 Mar 2021 15:00:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id A5DEE1E4415; Thu, 25 Mar 2021 16:00:25 +0100 (CET)
Date:   Thu, 25 Mar 2021 16:00:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Hugh Dickins <hughd@google.com>,
        Theodore Tso <tytso@mit.edu>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] shmem: allow reporting fanotify events with file
 handles on tmpfs
Message-ID: <20210325150025.GF13673@quack2.suse.cz>
References: <20210322173944.449469-1-amir73il@gmail.com>
 <20210322173944.449469-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322173944.449469-3-amir73il@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 22-03-21 19:39:44, Amir Goldstein wrote:
> Since kernel v5.1, fanotify_init(2) supports the flag FAN_REPORT_FID
> for identifying objects using file handle and fsid in events.
> 
> fanotify_mark(2) fails with -ENODEV when trying to set a mark on
> filesystems that report null f_fsid in stasfs(2).
> 
> Use the digest of uuid as f_fsid for tmpfs to uniquely identify tmpfs
> objects as best as possible and allow setting an fanotify mark that
> reports events with file handles on tmpfs.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Hugh, any opinion on this patch?

								Honza

> ---
>  mm/shmem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b2db4ed0fbc7..162d8f8993bb 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2846,6 +2846,9 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
>  		buf->f_ffree = sbinfo->free_inodes;
>  	}
>  	/* else leave those fields 0 like simple_statfs */
> +
> +	buf->f_fsid = uuid_to_fsid(dentry->d_sb->s_uuid.b);
> +
>  	return 0;
>  }
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
