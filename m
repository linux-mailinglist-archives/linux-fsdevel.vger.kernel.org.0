Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC6A749A13
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjGFK6j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbjGFK6K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:58:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F842716;
        Thu,  6 Jul 2023 03:57:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E35B920536;
        Thu,  6 Jul 2023 10:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688641033; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU+KQtOfxXd2y/X5GZ0jdnumA5TIjpP1KtqeVSydWJw=;
        b=RKQGLC57VkNV2X1z0s7MYmOMEsEvfMK4LKdwUikn2AkD+14Ax5rn1ahAdgTbsvVO4cZu7G
        hdDCL8nZ+emJIEl7YAxTY0LZMTb5PoDE55oT2nnHlfPXYFKUWCcQgzHmxbHADT5vkeAT4j
        b8+cfP+W017z/1QZaYSU74IkhgjU85I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688641033;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qU+KQtOfxXd2y/X5GZ0jdnumA5TIjpP1KtqeVSydWJw=;
        b=GWmJcBIciv1pZ2NzY8rN0YZopk2igWa8Tp4h/I3kSQw2rMsAp1jxW5FiO3bOV/b8zEL5i3
        WL6wfAqobrGOqtCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6EB4138EE;
        Thu,  6 Jul 2023 10:57:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rIhrNAmepmRTBgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:57:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 74E8AA0707; Thu,  6 Jul 2023 12:57:13 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:57:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org
Subject: Re: [PATCH v2 37/92] efivarfs: convert to ctime accessor functions
Message-ID: <20230706105713.7drqohk4by4b5qmu@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-35-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-35-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:02, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/efivarfs/file.c  | 2 +-
>  fs/efivarfs/inode.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/efivarfs/file.c b/fs/efivarfs/file.c
> index 375576111dc3..59b52718a3a2 100644
> --- a/fs/efivarfs/file.c
> +++ b/fs/efivarfs/file.c
> @@ -51,7 +51,7 @@ static ssize_t efivarfs_file_write(struct file *file,
>  	} else {
>  		inode_lock(inode);
>  		i_size_write(inode, datasize + sizeof(attributes));
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>  		inode_unlock(inode);
>  	}
>  
> diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
> index b973a2c03dde..db9231f0e77b 100644
> --- a/fs/efivarfs/inode.c
> +++ b/fs/efivarfs/inode.c
> @@ -25,7 +25,7 @@ struct inode *efivarfs_get_inode(struct super_block *sb,
>  	if (inode) {
>  		inode->i_ino = get_next_ino();
>  		inode->i_mode = mode;
> -		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  		inode->i_flags = is_removable ? 0 : S_IMMUTABLE;
>  		switch (mode & S_IFMT) {
>  		case S_IFREG:
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
