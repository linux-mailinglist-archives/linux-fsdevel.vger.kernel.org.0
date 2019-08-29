Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2C5A159D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfH2KQC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 06:16:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfH2KQB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 06:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+tvFhqmaMhEec6GVANstlSqfji2crmXW2QTn7NNJoKM=; b=A8ByRWni1NBWV0UmmUIN/6rpi
        X3+y753F9ZqsThDJt7o7aQDx8POSMk6vACgG+5/80a1/+RSMhyYSRrmPLRpcTkxdB4r9jhP39z00m
        SNB0dmwp7a4mnINr37mvl1dEDK1Kpg50ghRaa+oGg1UZDZiYC/NOIUUu0XDWQCgHzf/0eIckqUF/1
        9a6jhptLbC3I1vcXNZkpwv9AOY3c3Cp/r9EJxRPf72G+6RzZ1mF7BuKGpEZuA321ML2zD8nGEkrax
        VLgAfbmTT85kCCq9Gz0D6elE0GxuabOBX7ZlxpsnO0v9ywXu50/taO3Jf5w3NjCzs7tXNKdGet3j8
        t6Mc6EgUA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i3HSz-0004ua-L6; Thu, 29 Aug 2019 10:15:45 +0000
Date:   Thu, 29 Aug 2019 03:15:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v6 03/24] erofs: add super block operations
Message-ID: <20190829101545.GC20598@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-4-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802125347.166018-4-gaoxiang25@huawei.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 02, 2019 at 08:53:26PM +0800, Gao Xiang wrote:
> +static int __init erofs_init_inode_cache(void)
> +{
> +	erofs_inode_cachep = kmem_cache_create("erofs_inode",
> +					       sizeof(struct erofs_vnode), 0,
> +					       SLAB_RECLAIM_ACCOUNT,
> +					       init_once);
> +
> +	return erofs_inode_cachep ? 0 : -ENOMEM;

Please just use normal if/else.  Also having this function seems
entirely pointless.

> +static void erofs_exit_inode_cache(void)
> +{
> +	kmem_cache_destroy(erofs_inode_cachep);
> +}

Same for this one.

> +static void free_inode(struct inode *inode)

Please use an erofs_ prefix for all your functions.

> +{
> +	struct erofs_vnode *vi = EROFS_V(inode);

Why is this called vnode instead of inode?  That seems like a rather
odd naming for a Linux file system.

> +
> +	/* be careful RCU symlink path (see ext4_inode_info->i_data)! */
> +	if (is_inode_fast_symlink(inode))
> +		kfree(inode->i_link);

is_inode_fast_symlink only shows up in a later patch.  And really
obsfucates the check here in the only caller as you can just do an
unconditional kfree here - i_link will be NULL except for the case
where you explicitly set it.

Also this code is nothing like ext4, so the code seems a little confusing.

> +static bool check_layout_compatibility(struct super_block *sb,
> +				       struct erofs_super_block *layout)
> +{
> +	const unsigned int requirements = le32_to_cpu(layout->requirements);

Why is the variable name for the on-disk subperblock layout?  We usually
still calls this something with sb in the name, e.g. dsb. for disk
super block.

> +	EROFS_SB(sb)->requirements = requirements;
> +
> +	/* check if current kernel meets all mandatory requirements */
> +	if (requirements & (~EROFS_ALL_REQUIREMENTS)) {
> +		errln("unidentified requirements %x, please upgrade kernel version",
> +		      requirements & ~EROFS_ALL_REQUIREMENTS);
> +		return false;
> +	}
> +	return true;

Note that normally we call this features, but that doesn't really
matter too much.

> +static int superblock_read(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi;
> +	struct buffer_head *bh;
> +	struct erofs_super_block *layout;
> +	unsigned int blkszbits;
> +	int ret;
> +
> +	bh = sb_bread(sb, 0);

Is there any good reasons to use buffer heads like this in new code
vs directly using bios?

> +
> +	sbi->blocks = le32_to_cpu(layout->blocks);
> +	sbi->meta_blkaddr = le32_to_cpu(layout->meta_blkaddr);
> +	sbi->islotbits = ffs(sizeof(struct erofs_inode_v1)) - 1;
> +	sbi->root_nid = le16_to_cpu(layout->root_nid);
> +	sbi->inos = le64_to_cpu(layout->inos);
> +
> +	sbi->build_time = le64_to_cpu(layout->build_time);
> +	sbi->build_time_nsec = le32_to_cpu(layout->build_time_nsec);
> +
> +	memcpy(&sb->s_uuid, layout->uuid, sizeof(layout->uuid));
> +	memcpy(sbi->volume_name, layout->volume_name,
> +	       sizeof(layout->volume_name));

s_uuid should preferably be a uuid_t (assuming it is a real BE uuid,
if it is le it should be a guid_t).

> +/* set up default EROFS parameters */
> +static void default_options(struct erofs_sb_info *sbi)
> +{
> +}

No need to add an empty function.

> +static int erofs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct inode *inode;
> +	struct erofs_sb_info *sbi;
> +	int err;
> +
> +	infoln("fill_super, device -> %s", sb->s_id);
> +	infoln("options -> %s", (char *)data);

That is some very verbose debug info.  We usually don't add that and
let people trace the function instead.  Also you should probably
implement the new mount API.
new mount API.

> +static void erofs_kill_sb(struct super_block *sb)
> +{
> +	struct erofs_sb_info *sbi;
> +
> +	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
> +	infoln("unmounting for %s", sb->s_id);
> +
> +	kill_block_super(sb);
> +
> +	sbi = EROFS_SB(sb);
> +	if (!sbi)
> +		return;
> +	kfree(sbi);
> +	sb->s_fs_info = NULL;
> +}

Why is this needed?  You can just free your sb privatte information in
->put_super and wire up kill_block_super as the ->kill_sb method
directly.
