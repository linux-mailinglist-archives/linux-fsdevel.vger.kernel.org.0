Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE9BA2AD7EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 14:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgKJNpx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 08:45:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:39936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729898AbgKJNpx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:45:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0F1AABCC;
        Tue, 10 Nov 2020 13:45:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 614DA1E130B; Tue, 10 Nov 2020 14:45:51 +0100 (CET)
Date:   Tue, 10 Nov 2020 14:45:51 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chengguang Xu <cgxu519@mykernel.net>
Cc:     miklos@szeredi.hu, jack@suse.cz, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 07/10] ovl: implement overlayfs' ->write_inode
 operation
Message-ID: <20201110134551.GA28132@quack2.suse.cz>
References: <20201108140307.1385745-1-cgxu519@mykernel.net>
 <20201108140307.1385745-8-cgxu519@mykernel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108140307.1385745-8-cgxu519@mykernel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 08-11-20 22:03:04, Chengguang Xu wrote:
> +static int ovl_write_inode(struct inode *inode,
> +			   struct writeback_control *wbc)
> +{
> +	struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> +	struct inode *upper = ovl_inode_upper(inode);
> +	unsigned long iflag = 0;
> +	int ret = 0;
> +
> +	if (!upper)
> +		return 0;
> +
> +	if (!ovl_should_sync(ofs))
> +		return 0;
> +
> +	if (upper->i_sb->s_op->write_inode)
> +		ret = upper->i_sb->s_op->write_inode(inode, wbc);
> +
> +	iflag |= upper->i_state & I_DIRTY_ALL;
> +
> +	if (mapping_writably_mapped(upper->i_mapping) ||
> +	    mapping_tagged(upper->i_mapping, PAGECACHE_TAG_WRITEBACK))
> +		iflag |= I_DIRTY_PAGES;
> +
> +	if (iflag)
> +		ovl_mark_inode_dirty(inode);

I think you didn't incorporate feedback we were speaking about in the last
version of the series. May comment in [1] still applies - you can miss
inodes dirtied through mmap when you decide to clean the inode here. So
IMHO you need something like:

	if (inode_is_open_for_write(inode))
		ovl_mark_inode_dirty(inode);

here to keep inode dirty while it is open for write (and not based on upper
inode state which is unreliable).

								Honza

[1] https://lore.kernel.org/linux-fsdevel/20201105140332.GG32718@quack2.suse.cz/

> +
> +	return ret;
> +}
> +
>  static void ovl_evict_inode(struct inode *inode)
>  {
>  	struct ovl_fs *ofs = inode->i_sb->s_fs_info;
> @@ -411,6 +440,7 @@ static const struct super_operations ovl_super_operations = {
>  	.destroy_inode	= ovl_destroy_inode,
>  	.drop_inode	= generic_delete_inode,
>  	.evict_inode	= ovl_evict_inode,
> +	.write_inode	= ovl_write_inode,
>  	.put_super	= ovl_put_super,
>  	.sync_fs	= ovl_sync_fs,
>  	.statfs		= ovl_statfs,
> -- 
> 2.26.2
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
