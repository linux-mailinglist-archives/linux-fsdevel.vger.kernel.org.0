Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1C9509E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbfFXLhm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 07:37:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:55440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727608AbfFXLhm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 07:37:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0EF03AE79;
        Mon, 24 Jun 2019 11:37:40 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DBCD31E2F23; Mon, 24 Jun 2019 13:37:37 +0200 (CEST)
Date:   Mon, 24 Jun 2019 13:37:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, clm@fb.com,
        adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, jk@ozlabs.org,
        reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/7] vfs: flush and wait for io when setting the
 immutable flag via SETFLAGS
Message-ID: <20190624113737.GG32376@quack2.suse.cz>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
 <156116142734.1664939.5074567130774423066.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <156116142734.1664939.5074567130774423066.stgit@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 21-06-19 16:57:07, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> When we're using FS_IOC_SETFLAGS to set the immutable flag on a file, we
> need to ensure that userspace can't continue to write the file after the
> file becomes immutable.  To make that happen, we have to flush all the
> dirty pagecache pages to disk to ensure that we can fail a page fault on
> a mmap'd region, wait for pending directio to complete, and hope the
> caller locked out any new writes by holding the inode lock.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Seeing the way this worked out, is there a reason to have separate
vfs_ioc_setflags_flush_data() instead of folding the functionality in
vfs_ioc_setflags_check() (possibly renaming it to
vfs_ioc_setflags_prepare() to indicate it does already some changes)? I
don't see any place that would need these two separated...

> +/*
> + * Flush all pending IO and dirty mappings before setting S_IMMUTABLE on an
> + * inode via FS_IOC_SETFLAGS.  If the flush fails we'll clear the flag before
> + * returning error.
> + *
> + * Note: the caller should be holding i_mutex, or else be sure that
> + * they have exclusive access to the inode structure.
> + */
> +static inline int vfs_ioc_setflags_flush_data(struct inode *inode, int flags)
> +{
> +	int ret;
> +
> +	if (!vfs_ioc_setflags_need_flush(inode, flags))
> +		return 0;
> +
> +	inode_set_flags(inode, S_IMMUTABLE, S_IMMUTABLE);
> +	ret = inode_flush_data(inode);
> +	if (ret)
> +		inode_set_flags(inode, 0, S_IMMUTABLE);
> +	return ret;
> +}

Also this sets S_IMMUTABLE whenever vfs_ioc_setflags_need_flush() returns
true. That is currently the right thing but seems like a landmine waiting
to trip? So I'd just drop the vfs_ioc_setflags_need_flush() abstraction to
make it clear what's going on.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
