Return-Path: <linux-fsdevel+bounces-40999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB19A29EA7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 03:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 483C37A3CF1
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 02:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500417DA62;
	Thu,  6 Feb 2025 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8q1txOq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC862E62B
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Feb 2025 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808353; cv=none; b=DgZDcPIibx7gUeTrY8AgLzNAevJsQonWFuy/AtVaR77b/QFk8T2CXrQpTcPNhfLKg561BxAwEVJrCxqyB4MKF0Y4UEySoWzVuh/yLYDsKpTo+mb+YM9/DO8RhDgqKe3umbxQaTf2OBQGu4hexgrjVOW9FQamsYGF+OUMUE+M2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808353; c=relaxed/simple;
	bh=k6vMTmJHFnv2WkKE/A7okgY4lHxFWQNqFyef/pZ+/bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UP6xBHEqOu9regLM6DyBtt/S0vfWhuknG0iSjH2dFRZSHT1O/75BvmH36k7MYvD5IKFPNEO3a/ICXfbnQXMZV+DddbGZEtsmM4IujUFGSMp35tQlh9XFLJe2NC2FYre1E0GJU7KKm6Uw4Li8QIHsFPsy2U7rXJGxF58eA/eMEg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8q1txOq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738808350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jfJVrhk9Ifzv4h+gi2hPHXFp3NAOfRW4TP/LTqPsYQ=;
	b=D8q1txOqTPc5KHCIn1XtPVHgQ9+vdmnagkSd6LzLlP5crNxX7rnUQHRhqfBOtHKj6BfmnQ
	QXCZKKyLsTQQoRwL4bYBYfm1/P9SqL2tgXlEGotPsY1N6dBIm9CwcVb7aiCu4rnO4TY9PD
	0x/qIKJyTBvOENfBoBsB+sGJnJQZVmI=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-EnNTcjPdNSqFqKGArmpAnQ-1; Wed, 05 Feb 2025 21:19:09 -0500
X-MC-Unique: EnNTcjPdNSqFqKGArmpAnQ-1
X-Mimecast-MFC-AGG-ID: EnNTcjPdNSqFqKGArmpAnQ
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-851a991cf8bso96801639f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Feb 2025 18:19:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738808348; x=1739413148;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2jfJVrhk9Ifzv4h+gi2hPHXFp3NAOfRW4TP/LTqPsYQ=;
        b=NFXZpoR4JPckZSdmnVMIi3PVQzUXTmOjGk9tvHVwTDiGQYD35PzgzPY1lTon0jefiM
         9pe55BL4gZrx2YbDO/6x/kzd8+CKP0LDTl7Cg/02/mrgShfPByyF1eLwWH6hMIb3pDve
         wCl8wuIaeKbNXgqz35rx4WqJEyOrDslv+ruLHmc5dLPWnJcJc+5QDtDd2uIpQE7hUB6b
         VII8aO8bloqBOl1lNmI/gO/bPIOj1a5/cdUhn29dcZAEWO+Z3oI4H26ug+JxZIGcs66J
         Sx9Kf7eI2ah1YF1oTHiP6hX2c3lJabml0K2q2tBxBqABDLG2JY6ja1igRZN6uL36OVmz
         mTRg==
X-Forwarded-Encrypted: i=1; AJvYcCUUMfWNCpc5lgcDkPDQkBHD0aR/Jpv+1pdIZlTOW6iIojKpfKB0r/atfHzJZhlt1ORJSvt+ANTBHFusgv6i@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2llV2OG3fO5yEU+pJ7K2JzhxbIxdQvd2v1h7EA0ovcPwY/67j
	xmM2RARjmwl45VJQWPpSRmG+EUGMlSA2ff15ORpRoeMPTis3Dq/JeOxxnp/KFH2czgCkMJvtfQF
	1cFUR1YpMEqUPIgERN50MrHYaYYaN/FIQZ+4qNVOwIz3reVe4YwKJd5vir02PzrWA5jC4LhcwNA
	==
X-Gm-Gg: ASbGncviHLMiN/OfBMwFp5VmfzmTg5+mvt9F6Xs4o4N6lH6DZGUpOMxNx9O7NUawF0Q
	s/BP2iWDHcENZVVp2MWYWXfWvHiuTE0u8OOgwCYpP+FJC7s1cKVjh8zraDMAJLDSS3iY4K6L5ii
	QCiTASpRR10dRTFr25m3UFHX0kMbIdrcyRNxFRO0dxsEbJ2lRKyoh7ajkJFc/c0DjVobq8HZyPa
	vPpIAZ2XUyZqyRsAfYL0OZm0DR5Q8SZDmvUj1yTKefAaqQxQdgSd0KNKqmTX7dR3t3yf7gv3KCL
	NC0Q846ES5gYxgMO/z/pRJkKxc/oqE6pjqF34o7pKg3g
X-Received: by 2002:a92:cd84:0:b0:3ce:3565:629 with SMTP id e9e14a558f8ab-3d05a54b0damr17080585ab.1.1738808348672;
        Wed, 05 Feb 2025 18:19:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXZrRSdhEGS5oeToKOTzy3aKexIWiPlOnTh2/SsV+ZRTxK+0SkEC/Bdhvv9wG52PAcgmxgGw==
X-Received: by 2002:a92:cd84:0:b0:3ce:3565:629 with SMTP id e9e14a558f8ab-3d05a54b0damr17080435ab.1.1738808348360;
        Wed, 05 Feb 2025 18:19:08 -0800 (PST)
Received: from [10.0.0.48] (97-116-166-216.mpls.qwest.net. [97.116.166.216])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d05e9a32a3sm319925ab.72.2025.02.05.18.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2025 18:19:07 -0800 (PST)
Message-ID: <57a9557f-c895-466f-afaa-a40bf818e250@redhat.com>
Date: Wed, 5 Feb 2025 20:19:06 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] pstore: convert to the new mount API
To: Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
 brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, neilb@suse.de, ebiederm@xmission.com,
 tony.luck@intel.com
References: <20250205213931.74614-1-sandeen@redhat.com>
 <20250205213931.74614-2-sandeen@redhat.com>
 <DD66BE90-95CD-4F75-AD47-50E869460482@kernel.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <DD66BE90-95CD-4F75-AD47-50E869460482@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/5/25 8:04 PM, Kees Cook wrote:
>> @@ -431,19 +434,33 @@ static int pstore_fill_super(struct super_block *sb, void *data, int silent)
>> 		return -ENOMEM;
>>
>> 	scoped_guard(mutex, &pstore_sb_lock)
>> -		pstore_sb = sb;
>> +	pstore_sb = sb;
> Shouldn't scoped_guard() induce a indent?

Whoops, not sure how that happened, sorry.

Fix on commit or send V2?

>> 	pstore_get_records(0);
>>
>> 	return 0;
>> }
>>
>> -static struct dentry *pstore_mount(struct file_system_type *fs_type,
>> -	int flags, const char *dev_name, void *data)
>> +static int pstore_get_tree(struct fs_context *fc)
>> +{
>> +	if (fc->root)
>> +		return pstore_reconfigure(fc);

> I need to double check that changing kmsg_size out from under an active pstore won't cause problems, but it's probably okay. (Honestly I've been wanting to deprecate it as a mount option -- it really should just be a module param, but that's a separate task.)

Honestly I struggled with this for a while, not quite sure what's right.

> Reviewed-by: Kees Cook <kees@kernel.org>

Thanks,
-Eric

> (Is it easier to take this via fs or via pstore?)
> 
> -Kees


