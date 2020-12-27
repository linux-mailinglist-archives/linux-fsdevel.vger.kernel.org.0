Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845D92E3106
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Dec 2020 13:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgL0MAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Dec 2020 07:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgL0MAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Dec 2020 07:00:39 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A1C061794;
        Sun, 27 Dec 2020 03:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5uwYsgKdAULuF/GQ5sfCvBZKMe+X+d+8OkxeVuEmVJA=; b=IjBY/sHC2/QcJWOmpl7VLlP7Jf
        XOE8XGkn+3w0uboL02YaLa35ppR1NAmAR6R0bSwCV4SA7qE6KVMRkxt+rj2SZjYtAX4Vvp+rQ6X+L
        yoTSGRfIbGeRwSIlWOr43PT/49Q/wVO9OxiROdlQXIfCyeWKO35VHe1/e19UQMC5deFxCW/Dx4l6X
        L5MXthZUbL3KdF4rt0B1rTf6OAqR/kWVfW+wktWfVInuZKjEXpZmUTWILci1Up6fHnGAyNxuj9zKY
        sB3yNCqCxl228B1vOG83sKPUK31hUQijt0odJg5fPg3/gpdBa0HC+I3v4hphiuwqGhU5Jb6ni1YlM
        WFFfyplw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ktUhb-0008MJ-Kd; Sun, 27 Dec 2020 11:59:25 +0000
Date:   Sun, 27 Dec 2020 11:59:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org
Subject: Re: [PATCH v16 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20201227115911.GB5479@casper.infradead.org>
References: <20201225135119.3666763-1-almaz.alexandrovich@paragon-software.com>
 <20201225135119.3666763-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225135119.3666763-5-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 25, 2020 at 04:51:13PM +0300, Konstantin Komarov wrote:
> +static int ntfs_readdir(struct file *file, struct dir_context *ctx)
> +{
> +	const struct INDEX_ROOT *root;
> +	u64 vbo;
> +	size_t bit;
> +	loff_t eod;
> +	int err = 0;
> +	struct inode *dir = file_inode(file);
> +	struct ntfs_inode *ni = ntfs_i(dir);
> +	struct super_block *sb = dir->i_sb;
> +	struct ntfs_sb_info *sbi = sb->s_fs_info;
> +	loff_t i_size = dir->i_size;

I appreciate directories are never likely to exceed 4GB, but why not
use i_size_read() here?

> +	u32 pos = ctx->pos;
> +	u8 *name = NULL;
> +	struct indx_node *node = NULL;
> +	u8 index_bits = ni->dir.index_bits;
> +
> +	/* name is a buffer of PATH_MAX length */
> +	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);
> +
> +	if (ni->dir.changed) {
> +		ni->dir.changed = false;
> +		pos = 0;
> +	}

I don't think that 'changed' as implemented is all that useful.  If you
have one reader and one-or-more writers, the reader will go back to the
start, but if you have two readers and one-or-more writers, only one
reader will see the 'changed' flag before the other one resets it.

You need to use a sequence counter or something if you want this to be
proof against multiple readers, and honestly I don't think it's worth it.
POSIX says:
: If a file is removed from or added to the directory after the most
: recent call to opendir() or rewinddir(), whether a subsequent call to
: readdir() returns an entry for that file is unspecified.

> +	eod = i_size + sbi->record_size;
> +
> +	if (pos >= eod)
> +		return 0;
> +
> +	if (!dir_emit_dots(file, ctx))
> +		return 0;
> +
> +	/* allocate PATH_MAX bytes */
> +	name = __getname();
> +	if (!name)
> +		return -ENOMEM;
> +
> +	ni_lock(ni);

What is ni_lock() protecting against here?  You're being called under the
protection of dir->i_rwsem, which excludes simultaneous calls to create,
link, mknod, symlink, mkdir, unlink, rmdir and rename.

> +const struct file_operations ntfs_dir_operations = {
> +	.llseek = generic_file_llseek,
> +	.read = generic_read_dir,
> +	.iterate = ntfs_readdir,

This should probably be iterate_shared so multiple calls to readdir can
be in progress at once (see Documentation/filesystems/porting)

