Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2E278A9E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Aug 2023 12:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjH1KRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 06:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjH1KRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:17:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857E710C;
        Mon, 28 Aug 2023 03:17:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 459A51F460;
        Mon, 28 Aug 2023 10:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693217821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WzDkkOqXyxAW32MenOUeYu097Eo7SdlcGQval63I74=;
        b=EEBmCGQOH+CjpytQ23tFboiOF5bUumEY42hJJmF9uR7EkxZGEF7NpwuSdKVnkYVGiyq9ph
        btR4PFUGX2KK96gSKU7+t7x+AadDXdkhXvSdKoUh0M5Rz1i+Wz2YcROCo6UHkpal/UHsbt
        +bN9l1hmQ0Yip+ggLTWWdAAzC/7pIfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693217821;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WzDkkOqXyxAW32MenOUeYu097Eo7SdlcGQval63I74=;
        b=iJfZWaN15mnddcMeDrgjmcOL1xf+ot/rKn3Bjl7gEH7L0hVn9qRHB1AOCGhQPtY8CyGCUP
        kAtYDa9Yuvbf0oBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30A66139CC;
        Mon, 28 Aug 2023 10:17:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +D7WCx107GQvTgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 28 Aug 2023 10:17:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7A6CAA0774; Mon, 28 Aug 2023 12:17:00 +0200 (CEST)
Date:   Mon, 28 Aug 2023 12:17:00 +0200
From:   Jan Kara <jack@suse.cz>
To:     Edward AD <eadavis@sina.com>
Cc:     syzbot+b3123e6d9842e526de39@syzkaller.appspotmail.com,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: fix ext4_calculate_overhead use invliad j_inode
Message-ID: <20230828101700.i3exsxt7bxz53kau@quack3>
References: <000000000000b1426e0603bc40b6@google.com>
 <20230826035554.2849316-1-eadavis@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826035554.2849316-1-eadavis@sina.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 26-08-23 11:55:54, Edward AD wrote:
> In ext4_calculate_overhead(), ext4_get_journal_inode() returned an invalid inode 
> pointer without processing. Here, an invalid pointer judgment condition is added 
> to avoid incorrect operation of invalid pointer j_inode.
> 
> Reported-by: syzbot+b3123e6d9842e526de39@syzkaller.appspotmail.com
> Fixes: 99d6c5d892bf ("ext4: ext4_get_{dev}_journal return proper error value")
> Signed-off-by: Edward AD <eadavis@sina.com>

Thanks for the fixup but Ted has already merged the fixup from Zhang Yi [1].

								Honza

[1] https://lore.kernel.org/all/20230826011029.2023140-1-yi.zhang@huaweicloud.com


> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 34f5406c08da..0dac00954d25 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4178,7 +4178,7 @@ int ext4_calculate_overhead(struct super_block *sb)
>  	else if (ext4_has_feature_journal(sb) && !sbi->s_journal && j_inum) {
>  		/* j_inum for internal journal is non-zero */
>  		j_inode = ext4_get_journal_inode(sb, j_inum);
> -		if (j_inode) {
> +		if (j_inode && !IS_ERR(j_inode)) {
>  			j_blocks = j_inode->i_size >> sb->s_blocksize_bits;
>  			overhead += EXT4_NUM_B2C(sbi, j_blocks);
>  			iput(j_inode);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
