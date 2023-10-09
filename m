Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92677BE235
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376968AbjJIONC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376944AbjJIOM5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:12:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B1B8E;
        Mon,  9 Oct 2023 07:12:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0DBDA21888;
        Mon,  9 Oct 2023 14:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696860775; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2GYX8JSgGdKWggmywu2FDBZSE2vohK3oaeFf6lKuTo=;
        b=Z+Mbe3k0YcLpTpjaJpYN8TiOiCscknP2yAVvSJmDKb/Ymn568DMXT/n/PfKjAqJ4CVgf3N
        bZcY1h9NeXNquRNapOY8KxUPRLwnSs7mUElhryCLggFAmNyBK6UvRe6O0TpcyjeaYNiqdd
        ViHFNjE2PSuRGNFE/6JJP3UmOoBT4ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696860775;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F2GYX8JSgGdKWggmywu2FDBZSE2vohK3oaeFf6lKuTo=;
        b=tuZxU90xwNvnButZ9bPURv3udQmE6pqcYcJlJ0qQLHRBq+Ruf9Ak/6HDvKJS8lNIq83BvI
        g/BQv6j4WeoOzvAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F32F513905;
        Mon,  9 Oct 2023 14:12:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OR1QO2YKJGVTBgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 14:12:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8185AA04BB; Mon,  9 Oct 2023 16:12:54 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:12:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/4] reiserfs: user superblock as holder for journal
 device
Message-ID: <20231009141254.hjasc4ymbtsc242p@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-1-723a2f1132ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-1-723a2f1132ce@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 14:33:38, Christian Brauner wrote:
> I see no reason to use the journal as the holder of the block device.
> The superblock should be used. In the case were the journal and main
> device are the same we can easily reclaim because the same holder is
> used.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks sane. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index 015bfe4e4524..b9d9bf26d108 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2591,12 +2591,7 @@ static void release_journal_dev(struct super_block *super,
>  			       struct reiserfs_journal *journal)
>  {
>  	if (journal->j_dev_bd != NULL) {
> -		void *holder = NULL;
> -
> -		if (journal->j_dev_bd->bd_dev != super->s_dev)
> -			holder = journal;
> -
> -		blkdev_put(journal->j_dev_bd, holder);
> +		blkdev_put(journal->j_dev_bd, super);
>  		journal->j_dev_bd = NULL;
>  	}
>  }
> @@ -2606,7 +2601,6 @@ static int journal_init_dev(struct super_block *super,
>  			    const char *jdev_name)
>  {
>  	blk_mode_t blkdev_mode = BLK_OPEN_READ;
> -	void *holder = journal;
>  	int result;
>  	dev_t jdev;
>  
> @@ -2621,10 +2615,8 @@ static int journal_init_dev(struct super_block *super,
>  
>  	/* there is no "jdev" option and journal is on separate device */
>  	if ((!jdev_name || !jdev_name[0])) {
> -		if (jdev == super->s_dev)
> -			holder = NULL;
> -		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, holder,
> -						      NULL);
> +		journal->j_dev_bd = blkdev_get_by_dev(jdev, blkdev_mode, super,
> +						      &fs_holder_ops);
>  		if (IS_ERR(journal->j_dev_bd)) {
>  			result = PTR_ERR(journal->j_dev_bd);
>  			journal->j_dev_bd = NULL;
> @@ -2638,8 +2630,8 @@ static int journal_init_dev(struct super_block *super,
>  		return 0;
>  	}
>  
> -	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, holder,
> -					       NULL);
> +	journal->j_dev_bd = blkdev_get_by_path(jdev_name, blkdev_mode, super,
> +					       &fs_holder_ops);
>  	if (IS_ERR(journal->j_dev_bd)) {
>  		result = PTR_ERR(journal->j_dev_bd);
>  		journal->j_dev_bd = NULL;
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
