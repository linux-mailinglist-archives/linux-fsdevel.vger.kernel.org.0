Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAEB7BDD4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 11:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfGaJ7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 05:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfGaJ7F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 05:59:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C7150AE15;
        Wed, 31 Jul 2019 09:59:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4DD871E43D6; Wed, 31 Jul 2019 11:59:01 +0200 (CEST)
Date:   Wed, 31 Jul 2019 11:59:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Steve Magnani <steve.magnani@digidescorp.com>
Cc:     Jan Kara <jack@suse.com>, Steve Magnani <steve@digidescorp.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: prevent allocation beyond UDF partition
Message-ID: <20190731095901.GC15806@quack2.suse.cz>
References: <1564341552-129750-1-git-send-email-steve@digidescorp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564341552-129750-1-git-send-email-steve@digidescorp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun 28-07-19 14:19:12, Steve Magnani wrote:
> The UDF bitmap allocation code assumes that a recorded 
> Unallocated Space Bitmap is compliant with ECMA-167 4/13,
> which requires that pad bytes between the end of the bitmap 
> and the end of a logical block are all zero.
> 
> When a recorded bitmap does not comply with this requirement,
> for example one padded with FF to the block boundary instead
> of 00, the allocator may "allocate" blocks that are outside
> the UDF partition extent. This can result in UDF volume descriptors
> being overwritten by file data or by partition-level descriptors,
> and in extreme cases, even in scribbling on a subsequent disk partition.
> 
> Add a check that the block selected by the allocator actually
> resides within the UDF partition extent.
> 
> Signed-off-by: Steven J. Magnani <steve@digidescorp.com>

Thanks for the patch! Added to my tree. I've just slightly modified the
patch to also output error message about filesystem corruption.

								Honza

> 
> --- a/fs/udf/balloc.c	2019-07-26 11:35:28.249563705 -0500
> +++ b/fs/udf/balloc.c	2019-07-28 13:11:25.061431597 -0500
> @@ -325,6 +325,13 @@ got_block:
>  	newblock = bit + (block_group << (sb->s_blocksize_bits + 3)) -
>  		(sizeof(struct spaceBitmapDesc) << 3);
>  
> +	if (newblock >= sbi->s_partmaps[partition].s_partition_len) {
> +		/* Ran off the end of the bitmap,
> +		 * and bits following are non-compliant (not all zero)
> +		 */
> +		goto error_return;
> +	}
> +
>  	if (!udf_clear_bit(bit, bh->b_data)) {
>  		udf_debug("bit already cleared for block %d\n", bit);
>  		goto repeat;
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
