Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8753E76E9C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 15:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbjHCNOX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 09:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236079AbjHCNNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:13:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55505525B;
        Thu,  3 Aug 2023 06:12:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EA5B021873;
        Thu,  3 Aug 2023 13:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691068343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ot59AV78ck5rwDh+ZxSbqdOYuWP3zspJplYXbIDCPEg=;
        b=it/uueHk20C6SWEYwRpODhnx+51PxdNAjrwcS9cfESIfoTBPsaMl9lEOEhlF32ejDxtO2A
        EA1m1wBtZxzuyOfvHcObttcWzU7rZueXbv/p4C8VY+JnylCyIh0khx8jqCl/EH+nKWK8JT
        UnXxYqzEOKMjCjdEpmW3Haw1++m2Mys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691068343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ot59AV78ck5rwDh+ZxSbqdOYuWP3zspJplYXbIDCPEg=;
        b=mHyzUQlS3YILs5AEHKYro3JJ7LVvtu/qJYwnmvIum04HjMQdynKDQAHtFCrr8yiH4eTuHl
        jsD3rd1lPhJ7MJAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8406134B0;
        Thu,  3 Aug 2023 13:12:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YUvNNLeny2RAaAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 13:12:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 67ED8A076B; Thu,  3 Aug 2023 15:12:23 +0200 (CEST)
Date:   Thu, 3 Aug 2023 15:12:23 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 07/12] fs: stop using get_super in fs_mark_dead
Message-ID: <20230803131223.qkxsxs7svtcu5buz@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-8-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 17:41:26, Christoph Hellwig wrote:
> fs_mark_dead currently uses get_super to find the superblock for the
> block device that is going away.  This means it is limited to the
> main device stored in sb->s_dev, leading to a lot of code duplication
> for file systems that can use multiple block devices.
> 
> Now that the holder for all block devices used by file systems is set
> to the super_block, we can instead look at that holder and then check
> if the file system is born and active, so do that instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 09b65ee1a8b737..0cda4af0a7e16c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1209,17 +1209,39 @@ int get_tree_keyed(struct fs_context *fc,
>  EXPORT_SYMBOL(get_tree_keyed);
>  
>  #ifdef CONFIG_BLOCK
> +/*
> + * Lock a super block that the callers holds a reference to.
> + *
> + * The caller needs to ensure that the super_block isn't being freed while
> + * calling this function, e.g. by holding a lock over the call to this function
> + * and the place that clears the pointer to the superblock used by this function
> + * before freeing the superblock.
> + */
> +static bool lock_active_super(struct super_block *sb)
> +{
> +	down_read(&sb->s_umount);
> +	if (!sb->s_root ||
> +	    (sb->s_flags & (SB_ACTIVE | SB_BORN)) != (SB_ACTIVE | SB_BORN)) {
> +		up_read(&sb->s_umount);
> +		return false;
> +	}
> +	return true;
> +}
> +
>  static void fs_mark_dead(struct block_device *bdev)
>  {
> -	struct super_block *sb;
> +	struct super_block *sb = bdev->bd_holder;
>  
> -	sb = get_super(bdev);
> -	if (!sb)
> +	/* bd_holder_lock ensures that the sb isn't freed */
> +	lockdep_assert_held(&bdev->bd_holder_lock);
> +
> +	if (!lock_active_super(sb))
>  		return;
>  
>  	if (sb->s_op->shutdown)
>  		sb->s_op->shutdown(sb);
> -	drop_super(sb);
> +
> +	up_read(&sb->s_umount);
>  }
>  
>  static const struct blk_holder_ops fs_holder_ops = {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
