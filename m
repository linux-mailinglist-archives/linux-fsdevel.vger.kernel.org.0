Return-Path: <linux-fsdevel+bounces-48424-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD24AAED51
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F98A7BA716
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D121628C5B5;
	Wed,  7 May 2025 20:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IV2L6LOr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9E65A79B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650772; cv=none; b=enCuuClXNdRRxzzITZHpWlmkT+eOmlsdrRRSa5Dc/ufI0J74dutA8kbheQib8+jTm7+CMDW8vOlSjPFXaoAShH3m0vxr8P4fa+WXT8Lp49tem9tE6C5W3Ur2uqUvJr+XNXkV6ajXMNcs/cN6JpheBKj/2agh5VN0WOGRO531BOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650772; c=relaxed/simple;
	bh=m+9RrP6mDWX5/XkfRqIpJ5SmBohazOWCYcqVRlZJ1OM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jEf+WTLBDvCqzg3KXD30BLcyCIwFfKT7mR0zmDTKP4eLDyh8daEiGYTwkcsKNd4DrfOhS4UEXw2vZPokSQQlYV46GTObW4kJV0YZAGQmXjRt1c1C+FOsTWJ/NtI7EKczwwek+Ba+wVx0ZoKkYN79y9H8NP/SE32JEgPQGoIIK8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IV2L6LOr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746650766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZtvJYDNlO6G6hDwP0P9OZNeT6PCGTZnZorZ/GCvPqHw=;
	b=IV2L6LOrVVGTqJx6T1xM9qfG++Hx4Qjs7hkSy6GMyoCTIPxMaSwjkMSKNCWUIMjyAsZ+mk
	+z+KaykuwnBfWv0PNMYL4jhtRH+VBVxxctWRi3utTz5nevZp9lLMlXFb5mJl05ZK7pht5z
	K4mnW+RWCPnKk/p1G2vWFcCzlJtIhQE=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-B9Np0XgwMaWwmGaTapGbRw-1; Wed, 07 May 2025 16:46:05 -0400
X-MC-Unique: B9Np0XgwMaWwmGaTapGbRw-1
X-Mimecast-MFC-AGG-ID: B9Np0XgwMaWwmGaTapGbRw_1746650765
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3da76423b9cso3010385ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:46:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650764; x=1747255564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZtvJYDNlO6G6hDwP0P9OZNeT6PCGTZnZorZ/GCvPqHw=;
        b=pTwqFONUyuiX4sSTYqdy1ZGS+df/ooF9eyqisklujepWKJ3p4ByDOhfW6Rcs88jX+k
         2Ymg7rHCI2YKnBhwirjOhj2wVMhNx56WSHXmySykQPuKd7ZPZxtpaYjkwOwOiDzWYN2z
         Jk+IpcUEKn87WGSCrEXNQCUyrWZX8BAccNsTkB0y4D6/03PgjtMM6fJXoDPUCDGhPZJk
         n65di7OUHQHjmdbBmKmazIn2zsRj8N5YvwdvEBXU/nJXxIGJe5iJKAaJef5foJOxcvS1
         4aAnxNsf4Y5MA1Jg1I9s/NuVHXcMfVXuWLn4c73gKFPFvKKD9MHvkfKeSFzqavm5kjnl
         pcFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuDAifhfuEnfOVLDFiMUOHjIGz4ecgxMMgN3WIzUdw+hgv0nSSkKfzMAnfBHYxHQWYF4EreF7o+h0ZVgBH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz5otEyDKuRAwWMZbBz5AgA+w8jGXhAIqlFCTNYwQm2mSYrCzn
	SCHxGs5aZB4TVh/sAh5M+weCbkzIpqEN1mSmK27OAhcUqB/M+zEBf8zYQT6fAVoTEohdIMkeSeB
	XZqvXSvL/mJg6UgKE5Sauu/lb8pDmMmwE7LZgLpHjK0b16aZWzGF1m09HxCrdxd8=
X-Gm-Gg: ASbGncu9sk7Io1TiG+prW36W0RwIByNpYY8LCDv52bLKek6NBa64jaKQ1BWBmteA2gp
	9Lhf+HwFjAEigtiIXjJEkqDGTyOxvEmGAsdcthsbY7+9Hnj7BrA7vrg/CimB9gJRnPxCkQCgMUK
	RBAT1DnwhR7eY2wWKvcbn5N1YlE3vycjkNlg7QTIZ9RfMCpd0TRA285QZzF3zuskIb8jNxCM6va
	tcBgyiz7l8MIR665D2YW0MTGkO8X8Tp1anh+Nrxt6r/RklxYDQteOYBpV+gCh2Hpk110TrrvHfE
	GBGAaeqvkQ8EJMkTwQjuD2syzSSaHfGKR1Gx5hzJ8Zr6J2enGw==
X-Received: by 2002:a05:6e02:194e:b0:3d9:39ae:b23c with SMTP id e9e14a558f8ab-3da73930025mr57875345ab.20.1746650764719;
        Wed, 07 May 2025 13:46:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHScsCoRYIjUNWW5yDa0E+5rQrYqBqSuhif/7D+Zq0+3jJ4Uj1U10vDL6uVhOSKCIfNdkckww==
X-Received: by 2002:a05:6e02:194e:b0:3d9:39ae:b23c with SMTP id e9e14a558f8ab-3da73930025mr57875155ab.20.1746650764416;
        Wed, 07 May 2025 13:46:04 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a91b069sm2895193173.52.2025.05.07.13.46.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 13:46:04 -0700 (PDT)
Message-ID: <f1674387-66d3-443f-8d48-74d8dfd111f1@redhat.com>
Date: Wed, 7 May 2025 15:46:03 -0500
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
 <e72e0693-6590-4c1e-8bb8-9d891e1bc5c0@redhat.com>
 <aBvCi9KplfQ_7Gsn@google.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <aBvCi9KplfQ_7Gsn@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/7/25 3:28 PM, Jaegeuk Kim wrote:
>> But as far as I can tell, at least for the extent cache, remount is handled
>> properly already (with the hunk above):
>>
>> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
>> # mount /dev/vdb mnt
>> # mount -o remount,noextent_cache mnt
>> mount: /root/mnt: mount point not mounted or bad option.
>>        dmesg(1) may have more information after failed mount system call.
>> # dmesg | tail -n 1
>> [60012.364941] F2FS-fs (vdb): device aliasing requires extent cache
>> #
>>
>> I haven't tested with i.e. blkzoned devices though, is there a testcase
>> that fails for you?
> I'm worrying about any missing case to check options enabled by default_options.
> For example, in the case of device_aliasing, we rely on enabling extent_cache
> by default_options, which was not caught by f2fs_check_opt_consistency.
> 
> I was thinking that we'd need a post sanity check.

I see. If you want a "belt and suspenders" approach and it works for
you, no argument from me :)

-Eric


