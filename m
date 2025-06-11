Return-Path: <linux-fsdevel+bounces-51336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2997AD5A62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE7D1636F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 15:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234781C6FE9;
	Wed, 11 Jun 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E8VFAdOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD87B1AAA11
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749655606; cv=none; b=lbwwuNfs8dkc7pEbeail0wbwCqEjVmvWrAyFMasOZOdd6w06YzOcXbsC5UMHmiPwY++BKWAuOOWhg4UHnBFYN+mqV5cv848SQC0XxcS9YPwEg8xR/A+R3AaT/WpgywoJbrXPsM2UX2yCdfHUnjCQOJLJZrm7+dpTedOeWe/y4IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749655606; c=relaxed/simple;
	bh=Zclb6nP9tKkJil/hrncF8At7GwOesOJIVfldb1hH5Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FT/QUApoMcNus9KxDqyXCbpVRU15iJYCmuXTJ1nwWw28cHJTZiIeH2RRvQtaI+VCxlck1/VDwmXMQjW/cAKqO6DWaULqRq6yLRAqUjJwfH3eZJq0YEAKf/CPlzy4t5HnovKM950QZfGuCbFle3UtGJnb+PsbPeElwOMTAtqGpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E8VFAdOT; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-872886ed65aso554245739f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jun 2025 08:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749655604; x=1750260404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=E8VFAdOTu+z7NAH3Y9NFWPox06EIuHK/dw3gj7rHm+qecwZF01BLOFMRbYXcDDNVDv
         YO9fn5kdmEku+d8ANek+tYGF3vb7h1wN/Hfy2Zj/vzHCCysf+WqoVGLz0miCgGaGOhQC
         tpoiFMhp4uiHzIZtrd6JtKxPBfaY50y+s53WotNLrwzkhY5+pg47NGs0bKnd3XWmuYZ3
         mesEXznMEeAGV8devH5qRRaH1M7DUDpEkhc4KjDXPmvOBbYEfTFyicgRFwtFyM1kw3tx
         kMhoJvPIAV1odxZKkslbZRSZgnOfMsQR3alnr5hM5/1yf7pvn2Ik1arzmoJEPOD3mW8C
         EziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749655604; x=1750260404;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25gqdr8OB8B8YYkPUeyMN7WbLBqsy7NImg1t9TKxdME=;
        b=h5W7fh9VXXRibP/0zlulK+1cztlmLVFDUuTnQrNvscfak/bb58iGeQ/De9l03GI7cw
         YD4Lgb64LdaQvZu30AxwUVV9cKIa3N7W2UuhNyiwPgWYCq85EJ4O4rXtFN7WsocGyWUV
         1+JIkRMGuf90cM/2hc3vDGjHOBsWf1T4wnu9mRxBS9KfhfCHoVCEUlVzC3rB9H8YJ9sD
         hdlJB3NBx3CB43MZNXMevFUmM+41G+nhdiCY+niDuUOobwOMHMmG1WcRpSHyz0diwxfH
         OwtF6bkdXxg1/eeLYb9xdNgZ3EuH6hfpdmOE2JotUR3ff003rYAezk+DlHTw3UFWWxIY
         aO9w==
X-Forwarded-Encrypted: i=1; AJvYcCVYOTv8tdO3plIHbnBzcz7N/rgHbMk+7fVuNdYpSf7/MzryZ9KK78Re/lpSGbR+Mx87ljVRRKHj/hsgYT1o@vger.kernel.org
X-Gm-Message-State: AOJu0YyiVC2bUNRVrvPykWRwJzjHK4aMzEdDKoaskrfGlH9nyjTD++8V
	6t600jQmbRUvUOvjoo9rVr81oUsMN00R5vIWxs+s4QHQDwpZ6fck6qu8CD5jUjaNlwQ=
X-Gm-Gg: ASbGncvC3GLIQqRR0ySztwBDJRez3u8Vjk197pWpmjTQhdTKL+3cDlVLWiZxSGPeQne
	NETUV1Bm6zVHbXxxXIgD1RjreYLobV9OtODIk9vmOoKWPi4Z5RXey5rWGo+s331W/V5Vm0v5uHg
	AzdQdeeJP3qr4JieojQa+zVRs38R9KAWWW+XxvaU/7CO5oFDhkUqBMq2/FM96dXblmmpnj8Nuz3
	ZJkYiTfheaq8SHBR0NTK2ZaIgjnAqOjwjbgkRTKfY+ZK2Cwz26mDV2OkxpLm51NjH5kxTlONDz8
	dI1K2SIhh+Pgbijw1Yo/j7KfvHwomX7rKJD+uj2fASzFtFwAPBTMirTdrQ==
X-Google-Smtp-Source: AGHT+IHaxfT+O57Vn8979jdX84yGSFMet3prL9YRAAW17QgstqoINM/JBUR9h2E/1+qlZME9XacRsQ==
X-Received: by 2002:a05:6602:36ce:b0:85a:e279:1ed6 with SMTP id ca18e2360f4ac-875bc472084mr439890139f.11.1749655603849;
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc5b4294sm44276539f.14.2025.06.11.08.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 08:26:43 -0700 (PDT)
Message-ID: <afb8792b-a78d-4886-bf9a-23121510dec5@kernel.dk>
Date: Wed, 11 Jun 2025 09:26:41 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "block: don't reorder requests in
 blk_add_rq_to_plug"
To: Ming Lei <ming.lei@redhat.com>,
 Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
Cc: stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Hagar Hemdan <hagarhem@amazon.com>, Shaoying Xu <shaoyi@amazon.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20250611121626.7252-1-abuehaze@amazon.com>
 <aEmcZLGtQFWMDDXZ@fedora>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <aEmcZLGtQFWMDDXZ@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 9:10 AM, Ming Lei wrote:
> On Wed, Jun 11, 2025 at 12:14:54PM +0000, Hazem Mohamed Abuelfotoh wrote:
>> This reverts commit e70c301faece15b618e54b613b1fd6ece3dd05b4.
>>
>> Commit <e70c301faece> ("block: don't reorder requests in
>> blk_add_rq_to_plug") reversed how requests are stored in the blk_plug
>> list, this had significant impact on bio merging with requests exist on
>> the plug list. This impact has been reported in [1] and could easily be
>> reproducible using 4k randwrite fio benchmark on an NVME based SSD without
>> having any filesystem on the disk.
>>
>> My benchmark is:
>>
>>     fio --time_based --name=benchmark --size=50G --rw=randwrite \
>> 	--runtime=60 --filename="/dev/nvme1n1" --ioengine=psync \
>> 	--randrepeat=0 --iodepth=1 --fsync=64 --invalidate=1 \
>> 	--verify=0 --verify_fatal=0 --blocksize=4k --numjobs=4 \
>> 	--group_reporting
>>
>> On 1.9TiB SSD(180K Max IOPS) attached to i3.16xlarge AWS EC2 instance.
>>
>> Kernel        |  fio (B.W MiB/sec)  | I/O size (iostat)
>> --------------+---------------------+--------------------
>> 6.15.1        |   362               |  2KiB
>> 6.15.1+revert |   660 (+82%)        |  4KiB
>> --------------+---------------------+--------------------
> 
> I just run one quick test in my test VM, but can't reproduce it.
> 
> Also be curious, why does writeback produce so many 2KiB bios?

I was pondering that too, sounds like a misconfiguration of sorts. But
even without that, in a quick synthetic test here locally, I do see a
lot of missed merges that is solved with the alternative patch I sent
out. I strongly suspect it'll fix this issue too.

-- 
Jens Axboe

