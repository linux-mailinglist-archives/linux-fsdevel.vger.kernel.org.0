Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97A7198A9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjFAKMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjFAKLb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:11:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B71B9;
        Thu,  1 Jun 2023 03:10:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 435BC1F390;
        Thu,  1 Jun 2023 10:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685614241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGaVNdrkOTZj2qtdf7F3hcg3d/zT2ZnEwKaCdF4xaDk=;
        b=rkGU7YuqDa0vDogKN0AnnB3zSfXHFGa6pgkDu32cgjOh6OY/QYWhIC3Lkr1aKT+UlBQPnx
        x7NMdXiyIS89w25V4Sf0RAn72OHsl5NqH2XnkMateoVR0ejYGqcFv3CLJlg1mziClju5q9
        9iTDHgZLcL0pYOuVo673CVqvm7JCPjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685614241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGaVNdrkOTZj2qtdf7F3hcg3d/zT2ZnEwKaCdF4xaDk=;
        b=yPu+odnJb6bTRtnTEl9iyNWElxkTl26Y3upcQUZey6tbaM6noup6UrXCbNhPnIK5WcobFV
        njAdUwkpIPJzNVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 336B9139B7;
        Thu,  1 Jun 2023 10:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eWqFDKFueGSBPQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 10:10:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C721AA0754; Thu,  1 Jun 2023 12:10:40 +0200 (CEST)
Date:   Thu, 1 Jun 2023 12:10:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 15/16] ext4: wire up sops->shutdown
Message-ID: <20230601101040.5fcpj7ie5g5gtzhz@quack3>
References: <20230601094459.1350643-1-hch@lst.de>
 <20230601094459.1350643-16-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094459.1350643-16-hch@lst.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 11:44:58, Christoph Hellwig wrote:
> Wire up the shutdown method to shut down the file system when the
> underlying block device is marked dead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 865625089ecca3..a177a16c4d2fe5 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1450,6 +1450,11 @@ static void ext4_destroy_inode(struct inode *inode)
>  			 EXT4_I(inode)->i_reserved_data_blocks);
>  }
>  
> +static void ext4_shutdown(struct super_block *sb)
> +{
> +       ext4_force_shutdown(sb, EXT4_GOING_FLAGS_NOLOGFLUSH);
> +}
> +
>  static void init_once(void *foo)
>  {
>  	struct ext4_inode_info *ei = foo;
> @@ -1610,6 +1615,7 @@ static const struct super_operations ext4_sops = {
>  	.unfreeze_fs	= ext4_unfreeze,
>  	.statfs		= ext4_statfs,
>  	.show_options	= ext4_show_options,
> +	.shutdown	= ext4_shutdown,
>  #ifdef CONFIG_QUOTA
>  	.quota_read	= ext4_quota_read,
>  	.quota_write	= ext4_quota_write,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
