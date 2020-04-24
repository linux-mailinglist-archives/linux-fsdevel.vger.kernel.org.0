Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD231B7151
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 11:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDXJ5s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 05:57:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:34426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgDXJ5s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 05:57:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 21EACACD8;
        Fri, 24 Apr 2020 09:57:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 349F21E128C; Fri, 24 Apr 2020 11:57:46 +0200 (CEST)
Date:   Fri, 24 Apr 2020 11:57:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] fibmap: Warn and return an error in case of block >
 INT_MAX
Message-ID: <20200424095746.GB13069@quack2.suse.cz>
References: <cover.1587670914.git.riteshh@linux.ibm.com>
 <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e34d1ac05d29aeeb982713a807345a0aaafc7fe0.1587670914.git.riteshh@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 24-04-20 12:52:17, Ritesh Harjani wrote:
> We better warn the fibmap user and not return a truncated and therefore
> an incorrect block map address if the bmap() returned block address
> is greater than INT_MAX (since user supplied integer pointer).
> 
> It's better to WARN all user of ioctl_fibmap() and return a proper error
> code rather than silently letting a FS corruption happen if the user tries
> to fiddle around with the returned block map address.
> 
> We fix this by returning an error code of -ERANGE and returning 0 as the
> block mapping address in case if it is > INT_MAX.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ioctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index f1d93263186c..3489f3a12c1d 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -71,6 +71,11 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
>  	block = ur_block;
>  	error = bmap(inode, &block);
>  
> +	if (block > INT_MAX) {
> +		error = -ERANGE;
> +		WARN(1, "would truncate fibmap result\n");
> +	}
> +
>  	if (error)
>  		ur_block = 0;
>  	else
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
