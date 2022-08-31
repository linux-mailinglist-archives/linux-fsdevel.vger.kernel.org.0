Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C2C5A7BE7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 13:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiHaLGK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHaLGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 07:06:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3D89C536;
        Wed, 31 Aug 2022 04:06:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 72C7E21A7B;
        Wed, 31 Aug 2022 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661943967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ux+/6k6yQ68d20CIHpJNNhVF8b7vMhQjE5cIGh8WXbA=;
        b=gWzBh39lJUgv8YalnH1E/zHqDoZvJuwDJttq0eb5EwKD3gexkpEUqig8vE7ADgEj0aTpVk
        zmNsNkqdttx1r6tv8m5fU+ur8lf5fuRAEAE26Ontuxm07GZBmWv8Pz8w1DIEfmEFLu9uRJ
        PxcE/nkR+bxUDvtlQOuzJb8tk5EMZJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661943967;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ux+/6k6yQ68d20CIHpJNNhVF8b7vMhQjE5cIGh8WXbA=;
        b=79CrkKwcDm35RwKykj4Z/UcaMkbv7xV6sge+XImxuYJK/wSO3Zb6g/ir0fibCVSJxWpAkg
        84P5fdryH8GO1XBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57DD213A7C;
        Wed, 31 Aug 2022 11:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s7heFZ9AD2MidAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 31 Aug 2022 11:06:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C5DBBA067B; Wed, 31 Aug 2022 13:06:06 +0200 (CEST)
Date:   Wed, 31 Aug 2022 13:06:06 +0200
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
Subject: Re: [PATCH 11/14] ufs: replace ll_rw_block()
Message-ID: <20220831110606.7c25xioli2uxcacr@quack3>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
 <20220831072111.3569680-12-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220831072111.3569680-12-yi.zhang@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 31-08-22 15:21:08, Zhang Yi wrote:
> ll_rw_block() is not safe for the sync read path because it cannot
> guarantee that submitting read IO if the buffer has been locked. We
> could get false positive EIO after wait_on_buffer() if the buffer has
> been locked by others. So stop using ll_rw_block() in ufs.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ufs/balloc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ufs/balloc.c b/fs/ufs/balloc.c
> index bd810d8239f2..bbc2159eece4 100644
> --- a/fs/ufs/balloc.c
> +++ b/fs/ufs/balloc.c
> @@ -296,9 +296,7 @@ static void ufs_change_blocknr(struct inode *inode, sector_t beg,
>  			if (!buffer_mapped(bh))
>  					map_bh(bh, inode->i_sb, oldb + pos);
>  			if (!buffer_uptodate(bh)) {
> -				ll_rw_block(REQ_OP_READ, 1, &bh);
> -				wait_on_buffer(bh);
> -				if (!buffer_uptodate(bh)) {
> +				if (bh_read(bh, 0)) {
>  					ufs_error(inode->i_sb, __func__,
>  						  "read of block failed\n");
>  					break;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
