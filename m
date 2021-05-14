Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B22380DBC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhENQEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 12:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhENQEn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 12:04:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24F3361285;
        Fri, 14 May 2021 16:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621008211;
        bh=UfeJ7rlevhsr3HctnQSBie4iO7A+TPVBMGPi49VXHnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXnS1foUKNRXlRF1vY+lluRf78Hl0XuUjmCoRkWLtdmP6haDdMwIFtPzB/VMQ6mlw
         ERBgpgY82yadY2SPS83ff3JyEeHDVlvn4UVyo+xGzwt+B+Bm1703OVIJ53hBCjuScu
         Iv8Ehzvf9XzeWQr2NcPSg9wHoUDmA9Z4HG6lx1uDDeWtQ/vwP3LsTAz5Es/n/ZL5oB
         qqoI1AhUU44IP0kT0Ny7+Eq3hzA/l56mmo8MsU33trzIoyU53UbskTfbhVIzoRayki
         p7u7YlQt9RjSqqu9BASocyuqBf8+quD2KRq9B4XICmPoUr9gHAetsnP49gFwY5TqSp
         H6UymVd9LaE0Q==
Date:   Fri, 14 May 2021 09:03:30 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
Message-ID: <20210514160330.GK9675@magnolia>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-6-ruansy.fnst@fujitsu.com>
 <20210512012336.GU8582@magnolia>
 <OSBPR01MB292047344E0119E78E4D443CF4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB292047344E0119E78E4D443CF4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 08:35:44AM +0000, ruansy.fnst@fujitsu.com wrote:
> 
> 
> > -----Original Message-----
> > From: Darrick J. Wong <djwong@kernel.org>
> > Subject: Re: [PATCH v5 5/7] fsdax: Dedup file range to use a compare function
> > 
> > On Tue, May 11, 2021 at 11:09:31AM +0800, Shiyang Ruan wrote:
> > > With dax we cannot deal with readpage() etc. So, we create a dax
> > > comparison funciton which is similar with
> > > vfs_dedupe_file_range_compare().
> > > And introduce dax_remap_file_range_prep() for filesystem use.
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> > > ---
> > >  fs/dax.c             | 56
> > +++++++++++++++++++++++++++++++++++++++++++
> > >  fs/remap_range.c     | 57
> > +++++++++++++++++++++++++++++++++++++-------
> > >  fs/xfs/xfs_reflink.c |  8 +++++--
> > >  include/linux/dax.h  |  4 ++++
> > >  include/linux/fs.h   | 12 ++++++----
> > >  5 files changed, 123 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/fs/dax.c b/fs/dax.c
> > > index ee9d28a79bfb..dedf1be0155c 100644
> > > --- a/fs/dax.c
> > > +++ b/fs/dax.c
> > > @@ -1853,3 +1853,59 @@ vm_fault_t dax_finish_sync_fault(struct vm_fault
> > *vmf,
> > >  	return dax_insert_pfn_mkwrite(vmf, pfn, order);  }
> > > EXPORT_SYMBOL_GPL(dax_finish_sync_fault);
> > > +
> > > +static loff_t dax_range_compare_actor(struct inode *ino1, loff_t pos1,
> > > +		struct inode *ino2, loff_t pos2, loff_t len, void *data,
> > > +		struct iomap *smap, struct iomap *dmap) {
> > > +	void *saddr, *daddr;
> > > +	bool *same = data;
> > > +	int ret;
> > > +
> > > +	if (smap->type == IOMAP_HOLE && dmap->type == IOMAP_HOLE) {
> > > +		*same = true;
> > > +		return len;
> > > +	}
> > > +
> > > +	if (smap->type == IOMAP_HOLE || dmap->type == IOMAP_HOLE) {
> > > +		*same = false;
> > > +		return 0;
> > > +	}
> > > +
> > > +	ret = dax_iomap_direct_access(smap, pos1, ALIGN(pos1 + len, PAGE_SIZE),
> > > +				      &saddr, NULL);
> > > +	if (ret < 0)
> > > +		return -EIO;
> > > +
> > > +	ret = dax_iomap_direct_access(dmap, pos2, ALIGN(pos2 + len, PAGE_SIZE),
> > > +				      &daddr, NULL);
> > > +	if (ret < 0)
> > > +		return -EIO;
> > > +
> > > +	*same = !memcmp(saddr, daddr, len);
> > > +	return len;
> > > +}
> > > +
> > > +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > +		struct inode *dest, loff_t destoff, loff_t len, bool *is_same,
> > > +		const struct iomap_ops *ops)
> > > +{
> > > +	int id, ret = 0;
> > > +
> > > +	id = dax_read_lock();
> > > +	while (len) {
> > > +		ret = iomap_apply2(src, srcoff, dest, destoff, len, 0, ops,
> > > +				   is_same, dax_range_compare_actor);
> > > +		if (ret < 0 || !*is_same)
> > > +			goto out;
> > > +
> > > +		len -= ret;
> > > +		srcoff += ret;
> > > +		destoff += ret;
> > > +	}
> > > +	ret = 0;
> > > +out:
> > > +	dax_read_unlock(id);
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(dax_dedupe_file_range_compare);
> > > diff --git a/fs/remap_range.c b/fs/remap_range.c index
> > > e4a5fdd7ad7b..7bc4c8e3aa9f 100644
> > > --- a/fs/remap_range.c
> > > +++ b/fs/remap_range.c
> > > @@ -14,6 +14,7 @@
> > >  #include <linux/compat.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/fs.h>
> > > +#include <linux/dax.h>
> > >  #include "internal.h"
> > >
> > >  #include <linux/uaccess.h>
> > > @@ -199,9 +200,9 @@ static void vfs_unlock_two_pages(struct page *page1,
> > struct page *page2)
> > >   * Compare extents of two files to see if they are the same.
> > >   * Caller must have locked both inodes to prevent write races.
> > >   */
> > > -static int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > -					 struct inode *dest, loff_t destoff,
> > > -					 loff_t len, bool *is_same)
> > > +int vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > +				  struct inode *dest, loff_t destoff,
> > > +				  loff_t len, bool *is_same)
> > >  {
> > >  	loff_t src_poff;
> > >  	loff_t dest_poff;
> > > @@ -280,6 +281,7 @@ static int vfs_dedupe_file_range_compare(struct
> > > inode *src, loff_t srcoff,
> > >  out_error:
> > >  	return error;
> > >  }
> > > +EXPORT_SYMBOL(vfs_dedupe_file_range_compare);
> > >
> > >  /*
> > >   * Check that the two inodes are eligible for cloning, the ranges
> > > make @@ -289,9 +291,11 @@ static int
> > vfs_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > >   * If there's an error, then the usual negative error code is returned.
> > >   * Otherwise returns 0 with *len set to the request length.
> > >   */
> > > -int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > -				  struct file *file_out, loff_t pos_out,
> > > -				  loff_t *len, unsigned int remap_flags)
> > > +static int
> > > +__generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +				struct file *file_out, loff_t pos_out,
> > > +				loff_t *len, unsigned int remap_flags,
> > > +				const struct iomap_ops *dax_read_ops)
> > >  {
> > >  	struct inode *inode_in = file_inode(file_in);
> > >  	struct inode *inode_out = file_inode(file_out); @@ -351,8 +355,17 @@
> > > int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > >  	if (remap_flags & REMAP_FILE_DEDUP) {
> > >  		bool		is_same = false;
> > >
> > > -		ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > > -				inode_out, pos_out, *len, &is_same);
> > > +		if (!IS_DAX(inode_in))
> > > +			ret = vfs_dedupe_file_range_compare(inode_in, pos_in,
> > > +					inode_out, pos_out, *len, &is_same); #ifdef
> > CONFIG_FS_DAX
> > > +		else if (dax_read_ops)
> > > +			ret = dax_dedupe_file_range_compare(inode_in, pos_in,
> > > +					inode_out, pos_out, *len, &is_same,
> > > +					dax_read_ops);
> > > +#endif /* CONFIG_FS_DAX */
> > 
> > Hmm, can you add an entry to the !IS_ENABLED(CONFIG_DAX) part of dax.h
> > that defines dax_dedupe_file_range_compare as a dummy function that returns
> > -EOPNOTSUPP?  We try not to sprinkle preprocessor directives into the middle
> > of functions, per Linus rules.
> 
> I found that it's ok to build without the #ifdef and #endif here, even
> though CONFIG_FS_DAX is disabled.
> And like other dax functions in fs/dax.c, such as dax_iomap_rw(), it
> is declared in include/linux/dax.h without IS_ENABLED() or #ifdef
> wrapped.  And xfs calls it directly and it won't cause build error.
> So, I think I could just remove the #ifdef here, but I am not sure if
> this obeys the rule.

If it doesn't break the build (yay kbuild robot!) then it's probably
ok.

> > 
> > > +		else
> > > +			return -EINVAL;
> > >  		if (ret)
> > >  			return ret;
> > >  		if (!is_same)
> > > @@ -370,6 +383,34 @@ int generic_remap_file_range_prep(struct file
> > > *file_in, loff_t pos_in,
> > >
> > >  	return ret;
> > >  }
> > > +
> > > +#ifdef CONFIG_FS_DAX
> > > +int dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +			      struct file *file_out, loff_t pos_out,
> > > +			      loff_t *len, unsigned int remap_flags,
> > > +			      const struct iomap_ops *ops) {
> > > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > > +					       pos_out, len, remap_flags, ops); } #else int
> > > +dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +			      struct file *file_out, loff_t pos_out,
> > > +			      loff_t *len, unsigned int remap_flags,
> > > +			      const struct iomap_ops *ops) {
> > > +	return -EOPNOTSUPP;
> > > +}
> > > +#endif /* CONFIG_FS_DAX */
> > > +EXPORT_SYMBOL(dax_remap_file_range_prep);
> > 
> > I think this symbol belongs in fs/dax.c and the declaration in dax.h?
> 
> For the function name, it does should belong to fs/dax.  But if so,
> __generic_remap_file_range_prep() needs to be called in fs/dax.  I
> don't think this is good.

Why not?  FS_DAX is a boolean, so fs/dax.o will get linked into the same
vmlinux file as fs/remap_range.o.

--D

> 
> 
> --
> Thanks,
> Ruan Shiyang.
> 
> > 
> > --D
> > 
> > > +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +				  struct file *file_out, loff_t pos_out,
> > > +				  loff_t *len, unsigned int remap_flags) {
> > > +	return __generic_remap_file_range_prep(file_in, pos_in, file_out,
> > > +					       pos_out, len, remap_flags, NULL); }
> > >  EXPORT_SYMBOL(generic_remap_file_range_prep);
> > >
> > >  loff_t do_clone_file_range(struct file *file_in, loff_t pos_in, diff
> > > --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c index
> > > 060695d6d56a..d25434f93235 100644
> > > --- a/fs/xfs/xfs_reflink.c
> > > +++ b/fs/xfs/xfs_reflink.c
> > > @@ -1329,8 +1329,12 @@ xfs_reflink_remap_prep(
> > >  	if (IS_DAX(inode_in) || IS_DAX(inode_out))
> > >  		goto out_unlock;
> > >
> > > -	ret = generic_remap_file_range_prep(file_in, pos_in, file_out, pos_out,
> > > -			len, remap_flags);
> > > +	if (!IS_DAX(inode_in))
> > > +		ret = generic_remap_file_range_prep(file_in, pos_in, file_out,
> > > +				pos_out, len, remap_flags);
> > > +	else
> > > +		ret = dax_remap_file_range_prep(file_in, pos_in, file_out,
> > > +				pos_out, len, remap_flags, &xfs_read_iomap_ops);
> > >  	if (ret || *len == 0)
> > >  		goto out_unlock;
> > >
> > > diff --git a/include/linux/dax.h b/include/linux/dax.h index
> > > 3275e01ed33d..32e1c34349f2 100644
> > > --- a/include/linux/dax.h
> > > +++ b/include/linux/dax.h
> > > @@ -239,6 +239,10 @@ int dax_invalidate_mapping_entry_sync(struct
> > address_space *mapping,
> > >  				      pgoff_t index);
> > >  s64 dax_iomap_zero(loff_t pos, u64 length, struct iomap *iomap,
> > >  		struct iomap *srcmap);
> > > +int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
> > > +				  struct inode *dest, loff_t destoff,
> > > +				  loff_t len, bool *is_same,
> > > +				  const struct iomap_ops *ops);
> > >  static inline bool dax_mapping(struct address_space *mapping)  {
> > >  	return mapping->host && IS_DAX(mapping->host); diff --git
> > > a/include/linux/fs.h b/include/linux/fs.h index
> > > c3c88fdb9b2a..e2c348553d87 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -71,6 +71,7 @@ struct fsverity_operations;  struct fs_context;
> > > struct fs_parameter_spec;  struct fileattr;
> > > +struct iomap_ops;
> > >
> > >  extern void __init inode_init(void);
> > >  extern void __init inode_init_early(void); @@ -2126,10 +2127,13 @@
> > > extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file
> > > *,  extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
> > >  				       struct file *file_out, loff_t pos_out,
> > >  				       size_t len, unsigned int flags); -extern int
> > > generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > -					 struct file *file_out, loff_t pos_out,
> > > -					 loff_t *count,
> > > -					 unsigned int remap_flags);
> > > +int generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +				  struct file *file_out, loff_t pos_out,
> > > +				  loff_t *count, unsigned int remap_flags); int
> > > +dax_remap_file_range_prep(struct file *file_in, loff_t pos_in,
> > > +			      struct file *file_out, loff_t pos_out,
> > > +			      loff_t *len, unsigned int remap_flags,
> > > +			      const struct iomap_ops *ops);
> > >  extern loff_t do_clone_file_range(struct file *file_in, loff_t pos_in,
> > >  				  struct file *file_out, loff_t pos_out,
> > >  				  loff_t len, unsigned int remap_flags);
> > > --
> > > 2.31.1
> > >
> > >
> > >
