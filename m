Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C2749991
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGFKjN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFKjM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:39:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDD519B2;
        Thu,  6 Jul 2023 03:39:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2E1B21CD3;
        Thu,  6 Jul 2023 10:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688639949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdLBu6A63hxyixyTpcewuhG1RM8NQH/INPJL9w63i7c=;
        b=erR0FYTiUJ9lcXE4myuMPFUGk3UPLEFAmaGFYB/HLsjJzl8wM2WWL6VF8YUpawlRhMSeRS
        CAe0FYVgjGZSc6OoQIImk4gSW3yUirW28PHaqAOOQIfDctiNmnP7cFC5rqSCMamBt2ZGP6
        gNrJLv5WRmEjSJpJmpaqLZrkHM4fsmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688639949;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZdLBu6A63hxyixyTpcewuhG1RM8NQH/INPJL9w63i7c=;
        b=WLaqslvYyxkXuDmzLS2ALbntN/AblrkOA0S/tqnvar9Yslwz/RC1WtmEw//grDMli5fD+3
        n16+XdFDSQH4JCDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6512138FC;
        Thu,  6 Jul 2023 10:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qOhNNM2ZpmQaewAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:39:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63B83A0707; Thu,  6 Jul 2023 12:39:09 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:39:09 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/92] exfat: convert to simple_rename_timestamp
Message-ID: <20230706103909.jclg3nvltflqgwo2@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-10-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-10-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:37, Jeff Layton wrote:
> A rename potentially involves updating 4 different inode timestamps.
> Convert to the new simple_rename_timestamp helper function.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/exfat/namei.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index d9b46fa36bff..e91022ff80ef 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1312,8 +1312,8 @@ static int exfat_rename(struct mnt_idmap *idmap,
>  		goto unlock;
>  
>  	inode_inc_iversion(new_dir);
> -	new_dir->i_ctime = new_dir->i_mtime = new_dir->i_atime =
> -		EXFAT_I(new_dir)->i_crtime = current_time(new_dir);
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
> +	EXFAT_I(new_dir)->i_crtime = current_time(new_dir);

Hum, you loose atime update with this. Not that it would make sense to have
it but it would probably deserve a comment in the changelog.

Also why you use current_time(new_dir) here instead of say inode->i_ctime?

>  	exfat_truncate_atime(&new_dir->i_atime);
>  	if (IS_DIRSYNC(new_dir))
>  		exfat_sync_inode(new_dir);
> @@ -1336,7 +1336,6 @@ static int exfat_rename(struct mnt_idmap *idmap,
>  	}
>  
>  	inode_inc_iversion(old_dir);
> -	old_dir->i_ctime = old_dir->i_mtime = current_time(old_dir);
>  	if (IS_DIRSYNC(old_dir))
>  		exfat_sync_inode(old_dir);
>  	else

Also there is:

                new_inode->i_ctime = EXFAT_I(new_inode)->i_crtime =
                        current_time(new_inode);

in exfat_rename() from which you can remove the ctime update?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
