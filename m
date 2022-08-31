Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76095A7C0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiHaLPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiHaLPy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:15:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39F0883D3;
        Wed, 31 Aug 2022 04:15:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D059A1F924;
        Wed, 31 Aug 2022 11:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661944551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXzaBEvTVV7dbi9myeynRQQFCXVdxVJKtZqX81xMy8k=;
        b=mPbi7U2qKIanPKYVB8sPf2stChvWwJ1COvVr00O/9AJRZvghUomaQbB0KyXkUy4pMnVLKr
        w/6h+8ghNadTMJGE7oK3ErbM4mfCpj2CGsMQK4AHXb36lCPabynaouGuZ/Z5Agk4IDg2j4
        pSdrP2QZlF517bgBQJnIFu8gpi74cQg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661944551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oXzaBEvTVV7dbi9myeynRQQFCXVdxVJKtZqX81xMy8k=;
        b=+8l5+Kxjd5pNwOzZL5ohw7iQDKbEQCrFZuuYixoYezrMKq3W4lXTV40FstJ3qPyZO5S3mg
        Ln5047YJolJZx8Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF37013A7C;
        Wed, 31 Aug 2022 11:15:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oOq5KudCD2NueAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:15:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2254CA067B; Wed, 31 Aug 2022 13:15:51 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:15:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        ntfs3@lists.linux.dev, ocfs2-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        akpm@linux-foundation.org, axboe@kernel.dk,
        viro@zeniv.linux.org.uk, rpeterso@redhat.com, agruenba@redhat.com,
        almaz.alexandrovich@paragon-software.com, mark@fasheh.com,
        dushistov@mail.ru, hch@infradead.org, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH 13/14] ext2: replace bh_submit_read() helper with
 bh_read_locked()
Message-ID: <20220831111551.pjrcx2ld6wm5trct@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-14-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-14-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:10, Zhang Yi wrote:
> bh_submit_read() is almost the same as bh_read_locked(), switch to use
> bh_read_locked() in read_block_bitmap(), prepare remove the old one.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
...
> diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
> index c17ccc19b938..548a1d607f5a 100644
> --- a/fs/ext2/balloc.c
> +++ b/fs/ext2/balloc.c
> @@ -142,7 +142,7 @@ read_block_bitmap(struct super_block *sb, unsigned int block_group)
>  	if (likely(bh_uptodate_or_lock(bh)))
>  		return bh;
>  
> -	if (bh_submit_read(bh) < 0) {
> +	if (bh_read_locked(bh, 0) < 0) {

I would just use bh_read() here and thus remove a bit more of the
boilerplate code (like the bh_uptodate_or_lock() checking).

							Honza

>  		brelse(bh);
>  		ext2_error(sb, __func__,
>  			    "Cannot read block bitmap - "
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
