Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BD07BE293
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Oct 2023 16:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377746AbjJIOV0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Oct 2023 10:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377762AbjJIOVN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:21:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C4D52;
        Mon,  9 Oct 2023 07:20:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BD7C21F390;
        Mon,  9 Oct 2023 14:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696861241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2n+oa7q0gJ0pG9cxvuascqOmxeHZ0cLdWEDHMfqmZls=;
        b=JWjHMms3ZJAfP24nEKSd13j+JL9WaK3VRjWQKw074mNjs3YqK7OOvLTaaUtrS7hjo+2tRj
        Ef/lvaejAa8hmWfLcYaZ58puvl9PANzUVgdNBxXi9FEFT50al3epX9smJYdc31vnxacUpP
        2qwQX8R5cLTt2c3oe9s7FxTrsd7UO7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696861241;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2n+oa7q0gJ0pG9cxvuascqOmxeHZ0cLdWEDHMfqmZls=;
        b=0AXIXfXjT/OFukR/2zi9rTWzq1GLODVhvdTGVdNtWIMmaiGkE5WqzCjO4bmJQEr5Zyxjus
        AnKj4upTOOs9R8Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B05C013905;
        Mon,  9 Oct 2023 14:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GSYJKzkMJGUqCwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 09 Oct 2023 14:20:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2C6C9A04BB; Mon,  9 Oct 2023 16:20:41 +0200 (CEST)
Date:   Mon, 9 Oct 2023 16:20:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        reiserfs-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] reiserfs: centralize journal device closing
Message-ID: <20231009142041.mukdcpomsz3ni6ru@quack3>
References: <20231009-vfs-fixes-reiserfs-v1-0-723a2f1132ce@kernel.org>
 <20231009-vfs-fixes-reiserfs-v1-3-723a2f1132ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009-vfs-fixes-reiserfs-v1-3-723a2f1132ce@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 09-10-23 14:33:40, Christian Brauner wrote:
> Currently the journal device is closed in multiple locations:
> 
> * in reiserfs_fill_super() if reiserfs_fill_super() fails
> * in reiserfs_put_super() when reiserfs is shut down and
>   reiserfs_fill_super() had succeeded
> 
> Stop duplicating this logic and always kill the journal device in
> reiserfs_kill_b().
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/journal.c  | 18 ++++++++----------
>  fs/reiserfs/reiserfs.h |  2 ++
>  fs/reiserfs/super.c    |  4 ++++
>  3 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
> index b9d9bf26d108..e001a96fc76c 100644
> --- a/fs/reiserfs/journal.c
> +++ b/fs/reiserfs/journal.c
> @@ -90,8 +90,6 @@ static int flush_commit_list(struct super_block *s,
>  static int can_dirty(struct reiserfs_journal_cnode *cn);
>  static int journal_join(struct reiserfs_transaction_handle *th,
>  			struct super_block *sb);
> -static void release_journal_dev(struct super_block *super,
> -			       struct reiserfs_journal *journal);
>  static void dirty_one_transaction(struct super_block *s,
>  				 struct reiserfs_journal_list *jl);
>  static void flush_async_commits(struct work_struct *work);
> @@ -1889,12 +1887,6 @@ static void free_journal_ram(struct super_block *sb)
>  	if (journal->j_header_bh) {
>  		brelse(journal->j_header_bh);
>  	}
> -	/*
> -	 * j_header_bh is on the journal dev, make sure
> -	 * not to release the journal dev until we brelse j_header_bh
> -	 */
> -	release_journal_dev(sb, journal);
> -	vfree(journal);
>  }
>  
>  /*
> @@ -2587,13 +2579,19 @@ static void journal_list_init(struct super_block *sb)
>  	SB_JOURNAL(sb)->j_current_jl = alloc_journal_list(sb);
>  }
>  
> -static void release_journal_dev(struct super_block *super,
> -			       struct reiserfs_journal *journal)
> +void reiserfs_release_journal_dev(struct super_block *super,
> +				  struct reiserfs_journal *journal)
>  {
>  	if (journal->j_dev_bd != NULL) {
>  		blkdev_put(journal->j_dev_bd, super);
>  		journal->j_dev_bd = NULL;
>  	}
> +
> +	/*
> +	 * j_header_bh is on the journal dev, make sure not to release
> +	 * the journal dev until we brelse j_header_bh
> +	 */
> +	vfree(journal);
>  }
>  
>  static int journal_init_dev(struct super_block *super,
> diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
> index 7d12b8c5b2fa..dd5d69c25e32 100644
> --- a/fs/reiserfs/reiserfs.h
> +++ b/fs/reiserfs/reiserfs.h
> @@ -3414,3 +3414,5 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>  long reiserfs_compat_ioctl(struct file *filp,
>  		   unsigned int cmd, unsigned long arg);
>  int reiserfs_unpack(struct inode *inode);
> +void reiserfs_release_journal_dev(struct super_block *super,
> +				  struct reiserfs_journal *journal);
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index 6db8ed10a78d..c04d9a4427e5 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -550,6 +550,7 @@ int remove_save_link(struct inode *inode, int truncate)
>  static void reiserfs_kill_sb(struct super_block *s)
>  {
>  	struct reiserfs_sb_info *sbi = REISERFS_SB(s);
> +	struct reiserfs_journal *journal = NULL;
>  
>  	if (sbi) {
>  		reiserfs_proc_info_done(s);
> @@ -567,10 +568,13 @@ static void reiserfs_kill_sb(struct super_block *s)
>  		sbi->xattr_root = NULL;
>  		dput(sbi->priv_root);
>  		sbi->priv_root = NULL;
> +		journal = SB_JOURNAL(s);
>  	}
>  
>  	kill_block_super(s);
>  
> +	if (journal)
> +		reiserfs_release_journal_dev(s, journal);
>  	kfree(sbi);
>  	s->s_fs_info = NULL;
>  }
> 
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
