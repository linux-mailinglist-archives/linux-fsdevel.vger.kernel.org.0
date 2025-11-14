Return-Path: <linux-fsdevel+bounces-68524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F26BC5E157
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 17:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75F484F1175
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC6932D45E;
	Fri, 14 Nov 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1KClcNP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42DF32D447
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763132740; cv=none; b=LFKmazukLmz1mzu/8GsjZJ8DOnHpkEgB5qqVZyZ8mV+QE4241Fr+RZsyfQy5XfrwDst5mSQjpWrzjtuGkSrX8VWObUILDQp1tWoq8QAkVDHtnmIRUJFKBK88h3mykfG26gUGrawauVMUeG40x3DcMRF3+F3wstcpda0Us9EiF2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763132740; c=relaxed/simple;
	bh=L93JreTzRB4UPQE84me3I/kuJuHhYJGJhH0FyJsUgoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCfULzOgVnjRkNNCiMz/fnPNgslmenKXieDLEPqheaGvWOUADzIUC0XQ/jzDMMisphqioSZBzAot1lU/ddm3WCR0+2CJikaPhnYEk2jXaos0ChjPk5bXvSQQY+qSHUfGCBl/N46b7Jz3EgzurLbn/zwhbHZRYLLA03/2NVdmgjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1KClcNP; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-429cbdab700so194953f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 07:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763132737; x=1763737537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FP/zEDssVpkXN5Oo3HVZxGbWIcuFP9Iwl4GeAVqzLUA=;
        b=C1KClcNPOy8ZidyHwPmiSgm3NjMen/wXCbUfH+nO+cCEZD4NpaWYB15EP+/5cSR6F8
         dyu8xjRD6et2wobeVAxkd5zpt51Df83G1Ouvr5YPVGDBt52gobiKqRIlJzzYtxQpPk3O
         Wll9Fk9YAFmg6CJyiACfUNafSv3tkMnnKY/7I3q3pi5bmfaAZc5TzFGyGBrycxHAey4K
         8dW/JJV9SbO2m1uEuEcDq9o3ny53rrrZh1/MSeInro0DvdgeuxiyKdL6Hu71fZBf7mJt
         TsN7OCnasXPE2Xvk+kO84J9MdlcNwiXdcKTcOJixcTX4IVNpsi3lJ5aA9I3c3kN4hHpC
         PSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763132737; x=1763737537;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FP/zEDssVpkXN5Oo3HVZxGbWIcuFP9Iwl4GeAVqzLUA=;
        b=RroM10FkmgKK9DfnxZIWSzS//Ftv4fqOp2+dvf63kaXLPJpH+QvhsgUH7+BOBQLER8
         VO6qFdQlKSE0YWuOIZKFqHqg4HBaG4rtxcHO8BQRXoKr7Pe8yQ93XETeC5TnpSWBzEsj
         Z4cRGQJp9Shde48p4TQRlBUEneaSxSxpEPdd6nirDqjb5R7kDWxPL1soohUzT+H/DLm9
         RrayqpRTs8uoXzLvGOsKvvNkOUVLogJt177Bzw69qQOGb95VyKjz6lbtzEZf21nYk+/3
         IhcFCLstFOc/SYRiOSNVi1qCJGLtb3DObz1N+BW5jFD2Gsnq6MfpCBjCsegrHnGQSUuY
         0fXg==
X-Forwarded-Encrypted: i=1; AJvYcCWypXGNmg04YvdcOzSTUCtOHKNrL6m6sNPw0mXgQJF4lk+gM+NtItgSE2SS71zZqM+x0ICFUjlF89WCFLjA@vger.kernel.org
X-Gm-Message-State: AOJu0YyKKJZptMaRKTOiYghNBeCkj9+fDF4yP2sY4CIeRF9U8lJo7hmS
	+5l40oGtK0kPIx/k0HS6Ak7ySrsEyPC5OLKfTtFJKiVgLRiPSsoPFHR+
X-Gm-Gg: ASbGncumheG7doZ7RKrnGwBYFurfEVjTi9v5aHk8r8OA+SmQXpvbz5BbFet6NV3dr8P
	fsybVXwNW2Bbuvxk2uvocXwfGMmbDdJECJdnYMngMm/6ZwLCKsP++zSdo+FvQVwSxZBj8vovhqq
	tn3Ytto52bhaAWKCXkkE7LXmYCg70p0sTanv8FbfQlqe8HbrG3EYcUsfLtEdF0iqpmSOhWq+UuY
	c25heQ2Qc9IkC/Ogz0b0tTYb2R/vD8SihKuOzKz6X41HMLSeZ9rlZZiU4yB6cpwYHbsisYxThu4
	yncWDFHJZJ3Ppn61LdOfJxAQRRhOHkpRPs+N/a0RRvVmp5N9IWytzQxBMbRarRaCiT79WGsgb/s
	TGu42w/WNcQDzCXEotZdxthL30s3ItIkTqQzcUlP6TWNgaolBTdCBH5R95WxC851mKAqsq+htn0
	j1Mio2wkv0LS8R4P1+tGPvaw==
X-Google-Smtp-Source: AGHT+IE5xsf3o3bLXf3bxltZUYTgpns6qL/y0vB31JTBhm0i5AWknUyayIasT5hdLNbaFDg88LZ15g==
X-Received: by 2002:a05:6000:603:b0:429:c8f6:587c with SMTP id ffacd0b85a97d-42b5a6d1304mr1581770f8f.0.1763132736753;
        Fri, 14 Nov 2025 07:05:36 -0800 (PST)
Received: from [192.168.1.105] ([196.239.132.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206aasm10487274f8f.40.2025.11.14.07.05.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 07:05:36 -0800 (PST)
Message-ID: <1b598791-6d03-48a0-85be-da7d3242ed74@gmail.com>
Date: Fri, 14 Nov 2025 17:05:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/super: fix memory leak of s_fs_info on
 setup_bdev_super failure
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com, frank.li@vivo.com,
 glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, slava@dubeyko.com,
 syzkaller-bugs@googlegroups.com
References: <69155e34.050a0220.3565dc.0019.GAE@google.com>
 <20251114051215.526577-1-mehdi.benhadjkhelifa@gmail.com>
 <20251114-raubt-benoten-bf2d8f2317b2@brauner>
Content-Language: en-US
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
In-Reply-To: <20251114-raubt-benoten-bf2d8f2317b2@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/14/25 12:55 PM, Christian Brauner wrote:
> On Fri, Nov 14, 2025 at 06:12:12AM +0100, Mehdi Ben Hadj Khelifa wrote:
>> #syz test
>>
>> diff --git a/fs/super.c b/fs/super.c
>> index 5bab94fb7e03..a99e5281b057 100644
>> --- a/fs/super.c
>> +++ b/fs/super.c
>> @@ -1690,6 +1690,11 @@ int get_tree_bdev_flags(struct fs_context *fc,
>>   		if (!error)
>>   			error = fill_super(s, fc);
>>   		if (error) {
>> +			/*
>> +			 * return back sb_info ownership to fc to be freed by put_fs_context()
>> +			 */
>> +			fc->s_fs_info = s->s_fs_info;
>> +			s->s_fs_info = NULL;
>>   			deactivate_locked_super(s);
>>   			return error;
>>   		}
>> -- 
>> 2.51.2
>>
> 
> No, either free it in hfs_fill_super() when it fails or add a wrapper
> around kill_block_super() for hfs and free it after ->kill_sb() has run.

Ah. I just saw your reply after my I just sent out a new similar test.

I will be working on it with your suggestion.

Best Regards,
Mehdi Ben Hadj Khelifa

