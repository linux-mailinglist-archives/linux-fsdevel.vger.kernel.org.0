Return-Path: <linux-fsdevel+bounces-27568-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B79626B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F615B22C0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 12:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80C17554A;
	Wed, 28 Aug 2024 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I22J4E+y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BF816C841;
	Wed, 28 Aug 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847363; cv=none; b=A8B754ro05e+KhINtsOOt9gqTWzSLCiYzcBWqjOf+b8cFrg9ft7sKni0Zf4aUjEREF3i+EfSuNgJuKesE+0/gQ7MA8PSOOucvOlBN6X3l5VqRAhc2cat8nallUbWjEc7y8pLLxGqIsNcrPCgELyYA8WFBZ6huAlvCAfAxm9DClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847363; c=relaxed/simple;
	bh=h+PPbzCd+yBXL+aCxfusTdZ4qYyiHaCWW8ov+ydbo0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlS1VsXmJIM1WBvazCSrUpaYNF74cCHMxO2AiYmXsiZixhpf5AMuby+Vt6n2MpB6cUNmoTCDDcVx+YuiRfPalvvzWntXxDhEA59YU5lVEr5L1JQFEmL+i9Ujx2aH1UqitVjZLf4nS7gDynUIlVi80vFIobtBPk0xhHccBNAMT80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I22J4E+y; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5344ab30508so573743e87.0;
        Wed, 28 Aug 2024 05:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724847360; x=1725452160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ng4Et3b6RIM6IHeWgh/ZPQAPNCHpiV+CCb2HKlszHww=;
        b=I22J4E+ysdKV8Y7CPV4egjWwyeUJsi3clHERtivrSnmscFcY/jHqx/xoGYu+L3NovT
         RqaqKLG0CtV8wVXgwBdrsXgBSlnlJUfUBYrNli0P06wopj8OrUeYogCWNdNwz6mmtaE9
         w3Or8EFs2/RETZZG6YEwOUbVJigukB51EOx8ZeH8C8q8p6/J/a2jG33ciO8KGRdGoBXA
         hwVUJJl1DnsyxxpA9mIwZo/zo25XdPBVvX3Ux2PunPyHi5xfXTeDRZo/FK1HHtHj1Vd+
         Xz7G8npOoYFwzBSRHod5MvhHlZHET3yw0fEXy5xgCZ7z5Q/q+/bUeZGIPXxzt1H5AUJ8
         S3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724847360; x=1725452160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ng4Et3b6RIM6IHeWgh/ZPQAPNCHpiV+CCb2HKlszHww=;
        b=JACpkEh+9bvXkPDccUkhBOZfzZBRMnrta1AdgTMi/UBgZwrw8HDZvpBvhE1kInS1rC
         DcxRFlmsLvah/y4nyMmi+T0DpqJTIlfm1OtTHwVGfCUeQMEmxedfoHvUQtnMllOh6aqY
         3BCYWIkgJJjL+/fqb2O33X51RzgQ5OvB/SVxIwd2QSfaEU2oznOV+LuSt1mq1SB8G/uA
         e/y+8PvpGZHYTpJ/zhq22eBtefTFe5A4ObDGVbLFs5rIDNwTgASfqQfXmZ6G4c+2fcOD
         i4Z35WoDfn8k43zyVEkioGSzjPHC/b2ElX8RoH2Abw7KxOm/bivXW5oAIZIvmSJoXBZl
         iubg==
X-Forwarded-Encrypted: i=1; AJvYcCW1gQT85Nz8/YXU/HB0J7eikYt3NtAcaWCw8h1rmfr5qykkwVNEnEnixevpoOOO/3hSi/an4dD7xtTidlqe@vger.kernel.org, AJvYcCXfg6EfK1Y1neOhsStRqPBnXB345IDpOft4rAnuOOyeaYj1I8rpjzysh/9v6Wu1zrk1FfYx5Y+QrF3Q@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy3l/9ow6y+bvkSnWiZKu5sXIEHVCJUyDztmJZMkNXj//hg1FF
	Yk1I4bHoASRKwW3Iu8nq3gyUoxbZekmBs2LZu9w3OfFqwILHY+tDw/DK2vrY
X-Google-Smtp-Source: AGHT+IGVba96loo95wIpiJXJ9Zt+gf1IM8G4NGABVXkHxIAwPeyX7wekYe73dTT3+6h7F1MVYOwokw==
X-Received: by 2002:a05:6512:118d:b0:52e:8161:4ce6 with SMTP id 2adb3069b0e04-5345677fabdmr698663e87.25.1724847359932;
        Wed, 28 Aug 2024 05:15:59 -0700 (PDT)
Received: from [130.235.83.196] (nieman.control.lth.se. [130.235.83.196])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5334ea59557sm2145753e87.178.2024.08.28.05.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 05:15:59 -0700 (PDT)
Message-ID: <9e95498c-3924-4865-9012-ba92c4f4cf48@gmail.com>
Date: Wed, 28 Aug 2024 14:15:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to a24cae8fc1f1
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
 kjell.m.randa@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, willy@infradead.org, wozizhi@huawei.com
References: <877cc2rom1.fsf@debian-BULLSEYE-live-builder-AMD64>
 <1037bb5a-a48f-47cb-ace7-5e0aba7c6195@gmail.com>
 <878qwhl2l5.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Language: en-US
From: Anders Blomdell <anders.blomdell@gmail.com>
In-Reply-To: <878qwhl2l5.fsf@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dave,

Do you mind if I CC the path to stable@vger.kernel.org (and maybe GKH)?

/Anders

On 2024-08-28 05:54, Chandan Babu R wrote:
> On Tue, Aug 27, 2024 at 05:24:36 PM +0200, Anders Blomdell wrote:
>> Since 6.10 is still marked as a stable release, maybe this shold go into 6.10-fixes branch as well?
>>
>>    Dave Chinner (1):
>>        [95179935bead] xfs: xfs_finobt_count_blocks() walks the wrong btree
>>
> 
> xfs-linux git repository's xfs-6.10-fixes is not meant for collecting patches
> for stable kernels.
> 
> Also, the patch mentioned above cannot be merged into 6.10.y for the following
> reasons:
> 1. The 6.11 kernel has not been released yet.
> 2. No developer has signed up for backporting patches to 6.10.y.
> 

