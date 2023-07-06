Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC58749985
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 12:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGFKbE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 06:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjGFKbC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:31:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB21BD6;
        Thu,  6 Jul 2023 03:31:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 27D4D1FE81;
        Thu,  6 Jul 2023 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688639459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcNDrPJIIBM1X7LIBRDVAwvKuZGT1oAcgJGf+1Sy2TU=;
        b=W3Q7uSTjmS76OIbXTawFr2zcGdDSiCkFBRCOWvvgGu5SUV2FiW9goEdtx/Yk7xQ+gANSS8
        KW/RsZ+np8RQDEPNtkUF0zkJ6b0T7sanpkG5Wb8y4IqP8ujvFKMwmojvr5c9V0K6W0ENIQ
        BCpVXaCSi7YN38TEi8rx2/NEk3FvFNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688639459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zcNDrPJIIBM1X7LIBRDVAwvKuZGT1oAcgJGf+1Sy2TU=;
        b=fWwsj/P2v2mk+cKIoPxix+mSmaAmLeHu5eOFg1E47uNO4HWZAh4njaTYQ1oB8yctl6nmGl
        ZVf4W0gEBMWfpHAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1994E138FC;
        Thu,  6 Jul 2023 10:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uQ4zBuOXpmT2dgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 10:30:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A1B3AA0707; Thu,  6 Jul 2023 12:30:58 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:30:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 10/92] ubifs: convert to simple_rename_timestamp
Message-ID: <20230706103058.xfg4pti3tyqghpla@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-8-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-8-jlayton@kernel.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:00:35, Jeff Layton wrote:
> A rename potentially involves updating 4 different inode timestamps.
> Convert to the new simple_rename_timestamp helper function.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ubifs/dir.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index ef0499edc248..7ec25310bd8a 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1414,8 +1414,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>  	 * Like most other Unix systems, set the @i_ctime for inodes on a
>  	 * rename.
>  	 */
> -	time = current_time(old_dir);
> -	old_inode->i_ctime = time;
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>  
>  	/* We must adjust parent link count when renaming directories */
>  	if (is_dir) {
> @@ -1444,13 +1443,11 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	old_dir->i_size -= old_sz;
>  	ubifs_inode(old_dir)->ui_size = old_dir->i_size;
> -	old_dir->i_mtime = old_dir->i_ctime = time;
> -	new_dir->i_mtime = new_dir->i_ctime = time;
>  
>  	/*
>  	 * And finally, if we unlinked a direntry which happened to have the
>  	 * same name as the moved direntry, we have to decrement @i_nlink of
> -	 * the unlinked inode and change its ctime.
> +	 * the unlinked inode.
>  	 */
>  	if (unlink) {
>  		/*
> @@ -1462,7 +1459,6 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>  			clear_nlink(new_inode);
>  		else
>  			drop_nlink(new_inode);
> -		new_inode->i_ctime = time;
>  	} else {
>  		new_dir->i_size += new_sz;
>  		ubifs_inode(new_dir)->ui_size = new_dir->i_size;
> @@ -1557,7 +1553,6 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>  	int sync = IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir);
>  	struct inode *fst_inode = d_inode(old_dentry);
>  	struct inode *snd_inode = d_inode(new_dentry);
> -	struct timespec64 time;
>  	int err;
>  	struct fscrypt_name fst_nm, snd_nm;
>  
> @@ -1588,11 +1583,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>  
>  	lock_4_inodes(old_dir, new_dir, NULL, NULL);
>  
> -	time = current_time(old_dir);
> -	fst_inode->i_ctime = time;
> -	snd_inode->i_ctime = time;
> -	old_dir->i_mtime = old_dir->i_ctime = time;
> -	new_dir->i_mtime = new_dir->i_ctime = time;
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>  
>  	if (old_dir != new_dir) {
>  		if (S_ISDIR(fst_inode->i_mode) && !S_ISDIR(snd_inode->i_mode)) {
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
