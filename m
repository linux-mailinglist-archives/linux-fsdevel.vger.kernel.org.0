Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D607BE2A6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234553AbjJIOZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234088AbjJIOZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:25:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E228E;
        Mon,  9 Oct 2023 07:25:14 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF92421880;
        Mon,  9 Oct 2023 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696861512; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfoiN7IKbgfE7NwvuyHMDs9h6NzVDK3Dfvij5BkWyTI=;
        b=sx6wGUn82P8cqqAvbJeSDxojJtC7vO+jZWJXBp0ZPTJQ7HCxuB5jlDUPJJ3Hqk1thaUCHz
        apPl+ZTF0KS+EQoPASvfrZNznX1t0x6FLmUavFd8Ipfn8K6vCOqhY1FDEmSMTgu+5Ea7xk
        ZLjc+kMiLaipeXwfQZYEwa7Fx6WoS9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696861512;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vfoiN7IKbgfE7NwvuyHMDs9h6NzVDK3Dfvij5BkWyTI=;
        b=tzyHHmt1zQ5jrMF2ufvJvDjW5eblR4jmGiRncphW7tKsHI6AVmylUJ0jIJyDg4rJrCaqeK
        BlbjQx1Us0+pzTCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C0EAB13905;
        Mon,  9 Oct 2023 14:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xu0VL0gNJGVjDQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 14:25:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 455FAA04BB; Mon,  9 Oct 2023 16:25:12 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:25:12 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
Subject: Re: [PATCH 4/4] reiserfs: fix journal device opening
Message-ID: <20231009142512.7wimsbttpjyivcks@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-4-723a2f1132ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-4-723a2f1132ce@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 14:33:41, Christian Brauner wrote:
> We can't open devices with s_umount held without risking deadlocks.
> So drop s_umount and reacquire it when opening the journal device.
> 
> Reported-by: syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index e001a96fc76c..0c680de72d43 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -2714,7 +2714,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  	struct reiserfs_journal_header *jh;
>  	struct reiserfs_journal *journal;
>  	struct reiserfs_journal_list *jl;
> -	int ret;
> +	int ret = 1;
>  
>  	journal = SB_JOURNAL(sb) = vzalloc(sizeof(struct reiserfs_journal));
>  	if (!journal) {
> @@ -2727,6 +2727,13 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  	INIT_LIST_HEAD(&journal->j_working_list);
>  	INIT_LIST_HEAD(&journal->j_journal_list);
>  	journal->j_persistent_trans = 0;
> +
> +	/*
> +	 * blkdev_put() can't be called under s_umount, see the comment
> +	 * in get_tree_bdev() for more details
> +	 */
> +	up_write(&sb->s_umount);
> +
>  	if (reiserfs_allocate_list_bitmaps(sb, journal->j_list_bitmap,
>  					   reiserfs_bmap_count(sb)))
>  		goto free_and_return;
> @@ -2891,8 +2898,7 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  		goto free_and_return;
>  	}
>  
> -	ret = journal_read(sb);
> -	if (ret < 0) {
> +	if (journal_read(sb) < 0) {
>  		reiserfs_warning(sb, "reiserfs-2006",
>  				 "Replay Failure, unable to mount");
>  		goto free_and_return;
> @@ -2900,10 +2906,14 @@ int journal_init(struct super_block *sb, const char *j_dev_name,
>  
>  	INIT_DELAYED_WORK(&journal->j_work, flush_async_commits);
>  	journal->j_work_sb = sb;
> -	return 0;
> +	ret = 0;
> +
>  free_and_return:
> -	free_journal_ram(sb);
> -	return 1;
> +	if (ret)
> +		free_journal_ram(sb);
> +
> +	down_write(&sb->s_umount);
> +	return ret;
>  }
>  
>  /*
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
