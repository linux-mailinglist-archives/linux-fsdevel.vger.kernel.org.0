Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E7776E6B5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235474AbjHCLVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbjHCLVQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:21:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D624C13D;
        Thu,  3 Aug 2023 04:21:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 982C91F45A;
        Thu,  3 Aug 2023 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691061671; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=;
        b=SshCa3at/QVqc2HIIpLg9LhDhKTreRaL2cZGX45vYwIeK3cx7PttlNBGYy6OudlZNlY9ra
        MOv4rt6y4ZaVGS2gQBky7dhvCX5sAuEwxT7t0AG/xr4WPg3HrvCw3+qX5Fp1tt3Cecc/DQ
        xnTqKiRxO3ni8MzYtqEIGMQIwjC94ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691061671;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/oqdnU2hVSvQjG7zr7ybcm4vgtUzeJvEjdOgZyr5MDo=;
        b=H+MFCeAyi3R3yXuvvMJFuzNpnCx698yyaUcPgHxx1B/25fIvZ6HmN/YfD5MBWOxvwIKJn3
        LdjGjluOtzdqOXCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 85D45134B0;
        Thu,  3 Aug 2023 11:21:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C3WjIKeNy2SCLgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 11:21:11 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D9E0FA076B; Thu,  3 Aug 2023 13:21:10 +0200 (CEST)
Date:   Thu, 3 Aug 2023 13:21:10 +0200
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
Subject: Re: [PATCH 05/12] ext4: make the IS_EXT2_SB/IS_EXT3_SB checks more
 robust
Message-ID: <20230803112110.7qybhrgn2rwaguu2@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-6-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 17:41:24, Christoph Hellwig wrote:
> Check for sb->s_type which is the right place to look at the file system
> type, not the holder, which is just an implementation detail in the VFS
> helpers.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c94ebf704616e5..193d665813b611 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -140,7 +140,7 @@ static struct file_system_type ext2_fs_type = {
>  };
>  MODULE_ALIAS_FS("ext2");
>  MODULE_ALIAS("ext2");
> -#define IS_EXT2_SB(sb) ((sb)->s_bdev->bd_holder == &ext2_fs_type)
> +#define IS_EXT2_SB(sb) ((sb)->s_type == &ext2_fs_type)
>  #else
>  #define IS_EXT2_SB(sb) (0)
>  #endif
> @@ -156,7 +156,7 @@ static struct file_system_type ext3_fs_type = {
>  };
>  MODULE_ALIAS_FS("ext3");
>  MODULE_ALIAS("ext3");
> -#define IS_EXT3_SB(sb) ((sb)->s_bdev->bd_holder == &ext3_fs_type)
> +#define IS_EXT3_SB(sb) ((sb)->s_type == &ext3_fs_type)
>  
>  
>  static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
