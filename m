Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF1F32C51C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244136AbhCDATN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:13 -0500
Received: from verein.lst.de ([213.95.11.211]:36166 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356547AbhCCKrm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 01C4E68C65; Wed,  3 Mar 2021 10:30:53 +0100 (CET)
Date:   Wed, 3 Mar 2021 10:30:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-btrfs@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        david@fromorbit.com, hch@lst.de, rgoldwyn@suse.de,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v2 05/10] fsdax: Replace mmap entry in case of CoW
Message-ID: <20210303093052.GE12784@lst.de>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com> <20210226002030.653855-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226002030.653855-6-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:20:25AM +0800, Shiyang Ruan wrote:
> We replace the existing entry to the newly allocated one in case of CoW.
> Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
> entry as writeprotected.  This helps us snapshots so new write
> pagefaults after snapshots trigger a CoW.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  fs/dax.c | 37 ++++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 748dfb89fb41..ec4b733e0b59 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -722,6 +722,9 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>  	return 0;
>  }
>  
> +#define DAX_IF_DIRTY		(1 << 0)
> +#define DAX_IF_COW		(1 << 1)
> +
>  /*
>   * By this point grab_mapping_entry() has ensured that we have a locked entry
>   * of the appropriate size so we don't have to worry about downgrading PMDs to
> @@ -729,16 +732,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
>   * already in the tree, we will skip the insertion and just dirty the PMD as
>   * appropriate.
>   */
> -static void *dax_insert_entry(struct xa_state *xas,
> -		struct address_space *mapping, struct vm_fault *vmf,
> -		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
> +static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
> +		void *entry, pfn_t pfn, unsigned long flags,
> +		unsigned int insert_flags)
>  {
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
>  	void *new_entry = dax_make_entry(pfn, flags);
> +	bool dirty = insert_flags & DAX_IF_DIRTY;
> +	bool cow = insert_flags & DAX_IF_COW;
>  
>  	if (dirty)
>  		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);

I still think the __mark_inode_dirty should just be moved into the one
caller that needs it.
