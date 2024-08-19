Return-Path: <linux-fsdevel+bounces-26260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C139956AAF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 14:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1658BB24BAC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2024 12:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB716B3B8;
	Mon, 19 Aug 2024 12:22:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC116B3A3;
	Mon, 19 Aug 2024 12:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070166; cv=none; b=cc7w9C+5CCFDafZQzxM6uNbBspjSWD0mb0buG/nxGx/vkuz/+igPfWX+cvS/8qM12KovAVuyuZxa008eA5dtU0oseQAqYb5aBT26YPsVNAXZDXLJA34SdD1JkobJWMAK+5uF2OE3Uu+jFCl46/TDBQEsqdx+oKokktZgJFFz8SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070166; c=relaxed/simple;
	bh=KbhLAfk7Tce1c5moY4E2Fw2cl5jXZgt1xlAgNKyCp+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IXEoBt2XZtU11jjao5WMsctVIGJrkxC+7OLdOXwp5UkXz3MTbCCBg84TUG6Fddo7ozcbWU4Fettv/1VCCdOEJ1b/hjeLkiJfTeffpFIjwhPTBz5Ru5lYU/GxRg/HNXwVz6GuE7EcclAuj6uRjaO2nMEELaWcEnOECYum+dkosxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WnWng4VYrz2Cmyb;
	Mon, 19 Aug 2024 20:17:43 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 299981A0188;
	Mon, 19 Aug 2024 20:22:42 +0800 (CST)
Received: from [10.67.108.52] (10.67.108.52) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 19 Aug
 2024 20:22:41 +0800
Message-ID: <9b3795de-c67c-4582-9eb1-bed096b3eb67@huawei.com>
Date: Mon, 19 Aug 2024 20:22:41 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] zonefs: add support for FS_IOC_GETFSSYSFSPATH
Content-Language: en-US
To: <linux-fsdevel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <dlemoal@kernel.org>,
	<naohiro.aota@wdc.com>, <jth@kernel.org>
References: <20240809013627.3546649-1-liaochen4@huawei.com>
From: "liaochen (A)" <liaochen4@huawei.com>
In-Reply-To: <20240809013627.3546649-1-liaochen4@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500020.china.huawei.com (7.185.36.49)

On 2024/8/9 9:36, Liao Chen wrote:
> FS_IOC_GETFSSYSFSPATH ioctl expects sysfs sub-path of a filesystem, the
> format can be "$FSTYP/$SYSFS_IDENTIFIER" under /sys/fs, it can helps to
> standardizes exporting sysfs datas across filesystems.
> 
> This patch wires up FS_IOC_GETFSSYSFSPATH for zonefs, it will output
> "zonefs/<dev>".
> 
> Signed-off-by: Liao Chen <liaochen4@huawei.com>
> ---
>   fs/zonefs/super.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index faf1eb87895d..e180daa39578 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -1262,6 +1262,7 @@ static int zonefs_fill_super(struct super_block *sb, struct fs_context *fc)
>   	sb->s_maxbytes = 0;
>   	sb->s_op = &zonefs_sops;
>   	sb->s_time_gran	= 1;
> +	super_set_sysfs_name_id(sb);
>   
>   	/*
>   	 * The block size is set to the device zone write granularity to ensure
Gentle ping

Thanks,
Chen

