Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2386B749E5C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 15:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGFN7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGFN7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:59:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1382319B2;
        Thu,  6 Jul 2023 06:59:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C61D71FDD8;
        Thu,  6 Jul 2023 13:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688651979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6sMu/BjTnYH6/J9dAcbtmXjthsA9JArDGTT2zDLUsc=;
        b=je5hMMCwb7WgBH/zGNoB9s8P2nId4ji0ahMg5lAhftHRtsoeH7yWN4T1+1lSfBB/U25BR+
        NMySRHIaSqRcHIxWHTEI5+Vl5ICj5Xrp7OPUup7+PSeKfeAc5aKhr88CIOvCzgTxoTlBAk
        dpatgySLWM5KNJ4hu4bCqJfC9hFZIA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688651979;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r6sMu/BjTnYH6/J9dAcbtmXjthsA9JArDGTT2zDLUsc=;
        b=KIZk6il+I9iu+wmirgV76K8ltJYFsJq4BcBSWxYcl5v2XMfsEgAmLXqpJp7NRRgCNopp0L
        fnXtan00lqvR6xBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B76B0138EE;
        Thu,  6 Jul 2023 13:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lm3MLMvIpmQIZwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 13:59:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4EB1BA0707; Thu,  6 Jul 2023 15:59:39 +0200 (CEST)
Date:   Thu, 6 Jul 2023 15:59:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 67/92] procfs: convert to ctime accessor functions
Message-ID: <20230706135939.iyens427je5jwape@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-65-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-65-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:32, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/proc/base.c        | 2 +-
>  fs/proc/inode.c       | 2 +-
>  fs/proc/proc_sysctl.c | 2 +-
>  fs/proc/self.c        | 2 +-
>  fs/proc/thread_self.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index eb2e498e3b8d..bbc998fd2a2f 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -1902,7 +1902,7 @@ struct inode *proc_pid_make_inode(struct super_block *sb,
>  	ei = PROC_I(inode);
>  	inode->i_mode = mode;
>  	inode->i_ino = get_next_ino();
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_op = &proc_def_inode_operations;
>  
>  	/*
> diff --git a/fs/proc/inode.c b/fs/proc/inode.c
> index 67b09a1d9433..532dc9d240f7 100644
> --- a/fs/proc/inode.c
> +++ b/fs/proc/inode.c
> @@ -660,7 +660,7 @@ struct inode *proc_get_inode(struct super_block *sb, struct proc_dir_entry *de)
>  
>  	inode->i_private = de->data;
>  	inode->i_ino = de->low_ino;
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	PROC_I(inode)->pde = de;
>  	if (is_empty_pde(de)) {
>  		make_empty_dir_inode(inode);
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 5ea42653126e..6bc10e7e0ff7 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -463,7 +463,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
>  	head->count++;
>  	spin_unlock(&sysctl_lock);
>  
> -	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  	inode->i_mode = table->mode;
>  	if (!S_ISDIR(table->mode)) {
>  		inode->i_mode |= S_IFREG;
> diff --git a/fs/proc/self.c b/fs/proc/self.c
> index 72cd69bcaf4a..ecc4da8d265e 100644
> --- a/fs/proc/self.c
> +++ b/fs/proc/self.c
> @@ -46,7 +46,7 @@ int proc_setup_self(struct super_block *s)
>  		struct inode *inode = new_inode(s);
>  		if (inode) {
>  			inode->i_ino = self_inum;
> -			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  			inode->i_mode = S_IFLNK | S_IRWXUGO;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
> diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
> index a553273fbd41..63ac1f93289f 100644
> --- a/fs/proc/thread_self.c
> +++ b/fs/proc/thread_self.c
> @@ -46,7 +46,7 @@ int proc_setup_thread_self(struct super_block *s)
>  		struct inode *inode = new_inode(s);
>  		if (inode) {
>  			inode->i_ino = thread_self_inum;
> -			inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
> +			inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  			inode->i_mode = S_IFLNK | S_IRWXUGO;
>  			inode->i_uid = GLOBAL_ROOT_UID;
>  			inode->i_gid = GLOBAL_ROOT_GID;
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
