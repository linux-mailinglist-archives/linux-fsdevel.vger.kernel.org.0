Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6CD63F50E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 17:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiLAQRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 11:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232225AbiLAQRZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:17:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFE6BB7D7;
        Thu,  1 Dec 2022 08:17:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB017B81F8A;
        Thu,  1 Dec 2022 16:17:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63631C433C1;
        Thu,  1 Dec 2022 16:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669911435;
        bh=xEUa0q1V/GeuhlVvbRVjNYe9PdAEmhY+C71nTUjdMVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vNU6OPABKKc+65PXc3d8NgpN3RZX0rAXLRxEytiZIHpxUsPNvmuoT6sAmN2B/Afkj
         qFzvPQQsag2/oGaStn/+BPaDQvIshVzRzmYOzrbPHCXBdnZ1TkkzPetuNQbvTNd1vB
         H7w3P6xXbwE3tEgxOUk5L902I14ChkDxX4hrzo+24bc53Efn3MWkGsw/pdrKYJ1W81
         2nIYcilIGAJFzlZNNISEFXmD3NwmLAF7H8N8S4MlcCalqRkRBIbhy/8SDie73xrbEz
         hALH6HKvcb7vFOC6XOESVJDj7gw05C1Emr6vPP8kBt3pmizLcFHXnjz9myigd42+I3
         ICjVH5KGaPh9Q==
Date:   Thu, 1 Dec 2022 08:17:14 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, dan.j.williams@intel.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 2/8] fsdax: invalidate pages when CoW
Message-ID: <Y4jTii+tENz3IeXy@magnolia>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
 <1669908538-55-3-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669908538-55-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:28:52PM +0000, Shiyang Ruan wrote:
> CoW changes the share state of a dax page, but the share count of the
> page isn't updated.  The next time access this page, it should have been
> a newly accessed, but old association exists.  So, we need to clear the
> share state when CoW happens, in both dax_iomap_rw() and
> dax_zero_iter().
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

Looks ok,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/dax.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/dax.c b/fs/dax.c
> index 85b81963ea31..482dda85ccaf 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
> @@ -1264,6 +1264,15 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
>  	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
>  		return length;
>  
> +	/*
> +	 * invalidate the pages whose sharing state is to be changed
> +	 * because of CoW.
> +	 */
> +	if (iomap->flags & IOMAP_F_SHARED)
> +		invalidate_inode_pages2_range(iter->inode->i_mapping,
> +					      pos >> PAGE_SHIFT,
> +					      (pos + length - 1) >> PAGE_SHIFT);
> +
>  	do {
>  		unsigned offset = offset_in_page(pos);
>  		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
> @@ -1324,12 +1333,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  		struct iov_iter *iter)
>  {
>  	const struct iomap *iomap = &iomi->iomap;
> -	const struct iomap *srcmap = &iomi->srcmap;
> +	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
>  	loff_t length = iomap_length(iomi);
>  	loff_t pos = iomi->pos;
>  	struct dax_device *dax_dev = iomap->dax_dev;
>  	loff_t end = pos + length, done = 0;
>  	bool write = iov_iter_rw(iter) == WRITE;
> +	bool cow = write && iomap->flags & IOMAP_F_SHARED;
>  	ssize_t ret = 0;
>  	size_t xfer;
>  	int id;
> @@ -1356,7 +1366,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  	 * into page tables. We have to tear down these mappings so that data
>  	 * written by write(2) is visible in mmap.
>  	 */
> -	if (iomap->flags & IOMAP_F_NEW) {
> +	if (iomap->flags & IOMAP_F_NEW || cow) {
>  		invalidate_inode_pages2_range(iomi->inode->i_mapping,
>  					      pos >> PAGE_SHIFT,
>  					      (end - 1) >> PAGE_SHIFT);
> @@ -1390,8 +1400,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
>  			break;
>  		}
>  
> -		if (write &&
> -		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
> +		if (cow) {
>  			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
>  						 kaddr);
>  			if (ret)
> -- 
> 2.38.1
> 
