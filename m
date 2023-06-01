Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC2C71988E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjFAKLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbjFAKKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA75D10D2;
        Thu,  1 Jun 2023 03:10:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 431761F86C;
        Thu,  1 Jun 2023 10:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685614202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abruGtVP9ScBJlQSE7zQj+GmYvnPwSTU2l53mgFmTic=;
        b=Zx42HasM4xUfIKAaR1DIxrUHCDlW++ScBSLvBmVU7mgPyM2tfeAHZ9IqjU/o7qHowTYmUT
        j/ATwbtIxL0pvc5qcdjUBHxGh4x6QaOkAIC0I3cjFZgnBfxGX0E5YKLvzLS+o1n9I5V7cI
        lw+0C3I0imyQfaWsT5L5ehhp0TJ87PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685614202;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abruGtVP9ScBJlQSE7zQj+GmYvnPwSTU2l53mgFmTic=;
        b=nYy+Xvq2gyytdIjl0KzaQGicobj+XiYliqCUlH53r9TtVRlhqhLacFR0384vPY6X7qIT1X
        lfFwVbWHLXu2btDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31762139B7;
        Thu,  1 Jun 2023 10:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0csDDHpueGQcPQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 01 Jun 2023 10:10:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B5AB3A0754; Thu,  1 Jun 2023 12:10:01 +0200 (CEST)
Date:   Thu, 1 Jun 2023 12:10:01 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 14/16] ext4: split ext4_shutdown
Message-ID: <20230601101001.najppil33tuntlaw@quack3>
References: <20230601094459.1350643-1-hch@lst.de>
 <20230601094459.1350643-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601094459.1350643-15-hch@lst.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 01-06-23 11:44:57, Christoph Hellwig wrote:
> Split ext4_shutdown into a low-level helper that will be reused for
> implementing the shutdown super operation and a wrapper for the ioctl
> handling.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h  |  1 +
>  fs/ext4/ioctl.c | 24 +++++++++++++++---------
>  2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 6948d673bba2e8..2d60bbe8d171d9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2965,6 +2965,7 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
>  int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
>  extern void ext4_reset_inode_seed(struct inode *inode);
>  int ext4_update_overhead(struct super_block *sb, bool force);
> +int ext4_force_shutdown(struct super_block *sb, u32 flags);
>  
>  /* migrate.c */
>  extern int ext4_ext_migrate(struct inode *);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index f9a43015206323..961284cc9b65cc 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -793,16 +793,9 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
>  }
>  #endif
>  
> -static int ext4_shutdown(struct super_block *sb, unsigned long arg)
> +int ext4_force_shutdown(struct super_block *sb, u32 flags)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> -	__u32 flags;
> -
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EPERM;
> -
> -	if (get_user(flags, (__u32 __user *)arg))
> -		return -EFAULT;
>  
>  	if (flags > EXT4_GOING_FLAGS_NOLOGFLUSH)
>  		return -EINVAL;
> @@ -838,6 +831,19 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
>  	return 0;
>  }
>  
> +static int ext4_ioctl_shutdown(struct super_block *sb, unsigned long arg)
> +{
> +	u32 flags;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (get_user(flags, (__u32 __user *)arg))
> +		return -EFAULT;
> +
> +	return ext4_force_shutdown(sb, flags);
> +}
> +
>  struct getfsmap_info {
>  	struct super_block	*gi_sb;
>  	struct fsmap_head __user *gi_data;
> @@ -1566,7 +1572,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  		return ext4_ioctl_get_es_cache(filp, arg);
>  
>  	case EXT4_IOC_SHUTDOWN:
> -		return ext4_shutdown(sb, arg);
> +		return ext4_ioctl_shutdown(sb, arg);
>  
>  	case FS_IOC_ENABLE_VERITY:
>  		if (!ext4_has_feature_verity(sb))
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
