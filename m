Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9BA390A9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 22:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhEYUoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 16:44:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231182AbhEYUoo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 16:44:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A400061409;
        Tue, 25 May 2021 20:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621975393;
        bh=D9/lkDf7/4G2MsG+84gaDXO7v7xhTSSqmHMTWi1xl5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gWt3V53WTHyJPdEqHJaiSjzFKDoxv0siITj6vkwlqJXoCFCv3a3exQZokq6Tonv30
         gMlbZf5iUa/Tplf7dwGeETBsjwgLMAEfIxdlTKGU+qc54RBD6xX/YQQvQ5ekFgP4qd
         2+r05F69dPROmTIFIVRPzEBOiSjcvk4cl99FWfRWeS/2hUrt1iSElUvXsOhXbbeYrI
         3Jy9OORfYg3TKBLlS3Bi54A4zCiGK6t5PZVWbNrjze/xPOo+5rBtv4rgxsNNeh02E1
         Whjvii7J/mMCnawZPlrhtapQheVSwKVYf3ytpEB2b4316qWTYa5vsbWoW7/muPlCfX
         GhrzuzD+2ASMw==
Date:   Tue, 25 May 2021 13:43:13 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 02/13] documentation: Sync file_operations members with
 reality
Message-ID: <20210525204313.GL202121@locust>
References: <20210525125652.20457-1-jack@suse.cz>
 <20210525135100.11221-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525135100.11221-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 03:50:39PM +0200, Jan Kara wrote:
> Sync listing of struct file_operations members with the real one in
> fs.h.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 1e894480115b..4ed2b22bd0a8 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -506,6 +506,7 @@ prototypes::
>  	ssize_t (*write) (struct file *, const char __user *, size_t, loff_t *);
>  	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
>  	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
> +	int (*iopoll) (struct kiocb *kiocb, bool spin);
>  	int (*iterate) (struct file *, struct dir_context *);
>  	int (*iterate_shared) (struct file *, struct dir_context *);
>  	__poll_t (*poll) (struct file *, struct poll_table_struct *);
> @@ -518,12 +519,6 @@ prototypes::
>  	int (*fsync) (struct file *, loff_t start, loff_t end, int datasync);
>  	int (*fasync) (int, struct file *, int);
>  	int (*lock) (struct file *, int, struct file_lock *);
> -	ssize_t (*readv) (struct file *, const struct iovec *, unsigned long,
> -			loff_t *);
> -	ssize_t (*writev) (struct file *, const struct iovec *, unsigned long,
> -			loff_t *);
> -	ssize_t (*sendfile) (struct file *, loff_t *, size_t, read_actor_t,
> -			void __user *);
>  	ssize_t (*sendpage) (struct file *, struct page *, int, size_t,
>  			loff_t *, int);
>  	unsigned long (*get_unmapped_area)(struct file *, unsigned long,
> @@ -536,6 +531,14 @@ prototypes::
>  			size_t, unsigned int);
>  	int (*setlease)(struct file *, long, struct file_lock **, void **);
>  	long (*fallocate)(struct file *, int, loff_t, loff_t);
> +	void (*show_fdinfo)(struct seq_file *m, struct file *f);
> +	unsigned (*mmap_capabilities)(struct file *);
> +	ssize_t (*copy_file_range)(struct file *, loff_t, struct file *,
> +			loff_t, size_t, unsigned int);
> +	loff_t (*remap_file_range)(struct file *file_in, loff_t pos_in,
> +			struct file *file_out, loff_t pos_out,
> +			loff_t len, unsigned int remap_flags);

Acked-by: Darrick J. Wong <djwong@kernel.org>

The remap_file_range part looks correct to me.  At a glance the others
seem fine too, but I'm not as familiar with them...

--D

> +	int (*fadvise)(struct file *, loff_t, loff_t, int);
>  
>  locking rules:
>  	All may block.
> -- 
> 2.26.2
> 
