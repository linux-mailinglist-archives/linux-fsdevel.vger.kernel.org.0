Return-Path: <linux-fsdevel+bounces-43511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B96A5791A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 09:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B220F1889477
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Mar 2025 08:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6DD1A2632;
	Sat,  8 Mar 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpFZJrxT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3DB17583;
	Sat,  8 Mar 2025 08:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741421167; cv=none; b=eC/nHdaYg2Vi1K45LqBWrFDeXom2fq21Yw68m/lmkYLIfOfGhkfYa88aYDjg4EZ6n3lcW2gU7kVHgjICy2sCm8LPwUwbG9p/JRctvbYs40Gdqq0mkkqnNHAplSixho1pzUqSLcwlquWBrcHOkPHja2VXYnJNtZfji5DtAPQT5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741421167; c=relaxed/simple;
	bh=XGRxZAYguXEWQD/gjMwK8T/ARx3CsugPw3sn2U4bboE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EuK0VFBx4H3OHs+B54mHhMLkk7+cD6rNcj2UduPjZxX0WjCOWvs2FixFXwa1a3xloDSV8vUOhbHYWgaLK8YOk7xBHQDy/IXIxojIYYW/JMrm+iI2s1IR6GtF3IBI1BrSNGqKJDBJp3+QNSCJpZrUpbG7Gdg6+bXODmqerZCwckY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CpFZJrxT; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22337bc9ac3so54314055ad.1;
        Sat, 08 Mar 2025 00:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741421165; x=1742025965; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ChhxADJR+xbJvkByK/dxsEr1PgDDMt78zzdKfiQchCo=;
        b=CpFZJrxTWo8NSt1unJJNGf6kwCHf2blg6Z4PFACJlPyTiuEOu4YtRy+etWqjTzQIsI
         TSzrZUfydc9dq0KRDufOe9jTxo+3jGiKHjOBNacxhw1A6lXHVbxL0jUdK/4nSC2pp0eB
         50htEeqEVgWB896flEkZ8NXDaUoFI/KHZ3sTUdMiIdYfRSy1Y9XcH8NsEbavE1yF8mhe
         rqwjsua82u8dZXa5ImCi9UkRvK7aTQDmby1/UX4XAsNTAKciQulwo/UGSF1eVp2HJ9Sp
         1kPt41XHWyOiV7QbmZkRqi4OtHiWwUVEBKTl4D9mN9UKNfyi4xXhTZojAzK5Cp2j40Pl
         eh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741421165; x=1742025965;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChhxADJR+xbJvkByK/dxsEr1PgDDMt78zzdKfiQchCo=;
        b=Oz48klfTUoUOKbtWfuN5Qb4KHsY4sksEyYo+BE9riXwdx9qjfYwTH8UiX+RYXU62Hp
         EUB5fhIU7+4tXUL8cZrr+79flFU2uAw9DeiQ8bNSk2LtoyJziBMQ4PlnnVN0bl+78FZu
         amFkG1bcHj7Vzm96bFn63ir47Sau5/S5JCkzpPjxlwDz36UWeIUnVGJpIlFnsSthxley
         OFMwQet92NI/MyN7EDpZxm3tebNToMHb/OyLcHJRyzqaR6E2Z1tgOkkyjHPizHloopOi
         uPHyUjKaaUGSSKH1xJdPLUDXWeeCjd2k0b+RSgq7Msh8c8YfGxYvXY0UrDqd+EpQRr7/
         dGpA==
X-Forwarded-Encrypted: i=1; AJvYcCUs6dl/Q/2EeH/2nf88L7H13SmzVPQ+Jej5+jLPg3vG8RK7Bj2AhGjO+GQW1bMyybTiPgTgJbg3aLcSY4SY@vger.kernel.org, AJvYcCWL/r808OVgUVfQjXao2NKnZXd6AQhjdqgxG8u8byU/Hcn+yExcqHXeT3cpPTO5I4y5lcuxCmNThWg=@vger.kernel.org, AJvYcCWy09PZy4wJ1sMRBtwvY5Ypa7qWzNkvaOHbaI2v5eIO4bmMn5aBQp/WTFIFtfm5s8maDv87mr6khSriQ6FiCw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRjYYqRDVrjT7u13EQAuJ7Ayd6/D3hRoDSTiWQ5NO/cG+5E32q
	QI2lDkNZa71aiKiPjmNp2/2AjG/AL914s+IcBZ1f0HHjT9kXaWZF
X-Gm-Gg: ASbGncuNHbp6le175uSc4cSfRKMKTnDj3PIcC5x9RHiztgpZKKAuL8IVsKl4q8EiopH
	B3ofkNZQBKMtmDPeS4j1+X1etI7FNcQVVa8nDWnogd4+/rEQRMCY7ZGRFXOv2jTVzSnOh4MjCFb
	ZxC1ug6nZBTAsP7ERWSkLE0r7vrT5rlqSzdBnwc23Nx5QKbbhHyQKDF+JI88Z0wjXTdZPg4FHrM
	NOIQcHpXuHEfrBZ0MKb05//0OX9BNCXQmzpCPemLk/JXbfAx0O0T2wQV8FzM6tC8eur8SAtQX8n
	NHbPk3q3QL8pY5IB+HZ78yVKJg9texsM6+kKJfqL/CRR1SjzMbrBcVt7gugfCBE3qqNDaj1hVQh
	6k/o=
X-Google-Smtp-Source: AGHT+IHTlPN6GmKz0DlzaC9MC6JKE39U4JRzI9PelS42v8C7wtfhvijef631QQXLRW/IU34dwMPy/w==
X-Received: by 2002:a17:902:ce0f:b0:223:3396:15e8 with SMTP id d9443c01a7336-22428899f38mr129999835ad.22.1741421165055;
        Sat, 08 Mar 2025 00:06:05 -0800 (PST)
Received: from localhost.localdomain ([103.49.135.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22410a92699sm41859775ad.204.2025.03.08.00.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Mar 2025 00:06:04 -0800 (PST)
From: Ruiwu Chen <rwchen404@gmail.com>
To: mcgrof@kernel.org
Cc: corbet@lwn.net,
	joel.granados@kernel.org,
	keescook@chromium.org,
	linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rwchen404@gmail.com,
	viro@zeniv.linux.org.uk,
	zachwade.k@gmail.com
Subject: Re: [PATCH v2] drop_caches: re-enable message after disabling
Date: Sat,  8 Mar 2025 16:05:49 +0800
Message-Id: <20250308080549.14464-1-rwchen404@gmail.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
References: <Z7tZTCsQop1Oxk_O@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

>> When 'echo 4 > /proc/sys/vm/drop_caches' the message is disabled,
>> but there is no interface to enable the message, only by restarting
>> the way, so add the 'echo 0 > /proc/sys/vm/drop_caches' way to
>> enabled the message again.
>> 
>> Signed-off-by: Ruiwu Chen <rwchen404@gmail.com>
>
> You are overcomplicating things, if you just want to re-enable messages
> you can just use:
>
> -		stfu |= sysctl_drop_caches & 4;
> +		stfu = sysctl_drop_caches & 4;
>
> The bool is there as 4 is intended as a bit flag, you can can figure
> out what values you want and just append 4 to it to get the expected
> result.
>
>  Luis

Is that what you mean ?

-               stfu |= sysctl_drop_caches & 4;
+               stfu ^= sysctl_drop_caches & 4;

'echo 4 > /sys/kernel/vm/drop_caches' can disable or open messages,
This is what I originally thought, but there is uncertainty that when different operators execute the command,
It is not possible to determine whether this time is enabled or turned on unless you operate it twice.

Ruiwu

>
>> ---
>> v2: - updated Documentation/ to note this new API.
>>     - renamed the variable.
>>     - rebase this on top of sysctl-next [1].
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/log/?h=sysctl-next
>> 
>>  Documentation/admin-guide/sysctl/vm.rst | 11 ++++++++++-
>>  fs/drop_caches.c                        | 11 +++++++----
>>  2 files changed, 17 insertions(+), 5 deletions(-)
>> 
>> diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
>> index f48eaa98d22d..ef73d36e8b84 100644
>> --- a/Documentation/admin-guide/sysctl/vm.rst
>> +++ b/Documentation/admin-guide/sysctl/vm.rst
>> @@ -266,7 +266,16 @@ used::
>>  	cat (1234): drop_caches: 3
>>  
>>  These are informational only.  They do not mean that anything is wrong
>> -with your system.  To disable them, echo 4 (bit 2) into drop_caches.
>> +with your system.
>> +
>> +To disable informational::
>> +
>> +	echo 4 > /proc/sys/vm/drop_caches
>> +
>> +To enable informational::
>> +
>> +	echo 0 > /proc/sys/vm/drop_caches
>> +
>>  
>>  enable_soft_offline
>>  ===================
>> diff --git a/fs/drop_caches.c b/fs/drop_caches.c
>> index 019a8b4eaaf9..a49af7023886 100644
>> --- a/fs/drop_caches.c
>> +++ b/fs/drop_caches.c
>> @@ -57,7 +57,7 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>>  	if (ret)
>>  		return ret;
>>  	if (write) {
>> -		static int stfu;
>> +		static bool silent;
>>  
>>  		if (sysctl_drop_caches & 1) {
>>  			lru_add_drain_all();
>> @@ -68,12 +68,15 @@ static int drop_caches_sysctl_handler(const struct ctl_table *table, int write,
>>  			drop_slab();
>>  			count_vm_event(DROP_SLAB);
>>  		}
>> -		if (!stfu) {
>> +		if (!silent) {
>>  			pr_info("%s (%d): drop_caches: %d\n",
>>  				current->comm, task_pid_nr(current),
>>  				sysctl_drop_caches);
>>  		}
>> -		stfu |= sysctl_drop_caches & 4;
>> +		if (sysctl_drop_caches == 0)
>> +			silent = true;
>> +		else if (sysctl_drop_caches == 4)
>> +			silent = false;
>>  	}
>>  	return 0;
>>  }
>> @@ -85,7 +88,7 @@ static const struct ctl_table drop_caches_table[] = {
>>  		.maxlen		= sizeof(int),
>>  		.mode		= 0200,
>>  		.proc_handler	= drop_caches_sysctl_handler,
>> -		.extra1		= SYSCTL_ONE,
>> +		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= SYSCTL_FOUR,
>>  	},
>>  };
>> -- 
>> 2.27.0
>> 

