Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BDE5EFF90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 00:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiI2V76 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 17:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiI2V74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 17:59:56 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CB83422D7;
        Thu, 29 Sep 2022 14:59:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-106-210.pa.nsw.optusnet.com.au [49.181.106.210])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 732491101ED8;
        Fri, 30 Sep 2022 07:59:53 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1oe1ZP-00DigR-7D; Fri, 30 Sep 2022 07:59:51 +1000
Date:   Fri, 30 Sep 2022 07:59:51 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] iomap: fix memory corruption when recording errors
 during writeback
Message-ID: <20220929215951.GG3600936@dread.disaster.area>
References: <YzXnoR0UMBVfoaOf@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzXnoR0UMBVfoaOf@magnolia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=63361559
        a=j6JUzzrSC7wlfFge/rmVbg==:117 a=j6JUzzrSC7wlfFge/rmVbg==:17
        a=kj9zAlcOel0A:10 a=xOM3xZuef0cA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8
        a=7-415B0cAAAA:8 a=JS6q_rC8M70TE2Jj7zYA:9 a=CjuIK1q_8ugA:10
        a=AjGcO6oz07-iQ99wixmX:22 a=biEYGPWJfzWAr4FL6Ov7:22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 11:44:49AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Every now and then I see this crash on arm64:
....
> This crash is a result of iomap_writepage_map encountering some sort of
> error during writeback and wanting to set that error code in the file
> mapping so that fsync will report it.  Unfortunately, the code
> dereferences folio->mapping after unlocking the folio, which means that
> another thread could have removed the page from the page cache
> (writeback doesn't hold the invalidation lock) and give it to somebody
> else.
> 
> At best we crash the system like above; at worst, we corrupt memory or
> set an error on some other unsuspecting file while failing to record the
> problems with *this* file.  Regardless, fix the problem by reporting the
> error to the inode mapping.
> 
> NOTE: Commit 598ecfbaa742 lifted the XFS writeback code to iomap, so
> this fix should be backported to XFS in the 4.6-5.4 kernels in addition
> to iomap in the 5.5-5.19 kernels.
> 
> Fixes: e735c0079465 ("iomap: Convert iomap_add_to_ioend() to take a folio")
> Probably-Fixes: 598ecfbaa742 ("iomap: lift the xfs writeback code to iomap")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  fs/iomap/buffered-io.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index ca5c62901541..77d59c159248 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -1421,7 +1421,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
>  	if (!count)
>  		folio_end_writeback(folio);
>  done:
> -	mapping_set_error(folio->mapping, error);
> +	mapping_set_error(inode->i_mapping, error);
>  	return error;

Looks good, though it might be worth putting a comment somewhere in
this code to indicate that it's not safe to trust the folio contents
after we've submitted the bio, unlocked it without setting
writeback, or ended writeback on an unlocked folio...

Regardless,

Reviewed-by: Dave Chinner <dchinner@redhat.com>

-- 
Dave Chinner
david@fromorbit.com
