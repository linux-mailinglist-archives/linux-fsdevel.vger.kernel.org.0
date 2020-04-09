Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97E071A34FC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 15:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgDINhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 09:37:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:49866 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgDINhW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6FD8AAE30;
        Thu,  9 Apr 2020 13:37:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DA5F71E124D; Thu,  9 Apr 2020 15:37:19 +0200 (CEST)
Date:   Thu, 9 Apr 2020 15:37:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        sandeen@sandeen.net
Subject: Re: [RFC 1/1] ext4: Fix race in
 ext4_mb_discard_group_preallocations()
Message-ID: <20200409133719.GA18960@quack2.suse.cz>
References: <cover.1586358980.git.riteshh@linux.ibm.com>
 <2e231c371cc83357a6c9d55e4f7284f6c1fb1741.1586358980.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e231c371cc83357a6c9d55e4f7284f6c1fb1741.1586358980.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Ritesh!

On Wed 08-04-20 22:24:10, Ritesh Harjani wrote:
> @@ -3908,16 +3919,13 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  
>  	mb_debug(1, "discard preallocation for group %u\n", group);
>  
> -	if (list_empty(&grp->bb_prealloc_list))
> -		return 0;
> -

OK, so ext4_mb_discard_preallocations() is now going to lock every group
when we try to discard preallocations. That's likely going to increase lock
contention on the group locks if we are running out of free blocks when
there are multiple processes trying to allocate blocks. I guess we don't
care about the performace of this case too deeply but I'm not sure if the
cost won't be too big - probably we should check how much the CPU usage
with multiple allocating process trying to find free blocks grows...

>  	bitmap_bh = ext4_read_block_bitmap(sb, group);
>  	if (IS_ERR(bitmap_bh)) {
>  		err = PTR_ERR(bitmap_bh);
>  		ext4_set_errno(sb, -err);
>  		ext4_error(sb, "Error %d reading block bitmap for %u",
>  			   err, group);
> -		return 0;
> +		goto out_dbg;
>  	}
>  
>  	err = ext4_mb_load_buddy(sb, group, &e4b);
> @@ -3925,7 +3933,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  		ext4_warning(sb, "Error %d loading buddy information for %u",
>  			     err, group);
>  		put_bh(bitmap_bh);
> -		return 0;
> +		goto out_dbg;
>  	}
>  
>  	if (needed == 0)
> @@ -3967,9 +3975,15 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>  		goto repeat;
>  	}
>  
> -	/* found anything to free? */
> +	/*
> +	 * If this list is empty, then return the grp->bb_free. As someone
> +	 * else may have freed the PAs and updated grp->bb_free.
> +	 */
>  	if (list_empty(&list)) {
>  		BUG_ON(free != 0);
> +		mb_debug(1, "Someone may have freed PA for this group %u, grp->bb_free %d\n",
> +			 group, grp->bb_free);
> +		free = grp->bb_free;
>  		goto out;
>  	}

OK, but this still doesn't reliably fix the problem, does it? Because
bb_free can be still zero and another process just has some extents to free
in its local 'list' (e.g. because it has decided it doesn't have enough
extents, some were busy and it decided to cond_resched()), so bb_free will
increase from 0 only once these extents are freed.

Honestly, I don't understand why ext4_mb_discard_group_preallocations()
bothers with the local 'list'. Why doesn't it simply free the preallocation
right away? And that would also basically fix your problem (well, it would
still theoretically exist because there's still freeing of one extent
potentially pending but I'm not sure if that will still be a practical
issue).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
