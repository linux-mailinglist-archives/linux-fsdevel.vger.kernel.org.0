Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E50551494
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiFTJkW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiFTJkT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:40:19 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8813D77;
        Mon, 20 Jun 2022 02:40:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 81D271FAC7;
        Mon, 20 Jun 2022 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655718016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KUjjHf5tlCJj2mUcZZwy2Ih7xiYladsUyylahPh1sY=;
        b=M+TPtpvTnLfqNrPP2b/QF9DsgPWVYTxw/pMSRwClMAJsxF6hkShH3ocMs10vR8sfPCIcje
        naGl3ycH9hGNa5D0FZlg+4Fe5Ho3RRuOkhFwhKONO0hoOGhut4CyyCaFuw3DOLvQWqThNe
        V6ehE4/6dDLT/6Cdc22nQI9Vlj5MmUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655718016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6KUjjHf5tlCJj2mUcZZwy2Ih7xiYladsUyylahPh1sY=;
        b=A+R30WPBSdq2tOmDkifzhxTuRBT+P6EHf0q2jw8a+ouxCe7HWIjSZMVj3G+5MjqU1ZMYLe
        Flzr2fIsowG+yKCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 714052C141;
        Mon, 20 Jun 2022 09:40:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 31C2AA0636; Mon, 20 Jun 2022 11:40:16 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:40:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 2/3] fs/buffer: Drop useless return value of submit_bh
Message-ID: <20220620094016.2sobdlp3bzmuorou@quack3.lan>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <77274d2a2030f6ee06901496f9c5fbe8779127a3.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77274d2a2030f6ee06901496f9c5fbe8779127a3.1655703467.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 11:28:41, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch drops the useless return value of
> submit_bh from __sync_dirty_buffer(). Once all of submit_bh callers are
> cleaned up, we can make it's return type as void.
> 
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 898c7f301b1b..313283af15b6 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -3121,8 +3121,6 @@ EXPORT_SYMBOL(write_dirty_buffer);
>   */
>  int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
>  {
> -	int ret = 0;
> -
>  	WARN_ON(atomic_read(&bh->b_count) < 1);
>  	lock_buffer(bh);
>  	if (test_clear_buffer_dirty(bh)) {
> @@ -3137,14 +3135,14 @@ int __sync_dirty_buffer(struct buffer_head *bh, int op_flags)
>  
>  		get_bh(bh);
>  		bh->b_end_io = end_buffer_write_sync;
> -		ret = submit_bh(REQ_OP_WRITE, op_flags, bh);
> +		submit_bh(REQ_OP_WRITE, op_flags, bh);
>  		wait_on_buffer(bh);
> -		if (!ret && !buffer_uptodate(bh))
> -			ret = -EIO;
> +		if (!buffer_uptodate(bh))
> +			return -EIO;
>  	} else {
>  		unlock_buffer(bh);
>  	}
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL(__sync_dirty_buffer);
>  
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
