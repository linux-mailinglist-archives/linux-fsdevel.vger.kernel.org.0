Return-Path: <linux-fsdevel+bounces-60021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A454B40E8B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48583AF8AD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 20:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F5E34DCC9;
	Tue,  2 Sep 2025 20:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="B9uMA0y7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDD9312810
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 20:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756844628; cv=none; b=n64fxK4B0siY8VOfpu29H+/Nud4sgyqRWmP775lCZBD0Iti3NdQACoO0HsZ5Sbnp2dbjh4bzdwh44AEMBPbLuX5n1YQAHiXCGSJTXMYjyOfJU+KCuPYV6MCCbym8GthK+ZB5Zrp8AKMD78JeP3rfCLrLEIZGEkUAbedRugKZ1lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756844628; c=relaxed/simple;
	bh=dldwsN7JwF159qfL19SWMfGJuEIEBMeOJ/lW1xsfG64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s+Pa9bIpk1hQ8I0vU59WC3RMLPb5I6/z9wGYXRShtMzG8736X/ZacNfE3fen2PLy5VmyoMtn7Zzcn5izoODzUZHzj5rZh2jELunGlXNK2rpRG7z15HB+jl1PPfPzUmR2rjmfR7UXfkl9OwYzecHESsCvhPqPJrurqk7sNZOEnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=B9uMA0y7; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b2f0660a7bso53162421cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Sep 2025 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756844624; x=1757449424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti1dNaEX5RAgN5lpAttUlDndIhL/boOtgWoq584IIFM=;
        b=B9uMA0y7ULitKSg4vCq9rcrnBaTKI2SOLqzi18WEIsspcPI7pytUjlP7GMDhClBPy6
         Nw1dShQIvyXB8TatAp34klaDzs4kOgoOSdsHi5fiLvVQNucz0uJG7JnVOocQhWrRuxen
         7BLAW4Xaa42s4CttJ321eIQEdQvfBSEGJek0W/9ArxlRmLAB8fVeIoH4j3zor5D54hMb
         DSWNIzWRCZ5+F+1eHMZa9ncKsv4AY7QmxSO/HYT+l84urk/xr2g1osN0PAiFg8K/UYjA
         c9ifi+k4fEIJHiRQXtEdS6o+aGGoM8xUk3kk2YPoL31SjLfRkivRpzSUyS4dNS4YLXbI
         PT2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756844624; x=1757449424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ti1dNaEX5RAgN5lpAttUlDndIhL/boOtgWoq584IIFM=;
        b=gXd1yivBY7irzv24Gd+UXEXmUFCClkov6lEewJ8hQELaA4GFtxCqwtXbUth2YG1lYK
         kaaH5HpHkukPHWy2tlCfbjxFUc+2htoaexTpjk9Xj8e8j3h3milf9ae1rN581yx1sMx7
         U17YxNzYhPbAFV9fBWUlBnjOKJZY2PG+dIfvGo21fw/12cAM8AIIPHpl9agywor7Q205
         OBoWUuKIC2o1cHzJT33/O4+/Lh7Eh0xKLiXFHpD8/A3WlY9RfJGoFOWIpVyG2iCATGcn
         QNfh1vFa09sN+AcjZL5imSfxBZwG28k/fEr/NQc5PsuJdUtTkxhuGKpJg2/J0E5tfOEJ
         JEPw==
X-Forwarded-Encrypted: i=1; AJvYcCUsvnakDVqbHjQQJLOiozXwbz6JsMfg4jOnME4DHY63oIJ4VEAj3iheZg6DQZIVJ1WhSjMxZ8nLfoosTqSG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbhy9GMiVmiO778V89NSDC6oWm0FFypLVZDHUbZJT8J6oQhV3N
	63qz3JP3qLBtE5Kpnnw8wsRNGRW4sieax8ErjXoKsy0ghGFwz37pPs4qC1fLzQbymjDHV62/uss
	wfeY6
X-Gm-Gg: ASbGncuMuTIVVtrEj9iBSvK0OINJQwJGDLUaylWYyM4Gg/56CzPuJBkhcavD2OQsUrM
	EG7fepz7Uw8dMeDHaaxeiI+fuZX0J7xUvISj0zpjOHB5o1srI99KcKRTxNys0Fd2z/AhEWMbCE1
	ysvUOP2Y/Tf/E/JYAvl6xle9uVx+Rs5GbHU6mtVCXP+GXbRi4pLCOqhBw6aaxdyWJjsTNMA+Kst
	Pw0dcPkbHMWC/djTpsXpfgLwhSE5dllHggkksHEnHjUWByMBJ8sqXkoBe2wP1O5dJaQNPRqT4YQ
	nPoAlOAMEXsVOA03X4D3VDOMCYnz6NoMK9NPUhEpe6lyLK4UpEcbnJKtcr+gF29Y+VvZrSP8lSG
	010Tn6U/6Bh1URCFvTFHMdF48dyZ8+FIqiWErsLX52JA4VMoI
X-Google-Smtp-Source: AGHT+IHUsaSnoZSo/var0yLCu9AO/fvoiQsemCFj3Gw1dysdd2u/8NiVBo76Ya0LxI9XAMdMj2Fr8g==
X-Received: by 2002:a05:622a:4d97:b0:4b3:c25:7280 with SMTP id d75a77b69052e-4b31dd5679cmr186031381cf.71.1756844624181;
        Tue, 02 Sep 2025 13:23:44 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7a1738sm280951cf.46.2025.09.02.13.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 13:23:43 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: yuezhang.mo@sony.com
Cc: ethan.ferguson@zetier.com,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com
Subject: RE: [PATCH v4 0/1] exfat: Add support for FS_IOC_{GET,SET}FSLABEL
Date: Tue,  2 Sep 2025 16:23:06 -0400
Message-Id: <20250902202306.86404-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <PUZPR04MB63160C89856D1164322B643E8106A@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <PUZPR04MB63160C89856D1164322B643E8106A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/2/25 00:55, Yuezhang.Mo@sony.com wrote:
> Hi,
> 
> I have 3 more comments.
> 
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
>>       struct buffer_head **vol_amap; /* allocation bitmap */
>>
>>       unsigned short *vol_utbl; /* upcase table */
>> +     unsigned short *volume_label; /* volume name */
>>
>>       unsigned int clu_srch_ptr; /* cluster search pointer */
>>       unsigned int used_clusters; /* number of used clusters */
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
>>       return exfat_force_shutdown(sb, flags);
>>  }
>>
>> +static int exfat_ioctl_get_volume_label(struct super_block *sb, unsigned
>> long arg)
>> +{
>> +     int ret;
>> +     char utf8[FSLABEL_MAX] = {0};
>> +     struct exfat_uni_name *uniname;
>> +     struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +
>> +     uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>> +     if (!uniname)
>> +             return -ENOMEM;
>> +
>> +     ret = exfat_read_volume_label(sb);
>> +     if (ret < 0)
>> +             goto cleanup;
>> +
>> +     memcpy(uniname->name, sbi->volume_label,
>> +            EXFAT_VOLUME_LABEL_LEN * sizeof(short));
>> +     uniname->name[EXFAT_VOLUME_LABEL_LEN] = 0x0000;
>> +     uniname->name_len = UniStrnlen(uniname->name,
>> EXFAT_VOLUME_LABEL_LEN);
>> +
>> +     ret = exfat_utf16_to_nls(sb, uniname, utf8, FSLABEL_MAX);
>> +     if (ret < 0)
>> +             goto cleanup;
>> +
>> +     if (copy_to_user((char __user *)arg, utf8, FSLABEL_MAX)) {
>> +             ret = -EFAULT;
>> +             goto cleanup;
>> +     }
>> +
>> +     ret = 0;
>> +
>> +cleanup:
>> +     kfree(uniname);
>> +     return ret;
>> +}
>> +
>> +static int exfat_ioctl_set_volume_label(struct super_block *sb,
>> +                                     unsigned long arg,
>> +                                     struct inode *root_inode)
>> +{
>> +     int ret, lossy;
>> +     char utf8[FSLABEL_MAX];
>> +     struct exfat_uni_name *uniname;
>> +
>> +     if (!capable(CAP_SYS_ADMIN))
>> +             return -EPERM;
>> +
>> +     uniname = kmalloc(sizeof(struct exfat_uni_name), GFP_KERNEL);
>> +     if (!uniname)
>> +             return -ENOMEM;
>> +
>> +     if (copy_from_user(utf8, (char __user *)arg, FSLABEL_MAX)) {
>> +             ret = -EFAULT;
>> +             goto cleanup;
>> +     }
>> +
>> +     if (utf8[0]) {
>> +             ret = exfat_nls_to_utf16(sb, utf8, strnlen(utf8,
>> FSLABEL_MAX),
>> +                                      uniname, &lossy);
>> +             if (ret < 0)
>> +                     goto cleanup;
>> +             else if (lossy & NLS_NAME_LOSSY) {
>> +                     ret = -EINVAL;
>> +                     goto cleanup;
>> +             }
>> +     } else {
>> +             uniname->name[0] = 0x0000;
>> +             uniname->name_len = 0;
>> +     }
>> +
>> +     if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +             exfat_info(sb, "Volume label length too long, truncating");
>> +             uniname->name_len = EXFAT_VOLUME_LABEL_LEN;
>> +     }
>> +
>> +     ret = exfat_write_volume_label(sb, uniname, root_inode);
>> +
>> +cleanup:
>> +     kfree(uniname);
>> +     return ret;
>> +}
>> +
>>  long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>  {
>>       struct inode *inode = file_inode(filp);
>>       u32 __user *user_attr = (u32 __user *)arg;
>> +     struct inode *root_inode = filp->f_path.mnt->mnt_root->d_inode;
>>
>>       switch (cmd) {
>>       case FAT_IOCTL_GET_ATTRIBUTES:
>> @@ -500,6 +584,10 @@ long exfat_ioctl(struct file *filp, unsigned int cmd,
>> unsigned long arg)
>>               return exfat_ioctl_shutdown(inode->i_sb, arg);
>>       case FITRIM:
>>               return exfat_ioctl_fitrim(inode, arg);
>> +     case FS_IOC_GETFSLABEL:
>> +             return exfat_ioctl_get_volume_label(inode->i_sb, arg);
>> +     case FS_IOC_SETFSLABEL:
>> +             return exfat_ioctl_set_volume_label(inode->i_sb, arg,
>> root_inode);
>>       default:
>>               return -ENOTTY;
>>       }
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
>>       return 0;
>>  }
>>
>> +static int exfat_get_volume_label_ptrs(struct super_block *sb,
>> +                                    struct buffer_head **out_bh,
>> +                                    struct exfat_dentry **out_dentry,
>> +                                    struct inode *root_inode)
>> +{
>> +     int i, ret;
>> +     unsigned int type, old_clu;
>> +     struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +     struct exfat_chain clu;
>> +     struct exfat_dentry *ep, *deleted_ep = NULL;
>> +     struct buffer_head *bh, *deleted_bh;
>> +
>> +     clu.dir = sbi->root_dir;
>> +     clu.flags = ALLOC_FAT_CHAIN;
>> +
>> +     while (clu.dir != EXFAT_EOF_CLUSTER) {
>> +             for (i = 0; i < sbi->dentries_per_clu; i++) {
>> +                     ep = exfat_get_dentry(sb, &clu, i, &bh);
>> +
>> +                     if (!ep) {
>> +                             ret = -EIO;
>> +                             goto end;
>> +                     }
>> +
>> +                     type = exfat_get_entry_type(ep);
>> +                     if (type == TYPE_DELETED && !deleted_ep && root_inode)
>> {
>> +                             deleted_ep = ep;
>> +                             deleted_bh = bh;
>> +                             continue;
>> +                     }
>> +
>> +                     if (type == TYPE_UNUSED) {
>> +                             if (!root_inode) {
>> +                                     brelse(bh);
>> +                                     ret = -ENOENT;
>> +                                     goto end;
>> +                             }
>> +
>> +                             if (deleted_ep) {
>> +                                     brelse(bh);
>> +                                     goto end;
>> +                             }
>> +
>> +                             if (i < sbi->dentries_per_clu - 1) {
>> +                                     deleted_ep = ep;
>> +                                     deleted_bh = bh;
>> +
>> +                                     ep = exfat_get_dentry(sb, &clu,
>> +                                                           i + 1, &bh);
>> +                                     memset(ep, 0,
>> +                                            sizeof(struct exfat_dentry));
>> +                                     ep->type = EXFAT_UNUSED;
>> +                                     exfat_update_bh(bh, true);
>> +                                     brelse(bh);
>> +
>> +                                     goto end;
>> +                             }
>> +
>> +                             // Last dentry in cluster
> 
> Please use /* */ to comment.
> 
>> +                             clu.size = 0;
>> +                             old_clu = clu.dir;
>> +                             ret = exfat_alloc_cluster(root_inode, 1,
>> +                                                       &clu, true);
>> +                             if (ret < 0) {
>> +                                     brelse(bh);
>> +                                     goto end;
>> +                             }
> 
> In exFAT, directory size is limited to 256MB. Please add a check to return -ENOSPC
> instead of allocating a new cluster if the root directory size had reached this limit. 
>
Noted. I am switching over to using exfat_find_empty_entry, which
checks for this.
>> +
>> +                             ret = exfat_ent_set(sb, old_clu, clu.dir);
>> +                             if (ret < 0) {
>> +                                     exfat_free_cluster(root_inode, &clu);
>> +                                     brelse(bh);
>> +                                     goto end;
>> +                             }
>> +
>> +                             ret = exfat_zeroed_cluster(root_inode, clu.dir);
>> +                             if (ret < 0) {
>> +                                     exfat_free_cluster(root_inode, &clu);
>> +                                     brelse(bh);
>> +                                     goto end;
>> +                             }
> 
> After allocating a new cluster for the root directory, its size needs to be updated.
>
Where would I update the size? I don't think the root directory has a
Stream Extension dentry, would I increment the exfat_inode_info.dir.size
field?
>> +
>> +                             deleted_ep = ep;
>> +                             deleted_bh = bh;
>> +                             goto end;
>> +                     }
>> +
>> +                     if (type == TYPE_VOLUME) {
>> +                             *out_bh = bh;
>> +                             *out_dentry = ep;
>> +
>> +                             if (deleted_ep)
>> +                                     brelse(deleted_bh);
>> +
>> +                             return 0;
>> +                     }
>> +
>> +                     brelse(bh);
>> +             }
>> +
>> +             if (exfat_get_next_cluster(sb, &(clu.dir))) {
>> +                     ret = -EIO;
>> +                     goto end;
>> +             }
>> +     }
>> +
>> +     ret = -EIO;
>> +
>> +end:
>> +     if (deleted_ep) {
>> +             *out_bh = deleted_bh;
>> +             *out_dentry = deleted_ep;
>> +             memset((*out_dentry), 0, sizeof(struct exfat_dentry));
>> +             (*out_dentry)->type = EXFAT_VOLUME;
>> +             return 0;
>> +     }
>> +
>> +     *out_bh = NULL;
>> +     *out_dentry = NULL;
>> +     return ret;
>> +}
>> +
>> +static int exfat_alloc_volume_label(struct super_block *sb)
>> +{
>> +     struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +
>> +     if (sbi->volume_label)
>> +             return 0;
>> +
>> +
>> +     mutex_lock(&sbi->s_lock);
>> +     sbi->volume_label = kcalloc(EXFAT_VOLUME_LABEL_LEN,
>> +                                                  sizeof(short), GFP_KERNEL);
>> +     mutex_unlock(&sbi->s_lock);
>> +
>> +     if (!sbi->volume_label)
>> +             return -ENOMEM;
>> +
>> +     return 0;
>> +}
>> +
>> +int exfat_read_volume_label(struct super_block *sb)
>> +{
>> +     int ret, i;
>> +     struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +     struct buffer_head *bh = NULL;
>> +     struct exfat_dentry *ep = NULL;
>> +
>> +     ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, NULL);
>> +     // ENOENT signifies that a volume label dentry doesn't exist
>> +     // We will treat this as an empty volume label and not fail.
>> +     if (ret < 0 && ret != -ENOENT)
>> +             goto cleanup;
>> +
>> +     ret = exfat_alloc_volume_label(sb);
>> +     if (ret < 0)
>> +             goto cleanup;
>> +
>> +     mutex_lock(&sbi->s_lock);
>> +     if (!ep)
>> +             memset(sbi->volume_label, 0, EXFAT_VOLUME_LABEL_LEN);
>> +     else
>> +             for (i = 0; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +                     sbi->volume_label[i] = le16_to_cpu(ep-
>>> dentry.volume_label.volume_label[i]);
>> +     mutex_unlock(&sbi->s_lock);
>> +
>> +     ret = 0;
>> +
>> +cleanup:
>> +     if (bh)
>> +             brelse(bh);
>> +
>> +     return ret;
>> +}
>> +
>> +int exfat_write_volume_label(struct super_block *sb,
>> +                          struct exfat_uni_name *uniname,
>> +                          struct inode *root_inode)
>> +{
>> +     int ret, i;
>> +     struct exfat_sb_info *sbi = EXFAT_SB(sb);
>> +     struct buffer_head *bh = NULL;
>> +     struct exfat_dentry *ep = NULL;
>> +
>> +     if (uniname->name_len > EXFAT_VOLUME_LABEL_LEN) {
>> +             ret = -EINVAL;
>> +             goto cleanup;
>> +     }
>> +
>> +     ret = exfat_get_volume_label_ptrs(sb, &bh, &ep, root_inode);
>> +     if (ret < 0)
>> +             goto cleanup;
>> +
>> +     ret = exfat_alloc_volume_label(sb);
>> +     if (ret < 0)
>> +             goto cleanup;
>> +
>> +     memcpy(sbi->volume_label, uniname->name,
>> +            uniname->name_len * sizeof(short));
>> +
>> +     mutex_lock(&sbi->s_lock);
>> +     for (i = 0; i < uniname->name_len; i++)
>> +             ep->dentry.volume_label.volume_label[i] =
>> +                     cpu_to_le16(sbi->volume_label[i]);
>> +     // Fill the rest of the str with 0x0000
>> +     for (; i < EXFAT_VOLUME_LABEL_LEN; i++)
>> +             ep->dentry.volume_label.volume_label[i] = 0x0000;
>> +
>> +     ep->dentry.volume_label.char_count = uniname->name_len;
>> +     mutex_unlock(&sbi->s_lock);
>> +
>> +     ret = 0;
>> +
>> +cleanup:
>> +     if (bh) {
>> +             exfat_update_bh(bh, true);
>> +             brelse(bh);
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>>  /* mount the file system volume */
>>  static int __exfat_fill_super(struct super_block *sb,
>>               struct exfat_chain *root_clu)
>> @@ -791,6 +1014,7 @@ static void delayed_free(struct rcu_head *p)
>>
>>       unload_nls(sbi->nls_io);
>>       exfat_free_upcase_table(sbi);
>> +     kfree(sbi->volume_label);
>>       exfat_free_sbi(sbi);
>>  }
>>
>> --
>> 2.34.1

