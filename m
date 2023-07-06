Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2590749DD5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjGFNea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGFNe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:34:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B053F1996;
        Thu,  6 Jul 2023 06:34:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68C7421B05;
        Thu,  6 Jul 2023 13:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688650466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+HWAIIhhV1bbuzI9bn8sagrmpXmB6BY8CYYY/NSQTwM=;
        b=npaGavp6icAn1NmRjA9mKQDvfWmqXbyKpBHBZr1tu6i8zpkXeKW3rOP6f8uzseYID9+vXz
        NsWzXJrKKb6lvLciPYWsM/tfBLa6vE62JeDrc61WKqHz12fBmeAIOqgkdjbuVJVjuVHp9Q
        9RrXPM1oC2eG7HbQ5w4193yqb4ruPGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688650466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+HWAIIhhV1bbuzI9bn8sagrmpXmB6BY8CYYY/NSQTwM=;
        b=EamnCtiW/jL/E0B3FI40IZChzyblMMUeCqgK2LZ6EQpUEWQGipeXUAU1IBq8i+Kv4XoDda
        yNP2u3/6t5/edjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AA63138EE;
        Thu,  6 Jul 2023 13:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w6EgFuLCpmQqWgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:34:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F11EBA0707; Thu,  6 Jul 2023 15:34:25 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:34:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 58/92] nfsd: convert to ctime accessor functions
Message-ID: <20230706133425.ahb7vxida6hks6z7@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-56-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-56-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:23, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/nfsctl.c | 2 +-
>  fs/nfsd/vfs.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 1b8b1aab9a15..a53c5660a8c4 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -1131,7 +1131,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
>  	/* Following advice from simple_fill_super documentation: */
>  	inode->i_ino = iunique(sb, NFSD_MaxReserved);
>  	inode->i_mode = mode;
> -	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	switch (mode & S_IFMT) {
>  	case S_IFDIR:
>  		inode->i_fop = &simple_dir_operations;
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 8a2321d19194..40a68bae88fc 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -520,7 +520,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	nfsd_sanitize_attrs(inode, iap);
>  
> -	if (check_guard && guardtime != inode->i_ctime.tv_sec)
> +	if (check_guard && guardtime != inode_get_ctime(inode).tv_sec)
>  		return nfserr_notsync;
>  
>  	/*
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
