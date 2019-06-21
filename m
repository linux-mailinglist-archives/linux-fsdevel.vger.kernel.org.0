Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB44DF48
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 05:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbfFUDRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jun 2019 23:17:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbfFUDRj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jun 2019 23:17:39 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBC9020679;
        Fri, 21 Jun 2019 03:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561087058;
        bh=8upGiMNBTtWDElF9gjCLmVIbeZJwV8B0qLNbePNiBiU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i7NAHT3Z7Kbuc4XrtwXOF81T38DWmrfYNGoBYndscZEb0luoJO0t/EdZKKvzbOvX0
         ndbZtCx8sjRpIUemKoBxuF9qRXD3gVk9mg4H3uF3Xx1mOpmgmVa2tgoCOCaVDe5DIG
         xBvf1lzHH0jscgF3GCUVG9dpoP8HuP1RtKSkB8qc=
Date:   Thu, 20 Jun 2019 20:17:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v5 14/16] ext4: add basic fs-verity support
Message-ID: <20190621031736.GA742@sol.localdomain>
References: <20190620205043.64350-1-ebiggers@kernel.org>
 <20190620205043.64350-15-ebiggers@kernel.org>
 <20190620235938.GE5375@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620235938.GE5375@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Darrick,

On Thu, Jun 20, 2019 at 04:59:38PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > index 1cb67859e0518b..5a1deea3fb3e37 100644
> > --- a/fs/ext4/ext4.h
> > +++ b/fs/ext4/ext4.h
> > @@ -41,6 +41,7 @@
> >  #endif
> >  
> >  #include <linux/fscrypt.h>
> > +#include <linux/fsverity.h>
> >  
> >  #include <linux/compiler.h>
> >  
> > @@ -395,6 +396,7 @@ struct flex_groups {
> >  #define EXT4_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
> >  #define EXT4_HUGE_FILE_FL               0x00040000 /* Set to each huge file */
> >  #define EXT4_EXTENTS_FL			0x00080000 /* Inode uses extents */
> > +#define EXT4_VERITY_FL			0x00100000 /* Verity protected inode */
> 
> Hmm, a new inode flag, superblock rocompat feature flag, and
> (presumably) the Merkle tree has some sort of well defined format which
> starts at the next 64k boundary past EOF.
> 
> Would you mind updating the relevant parts of the ondisk format
> documentation in Documentation/filesystems/ext4/, please?
> 
> I saw that the Merkle tree and verity descriptor formats themselves are
> documented in the first patch, so you could simply link the ext4
> documentation to it.
> 

Sure, I'll update the ext4 documentation.

> > +/*
> > + * Read some verity metadata from the inode.  __vfs_read() can't be used because
> > + * we need to read beyond i_size.
> > + */
> > +static int pagecache_read(struct inode *inode, void *buf, size_t count,
> > +			  loff_t pos)
> > +{
> > +	while (count) {
> > +		size_t n = min_t(size_t, count,
> > +				 PAGE_SIZE - offset_in_page(pos));
> > +		struct page *page;
> > +		void *addr;
> > +
> > +		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
> > +					 NULL);
> > +		if (IS_ERR(page))
> > +			return PTR_ERR(page);
> > +
> > +		addr = kmap_atomic(page);
> > +		memcpy(buf, addr + offset_in_page(pos), n);
> > +		kunmap_atomic(addr);
> > +
> > +		put_page(page);
> > +
> > +		buf += n;
> > +		pos += n;
> > +		count -= n;
> > +	}
> > +	return 0;
> > +}
> > +
> > +/*
> > + * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
> > + * kernel_write() can't be used because the file descriptor is readonly.
> > + */
> > +static int pagecache_write(struct inode *inode, const void *buf, size_t count,
> > +			   loff_t pos)
> > +{
> > +	while (count) {
> > +		size_t n = min_t(size_t, count,
> > +				 PAGE_SIZE - offset_in_page(pos));
> > +		struct page *page;
> > +		void *fsdata;
> > +		void *addr;
> > +		int res;
> > +
> > +		res = pagecache_write_begin(NULL, inode->i_mapping, pos, n, 0,
> > +					    &page, &fsdata);
> > +		if (res)
> > +			return res;
> > +
> > +		addr = kmap_atomic(page);
> > +		memcpy(addr + offset_in_page(pos), buf, n);
> > +		kunmap_atomic(addr);
> > +
> > +		res = pagecache_write_end(NULL, inode->i_mapping, pos, n, n,
> > +					  page, fsdata);
> > +		if (res < 0)
> > +			return res;
> > +		if (res != n)
> > +			return -EIO;
> > +
> > +		buf += n;
> > +		pos += n;
> > +		count -= n;
> > +	}
> > +	return 0;
> > +}
> 
> This same code is duplicated in the f2fs patch.  Is there a reason why
> they don't share this common code?  Even if you have to hide it under
> fs/verity/ ?
> 

Yes, pagecache_read() and pagecache_write() are identical between ext4 and f2fs.
I didn't put them in fs/verity/ because the "metadata past EOF" approach is a
choice of ext4 and f2fs and not intrinsic to the fs-verity feature itself, so to
avoid confusion I made the fs/verity/ support layer be completely clean of any
assumption that that's the way filesystems implement fs-verity.

Also, making the fsverity_operations call back into fs/verity/ adds a little
extra conceptual complexity about what belongs where, since then we'd have a
call stack of filesystem => fs/verity/ => filesystem => fs/verity/.

But if people would rather that ext4 and f2fs share these two functions anyway,
then sure, we could move them into fs/verity/, and other filesystems (if they
take a different approach to fs-verity) simply won't use them.

- Eric
