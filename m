Return-Path: <linux-fsdevel+bounces-48926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2A1AB6054
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 03:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 504B74A4925
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 01:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E038C7E0E4;
	Wed, 14 May 2025 01:03:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616528DD0
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 01:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747184618; cv=none; b=gM9/NH9nSoWRU2kfdp5ijOJ+pazwtDbFmGZwJhM7ZsZwpe1lgQSP+tpYpTuaIgJF7YgonjO8+56jWB/aRgqAdTtMFLP8BD+EjZ9uSRgqZrrj3EPGyXG2wGiK7ObTpzH0bCpLcmzLCgkoTvJtkcsplb398mcdAKTlUqY/nEPDxOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747184618; c=relaxed/simple;
	bh=rJqXbYLnV4H5nlU8Yu2c4pimYysj/T77CfRkw7HoaPc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LByuuRZ5cndFfOqM6o60JQgIblxlytmcoJ4S8Mhh2b9Gba7CBDaPj+nzuqN0yUuR+VaiaUnhKHhX9u3YHwA3fDbDiownpXJbmx/X5Z3lLST+N2+3nPym3F95bHSTfRy13BMQ26ImlxRzsvBdgkuoK/OVIHFb4FXBmqu3CR/clmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Zxw6b4JLKztRc4;
	Wed, 14 May 2025 09:02:15 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 9AEF4180487;
	Wed, 14 May 2025 09:03:32 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 May 2025 09:03:32 +0800
Message-ID: <6e14ecbb-b65d-4a1e-a7f0-836284d098b6@huawei.com>
Date: Wed, 14 May 2025 09:03:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 5/7] f2fs: separate the options parsing and options
 checking
To: Eric Sandeen <sandeen@redhat.com>, Chao Yu <chao@kernel.org>,
	<linux-f2fs-devel@lists.sourceforge.net>
CC: <linux-fsdevel@vger.kernel.org>, <jaegeuk@kernel.org>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-6-sandeen@redhat.com>
 <61cc47ec-787a-4cad-b7c1-3248dafbea79@kernel.org>
 <7a2d79f3-d524-4dd3-afff-b6f658935151@redhat.com>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <7a2d79f3-d524-4dd3-afff-b6f658935151@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500009.china.huawei.com (7.202.194.199)



On 2025/5/8 23:52, Eric Sandeen wrote:
> On 5/8/25 3:13 AM, Chao Yu wrote:
>> On 4/24/25 01:08, Eric Sandeen wrote:
>>> From: Hongbo Li <lihongbo22@huawei.com>
> 
> ...
> 
>>> +	if (ctx->qname_mask) {
>>> +		for (i = 0; i < MAXQUOTAS; i++) {
>>> +			if (!(ctx->qname_mask & (1 << i)))
>>> +				continue;
>>> +
>>> +			old_qname = F2FS_OPTION(sbi).s_qf_names[i];
>>> +			new_qname = F2FS_CTX_INFO(ctx).s_qf_names[i];
>>> +			if (quota_turnon &&
>>> +				!!old_qname != !!new_qname)
>>> +				goto err_jquota_change;
>>> +
>>> +			if (old_qname) {
>>> +				if (strcmp(old_qname, new_qname) == 0) {
>>> +					ctx->qname_mask &= ~(1 << i);
>>
>> Needs to free and nully F2FS_CTX_INFO(ctx).s_qf_names[i]?
>>
> 
> I will have to look into this. If s_qf_names are used/applied, they get
> transferred to the sbi in f2fs_apply_quota_options and are freed in the
> normal course of the fiesystem lifetime, i.e at unmount in f2fs_put_super.
> That's the normal non-error lifecycle of the strings.
> 
> If they do not get transferred to the sbi in f2fs_apply_quota_options, they
> remain on the ctx, and should get freed in f2fs_fc_free:
> 
>          for (i = 0; i < MAXQUOTAS; i++)
>                  kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
> 
> It is possible to free them before f2fs_fc_free of course and that might
> be an inconsistency in this function, because we do that in the other case
> in the check_consistency function:
> 
>                          if (quota_feature) {
>                                  f2fs_info(sbi, "QUOTA feature is enabled, so ignore qf_name");
>                                  ctx->qname_mask &= ~(1 << i);
>                                  kfree(F2FS_CTX_INFO(ctx).s_qf_names[i]);
>                                  F2FS_CTX_INFO(ctx).s_qf_names[i] = NULL;
>                          }
> 
> I'll have to look at it a bit more. But this is modeled on ext4's
> ext4_check_quota_consistency(), and it does not do any freeing in that
> function; it leaves freeing in error cases to when the fc / ctx gets freed.
> 
> But tl;dr: I think we can remove the kfree and "= NULL" in this function,
> and defer the freeing in the error case.
> 
>>> +
>>> +static inline void clear_compression_spec(struct f2fs_fs_context *ctx)
>>> +{
>>> +	ctx->spec_mask &= ~(F2FS_SPEC_compress_algorithm
>>> +						| F2FS_SPEC_compress_log_size
>>> +						| F2FS_SPEC_compress_extension
>>> +						| F2FS_SPEC_nocompress_extension
>>> +						| F2FS_SPEC_compress_chksum
>>> +						| F2FS_SPEC_compress_mode);
>>
>> How about add a macro to include all compression macros, and use it to clean
>> up above codes?
> 
> That's a good idea and probably easy enough to do without rebase pain.
>   
>>> +
>>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>>> +				F2FS_CTX_INFO(ctx).extensions,
>>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
>>
>> Can you please describe what is detailed confliction in the log? e.g. new
>> noext conflicts w/ new ext...
> 
> Hmm, let me think about this. I had not noticed it was calling
> f2fs_test_compress_extension 3 times, I wonder if there is a better option.
> I need to understand this approach better. Maybe Hongbo has thoughts.
> 
ah, I kept it with the older format. And they should check the unmatched 
conflict between ctx and sbi.

Thanks,
Hongbo

>>> +		return -EINVAL;
>>> +	}
>>> +	if (f2fs_test_compress_extension(F2FS_CTX_INFO(ctx).noextensions,
>>> +				F2FS_CTX_INFO(ctx).nocompress_ext_cnt,
>>> +				F2FS_OPTION(sbi).extensions,
>>> +				F2FS_OPTION(sbi).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
>>
>> Ditto,
>>
>>> +		return -EINVAL;
>>> +	}
>>> +	if (f2fs_test_compress_extension(F2FS_OPTION(sbi).noextensions,
>>> +				F2FS_OPTION(sbi).nocompress_ext_cnt,
>>> +				F2FS_CTX_INFO(ctx).extensions,
>>> +				F2FS_CTX_INFO(ctx).compress_ext_cnt)) {
>>> +		f2fs_err(sbi, "invalid compress or nocompress extension");
>>
>> Ditto,
> 
> thanks,
> -Eric
> 
> 

