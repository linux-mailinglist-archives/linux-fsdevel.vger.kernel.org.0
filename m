Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49F3B749B61
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 14:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjGFMIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbjGFMIT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:08:19 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8961199F;
        Thu,  6 Jul 2023 05:08:17 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QxZxN23rRzPjxy;
        Thu,  6 Jul 2023 20:06:00 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 20:08:13 +0800
Subject: Re: [PATCH v2 10/92] ubifs: convert to simple_rename_timestamp
To:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Richard Weinberger <richard@nod.at>
CC:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
 <20230705190309.579783-8-jlayton@kernel.org>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <7ceadd6a-a19a-5ba0-fab4-ff79d90c8c77@huawei.com>
Date:   Thu, 6 Jul 2023 20:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230705190309.579783-8-jlayton@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ÔÚ 2023/7/6 3:00, Jeff Layton Ð´µÀ:
> A rename potentially involves updating 4 different inode timestamps.
> Convert to the new simple_rename_timestamp helper function.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ubifs/dir.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>

> diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
> index ef0499edc248..7ec25310bd8a 100644
> --- a/fs/ubifs/dir.c
> +++ b/fs/ubifs/dir.c
> @@ -1414,8 +1414,7 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>   	 * Like most other Unix systems, set the @i_ctime for inodes on a
>   	 * rename.
>   	 */
> -	time = current_time(old_dir);
> -	old_inode->i_ctime = time;
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>   
>   	/* We must adjust parent link count when renaming directories */
>   	if (is_dir) {
> @@ -1444,13 +1443,11 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>   
>   	old_dir->i_size -= old_sz;
>   	ubifs_inode(old_dir)->ui_size = old_dir->i_size;
> -	old_dir->i_mtime = old_dir->i_ctime = time;
> -	new_dir->i_mtime = new_dir->i_ctime = time;
>   
>   	/*
>   	 * And finally, if we unlinked a direntry which happened to have the
>   	 * same name as the moved direntry, we have to decrement @i_nlink of
> -	 * the unlinked inode and change its ctime.
> +	 * the unlinked inode.
>   	 */
>   	if (unlink) {
>   		/*
> @@ -1462,7 +1459,6 @@ static int do_rename(struct inode *old_dir, struct dentry *old_dentry,
>   			clear_nlink(new_inode);
>   		else
>   			drop_nlink(new_inode);
> -		new_inode->i_ctime = time;
>   	} else {
>   		new_dir->i_size += new_sz;
>   		ubifs_inode(new_dir)->ui_size = new_dir->i_size;
> @@ -1557,7 +1553,6 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>   	int sync = IS_DIRSYNC(old_dir) || IS_DIRSYNC(new_dir);
>   	struct inode *fst_inode = d_inode(old_dentry);
>   	struct inode *snd_inode = d_inode(new_dentry);
> -	struct timespec64 time;
>   	int err;
>   	struct fscrypt_name fst_nm, snd_nm;
>   
> @@ -1588,11 +1583,7 @@ static int ubifs_xrename(struct inode *old_dir, struct dentry *old_dentry,
>   
>   	lock_4_inodes(old_dir, new_dir, NULL, NULL);
>   
> -	time = current_time(old_dir);
> -	fst_inode->i_ctime = time;
> -	snd_inode->i_ctime = time;
> -	old_dir->i_mtime = old_dir->i_ctime = time;
> -	new_dir->i_mtime = new_dir->i_ctime = time;
> +	simple_rename_timestamp(old_dir, old_dentry, new_dir, new_dentry);
>   
>   	if (old_dir != new_dir) {
>   		if (S_ISDIR(fst_inode->i_mode) && !S_ISDIR(snd_inode->i_mode)) {
> 

