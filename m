Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D891B715C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 11:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDXJ7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 05:59:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:36590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXJ7r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:59:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77463AA7C;
        Fri, 24 Apr 2020 09:59:45 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 8CC761E128C; Fri, 24 Apr 2020 11:59:45 +0200 (CEST)
Date:   Fri, 24 Apr 2020 11:59:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: bmap: Remove the WARN and return the proper
 block address
Message-ID: <20200424095945.GC13069@quack2.suse.cz>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2e09c5d840458b4ace6f9b31429ceefd9c1df01.1587670914.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-04-20 12:52:18, Ritesh Harjani wrote:
> iomap_bmap() could be called from either of these two paths.
> Either when a user is calling an ioctl_fibmap() interface to get
> the block mapping address or by some filesystem via use of bmap()
> internal kernel API.
> bmap() kernel API is well equipped with handling of u64 addresses.
> 
> WARN condition in iomap_bmap_actor() was mainly added to warn all
> the fibmap users. But now that in previous patch we have directly added
> this WARN condition for all fibmap users and also made sure to return 0
> as block map address in case if addr > INT_MAX. 
> So we can now remove this logic from here.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Yes, I agree it's better to hadle the overflow in the ioctl than in the iomap
actor. The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/iomap/fiemap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
> index bccf305ea9ce..d55e8f491a5e 100644
> --- a/fs/iomap/fiemap.c
> +++ b/fs/iomap/fiemap.c
> @@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
>  
>  	if (iomap->type == IOMAP_MAPPED) {
>  		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
> -		if (addr > INT_MAX)
> -			WARN(1, "would truncate bmap result\n");
> -		else
> -			*bno = addr;
> +		*bno = addr;
>  	}
>  	return 0;
>  }
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
