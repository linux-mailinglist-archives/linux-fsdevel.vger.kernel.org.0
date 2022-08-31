Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A255A7C30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiHaLbi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaLbh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:31:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9FCA1A60;
        Wed, 31 Aug 2022 04:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 584321F893;
        Wed, 31 Aug 2022 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661945495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrNkIM9koqnVx0iIIXA2kZMeNNiavp0FWSmtqMYA0AU=;
        b=j090jyCm7ljBjfs584BrGreYmQ2T034+Z8td5gv5FfrZdYMc/nlY8I/aSz4C3omfWXI7/r
        ZEOzi6UQXDB/dteLKZnnp6hc6sOMCOwq5e58CzzpQlUY6ftrhpOKAPFxsdKIx1CgNfMFzA
        Hj4TA31NoNrPyxjPQrg5GzRWQRMIkIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661945495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XrNkIM9koqnVx0iIIXA2kZMeNNiavp0FWSmtqMYA0AU=;
        b=tPMWSP1a01IN2kwdj3whXjAztjKIlV4ffC1mOQYyySOtBL6HO9DkoW/WjMWwVHqCAYhxCh
        O+LRuPOxKQsV1wBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 422571332D;
        Wed, 31 Aug 2022 11:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JKAjEJdGD2NefwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:31:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D7D52A067B; Wed, 31 Aug 2022 13:31:34 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:31:34 +0200
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
Subject: Re: [PATCH 08/14] ocfs2: replace ll_rw_block()
Message-ID: <20220831113134.fdmklqore4uglz7g@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-9-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-9-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:05, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that submitting read IO if the buffer has been locked. We
> could get false positive EIO after wait_on_buffer() if the buffer has
> been locked by others. So stop using ll_rw_block() in ocfs2.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  fs/ocfs2/aops.c  | 2 +-
>  fs/ocfs2/super.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
> index af4157f61927..1d65f6ef00ca 100644
> --- a/fs/ocfs2/aops.c
> +++ b/fs/ocfs2/aops.c
> @@ -636,7 +636,7 @@ int ocfs2_map_page_blocks(struct page *page, u64 *p_blkno,
>  			   !buffer_new(bh) &&
>  			   ocfs2_should_read_blk(inode, page, block_start) &&
>  			   (block_start < from || block_end > to)) {
> -			ll_rw_block(REQ_OP_READ, 1, &bh);
> +			bh_read_nowait(bh, 0);
>  			*wait_bh++=bh;
>  		}
>  
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index e2cc9eec287c..4050f35bbd0c 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -1763,10 +1763,7 @@ static int ocfs2_get_sector(struct super_block *sb,
>  	lock_buffer(*bh);
>  	if (!buffer_dirty(*bh))
>  		clear_buffer_uptodate(*bh);
> -	unlock_buffer(*bh);
> -	ll_rw_block(REQ_OP_READ, 1, bh);
> -	wait_on_buffer(*bh);
> -	if (!buffer_uptodate(*bh)) {
> +	if (bh_read_locked(*bh, 0)) {
>  		mlog_errno(-EIO);
>  		brelse(*bh);
>  		*bh = NULL;

I would just use bh_read() here and drop bh_read_locked() altogether...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
