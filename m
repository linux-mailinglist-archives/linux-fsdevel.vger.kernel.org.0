Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C42AF749E63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjGFOAs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGFOAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:00:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6419C19B2;
        Thu,  6 Jul 2023 07:00:46 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 247CB1F747;
        Thu,  6 Jul 2023 14:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688652045; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxGry15H989syPHPQxBcd36hO5oYxiI6CLjT5miU2TM=;
        b=awVDcWX1hAYueNl7HTEZn6XDpD9iMJEzXHFIFgremf1/8USk7qN+8/A6rKggzGvN4wxTLK
        I8EY10b3dQxsCwQLQbAkMozvEqU81zoaRP+BTmZq9FFBHBg5pBMbMMd39dkft4z3sCEpJq
        d+TthFFUyTub3KIp6HwlSyfpnz+Gpbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688652045;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IxGry15H989syPHPQxBcd36hO5oYxiI6CLjT5miU2TM=;
        b=V0ra4DOpOPEFytemB0S42T+0rK5+jCv0Dboioa57wB0qdF/w2qGHJz7yuDRE6h/snM5Ec9
        Wo3h1u7o6zf5myDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CDB4138EE;
        Thu,  6 Jul 2023 14:00:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P/wYAw3JpmS9ZwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:00:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 50E2FA0707; Thu,  6 Jul 2023 16:00:44 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:00:44 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Anders Larsen <al@alarsen.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 69/92] qnx4: convert to ctime accessor functions
Message-ID: <20230706140044.4tvbd3m27k7sybmr@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-67-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-67-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:34, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Anders Larsen <al@alarsen.net>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/qnx4/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 391ea402920d..a7171f5532a1 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -305,8 +305,7 @@ struct inode *qnx4_iget(struct super_block *sb, unsigned long ino)
>  	inode->i_mtime.tv_nsec = 0;
>  	inode->i_atime.tv_sec   = le32_to_cpu(raw_inode->di_atime);
>  	inode->i_atime.tv_nsec = 0;
> -	inode->i_ctime.tv_sec   = le32_to_cpu(raw_inode->di_ctime);
> -	inode->i_ctime.tv_nsec = 0;
> +	inode_set_ctime(inode, le32_to_cpu(raw_inode->di_ctime), 0);
>  	inode->i_blocks  = le32_to_cpu(raw_inode->di_first_xtnt.xtnt_size);
>  
>  	memcpy(qnx4_inode, raw_inode, QNX4_DIR_ENTRY_SIZE);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
