Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE355551491
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jun 2022 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiFTJj1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jun 2022 05:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241191AbiFTJjT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:39:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC321AD;
        Mon, 20 Jun 2022 02:39:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 296BC21BE2;
        Mon, 20 Jun 2022 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655717957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYWVMHG5uiifTKfpGR7tyTllpx+/f/+eExU2DAYRFNY=;
        b=1akeDa7jLquFL+eWMEejUwJa+/2OgtGeby6xSYE+BPN5fd1COSsxN1ZNpY+nAf4okWA/+P
        BFWkdBZIWC3wdJKkuVRE9FNR2qzVDJGE26a3f97VGXeLmr79Bf9bhkqGvBn7ju5q3QNw85
        IkMNqbHGyXMeaZM9TnlfJqn7L8kVes8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655717957;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYWVMHG5uiifTKfpGR7tyTllpx+/f/+eExU2DAYRFNY=;
        b=sGLhYT27kayAumlETIvojm2oXS2+SzMYJ3bits8e7W6cf0o/JP4djbelmLTIG31kbi74aL
        E2KgSwgaVlKgw6Bg==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 130BE2C141;
        Mon, 20 Jun 2022 09:39:17 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A569A0636; Mon, 20 Jun 2022 11:39:16 +0200 (CEST)
Date:   Mon, 20 Jun 2022 11:39:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC 1/3] jbd2: Drop useless return value of submit_bh
Message-ID: <20220620093916.qxrg7qowpqcm7umf@quack3.lan>
References: <cover.1655703466.git.ritesh.list@gmail.com>
 <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57b9cb59e50dfdf68eef82ef38944fbceba4e585.1655703467.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 11:28:40, Ritesh Harjani wrote:
> submit_bh always returns 0. This patch cleans up 2 of it's caller
> in jbd2 to drop submit_bh's useless return value.
> Once all submit_bh callers are cleaned up, we can make it's return
> type as void.
> 
> Signed-off-by: Ritesh Harjani <ritesh.list@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/commit.c  | 11 +++++------
>  fs/jbd2/journal.c |  6 ++----
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index eb315e81f1a6..688fd960d01f 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -122,8 +122,8 @@ static int journal_submit_commit_record(journal_t *journal,
>  {
>  	struct commit_header *tmp;
>  	struct buffer_head *bh;
> -	int ret;
>  	struct timespec64 now;
> +	int write_flags = REQ_SYNC;
>  
>  	*cbh = NULL;
>  
> @@ -155,13 +155,12 @@ static int journal_submit_commit_record(journal_t *journal,
>  
>  	if (journal->j_flags & JBD2_BARRIER &&
>  	    !jbd2_has_feature_async_commit(journal))
> -		ret = submit_bh(REQ_OP_WRITE,
> -			REQ_SYNC | REQ_PREFLUSH | REQ_FUA, bh);
> -	else
> -		ret = submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +		write_flags |= REQ_PREFLUSH | REQ_FUA;
> +
> +	submit_bh(REQ_OP_WRITE, write_flags, bh);
>  
>  	*cbh = bh;
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index c0cbeeaec2d1..81a282e676bc 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1606,7 +1606,7 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>  {
>  	struct buffer_head *bh = journal->j_sb_buffer;
>  	journal_superblock_t *sb = journal->j_superblock;
> -	int ret;
> +	int ret = 0;
>  
>  	/* Buffer got discarded which means block device got invalidated */
>  	if (!buffer_mapped(bh)) {
> @@ -1636,14 +1636,12 @@ static int jbd2_write_superblock(journal_t *journal, int write_flags)
>  		sb->s_checksum = jbd2_superblock_csum(journal, sb);
>  	get_bh(bh);
>  	bh->b_end_io = end_buffer_write_sync;
> -	ret = submit_bh(REQ_OP_WRITE, write_flags, bh);
> +	submit_bh(REQ_OP_WRITE, write_flags, bh);
>  	wait_on_buffer(bh);
>  	if (buffer_write_io_error(bh)) {
>  		clear_buffer_write_io_error(bh);
>  		set_buffer_uptodate(bh);
>  		ret = -EIO;
> -	}
> -	if (ret) {
>  		printk(KERN_ERR "JBD2: Error %d detected when updating "
>  		       "journal superblock for %s.\n", ret,
>  		       journal->j_devname);
> -- 
> 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
