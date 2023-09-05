Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F597924CA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjIEP7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354739AbjIEN4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:56:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C67197;
        Tue,  5 Sep 2023 06:56:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 540EA21AD2;
        Tue,  5 Sep 2023 13:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693922190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BnNbZmpVxIuS2BOlgd/tEGnEIeSQoFZTx2iHFPSc4mI=;
        b=ciKXi3l1Ha5z2PZ2BDnzEiMWhD+C4bNAB+qBTTH3fC+FFngmzNOIMGtiD5PmUMQcx4sBAj
        kt9TA3xsCecAHmBpO0EB4uuHHLusmW8qbC8SFIBvcxg6JEB15jBYi1CKtqVg8X44+GPxGr
        1gnl1gOS1MsIaZoalDedSXXUlWOJtLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693922190;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BnNbZmpVxIuS2BOlgd/tEGnEIeSQoFZTx2iHFPSc4mI=;
        b=Wn2hz/d85qD1aEc4S49DpeqS6I93TPG1dFMtvinHW2gVqTgZc6e3IfbdCR17bGfFD45QKl
        fcl03+/4Ple1XNDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 44F8513499;
        Tue,  5 Sep 2023 13:56:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8EayEI4z92QcRgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 05 Sep 2023 13:56:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AF555A0776; Tue,  5 Sep 2023 15:56:29 +0200 (CEST)
Date:   Tue, 5 Sep 2023 15:56:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <20230905135629.wdjl2b6s3pzh7idg@quack3>
References: <cover.1693909504.git.ojaswin@linux.ibm.com>
 <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 05-09-23 15:58:01, Ojaswin Mujoo wrote:
> ** Short Version **
> 
> In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> never zero out the range of bh that is not under write, causing whatever stale
> data is present in the folio at that time to be written out to disk. To fix this
> mark the buffer as new in _ext4_get_block(), in case it is unwritten.
> 
> -----
> ** Long Version **
> 
> The issue mentioned above was resulting in two different bugs:
> 
> 1. On block size < page size case in ext4, generic/269 was reliably
> failing with dioread_nolock. The state of the write was as follows:
> 
>   * The write was extending i_size.
>   * The last block of the file was fallocated and had an unwritten extent
>   * We were near ENOSPC and hence we were switching to non-delayed alloc
>     allocation.
> 
> In this case, the back trace that triggers the bug is as follows:
> 
>   ext4_da_write_begin()
>     /* switch to nodelalloc due to low space */
>     ext4_write_begin()
>       ext4_should_dioread_nolock() // true since mount flags still have delalloc
>       __block_write_begin(..., ext4_get_block_unwritten)
>         __block_write_begin_int()
>           for(each buffer head in page) {
>             /* first iteration, this is bh1 which contains i_size */
>             if (!buffer_mapped)
>               get_block() /* returns bh with only UNWRITTEN and MAPPED */
>             /* second iteration, bh2 */
>               if (!buffer_mapped)
>                 get_block() /* we fail here, could be ENOSPC */
>           }
>           if (err)
>             /*
>              * this would zero out all new buffers and mark them uptodate.
>              * Since bh1 was never marked new, we skip it here which causes
>              * the bug later.
>              */
>             folio_zero_new_buffers();
>       /* ext4_wrte_begin() error handling */
>       ext4_truncate_failed_write()
>         ext4_truncate()
>           ext4_block_truncate_page()
>             __ext4_block_zero_page_range()
	>               if(!buffer_uptodate())
>                 ext4_read_bh_lock()
>                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
>                     BUG_ON(buffer_unwritten(bh)); /* !!! */
> 
> 2. The second issue is stale data exposure with page size >= blocksize
> with dioread_nolock. The conditions needed for it to happen are same as
> the previous issue ie dioread_nolock around ENOSPC condition. The issue
> is also similar where in __block_write_begin_int() when we call
> ext4_get_block_unwritten() on the buffer_head and the underlying extent
> is unwritten, we get an unwritten and mapped buffer head. Since it is
> not new, we never zero out the partial range which is not under write,
> thus writing stale data to disk. This can be easily observed with the
> following reporducer:
> 
>  fallocate -l 4k testfile
>  xfs_io -c "pwrite 2k 2k" testfile
>  # hexdump output will have stale data in from byte 0 to 2k in testfile
>  hexdump -C testfile
> 
> NOTE: To trigger this, we need dioread_nolock enabled and write
> happening via ext4_write_begin(), which is usually used when we have -o
> nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
> alternate way to call ext4_write_begin() is to fill make sure dellayed
> alloc switches to nodelalloc (ext4_da_write_begin() calls
> ext4_write_begin()).  This will usually happen when FS is almost full
> like the way generic/269 was triggering it in Issue 1 above. This might
> make this issue harder to replicate hence for reliable replicate, I used
> the below patch to temporarily allow dioread_nolock with nodelalloc and
> then mount the disk with -o nodealloc,dioread_nolock. With this you can
> hit the stale data issue 100% of times:
> 
> @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
>   if (ext4_should_journal_data(inode))
>     return 0;
>   /* temporary fix to prevent generic/422 test failures */
> - if (!test_opt(inode->i_sb, DELALLOC))
> -   return 0;
> + // if (!test_opt(inode->i_sb, DELALLOC))
> + //  return 0;
>   return 1;
>  }
> 
> -------
> 
> After applying this patch to mark buffer as NEW, both the above issues are
> fixed.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Good catch! But I'm wondering whether this is really the right fix. For
example in ext4_block_truncate_page() shouldn't we rather be checking
whether the buffer isn't unwritten and if yes then bail because there's
nothing to zero out in the block? That would seem like a more logical
and robust solution of the first problem to me.

Regarding the second issue I agree that using buffer_new flag makes the
most sense. But it would make most sense to me to put this special logic
directly into ext4_get_block_unwritten() because it is really special logic
when preparing buffered write via unwritten extent (and it relies on
__block_write_begin_int() logic to interpret buffer_new flag in the right
way). Putting in _ext4_get_block() seems confusing to me because it raises
questions like why should we set it for reads? And why not set it already
in ext4_map_blocks() which is also used by iomap?

								Honza


> ---
>  fs/ext4/inode.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 6c490f05e2ba..a30bfec0b525 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -765,6 +765,10 @@ static int _ext4_get_block(struct inode *inode, sector_t iblock,
>  	if (ret > 0) {
>  		map_bh(bh, inode->i_sb, map.m_pblk);
>  		ext4_update_bh_state(bh, map.m_flags);
> +
> +		if (buffer_unwritten(bh))
> +			set_buffer_new(bh);
> +
>  		bh->b_size = inode->i_sb->s_blocksize * map.m_len;
>  		ret = 0;
>  	} else if (ret == 0) {
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
