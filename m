Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340533C67CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 03:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhGMBFR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 21:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhGMBFQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:05:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EC2A611CC;
        Tue, 13 Jul 2021 01:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626138147;
        bh=wmsUL1R2xXv/lc0kVW0n4SuQ1K4WRdLz0Vs5Mq0sQQY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7msqr9I4jFcGyIIVaVeeFiSdV1KAox118ZjCxQe4nvCayB4615onakJ7fWb8kiPe
         qFIm9jMVYNQT64+ZKSOez774UGtAozFQQEXZqUGWWPyrwWgcmP2GDGf0DQ94Vp5eaP
         59t8ZA7xm3usHNzAJBRwuST9unrJqNcRg+t2i77q5vNp7kMsSg++9Zp1F+KLYk91y2
         KeczINZZCSvp3INrsc6INpR0LSm/k5pAAISF2N4jx6aoDcee8WJHXESX2qMlEbtTSi
         7vS9s3efb3T1OPcbLvjQZMSCaZlgdDiSd/bAgMC/v938DAqkvuzHctHnl5/KnQRbR+
         BY6L9JH1OP4CA==
Date:   Mon, 12 Jul 2021 18:02:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 02/14] documentation: Sync file_operations members with
 reality
Message-ID: <20210713010227.GC23236@magnolia>
References: <20210712163901.29514-1-jack@suse.cz>
 <20210712165609.13215-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712165609.13215-2-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 06:55:53PM +0200, Jan Kara wrote:
> Sync listing of struct file_operations members with the real one in
> fs.h.
> 
> Acked-by: Darrick J. Wong <djwong@kernel.org>

Might as well upgrade this to:
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  Documentation/filesystems/locking.rst | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 2183fd8cc350..cdf15492c699 100644
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
> +	int (*fadvise)(struct file *, loff_t, loff_t, int);
>  
>  locking rules:
>  	All may block.
> -- 
> 2.26.2
> 
