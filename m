Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BECE2E8F65
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 03:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbhADCUF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jan 2021 21:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727740AbhADCUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jan 2021 21:20:05 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D6C061793;
        Sun,  3 Jan 2021 18:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QqpupMZVVb2ckS4eUo7CRnOkNp8jzFCdbETfMfg6E94=; b=JCbgQbeTC6kNU+StFdzzSvAEI+
        1TsMn3GaPtp0EINKulyUo3KufXLVJnaA02gNlJY9DrA0pziDzBlysKbI9WWAt6A2MsGqyXLgAkm0p
        nbI6NJBh4cu8U94JlNLA0XDHy9VsKXO0Q0+0JgxkmxC/sTi3FnZ1ryzTpEdBW+RuHTXZcMCJX64G5
        fw9y5IdJ4GV/2F/1ncNW0iRApc53EzIp+q4YR30z7aqlCCjqywI5b7Q4NzxkEwfpS1lfNtXjLccDs
        hlHDVI3BOSm5qaYTbGGmHkuu9169GlKWjb1V8/P6Gz2bGZm/lp/ovL+tEIJR+D1TUlF6HiuG9ELEl
        rlFs9r6w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kwFSE-000bDU-8v; Mon, 04 Jan 2021 02:19:05 +0000
Date:   Mon, 4 Jan 2021 02:18:42 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, pali@kernel.org, dsterba@suse.cz,
        aaptel@suse.com, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com
Subject: Re: [PATCH v17 04/10] fs/ntfs3: Add file operations and
 implementation
Message-ID: <20210104021842.GB28414@casper.infradead.org>
References: <20201231152401.3162425-1-almaz.alexandrovich@paragon-software.com>
 <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231152401.3162425-5-almaz.alexandrovich@paragon-software.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:55PM +0300, Konstantin Komarov wrote:
> +/*
> + * file_operations::iterate_shared
> + *
> + * Use non sorted enumeration.
> + * We have an example of broken volume where sorted enumeration
> + * counts each name twice
> + */
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
> +	loff_t i_size = i_size_read(dir);
> +	u32 pos = ctx->pos;
> +	u8 *name = NULL;
> +	struct indx_node *node = NULL;
> +	u8 index_bits = ni->dir.index_bits;
> +
> +	/* name is a buffer of PATH_MAX length */
> +	static_assert(NTFS_NAME_LEN * 4 < PATH_MAX);
> +
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

What is this lock protecting?

