Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A576E743
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 13:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235648AbjHCLrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 07:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjHCLrA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:47:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48B430C0;
        Thu,  3 Aug 2023 04:46:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5113A1F747;
        Thu,  3 Aug 2023 11:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1691063212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZRATTl9ze2dbUUVR6EVaJqJOlEgsHbOiGIMflJWuqI0=;
        b=h+EOnXJZ1jQZw9KNznDfrtEVfnT0I2iXG3/4HvbXo1yozv3rIJ+Wdq9MEXs36iEvzouiwa
        Qa8ClVd3Mwj47ujqwbT/HakaB10E6VKYHQZyrhi2fOcf6kBVnzu7m3kX6pRQr2zwBP0jIi
        nGT1wBjrem2o26HsmwfVoHsRyMvqQbg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1691063212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZRATTl9ze2dbUUVR6EVaJqJOlEgsHbOiGIMflJWuqI0=;
        b=qfBkEeurvDJwpRK/HkPdKdpHXcX207g6s3ATzE+1nJ8sM1f44b6FY6WolKFsTJ/M5qyHi4
        gkmsb6FWy8DyysCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A1D01333C;
        Thu,  3 Aug 2023 11:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ymsfDqyTy2QOPAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 03 Aug 2023 11:46:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B5F2AA076B; Thu,  3 Aug 2023 13:46:51 +0200 (CEST)
Date:   Thu, 3 Aug 2023 13:46:51 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH 02/12] nilfs2: use setup_bdev_super to de-duplicate the
 mount code
Message-ID: <20230803114651.ihtqqgthbdjjgxev@quack3>
References: <20230802154131.2221419-1-hch@lst.de>
 <20230802154131.2221419-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802154131.2221419-3-hch@lst.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed 02-08-23 17:41:21, Christoph Hellwig wrote:
> Use the generic setup_bdev_super helper to open the main block device
> and do various bits of superblock setup instead of duplicating the
> logic.  This includes moving to the new scheme implemented in common
> code that only opens the block device after the superblock has allocated.
> 
> It does not yet convert nilfs2 to the new mount API, but doing so will
> become a bit simpler after this first step.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

AFAICS nilfs2 could *almost* use mount_bdev() directly and then just do its
snapshot thing after mount_bdev() returns. But it has this weird logic
that: "if the superblock is already mounted but we can shrink the whole
dcache, then do remount instead of ignoring mount options". Firstly, this
looks racy - what prevents someone from say opening a file on the sb just
after nilfs_tree_is_busy() shrinks dcache? Secondly, it is inconsistent
with any other filesystem so it's going to surprise sysadmins not
intimately knowing nilfs2. Thirdly, from userspace you cannot tell what
your mount call is going to do. Last but not least, what is it really good
for? Ryusuke, can you explain please?

								Honza

> ---
>  fs/nilfs2/super.c | 81 ++++++++++++++++++-----------------------------
>  1 file changed, 30 insertions(+), 51 deletions(-)
> 
> diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
> index 0ef8c71bde8e5f..a5d1fa4e7552f6 100644
> --- a/fs/nilfs2/super.c
> +++ b/fs/nilfs2/super.c
> @@ -35,6 +35,7 @@
>  #include <linux/writeback.h>
>  #include <linux/seq_file.h>
>  #include <linux/mount.h>
> +#include <linux/fs_context.h>
>  #include "nilfs.h"
>  #include "export.h"
>  #include "mdt.h"
> @@ -1216,7 +1217,6 @@ static int nilfs_remount(struct super_block *sb, int *flags, char *data)
>  }
>  
>  struct nilfs_super_data {
> -	struct block_device *bdev;
>  	__u64 cno;
>  	int flags;
>  };
> @@ -1283,64 +1283,49 @@ static int nilfs_identify(char *data, struct nilfs_super_data *sd)
>  
>  static int nilfs_set_bdev_super(struct super_block *s, void *data)
>  {
> -	s->s_bdev = data;
> -	s->s_dev = s->s_bdev->bd_dev;
> +	s->s_dev = *(dev_t *)data;
>  	return 0;
>  }
>  
>  static int nilfs_test_bdev_super(struct super_block *s, void *data)
>  {
> -	return (void *)s->s_bdev == data;
> +	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
>  }
>  
>  static struct dentry *
>  nilfs_mount(struct file_system_type *fs_type, int flags,
>  	     const char *dev_name, void *data)
>  {
> -	struct nilfs_super_data sd;
> +	struct nilfs_super_data sd = { .flags = flags };
>  	struct super_block *s;
> -	struct dentry *root_dentry;
> -	int err, s_new = false;
> +	dev_t dev;
> +	int err;
>  
> -	sd.bdev = blkdev_get_by_path(dev_name, sb_open_mode(flags), fs_type,
> -				     NULL);
> -	if (IS_ERR(sd.bdev))
> -		return ERR_CAST(sd.bdev);
> +	if (nilfs_identify(data, &sd))
> +		return ERR_PTR(-EINVAL);
>  
> -	sd.cno = 0;
> -	sd.flags = flags;
> -	if (nilfs_identify((char *)data, &sd)) {
> -		err = -EINVAL;
> -		goto failed;
> -	}
> +	err = lookup_bdev(dev_name, &dev);
> +	if (err)
> +		return ERR_PTR(err);
>  
> -	/*
> -	 * once the super is inserted into the list by sget, s_umount
> -	 * will protect the lockfs code from trying to start a snapshot
> -	 * while we are mounting
> -	 */
> -	mutex_lock(&sd.bdev->bd_fsfreeze_mutex);
> -	if (sd.bdev->bd_fsfreeze_count > 0) {
> -		mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
> -		err = -EBUSY;
> -		goto failed;
> -	}
>  	s = sget(fs_type, nilfs_test_bdev_super, nilfs_set_bdev_super, flags,
> -		 sd.bdev);
> -	mutex_unlock(&sd.bdev->bd_fsfreeze_mutex);
> -	if (IS_ERR(s)) {
> -		err = PTR_ERR(s);
> -		goto failed;
> -	}
> +		 &dev);
> +	if (IS_ERR(s))
> +		return ERR_CAST(s);
>  
>  	if (!s->s_root) {
> -		s_new = true;
> -
> -		/* New superblock instance created */
> -		snprintf(s->s_id, sizeof(s->s_id), "%pg", sd.bdev);
> -		sb_set_blocksize(s, block_size(sd.bdev));
> -
> -		err = nilfs_fill_super(s, data, flags & SB_SILENT ? 1 : 0);
> +		/*
> +		 * We drop s_umount here because we need to open the bdev and
> +		 * bdev->open_mutex ranks above s_umount (blkdev_put() ->
> +		 * __invalidate_device()). It is safe because we have active sb
> +		 * reference and SB_BORN is not set yet.
> +		 */
> +		up_write(&s->s_umount);
> +		err = setup_bdev_super(s, flags, NULL);
> +		down_write(&s->s_umount);
> +		if (!err)
> +			err = nilfs_fill_super(s, data,
> +					       flags & SB_SILENT ? 1 : 0);
>  		if (err)
>  			goto failed_super;
>  
> @@ -1366,24 +1351,18 @@ nilfs_mount(struct file_system_type *fs_type, int flags,
>  	}
>  
>  	if (sd.cno) {
> +		struct dentry *root_dentry;
> +
>  		err = nilfs_attach_snapshot(s, sd.cno, &root_dentry);
>  		if (err)
>  			goto failed_super;
> -	} else {
> -		root_dentry = dget(s->s_root);
> +		return root_dentry;
>  	}
>  
> -	if (!s_new)
> -		blkdev_put(sd.bdev, fs_type);
> -
> -	return root_dentry;
> +	return dget(s->s_root);
>  
>   failed_super:
>  	deactivate_locked_super(s);
> -
> - failed:
> -	if (!s_new)
> -		blkdev_put(sd.bdev, fs_type);
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
