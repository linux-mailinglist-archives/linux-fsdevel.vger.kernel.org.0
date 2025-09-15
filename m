Return-Path: <linux-fsdevel+bounces-61307-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BDB576B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63FBF443FD1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99BD02FD7AE;
	Mon, 15 Sep 2025 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vAm9gvR8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B302FD1B5
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932797; cv=none; b=JOo9qi9iYt9DFhZL3mn09X4XcK3GSygYFxikIfU3Kq+zpS7YeLLxSDUEX2BXVLi9kR8pBvggG2RSo9mo+l092FcF4PeZzt0u+zYFebQvf+s8UBKiD/fRVWr+njc6zxNRiTN3Z8ghgA3tZQBTd1LNvbaIlz4BXYSj1pGHqN3Mclo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932797; c=relaxed/simple;
	bh=BtsOh0+dcnqSFBWHqm5D46523X41g9IZzeKqSkkqVW8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=cc+mpmXIcMP9YANfyEAXm6CC1xnsfV/6bTL5Rvv2fQ/uiOU2mfT/2yP3YSDTyINzquvfz/4Q8ydcMVE62exGJJYBLaSi/Eeh5gXnCokQrNTNrfDExPi/BEBDJcUwdFtmMdtbP6zlQiH7jZ3BjXK/AGBqMej+lWDEjMi1oM4rOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vAm9gvR8; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250915103951epoutp037019c3ffb6067ef7c1abc8e9a03bc986~lbo9E6hRG2922229222epoutp03T
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 10:39:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250915103951epoutp037019c3ffb6067ef7c1abc8e9a03bc986~lbo9E6hRG2922229222epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1757932791;
	bh=snNgxWEvqHIfJBixcIqkYgUg/GNr72cd3LTjjEwqksI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=vAm9gvR8PNmhhkIuF6q4UtjdRBMYoF18khK0GOkSHxDekFKDCuA801cjueae5uqAB
	 nrYtfxT+twhr33H/NXG5oV6SVrTtIvmjIPQwaTeUUZeQ6oujjBkNtHcnBrxKKz2M2w
	 VXLnlbPXSa2y6z1JCU2hshb4kvSngNbEleCrdXrA=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPS id
	20250915103950epcas1p4619705a1b470125d9a9f5d49e4847af1~lbo8t4QE_0912309123epcas1p4j;
	Mon, 15 Sep 2025 10:39:50 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.36.224]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cQM3p2x6Nz2SSKX; Mon, 15 Sep
	2025 10:39:50 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
	20250915103949epcas1p4f7fb8db0c2c288a45b98c6d56dddc70b~lbo70lIGS1701917019epcas1p4g;
	Mon, 15 Sep 2025 10:39:49 +0000 (GMT)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250915103949epsmtip18350b6ae4a405bd85e80e38a91b631d8~lbo7xlx7a1560515605epsmtip17;
	Mon, 15 Sep 2025 10:39:49 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Ethan Ferguson'" <ethan.ferguson@zetier.com>, <linkinjeon@kernel.org>,
	<yuezhang.mo@sony.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cpgs@samsung.com>, "'Yuezhang Mo'" <Yuezhang.Mo@sony.com>,
	<sj1557.seo@samsung.com>
In-Reply-To: <20250912032619.9846-2-ethan.ferguson@zetier.com>
Subject: RE: [PATCH v7 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon, 15 Sep 2025 19:39:49 +0900
Message-ID: <8f2b01dc262d$0ff524a0$2fdf6de0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQDtRy/IJFFDSJGVRt3F5RwuJnX7UwJYHESyARs+6dq2Vi+kwA==
Content-Language: ko
X-CMS-MailID: 20250915103949epcas1p4f7fb8db0c2c288a45b98c6d56dddc70b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250912032640epcas1p4e4649c7ae90fecc013d8dcb548f6c7b7
References: <20250912032619.9846-1-ethan.ferguson@zetier.com>
	<CGME20250912032640epcas1p4e4649c7ae90fecc013d8dcb548f6c7b7@epcas1p4.samsung.com>
	<20250912032619.9846-2-ethan.ferguson@zetier.com>

> Add support for reading / writing to the exfat volume label from the
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
> 
> Co-developed-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>

Looks great! Thanks.
Reviewed-by: Sungjong Seo <sj1557.seo@samsung.com>

> ---
>  fs/exfat/dir.c       | 158 +++++++++++++++++++++++++++++++++++++++++++
>  fs/exfat/exfat_fs.h  |   7 ++
>  fs/exfat/exfat_raw.h |   6 ++
>  fs/exfat/file.c      |  52 ++++++++++++++
>  fs/exfat/namei.c     |   2 +-
>  5 files changed, 224 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index ee060e26f51d..55d826f6475d 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -1244,3 +1244,161 @@ int exfat_count_dir_entries(struct super_block
*sb,
> struct exfat_chain *p_dir)
> 
>  	return count;
>  }
> +
> +static int exfat_get_volume_label_dentry(struct super_block *sb,
> +		struct exfat_entry_set_cache *es)
> +{
> +	int i;
> +	int dentry = 0;
> +	unsigned int type;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_hint_femp hint_femp;
> +	struct exfat_inode_info *ei = EXFAT_I(sb->s_root->d_inode);
> +	struct exfat_chain clu;
> +	struct exfat_dentry *ep;
> +	struct buffer_head *bh;
> +
> +	hint_femp.eidx = EXFAT_HINT_NONE;
> +	exfat_chain_set(&clu, sbi->root_dir, 0, ALLOC_FAT_CHAIN);
> +
> +	while (clu.dir != EXFAT_EOF_CLUSTER) {
> +		for (i = 0; i < sbi->dentries_per_clu; i++, dentry++) {
> +			ep = exfat_get_dentry(sb, &clu, i, &bh);
> +			if (!ep)
> +				return -EIO;
> +
> +			type = exfat_get_entry_type(ep);
> +			if (hint_femp.eidx == EXFAT_HINT_NONE) {
> +				if (type == TYPE_DELETED || type ==
TYPE_UNUSED)
> {
> +					hint_femp.cur = clu;
> +					hint_femp.eidx = dentry;
> +					hint_femp.count = 1;
> +				}
> +			}
> +
> +			if (type == TYPE_UNUSED) {
> +				brelse(bh);
> +				goto not_found;
> +			}
> +
> +			if (type != TYPE_VOLUME) {
> +				brelse(bh);
> +				continue;
> +			}
> +
> +			memset(es, 0, sizeof(*es));
> +			es->sb = sb;
> +			es->bh = es->__bh;
> +			es->bh[0] = bh;
> +			es->num_bh = 1;
> +			es->start_off = EXFAT_DEN_TO_B(i) % sb->s_blocksize;
> +
> +			return 0;
> +		}
> +
> +		if (exfat_get_next_cluster(sb, &(clu.dir)))
> +			return -EIO;
> +	}
> +
> +not_found:
> +	if (hint_femp.eidx == EXFAT_HINT_NONE) {
> +		hint_femp.cur.dir = EXFAT_EOF_CLUSTER;
> +		hint_femp.eidx = dentry;
> +		hint_femp.count = 0;
> +	}
> +
> +	ei->hint_femp = hint_femp;
> +
> +	return -ENOENT;
> +}
> +
> +int exfat_read_volume_label(struct super_block *sb, struct exfat_uni_name
> *label_out)
> +{
> +	int ret, i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_entry_set_cache es;
> +	struct exfat_dentry *ep;
> +
> +	mutex_lock(&sbi->s_lock);
> +
> +	memset(label_out, 0, sizeof(*label_out));
> +	ret = exfat_get_volume_label_dentry(sb, &es);
> +	if (ret < 0) {
> +		/*
> +		 * ENOENT signifies that a volume label dentry doesn't exist
> +		 * We will treat this as an empty volume label and not fail.
> +		 */
> +		if (ret == -ENOENT)
> +			ret = 0;
> +
> +		goto unlock;
> +	}
> +
> +	ep = exfat_get_dentry_cached(&es, 0);
> +	label_out->name_len = ep->dentry.volume_label.char_count;
> +	if (label_out->name_len > EXFAT_VOLUME_LABEL_LEN) {
> +		ret = -EIO;
> +		goto unlock;
> +	}
> +
> +	for (i = 0; i < label_out->name_len; i++)
> +		label_out->name[i] = le16_to_cpu(ep-
> >dentry.volume_label.volume_label[i]);
> +
> +unlock:
> +	mutex_unlock(&sbi->s_lock);
> +	return ret;
> +}
> +
> +int exfat_write_volume_label(struct super_block *sb,
> +			     struct exfat_uni_name *label)
> +{
> +	int ret, i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct inode *root_inode = sb->s_root->d_inode;
> +	struct exfat_entry_set_cache es;
> +	struct exfat_chain clu;
> +	struct exfat_dentry *ep;
> +
> +	if (label->name_len > EXFAT_VOLUME_LABEL_LEN)
> +		return -EINVAL;
> +
> +	mutex_lock(&sbi->s_lock);
> +
> +	ret = exfat_get_volume_label_dentry(sb, &es);
> +	if (ret == -ENOENT) {
> +		if (label->name_len == 0) {
> +			/* No volume label dentry, no need to clear */
> +			ret = 0;
> +			goto unlock;
> +		}
> +
> +		ret = exfat_find_empty_entry(root_inode, &clu, 1, &es);
> +	}
> +
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ep = exfat_get_dentry_cached(&es, 0);
> +
> +	if (label->name_len == 0 && ep->dentry.volume_label.char_count == 0)
> {
> +		/* volume label had been cleared */
> +		exfat_put_dentry_set(&es, 0);
> +		goto unlock;
> +	}
> +
> +	memset(ep, 0, sizeof(*ep));
> +	ep->type = EXFAT_VOLUME;
> +
> +	for (i = 0; i < label->name_len; i++)
> +		ep->dentry.volume_label.volume_label[i] =
> +			cpu_to_le16(label->name[i]);
> +
> +	ep->dentry.volume_label.char_count = label->name_len;
> +	es.modified = true;
> +
> +	ret = exfat_put_dentry_set(&es, IS_DIRSYNC(root_inode));
> +
> +unlock:
> +	mutex_unlock(&sbi->s_lock);
> +	return ret;
> +}
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index f8ead4d47ef0..329697c89d09 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -477,6 +477,9 @@ int exfat_force_shutdown(struct super_block *sb, u32
> flags);
>  /* namei.c */
>  extern const struct dentry_operations exfat_dentry_ops;
>  extern const struct dentry_operations exfat_utf8_dentry_ops;
> +int exfat_find_empty_entry(struct inode *inode,
> +		struct exfat_chain *p_dir, int num_entries,
> +			   struct exfat_entry_set_cache *es);
> 
>  /* cache.c */
>  int exfat_cache_init(void);
> @@ -517,6 +520,10 @@ int exfat_get_empty_dentry_set(struct
> exfat_entry_set_cache *es,
>  		unsigned int num_entries);
>  int exfat_put_dentry_set(struct exfat_entry_set_cache *es, int sync);
>  int exfat_count_dir_entries(struct super_block *sb, struct exfat_chain
> *p_dir);
> +int exfat_read_volume_label(struct super_block *sb,
> +			    struct exfat_uni_name *label_out);
> +int exfat_write_volume_label(struct super_block *sb,
> +			     struct exfat_uni_name *label);
> 
>  /* inode.c */
>  extern const struct inode_operations exfat_file_inode_operations;
> diff --git a/fs/exfat/exfat_raw.h b/fs/exfat/exfat_raw.h
> index 971a1ccd0e89..4082fa7b8c14 100644
> --- a/fs/exfat/exfat_raw.h
> +++ b/fs/exfat/exfat_raw.h
> @@ -80,6 +80,7 @@
>  #define BOOTSEC_OLDBPB_LEN		53
> 
>  #define EXFAT_FILE_NAME_LEN		15
> +#define EXFAT_VOLUME_LABEL_LEN		11
> 
>  #define EXFAT_MIN_SECT_SIZE_BITS		9
>  #define EXFAT_MAX_SECT_SIZE_BITS		12
> @@ -159,6 +160,11 @@ struct exfat_dentry {
>  			__le32 start_clu;
>  			__le64 size;
>  		} __packed upcase; /* up-case table directory entry */
> +		struct {
> +			__u8 char_count;
> +			__le16 volume_label[EXFAT_VOLUME_LABEL_LEN];
> +			__u8 reserved[8];
> +		} __packed volume_label; /* volume label directory entry */
>  		struct {
>  			__u8 flags;
>  			__u8 vendor_guid[16];
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 538d2b6ac2ec..f246cf439588 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -486,6 +486,54 @@ static int exfat_ioctl_shutdown(struct super_block
> *sb, unsigned long arg)
>  	return exfat_force_shutdown(sb, flags);
>  }
> 
> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned
> long arg)
> +{
> +	int ret;
> +	char label[FSLABEL_MAX] = {0};
> +	struct exfat_uni_name uniname;
> +
> +	ret = exfat_read_volume_label(sb, &uniname);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = exfat_utf16_to_nls(sb, &uniname, label, uniname.name_len);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_to_user((char __user *)arg, label, ret + 1))
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int exfat_ioctl_set_volume_label(struct super_block *sb,
> +					unsigned long arg)
> +{
> +	int ret = 0, lossy;
> +	char label[FSLABEL_MAX];
> +	struct exfat_uni_name uniname;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (copy_from_user(label, (char __user *)arg, FSLABEL_MAX))
> +		return -EFAULT;
> +
> +	memset(&uniname, 0, sizeof(uniname));
> +	if (label[0]) {
> +		ret = exfat_nls_to_utf16(sb, label, FSLABEL_MAX,
> +					 &uniname, &lossy);
> +		if (ret < 0)
> +			return ret;
> +		else if (lossy & NLS_NAME_LOSSY)
> +			return -EINVAL;
> +	}
> +
> +	uniname.name_len = ret;
> +
> +	return exfat_write_volume_label(sb, &uniname);
> +}
> +
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> @@ -500,6 +548,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd,
> unsigned long arg)
>  		return exfat_ioctl_shutdown(inode->i_sb, arg);
>  	case FITRIM:
>  		return exfat_ioctl_fitrim(inode, arg);
> +	case FS_IOC_GETFSLABEL:
> +		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
> +	case FS_IOC_SETFSLABEL:
> +		return exfat_ioctl_set_volume_label(inode->i_sb, arg);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index f5f1c4e8a29f..eaa781d6263c 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -300,7 +300,7 @@ static int exfat_check_max_dentries(struct inode
> *inode)
>   *   the directory entry index in p_dir is returned on succeeds
>   *   -error code is returned on failure
>   */
> -static int exfat_find_empty_entry(struct inode *inode,
> +int exfat_find_empty_entry(struct inode *inode,
>  		struct exfat_chain *p_dir, int num_entries,
>  		struct exfat_entry_set_cache *es)
>  {
> --
> 2.34.1



