Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F2A4AC680
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 17:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbiBGQxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 11:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239932AbiBGQmn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:42:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D09C0401D1;
        Mon,  7 Feb 2022 08:42:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 900B2210E5;
        Mon,  7 Feb 2022 16:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644252161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RisJZ8b8EPVQ7pfozdxNwp19nb/lmVtKodGngXI8S8=;
        b=F58l/veJoWTL2z72iEyV6iGWuis9mwljKYfdl5pqHuW+DwbsWiE4SI395AXfh9vGVbCzM7
        8M5Mb+Jnv2ESGaoe2F9Ervxpzl+XyCgYwXQYSWZBdrPWnQb7L2610+hNdnhfbwctNcAoFw
        SBALq/bNzIaV1N4eCb4cInJqRpUoKmM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644252161;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6RisJZ8b8EPVQ7pfozdxNwp19nb/lmVtKodGngXI8S8=;
        b=0iZkcePax3j41qylhopB4xFUEZuGe2YtQARUujCYmoxn6WqLpYGYfzNbgqupMsUzOqvtJj
        /DtnVQQc+3aydtDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8281BA3B84;
        Mon,  7 Feb 2022 16:42:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2AEBDA05BB; Mon,  7 Feb 2022 17:42:41 +0100 (CET)
Date:   Mon, 7 Feb 2022 17:42:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: Re: [PATCHv1 7/9] ext4: Add ext4_sb_block_valid() refactored out of
 ext4_inode_block_valid()
Message-ID: <20220207164241.voulrwcz4ib2ujoz@quack3.lan>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
 <1c5fae30be49b5116e4e5604e6224b33b778feaf.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c5fae30be49b5116e4e5604e6224b33b778feaf.1644062450.git.riteshh@linux.ibm.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 05-02-22 19:39:56, Ritesh Harjani wrote:
> This API will be needed at places where we don't have an inode
> for e.g. while freeing blocks in ext4_group_add_blocks()
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

...

> @@ -329,7 +324,8 @@ int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
>  		else if (start_blk >= (entry->start_blk + entry->count))
>  			n = n->rb_right;
>  		else {
> -			ret = (entry->ino == inode->i_ino);
> +			if (inode)
> +				ret = (entry->ino == inode->i_ino);
>  			break;

In case inode is not passed, we must not overlap any entry in the rbtree.
So we should return 0, not 1.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
