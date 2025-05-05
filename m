Return-Path: <linux-fsdevel+bounces-48148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2AAEAAAEB8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 05:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 576C33A733A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 02:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D0F2874FC;
	Mon,  5 May 2025 23:03:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE2135D7B0;
	Mon,  5 May 2025 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485907; cv=none; b=NqXndjlF7UXtxwhv5z97T9mG8vtn7fe0UZWKJ2/siY2KfX2elLmjlwiUmF8ldmBJrqIdPV6or73MKZtBsvKdvv0g/ILbbiwvQApe/ohty1SpxZ1X2lHa5+gJoyONuW2GGfov5ldHJ+oYS61pQ4hmnizFB3wA3Msjbw8eMYVzN9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485907; c=relaxed/simple;
	bh=0iA7SnkO+rHs3cH5clhDyFXZGFleV4DrWF4XKWa+sJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uf8qPEEDBUnaZ553HgnSeD5UqVrieQTt3M/dYADeJC30THNN4W6Efhcj34Fk4JGNNoyNsEkUdeZGXENHGrbGjSG3GQe75Ih070Oub1BKk2f8yTEy7nVeMxefOTtvNl15qJsacBp1sgsyv8ZmUsUV5j7Y7p6H2ITyq+P7dgFVe8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-301a8b7398cso562090a91.1;
        Mon, 05 May 2025 15:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746485904; x=1747090704;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E69HBkxQBdEYOvZVGJya06bZ/qelSSQFUZVNp/6hv4Q=;
        b=lJvzSgtyPnoHiFxUpFmzKiz6URvRZCx33ChApMBAWF5Uz4p1OO6I1sMp03p/ZBPdC5
         CV2FEGQWEd3E4Adp4bPi2kC2N5bhT/wnoMehzaRNZcemP6lGxUBuNuXGJUsAxryDBtmu
         Rms+Vn2Z+aN6yYDDw+b7VyapearqB8sxGQpkE2RPvuA2JyH4OsgM4nr9WpzmT+rs2iSx
         Zj2MoGS+0klurQsSW1GHPX5MzQPmgMQvrU8gPG3aBJGyaf2JBo37mzzWLUbLtjbByi2k
         NS/qM1NE4n8xIh/SzcACPHBeGSnkHfCG4ORTyK73nAAK5cWAVE35+cQO+tMZDx1WUB+x
         1fYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy6vXRy3kTbASz93AciySyXYKbLdiB0fKenkW1NjoReB3gmSsA0+oM+nnU8TcJtItGnmBSCEGDFvw=@vger.kernel.org, AJvYcCW3l945nYAP1uoPIEObMwQN5vNaEhUmPxu8fCwGkR7reNSzGJB2C/UR7WjrSTxyWvtuYi48bmNDyL04c0xb@vger.kernel.org, AJvYcCXoIxNff7atlPMw04bMfZJInDljxL1XIH3+HKisiGdAV/xwd5MKP6qrLp+WFnQnk3xxKz5yCEDWQmDZIcDz3A==@vger.kernel.org, AJvYcCXrFlfSJZJopr1GzL9abx1UcVQzAmxI+CxHiaRy9dLHMrTRcmUiisFnyBELekhLrln7Gg2OJ5Yfo+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2Kn69NkgJleSsMj82SLxJRVlEphWtb+4NVeyh1/s+RKJP4GE4
	IffK3d/+i5+KK9+DvlZTzQSPLfTgkXw/vCtMxJLkG/cXFlwkKdRV
X-Gm-Gg: ASbGnctmvgOoU12WsfDLDTmS0ysJgv7vV8tlt6/iPrlv89zx67kJ6L6yuwy8UA3XZwd
	tESQWLnaLzdJQ3W7IaOVVlX7dCwskH4YyihJHfOgPAXWXMVYH7ADSikJdROMI8ytUnFKj78Ob7w
	F6Cneypm7r9SJBI7peWvFfvgIkXQ+RhzdgwSdiGmmYP3uGakvu7kI1Wz1dvum0L1m9Lcyr9DOKQ
	ljVFJPmJAtLWdugEkb90rC3kldSorJ/sVj913oybvLSmd8GjRTSyuIyVnQep3efrD9PyD2Gq2Jf
	oHWZVc00o6lD/qJ8kxHYowJxSSnwxdMxwVUKvkxtr8l/W36k/e+I
X-Google-Smtp-Source: AGHT+IHJTeyvyyCYbIt/rYD4AuU2+QD3JmkKZhwPhbVCwB3WHS4NZFqPQbdjDVG7wdbKMVf90do5qQ==
X-Received: by 2002:a17:902:d4c4:b0:224:e0e:e08b with SMTP id d9443c01a7336-22e1022be16mr89698425ad.0.1746485903779;
        Mon, 05 May 2025 15:58:23 -0700 (PDT)
Received: from [192.168.50.136] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a347488b0sm12359854a91.16.2025.05.05.15.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 15:58:23 -0700 (PDT)
Message-ID: <81a917f3-fb41-4958-8d76-7cdfa7b60a7c@kzalloc.com>
Date: Tue, 6 May 2025 07:58:18 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs: Prevent panic from NULL dereference in
 alloc_fs_context() during do_exit()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <len.brown@intel.com>, byungchul@sk.com,
 max.byungchul.park@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>,
 linux-efi@vger.kernel.org
References: <20250505203801.83699-2-ysk@kzalloc.com>
 <20250505223615.GK2023217@ZenIV>
Content-Language: en-US
From: Yunseong Kim <ysk@kzalloc.com>
Organization: kzalloc
In-Reply-To: <20250505223615.GK2023217@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Alexander,

Thanks for the feedback!

On 5/6/25 7:36 오전, Al Viro wrote:
> On Tue, May 06, 2025 at 05:38:02AM +0900, Yunseong Kim wrote:
>> The function alloc_fs_context() assumes that current->nsproxy and its
>> net_ns field are valid. However, this assumption can be violated in
>> cases such as task teardown during do_exit(), where current->nsproxy can
>> be NULL or already cleared.
>>
>> This issue was triggered during stress-ng's kernel-coverage.sh testing,
>> Since alloc_fs_context() can be invoked in various contexts — including
>> from asynchronous or teardown paths like do_exit() — it's difficult to
>> guarantee that its input arguments are always valid.
>>
>> A follow-up patch will improve the granularity of this fix by moving the
>> check closer to the actual mount trigger(e.g., in efivarfs_pm_notify()).
> 
> UGH.
> 
>> diff --git a/fs/fs_context.c b/fs/fs_context.c
>> index 582d33e81117..529de43b8b5e 100644
>> --- a/fs/fs_context.c
>> +++ b/fs/fs_context.c
>> @@ -282,6 +282,9 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
>>  	struct fs_context *fc;
>>  	int ret = -ENOMEM;
>>  
>> +	if (!current->nsproxy || !current->nsproxy->net_ns)
>> +		return ERR_PTR(-EINVAL);
>> +
>>  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
>>  	if (!fc)
>>  		return ERR_PTR(-ENOMEM);
> 
> That might paper over the oops, but I very much doubt that this will be
> a correct fix...  Note that in efivarfs_pm_notify() we have other
> fun issues when run from such context - have task_work_add() fail in
> fput() and if delayed_fput() runs right afterwards and
>         efivar_init(efivarfs_check_missing, sfi->sb, false);
> in there might end up with UAF...

I see your point — simply returning early in alloc_fs_context() may just
paper over a deeper issue, and I agree that this might not be the right
long-term fix. I wasn’t aware of the potential UAF scenario involving
efivarfs_pm_notify() and delayed_fput().

I’ll take a closer look at the call paths involved here, especially
around efivarfs_pm_notify(), fput(), and delayed_fput() interactions
during do_exit().

Also, I’ll loop in the EFI mailing list so we can discuss this
further from the efivarfs side as well.

Thanks again,
Yunseong

