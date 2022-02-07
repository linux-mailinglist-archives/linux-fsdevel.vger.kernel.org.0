Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D19444AC67A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 17:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245470AbiBGQxN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 11:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390852AbiBGQp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:45:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9237DC0401D6;
        Mon,  7 Feb 2022 08:45:43 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4E61C1F380;
        Mon,  7 Feb 2022 16:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644252342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWRtBB3Dgiht4f5U+0EoMI1j8uMVf1Y34Pbo+aXQ5Ds=;
        b=C094EB8yWPQCWQZrcpJIdjSq5JJNcOcR3RdgHBe0UYuqAl3CUUc7oA3ega3+R05AaSjov/
        mgziNxycTT8Zjt6sKr6A7W2ZIYVRbvlFfts4XIJHpjyZhPXhuX6Y6PB0DX8voevIhC8jke
        KdiWzzauY5GmxxyC7XHd5ebcc4R8MqQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644252342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CWRtBB3Dgiht4f5U+0EoMI1j8uMVf1Y34Pbo+aXQ5Ds=;
        b=zu1tb0+ryIIN87Q1u0Pz4fUhOg1JFgvX1pD+eEFEOWzL7ngwRh+0yu5PC/OSfsCzBkuKU6
        zvwRfrl2K32/uRDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 125A5A3B8B;
        Mon,  7 Feb 2022 16:45:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A40D6A05BB; Mon,  7 Feb 2022 17:45:41 +0100 (CET)
Date:   Mon, 7 Feb 2022 17:45:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 9/9] ext4: Add extra check in ext4_mb_mark_bb() to
 prevent against possible corruption
Message-ID: <20220207164541.ewtyvkrcbgvmqkbi@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <50eb09dbf5d8d67c7edb0a4c0146e184cf4e2ed0.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50eb09dbf5d8d67c7edb0a4c0146e184cf4e2ed0.1644062450.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-02-22 19:39:58, Ritesh Harjani wrote:
> This patch adds an extra checks in ext4_mb_mark_bb() function
> to make sure we mark & report error if we were to mark/clear any
> of the critical FS metadata specific bitmaps (&bail out) to prevent
> from any accidental corruption.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 9f2b3a057918..75c20a10529a 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3918,6 +3918,14 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
>  			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
>  		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
>  
> +		if (!ext4_sb_block_valid(sb, NULL, block, thisgrp_len)) {
> +			ext4_error(sb, "Marking blocks in system zone - "
> +				   "Block = %llu, len = %u",
> +				   block, thisgrp_len);
> +			bitmap_bh = NULL;
> +			break;
> +		}
> +
>  		bitmap_bh = ext4_read_block_bitmap(sb, group);
>  		if (IS_ERR(bitmap_bh)) {
>  			err = PTR_ERR(bitmap_bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
