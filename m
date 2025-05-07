Return-Path: <linux-fsdevel+bounces-48318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456DAAD438
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 05:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0232D7AC85A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFD17A2EC;
	Wed,  7 May 2025 03:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVjQblnn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6A1C54A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 03:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589510; cv=none; b=GdT5h2v/eSzVxNY8K4hHUO3eNyFowE/CIJZWofZ/JR967s6CDLfm7awtjn9jyvGuqBBsehayNXG3Qwy5Y5kElvn5bPZJKLCsaWFutn9GIzmdRc3KQ8frYnT+sqeEQPN1K/DHJUS893vjkLt4vA/NvoFehhkyENMEdqAT/kDQlFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589510; c=relaxed/simple;
	bh=wypHOFT/MzxsC9+UamlDZl785kKBNDgq9//xHw2/nVs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XA3h1Glkbe8WY4Jv5/YOmNa2twFCh0mgbxf5N1ao5MiAWJEdlO7QKJFg+t2xd5zbusvhxiG5iqHFgYJaDzp5PdBs3gcErZ/+gnQDy1HVtmeFtkhVvhw4LW9ONc+v3Fu/5eIDgKC59mz5r9Dyq+A1d4pAhyik3Lo8JS8rb346pwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AVjQblnn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746589507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iUptd6F4oG0VOYqO06dHpB/sMUUK+Y82o4gN6z00S3I=;
	b=AVjQblnnafiJkXIfz8jlfFugmXi//rhXVmSfTer2bMJlMqUBbbLitqYmx125ybMpR6Lsvv
	cf8O3jXOP4ip7Q26w6Ppwh9NDqtxvh3cNGh0/W8W5vFlDJlRDhSs6NSrplDAPPeCbLBkA9
	hhUft8WVIPsd+MSBS/Qy5egxVeLLvYc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-lUjoc_C6MlCt7e1VUkmLcA-1; Tue, 06 May 2025 23:45:06 -0400
X-MC-Unique: lUjoc_C6MlCt7e1VUkmLcA-1
X-Mimecast-MFC-AGG-ID: lUjoc_C6MlCt7e1VUkmLcA_1746589505
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3da707dea42so23019575ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 May 2025 20:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589505; x=1747194305;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUptd6F4oG0VOYqO06dHpB/sMUUK+Y82o4gN6z00S3I=;
        b=e66zJRW6H7GIAIcuufROQfws8Fi7eoBKtnqAAaoICG7qBUN9N++hYwOl+A7W0lfLY2
         NOZclk2E5TfbAR3tmfa2J/zXTYYI7Fh3TN3yR8BDe6R5pDV9QKvvukFb6CVlUz/GD9Jo
         EcyVH+7vrhOOwKzEAep8NAyzpOVa/PZirB+aEYAlblyDHJW+NdbTFyRzOBn5EuQGyCCF
         0JvyPQLo+P1GzE7JNxQXWuHPwwjh/9Q8iWInpGRtMFbsdJuC9nu7KsxDZEFl9DrdzxKW
         A6dMK99dqBkK+M1r5rX4R4scl732CeGF1GvDMQB6T9+5qIUdeuARwkqQhQ/TbaThQ6wz
         0sew==
X-Forwarded-Encrypted: i=1; AJvYcCXQK/0Su48j3mdX8LDKBgDGllQHUJ11kbuTkpcEgABaL4mZoR4UE+qrfotYIRCyTje4DPV8dJ6yNiSKMTGT@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcc/0FvLW7vaaX6m+U+FOLY/Itn83ixhSrUkER2dpCNZJDNY5z
	b+AZWBBjZfWlam39dfaigWtQy9NIEz/CiUU+1oc2LRzcgrPBWAOnCIi7pIhvAA4Qd+t2xwr2HyX
	6sDypLmDhDiyqIZrI8rRr7CFSrxv/VLWO53iKYCtnsHe2RqwtUEjLoWrapY4bpS0=
X-Gm-Gg: ASbGncsr/XRgIZP22HM4qicxBwawBd4WbHWo/QotxV2l6DT45juIf+nsHpsWO6Wz+yc
	kbtIq3kJX/PtqM7EVFJ6W++yfRAY63vxS3wxVFw+hnou1hMdZDFvpo6sc7lQhC2QSqiPWbIdDa/
	qfIokAJvV7W3P0pE3kSOi1/URrK+ZO6kmsqrwFk+waPisJ7JiRVMSecOBPo41X/+YsRcLjNjjSk
	1/kGzfD7DOx/z6iZqQKd2/1Czo5LsxBzj6El3nHDHCLge2J8FODCBxLKeO3mQVLD9lXKn9zCuet
	QsFoHPu62bJDckaLrgOw9QWk9846Iwd+hExlXmurFL76tZFcCw==
X-Received: by 2002:a05:6e02:1549:b0:3d9:6dfe:5137 with SMTP id e9e14a558f8ab-3da738f962emr17763525ab.10.1746589505413;
        Tue, 06 May 2025 20:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQx6RG9So6DDmRMAzVujY6px4pWLDRiLTL/2yLNLQkiwi7UZTvELyeKidJqYkoIMKlHB5f6A==
X-Received: by 2002:a05:6e02:1549:b0:3d9:6dfe:5137 with SMTP id e9e14a558f8ab-3da738f962emr17763345ab.10.1746589505056;
        Tue, 06 May 2025 20:45:05 -0700 (PDT)
Received: from [10.0.0.82] (97-116-169-14.mpls.qwest.net. [97.116.169.14])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d975f73e68sm28266455ab.72.2025.05.06.20.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 20:45:04 -0700 (PDT)
Message-ID: <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
Date: Tue, 6 May 2025 22:45:01 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 0/7] f2fs: new mount API conversion
From: Eric Sandeen <sandeen@redhat.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 chao@kernel.org, lihongbo22@huawei.com
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
Content-Language: en-US
In-Reply-To: <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 9:56 PM, Eric Sandeen wrote:
> On 5/6/25 8:23 PM, Jaegeuk Kim wrote:

...

>> What about:
>> # mount -o loop,noextent_cache f2fsfile.img mnt
>>
>> In this case, 1) ctx_clear_opt(), 2) set_opt() in default_options,
>> 3) clear_opt since mask is set?
> 
> Not sure what I'm missing, it seems to work properly here but I haven't
> pulled your (slightly) modified patches yet:
> 
> # mount -o loop,extent_cache f2fsfile.img mnt
> # mount | grep -wo extent_cache
> extent_cache
> # umount mnt
> 
> # mount -o loop,noextent_cache f2fsfile.img mnt
> # mount | grep -wo noextent_cache
> noextent_cache
> #
> 
> this looks right?
> 
> I'll check your tree tomorrow, though it doesn't sound like you made many
> changes.

Hmm, I checked tonight and I see the same (correct?) behavior in your tree.

>> And, device_aliasing check is still failing, since it does not understand
>> test_opt(). Probably it's the only case?

Again, in your tree (I had to use a git version of f2fs-tools to make device
aliasing work - maybe time for a release?) ;) 

# mkfs.ext4 /dev/vdc
# mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
# mount -o noextent_cache /dev/vdb mnt
# dmesg | tail -n 1
[  581.924604] F2FS-fs (vdb): device aliasing requires extent cache
# mount -o extent_cache /dev/vdb mnt
# mount | grep -wo extent_cache
extent_cache
# 

Maybe you can show me exactly what's not working for you?

-Eric


