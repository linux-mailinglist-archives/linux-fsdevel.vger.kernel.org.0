Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17F5016853A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgBURmV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Feb 2020 12:42:21 -0500
Received: from verein.lst.de ([213.95.11.211]:56711 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgBURmV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:42:21 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4E3668BFE; Fri, 21 Feb 2020 18:42:17 +0100 (CET)
Date:   Fri, 21 Feb 2020 18:42:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH V4 03/13] fs: Remove unneeded IS_DAX() check
Message-ID: <20200221174217.GA11378@lst.de>
References: <20200221004134.30599-1-ira.weiny@intel.com> <20200221004134.30599-4-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221004134.30599-4-ira.weiny@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:41:24PM -0800, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Remove the check because DAX now has it's own read/write methods and
> file systems which support DAX check IS_DAX() prior to IOCB_DIRECT on
> their own.  Therefore, it does not matter if the file state is DAX when
> the iocb flags are created.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from v3:
> 	Reword commit message.
> 	Reordered to be a 'pre-cleanup' patch
> ---
>  include/linux/fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3cd4fe6b845e..63d1e533a07d 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3388,7 +3388,7 @@ extern int file_update_time(struct file *file);
>  
>  static inline bool io_is_direct(struct file *filp)
>  {
> -	return (filp->f_flags & O_DIRECT) || IS_DAX(filp->f_mapping->host);
> +	return (filp->f_flags & O_DIRECT);

Please just kill io_is_direct entirely.
