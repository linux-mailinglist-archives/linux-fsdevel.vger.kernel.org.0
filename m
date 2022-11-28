Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F0B63AEC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 18:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbiK1RXD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 12:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232960AbiK1RW5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:22:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A127E26AE6
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 09:22:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AEDF6127D
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 17:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82975C433C1;
        Mon, 28 Nov 2022 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669656174;
        bh=ZgTUc8hIYFgBYjOU34oPYCI4lQ5Uph0W1Xkt3AWrsqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYrlT3eYwHSYoo6jCmoubTiXArCDOtfM2OKDjvkoMQ2sGNU/HnQvAwKbGQmR++L+3
         rjSKA/f6N+wVJwN9H9YcZXBYvd/qAYI2QQS3C6aY8Rc4ZjxSOtSdWQdODuYyUQkPAy
         jGO2opyhhIVsgM7EiuY26pOcSZozzAXXvX1lsiZ+kYm2C6on1Hl1rBc4Tlgo3LEmW0
         2ywt2015r9uyPH3SWX8R68tMMHihRWRldaTMGM7rF/p8mqQQyjr2PRE09asW7hk3m1
         xMyEbCvdm3Rh+Gc/UCSbWiR7nDbGH3ztN14dyGZZSBsTc9los6x5Y2vUURBo8t+YIb
         6sh66dmvGW/EQ==
Date:   Mon, 28 Nov 2022 09:22:53 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Brian Foster <bfoster@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/remap_range: avoid spurious writeback on zero length
 request
Message-ID: <Y4TubQFwHExk07w4@magnolia>
References: <20221128160813.3950889-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128160813.3950889-1-bfoster@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:08:13AM -0500, Brian Foster wrote:
> generic_remap_checks() can reduce the effective request length (i.e.,
> after the reflink extend to EOF case is handled) down to zero. If this
> occurs, __generic_remap_file_range_prep() proceeds through dio
> serialization, file mapping flush calls, and may invoke file_modified()
> before returning back to the filesystem caller, all of which immediately
> check for len == 0 and return.
> 
> While this is mostly harmless, it is spurious and not completely
> without side effect. A filemap write call can submit I/O (but not
> wait on it) when the specified end byte precedes the start but
> happens to land on the same aligned page boundary, which can occur
> from __generic_remap_file_range_prep() when len is 0.
> 
> The dedupe path already has a len == 0 check to break out before doing
> range comparisons. Lift this check a bit earlier in the function to
> cover the general case of len == 0 and avoid the unnecessary work.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks correct,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

Should there be an(other) "if (!*len) return 0;" after the
generic_remap_check_len call to skip the mtime update if the remap
request gets shortened to avoid remapping an unaligned eofblock into the
middle of the destination file?

--D

> ---
>  fs/remap_range.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/remap_range.c b/fs/remap_range.c
> index 654912d06862..32ea992f9acc 100644
> --- a/fs/remap_range.c
> +++ b/fs/remap_range.c
> @@ -306,6 +306,8 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  			remap_flags);
>  	if (ret)
>  		return ret;
> +	if (*len == 0)
> +		return 0;
>  
>  	/* Wait for the completion of any pending IOs on both files */
>  	inode_dio_wait(inode_in);
> @@ -328,9 +330,6 @@ __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
>  	if (remap_flags & REMAP_FILE_DEDUP) {
>  		bool		is_same = false;
>  
> -		if (*len == 0)
> -			return 0;
> -
>  		if (!IS_DAX(inode_in))
>  			ret = vfs_dedupe_file_range_compare(file_in, pos_in,
>  					file_out, pos_out, *len, &is_same);
> -- 
> 2.37.3
> 
