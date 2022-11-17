Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0698662E3A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiKQSBT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 13:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239005AbiKQSBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:01:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B17ECB7;
        Thu, 17 Nov 2022 10:01:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDC12B82175;
        Thu, 17 Nov 2022 18:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74957C433D6;
        Thu, 17 Nov 2022 18:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668708073;
        bh=xwEp7EdExUNPKNnYIByDMVKSZYMdstukS+WksU0gnto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a+T/kHgt6b0DAl1UhCBxzNC7zy5863aYZrfLQd2kBw+j48Wtv5d2Jvt7/oKYITBqg
         sVYxgZNJiYTAwGuJ9nwSaUi+JvXvdG8Rshh9NSbILs/HAqDs2k0yD7jmFdMtWlxbRQ
         ZL+zG8g05ZmLD3C/+Lvc6QxE384wZfuQueFQMeFPt5D5/GrsAvyVUy0bPvmGSinnMJ
         ixUD7q72/m7tML1K07A+TPS+3M+gbwpSZTX3LmDEB+KzjEU1mWZ3kCQXza7TsVJe30
         7RzzRveWOhU6Td13ypcN8URJVI+Dk6fkB37WBSWl2VKqDnGTYEhTPi7hXqnaqavKQn
         eMjmJ+CXprxpg==
Date:   Thu, 17 Nov 2022 10:01:13 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 9/9] xfs: drop write error injection is unfixable, remove
 it
Message-ID: <Y3Z26ZYSEK+rf0q4@magnolia>
References: <20221117055810.498014-1-david@fromorbit.com>
 <20221117055810.498014-10-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117055810.498014-10-david@fromorbit.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 17, 2022 at 04:58:10PM +1100, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> With the changes to scan the page cache for dirty data to avoid data
> corruptions from partial write cleanup racing with other page cache
> operations, the drop writes error injection no longer works the same
> way it used to and causes xfs/196 to fail. This is because xfs/196
> writes to the file and populates the page cache before it turns on
> the error injection and starts failing -overwrites-.
> 
> The result is that the original drop-writes code failed writes only
> -after- overwriting the data in the cache, followed by invalidates
> the cached data, then punching out the delalloc extent from under
> that data.
> 
> On the surface, this looks fine. The problem is that page cache
> invalidation *doesn't guarantee that it removes anything from the
> page cache* and it doesn't change the dirty state of the folio. When
> block size == page size and we do page aligned IO (as xfs/196 does)
> everything happens to align perfectly and page cache invalidation
> removes the single page folios that span the written data. Hence the
> followup delalloc punch pass does not find cached data over that
> range and it can punch the extent out.
> 
> IOWs, xfs/196 "works" for block size == page size with the new
> code. I say "works", because it actually only works for the case
> where IO is page aligned, and no data was read from disk before
> writes occur. Because the moment we actually read data first, the
> readahead code allocates multipage folios and suddenly the
> invalidate code goes back to zeroing subfolio ranges without
> changing dirty state.
> 
> Hence, with multipage folios in play, block size == page size is
> functionally identical to block size < page size behaviour, and
> drop-writes is manifestly broken w.r.t to this case. Invalidation of
> a subfolio range doesn't result in the folio being removed from the
> cache, just the range gets zeroed. Hence after we've sequentially
> walked over a folio that we've dirtied (via write data) and then
> invalidated, we end up with a dirty folio full of zeroed data.
> 
> And because the new code skips punching ranges that have dirty
> folios covering them, we end up leaving the delalloc range intact
> after failing all the writes. Hence failed writes now end up
> writing zeroes to disk in the cases where invalidation zeroes folios
> rather than removing them from cache.
> 
> This is a fundamental change of behaviour that is needed to avoid
> the data corruption vectors that exist in the old write fail path,
> and it renders the drop-writes injection non-functional and
> unworkable as it stands.
> 
> As it is, I think the error injection is also now unnecessary, as
> partial writes that need delalloc extent are going to be a lot more
> common with stale iomap detection in place. Hence this patch removes
> the drop-writes error injection completely. xfs/196 can remain for
> testing kernels that don't have this data corruption fix, but those
> that do will report:
> 
> xfs/196 3s ... [not run] XFS error injection drop_writes unknown on this kernel.

Assuming you're planning to scuttle xfs/196 as well,

(I appreciate the cleanups in xfs_error.c too.)

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  fs/xfs/libxfs/xfs_errortag.h | 12 +++++-------
>  fs/xfs/xfs_error.c           | 27 ++++++++++++++++++++-------
>  fs/xfs/xfs_iomap.c           |  9 ---------
>  3 files changed, 25 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_errortag.h b/fs/xfs/libxfs/xfs_errortag.h
> index 5362908164b0..580ccbd5aadc 100644
> --- a/fs/xfs/libxfs/xfs_errortag.h
> +++ b/fs/xfs/libxfs/xfs_errortag.h
> @@ -40,13 +40,12 @@
>  #define XFS_ERRTAG_REFCOUNT_FINISH_ONE			25
>  #define XFS_ERRTAG_BMAP_FINISH_ONE			26
>  #define XFS_ERRTAG_AG_RESV_CRITICAL			27
> +
>  /*
> - * DEBUG mode instrumentation to test and/or trigger delayed allocation
> - * block killing in the event of failed writes. When enabled, all
> - * buffered writes are silenty dropped and handled as if they failed.
> - * All delalloc blocks in the range of the write (including pre-existing
> - * delalloc blocks!) are tossed as part of the write failure error
> - * handling sequence.
> + * Drop-writes support removed because write error handling cannot trash
> + * pre-existing delalloc extents in any useful way anymore. We retain the
> + * definition so that we can reject it as an invalid value in
> + * xfs_errortag_valid().
>   */
>  #define XFS_ERRTAG_DROP_WRITES				28
>  #define XFS_ERRTAG_LOG_BAD_CRC				29
> @@ -95,7 +94,6 @@
>  #define XFS_RANDOM_REFCOUNT_FINISH_ONE			1
>  #define XFS_RANDOM_BMAP_FINISH_ONE			1
>  #define XFS_RANDOM_AG_RESV_CRITICAL			4
> -#define XFS_RANDOM_DROP_WRITES				1
>  #define XFS_RANDOM_LOG_BAD_CRC				1
>  #define XFS_RANDOM_LOG_ITEM_PIN				1
>  #define XFS_RANDOM_BUF_LRU_REF				2
> diff --git a/fs/xfs/xfs_error.c b/fs/xfs/xfs_error.c
> index c6b2aabd6f18..dea3c0649d2f 100644
> --- a/fs/xfs/xfs_error.c
> +++ b/fs/xfs/xfs_error.c
> @@ -46,7 +46,7 @@ static unsigned int xfs_errortag_random_default[] = {
>  	XFS_RANDOM_REFCOUNT_FINISH_ONE,
>  	XFS_RANDOM_BMAP_FINISH_ONE,
>  	XFS_RANDOM_AG_RESV_CRITICAL,
> -	XFS_RANDOM_DROP_WRITES,
> +	0, /* XFS_RANDOM_DROP_WRITES has been removed */
>  	XFS_RANDOM_LOG_BAD_CRC,
>  	XFS_RANDOM_LOG_ITEM_PIN,
>  	XFS_RANDOM_BUF_LRU_REF,
> @@ -162,7 +162,6 @@ XFS_ERRORTAG_ATTR_RW(refcount_continue_update,	XFS_ERRTAG_REFCOUNT_CONTINUE_UPDA
>  XFS_ERRORTAG_ATTR_RW(refcount_finish_one,	XFS_ERRTAG_REFCOUNT_FINISH_ONE);
>  XFS_ERRORTAG_ATTR_RW(bmap_finish_one,	XFS_ERRTAG_BMAP_FINISH_ONE);
>  XFS_ERRORTAG_ATTR_RW(ag_resv_critical,	XFS_ERRTAG_AG_RESV_CRITICAL);
> -XFS_ERRORTAG_ATTR_RW(drop_writes,	XFS_ERRTAG_DROP_WRITES);
>  XFS_ERRORTAG_ATTR_RW(log_bad_crc,	XFS_ERRTAG_LOG_BAD_CRC);
>  XFS_ERRORTAG_ATTR_RW(log_item_pin,	XFS_ERRTAG_LOG_ITEM_PIN);
>  XFS_ERRORTAG_ATTR_RW(buf_lru_ref,	XFS_ERRTAG_BUF_LRU_REF);
> @@ -206,7 +205,6 @@ static struct attribute *xfs_errortag_attrs[] = {
>  	XFS_ERRORTAG_ATTR_LIST(refcount_finish_one),
>  	XFS_ERRORTAG_ATTR_LIST(bmap_finish_one),
>  	XFS_ERRORTAG_ATTR_LIST(ag_resv_critical),
> -	XFS_ERRORTAG_ATTR_LIST(drop_writes),
>  	XFS_ERRORTAG_ATTR_LIST(log_bad_crc),
>  	XFS_ERRORTAG_ATTR_LIST(log_item_pin),
>  	XFS_ERRORTAG_ATTR_LIST(buf_lru_ref),
> @@ -256,6 +254,19 @@ xfs_errortag_del(
>  	kmem_free(mp->m_errortag);
>  }
>  
> +static bool
> +xfs_errortag_valid(
> +	unsigned int		error_tag)
> +{
> +	if (error_tag >= XFS_ERRTAG_MAX)
> +		return false;
> +
> +	/* Error out removed injection types */
> +	if (error_tag == XFS_ERRTAG_DROP_WRITES)
> +		return false;
> +	return true;
> +}
> +
>  bool
>  xfs_errortag_test(
>  	struct xfs_mount	*mp,
> @@ -277,7 +288,9 @@ xfs_errortag_test(
>  	if (!mp->m_errortag)
>  		return false;
>  
> -	ASSERT(error_tag < XFS_ERRTAG_MAX);
> +	if (!xfs_errortag_valid(error_tag))
> +		return false;
> +
>  	randfactor = mp->m_errortag[error_tag];
>  	if (!randfactor || prandom_u32_max(randfactor))
>  		return false;
> @@ -293,7 +306,7 @@ xfs_errortag_get(
>  	struct xfs_mount	*mp,
>  	unsigned int		error_tag)
>  {
> -	if (error_tag >= XFS_ERRTAG_MAX)
> +	if (!xfs_errortag_valid(error_tag))
>  		return -EINVAL;
>  
>  	return mp->m_errortag[error_tag];
> @@ -305,7 +318,7 @@ xfs_errortag_set(
>  	unsigned int		error_tag,
>  	unsigned int		tag_value)
>  {
> -	if (error_tag >= XFS_ERRTAG_MAX)
> +	if (!xfs_errortag_valid(error_tag))
>  		return -EINVAL;
>  
>  	mp->m_errortag[error_tag] = tag_value;
> @@ -319,7 +332,7 @@ xfs_errortag_add(
>  {
>  	BUILD_BUG_ON(ARRAY_SIZE(xfs_errortag_random_default) != XFS_ERRTAG_MAX);
>  
> -	if (error_tag >= XFS_ERRTAG_MAX)
> +	if (!xfs_errortag_valid(error_tag))
>  		return -EINVAL;
>  
>  	return xfs_errortag_set(mp, error_tag,
> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
> index a9b3a1bcc3fd..d294a00ca28b 100644
> --- a/fs/xfs/xfs_iomap.c
> +++ b/fs/xfs/xfs_iomap.c
> @@ -1191,15 +1191,6 @@ xfs_buffered_write_iomap_end(
>  	struct xfs_mount	*mp = XFS_M(inode->i_sb);
>  	int			error;
>  
> -	/*
> -	 * Behave as if the write failed if drop writes is enabled. Set the NEW
> -	 * flag to force delalloc cleanup.
> -	 */
> -	if (XFS_TEST_ERROR(false, mp, XFS_ERRTAG_DROP_WRITES)) {
> -		iomap->flags |= IOMAP_F_NEW;
> -		written = 0;
> -	}
> -
>  	error = iomap_file_buffered_write_punch_delalloc(inode, iomap, offset,
>  			length, written, &xfs_buffered_write_delalloc_punch);
>  	if (error && !xfs_is_shutdown(mp)) {
> -- 
> 2.37.2
> 
