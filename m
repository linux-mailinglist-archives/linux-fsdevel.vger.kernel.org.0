Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50D749FFC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 16:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjGFOzH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjGFOzF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:55:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5B52125;
        Thu,  6 Jul 2023 07:54:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D22B21F88F;
        Thu,  6 Jul 2023 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1688655282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tSo8xDw/4qcrWyUtHEM2stuMbnFOxbY9OoKZvqkah0=;
        b=mHhvp4jf0MFo2z3YcKERCxkpzRzJBbCelVKeZAZ0kN6xFb8sMvsbkRWAAMCoHrxd7iEQWb
        34l1W7dgUg+LFqnFVIosV4gl/SDlPv/v2tWzzYV6SgfxsHhprTGhxPvMAPPhmtCVDa/rhF
        DsFt8PSqv3XhwMfDiW/RmbmvXN4dPgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1688655282;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4tSo8xDw/4qcrWyUtHEM2stuMbnFOxbY9OoKZvqkah0=;
        b=dBBLre/VUWulQVojAhsXZSOmFrBpGc0qrHnu793gUTECixk3/9pV3cuRV2iVEV3tRezVTs
        zkecolNTSbCV/vAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3213138FC;
        Thu,  6 Jul 2023 14:54:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6g+cL7LVpmRnBAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 06 Jul 2023 14:54:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 503BAA0707; Thu,  6 Jul 2023 16:54:42 +0200 (CEST)
Date:   Thu, 6 Jul 2023 16:54:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 85/92] mqueue: convert to ctime accessor functions
Message-ID: <20230706145442.3ycggpvtwez7hz5s@quack3>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-83-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705190309.579783-83-jlayton@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 05-07-23 15:01:50, Jeff Layton wrote:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  ipc/mqueue.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 71881bddad25..ba8215ed663a 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -302,7 +302,7 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
>  	inode->i_mode = mode;
>  	inode->i_uid = current_fsuid();
>  	inode->i_gid = current_fsgid();
> -	inode->i_mtime = inode->i_ctime = inode->i_atime = current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>  
>  	if (S_ISREG(mode)) {
>  		struct mqueue_inode_info *info;
> @@ -596,7 +596,7 @@ static int mqueue_create_attr(struct dentry *dentry, umode_t mode, void *arg)
>  
>  	put_ipc_ns(ipc_ns);
>  	dir->i_size += DIRENT_SIZE;
> -	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
> +	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
>  
>  	d_instantiate(dentry, inode);
>  	dget(dentry);
> @@ -618,7 +618,7 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
>  
> -	dir->i_ctime = dir->i_mtime = dir->i_atime = current_time(dir);
> +	dir->i_mtime = dir->i_atime = inode_set_ctime_current(dir);
>  	dir->i_size -= DIRENT_SIZE;
>  	drop_nlink(inode);
>  	dput(dentry);
> @@ -635,7 +635,8 @@ static int mqueue_unlink(struct inode *dir, struct dentry *dentry)
>  static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
>  				size_t count, loff_t *off)
>  {
> -	struct mqueue_inode_info *info = MQUEUE_I(file_inode(filp));
> +	struct inode *inode = file_inode(filp);
> +	struct mqueue_inode_info *info = MQUEUE_I(inode);
>  	char buffer[FILENT_SIZE];
>  	ssize_t ret;
>  
> @@ -656,7 +657,7 @@ static ssize_t mqueue_read_file(struct file *filp, char __user *u_data,
>  	if (ret <= 0)
>  		return ret;
>  
> -	file_inode(filp)->i_atime = file_inode(filp)->i_ctime = current_time(file_inode(filp));
> +	inode->i_atime = inode_set_ctime_current(inode);
>  	return ret;
>  }
>  
> @@ -1162,8 +1163,7 @@ static int do_mq_timedsend(mqd_t mqdes, const char __user *u_msg_ptr,
>  				goto out_unlock;
>  			__do_notify(info);
>  		}
> -		inode->i_atime = inode->i_mtime = inode->i_ctime =
> -				current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  	}
>  out_unlock:
>  	spin_unlock(&info->lock);
> @@ -1257,8 +1257,7 @@ static int do_mq_timedreceive(mqd_t mqdes, char __user *u_msg_ptr,
>  
>  		msg_ptr = msg_get(info);
>  
> -		inode->i_atime = inode->i_mtime = inode->i_ctime =
> -				current_time(inode);
> +		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
>  
>  		/* There is now free space in queue. */
>  		pipelined_receive(&wake_q, info);
> @@ -1396,7 +1395,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
>  	if (notification == NULL) {
>  		if (info->notify_owner == task_tgid(current)) {
>  			remove_notification(info);
> -			inode->i_atime = inode->i_ctime = current_time(inode);
> +			inode->i_atime = inode_set_ctime_current(inode);
>  		}
>  	} else if (info->notify_owner != NULL) {
>  		ret = -EBUSY;
> @@ -1422,7 +1421,7 @@ static int do_mq_notify(mqd_t mqdes, const struct sigevent *notification)
>  
>  		info->notify_owner = get_pid(task_tgid(current));
>  		info->notify_user_ns = get_user_ns(current_user_ns());
> -		inode->i_atime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode_set_ctime_current(inode);
>  	}
>  	spin_unlock(&info->lock);
>  out_fput:
> @@ -1485,7 +1484,7 @@ static int do_mq_getsetattr(int mqdes, struct mq_attr *new, struct mq_attr *old)
>  			f.file->f_flags &= ~O_NONBLOCK;
>  		spin_unlock(&f.file->f_lock);
>  
> -		inode->i_atime = inode->i_ctime = current_time(inode);
> +		inode->i_atime = inode_set_ctime_current(inode);
>  	}
>  
>  	spin_unlock(&info->lock);
> -- 
> 2.41.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
