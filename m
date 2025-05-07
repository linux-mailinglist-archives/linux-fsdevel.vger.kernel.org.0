Return-Path: <linux-fsdevel+bounces-48312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15EFAAD26E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 02:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA3DE1B63CE1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15C25A79B;
	Wed,  7 May 2025 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iMYYpN/b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D554A94A
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746579087; cv=none; b=ggP71tGB6yhx92mzz09K9fKn8GGb3ZUqzEBWlITSPgwl+xFtz8YHIiTuxmO/Y5gl3e05NIWxq5B69R282O+zLa95BWN89KNZ9a9+FizaF2Gqhbjkx36tdEvkCYA+Alu9l/Xeo24D5fskkZgouQSQ/+ozDaIjIALLx9sNzZwQqpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746579087; c=relaxed/simple;
	bh=0pWr2cd+by9UmAmsp9hYIXDpK4lbQf5sBIt9vQ+uU8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cy2sNbn7hvAjYfsusJBEAf49SAB3tURY8EslLjsSfQy1+Bmyc+nU4PmJFJKRKxkVu0V7Hp5KdqE+GsoRS7Xz/NlUMryXWEU+lFsqUTwsO4YpAGJpR8x05RUV4wfSki+PHlVi/dCC50nR95gwefgAalhuJuY4tgB7fHhEGpWeRw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iMYYpN/b; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746579084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0pWr2cd+by9UmAmsp9hYIXDpK4lbQf5sBIt9vQ+uU8Y=;
	b=iMYYpN/bZWRs1Fm9hPhXltHCLnzd0VzAQJpWdXbyvYZ35G9U5p+r4VVaEpvE71S24d6F4b
	X6nKQFnGYIi2qPuzQ8VMwMEPGUVmC/xFQe0HQpHaYhSYzYaP2cevURUxxfbr8ahR5+ck0T
	VDl7PXobDVzO3Q4+TYVbnsIJreaDocs=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-9T6CNXVrNBq2v__ZwxpY4Q-1; Tue, 06 May 2025 20:51:21 -0400
X-MC-Unique: 9T6CNXVrNBq2v__ZwxpY4Q-1
X-Mimecast-MFC-AGG-ID: 9T6CNXVrNBq2v__ZwxpY4Q_1746579081
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3d43d333855so61906255ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 17:51:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746579081; x=1747183881;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pWr2cd+by9UmAmsp9hYIXDpK4lbQf5sBIt9vQ+uU8Y=;
        b=X/5JDWc8NX3ah9Uq7Y5NPD8W9R+my//yMMoDsNUeT9AbDA5yFdwBBW9ME5idRqeH0q
         o7Ll90QqBTJaaV3/tgVYXvX+NWI7vnytAZ9NsXYgFMqTvQcia5kzy63Bq6EAo0QMuBab
         iopXSItB3dcmbm4bqQxXEGs2bNFn1cPyh5wd8p/yxub6y4vYGgiSX9PRJzPgskCZSdUh
         BC7/9l1cyLKnDTuOUrkmYCDWY0qRPLMJ2dHXpzVRDId/MJ6dENa67DVBZOxpQcXSTQuG
         jpeJIfiGr0BAkXqx0uNFq/m2Bj3Oh8kBfOPds5Px2l1nP+8zBou5deQG796gXSx4NqE2
         G0wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlayZ3rpNwbIqXI7N7HyFeBP/l1GMkooz6jUpAVDkrlRopMivyduKNl7jRuyEOhbkkJQecpoZYRmoiMnyp@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4G4bJWRVsU6F8zYvrtndCjXaEM5ORGVCyxmTjD+m+ak7Et/hf
	bvUXO4lsT2o+0ueaOAg69kchMKg+gESvvn7ZmXPqe0voOXWFwjGmvpmh3W0qtBC3xswm6d+4dWn
	5fGGTlp7K2anvneFdWSQNheKVHPeeF0gHsCXkns0DiFJb1SN0gH1bd1WZNOj2c6s=
X-Gm-Gg: ASbGncvjXn9qQ8ZL2daWiNEPeyQRi6vd/dN3/pyqREv6cgS0/MKuWJ+0FjlBIdcrBTG
	PDwcwKVrqLYq5yXqb7QPrNcsb+qhoRNOWWqahth2mY1arNPiaih2zP6qMfUUuaX+CyONc8JUvce
	O5KXIMhsCjGjKqkxh/HVUQWF6Q6lNSeBxRdZ4R38MAGnLp6ELGFlGG4CRhD33r+RoYuArshzo6e
	HFnYIh86rfOLkZv7NmgmkTLh13upIDItVDUVa1FlhclgA+qVQYS1kh4icVfASOpBBXLmrH7/bU2
	E6kHyadWTgdTDOf2L7RkGWvaycg4uybkmIHFLfKh7mPFuDj3MQ==
X-Received: by 2002:a05:6e02:1aae:b0:3d6:cbed:330c with SMTP id e9e14a558f8ab-3da738f0d85mr12512865ab.11.1746579081115;
        Tue, 06 May 2025 17:51:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ0VOD9u4tL6JybdUb0h9a596TAGo0eVzlgDRptJuHaa/SZEu6MEmjYCHo+4LemHqTUy4pLQ==
X-Received: by 2002:a05:6e02:1aae:b0:3d6:cbed:330c with SMTP id e9e14a558f8ab-3da738f0d85mr12512745ab.11.1746579080702;
        Tue, 06 May 2025 17:51:20 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7306f4a5sm2549905ab.49.2025.05.06.17.51.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 17:51:20 -0700 (PDT)
Message-ID: <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
Date: Tue, 6 May 2025 19:51:19 -0500
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
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBqq1fQd1YcMAJL6@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 7:35 PM, Jaegeuk Kim wrote:
> Hmm, I had to drop the series at the moment, since it seems needing more
> work to deal with default_options(), which breaks my device setup.
> For example, set_opt(sbi, READ_EXTENT_CACHE) in default_options is not propagating
> to the below logics. In this case, do we need ctx_set_opt() if user doesn't set?

Hm, can you describe the test or environment that fails for you?
(I'm afraid that I may not have all the right hardware to test everything,
so may have missed some cases)

However, from a quick test here, a loopback mount of an f2fs image file does
set extent_cache properly, so maybe I don't understand the problem:

# mount -o loop f2fsfile.img mnt
# mount | grep -o extent_cache
extent_cache
#

I'm happy to try to look into it though. Maybe you can put the patches
back on a temporary branch for me to pull and test?

Thanks,
- Eric



