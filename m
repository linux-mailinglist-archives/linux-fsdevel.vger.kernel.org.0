Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242E77C69F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 17:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfGaPbj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 11:31:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:37310 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGaPbi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 11:31:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VF8ggp167637;
        Wed, 31 Jul 2019 15:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=e//p2MeonEpNRd3oew+L/RI5f1yyX9Uye2F9qPC3fxo=;
 b=SJCgVT+05ciRAoA/gSCHXMfxdCLFnhl8qjVh90DOPzm1mguk3Q8SSTQgI3dKu0cZpbWn
 zYmqtERsA/qiUgG0xrMjP5PJz+tveGesCAD7BjOCBVFeXYdy9ssM+y6VDbPm/vY++yuu
 YtB0fL4/DCN+jLinaLi3hdPDML9GS1p1HDSXkBpIM1OCDn6vNddvPbvX2pD3IDUj/UAJ
 +m3CXc4pxA86xCiTMzYcl+aAxnrDSoGM9kqYX9nPE8nroqK/gAHdssaqyVW9r8zDGJ7h
 thAaDEOUE+KEn6v+AmOecuxAX026po7pz8x6zNbawgSJVE1tBbhOv581HIQe+2QPqdnA qQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1tx735-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:28:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6VFRiIc127699;
        Wed, 31 Jul 2019 15:28:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u38fb5f53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 15:28:39 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6VFSWe5001806;
        Wed, 31 Jul 2019 15:28:32 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 31 Jul 2019 08:28:31 -0700
Date:   Wed, 31 Jul 2019 08:28:29 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, arnd@arndb.de,
        y2038@lists.linaro.org, aivazian.tigran@gmail.com, al@alarsen.net,
        coda@cs.cmu.edu, dushistov@mail.ru, dwmw2@infradead.org,
        hch@infradead.org, jack@suse.com, jaharkes@cs.cmu.edu,
        luisbg@kernel.org, nico@fluxnic.net, phillip@squashfs.org.uk,
        richard@nod.at, salah.triki@gmail.com, shaggy@kernel.org,
        linux-xfs@vger.kernel.org, codalist@telemann.coda.cs.cmu.edu,
        linux-ext4@vger.kernel.org, linux-mtd@lists.infradead.org,
        jfs-discussion@lists.sourceforge.net,
        reiserfs-devel@vger.kernel.org
Subject: Re: [PATCH 06/20] fs: Fill in max and min timestamps in superblock
Message-ID: <20190731152829.GS1561054@magnolia>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
 <20190730014924.2193-7-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730014924.2193-7-deepa.kernel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=18 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907310157
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9335 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907310156
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 29, 2019 at 06:49:10PM -0700, Deepa Dinamani wrote:
> Fill in the appropriate limits to avoid inconsistencies
> in the vfs cached inode times when timestamps are
> outside the permitted range.
> 
> Even though some filesystems are read-only, fill in the
> timestamps to reflect the on-disk representation.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: aivazian.tigran@gmail.com
> Cc: al@alarsen.net
> Cc: coda@cs.cmu.edu
> Cc: darrick.wong@oracle.com
> Cc: dushistov@mail.ru
> Cc: dwmw2@infradead.org
> Cc: hch@infradead.org
> Cc: jack@suse.com
> Cc: jaharkes@cs.cmu.edu
> Cc: luisbg@kernel.org
> Cc: nico@fluxnic.net
> Cc: phillip@squashfs.org.uk
> Cc: richard@nod.at
> Cc: salah.triki@gmail.com
> Cc: shaggy@kernel.org
> Cc: linux-xfs@vger.kernel.org
> Cc: codalist@coda.cs.cmu.edu
> Cc: linux-ext4@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org
> Cc: jfs-discussion@lists.sourceforge.net
> Cc: reiserfs-devel@vger.kernel.org
> ---
>  fs/befs/linuxvfs.c       | 2 ++
>  fs/bfs/inode.c           | 2 ++
>  fs/coda/inode.c          | 3 +++
>  fs/cramfs/inode.c        | 2 ++
>  fs/efs/super.c           | 2 ++
>  fs/ext2/super.c          | 2 ++
>  fs/freevxfs/vxfs_super.c | 2 ++
>  fs/jffs2/fs.c            | 3 +++
>  fs/jfs/super.c           | 2 ++
>  fs/minix/inode.c         | 2 ++
>  fs/qnx4/inode.c          | 2 ++
>  fs/qnx6/inode.c          | 2 ++
>  fs/reiserfs/super.c      | 3 +++
>  fs/romfs/super.c         | 2 ++
>  fs/squashfs/super.c      | 2 ++
>  fs/ufs/super.c           | 7 +++++++
>  fs/xfs/xfs_super.c       | 2 ++
>  17 files changed, 42 insertions(+)
> 
> diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
> index 462d096ff3e9..64cdf4d8e424 100644
> --- a/fs/befs/linuxvfs.c
> +++ b/fs/befs/linuxvfs.c
> @@ -893,6 +893,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
>  	sb->s_op = &befs_sops;
>  	sb->s_export_op = &befs_export_operations;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = 0xffffffffffffll;
>  	root = befs_iget(sb, iaddr2blockno(sb, &(befs_sb->root_dir)));
>  	if (IS_ERR(root)) {
>  		ret = PTR_ERR(root);
> diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
> index 5e97bed073d7..f8ce1368218b 100644
> --- a/fs/bfs/inode.c
> +++ b/fs/bfs/inode.c
> @@ -324,6 +324,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
>  		return -ENOMEM;
>  	mutex_init(&info->bfs_lock);
>  	s->s_fs_info = info;
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
>  
>  	sb_set_blocksize(s, BFS_BSIZE);
>  
> diff --git a/fs/coda/inode.c b/fs/coda/inode.c
> index 321f56e487cb..b1c70e2b9b1e 100644
> --- a/fs/coda/inode.c
> +++ b/fs/coda/inode.c
> @@ -188,6 +188,9 @@ static int coda_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_magic = CODA_SUPER_MAGIC;
>  	sb->s_op = &coda_super_operations;
>  	sb->s_d_op = &coda_dentry_operations;
> +	sb->s_time_gran = 1;
> +	sb->s_time_min = S64_MIN;
> +	sb->s_time_max = S64_MAX;
>  
>  	error = super_setup_bdi(sb);
>  	if (error)
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 9352487bd0fc..4d1d8b7761ed 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -597,6 +597,8 @@ static int cramfs_finalize_super(struct super_block *sb,
>  
>  	/* Set it all up.. */
>  	sb->s_flags |= SB_RDONLY;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = 0;
>  	sb->s_op = &cramfs_ops;
>  	root = get_cramfs_inode(sb, cramfs_root, 0);
>  	if (IS_ERR(root))
> diff --git a/fs/efs/super.c b/fs/efs/super.c
> index 867fc24dee20..4a6ebff2af76 100644
> --- a/fs/efs/super.c
> +++ b/fs/efs/super.c
> @@ -257,6 +257,8 @@ static int efs_fill_super(struct super_block *s, void *d, int silent)
>  	if (!sb)
>  		return -ENOMEM;
>  	s->s_fs_info = sb;
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
>   
>  	s->s_magic		= EFS_SUPER_MAGIC;
>  	if (!sb_set_blocksize(s, EFS_BLOCKSIZE)) {
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 44eb6e7eb492..baa36c6fb71e 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -1002,6 +1002,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_maxbytes = ext2_max_size(sb->s_blocksize_bits);
>  	sb->s_max_links = EXT2_LINK_MAX;
> +	sb->s_time_min = S32_MIN;
> +	sb->s_time_max = S32_MAX;
>  
>  	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV) {
>  		sbi->s_inode_size = EXT2_GOOD_OLD_INODE_SIZE;
> diff --git a/fs/freevxfs/vxfs_super.c b/fs/freevxfs/vxfs_super.c
> index a89f68c3cbed..578a5062706e 100644
> --- a/fs/freevxfs/vxfs_super.c
> +++ b/fs/freevxfs/vxfs_super.c
> @@ -229,6 +229,8 @@ static int vxfs_fill_super(struct super_block *sbp, void *dp, int silent)
>  
>  	sbp->s_op = &vxfs_super_ops;
>  	sbp->s_fs_info = infp;
> +	sbp->s_time_min = 0;
> +	sbp->s_time_max = U32_MAX;
>  
>  	if (!vxfs_try_sb_magic(sbp, silent, 1,
>  			(__force __fs32)cpu_to_le32(VXFS_SUPER_MAGIC))) {
> diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
> index 8a20ddd25f2d..d0b59d03a7a9 100644
> --- a/fs/jffs2/fs.c
> +++ b/fs/jffs2/fs.c
> @@ -590,6 +590,9 @@ int jffs2_do_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_blocksize = PAGE_SIZE;
>  	sb->s_blocksize_bits = PAGE_SHIFT;
>  	sb->s_magic = JFFS2_SUPER_MAGIC;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = U32_MAX;
> +
>  	if (!sb_rdonly(sb))
>  		jffs2_start_garbage_collect_thread(c);
>  	return 0;
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index f4e10cb9f734..b2dc4d1f9dcc 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -503,6 +503,8 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_fs_info = sbi;
>  	sb->s_max_links = JFS_LINK_MAX;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = U32_MAX;
>  	sbi->sb = sb;
>  	sbi->uid = INVALID_UID;
>  	sbi->gid = INVALID_GID;
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index f96073f25432..7cb5fd38eb14 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -277,6 +277,8 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
>  
>  	/* set up enough so that it can read an inode */
>  	s->s_op = &minix_sops;
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
>  	root_inode = minix_iget(s, MINIX_ROOT_INO);
>  	if (IS_ERR(root_inode)) {
>  		ret = PTR_ERR(root_inode);
> diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
> index 922d083bbc7c..e8da1cde87b9 100644
> --- a/fs/qnx4/inode.c
> +++ b/fs/qnx4/inode.c
> @@ -201,6 +201,8 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
>  	s->s_op = &qnx4_sops;
>  	s->s_magic = QNX4_SUPER_MAGIC;
>  	s->s_flags |= SB_RDONLY;	/* Yup, read-only yet */
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
>  
>  	/* Check the superblock signature. Since the qnx4 code is
>  	   dangerous, we should leave as quickly as possible
> diff --git a/fs/qnx6/inode.c b/fs/qnx6/inode.c
> index 0f8b0ff1ba43..345db56c98fd 100644
> --- a/fs/qnx6/inode.c
> +++ b/fs/qnx6/inode.c
> @@ -429,6 +429,8 @@ static int qnx6_fill_super(struct super_block *s, void *data, int silent)
>  	s->s_op = &qnx6_sops;
>  	s->s_magic = QNX6_SUPER_MAGIC;
>  	s->s_flags |= SB_RDONLY;        /* Yup, read-only yet */
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
>  
>  	/* ease the later tree level calculations */
>  	sbi = QNX6_SB(s);
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index ab028ea0e561..d69b4ac0ae2f 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -1976,6 +1976,9 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
>  		goto error_unlocked;
>  	}
>  
> +	s->s_time_min = 0;
> +	s->s_time_max = U32_MAX;
> +
>  	rs = SB_DISK_SUPER_BLOCK(s);
>  	/*
>  	 * Let's do basic sanity check to verify that underlying device is not
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index 7d580f7c3f1d..a42c0e3079dc 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -478,6 +478,8 @@ static int romfs_fill_super(struct super_block *sb, void *data, int silent)
>  	sb->s_maxbytes = 0xFFFFFFFF;
>  	sb->s_magic = ROMFS_MAGIC;
>  	sb->s_flags |= SB_RDONLY | SB_NOATIME;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = 0;
>  	sb->s_op = &romfs_super_ops;
>  
>  #ifdef CONFIG_ROMFS_ON_MTD
> diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
> index effa638d6d85..a9e9837617a9 100644
> --- a/fs/squashfs/super.c
> +++ b/fs/squashfs/super.c
> @@ -183,6 +183,8 @@ static int squashfs_fill_super(struct super_block *sb, void *data, int silent)
>  		(u64) le64_to_cpu(sblk->id_table_start));
>  
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
> +	sb->s_time_min = 0;
> +	sb->s_time_max = U32_MAX;
>  	sb->s_flags |= SB_RDONLY;
>  	sb->s_op = &squashfs_super_ops;
>  
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index 4ed0dca52ec8..1da0be667409 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -843,6 +843,10 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	sb->s_maxbytes = MAX_LFS_FILESIZE;
>  
> +	sb->s_time_gran = NSEC_PER_SEC;
> +	sb->s_time_min = S32_MIN;
> +	sb->s_time_max = S32_MAX;
> +
>  	switch (sbi->s_mount_opt & UFS_MOUNT_UFSTYPE) {
>  	case UFS_MOUNT_UFSTYPE_44BSD:
>  		UFSD("ufstype=44bsd\n");
> @@ -861,6 +865,9 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
>  		uspi->s_fshift = 9;
>  		uspi->s_sbsize = super_block_size = 1536;
>  		uspi->s_sbbase =  0;
> +		sb->s_time_gran = 1;
> +		sb->s_time_min = S64_MIN;
> +		sb->s_time_max = S64_MAX;
>  		flags |= UFS_TYPE_UFS2 | UFS_DE_44BSD | UFS_UID_44BSD | UFS_ST_44BSD | UFS_CG_44BSD;
>  		break;
>  		
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index a14d11d78bd8..1a0daf46bae8 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1685,6 +1685,8 @@ xfs_fs_fill_super(
>  	sb->s_maxbytes = xfs_max_file_offset(sb->s_blocksize_bits);
>  	sb->s_max_links = XFS_MAXLINK;
>  	sb->s_time_gran = 1;
> +	sb->s_time_min = S32_MIN;
> +	sb->s_time_max = S32_MAX;

For the XFS part,

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

>  	set_posix_acl_flag(sb);
>  
>  	/* version 5 superblocks support inode version counters. */
> -- 
> 2.17.1
> 
