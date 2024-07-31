Return-Path: <linux-fsdevel+bounces-24660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403879427D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 09:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CD661C21109
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2024 07:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E28C1A71EE;
	Wed, 31 Jul 2024 07:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agZ8kPXq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E816CD29;
	Wed, 31 Jul 2024 07:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722410792; cv=none; b=NMXdfI7+7pHIW3/87lJHlfkTFSf4uJjka3763AIFaCs+ERitMTsDYfNH+YBLMfYPRL/Lji1k2TzG3dPpJDfy4REr+2hO8SKqjYlSUEjeFJPmlTQ59Y/R41zEewFUljDk9kNJln8ALlMMvyfc1m+n9jDAR6fClF9/mFRnVxAi5z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722410792; c=relaxed/simple;
	bh=KEj5Hysbcu7TyAUrgefMC/+xNLZtS7eOoyIhkUIaM9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYzIBtX2DGS7J7kulVHqgaFDuEV3a86CF2px4tUOBKUPVqqW5l+3Xw/3RSUNEY4g+V5A3HSUG8D4skyHZrGjWd97/7jvdrm06+fFYmT8oXqex+kzx7FKPdx8euUN3ujIdi34o7riIiMfxHf87oviKHIMTke3wWA6jWNyTzOMQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agZ8kPXq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60530C116B1;
	Wed, 31 Jul 2024 07:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722410791;
	bh=KEj5Hysbcu7TyAUrgefMC/+xNLZtS7eOoyIhkUIaM9E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=agZ8kPXqaUfOg6SnQ4wJEPxA6JAUAu2W8tS1ykzJVzouh3JLy6L25Dj23rrRu1V4E
	 StVrI/ALbYuMJdj+2dasXwtDPXZ7/ttPCcb3dTutykv7k5efSGg6BZGegDoZphLun7
	 fl2QPLxlL/nnh0vHw6xiQs2a5DIaqdCpXtJ+a/EW/MdEHWwPagHBfPpEOUTCuV8Mi6
	 8IXP1F7ifM45FeIyUEUx7ajIVo30IwOBXV5V2Gz5iogpR3c4jOBwBtDSwy2RzhcmTl
	 BxkckmzOn1hYke5EYpuXPwWxO82dxtQtdLydbF1zqscLWan4/78vsMvbS6++IEvTHx
	 0Wtvg+NSi/5qg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c6661bca43so3334421eaf.0;
        Wed, 31 Jul 2024 00:26:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUr1NOP8XZjQiIV6YwkGa99k2YuqsOuvRVnQ91Okl6TEi4KRVTV3+FLsCj1CmDECaGChjbooMKD3rWtUZgwb472WqiFl/6w11JJVWiFJuzdVVQUMtasdMNFeXU6L0v5fBYctpJmH8p6Z9thLQ==
X-Gm-Message-State: AOJu0Yz+yCp8bdGtjCMt7DB4qI3GIH0l7fc8ja276pVaBi56T8/5GB16
	hOm5QtSnIYumhQoa6eb7tw0YOJh6YP9qmGGHrnaA3fax3kDpC4EoFwF24/GZT6rfWCU3nj1LaHv
	TTVnddS9WvcnC/JWfh7gGQ+iShbo=
X-Google-Smtp-Source: AGHT+IFZ3/ynt9o5Y0iPThJsqplwU0njdNj0tMvR6tFAXumYHoZ2q7Lor68bIiG3MHLu5I+lwqTi1EfwMwgJhZRkXFU=
X-Received: by 2002:a05:6820:3093:b0:5d5:b226:2ff5 with SMTP id
 006d021491bc7-5d5d09f54e5mr14309972eaf.0.1722410790697; Wed, 31 Jul 2024
 00:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731022715.4044482-1-dongliang.cui@unisoc.com>
In-Reply-To: <20240731022715.4044482-1-dongliang.cui@unisoc.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 31 Jul 2024 16:26:19 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9SbOfkHCeynzdhF-H4ejxSGoz1Bhv60qJmgQQkpQsptA@mail.gmail.com>
Message-ID: <CAKYAXd9SbOfkHCeynzdhF-H4ejxSGoz1Bhv60qJmgQQkpQsptA@mail.gmail.com>
Subject: Re: [PATCH v3] exfat: check disk status during buffer write
To: Dongliang Cui <dongliang.cui@unisoc.com>
Cc: sj1557.seo@samsung.com, hch@infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, 
	ke.wang@unisoc.com, Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2024=EB=85=84 7=EC=9B=94 31=EC=9D=BC (=EC=88=98) =EC=98=A4=EC=A0=84 11:29, =
Dongliang Cui <dongliang.cui@unisoc.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
>
> We found that when writing a large file through buffer write, if the
> disk is inaccessible, exFAT does not return an error normally, which
> leads to the writing process not stopping properly.
>
> To easily reproduce this issue, you can follow the steps below:
>
> 1. format a device to exFAT and then mount (with a full disk erase)
> 2. dd if=3D/dev/zero of=3D/exfat_mount/test.img bs=3D1M count=3D8192
> 3. eject the device
>
> You may find that the dd process does not stop immediately and may
> continue for a long time.
>
> The root cause of this issue is that during buffer write process,
> exFAT does not need to access the disk to look up directory entries
> or the FAT table (whereas FAT would do) every time data is written.
> Instead, exFAT simply marks the buffer as dirty and returns,
> delegating the writeback operation to the writeback process.
>
> If the disk cannot be accessed at this time, the error will only be
> returned to the writeback process, and the original process will not
> receive the error, so it cannot be returned to the user side.
>
> When the disk cannot be accessed normally, an error should be returned
> to stop the writing process.
>
> Signed-off-by: Dongliang Cui <dongliang.cui@unisoc.com>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
> Changes in v3:
>  - Implement .shutdown to monitor disk status.
> ---
>  fs/exfat/exfat_fs.h | 10 ++++++++++
>  fs/exfat/inode.c    |  3 +++
>  fs/exfat/super.c    | 11 +++++++++++
>  3 files changed, 24 insertions(+)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index ecc5db952deb..c6cf36070aa3 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -148,6 +148,9 @@ enum {
>  #define DIR_CACHE_SIZE         \
>         (DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
>
> +/* Superblock flags */
> +#define EXFAT_FLAGS_SHUTDOWN   1
> +
>  struct exfat_dentry_namebuf {
>         char *lfn;
>         int lfnbuf_len; /* usually MAX_UNINAME_BUF_SIZE */
> @@ -267,6 +270,8 @@ struct exfat_sb_info {
>         unsigned int clu_srch_ptr; /* cluster search pointer */
>         unsigned int used_clusters; /* number of used clusters */
>
> +       unsigned long s_exfat_flags; /* Exfat superblock flags */
> +
>         struct mutex s_lock; /* superblock lock */
>         struct mutex bitmap_lock; /* bitmap lock */
>         struct exfat_mount_options options;
> @@ -338,6 +343,11 @@ static inline struct exfat_inode_info *EXFAT_I(struc=
t inode *inode)
>         return container_of(inode, struct exfat_inode_info, vfs_inode);
>  }
>
> +static inline int exfat_forced_shutdown(struct super_block *sb)
> +{
> +       return test_bit(EXFAT_FLAGS_SHUTDOWN, &EXFAT_SB(sb)->s_exfat_flag=
s);
> +}
> +
>  /*
>   * If ->i_mode can't hold 0222 (i.e. ATTR_RO), we use ->i_attrs to
>   * save ATTR_RO instead of ->i_mode.
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index dd894e558c91..b1b814183494 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -452,6 +452,9 @@ static int exfat_write_begin(struct file *file, struc=
t address_space *mapping,
>  {
>         int ret;
>
> +       if (unlikely(exfat_forced_shutdown(mapping->host->i_sb)))
> +               return -EIO;
We need to add this to other write operations(exfat_create, unlink,
mkdir, rmdir, rename, setattr, writepages)
as well as exfat_write_begin().
Thanks.

