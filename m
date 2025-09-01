Return-Path: <linux-fsdevel+bounces-59902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175D4B3ED9B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57F82079FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 18:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EED30F800;
	Mon,  1 Sep 2025 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="MMF9Ss0J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73247241680
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756749729; cv=none; b=K7YrivLtwilmzb04YdpNwyE3jfgaCFC4zGPF4KDwikNI8wlmQrUDuX1wJewjIz/kMT1G3Fss+KKHdwP0WbXJD7lMbh5zWJvNADv9AeJZsYz2jINZc31hrduphjavg/9OfCJJpQbcLn0W/jpe0wtmM6B4sde4as9jtV4+J8CpBCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756749729; c=relaxed/simple;
	bh=UlhXpPpdkEYA1T8K0EK5wUn4spw5NOB5LKobJnYuX4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dP83hNA3p+7uzvFwqblrYYp99Y/fIEdG/NXzfXV9IXV0INywrwz7uWqw04hEd+KcrLY0cpSRsa9A5uDFtnBNPXgdc/SX4SGbU6vLHyjXNwQUy7woMR2nlIiijgoOK7+wKI4tz+sIzsJ3qr0nwJwEfAx5xGmCAAQVUUPdjPzgMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=MMF9Ss0J; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109c482c8so84865781cf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756749726; x=1757354526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQKg/4y4CRuZ3XErMAvF9tNnugMHG59rZdlbulRXxbE=;
        b=MMF9Ss0Jj7Uebu0YwNJfqArs3Uyl6TeUKp4aYJ1yP8kS1UYfM9t0nmAf1G6wkQZQDy
         GtrpaCDuG4IO/p9CXfDUsgqaD4HNRN9W3c9LeY1GFBhKsNoxd6qpp5aUMhBqQDVFDvQD
         SDcH25XBggzz7SHWg6kc1aHNtusbUBk5BEZmjOJ//SxPGXUvHt2C7bw4bHpwG9RScJJ6
         YTnEovkwj/7eQMzorV59SY6+5Y0j4v5Zzrs1g77R1UXutc7makETnXY1EkOHXkuWKRZR
         aDpMDvoEPvCQsRfV90Za/kKYLQAJZlH7idDGyJishTzgQAv1Y7v2J8r9SdAlrRNPHO+/
         sguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756749726; x=1757354526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XQKg/4y4CRuZ3XErMAvF9tNnugMHG59rZdlbulRXxbE=;
        b=EKSsk5R2M+e4Hl3DQLpOHiSjgQ2jISxVY1zHxNGcjpmBwQIvle+EiczzEQs12p9LvQ
         4KlTeFQ6nwiPyUbuP3v7Eu6YRxRPusNOFsINSZfe+meQVRPVadKNfHNUl6CQiV/5egtf
         wmaZxqJZ+WZxmyMtO8ycUCUjA2rDlZePDGRrYL2umHKrcuPIlwIchdd6WjRvbvnar9P1
         i90UlPjeZtpcOSQ3OY05csBXFqJUzMg7aII0oyl9IXNPFMZPqGLxnX1agEQ01DbxZ1l0
         +JCpOFg5LjAIryYkOSJOlmMw6urgrtFFoGv+f+1sZXUWKos2mZOjIlZVNScLIFdVP05s
         Y/oQ==
X-Forwarded-Encrypted: i=1; AJvYcCULd31Rtr74ZTRywzEAnr5II6t/4I2lL18UF30g++1gl9br29J+vrlY9jjneSakuk81bW9cbh1pTmWDz8vw@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/FmKfKdF5k5nuXRNV15Fv6QvrK/CGx9wjmLqQFgVXC+yYRPr
	8+4ylXywjcMpsjvgQw/+kQAE5AkHXIrSvDBrRwfZdzncG15AwE5k3zqz9eOKAVjnwBA=
X-Gm-Gg: ASbGncvPsNO8YF8D1j73jsK2znzJsZXrdwRQS143Q/n4c5TswfmOKzm7Wq9GdklTWwe
	t69orYCTU/vQit+H1zdTma8+J9wN2QSKOCLbcllnnskuFxMabcREfle3FRcbIBkiubqE0GxPDI0
	+gXOlJ3n5nTNz+FlMF5QKotlJbx2BbWLLgC0r3LF1MMMjj+d/HtP4DH9j+NSlso0edjBJ5uWp7Z
	w025TtxKibmERzaC1dLxT1iUOj9H/7tvUUaMZ6vLdVtqCKH0GwpX0yv43MV67m1LVHLgO0ponvP
	qp9k7Z/45lweSD4lh9Eq5NlJa8m2I9PKDc2gNvgl/yT6yjkSiHKSnoVGBX89OxARXSLqGom1aux
	IPOp4u329ET6hV514gFnxpffRQxXpNlExynDJvpgTEvQbcqkE
X-Google-Smtp-Source: AGHT+IG/uSVhgqxhFMWoza95zCxQM300EAU+uR4UAx8aeIbObeCVv7hfs/a3q/CySD5xzsNDZrvHCA==
X-Received: by 2002:a05:622a:1214:b0:4b2:f065:f331 with SMTP id d75a77b69052e-4b31dd7bdc4mr103870461cf.78.1756749725824;
        Mon, 01 Sep 2025 11:02:05 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b346330bacsm41061cf.51.2025.09.01.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:02:05 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: sj1557.seo@samsung.com
Cc: cpgs@samsung.com,
	ethan.ferguson@zetier.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yuezhang.mo@sony.com
Subject: RE: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Mon,  1 Sep 2025 14:02:01 -0400
Message-Id: <20250901180201.509218-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <000001dc1a5c$aaac6350$000529f0$@samsung.com>
References: <000001dc1a5c$aaac6350$000529f0$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/31/25 05:50, Sungjong Seo wrote:
> Hi,
>> Add support for reading / writing to the exfat volume label from the
>> FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls
>>
>> Signed-off-by: Ethan Ferguson <ethan.ferguson@zetier.com>
>> ---
>>  fs/exfat/exfat_fs.h  |   5 +
>>  fs/exfat/exfat_raw.h |   6 ++
>>  fs/exfat/file.c      |  88 +++++++++++++++++
>>  fs/exfat/super.c     | 224 +++++++++++++++++++++++++++++++++++++++++++
>>  4 files changed, 323 insertions(+)
>>
>> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
>> index f8ead4d47ef0..ed4b5ecb952b 100644
>> --- a/fs/exfat/exfat_fs.h
>> +++ b/fs/exfat/exfat_fs.h
>> @@ -267,6 +267,7 @@ struct exfat_sb_info {
>>  	struct buffer_head **vol_amap; /* allocation bitmap */
>>
>>  	unsigned short *vol_utbl; /* upcase table */
>> +	unsigned short *volume_label; /* volume name */
> Why is it necessary to allocate and cache it? I didn't find where to reuse
> it.
> Is there a reason why uniname is not used directly as an argument?
> Is there something I missed?
>
I thought it might be prudent to store it in the sbi, in case other
patches in the future might want to use the volume label. However, since
this is not necessary, I can remove it if needed.

I chose not to use a uniname, as that would require allocating lots of
data, when the maximum amount of bytes present in a volume label is 22.

>>
>>  	unsigned int clu_srch_ptr; /* cluster search pointer */
>>  	unsigned int used_clusters; /* number of used clusters */
>> @@ -431,6 +432,10 @@ static inline loff_t exfat_ondisk_size(const struct
>> inode *inode)
> [snip]
>> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
>> index 538d2b6ac2ec..970e3ee57c43 100644
>> --- a/fs/exfat/file.c
>> +++ b/fs/exfat/file.c
>> @@ -12,6 +12,7 @@
>>  #include <linux/security.h>
>>  #include <linux/msdos_fs.h>
>>  #include <linux/writeback.h>
>> +#include "../nls/nls_ucs2_utils.h"
>>
>>  #include "exfat_raw.h"
>>  #include "exfat_fs.h"
>> @@ -486,10 +487,93 @@ static int exfat_ioctl_shutdown(struct super_block
>> *sb, unsigned long arg)
>>  	return exfat_force_shutdown(sb, flags);
>>  }
>>
>> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned
>> long arg)
>> +{
>> +	int ret;
>> +	char utf8[FSLABEL_MAX] = {0};
>> +	struct exfat_uni_name *uniname;
>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +
>> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>> +	if (!uniname)
>> +		return -ENOMEM;
>> +
>> +	ret = exfat_read_volume_label(sb);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	memcpy(uniname->name, sbi->volume_label,
>> +	       EXFAT_VOLUME_LABEL_LEN * sizeof(short));
>> +	uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
>> +	uniname->name_len = UniStrnlen(uniname->name,
>> EXFAT_VOLUME_LABEL_LEN);
> The volume label length is stored on-disk. It makes sense to retrieve
> it directly. This way, there is no need to unnecessarily include the 
> NLS utility header file.
>
That's true, given I'll be removing the volume_label field from the
superblock info struct, I can rework this function to output to a
uniname struct.
>> +
>> +	ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
>> +		ret = -EFAULT;
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = 0;
>> +
>> +cleanup:
>> +	kfree(uniname);
>> +	return ret;
>> +}
>> +
>> +static int exfat_ioctl_set_volume_label(struct super_block *sb,
>> +					unsigned long arg,
>> +					struct inode *root_inode)
>> +{
>> +	int ret, lossy;
>> +	char utf8[FSLABEL_MAX];
>> +	struct exfat_uni_name *uniname;
>> +
>> +	if (!capable(CAP_SYS_ADMIN))
>> +		return -EPERM;
>> +
>> +	uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>> +	if (!uniname)
>> +		return -ENOMEM;
>> +
>> +	if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {
>> +		ret = -EFAULT;
>> +		goto cleanup;
>> +	}
>> +
>> +	if (utf8[0]) {
>> +		ret = exfat_nls_to_utf16(sb, utf8, strnlen(utf8,
>> FSLABEL_MAX),
>> +					 uniname, &lossy);
>> +		if (ret < 0)
>> +			goto cleanup;
>> +		else if (lossy & NLS_NAME_LOSSY) {
>> +			ret = -EINVAL;
>> +			goto cleanup;
>> +		}
>> +	} else {
>> +		uniname->name[0] = 0x0000;
>> +		uniname->name_len = 0;
>> +	}
>> +
>> +	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +		exfat_info(sb, "Volume label length too long, truncating");
>> +		uniname->name_len = EXFAT_VOLUME_LABEL_LEN;
>> +	}
>> +
>> +	ret = exfat_write_volume_label(sb, uniname, root_inode);
>> +
>> +cleanup:
>> +	kfree(uniname);
>> +	return ret;
>> +}
>> +
>>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  {
>>  	struct inode *inode = file_inode(filp);
>>  	u32 __user *user_attr = (u32 __user *)arg;
>> +	struct inode *root_inode = filp->f_path.mnt->mnt_root->d_inode;
> From this point, there is no need to pass root_inode. The root_inode can be
> obtained directly from sb->s_root->d_inode within the function.
>
Must have missed that, thank you!
>>
>>  	switch (cmd) {
>>  	case FAT_IOCTL_GET_ATTRIBUTES:
>> @@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd,
>> unsigned long arg)
>>  		return exfat_ioctl_shutdown(inode->i_sb, arg);
>>  	case FITRIM:
>>  		return exfat_ioctl_fitrim(inode, arg);
>> +	case FS_IOC_GETFSLABEL:
>> +		return exfat_ioctl_get_volume_label(inode->i_sb, arg);
>> +	case FS_IOC_SETFSLABEL:
>> +		return exfat_ioctl_set_volume_label(inode->i_sb, arg,
>> root_inode);
>>  	default:
>>  		return -ENOTTY;
>>  	}
>> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
>> index 8926e63f5bb7..7931cdb4a1d1 100644
>> --- a/fs/exfat/super.c
>> +++ b/fs/exfat/super.c
>> @@ -18,6 +18,7 @@
>>  #include <linux/nls.h>
>>  #include <linux/buffer_head.h>
>>  #include <linux/magic.h>
>> +#include "../nls/nls_ucs2_utils.h"
>>
>>  #include "exfat_raw.h"
>>  #include "exfat_fs.h"
>> @@ -573,6 +574,228 @@ static int exfat_verify_boot_region(struct
>> super_block *sb)
>>  	return 0;
>>  }
>>
>> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
>> +				       struct buffer_head **out_bh,
>> +				       struct exfat_dentry **out_dentry,
>> +				       struct inode *root_inode)
> Instead of passing root_inode, it seems more helpful to pass the
> need_create condition to better understand the function's behavior.
> As mentioned earlier, the root_inode can be found directly from
> sb->s_root->d_inode.
>
Given I can now obtain the root inode due to your above suggestion, I
can use need_create from my previous patch (v3).
>> +{
>> +	int i, ret;
>> +	unsigned int type, old_clu;
>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +	struct exfat_chain clu;
>> +	struct exfat_dentry *ep, *deleted_ep = NULL;
>> +	struct buffer_head *bh, *deleted_bh;
>> +
>> +	clu.dir = sbi->root_dir;
>> +	clu.flags = ALLOC_FAT_CHAIN;
>> +
>> +	while (clu.dir != EXFAT_EOF_CLUSTER) {
>> +		for (i = 0; i < sbi->dentries_per_clu; i++) {
>> +			ep = exfat_get_dentry(sb, &clu, i, &bh);
>> +
>> +			if (!ep) {
>> +				ret = -EIO;
>> +				goto end;
>> +			}
>> +
>> +			type = exfat_get_entry_type(ep);
>> +			if (type == TYPE_DELETED && !deleted_ep &&
> root_inode)
>> {
>> +				deleted_ep = ep;
>> +				deleted_bh = bh;
>> +				continue;
>> +			}
>> +
>> +			if (type == TYPE_UNUSED) {
>> +				if (!root_inode) {
>> +					brelse(bh);
>> +					ret = -ENOENT;
>> +					goto end;
>> +				}
> Too many unnecessary operations are being performed here.
> 1. Since the VOLUME_LABEL entry requires only one empty entry, if a DELETED
>     or UNUSED entry is found, it can be used directly.
> 2. According to the exFAT specification, all entries after UNUSED are
>     guaranteed to be UNUSED.
> 
> Therefore, there is no need to allocate additional clusters or
> mark the next entry as UNUSED here.
> 
> In the case of need_create(as of now, root_inode is not null),
> if the next cluster is EOF and TYPE_VOLUME, TYPE_DELETED, or TYPE_UNUSED
> entries are not found, then a new cluster should be allocated.
> 
> Lastly, if a new VOLUME_LABEL entry is created, initialization of
> hint_femp is required.
>
Just so I'm sure, if the last dentry in a cluster is TYPE_UNUSED, we can
safely overwrite that with the volume label (assuming no other
TYPE_VOLUME or TYPE_DELETED have been found previously), and we don't
have to allocate a new cluster? And we would only have to allocate a
new cluster if there are no TYPE_UNUSED, TYPE_VOLUME, or TYPE_DELETED
anywhere in the chain?

As for hint_femp, should I set the root_inode's hint_femp field to
EXFAT_HINT_NONE?
>> +
>> +				if (deleted_ep) {
>> +					brelse(bh);
>> +					goto end;
>> +				}
>> +
>> +				if (i < sbi->dentries_per_clu - 1) {
> 
>> +					deleted_ep = ep;
>> +					deleted_bh = bh;
>> +
>> +					ep = exfat_get_dentry(sb, &clu,
>> +							      i + 1, &bh);
>> +					memset(ep, 0,
>> +					       sizeof(struct exfat_dentry));
>> +					ep->type = EXFAT_UNUSED;
>> +					exfat_update_bh(bh, true);
>> +					brelse(bh);
>> +
>> +					goto end;
>> +				}
>> +
>> +				// Last dentry in cluster
>> +				clu.size = 0;
>> +				old_clu = clu.dir;
>> +				ret = exfat_alloc_cluster(root_inode, 1,
>> +							  &clu, true);
>> +				if (ret < 0) {
>> +					brelse(bh);
>> +					goto end;
>> +				}
>> +
>> +				ret = exfat_ent_set(sb, old_clu, clu.dir);
>> +				if (ret < 0) {
>> +					exfat_free_cluster(root_inode,
> &clu);
>> +					brelse(bh);
>> +					goto end;
>> +				}
>> +
>> +				ret = exfat_zeroed_cluster(root_inode,
> clu.dir);
>> +				if (ret < 0) {
>> +					exfat_free_cluster(root_inode,
> &clu);
>> +					brelse(bh);
>> +					goto end;
>> +				}
>> +
>> +				deleted_ep = ep;
>> +				deleted_bh = bh;
>> +				goto end;
>> +			}
>> +
>> +			if (type == TYPE_VOLUME) {
>> +				*out_bh = bh;
>> +				*out_dentry = ep;
>> +
>> +				if (deleted_ep)
>> +					brelse(deleted_bh);
>> +
>> +				return 0;
>> +			}
>> +
>> +			brelse(bh);
>> +		}
>> +
>> +		if (exfat_get_next_cluster(sb, &(clu.dir))) {
>> +			ret = -EIO;
>> +			goto end;
>> +		}
>> +	}
>> +
>> +	ret = -EIO;
>> +
>> +end:
>> +	if (deleted_ep) {
>> +		*out_bh = deleted_bh;
>> +		*out_dentry = deleted_ep;
>> +		memset((*out_dentry), 0, sizeof(struct exfat_dentry));
>> +		(*out_dentry)->type = EXFAT_VOLUME;
>> +		return 0;
>> +	}
>> +
>> +	*out_bh = NULL;
>> +	*out_dentry = NULL;
>> +	return ret;
>> +}
>> +
>> +static int exfat_alloc_volume_label(struct super_block *sb)
>> +{
>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +
>> +	if (sbi->volume_label)
>> +		return 0;
>> +
>> +
>> +	mutex_lock(&sbi->s_lock);
>> +	sbi->volume_label = kcalloc(EXFAT_VOLUME_LABEL_LEN,
>> +						     sizeof(short),
> GFP_KERNEL);
>> +	mutex_unlock(&sbi->s_lock);
>> +
>> +	if (!sbi->volume_label)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>> +int exfat_read_volume_label(struct super_block *sb)
>> +{
>> +	int ret, i;
>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +	struct buffer_head *bh = NULL;
>> +	struct exfat_dentry *ep = NULL;
>> +
>> +	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, NULL);
>> +	// ENOENT signifies that a volume label dentry doesn't exist
>> +	// We will treat this as an empty volume label and not fail.
>> +	if (ret < 0 && ret != -ENOENT)
>> +		goto cleanup;
>> +
>> +	ret = exfat_alloc_volume_label(sb);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	mutex_lock(&sbi->s_lock);
> The sbi->s_lock should be acquired from the beginning of the function.
>
This would be better, I agree.
>> +	if (!ep)
>> +		memset(sbi->volume_label, 0, EXFAT_VOLUME_LABEL_LEN);
> If sbi->volume_label remains, a memset operation is required for
> EXFAT_VOLUME_LABEL_LEN * sizeof(short).
> 
>> +	else
>> +		for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +			sbi->volume_label[i] = le16_to_cpu(ep-
>>> dentry.volume_label.volume_label[i]);
>> +	mutex_unlock(&sbi->s_lock);
>> +
>> +	ret = 0;
>> +
>> +cleanup:
>> +	if (bh)
>> +		brelse(bh);
>> +
>> +	return ret;
>> +}
>> +
>> +int exfat_write_volume_label(struct super_block *sb,
>> +			     struct exfat_uni_name *uniname,
>> +			     struct inode *root_inode)
>> +{
>> +	int ret, i;
>> +	struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +	struct buffer_head *bh = NULL;
>> +	struct exfat_dentry *ep = NULL;
>> +
>> +	if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +		ret = -EINVAL;
>> +		goto cleanup;
>> +	}
>> +
>> +	ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, root_inode);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	ret = exfat_alloc_volume_label(sb);
>> +	if (ret < 0)
>> +		goto cleanup;
>> +
>> +	memcpy(sbi->volume_label, uniname->name,
>> +	       uniname->name_len * sizeof(short));
>> +
>> +	mutex_lock(&sbi->s_lock);
> The sbi->s_lock should be acquired from the beginning of the function.
>
Noted, thanks!
>> +	for (i = 0; i < uniname->name_len; i++)
>> +		ep->dentry.volume_label.volume_label[i] =
>> +			cpu_to_le16(sbi->volume_label[i]);
>> +	// Fill the rest of the str with 0x0000
>> +	for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +		ep->dentry.volume_label.volume_label[i] = 0x0000;
>> +
>> +	ep->dentry.volume_label.char_count = uniname->name_len;
>> +	mutex_unlock(&sbi->s_lock);
>> +
>> +	ret = 0;
>> +
>> +cleanup:
>> +	if (bh) {
>> +		exfat_update_bh(bh, true);
>> +		brelse(bh);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  /* mount the file system volume */
>>  static int __exfat_fill_super(struct super_block *sb,
>>  		struct exfat_chain *root_clu)
>> @@ -791,6 +1014,7 @@ static void delayed_free(struct rcu_head *p)
>>
>>  	unload_nls(sbi->nls_io);
>>  	exfat_free_upcase_table(sbi);
>> +	kfree(sbi->volume_label);
>>  	exfat_free_sbi(sbi);
>>  }
>>
>> --
>> 2.34.1
> 
> 

Thanks you for the sugestions,
Ethan Ferguson

