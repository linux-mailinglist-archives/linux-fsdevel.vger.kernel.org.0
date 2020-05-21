Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2D91DD9B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 May 2020 23:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgEUVzc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 May 2020 17:55:32 -0400
Received: from mail108.syd.optusnet.com.au ([211.29.132.59]:56002 "EHLO
        mail108.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730122AbgEUVzc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 May 2020 17:55:32 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail108.syd.optusnet.com.au (Postfix) with ESMTPS id 9F4AD1A7F66;
        Fri, 22 May 2020 07:55:27 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jbt9v-0000Si-Bl; Fri, 22 May 2020 07:55:23 +1000
Date:   Fri, 22 May 2020 07:55:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/36] fs: Add a filesystem flag for large pages
Message-ID: <20200521215523.GR2005@dread.disaster.area>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-8-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-8-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=JfrnYn6hAAAA:8 a=7-415B0cAAAA:8
        a=khlJBHKmE670Q-po3lMA:9 a=70w1-rSo-Nt5nqzG:21 a=UBtUr0dm7oXX99_u:21
        a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:27AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> The page cache needs to know whether the filesystem supports pages >
> PAGE_SIZE.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/fs.h      | 1 +
>  include/linux/pagemap.h | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 55c743925c40..777783c8760b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2241,6 +2241,7 @@ struct file_system_type {
>  #define FS_HAS_SUBTYPE		4
>  #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
>  #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
> +#define FS_LARGE_PAGES		8192	/* Remove once all fs converted */
>  #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
>  	int (*init_fs_context)(struct fs_context *);
>  	const struct fs_parameter_spec *parameters;
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 36bfc9d855bb..c6db74b5e62f 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -116,6 +116,11 @@ static inline void mapping_set_gfp_mask(struct address_space *m, gfp_t mask)
>  	m->gfp_mask = mask;
>  }
>  
> +static inline bool mapping_large_pages(struct address_space *mapping)
> +{
> +	return mapping->host->i_sb->s_type->fs_flags & FS_LARGE_PAGES;
> +}

If you've got to dereference 4 layers deep to check a behaviour
flag, the object needs it's own flag.  Can you just propagate this
to the address space when the inode is instantiated and the address
space initialised?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
