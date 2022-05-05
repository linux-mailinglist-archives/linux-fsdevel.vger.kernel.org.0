Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C79951CABA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 22:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385924AbiEEUmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 16:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235604AbiEEUmJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 16:42:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479D65FF26;
        Thu,  5 May 2022 13:38:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F287B82DF0;
        Thu,  5 May 2022 20:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51F5C385AA;
        Thu,  5 May 2022 20:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651783105;
        bh=Ftdlx/J6+2yersYEpJzNemic5uh9nbtLakcJSrvrbT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GwxkfnzCoLKjBawUzecA15DpeVbn2x9VDqK96b5P0hcmcgUpOgVUYVmVQjRutu9Zl
         us0/wcoAZJ5jcJLBvtqNDbS7TV1O3zJMXQBoDbXGYYsv/vJ/XtueMjBRk+89WCpdzl
         DWpx+chRpZeBbmSnwujNi6cAi0uJtGUSzUQDgYwH/PmhU/bOmLgnsLPVFOqTWmF27x
         H4SNaInIwWBcGC2ko/sR/0kEzMO5J+Bm4IXUF2VIy5SLuhYD0hij63PPVjJAAYRPYA
         NQ2bQ6IqiDyTuASejhUrw4/ZOS4VL+4PD7Nl7sMKdP7sB//KSsYklLw3vQhKyKFvx5
         CGHteeoowPZpw==
Date:   Thu, 5 May 2022 13:38:25 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/7] iomap: allow the file system to provide a bio_set
 for direct I/O
Message-ID: <20220505203825.GM27195@magnolia>
References: <20220505201115.937837-1-hch@lst.de>
 <20220505201115.937837-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505201115.937837-3-hch@lst.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 03:11:10PM -0500, Christoph Hellwig wrote:
> Allow the file system to provide a specific bio_set for allocating
> direct I/O bios.  This will allow file systems that use the
> ->submit_io hook to stash away additional information for file system
> use.
> 
> To make use of this additional space for information in the completion
> path, the file system needs to override the ->bi_end_io callback and
> then call back into iomap, so export iomap_dio_bio_end_io for that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

LGTM,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/direct-io.c  | 18 ++++++++++++++----
>  include/linux/iomap.h | 11 +++++++++++
>  2 files changed, 25 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> index b08f5dc31780d..15929690d89e3 100644
> --- a/fs/iomap/direct-io.c
> +++ b/fs/iomap/direct-io.c
> @@ -51,6 +51,15 @@ struct iomap_dio {
>  	};
>  };
>  
> +static struct bio *iomap_dio_alloc_bio(const struct iomap_iter *iter,
> +		struct iomap_dio *dio, unsigned short nr_vecs, unsigned int opf)
> +{
> +	if (dio->dops && dio->dops->bio_set)
> +		return bio_alloc_bioset(iter->iomap.bdev, nr_vecs, opf,
> +					GFP_KERNEL, dio->dops->bio_set);
> +	return bio_alloc(iter->iomap.bdev, nr_vecs, opf, GFP_KERNEL);
> +}
> +
>  static void iomap_dio_submit_bio(const struct iomap_iter *iter,
>  		struct iomap_dio *dio, struct bio *bio, loff_t pos)
>  {
> @@ -144,7 +153,7 @@ static inline void iomap_dio_set_error(struct iomap_dio *dio, int ret)
>  	cmpxchg(&dio->error, 0, ret);
>  }
>  
> -static void iomap_dio_bio_end_io(struct bio *bio)
> +void iomap_dio_bio_end_io(struct bio *bio)
>  {
>  	struct iomap_dio *dio = bio->bi_private;
>  	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> @@ -176,16 +185,17 @@ static void iomap_dio_bio_end_io(struct bio *bio)
>  		bio_put(bio);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(iomap_dio_bio_end_io);
>  
>  static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
>  		loff_t pos, unsigned len)
>  {
>  	struct inode *inode = file_inode(dio->iocb->ki_filp);
>  	struct page *page = ZERO_PAGE(0);
> -	int flags = REQ_SYNC | REQ_IDLE;
>  	struct bio *bio;
>  
> -	bio = bio_alloc(iter->iomap.bdev, 1, REQ_OP_WRITE | flags, GFP_KERNEL);
> +	bio = iomap_dio_alloc_bio(iter, dio, 1,
> +			REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
>  	fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  				  GFP_KERNEL);
>  	bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
> @@ -311,7 +321,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>  			goto out;
>  		}
>  
> -		bio = bio_alloc(iomap->bdev, nr_pages, bio_opf, GFP_KERNEL);
> +		bio = iomap_dio_alloc_bio(iter, dio, nr_pages, bio_opf);
>  		fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
>  					  GFP_KERNEL);
>  		bio->bi_iter.bi_sector = iomap_sector(iomap, pos);
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index b76f0dd149fb4..526c9e7f2eaf8 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -320,6 +320,16 @@ struct iomap_dio_ops {
>  		      unsigned flags);
>  	void (*submit_io)(const struct iomap_iter *iter, struct bio *bio,
>  		          loff_t file_offset);
> +
> +	/*
> +	 * Filesystems wishing to attach private information to a directio bio
> +	 * must provide a ->submit_io method that attaches the additional
> +	 * information to the bio and changes the ->bi_end_io callback to a
> +	 * custom function.  This function should, at a minimum, perform any
> +	 * relevant post-processing of the bio and end with a call to
> +	 * iomap_dio_bio_end_io.
> +	 */
> +	struct bio_set *bio_set;
>  };
>  
>  /*
> @@ -349,6 +359,7 @@ struct iomap_dio *__iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>  		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
>  		unsigned int dio_flags, size_t done_before);
>  ssize_t iomap_dio_complete(struct iomap_dio *dio);
> +void iomap_dio_bio_end_io(struct bio *bio);
>  
>  #ifdef CONFIG_SWAP
>  struct file;
> -- 
> 2.30.2
> 
