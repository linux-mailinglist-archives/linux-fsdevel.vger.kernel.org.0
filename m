Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C558749988
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGFKcL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjGFKcK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:32:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF95E54;
        Thu,  6 Jul 2023 03:32:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 902A61FFB3;
        Thu,  6 Jul 2023 10:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688639528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GDhkv7kVU4fNDOWU2jUTGmYrtvjheK+E+ZD1vYsxzM=;
        b=R9dHok45Mfsd5AWQ5TKGFvH2lkRTzakQXx0Vme3cIW+e4NlWPDDhRdgN9ckkmOx+CBzm3i
        eAhKF4+HQ4y7lIXjMwO46Ukj0nnwYC+AIoTfg/XUrgHC6kKyr1oTFgSrprDhfAe7glNU1K
        Mimmblfj4o0AF4Kcm1ndxFX1Y40dAL0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688639528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5GDhkv7kVU4fNDOWU2jUTGmYrtvjheK+E+ZD1vYsxzM=;
        b=7V3m9xu1p3gDi+wXxP4ZbdybM6Rkfnxq3Ex/ZAA0dEbLTWOj7v5c/+HdS6a2I9kxAzQ88Q
        QKJi+3uX4+CuA1Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 82F9A138FC;
        Thu,  6 Jul 2023 10:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tov5HyiYpmSMdwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:32:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1D6D1A0707; Thu,  6 Jul 2023 12:32:08 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:32:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH v2 14/92] reiserfs: convert to simple_rename_timestamp
Message-ID: <20230706103208.3jwhlip4a6k7vzat@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-12-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-12-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:39, Jeff Layton wrote:
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/reiserfs/namei.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
> index 52240cc891cf..405ac59eb2dd 100644
> --- a/fs/reiserfs/namei.c
> +++ b/fs/reiserfs/namei.c
> @@ -1325,7 +1325,6 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
>  	int jbegin_count;
>  	umode_t old_inode_mode;
>  	unsigned long savelink = 1;
> -	struct timespec64 ctime;
>  
>  	if (flags & ~RENAME_NOREPLACE)
>  		return -EINVAL;
> @@ -1576,14 +1575,11 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
>  
>  	mark_de_hidden(old_de.de_deh + old_de.de_entry_num);
>  	journal_mark_dirty(&th, old_de.de_bh);
> -	ctime = current_time(old_dir);
> -	old_dir->i_ctime = old_dir->i_mtime = ctime;
> -	new_dir->i_ctime = new_dir->i_mtime = ctime;
>  	/*
>  	 * thanks to Alex Adriaanse <alex_a@caltech.edu> for patch
>  	 * which adds ctime update of renamed object
>  	 */
> -	old_inode->i_ctime = ctime;
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>  
>  	if (new_dentry_inode) {
>  		/* adjust link number of the victim */
> @@ -1592,7 +1588,6 @@ static int reiserfs_rename(struct mnt_idmap *idmap,
>  		} else {
>  			drop_nlink(new_dentry_inode);
>  		}
> -		new_dentry_inode->i_ctime = ctime;
>  		savelink = new_dentry_inode->i_nlink;
>  	}
>  
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
