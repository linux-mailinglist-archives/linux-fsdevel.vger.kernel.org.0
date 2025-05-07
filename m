Return-Path: <linux-fsdevel+bounces-48315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A82E8AAD3A2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 04:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B4DF3BBB7F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 02:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBBB19F43A;
	Wed,  7 May 2025 02:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d2AWDOYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10C679E1
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746586585; cv=none; b=DarvKbSM9vbB5bBRX9Hx8AOefPjSPkBS8ZHbuqfiH3sQY6rtBvrgRSgi1nusxgbmB8uxONU5Z2/kcf+vVFJJL6/QoFT5ws56QR1V1dwQbc+HE1jLqYcKXhsOtXPGa+C9DZIjVHYlenyywTI6WncM//P/NqGjgSzIQHZRxV58iGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746586585; c=relaxed/simple;
	bh=zOqao76QONh193E3M2BAOE/ccdxxYMO8xqfULovO7M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J13Rk8ikiUiX6leUjcFTnXwbfzWyX0d30Tp+XDKLWrDMGtpxYu2Bd8KaGJYzwE2U22o2JWCDtlkbtx19R7TzYB695/susQ8Bil9NafR1s/m9tswhhvq1JoBa7N5SCWU8yIkmAryln2YLydPeUuFutPViTUKYpYo1whmnsiVp0xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d2AWDOYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746586581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6v13hBXxOIEJvuIfma0sX2loz9ZFHIAPS4YyMthI+CY=;
	b=d2AWDOYUD/o67bWpl3XyPAycVpBunyHbMBQLlQJ/XFRERdw8FoKsy441n1Sn13K6hzi4R1
	urrOW5NLVipkBwWZb9fABW/eFlJQCEUNDsVWLJGF3Bzbv+hhhv4ZDf27Ti9Tfy2I+TT7Gq
	n122qh6QBfMCrSQAPrYGfTr17Nra/a8=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-ruKpvFYbOU66njriN52FTg-1; Tue, 06 May 2025 22:56:19 -0400
X-MC-Unique: ruKpvFYbOU66njriN52FTg-1
X-Mimecast-MFC-AGG-ID: ruKpvFYbOU66njriN52FTg_1746586579
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d81bc8ec0cso122826215ab.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 19:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746586579; x=1747191379;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6v13hBXxOIEJvuIfma0sX2loz9ZFHIAPS4YyMthI+CY=;
        b=Tp8IP3n8BwwH0xn9cIOfG6DV3lvKLmqvW8q2i+yNF5Z54aQMCB7tk33XmU9Rn3bues
         J63YInAeT3Q/wY274aXYtfltWF4lws2x1goMQKoVBF34WRnHPVdvaIDjNvlQx47I5UFT
         jvGYypDRURdGjKOiTbLKQqcFGEbVxvf1BO8uGRDhKp7GFW5J9fmK0v99Q3QGI8h8vssz
         aQhug4M7KwxByw/c+6OoHr2dgCGocklYqvgQ35NiwlcPtlUBTFe+Rfnp9KG8Qub8cIlV
         6et90hwwod1d5VtL5f5ZSvboJXiL/gah/DUyK/i+YMTAbMiChOd09/iMKZFx3WWOTs+5
         q8BQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3Xq1yerHacUI+ASJ7BfrmTTZetclwk3D5LSDwTkQS+o4lQIwenJwDyrrmVFacizZV3rLMl0bIUF6Xgt0l@vger.kernel.org
X-Gm-Message-State: AOJu0YyAx6Mq4JRtnAfeuW6AXoDFnzIKGbdq4w4hZhbLc1hiNVAB0ed+
	IHWmCdcWbIz4nDnOtEsJLMCY6Biaj2YleqEOx2LJpx0y6K9kxz6PZs+TbTGh9RIWRMn1Z5szTg0
	5rIYmD+pVAidRx+cLhlzprVOah+2HtOR9zg7w7Vp0GtJJsr0BYgvT3Lmlj6FKZGk=
X-Gm-Gg: ASbGnct52gGsAVMJxBF6ryUujk2scX8cKR669TlNe2cihOyjL1i60nnKjXWHnLC04nV
	ucB9IGfUu2QavGQ0aqfwAQXbiUdmfqUnDD/0dRKAButEIgBNC5mPRU/YIyLS9Ah+t23C+qAMB+F
	6xToF+cMxaFHcJAF8VWAyshMXCGzqQMnxGsB37Zq8NIlvrhaDOdvqXzteYHiOgnmdGNE2ee+uro
	ATL1x1ArSrpJgh314FffbeurT0biAQm0zpZaBSUYM7ZUjs9ydwf/LZSF0oKQHxE1rvRRy88lkGb
	w5ACBWP9w1i/Eg9IvZ3NH11bWlOl6C35j3/wSuaX3Jg9WOSW+Iwm
X-Received: by 2002:a05:6e02:1529:b0:3d5:8103:1a77 with SMTP id e9e14a558f8ab-3da738ed6c7mr15950775ab.1.1746586579119;
        Tue, 06 May 2025 19:56:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvhazwqX/isryjo2Em58HlkEQs6DbIsyogQaU4RF5dJTGp+n9kI8lL0SQS1m+Sp3HWH7IxmA==
X-Received: by 2002:a05:6e02:1529:b0:3d5:8103:1a77 with SMTP id e9e14a558f8ab-3da738ed6c7mr15950615ab.1.1746586578854;
        Tue, 06 May 2025 19:56:18 -0700 (PDT)
Received: from [10.0.0.82] (75-168-235-180.mpls.qwest.net. [75.168.235.180])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975ec7df4sm28463795ab.32.2025.05.06.19.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 19:56:18 -0700 (PDT)
Message-ID: <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
Date: Tue, 6 May 2025 21:56:16 -0500
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
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBq2GrqV9hw5cTyJ@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 8:23 PM, Jaegeuk Kim wrote:
> On 05/06, Eric Sandeen wrote:
>> On 5/6/25 7:35 PM, Jaegeuk Kim wrote:
>>> Hmm, I had to drop the series at the moment, since it seems needing more
>>> work to deal with default_options(), which breaks my device setup.
>>> For example, set_opt(sbi, READ_EXTENT_CACHE) in default_options is not propagating
>>> to the below logics. In this case, do we need ctx_set_opt() if user doesn't set?
>>
>> Hm, can you describe the test or environment that fails for you?
>> (I'm afraid that I may not have all the right hardware to test everything,
>> so may have missed some cases)
>>
>> However, from a quick test here, a loopback mount of an f2fs image file does
>> set extent_cache properly, so maybe I don't understand the problem:
>>
>> # mount -o loop f2fsfile.img mnt
>> # mount | grep -o extent_cache
>> extent_cache
>> #
>>
>> I'm happy to try to look into it though. Maybe you can put the patches
>> back on a temporary branch for me to pull and test?
> 
> Thank you! I pushed here the last version.
> 
> https://github.com/jaegeuk/f2fs/commits/mount/
> 
> What about:
> # mount -o loop,noextent_cache f2fsfile.img mnt
> 
> In this case, 1) ctx_clear_opt(), 2) set_opt() in default_options,
> 3) clear_opt since mask is set?

Not sure what I'm missing, it seems to work properly here but I haven't
pulled your (slightly) modified patches yet:

# mount -o loop,extent_cache f2fsfile.img mnt
# mount | grep -wo extent_cache
extent_cache
# umount mnt

# mount -o loop,noextent_cache f2fsfile.img mnt
# mount | grep -wo noextent_cache
noextent_cache
#

this looks right?

I'll check your tree tomorrow, though it doesn't sound like you made many
changes.

> And, device_aliasing check is still failing, since it does not understand
> test_opt(). Probably it's the only case?

I think you can blame me, not Hongbo on that one ;) - I will look into it.

-Eric

>>
>> Thanks,
>> - Eric
>>
> 


