Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22B16A4153
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjB0MBc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Feb 2023 07:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjB0MBa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Feb 2023 07:01:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B28B1E1E9;
        Mon, 27 Feb 2023 04:01:29 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AF3A1FD63;
        Mon, 27 Feb 2023 12:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677499288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5gTAfyOlTzJ4oNO8+DLYyEkz3s3GJLc/VFSfJCGKz0=;
        b=FIyedv0JYW76OtvV3yup4m9Qj3D6wyMeLRm9cQpsCMISbtFtQvlBaaJ7ocZL5bRyTjVrHG
        ph+isYzOGm/oNxrbgKnFU16cSaedQnUwzYy0MvkxpfeFIc9wZDIiS77n5MvsdB5lRdXN4F
        58wd10GQ7iI8OGjyj0mmDObloRWXrzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677499288;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G5gTAfyOlTzJ4oNO8+DLYyEkz3s3GJLc/VFSfJCGKz0=;
        b=WjFZ2KFENIJoscFRwD5VRAkucF7ktW5jlnLnZiu3spXSMrnA2BWhKSrdChAGrLgDp7VTt0
        7RdDZF06n3cveVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0DFCA13912;
        Mon, 27 Feb 2023 12:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NjBlA5ib/GMzLwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Feb 2023 12:01:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C909A06F2; Mon, 27 Feb 2023 13:01:27 +0100 (CET)
Date:   Mon, 27 Feb 2023 13:01:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, rookxu <brookxu.cn@gmail.com>
Subject: Re: [PATCH v4 6/9] ext4: Fix best extent lstart adjustment logic in
 ext4_mb_new_inode_pa()
Message-ID: <20230227120127.ki3ydzdbi25d5wmp@quack3>
References: <cover.1676634592.git.ojaswin@linux.ibm.com>
 <79b5240a6168171577b1bb9ef7a27c0c52676d37.1676634592.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79b5240a6168171577b1bb9ef7a27c0c52676d37.1676634592.git.ojaswin@linux.ibm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 17-02-23 17:44:15, Ojaswin Mujoo wrote:
> When the length of best extent found is less than the length of goal extent
> we need to make sure that the best extent atleast covers the start of the
> original request. This is done by adjusting the ac_b_ex.fe_logical (logical
> start) of the extent.
> 
> While doing so, the current logic sometimes results in the best extent's logical
> range overflowing the goal extent. Since this best extent is later added to the
> inode preallocation list, we have a possibility of introducing overlapping
> preallocations. This is discussed in detail here [1].
> 
> To fix this, replace the existing logic with the below logic for adjusting best
> extent as it keeps fragmentation in check while ensuring logical range of best
> extent doesn't overflow out of goal extent:
> 
> 1. Check if best extent can be kept at end of goal range and still cover
>    original start.
> 2. Else, check if best extent can be kept at start of goal range and still cover
>    original start.
> 3. Else, keep the best extent at start of original request.
> 
> Also, add a few extra BUG_ONs that might help catch errors faster.
> 
> [1] https://lore.kernel.org/r/Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one style nit below.

> +		/*
> +		 * Use the below logic for adjusting best extent as it keeps
> +		 * fragmentation in check while ensuring logical range of best
> +		 * extent doesn't overflow out of goal extent:
> +		 *
> +		 * 1. Check if best ex can be kept at end of goal and still
> +		 *    cover original start
> +		 * 2. Else, check if best ex can be kept at start of goal and
> +		 *    still cover original start
> +		 * 3. Else, keep the best ex at start of original request.
> +		 */
> +		new_bex_end = ac->ac_g_ex.fe_logical +
> +			EXT4_C2B(sbi, ac->ac_g_ex.fe_len);
> +		new_bex_start = new_bex_end - EXT4_C2B(sbi, ac->ac_b_ex.fe_len);
> +		if (ac->ac_o_ex.fe_logical >= new_bex_start)
> +				goto adjust_bex;
		^^^ The indentation looks too big here

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
