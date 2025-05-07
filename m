Return-Path: <linux-fsdevel+bounces-48416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA6BAAECC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDEF9E2242
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AB1202996;
	Wed,  7 May 2025 20:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SLZpIPOy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C05F28373
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649197; cv=none; b=IaiZnHUXOXI5lVnlNMepGzAoQgVehzIudh7vngOkaiwa2pL37xyZFGYjhH4U7OSlpQJhtvjjtXVR0xWwrPJwXi5N+NXu3JllVCknduiyjnhQJoccErtlU6JXZIkHaO/jXy287mOlAAYjTzTKJWuA/JdmE34Bw0uhALBOFN6qjOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649197; c=relaxed/simple;
	bh=QXR1iKFGrFt0LWDYthgg9ptqwvkcM27HP465V1TEtQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=liB1B6uSqo6C0T3GZT/wkaAsKfrC803r7B1DNTBsQ1wktarN73I5c8oC5sPXpdmd62EN0pZ+uaCForW2iBdHjjiJfOBngPIU+p6i90DNwdsfQ0WERDjzsAJyDRNiiIrnM34YqrklUoJpltc0stF8dp429opfiHq8QNz9QcRrIFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SLZpIPOy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746649194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bo8aK9h6rUqnvOG4WGxf5znAkmeNi5YW75Ok0lpquB4=;
	b=SLZpIPOyrVZHLGQwjd7wlKQ0Gs+QCuqIoeEeIiRCo/+ni1Trh6gPvvWsrMLTXKFhslJusB
	pT5XMwuXZ/eNtcUJ9j0M5qmPZ4d+GZ/X5K/UfCulrCH+Zwa5OeU/Lvkzd6GVC7QktRhCI7
	pmvFeoROMpaXs2wckyOrwrcwLtNsONA=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-PW1xSERdNUGrfk6swP9tOA-1; Wed, 07 May 2025 16:19:52 -0400
X-MC-Unique: PW1xSERdNUGrfk6swP9tOA-1
X-Mimecast-MFC-AGG-ID: PW1xSERdNUGrfk6swP9tOA_1746649192
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3da717e86b1so2451545ab.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746649192; x=1747253992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bo8aK9h6rUqnvOG4WGxf5znAkmeNi5YW75Ok0lpquB4=;
        b=AyD5J5xU/SkSzLynhkJS3kw1gcFKdS5REwN3yJx+FqIQEjvsQrmM+65+tO2Nyy69PK
         vinHg1eXuglTjKAZAuaMBoYapWg0FPnBLbQ06vXVKDnACWWTfkX8Z8tLuAzYLKg5m229
         5gJMjacpMJXBrazk4LmaMG8UzDoF61tbGJ7nWAYyrUXHJMedQ8siUZi6MMHbZdRsIenB
         lfDNo/6VOKHee6tZJOYXPrTy1R+p2fr2U4hbLjd4JfZhtmmJ5qOMAqyqWnpKF8JXzjAe
         3F7g1PPq9ig2RUJtB4azUHOqEg5i0BiTobYLVvxFXsJu2q3jLx0qOBPoYYUCiaOXXFlL
         7SEw==
X-Forwarded-Encrypted: i=1; AJvYcCWlkShkBluQPS5tVKD84/6MZSwVVmmuAQkaRQu3peOsirdHLw3pKaGlxmYnro98Xuii3EudgcZ2eb8O3Iim@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ4KorftrzgyR55oKXuXOsqjiRc44X2CHg1RGHjdq9MXpcV4Jf
	3rmDDzVvMg/aRZRql+ygzYCe0nw9H65nLYo/UerMDJFwlG4iKS1M5gabHw0SlufIN78INluuc7+
	dUYhOEh/KyYMrCRcSwhJUMYymKCcsLBaMSouJ7KnDvpIHpdK3Dy8X8vCERCpY9tw=
X-Gm-Gg: ASbGncuhYI+gPSG29QXN635k9afPBa/ZKH2UyODzk+FNaUnRXYeHL9sLymstoXjfuEz
	fJanNSVWV0hQ5juMNtvtM1PBkjjxKb//w9NKQjqXRXOW4354/s88bLnDUpYwJu5P6CEOjA2aaDt
	vMT8jgzoFODWEb1jJ2thUQF3uw/aie2dM9mJN6LSfYjW2zQ8q3jDnVYunrR1KzC07LNtTceqmcq
	idhOsTkIIxIvQcMD5ucXMRsmt0N8A5ZGPlXA8hsOjmwvlDQlG01zKWmnBp76jjlelzfwRYiU7e7
	jFk+vWt57cWtNUZxFn4GaYrXxqnOJqiqCQsLMlShCY72M/TW5g==
X-Received: by 2002:a05:6e02:1707:b0:3d9:6cd9:505b with SMTP id e9e14a558f8ab-3da73923292mr48865715ab.16.1746649191979;
        Wed, 07 May 2025 13:19:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGirjblSq3VrPg4cSPPtixsZ9RLYr2y/Vqrv6Gu4fgJ719DDeE4NF/GlqgoJ1qnrPOOSrrIWQ==
X-Received: by 2002:a05:6e02:1707:b0:3d9:6cd9:505b with SMTP id e9e14a558f8ab-3da73923292mr48865325ab.16.1746649191574;
        Wed, 07 May 2025 13:19:51 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da70a57088sm8262035ab.70.2025.05.07.13.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 13:19:50 -0700 (PDT)
Message-ID: <e72e0693-6590-4c1e-8bb8-9d891e1bc5c0@redhat.com>
Date: Wed, 7 May 2025 15:19:49 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 chao@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
 <aBtyRFIrDU3IfQhV@google.com>
 <6528bdf7-3f8b-41c0-acfe-a293d68176a7@redhat.com>
 <aBu5CU7k0568RU6E@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBu5CU7k0568RU6E@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 2:48 PM, Jaegeuk Kim wrote:
> On 05/07, Eric Sandeen wrote:
>> On 5/7/25 9:46 AM, Jaegeuk Kim wrote:
>>
>>> I meant:
>>>
>>> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
>>> # mount /dev/vdb mnt
>>>
>>> It's supposed to be successful, since extent_cache is enabled by default.
>>
>> I'm sorry, clearly I was too sleepy last night. This fixes it for me.
>>
>> We have to test the mask to see if the option was explisitly set (either
>> extent_cache or noextent_cache) at mount time.
>>
>> If it was not specified at all, it will be set by the default f'n and
>> remain in the sbi, and it will pass this consistency check.
>>
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index d89b9ede221e..e178796ce9a7 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1412,7 +1414,8 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>>  	}
>>  
>>  	if (f2fs_sb_has_device_alias(sbi) &&
>> -			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
>> +			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
>> +			 !ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
>>  		f2fs_err(sbi, "device aliasing requires extent cache");
>>  		return -EINVAL;
>>  	}
> 
> I think that will cover the user-given options only, but we'd better check the
> final options as well. Can we apply like this?

I'm sorry, I'm not sure I understand what situation this additional
changes will cover...

It looks like this adds the f2fs_sanity_check_options() to the remount
path to explicitly (re-)check a few things.

But as far as I can tell, at least for the extent cache, remount is handled
properly already (with the hunk above):

# mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
# mount /dev/vdb mnt
# mount -o remount,noextent_cache mnt
mount: /root/mnt: mount point not mounted or bad option.
       dmesg(1) may have more information after failed mount system call.
# dmesg | tail -n 1
[60012.364941] F2FS-fs (vdb): device aliasing requires extent cache
#

I haven't tested with i.e. blkzoned devices though, is there a testcase
that fails for you?

Thanks,
-Eric

> ---
>  fs/f2fs/super.c | 50 ++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index d89b9ede221e..270a9bf9773d 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1412,6 +1412,7 @@ static int f2fs_check_opt_consistency(struct fs_context *fc,
>  	}
>  
>  	if (f2fs_sb_has_device_alias(sbi) &&
> +			(ctx->opt_mask & F2FS_MOUNT_READ_EXTENT_CACHE) &&
>  			!ctx_test_opt(ctx, F2FS_MOUNT_READ_EXTENT_CACHE)) {
>  		f2fs_err(sbi, "device aliasing requires extent cache");
>  		return -EINVAL;
> @@ -1657,6 +1658,29 @@ static void f2fs_apply_options(struct fs_context *fc, struct super_block *sb)
>  	f2fs_apply_quota_options(fc, sb);
>  }
>  
> +static int f2fs_sanity_check_options(struct f2fs_sb_info *sbi)
> +{
> +	if (f2fs_sb_has_device_alias(sbi) &&
> +	    !test_opt(sbi, READ_EXTENT_CACHE)) {
> +		f2fs_err(sbi, "device aliasing requires extent cache");
> +		return -EINVAL;
> +	}
> +#ifdef CONFIG_BLK_DEV_ZONED
> +	if (f2fs_sb_has_blkzoned(sbi) &&
> +	    sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> +		f2fs_err(sbi,
> +			"zoned: max open zones %u is too small, need at least %u open zones",
> +				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> +		return -EINVAL;
> +	}
> +#endif
> +	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> +		f2fs_warn(sbi, "LFS is not compatible with IPU");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>  static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  {
>  	struct f2fs_inode_info *fi;
> @@ -2616,21 +2640,15 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  	default_options(sbi, true);
>  
>  	err = f2fs_check_opt_consistency(fc, sb);
> -	if (err < 0)
> +	if (err)
>  		goto restore_opts;
>  
>  	f2fs_apply_options(fc, sb);
>  
> -#ifdef CONFIG_BLK_DEV_ZONED
> -	if (f2fs_sb_has_blkzoned(sbi) &&
> -		sbi->max_open_zones < F2FS_OPTION(sbi).active_logs) {
> -		f2fs_err(sbi,
> -			"zoned: max open zones %u is too small, need at least %u open zones",
> -				 sbi->max_open_zones, F2FS_OPTION(sbi).active_logs);
> -		err = -EINVAL;
> +	err = f2fs_sanity_check_options(sbi);
> +	if (err)
>  		goto restore_opts;
> -	}
> -#endif
> +
>  	/* flush outstanding errors before changing fs state */
>  	flush_work(&sbi->s_error_work);
>  
> @@ -2663,12 +2681,6 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  		}
>  	}
>  #endif
> -	if (f2fs_lfs_mode(sbi) && !IS_F2FS_IPU_DISABLE(sbi)) {
> -		err = -EINVAL;
> -		f2fs_warn(sbi, "LFS is not compatible with IPU");
> -		goto restore_opts;
> -	}
> -
>  	/* disallow enable atgc dynamically */
>  	if (no_atgc == !!test_opt(sbi, ATGC)) {
>  		err = -EINVAL;
> @@ -4808,11 +4820,15 @@ static int f2fs_fill_super(struct super_block *sb, struct fs_context *fc)
>  	default_options(sbi, false);
>  
>  	err = f2fs_check_opt_consistency(fc, sb);
> -	if (err < 0)
> +	if (err)
>  		goto free_sb_buf;
>  
>  	f2fs_apply_options(fc, sb);
>  
> +	err = f2fs_sanity_check_options(sbi);
> +	if (err)
> +		goto free_options;
> +
>  	sb->s_maxbytes = max_file_blocks(NULL) <<
>  				le32_to_cpu(raw_super->log_blocksize);
>  	sb->s_max_links = F2FS_LINK_MAX;


