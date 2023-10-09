Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3B17BD827
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJIKIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 06:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbjJIKI2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:08:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE9297;
        Mon,  9 Oct 2023 03:08:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 18EE421847;
        Mon,  9 Oct 2023 10:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696846106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KI8iGmDacbjyfpujQS0BFEqs/bpz2R47Nq98pWnN1Kg=;
        b=kLdsgi8ijKHDs7ueTrlwHESoADuAyKkXPOBTNwBbQdKHrIzCOAZY6lro9s2/pv6+f5QqQg
        +xBHbSs2QyDGx3z+s4/R9INchqMqHlLs0myYWnOwJzZ4GQ1LJSCIELKjXaaRbMcaRpHkku
        1fc1gKrlUleAhXjt3lZ6s/3uq6EyNT8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696846106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KI8iGmDacbjyfpujQS0BFEqs/bpz2R47Nq98pWnN1Kg=;
        b=Ezey8VTIiHbqUPl9cBkACsMHidTrypgIsvLLrLo1GXWsO+A+pyht3ciFWhBNDIN4wEAUnN
        OQ3sn7AuaxPnIyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 072C313905;
        Mon,  9 Oct 2023 10:08:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5aG1ARrRI2XpdQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 10:08:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 94439A04B2; Mon,  9 Oct 2023 12:08:25 +0200 (CEST)
Date:   Mon, 9 Oct 2023 12:08:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lizhi Xu <lizhi.xu@windriver.com>
Cc:     syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com,
        axboe@kernel.dk, brauner@kernel.org, dave.kleikamp@oracle.com,
        hare@suse.de, hch@lst.de, jack@suse.cz,
        jfs-discussion@lists.sourceforge.net, johannes.thumshirn@wdc.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: fix log->bdev_handle null ptr deref in lbmStartIO
Message-ID: <20231009100825.dkkaylsrj4db3ekp@quack3>
References: <0000000000005239cf060727d3f6@google.com>
 <20231009094557.1398920-1-lizhi.xu@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009094557.1398920-1-lizhi.xu@windriver.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 17:45:57, Lizhi Xu wrote:
> When sbi->flag is JFS_NOINTEGRITY in lmLogOpen(), log->bdev_handle can't
> be inited, so it value will be NULL.
> Therefore, add the "log ->no_integrity=1" judgment in lbmStartIO() to avoid such
> problems.
> 
> Reported-and-tested-by: syzbot+23bc20037854bb335d59@syzkaller.appspotmail.com
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>

Ah, good catch. Who would think someone creates bios for NULL bdev only to
release them shortly afterwards ;). Anyway the fix looks good. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

Christian, please pick up this fixup into your tree. Thanks!

								Honza

> ---
>  fs/jfs/jfs_logmgr.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
> index c911d838b8ec..c41a76164f84 100644
> --- a/fs/jfs/jfs_logmgr.c
> +++ b/fs/jfs/jfs_logmgr.c
> @@ -2110,10 +2110,14 @@ static void lbmStartIO(struct lbuf * bp)
>  {
>  	struct bio *bio;
>  	struct jfs_log *log = bp->l_log;
> +	struct block_device *bdev = NULL;
>  
>  	jfs_info("lbmStartIO");
>  
> -	bio = bio_alloc(log->bdev_handle->bdev, 1, REQ_OP_WRITE | REQ_SYNC,
> +	if (!log->no_integrity) 
> +		bdev = log->bdev_handle->bdev;	
> +
> +	bio = bio_alloc(bdev, 1, REQ_OP_WRITE | REQ_SYNC,
>  			GFP_NOFS);
>  	bio->bi_iter.bi_sector = bp->l_blkno << (log->l2bsize - 9);
>  	__bio_add_page(bio, bp->l_page, LOGPSIZE, bp->l_offset);
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
