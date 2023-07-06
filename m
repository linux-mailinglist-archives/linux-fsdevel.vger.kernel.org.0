Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD4749C67
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjGFMsv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbjGFMsb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:48:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C871FDB;
        Thu,  6 Jul 2023 05:48:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 150B1228BE;
        Thu,  6 Jul 2023 12:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688647682; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gRXye/rxgx5yXx+4yaqVLpPLLCHYMJGCFB4srDdTvrs=;
        b=HXYJ/++T9nVftJLw686zBdTp0YcyK0ZaRFe/2Xxm0wzQL/fp9KguiyhCNN7DBor7IsCLAS
        hD4ctzB4Pz2fvwPnnGy6mlXg+7chpKrRw7QOQD36xXsc3gckcMccpGVTQ3P5YvO4XE2aSw
        GLjtsJYxF10ha9wbTTNMpd7hCWV2+ZY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688647682;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gRXye/rxgx5yXx+4yaqVLpPLLCHYMJGCFB4srDdTvrs=;
        b=mH3XoeJCtzX3hkFYlQJGOO8bI2u0KB2in0z2GPcmkdyNbzdafC/huFHu0vnDvQW6he2Quw
        pCGP4mx09bJlF8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0782C138FC;
        Thu,  6 Jul 2023 12:48:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+nJAQK4pmQcQgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 12:48:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AB698A0707; Thu,  6 Jul 2023 14:48:01 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:48:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v2 50/92] hostfs: convert to ctime accessor functions
Message-ID: <20230706124801.exu6lh2d6dwt4dfj@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-48-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-48-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:15, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/hostfs/hostfs_kern.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
> index 46387090eb76..182af84a9c12 100644
> --- a/fs/hostfs/hostfs_kern.c
> +++ b/fs/hostfs/hostfs_kern.c
> @@ -517,8 +517,7 @@ static int hostfs_inode_update(struct inode *ino, const struct hostfs_stat *st)
>  		(struct timespec64){ st->atime.tv_sec, st->atime.tv_nsec };
>  	ino->i_mtime =
>  		(struct timespec64){ st->mtime.tv_sec, st->mtime.tv_nsec };
> -	ino->i_ctime =
> -		(struct timespec64){ st->ctime.tv_sec, st->ctime.tv_nsec };
> +	inode_set_ctime_to_ts(ino, &st->ctime);
>  	ino->i_size = st->size;
>  	ino->i_blocks = st->blocks;
>  	return 0;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
