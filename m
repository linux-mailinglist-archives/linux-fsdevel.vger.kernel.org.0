Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608912ED080
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 14:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbhAGNSf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 08:18:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:51454 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbhAGNSf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:18:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA419AD12;
        Thu,  7 Jan 2021 13:17:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7BA261E0872; Thu,  7 Jan 2021 14:17:53 +0100 (CET)
Date:   Thu, 7 Jan 2021 14:17:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/13] fs: don't call ->dirty_inode for lazytime
 timestamp updates
Message-ID: <20210107131753.GD12990@quack2.suse.cz>
References: <20210105005452.92521-1-ebiggers@kernel.org>
 <20210105005452.92521-6-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-6-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 04-01-21 16:54:44, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> There is no need to call ->dirty_inode for lazytime timestamp updates
> (i.e. for __mark_inode_dirty(I_DIRTY_TIME)), since by the definition of
> lazytime, filesystems must ignore these updates.  Filesystems only need
> to care about the updated timestamps when they expire.
> 
> Therefore, only call ->dirty_inode when I_DIRTY_INODE is set.
> 
> Based on a patch from Christoph Hellwig:
> https://lore.kernel.org/r/20200325122825.1086872-4-hch@lst.de
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

...

> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 081e335cdee47..e3347fd6eb13a 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -2264,16 +2264,16 @@ void __mark_inode_dirty(struct inode *inode, int flags)
>  	 * Don't do this for I_DIRTY_PAGES - that doesn't actually
>  	 * dirty the inode itself
>  	 */
> -	if (flags & (I_DIRTY_INODE | I_DIRTY_TIME)) {
> +	if (flags & I_DIRTY_INODE) {
>  		trace_writeback_dirty_inode_start(inode, flags);
>  
>  		if (sb->s_op->dirty_inode)
>  			sb->s_op->dirty_inode(inode, flags);

OK, but shouldn't we pass just (flags & I_DIRTY_INODE) to ->dirty_inode().
Just to make it clear what the filesystem is supposed to consume in
'flags'...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
