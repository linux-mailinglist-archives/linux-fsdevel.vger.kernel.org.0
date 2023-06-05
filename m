Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21088723363
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 00:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjFEWz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 18:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjFEWz7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB55698;
        Mon,  5 Jun 2023 15:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6799B62B8A;
        Mon,  5 Jun 2023 22:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C471CC433D2;
        Mon,  5 Jun 2023 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686005756;
        bh=hDI44D9cmAmcalso/hpzbfzcVtffmysVEyLe2ERU+PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXAQR2M+f08mdVrqPaMVFi6xlYDvP8ROhOq0KZXU2zAtBDSPvXDaDv/hMrZkiJvgK
         avmKHPbeOC8a6tSZMNb0p9HNrXXeW2CPpRGREpIvEDaRu5JTM+R6XzLuYt8DIzBJZS
         DguSxBxah/if7uYjMlaO9N3FjP7qi472mS60e5ajS3cDIAT4VNZGL8srxWJQdoeCTF
         zqmCJqHxGZaf9hRb9eVVzfO0dGy0A6aE+meTnvPI6+B8JApmwACTAaNkVfidEebtZd
         Oy5Y4UtNxRmtfZOISoYo9C0G+UE500nFI8ohM/RxKuFgAG7mVysfJOSy2jtAcU1Wju
         PszMmiQmyxaKQ==
Date:   Mon, 5 Jun 2023 15:55:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [PATCHv7 4/6] iomap: Refactor iomap_write_delalloc_punch()
 function out
Message-ID: <20230605225556.GG1325469@frogsfrogsfrogs>
References: <cover.1685962158.git.ritesh.list@gmail.com>
 <27c39cdf2150f19d91b7118b7399177d6889a358.1685962158.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27c39cdf2150f19d91b7118b7399177d6889a358.1685962158.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 05, 2023 at 04:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> This patch moves iomap_write_delalloc_punch() out of
> iomap_write_delalloc_scan(). No functionality change in this patch.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Seems fine on its own...
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 54 ++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 136f57ccd0be..f55a339f99ec 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -894,6 +894,33 @@ iomap_file_buffered_write(struct kiocb *iocb, struct iov_iter *i,
>  }
>  EXPORT_SYMBOL_GPL(iomap_file_buffered_write);
>  
> +static int iomap_write_delalloc_punch(struct inode *inode, struct folio *folio,
> +		loff_t *punch_start_byte, loff_t start_byte, loff_t end_byte,
> +		int (*punch)(struct inode *inode, loff_t offset, loff_t length))
> +{
> +	int ret = 0;
> +
> +	if (!folio_test_dirty(folio))
> +		return ret;
> +
> +	/* if dirty, punch up to offset */
> +	if (start_byte > *punch_start_byte) {
> +		ret = punch(inode, *punch_start_byte,
> +				start_byte - *punch_start_byte);
> +		if (ret)
> +			goto out;
> +	}
> +	/*
> +	 * Make sure the next punch start is correctly bound to
> +	 * the end of this data range, not the end of the folio.
> +	 */
> +	*punch_start_byte = min_t(loff_t, end_byte,
> +				  folio_next_index(folio) << PAGE_SHIFT);
> +
> +out:
> +	return ret;
> +}
> +
>  /*
>   * Scan the data range passed to us for dirty page cache folios. If we find a
>   * dirty folio, punch out the preceeding range and update the offset from which
> @@ -917,6 +944,7 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  {
>  	while (start_byte < end_byte) {
>  		struct folio	*folio;
> +		int ret;
>  
>  		/* grab locked page */
>  		folio = filemap_lock_folio(inode->i_mapping,
> @@ -927,26 +955,12 @@ static int iomap_write_delalloc_scan(struct inode *inode,
>  			continue;
>  		}
>  
> -		/* if dirty, punch up to offset */
> -		if (folio_test_dirty(folio)) {
> -			if (start_byte > *punch_start_byte) {
> -				int	error;
> -
> -				error = punch(inode, *punch_start_byte,
> -						start_byte - *punch_start_byte);
> -				if (error) {
> -					folio_unlock(folio);
> -					folio_put(folio);
> -					return error;
> -				}
> -			}
> -
> -			/*
> -			 * Make sure the next punch start is correctly bound to
> -			 * the end of this data range, not the end of the folio.
> -			 */
> -			*punch_start_byte = min_t(loff_t, end_byte,
> -					folio_next_index(folio) << PAGE_SHIFT);
> +		ret = iomap_write_delalloc_punch(inode, folio, punch_start_byte,
> +						 start_byte, end_byte, punch);
> +		if (ret) {
> +			folio_unlock(folio);
> +			folio_put(folio);
> +			return ret;
>  		}
>  
>  		/* move offset to start of next folio in range */
> -- 
> 2.40.1
> 
