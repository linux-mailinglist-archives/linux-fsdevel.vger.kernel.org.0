Return-Path: <linux-fsdevel+bounces-33484-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEBA9B9548
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 17:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04126281352
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 16:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9C81CF5F8;
	Fri,  1 Nov 2024 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="phncJ5FX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE2D1CB315;
	Fri,  1 Nov 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730478264; cv=none; b=JDzG1CLXWl3ARAgSDT1JRGErgFPpEjIFAmuA04wKPPjTbvcwu0OnP51GimpJfVjKLufZvRKL95jf4ezKwnmSX3ptKMQOIM2GSl7C68N9MtrzeF6MhQd1pjPgYpNuoXOHx8HRRc1ivNnH8FrZr5s7oRf+/gmWhBe6PgN/P7q6aWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730478264; c=relaxed/simple;
	bh=b0UAhav8960xcXnvYOfhHi2qXno7YIInP3C/ji4vnCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uz8E1GDa9VSMFgyfLl5w8s1Rd1QV6fWOMposGA5WaotN9Y8FZsU5C6T6fF3QPKrsZ8QT0c0Tx+A+SBbpXEYnO3CDSG/zo9pGl9tzUA/pqrFwbBZYUCh94MADi+3ScdIkER3FkMV1DMd71dLHXLDnmWNHxzPBpe4zfDyakIWo/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=phncJ5FX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6Xgaa20mje3eJrSCrnSFC9yazY/wXpJmFMU70h4HLjI=; b=phncJ5FXPhT/q+hCcFE7MtumlU
	itjmiVSImydeG4klTYxAW740OhGCXkc+VUTKFYqq7n+IjTVb4p1Npb2DJT7u5k6PZ8bIMwYaySm80
	dLpHXSzEmR3/ILm0emL4o0qRd0gBg1+HXypeRMphrRuserZpPK0hvnDBypYRqWpEqf7voB7MSVBX7
	wUAJh5PVYf5Ut4LbOewf+oBlotLyCUaB0tgUWMdtNaCvll3CjdUo/W7wvt1iWw1pPAG6C44B1u3Fj
	6mE+7b9KksqkW5fyI0Xl1yFA25ZkcZybqqVbUiX85ksexTYC+LmzWIqDOqY9eLjjuIBjqGWtt/YKH
	pTPxaMgg==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t6uRN-000UYc-HK; Fri, 01 Nov 2024 17:24:01 +0100
Message-ID: <3754d3af-13bd-499b-9bca-633de721724f@igalia.com>
Date: Fri, 1 Nov 2024 13:23:55 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tmpfs: Initialize sysfs during tmpfs init
To: Nathan Chancellor <nathan@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 krisman@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
 Theodore Ts'o <tytso@mit.edu>
References: <20241101013741.295792-1-andrealmeid@igalia.com>
 <20241101013741.295792-4-andrealmeid@igalia.com>
 <20241101071942.GB2962282@thelio-3990X>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241101071942.GB2962282@thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 01/11/2024 04:19, Nathan Chancellor escreveu:
> Hi André,
> 
> On Thu, Oct 31, 2024 at 10:37:41PM -0300, André Almeida wrote:
>> Instead of using fs_initcall(), initialize sysfs with the rest of the
>> filesystem. This is the right way to do it because otherwise any error
>> during tmpfs_sysfs_init() would get silently ignored. It's also useful
>> if tmpfs' sysfs ever need to display runtime information.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   mm/shmem.c | 130 ++++++++++++++++++++++++++++-------------------------
>>   1 file changed, 68 insertions(+), 62 deletions(-)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 6038e1d11987..8ff2f619f531 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -5126,6 +5126,66 @@ static struct file_system_type shmem_fs_type = {
>>   	.fs_flags	= FS_USERNS_MOUNT | FS_ALLOW_IDMAP | FS_MGTIME,
>>   };
>>   
>> +#if defined(CONFIG_SYSFS) && defined(CONFIG_TMPFS)
> 
> This condition...
> 
>> +static int __init tmpfs_sysfs_init(void)
>> +{
>> +	int ret;
>> +
>> +	tmpfs_kobj = kobject_create_and_add("tmpfs", fs_kobj);
>> +	if (!tmpfs_kobj)
>> +		return -ENOMEM;
>> +
>> +	ret = sysfs_create_group(tmpfs_kobj, &tmpfs_attribute_group);
>> +	if (ret)
>> +		kobject_put(tmpfs_kobj);
>> +
>> +	return ret;
>> +}
>> +#endif /* CONFIG_SYSFS && CONFIG_TMPFS */
>> +
>>   void __init shmem_init(void)
>>   {
>>   	int error;
>> @@ -5149,6 +5209,14 @@ void __init shmem_init(void)
>>   		goto out1;
>>   	}
>>   
>> +#ifdef CONFIG_SYSFS
> 
> and this condition are not the same, so there will be a compile error if
> CONFIG_SHMEM and CONFIG_SYSFS are enabled but CONFIG_TMPFS is not, such
> as with ARCH=x86_64 allnoconfig for me:
> 
>    mm/shmem.c: In function 'shmem_init':
>    mm/shmem.c:5243:17: error: implicit declaration of function 'tmpfs_sysfs_init'; did you mean 'uids_sysfs_init'? [-Wimplicit-function-declaration]
>     5243 |         error = tmpfs_sysfs_init();
>          |                 ^~~~~~~~~~~~~~~~
>          |                 uids_sysfs_init
> 

Thanks for the catch! Fixed for v2

>> +	error = tmpfs_sysfs_init();
>> +	if (error) {
>> +		pr_err("Could not init tmpfs sysfs\n");
>> +		goto out1;
>> +	}
>> +#endif
> 
> Cheers,
> Nathan


