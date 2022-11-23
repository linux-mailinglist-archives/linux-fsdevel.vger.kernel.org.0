Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F666365F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 17:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238720AbiKWQiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 11:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiKWQh5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:37:57 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0EB49B6B
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 08:37:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 721301F85D;
        Wed, 23 Nov 2022 16:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669221466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uQZGdYhrHGc9rG/VRPsenJYGcNNe0rOSpB8CG5lntk=;
        b=p2IMXVOSEvPRwrXXczbQrE/K9aZLI/zDTbpfA2KPxmC/pBrRfkh5tn2n1fz/jeZAKFvkA1
        YrYL6DqVJXYHNHc1kJzvVEL+P6pNcdvFeqxb47NuU7fT/DcOLfkUh4hiAdIC26apeNd4UC
        jWWLxVnJ8UeB+4CH/7eMstTiy9tY2ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669221466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7uQZGdYhrHGc9rG/VRPsenJYGcNNe0rOSpB8CG5lntk=;
        b=QpJT5gvpWA4KJAu3x4ZeSKk2q/P7eoiY7drxYaRWjCqSFHfPEKNv1dRvm/2aQlnZeVTibP
        qMSjyeMGy5/v6gAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 60C9F13AE7;
        Wed, 23 Nov 2022 16:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id O/eaF1pMfmMlYwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 23 Nov 2022 16:37:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 90F34A0709; Wed, 23 Nov 2022 17:37:45 +0100 (CET)
Date:   Wed, 23 Nov 2022 17:37:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.com>,
        Eric Sandeen <sandeen@redhat.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v2 2/3] shmem: implement user/group quota support for
 tmpfs
Message-ID: <20221123163745.nnunvbl3s6th6kjx@quack3>
References: <20221121142854.91109-1-lczerner@redhat.com>
 <20221121142854.91109-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ftgguspdr4qdbjar"
Content-Disposition: inline
In-Reply-To: <20221121142854.91109-3-lczerner@redhat.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ftgguspdr4qdbjar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon 21-11-22 15:28:53, Lukas Czerner wrote:
> Implement user and group quota support for tmpfs using system quota file
> in vfsv0 quota format. Because everything in tmpfs is temporary and as a
> result is lost on umount, the quota files are initialized on every
> mount. This also goes for quota limits, that needs to be set up after
> every mount.
> 
> The quota support in tmpfs is well separated from the rest of the
> filesystem and is only enabled using mount option -o quota (and
> usrquota and grpquota for compatibility reasons). Only quota accounting
> is enabled this way, enforcement needs to be enable by regular quota
> tools (using Q_QUOTAON ioctl).
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

...

> diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
> index 0408c245785e..9c4f228ef4f3 100644
> --- a/Documentation/filesystems/tmpfs.rst
> +++ b/Documentation/filesystems/tmpfs.rst
> @@ -86,6 +86,18 @@ use up all the memory on the machine; but enhances the scalability of
>  that instance in a system with many CPUs making intensive use of it.
>  
>  
> +tmpfs also supports quota with the following mount options
> +
> +========  =============================================================
> +quota     Quota accounting is enabled on the mount. Tmpfs is using
> +          hidden system quota files that are initialized on mount.
> +          Quota limits can quota enforcement can be enabled using
                          ^^^ and?

> +          standard quota tools.
> +usrquota  Same as quota option. Exists for compatibility reasons.
> +grpquota  Same as quota option. Exists for compatibility reasons.

As we discussed with V1, I'd prefer if user & group quotas could be enabled
/ disabled independently. Mostly to not differ from other filesystems
unnecessarily.

> +========  =============================================================
> +
> +
>  tmpfs has a mount option to set the NUMA memory allocation policy for
>  all files in that instance (if CONFIG_NUMA is enabled) - which can be
>  adjusted on the fly via 'mount -o remount ...'
> diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
> index f1a7a03632a2..007604e7eb09 100644
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -716,11 +716,11 @@ int dquot_quota_sync(struct super_block *sb, int type)
>  	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
>  		if (type != -1 && cnt != type)
>  			continue;
> -		if (!sb_has_quota_active(sb, cnt))
> -			continue;
> -		inode_lock(dqopt->files[cnt]);
> -		truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
> -		inode_unlock(dqopt->files[cnt]);
> +		if (sb_has_quota_active(sb, cnt) && dqopt->files[cnt]) {
> +			inode_lock(dqopt->files[cnt]);
> +			truncate_inode_pages(&dqopt->files[cnt]->i_data, 0);
> +			inode_unlock(dqopt->files[cnt]);
> +		}
>  	}

No need to mess with this when you have DQUOT_QUOTA_SYS_FILE set.

> +/*
> + * We don't have any quota files to read, or write to/from, but quota code
> + * requires .quota_read and .quota_write to exist.
> + */
> +static ssize_t shmem_quota_write(struct super_block *sb, int type,
> +				const char *data, size_t len, loff_t off)
> +{
> +	return len;
> +}
> +
> +static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
> +			       size_t len, loff_t off)
> +{
> +	return len;
> +}

Instead of these functions I'd go for attached patch.

> @@ -363,7 +438,7 @@ bool shmem_charge(struct inode *inode, long pages)
>  	struct shmem_inode_info *info = SHMEM_I(inode);
>  	unsigned long flags;
>  
> -	if (!shmem_inode_acct_block(inode, pages))
> +	if (shmem_inode_acct_block(inode, pages))
>  		return false;

As Brian asked, I'd prefer to have the calling convention change as a
separate patch.

> +static struct inode *shmem_get_inode(struct super_block *sb, struct inode *dir,
> +				     umode_t mode, dev_t dev, unsigned long flags)
> +{
> +	int err;
> +	struct inode *inode;
> +
> +	inode = shmem_get_inode_noquota(sb, dir, mode, dev, flags);
> +	if (inode) {
> +		err = dquot_initialize(inode);
> +		if (err)
> +			goto errout;
> +
> +		err = dquot_alloc_inode(inode);
> +		if (err) {
> +			dquot_drop(inode);
> +			goto errout;
> +		}
> +	}
> +	return inode;

I'd rather make shmem_get_inode() always return ERR_PTR or inode pointer.
It's more natural convention. Also this calling convention change should
go into a separate patch.

> +
> +errout:
> +	inode->i_flags |= S_NOQUOTA;
> +	iput(inode);
> +	shmem_free_inode(sb);
> +	if (err)
> +		return ERR_PTR(err);
> +	return NULL;
> +}
> +
...

> @@ -4196,8 +4348,10 @@ static struct file *__shmem_file_setup(struct vfsmount *mnt, const char *name, l
>  
>  	inode = shmem_get_inode(mnt->mnt_sb, NULL, S_IFREG | S_IRWXUGO, 0,
>  				flags);
> -	if (unlikely(!inode)) {
> +	if (IS_ERR_OR_NULL(inode)) {
>  		shmem_unacct_size(flags, size);
> +		if (IS_ERR(inode))
> +			return (struct file *)inode;
				^^ Uhuh. ERR_CAST()?

>  		return ERR_PTR(-ENOSPC);
>  	}
>  	inode->i_flags |= i_flags;


								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--ftgguspdr4qdbjar
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-quota-Check-presence-of-quota-operation-structures-i.patch"

From 4aaf5084147c4d8fe1a0805f2a85c0a60e18a4fe Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Wed, 23 Nov 2022 16:28:12 +0100
Subject: [PATCH] quota: Check presence of quota operation structures instead
 of ->quota_read and ->quota_write callbacks

Currently we check whether superblock has ->quota_read and ->quota_write
operations to check whether filesystem supports quotas. However for
example for shmfs we will not read or write dquots so check whether
quota operations are set in the superblock instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/quota/dquot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 0427b44bfee5..2c0fae111920 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2365,7 +2365,7 @@ int dquot_load_quota_sb(struct super_block *sb, int type, int format_id,
 
 	if (!fmt)
 		return -ESRCH;
-	if (!sb->s_op->quota_write || !sb->s_op->quota_read ||
+	if (!sb->dq_op || !sb->s_qcop ||
 	    (type == PRJQUOTA && sb->dq_op->get_projid == NULL)) {
 		error = -EINVAL;
 		goto out_fmt;
-- 
2.35.3


--ftgguspdr4qdbjar--
