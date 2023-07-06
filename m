Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1A749B5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGFMIL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjGFMIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:08:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB528172B;
        Thu,  6 Jul 2023 05:08:08 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4QxZzF1XZpz1HCjV;
        Thu,  6 Jul 2023 20:07:37 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 20:07:53 +0800
Subject: Re: [PATCH v2 78/92] ubifs: convert to ctime accessor functions
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-76-jlayton@kernel.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <13131dc7-c823-e65f-9bf0-4f8fe907e58b@huawei.com>
Date:   Thu, 6 Jul 2023 20:07:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230705190309.579783-76-jlayton@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2023/7/6 3:01, Jeff Layton Ð´µÀ:
> In later patches, we're going to change how the inode's ctime field is
> used. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ubifs/debug.c   |  4 ++--
>   fs/ubifs/dir.c     | 24 +++++++++++-------------
>   fs/ubifs/file.c    | 16 +++++++++-------
>   fs/ubifs/ioctl.c   |  2 +-
>   fs/ubifs/journal.c |  4 ++--
>   fs/ubifs/super.c   |  4 ++--
>   fs/ubifs/xattr.c   |  6 +++---
>   7 files changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
> index 9c9d3f0e36a4..eef9e527d9ff 100644
> --- a/fs/ubifs/debug.c
> +++ b/fs/ubifs/debug.c
> @@ -243,8 +243,8 @@ void ubifs_dump_inode(struct ubifs_info *c, const struct inode *inode)
>   	       (unsigned int)inode->i_mtime.tv_sec,
>   	       (unsigned int)inode->i_mtime.tv_nsec);
>   	pr_err("\tctime          %u.%u\n",
> -	       (unsigned int)inode->i_ctime.tv_sec,
> -	       (unsigned int)inode->i_ctime.tv_nsec);
> +	       (unsigned int) inode_get_ctime(inode).tv_sec,
> +	       (unsigned int) inode_get_ctime(inode).tv_nsec);
>   	pr_err("\tcreat_sqnum    %llu\n", ui->creat_sqnum);
>   	pr_err("\txattr_size     %u\n", ui->xattr_size);
>   	pr_err("\txattr_cnt      %u\n", ui->xattr_cnt);
> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index 7ec25310bd8a..3a1ba8ba308a 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -96,8 +96,7 @@ struct inode *ubifs_new_inode(struct ubifs_info *c, struct inode *dir,
>   	inode->i_flags |= S_NOCMTIME;
>   
>   	inode_init_owner(&nop_mnt_idmap, inode, dir, mode);
> -	inode->i_mtime = inode->i_atime = inode->i_ctime =
> -			 current_time(inode);
> +	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
>   	inode->i_mapping->nrpages = 0;
>   
>   	if (!is_xattr) {
> @@ -325,7 +324,7 @@ static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
>   	mutex_lock(&dir_ui->ui_mutex);
>   	dir->i_size += sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -765,10 +764,10 @@ static int ubifs_link(struct dentry *old_dentry, struct inode *dir,
>   
>   	inc_nlink(inode);
>   	ihold(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>   	dir->i_size += sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -838,11 +837,11 @@ static int ubifs_unlink(struct inode *dir, struct dentry *dentry)
>   	}
>   
>   	lock_2_inodes(dir, inode);
> -	inode->i_ctime = current_time(dir);
> +	inode_set_ctime_current(inode);
>   	drop_nlink(inode);
>   	dir->i_size -= sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -940,12 +939,12 @@ static int ubifs_rmdir(struct inode *dir, struct dentry *dentry)
>   	}
>   
>   	lock_2_inodes(dir, inode);
> -	inode->i_ctime = current_time(dir);
> +	inode_set_ctime_current(inode);
>   	clear_nlink(inode);
>   	drop_nlink(dir);
>   	dir->i_size -= sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 1, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -1019,7 +1018,7 @@ static int ubifs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>   	inc_nlink(dir);
>   	dir->i_size += sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>   	if (err) {
>   		ubifs_err(c, "cannot create directory, error %d", err);
> @@ -1110,7 +1109,7 @@ static int ubifs_mknod(struct mnt_idmap *idmap, struct inode *dir,
>   	mutex_lock(&dir_ui->ui_mutex);
>   	dir->i_size += sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -1210,7 +1209,7 @@ static int ubifs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   	mutex_lock(&dir_ui->ui_mutex);
>   	dir->i_size += sz_change;
>   	dir_ui->ui_size = dir->i_size;
> -	dir->i_mtime = dir->i_ctime = inode->i_ctime;
> +	dir->i_mtime = inode_set_ctime_to_ts(dir, inode_get_ctime(inode));
>   	err = ubifs_jnl_update(c, dir, &nm, inode, 0, 0);
>   	if (err)
>   		goto out_cancel;
> @@ -1298,7 +1297,6 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	struct ubifs_budget_req ino_req = { .dirtied_ino = 1,
>   			.dirtied_ino_d = ALIGN(old_inode_ui->data_len, 8) };
>   	struct ubifs_budget_req wht_req;
> -	struct timespec64 time;
>   	unsigned int saved_nlink;
>   	struct fscrypt_name old_nm, new_nm;
>   

It would be better to put the change of do_rename in '[PATCH v2 10/92] 
ubifs: convert to simple_rename_timestamp'.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
> index 6738fe43040b..436b27d7c58f 100644
> --- a/fs/ubifs/file.c
> +++ b/fs/ubifs/file.c
> @@ -1092,7 +1092,7 @@ static void do_attr_changes(struct inode *inode, const struct iattr *attr)
>   	if (attr->ia_valid & ATTR_MTIME)
>   		inode->i_mtime = attr->ia_mtime;
>   	if (attr->ia_valid & ATTR_CTIME)
> -		inode->i_ctime = attr->ia_ctime;
> +		inode_set_ctime_to_ts(inode, attr->ia_ctime);
>   	if (attr->ia_valid & ATTR_MODE) {
>   		umode_t mode = attr->ia_mode;
>   
> @@ -1192,7 +1192,7 @@ static int do_truncation(struct ubifs_info *c, struct inode *inode,
>   	mutex_lock(&ui->ui_mutex);
>   	ui->ui_size = inode->i_size;
>   	/* Truncation changes inode [mc]time */
> -	inode->i_mtime = inode->i_ctime = current_time(inode);
> +	inode->i_mtime = inode_set_ctime_current(inode);
>   	/* Other attributes may be changed at the same time as well */
>   	do_attr_changes(inode, attr);
>   	err = ubifs_jnl_truncate(c, inode, old_size, new_size);
> @@ -1239,7 +1239,7 @@ static int do_setattr(struct ubifs_info *c, struct inode *inode,
>   	mutex_lock(&ui->ui_mutex);
>   	if (attr->ia_valid & ATTR_SIZE) {
>   		/* Truncation changes inode [mc]time */
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>   		/* 'truncate_setsize()' changed @i_size, update @ui_size */
>   		ui->ui_size = inode->i_size;
>   	}
> @@ -1364,8 +1364,10 @@ int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)
>   static inline int mctime_update_needed(const struct inode *inode,
>   				       const struct timespec64 *now)
>   {
> +	struct timespec64 ctime = inode_get_ctime(inode);
> +
>   	if (!timespec64_equal(&inode->i_mtime, now) ||
> -	    !timespec64_equal(&inode->i_ctime, now))
> +	    !timespec64_equal(&ctime, now))
>   		return 1;
>   	return 0;
>   }
> @@ -1396,7 +1398,7 @@ int ubifs_update_time(struct inode *inode, struct timespec64 *time,
>   	if (flags & S_ATIME)
>   		inode->i_atime = *time;
>   	if (flags & S_CTIME)
> -		inode->i_ctime = *time;
> +		inode_set_ctime_to_ts(inode, *time);
>   	if (flags & S_MTIME)
>   		inode->i_mtime = *time;
>   
> @@ -1432,7 +1434,7 @@ static int update_mctime(struct inode *inode)
>   			return err;
>   
>   		mutex_lock(&ui->ui_mutex);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>   		release = ui->dirty;
>   		mark_inode_dirty_sync(inode);
>   		mutex_unlock(&ui->ui_mutex);
> @@ -1570,7 +1572,7 @@ static vm_fault_t ubifs_vm_page_mkwrite(struct vm_fault *vmf)
>   		struct ubifs_inode *ui = ubifs_inode(inode);
>   
>   		mutex_lock(&ui->ui_mutex);
> -		inode->i_mtime = inode->i_ctime = current_time(inode);
> +		inode->i_mtime = inode_set_ctime_current(inode);
>   		release = ui->dirty;
>   		mark_inode_dirty_sync(inode);
>   		mutex_unlock(&ui->ui_mutex);
> diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
> index 67c5108abd89..d79cabe193c3 100644
> --- a/fs/ubifs/ioctl.c
> +++ b/fs/ubifs/ioctl.c
> @@ -118,7 +118,7 @@ static int setflags(struct inode *inode, int flags)
>   	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
>   	ui->flags |= ioctl2ubifs(flags);
>   	ubifs_set_inode_flags(inode);
> -	inode->i_ctime = current_time(inode);
> +	inode_set_ctime_current(inode);
>   	release = ui->dirty;
>   	mark_inode_dirty_sync(inode);
>   	mutex_unlock(&ui->ui_mutex);
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index dc52ac0f4a34..ffc9beee7be6 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -454,8 +454,8 @@ static void pack_inode(struct ubifs_info *c, struct ubifs_ino_node *ino,
>   	ino->creat_sqnum = cpu_to_le64(ui->creat_sqnum);
>   	ino->atime_sec  = cpu_to_le64(inode->i_atime.tv_sec);
>   	ino->atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
> -	ino->ctime_sec  = cpu_to_le64(inode->i_ctime.tv_sec);
> -	ino->ctime_nsec = cpu_to_le32(inode->i_ctime.tv_nsec);
> +	ino->ctime_sec  = cpu_to_le64(inode_get_ctime(inode).tv_sec);
> +	ino->ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
>   	ino->mtime_sec  = cpu_to_le64(inode->i_mtime.tv_sec);
>   	ino->mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
>   	ino->uid   = cpu_to_le32(i_uid_read(inode));
> diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
> index 32cb14759796..b08fb28d16b5 100644
> --- a/fs/ubifs/super.c
> +++ b/fs/ubifs/super.c
> @@ -146,8 +146,8 @@ struct inode *ubifs_iget(struct super_block *sb, unsigned long inum)
>   	inode->i_atime.tv_nsec = le32_to_cpu(ino->atime_nsec);
>   	inode->i_mtime.tv_sec  = (int64_t)le64_to_cpu(ino->mtime_sec);
>   	inode->i_mtime.tv_nsec = le32_to_cpu(ino->mtime_nsec);
> -	inode->i_ctime.tv_sec  = (int64_t)le64_to_cpu(ino->ctime_sec);
> -	inode->i_ctime.tv_nsec = le32_to_cpu(ino->ctime_nsec);
> +	inode_set_ctime(inode, (int64_t)le64_to_cpu(ino->ctime_sec),
> +			le32_to_cpu(ino->ctime_nsec));
>   	inode->i_mode = le32_to_cpu(ino->mode);
>   	inode->i_size = le64_to_cpu(ino->size);
>   
> diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
> index 349228dd1191..406c82eab513 100644
> --- a/fs/ubifs/xattr.c
> +++ b/fs/ubifs/xattr.c
> @@ -134,7 +134,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
>   	ui->data_len = size;
>   
>   	mutex_lock(&host_ui->ui_mutex);
> -	host->i_ctime = current_time(host);
> +	inode_set_ctime_current(host);
>   	host_ui->xattr_cnt += 1;
>   	host_ui->xattr_size += CALC_DENT_SIZE(fname_len(nm));
>   	host_ui->xattr_size += CALC_XATTR_BYTES(size);
> @@ -215,7 +215,7 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
>   	ui->data_len = size;
>   
>   	mutex_lock(&host_ui->ui_mutex);
> -	host->i_ctime = current_time(host);
> +	inode_set_ctime_current(host);
>   	host_ui->xattr_size -= CALC_XATTR_BYTES(old_size);
>   	host_ui->xattr_size += CALC_XATTR_BYTES(size);
>   
> @@ -474,7 +474,7 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
>   		return err;
>   
>   	mutex_lock(&host_ui->ui_mutex);
> -	host->i_ctime = current_time(host);
> +	inode_set_ctime_current(host);
>   	host_ui->xattr_cnt -= 1;
>   	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
>   	host_ui->xattr_size -= CALC_XATTR_BYTES(ui->data_len);
> 

