Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD347B67C4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjJCLXY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 07:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjJCLXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:23:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A758E
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Oct 2023 04:23:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3DDFE2185E;
        Tue,  3 Oct 2023 11:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696332200; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qf6k43VVT3zUH4o91+3575R2UTBLl4WdAo8oz1MIFQ=;
        b=IZyzqKs28CmiJuOb1nRXmZpS081Ubt0KVzEZ5lww9xDZw3dXpUde0O2Dekv4Vmb1NAAVso
        Fmhu656BEXLDOWHXFkMPz/KDI0vXmvbZ5OusxkHOnX4/q89xoQkWcuRLYPcrDDuhhXOrn1
        cuJs+6xoIv0mRnyBtHaS7yPb9egOP64=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696332200;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5qf6k43VVT3zUH4o91+3575R2UTBLl4WdAo8oz1MIFQ=;
        b=6OBIccJ+s7wANkoULf4Ehqdmq2vVvmW9ljdmF9lJZrW9E9V+hTP4rYe3iWHl1f/tznbmhz
        PiCYEWuAmclAe7DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F63F139F9;
        Tue,  3 Oct 2023 11:23:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UGF0C6j5G2WcfAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 03 Oct 2023 11:23:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A4BB8A07CB; Tue,  3 Oct 2023 13:23:19 +0200 (CEST)
Date:   Tue, 3 Oct 2023 13:23:19 +0200
From:   Jan Kara <jack@suse.cz>
To:     cem@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, hughd@google.com,
        brauner@kernel.org, jack@suse.cz
Subject: Re: [PATCH 1/3] tmpfs: add project ID support
Message-ID: <20231003112319.2776q54vy3g33nvy@quack3>
References: <20230925130028.1244740-1-cem@kernel.org>
 <20230925130028.1244740-2-cem@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925130028.1244740-2-cem@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 25-09-23 15:00:26, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Lay down infrastructure to support project quotas.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  include/linux/shmem_fs.h | 11 ++++++++---
>  mm/shmem.c               |  6 ++++++
>  mm/shmem_quota.c         | 10 ++++++++++
>  3 files changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
> index 6b0c626620f5..e82a64f97917 100644
> --- a/include/linux/shmem_fs.h
> +++ b/include/linux/shmem_fs.h
> @@ -15,7 +15,10 @@
>  
>  #ifdef CONFIG_TMPFS_QUOTA
>  #define SHMEM_MAXQUOTAS 2
> -#endif
> +
> +/* Default project ID */
> +#define SHMEM_DEF_PROJID 0
> +#endif /* CONFIG_TMPFS_QUOTA */
>  
>  struct shmem_inode_info {
>  	spinlock_t		lock;
> @@ -33,14 +36,16 @@ struct shmem_inode_info {
>  	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
>  #ifdef CONFIG_TMPFS_QUOTA
>  	struct dquot		*i_dquot[MAXQUOTAS];
> +	kprojid_t		i_projid;
>  #endif

I'm not sure it is great to bind project ID support with CONFIG_TMPFS_QUOTA
and in particular with sb_has_quota_active(sb, PRJQUOTA). It seems as a bit
unnatural restriction that could confuse administrators.

>  	struct offset_ctx	dir_offsets;	/* stable entry offsets */
>  	struct inode		vfs_inode;
>  };
>  
> -#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
> +#define SHMEM_FL_USER_VISIBLE		(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL)
>  #define SHMEM_FL_USER_MODIFIABLE \
> -	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
> +	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | \
> +	 FS_NOATIME_FL | FS_PROJINHERIT_FL)
>  #define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
>  
>  struct shmem_quota_limits {
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 67d93dd37a5e..6ccf60bd1690 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2539,6 +2539,12 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
>  	if (IS_ERR(inode))
>  		return inode;
>  
> +	if (dir && sb_has_quota_active(sb, PRJQUOTA))
> +		SHMEM_I(inode)->i_projid = SHMEM_I(dir)->i_projid;
> +	else
> +		SHMEM_I(inode)->i_projid = make_kprojid(&init_user_ns,
> +							SHMEM_DEF_PROJID);
> +
>  	err = dquot_initialize(inode);
>  	if (err)
>  		goto errout;
> diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
> index 062d1c1097ae..71224caa3e85 100644
> --- a/mm/shmem_quota.c
> +++ b/mm/shmem_quota.c
> @@ -325,6 +325,15 @@ static int shmem_dquot_write_info(struct super_block *sb, int type)
>  	return 0;
>  }
>  
> +static int shmem_get_projid(struct inode *inode, kprojid_t *projid)
> +{
> +	if (!sb_has_quota_active(inode->i_sb, PRJQUOTA))
> +		return -EOPNOTSUPP;

This is not needed as quota code ever calls ->get_projid only when project
quotas are enabled...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
