Return-Path: <linux-fsdevel+bounces-8535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CB838C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 11:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65851C230C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 10:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8006C5C8EB;
	Tue, 23 Jan 2024 10:40:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C35C619;
	Tue, 23 Jan 2024 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006454; cv=none; b=IYp+m96QVaiQKW1NU4ErEet1UnYCw18wyVJhhchBD1JRCO9IADZDjt6ACvoExYJscLtZY24o72jpuk1r0ktMbQtQCj1Sq8+aRGzQtzHsozUDlNwkUCoP02nFKKa2+/5p2/40p9tgPtF6FBqtII+6eHI/ubgs92u1VzhqPjZ/TiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006454; c=relaxed/simple;
	bh=x/7+wwKxczN3ej1c6k89cW/RUSox0yusws0gWmDca6o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRqXfimOFngLIKPl1iIAWPQGG1EVYCZ87hY1DYSSw4zQXQpe+AcupVXGuCqihnPwUHJ9LrJacxBR/2VDJbabuBecqEK/DWIkW32zJX2rw10AMN3UTF4Zn+NAx9mSHNCv3sBRDlbzYo5hu/HTbh8AMR1KChRmzIxFr5ec6Clnduk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W.CZc3u_1706006441;
Received: from 30.221.145.142(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W.CZc3u_1706006441)
          by smtp.aliyun-inc.com;
          Tue, 23 Jan 2024 18:40:42 +0800
Message-ID: <3d1d06de-cb59-40d7-b0df-110e7dc904d6@linux.alibaba.com>
Date: Tue, 23 Jan 2024 18:40:40 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] fuse: disable support for file handle when
 FUSE_EXPORT_SUPPORT not configured
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123093701.94166-1-jefflexu@linux.alibaba.com>
 <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgna=Eimk4KHUByk5ZRu7NKHTPJQukgV9GE_DNN_3_ztA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/24 6:17 PM, Amir Goldstein wrote:
> If you somehow find a way to mitigate the regression for NFS export of
> old fuse servers (maybe an opt-in Kconfig?), your patch is also going to
> regress AT_HANDLE_FID functionality, which can be used by fanotify to
> monitor fuse.
> 
> AT_HANDLE_FID flag to name_to_handle_at(2) means that
> open_by_handle_at(2) is not supposed to be called on that fh.
> 
> The correct way to deal with that would be something like this:
> 
> +static const struct export_operations fuse_fid_operations = {
> +       .encode_fh      = fuse_encode_fh,
> +};
> +
>  static const struct export_operations fuse_export_operations = {
>         .fh_to_dentry   = fuse_fh_to_dentry,
>         .fh_to_parent   = fuse_fh_to_parent,
> @@ -1529,12 +1533,16 @@ static void fuse_fill_attr_from_inode(struct
> fuse_attr *attr,
> 
>  static void fuse_sb_defaults(struct super_block *sb)
>  {
> +       struct fuse_mount *fm = get_fuse_mount_super(sb);
> +
>         sb->s_magic = FUSE_SUPER_MAGIC;
>         sb->s_op = &fuse_super_operations;
>         sb->s_xattr = fuse_xattr_handlers;
>         sb->s_maxbytes = MAX_LFS_FILESIZE;
>         sb->s_time_gran = 1;
> -       sb->s_export_op = &fuse_export_operations;
> +       if (fm->fc->export_support)
> +               sb->s_export_op = &fuse_export_operations;
> +       else
> +               sb->s_export_op = &fuse_fid_operations;
>         sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
>         if (sb->s_user_ns != &init_user_ns)
>                 sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
> 
> ---
> 
> This would make name_to_handle_at() without AT_HANDLE_FID fail
> and name_to_handle_at() with AT_HANDLE_FID to succeed as it should.
> 

Oh I didn't notice this.  Many thanks!


-- 
Thanks,
Jingbo

