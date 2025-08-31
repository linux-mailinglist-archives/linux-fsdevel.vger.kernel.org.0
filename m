Return-Path: <linux-fsdevel+bounces-59718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D69B3D1B8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 11:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF22189047D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Aug 2025 09:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713B2225791;
	Sun, 31 Aug 2025 09:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HJlrU0f/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CF1205E25
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756633834; cv=none; b=qiReVDrMbwWUAyCtLSX9HCe8IJDvDMHKHCsHyvDzXrO0sJoVxFATEtYFa3a4fHWfSaeZyCams0plMyvr8DaskoZWz+iYJBTQWJ+G5lnmz5fWWsNTrbPzpQnWMYloPWMUFg06ZsUOWTbiBiKmn2l4e9s2/1J5o4d6vCXkWcpn/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756633834; c=relaxed/simple;
	bh=6A4GMp7BO1+rdlclpCGlitO+jmTXztdIl2bN3hRhIBo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=r3fMClytzFLm4DJrkbdAQHfwKnsb7IEHAhaIPeIa+G4zBQxQVg1wNDBuK+ifVC07AlpXgn55607inY43IDkRodmFKc8aksAbJi/YYh/UNC2Cx72VQR6iQ2B0wQmTgd7GAst2c/H99b+CFhJso8neMPjao3ZpFduD9tx/e2m2G9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HJlrU0f/; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250831095024epoutp041ead67b8654daf0b377bba918275a2cb~g0SftUmII3215232152epoutp04b
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Aug 2025 09:50:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250831095024epoutp041ead67b8654daf0b377bba918275a2cb~g0SftUmII3215232152epoutp04b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756633824;
	bh=VtDCAjkm2qkjJ5xjbF4B+w7GJLiCWmEbeGMms+jD7vU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HJlrU0f/LF6hqxh+D1GCsZHhlzSbDnInBdDKKpZlTo3mVhkPBThP2AuMx3EVc5IyJ
	 DkUp52StSwV63I0R0z7sLRPvZ7CmD8MWuimNDpTiJf0so7l+NeIiULkhTZQMMgt3Xp
	 szkzJu1KpPbmOqxbPir4+27yGKdX4pZZE0rpovn4=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPS id
	20250831095022epcas1p3204f65f9de5a2e9bd960e45d7b53352c~g0SeryIoL1439614396epcas1p3X;
	Sun, 31 Aug 2025 09:50:22 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.36.224]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4cF6gf4Stwz2SSKX; Sun, 31 Aug
	2025 09:50:22 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
	20250831095021epcas1p34d0d6eec3f8ce076dbb1c8498de4450a~g0SdhpUrD1439614396epcas1p3W;
	Sun, 31 Aug 2025 09:50:21 +0000 (GMT)
Received: from W10PB11329 (unknown [10.253.152.129]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250831095021epsmtip273f35b972198555fd5ceca8f1775baf4~g0SdeIie20443504435epsmtip25;
	Sun, 31 Aug 2025 09:50:21 +0000 (GMT)
From: "Sungjong Seo" <sj1557.seo@samsung.com>
To: "'Ethan Ferguson'" <ethan.ferguson@zetier.com>, <linkinjeon@kernel.org>,
	<yuezhang.mo@sony.com>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<cpgs@samsung.com>
In-Reply-To: <20250822202010.232922-2-ethan.ferguson@zetier.com>
Subject: RE: [PATCH v4 1/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Sun, 31 Aug 2025 18:50:21 +0900
Message-ID: <000001dc1a5c$aaac6350$000529f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQHtaKTtCgn8qsbURORYOPLaF6mHwwEsV41eAYg80em0RBqlsA==
Content-Language: ko
X-CMS-MailID: 20250831095021epcas1p34d0d6eec3f8ce076dbb1c8498de4450a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-711,N
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250822202036epcas1p3be9836f29caef35b48c9ade774a47279
References: <20250822202010.232922-1-ethan.ferguson@zetier.com>
	<CGME20250822202036epcas1p3be9836f29caef35b48c9ade774a47279@epcas1p3.samsung.com>
	<20250822202010.232922-2-ethan.ferguson@zetier.com>

Hi,
> Add support for reading / writing to the exfat volume label from the
> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
> 
> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
> ---
>  fs/exfat/exfat_fs.h  |   5 +
>  fs/exfat/exfat_raw.h |   6 ++
>  fs/exfat/file.c      |  88 +++++++++++++++++
>  fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 323 insertions(+)
> 
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index f8ead4d47ef0..ed4b5ecb952b 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -267,6 +267,7 @@ struct exfat_sb_info {
>  	struct buffer_head **vol_amap; /* allocation bitmap */
> 
>  	unsigned short *vol_utbl; /* upcase table */
> +	unsigned short *volume_label; /* volume name */
Why is it necessary to allocate and cache it? I didn't find where to reuse
it.
Is there a reason why uniname is not used directly as an argument?
Is there something I missed?

> 
>  	unsigned int clu_srch_ptr; /* cluster search pointer */
>  	unsigned int used_clusters; /* number of used clusters */
> @@ -431,6 +432,10 @@ static inline loff_t exfat_ondisk_size(const struct
> inode *inode)
[snip]
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 538d2b6ac2ec..970e3ee57c43 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -12,6 +12,7 @@
>  #include <linux/security.h>
>  #include <linux/msdos_fs.h>
>  #include <linux/writeback.h>
> +#include "../nls/nls_ucs2_utils.h"
> 
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -486,10 +487,93 @@ static int exfat_ioctl_shutdown(struct super_block
> *sb, unsigned long arg)
>  	return exfat_force_shutdown(sb, flags);
>  }
> 
> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned
> long arg)
> +{
> +	int ret;
> +	char utf8[FSLABEL_MAX] = {0};
> +	struct exfat_uni_name *uniname;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
> +	if (!uniname)
> +		return -ENOMEM;
> +
> +	ret = exfat_read_volume_label(sb);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	memcpy(uniname->name, sbi->volume_label,
> +	       EXFAT_VOLUME_LABEL_LEN * sizeof(short));
> +	uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
> +	uniname->name_len = UniStrnlen(uniname->name,
> EXFAT_VOLUME_LABEL_LEN);
The volume label length is stored on-disk. It makes sense to retrieve
it directly. This way, there is no need to unnecessarily include the 
NLS utility header file.

> +
> +	ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
> +		ret = -EFAULT;
> +		goto cleanup;
> +	}
> +
> +	ret = 0;
> +
> +cleanup:
> +	kfree(uniname);
> +	return ret;
> +}
> +
> +static int exfat_ioctl_set_volume_label(struct super_block *sb,
> +					unsigned long arg,
> +					struct inode *root_inode)
> +{
> +	int ret, lossy;
> +	char utf8[FSLABEL_MAX];
> +	struct exfat_uni_name *uniname;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
> +	if (!uniname)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {
> +		ret = -EFAULT;
> +		goto cleanup;
> +	}
> +
> +	if (utf8[0]) {
> +		ret = exfat_nls_to_utf16(sb, utf8, strnlen(utf8,
> FSLABEL_MAX),
> +					 uniname, &lossy);
> +		if (ret < 0)
> +			goto cleanup;
> +		else if (lossy & NLS_NAME_LOSSY) {
> +			ret = -EINVAL;
> +			goto cleanup;
> +		}
> +	} else {
> +		uniname->name[0] = 0x0000;
> +		uniname->name_len = 0;
> +	}
> +
> +	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
> +		exfat_info(sb, "Volume label length too long, truncating");
> +		uniname->name_len = EXFAT_VOLUME_LABEL_LEN;
> +	}
> +
> +	ret = exfat_write_volume_label(sb, uniname, root_inode);
> +
> +cleanup:
> +	kfree(uniname);
> +	return ret;
> +}
> +
>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
>  	u32 __user *user_attr = (u32 __user *)arg;
> +	struct inode *root_inode = filp->f_path.mnt->mnt_root->d_inode;
From this point, there is no need to pass root_inode. The root_inode can be
obtained directly from sb->s_root->d_inode within the function.

> 
>  	switch (cmd) {
>  	case FAT_IOCTL_GET_ATTRIBUTES:
> @@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd,
> unsigned long arg)
>  		return exfat_ioctl_shutdown(inode->i_sb, arg);
>  	case FITRIM:
>  		return exfat_ioctl_fitrim(inode, arg);
> +	case FS_IOC_GETFSLABEL:
> +		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
> +	case FS_IOC_SETFSLABEL:
> +		return exfat_ioctl_set_volume_label(inode->i_sb, arg,
> root_inode);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 8926e63f5bb7..7931cdb4a1d1 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -18,6 +18,7 @@
>  #include <linux/nls.h>
>  #include <linux/buffer_head.h>
>  #include <linux/magic.h>
> +#include "../nls/nls_ucs2_utils.h"
> 
>  #include "exfat_raw.h"
>  #include "exfat_fs.h"
> @@ -573,6 +574,228 @@ static int exfat_verify_boot_region(struct
> super_block *sb)
>  	return 0;
>  }
> 
> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
> +				       struct buffer_head **out_bh,
> +				       struct exfat_dentry **out_dentry,
> +				       struct inode *root_inode)
Instead of passing root_inode, it seems more helpful to pass the
need_create condition to better understand the function's behavior.
As mentioned earlier, the root_inode can be found directly from
sb->s_root->d_inode.

> +{
> +	int i, ret;
> +	unsigned int type, old_clu;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct exfat_chain clu;
> +	struct exfat_dentry *ep, *deleted_ep = NULL;
> +	struct buffer_head *bh, *deleted_bh;
> +
> +	clu.dir = sbi->root_dir;
> +	clu.flags = ALLOC_FAT_CHAIN;
> +
> +	while (clu.dir != EXFAT_EOF_CLUSTER) {
> +		for (i = 0; i < sbi->dentries_per_clu; i++) {
> +			ep = exfat_get_dentry(sb, &clu, i, &bh);
> +
> +			if (!ep) {
> +				ret = -EIO;
> +				goto end;
> +			}
> +
> +			type = exfat_get_entry_type(ep);
> +			if (type == TYPE_DELETED && !deleted_ep &&
root_inode)
> {
> +				deleted_ep = ep;
> +				deleted_bh = bh;
> +				continue;
> +			}
> +
> +			if (type == TYPE_UNUSED) {
> +				if (!root_inode) {
> +					brelse(bh);
> +					ret = -ENOENT;
> +					goto end;
> +				}
Too many unnecessary operations are being performed here.
1. Since the VOLUME_LABEL entry requires only one empty entry, if a DELETED
    or UNUSED entry is found, it can be used directly.
2. According to the exFAT specification, all entries after UNUSED are
    guaranteed to be UNUSED.

Therefore, there is no need to allocate additional clusters or
mark the next entry as UNUSED here.

In the case of need_create(as of now, root_inode is not null),
if the next cluster is EOF and TYPE_VOLUME, TYPE_DELETED, or TYPE_UNUSED
entries are not found, then a new cluster should be allocated.

Lastly, if a new VOLUME_LABEL entry is created, initialization of
hint_femp is required.

> +
> +				if (deleted_ep) {
> +					brelse(bh);
> +					goto end;
> +				}
> +
> +				if (i < sbi->dentries_per_clu - 1) {

> +					deleted_ep = ep;
> +					deleted_bh = bh;
> +
> +					ep = exfat_get_dentry(sb, &clu,
> +							      i + 1, &bh);
> +					memset(ep, 0,
> +					       sizeof(struct exfat_dentry));
> +					ep->type = EXFAT_UNUSED;
> +					exfat_update_bh(bh, true);
> +					brelse(bh);
> +
> +					goto end;
> +				}
> +
> +				// Last dentry in cluster
> +				clu.size = 0;
> +				old_clu = clu.dir;
> +				ret = exfat_alloc_cluster(root_inode, 1,
> +							  &clu, true);
> +				if (ret < 0) {
> +					brelse(bh);
> +					goto end;
> +				}
> +
> +				ret = exfat_ent_set(sb, old_clu, clu.dir);
> +				if (ret < 0) {
> +					exfat_free_cluster(root_inode,
&clu);
> +					brelse(bh);
> +					goto end;
> +				}
> +
> +				ret = exfat_zeroed_cluster(root_inode,
clu.dir);
> +				if (ret < 0) {
> +					exfat_free_cluster(root_inode,
&clu);
> +					brelse(bh);
> +					goto end;
> +				}
> +
> +				deleted_ep = ep;
> +				deleted_bh = bh;
> +				goto end;
> +			}
> +
> +			if (type == TYPE_VOLUME) {
> +				*out_bh = bh;
> +				*out_dentry = ep;
> +
> +				if (deleted_ep)
> +					brelse(deleted_bh);
> +
> +				return 0;
> +			}
> +
> +			brelse(bh);
> +		}
> +
> +		if (exfat_get_next_cluster(sb, &(clu.dir))) {
> +			ret = -EIO;
> +			goto end;
> +		}
> +	}
> +
> +	ret = -EIO;
> +
> +end:
> +	if (deleted_ep) {
> +		*out_bh = deleted_bh;
> +		*out_dentry = deleted_ep;
> +		memset((*out_dentry), 0, sizeof(struct exfat_dentry));
> +		(*out_dentry)->type = EXFAT_VOLUME;
> +		return 0;
> +	}
> +
> +	*out_bh = NULL;
> +	*out_dentry = NULL;
> +	return ret;
> +}
> +
> +static int exfat_alloc_volume_label(struct super_block *sb)
> +{
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +
> +	if (sbi->volume_label)
> +		return 0;
> +
> +
> +	mutex_lock(&sbi->s_lock);
> +	sbi->volume_label = kcalloc(EXFAT_VOLUME_LABEL_LEN,
> +						     sizeof(short),
GFP_KERNEL);
> +	mutex_unlock(&sbi->s_lock);
> +
> +	if (!sbi->volume_label)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +int exfat_read_volume_label(struct super_block *sb)
> +{
> +	int ret, i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh = NULL;
> +	struct exfat_dentry *ep = NULL;
> +
> +	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, NULL);
> +	// ENOENT signifies that a volume label dentry doesn't exist
> +	// We will treat this as an empty volume label and not fail.
> +	if (ret < 0 && ret != -ENOENT)
> +		goto cleanup;
> +
> +	ret = exfat_alloc_volume_label(sb);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	mutex_lock(&sbi->s_lock);
The sbi->s_lock should be acquired from the beginning of the function.

> +	if (!ep)
> +		memset(sbi->volume_label, 0, EXFAT_VOLUME_LABEL_LEN);
If sbi->volume_label remains, a memset operation is required for
EXFAT_VOLUME_LABEL_LEN * sizeof(short).

> +	else
> +		for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
> +			sbi->volume_label[i] = le16_to_cpu(ep-
> >dentry.volume_label.volume_label[i]);
> +	mutex_unlock(&sbi->s_lock);
> +
> +	ret = 0;
> +
> +cleanup:
> +	if (bh)
> +		brelse(bh);
> +
> +	return ret;
> +}
> +
> +int exfat_write_volume_label(struct super_block *sb,
> +			     struct exfat_uni_name *uniname,
> +			     struct inode *root_inode)
> +{
> +	int ret, i;
> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
> +	struct buffer_head *bh = NULL;
> +	struct exfat_dentry *ep = NULL;
> +
> +	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, root_inode);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	ret = exfat_alloc_volume_label(sb);
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	memcpy(sbi->volume_label, uniname->name,
> +	       uniname->name_len * sizeof(short));
> +
> +	mutex_lock(&sbi->s_lock);
The sbi->s_lock should be acquired from the beginning of the function.

> +	for (i = 0; i < uniname->name_len; i++)
> +		ep->dentry.volume_label.volume_label[i] =
> +			cpu_to_le16(sbi->volume_label[i]);
> +	// Fill the rest of the str with 0x0000
> +	for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
> +		ep->dentry.volume_label.volume_label[i] = 0x0000;
> +
> +	ep->dentry.volume_label.char_count = uniname->name_len;
> +	mutex_unlock(&sbi->s_lock);
> +
> +	ret = 0;
> +
> +cleanup:
> +	if (bh) {
> +		exfat_update_bh(bh, true);
> +		brelse(bh);
> +	}
> +
> +	return ret;
> +}
> +
>  /* mount the file system volume */
>  static int __exfat_fill_super(struct super_block *sb,
>  		struct exfat_chain *root_clu)
> @@ -791,6 +1014,7 @@ static void delayed_free(struct rcu_head *p)
> 
>  	unload_nls(sbi->nls_io);
>  	exfat_free_upcase_table(sbi);
> +	kfree(sbi->volume_label);
>  	exfat_free_sbi(sbi);
>  }
> 
> --
> 2.34.1



