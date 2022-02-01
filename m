Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523874A5B50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 12:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237337AbiBALia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 06:38:30 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:56788 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiBALi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 06:38:29 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62B42218B1;
        Tue,  1 Feb 2022 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643715508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnRfG+zgacPMg+NpWbcj01l5JvWAf98K2Qfxr1G1Ag0=;
        b=AzzcbJxTzyXoJtU2VM7iMuYvYuGrmC4w8qw5/OBgrxU5FIG+jc400sosqmFEAZlCZDjd0X
        B3q+Gk1VBjV/q76RewWyeWCOTIxnqe4lIR4BFoyfHUGVYEs649oUr8V3//qDTzCkSW9ugD
        2PQoMOJCdzVFuCmqvqN6Ai5z5+TIplM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643715508;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RnRfG+zgacPMg+NpWbcj01l5JvWAf98K2Qfxr1G1Ag0=;
        b=wSUApJLysWgRUpLI/ndhyH+EXkixu10pEf4OuR7+uT278n3mLx7nCo8kejiBnLxNkdAHnG
        nj+VE0b+ms3j3wDA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51ECCA3B8B;
        Tue,  1 Feb 2022 11:38:28 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0BD03A05B1; Tue,  1 Feb 2022 12:38:28 +0100 (CET)
Date:   Tue, 1 Feb 2022 12:38:28 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [RFC 4/6] ext4: No need to test for block bitmap bits in
 ext4_mb_mark_bb()
Message-ID: <20220201113828.coe2l74skdoyrlzz@quack3.lan>
References: <cover.1643642105.git.riteshh@linux.ibm.com>
 <65ffc304d66815b6e3270f71e5d756b307d3c5be.1643642105.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ffc304d66815b6e3270f71e5d756b307d3c5be.1643642105.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 31-01-22 20:46:53, Ritesh Harjani wrote:
> We don't need the return value of mb_test_and_clear_bits() in ext4_mb_mark_bb()
> So simply use mb_clear_bits() instead.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. I'm rather confused by ext4_set_bits() vs mb_clear_bits()
asymetry but that's not directly related to this patch. Just another
cleanup to do. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 60d32d3d8dc4..2f931575e6c2 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3943,7 +3943,7 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  	if (state)
>  		ext4_set_bits(bitmap_bh->b_data, blkoff, clen);
>  	else
> -		mb_test_and_clear_bits(bitmap_bh->b_data, blkoff, clen);
> +		mb_clear_bits(bitmap_bh->b_data, blkoff, clen);
>  	if (ext4_has_group_desc_csum(sb) &&
>  	    (gdp->bg_flags & cpu_to_le16(EXT4_BG_BLOCK_UNINIT))) {
>  		gdp->bg_flags &= cpu_to_le16(~EXT4_BG_BLOCK_UNINIT);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
