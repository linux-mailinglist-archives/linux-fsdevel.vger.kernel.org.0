Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8EDD73E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbfJOKvA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 06:51:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbfJOKu7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19566B4B3;
        Tue, 15 Oct 2019 10:50:57 +0000 (UTC)
Date:   Tue, 15 Oct 2019 12:50:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Piotr Sarna <p.sarna@tlen.pl>
Cc:     linux-kernel@vger.kernel.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] hugetlbfs: add O_TMPFILE support
Message-ID: <20191015105055.GA24932@dhcp22.suse.cz>
References: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c29acf9c51dae17802e1b05c9e5e4051448c5c.1571129593.git.p.sarna@tlen.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 15-10-19 11:01:12, Piotr Sarna wrote:
> With hugetlbfs, a common pattern for mapping anonymous huge pages
> is to create a temporary file first.

Really? I though that this is normally done by shmget(SHM_HUGETLB) or
mmap(MAP_HUGETLB). Or maybe I misunderstood your definition on anonymous
huge pages.

> Currently libraries like
> libhugetlbfs and seastar create these with a standard mkstemp+unlink
> trick, but it would be more robust to be able to simply pass
> the O_TMPFILE flag to open(). O_TMPFILE is already supported by several
> file systems like ext4 and xfs. The implementation simply uses the existing
> d_tmpfile utility function to instantiate the dcache entry for the file.
> 
> Tested manually by successfully creating a temporary file by opening
> it with (O_TMPFILE|O_RDWR) on mounted hugetlbfs and successfully
> mapping 2M huge pages with it. Without the patch, trying to open
> a file with O_TMPFILE results in -ENOSUP.
> 
> Signed-off-by: Piotr Sarna <p.sarna@tlen.pl>
> ---
>  fs/hugetlbfs/inode.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 1dcc57189382..277b7d231db8 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -815,8 +815,11 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
>  /*
>   * File creation. Allocate an inode, and we're done..
>   */
> -static int hugetlbfs_mknod(struct inode *dir,
> -			struct dentry *dentry, umode_t mode, dev_t dev)
> +static int do_hugetlbfs_mknod(struct inode *dir,
> +			struct dentry *dentry,
> +			umode_t mode,
> +			dev_t dev,
> +			bool tmpfile)
>  {
>  	struct inode *inode;
>  	int error = -ENOSPC;
> @@ -824,13 +827,22 @@ static int hugetlbfs_mknod(struct inode *dir,
>  	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
>  	if (inode) {
>  		dir->i_ctime = dir->i_mtime = current_time(dir);
> -		d_instantiate(dentry, inode);
> +		if (tmpfile)
> +			d_tmpfile(dentry, inode);
> +		else
> +			d_instantiate(dentry, inode);
>  		dget(dentry);	/* Extra count - pin the dentry in core */
>  		error = 0;
>  	}
>  	return error;
>  }
>  
> +static int hugetlbfs_mknod(struct inode *dir,
> +			struct dentry *dentry, umode_t mode, dev_t dev)
> +{
> +	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
> +}
> +
>  static int hugetlbfs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
>  {
>  	int retval = hugetlbfs_mknod(dir, dentry, mode | S_IFDIR, 0);
> @@ -844,6 +856,12 @@ static int hugetlbfs_create(struct inode *dir, struct dentry *dentry, umode_t mo
>  	return hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0);
>  }
>  
> +static int hugetlbfs_tmpfile(struct inode *dir,
> +			struct dentry *dentry, umode_t mode)
> +{
> +	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
> +}
> +
>  static int hugetlbfs_symlink(struct inode *dir,
>  			struct dentry *dentry, const char *symname)
>  {
> @@ -1102,6 +1120,7 @@ static const struct inode_operations hugetlbfs_dir_inode_operations = {
>  	.mknod		= hugetlbfs_mknod,
>  	.rename		= simple_rename,
>  	.setattr	= hugetlbfs_setattr,
> +	.tmpfile	= hugetlbfs_tmpfile,
>  };
>  
>  static const struct inode_operations hugetlbfs_inode_operations = {
> -- 
> 2.21.0
> 

-- 
Michal Hocko
SUSE Labs
