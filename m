Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386F270D1AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjEWCsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 22:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbjEWCsW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 22:48:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE86CA;
        Mon, 22 May 2023 19:48:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06CC062E36;
        Tue, 23 May 2023 02:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06332C4339B;
        Tue, 23 May 2023 02:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810100;
        bh=w3PG+wvDxKl0ccqPHuJb+taZwlEJrTezcF9g2TqXZ1g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C08IctqNP5/PmceTbld2x6Z+tyTSwkltOrcprZv2cE3Uo496FntDjRuVS7M+Gpm2K
         U3cEe5vUgZ/7eUJhqG72NHK9lzGdtlP0BhZEzo4aOLxqWQOy2sSMMZWxhCG6Gfxmc7
         RNc/9BRwtQMCgX2cvdE35U5dVrPXYWf22vm8KWmEnZP0Luge4ya7MjlSfuu9rbNnBa
         8Ifj2kGXSoBEIod8Jpy7qPbz0/Bik3NHxxM106v7S+Yv14USfaHgu95Xz3kAOgUDNW
         5e1OnDfiRNQrkotrhbtQj/7CWQ6wR24GZzTJgeS7gVP4kaz5vmXOJGP0a5bMhH9ALV
         Neh/UjY9p1DXg==
Message-ID: <12153db1-20af-040b-ded0-31286b5bafca@kernel.org>
Date:   Tue, 23 May 2023 11:48:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 25/31] zonefs: Provide a splice-read wrapper
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
References: <20230522135018.2742245-1-dhowells@redhat.com>
 <20230522135018.2742245-26-dhowells@redhat.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230522135018.2742245-26-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/22/23 22:50, David Howells wrote:
> Provide a splice_read wrapper for zonefs.  This does some checks before
> proceeding and locks the inode across the call to filemap_splice_read() and
> a size check in case of truncation.  Splicing from direct I/O is handled by
> the caller.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Al Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Darrick J. Wong <djwong@kernel.org>
> cc: linux-xfs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-block@vger.kernel.org
> cc: linux-mm@kvack.org

One comment below but otherwise looks OK.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  fs/zonefs/file.c | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
> index 132f01d3461f..65d4c4fe6364 100644
> --- a/fs/zonefs/file.c
> +++ b/fs/zonefs/file.c
> @@ -752,6 +752,44 @@ static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
>  	return ret;
>  }
>  
> +static ssize_t zonefs_file_splice_read(struct file *in, loff_t *ppos,
> +				       struct pipe_inode_info *pipe,
> +				       size_t len, unsigned int flags)
> +{
> +	struct inode *inode = file_inode(in);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	struct zonefs_zone *z = zonefs_inode_zone(inode);
> +	loff_t isize;
> +	ssize_t ret = 0;
> +
> +	/* Offline zones cannot be read */
> +	if (unlikely(IS_IMMUTABLE(inode) && !(inode->i_mode & 0777)))
> +		return -EPERM;
> +
> +	if (*ppos >= z->z_capacity)
> +		return 0;
> +
> +	inode_lock_shared(inode);
> +
> +	/* Limit read operations to written data */
> +	mutex_lock(&zi->i_truncate_mutex);
> +	isize = i_size_read(inode);
> +	if (*ppos >= isize)
> +		len = 0;
> +	else
> +		len = min_t(loff_t, len, isize - *ppos);
> +	mutex_unlock(&zi->i_truncate_mutex);
> +
> +	if (len > 0) {
> +		ret = filemap_splice_read(in, ppos, pipe, len, flags);
> +		if (ret == -EIO)

Is -EIO the only error that filemap_splice_read() may return ? There are other
IO error codes that we could get from the block layer, e.g. -ETIMEDOUT etc. So
"if (ret < 0)" may be better here ?

> +			zonefs_io_error(inode, false);
> +	}
> +
> +	inode_unlock_shared(inode);
> +	return ret;
> +}
> +
>  /*
>   * Write open accounting is done only for sequential files.
>   */
> @@ -896,7 +934,7 @@ const struct file_operations zonefs_file_operations = {
>  	.llseek		= zonefs_file_llseek,
>  	.read_iter	= zonefs_file_read_iter,
>  	.write_iter	= zonefs_file_write_iter,
> -	.splice_read	= generic_file_splice_read,
> +	.splice_read	= zonefs_file_splice_read,
>  	.splice_write	= iter_file_splice_write,
>  	.iopoll		= iocb_bio_iopoll,
>  };
> 

-- 
Damien Le Moal
Western Digital Research

