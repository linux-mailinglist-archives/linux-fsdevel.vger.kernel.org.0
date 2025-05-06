Return-Path: <linux-fsdevel+bounces-48213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF66AAC027
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 11:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2600C1C27C1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 09:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C42750E2;
	Tue,  6 May 2025 09:42:29 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828FB442C;
	Tue,  6 May 2025 09:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746524548; cv=none; b=Wa4R5nZjYZRUsV7AA2EWHVXwlrKMAtcgzTyio9I30oUFhPkzN8Z5x5xdGllKt2yfhIc1UMt3vfoMs55EQ/iwEDI3ttqasvwg9JGlJcVbOJwDoPcleyghmUxoTiJNVPjHObzYx5YABsbyFWXzCN7CzBWdKHGZjeCi+K7Hu4yJXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746524548; c=relaxed/simple;
	bh=tV0nDwIoH2g7mHnHzytl/Ey8Bl8yk1y+cNBPV8pyc5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqdnmcNpP0CXKuirJwuUQ5luH5D53n38b2MLkMojQvUERUaQClGVflz7PftJNcbkmsi/5SeaKcW8QHfMeZRmQWUg/oP2nZfI95hSsVk4bgZMRQKeHGFZ6z5g3Dds1oi+Bu5VEVi3nuxDIHmsIe9iPX3uhQq8ZnzFMeaGEKZuuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7373aa99e2cso794963b3a.0;
        Tue, 06 May 2025 02:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746524547; x=1747129347;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T0NjyGvijBDvIUSC5O5zU3aez3V3m7u5cMnfIW2NYxk=;
        b=vNWKMPvb3P3CPwoVYGONDAs/4Q8brwXpho4xViHaThaWq8WhBd4dls4a5JsTMN0seD
         zPQdXlo0AVkbrB1aoVAwJiLvwWQkd9TCdCE3N9QASwL/uBNJiiUYY23tnnVeKfqZF6gc
         lslvL+jMjnOATIDGuwzcUkI68VmJBZ4+LAFKw5rdMbTj7k5noLj2qaNTxZn8eKqYTlAu
         7I3QGqaavCLvBfHHOJW2gHfi4GbFZfXELxE+tYBME3I31vi6ylwjsHF9MDkqsidxqp//
         /nybecEWhSI9DAZfhw6V3oXIN5ZB2OezxByVkBz1PAFm2K/anMvFJsMPtM9x4mQBFNwi
         C/qw==
X-Forwarded-Encrypted: i=1; AJvYcCUJJ/I9/VqqszwvvSk43rAU+C07g0qQ3N+2drK4yCYTv+Fo6D69UIACNjIn97eDBgrWzdBWn9pmoMWJPrQp@vger.kernel.org, AJvYcCWA3x+owDHEvcV6d/lTrjjc3S7lrz2JRtAIkPWj+aCHsEpqRAzU1/2A0J6TvH3VfVx3Az2K29BU2AY=@vger.kernel.org, AJvYcCWrN8FVv/sps6D6Dlm3amA/ecldIy9/ggCX3+6RSiuzdjHKPQSjfFeJoVajy8HEVUWmKi1DqGZ/CT6KNlVS@vger.kernel.org
X-Gm-Message-State: AOJu0YwQg1JatYahWw6eChXHfAxZ0JpU/Q79+O7HLMFe9/a+MppAghqh
	owNzhhT9BugCHtyEbaVhxJHwAsSHnFdH4luidT/GmJkbqrWlFpY2sxG3VQ==
X-Gm-Gg: ASbGncu5blTw5Hhc4Sn97kEMgWgxAfIVKB7z5vTaZqGS4ZW/XmTFK/zZmawTckOdDUF
	c5ibeU+LrtVgZtV38dy/TmjMMz34LhQT4GT7A0ae8Dr8T7e4pj1CQpbYDyDNIKSh/6k9lLn3DRG
	AV+zs/r0wMTvobzzRS2Bto2z8BXCcyOxC17gKtlt1B1l5nS7oFyLHf30J5k4yN6KBUhhFR+fpyK
	H2FM1dtpJB/I/0H3IsSAKcXycXxXNarR72jTmH11m5gFSe+/y5zYtzNLTGPCFNy2ylYREu3nbw2
	V2bwKm8WkSqwCWRbCl07CGQ8Eu105AnIL98S1HYOJRze/MX+sUKe
X-Google-Smtp-Source: AGHT+IHJPV6QHn0fik5+fgOnYxj6sw2W5noBjtawQua2EwoODPBFi11YGxjUR1TwWEuCjtTqOEsvmA==
X-Received: by 2002:a05:6a21:e89:b0:1ee:ea8f:2e9f with SMTP id adf61e73a8af0-20cdc0f5235mr9752018637.0.1746524546592;
        Tue, 06 May 2025 02:42:26 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b1fc0e32b8bsm5555899a12.48.2025.05.06.02.42.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 02:42:26 -0700 (PDT)
Message-ID: <4dcff9ce-4ec8-4b57-9f21-a7e2f37b4d5c@kzalloc.com>
Date: Tue, 6 May 2025 18:42:21 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Prevent panic from NULL dereference in
 alloc_fs_context() during do_exit()
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>,
 byungchul@sk.com, max.byungchul.park@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250505203801.83699-2-ysk@kzalloc.com>
 <20250505223615.GK2023217@ZenIV>
 <20250506-hochphase-kicken-7fa895216c2a@brauner>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250506-hochphase-kicken-7fa895216c2a@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christian,

On 5/6/25 5:45 오후, Christian Brauner wrote:
>>> diff --git a/fs/fs_context.c b/fs/fs_context.c
>>> index 582d33e81117..529de43b8b5e 100644
>>> --- a/fs/fs_context.c
>>> +++ b/fs/fs_context.c
>>> @@ -282,6 +282,9 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>>>  	struct fs_context *fc;
>>>  	int ret = -ENOMEM;
>>>  
>>> +	if (!current->nsproxy || !current->nsproxy->net_ns)
>>> +		return ERR_PTR(-EINVAL);
>>> +
>>>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
>>>  	if (!fc)
>>>  		return ERR_PTR(-ENOMEM);
>>
>> That might paper over the oops, but I very much doubt that this will be
>> a correct fix...  Note that in efivarfs_pm_notify() we have other
>> fun issues when run from such context - have task_work_add() fail in
>> fput() and if delayed_fput() runs right afterwards and
>>         efivar_init(efivarfs_check_missing, sfi->sb, false);
>> in there might end up with UAF...
> 
> We've already accepted a patch that removes the need for
> vfs_kern_mount() from efivarfs completely.

I’ll take a look at the patch you mentioned, check if the issue reproduces, and get back to you.

Link: https://lore.kernel.org/all/20250318194111.19419-4-James.Bottomley@HansenPartnership.com/

Thanks for checking it!

Best regards,
Yunseong Kim


