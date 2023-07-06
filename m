Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA79749A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbjGFK5n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjGFK5T (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:57:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309C171D;
        Thu,  6 Jul 2023 03:56:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 33D9622198;
        Thu,  6 Jul 2023 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688640995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR3QZLsIPfEtA5uIlB7DuNlqPC9LWmqXsuZ1ZDbfsLQ=;
        b=Zc+jlcwveKVLW3kdqnFbznxwbhZPbhvbTvx3b31h9NqPqFTQZn3AB2pYSkjLB60X5cIF3P
        b49N0uZMFlUcQN0/6W+8gy6y2MPeugrkiwd/OAA5TC2vmTPw1cblRkylEFlHNMhmJBBU5B
        uxIgqRmRwUP7rQqAygtxtQARQ9X6XcU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688640995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR3QZLsIPfEtA5uIlB7DuNlqPC9LWmqXsuZ1ZDbfsLQ=;
        b=1cI8fCn/AEZ4eI6GZatDhnC3NvAqxADANU3KWLfMPnzskQAtpXuPtACrnDzd1kQIs+D4Vn
        Q4LjNGRzMYXIrjDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20267138EE;
        Thu,  6 Jul 2023 10:56:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iSzXB+OdpmT0BQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:56:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C9C4A0707; Thu,  6 Jul 2023 12:56:34 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:56:34 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ecryptfs@vger.kernel.org
Subject: Re: [PATCH v2 36/92] ecryptfs: convert to ctime accessor functions
Message-ID: <20230706105634.ca5d4dv34z67bld3@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-34-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-34-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:01, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ecryptfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
> index 83274915ba6d..b491bb239c8f 100644
> --- a/fs/ecryptfs/inode.c
> +++ b/fs/ecryptfs/inode.c
> @@ -148,7 +148,7 @@ static int ecryptfs_do_unlink(struct inode *dir, struct dentry *dentry,
>  	}
>  	fsstack_copy_attr_times(dir, lower_dir);
>  	set_nlink(inode, ecryptfs_inode_to_lower(inode)->i_nlink);
> -	inode->i_ctime = dir->i_ctime;
> +	inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
>  out_unlock:
>  	dput(lower_dentry);
>  	inode_unlock(lower_dir);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
