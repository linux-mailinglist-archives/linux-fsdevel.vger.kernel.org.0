Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C292513D6FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2020 10:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbgAPJiJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jan 2020 04:38:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:34458 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgAPJiJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jan 2020 04:38:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D042B1AB;
        Thu, 16 Jan 2020 09:38:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 213631E0CBC; Thu, 16 Jan 2020 10:38:07 +0100 (CET)
Date:   Thu, 16 Jan 2020 10:38:07 +0100
From:   Jan Kara <jack@suse.cz>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH V2 05/12] fs: remove unneeded IS_DAX() check
Message-ID: <20200116093807.GB8446@quack2.suse.cz>
References: <20200110192942.25021-1-ira.weiny@intel.com>
 <20200110192942.25021-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110192942.25021-6-ira.weiny@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 10-01-20 11:29:35, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The IS_DAX() check in io_is_direct() causes a race between changing the
> DAX mode and creating the iocb flags.
> 
> Remove the check because DAX now emulates the page cache API and
> therefore it does not matter if the file mode is DAX or not when the
> iocb flags are created.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

The patch looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index d7584bcef5d3..e11989502eac 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3365,7 +3365,7 @@ extern int file_update_time(struct file *file);
>  
>  static inline bool io_is_direct(struct file *filp)
>  {
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> +	return (filp->f_flags & O_DIRECT);
>  }
>  
>  static inline bool vma_is_dax(struct vm_area_struct *vma)
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
