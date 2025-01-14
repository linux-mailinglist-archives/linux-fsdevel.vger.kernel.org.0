Return-Path: <linux-fsdevel+bounces-39148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCA9A10A27
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC2A3A230F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 15:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08E5148310;
	Tue, 14 Jan 2025 15:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8CFDeK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C21232420;
	Tue, 14 Jan 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736866873; cv=none; b=IIXGvuSP6ZioW1hRfpwlOWdByaL8DrJ+PFUR5ZRHKm5BuJ61PX/UDHJMqba6Jrbr8lkXIlNNgeFIgHJ0VPcsuyk5VejnUBKJ2qpPqFeFF9hPLpQ7YrCQYejgaraGsTntBhpASokD/0At0LZKGttct5IO2GPDUE/DlL1DqhMpht8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736866873; c=relaxed/simple;
	bh=7xPU3CihrCiw8vjoQX/4/sOqySZweQ6a42LUniKndRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQNVdA03XRxcM0ptbpguhj92JZf+qzKnLRwDc8p+N2YEoiZaBG+ZkuqIHzREfdRt9HkKTeDkuZ56WeTQ5+DYJqy7RntdxeMwnznstCPw9TTBfFSe7z8DnpCXlZ5LqbhskFJIH5BMPH0J16pGUSYoIV6/0SUtWI2j5RIHr41bGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8CFDeK7; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2f4448bf96fso7051630a91.0;
        Tue, 14 Jan 2025 07:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736866871; x=1737471671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=c4XL14+oIbnjkerJ5WD+7L+O/vlI+wTPhMKFazY0Vx8=;
        b=R8CFDeK7J/hFXhjNjZzYEvjHU1/B2mNMcXsESy42/VGFc9L+M5oj+y/YbaxsVtju7n
         iNwB+IqKN+PO1aeNU+cfIIJAxUqhyHFS5OY5GWtJYOfsmJwI7PSnIHbgwQUWv0q3uhM2
         1hBd3Ufp6Kk81ZWZx3RMoCkEfdUzVZsOR6PVF/nPy5gvMoaHXQvOQG3qg2sl7vFcrQSk
         wjtvibTsDLynrq7ZGe/LAe35f7SThNCaqQFi/sQF9SkUjyhf5Z0a3WWie9c36ewdj4/X
         ns7aJh0V8KoDnWbmHJIEg6bqLhT5jFpehaauVi76NZGYAg7Uj3w9y9Hli2cVXnONul3d
         SIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736866871; x=1737471671;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4XL14+oIbnjkerJ5WD+7L+O/vlI+wTPhMKFazY0Vx8=;
        b=ODGGcxyUMF5f96G0WInPhm5EQ+8Z8x5YJc9O7wZMhRhR1FrATJR5w4Bk+tyhQTrQV0
         rd3fZmY/MxVa8G2Y5ll8/ixVRn0e5r2wfnDQrJkJZXbt7fPh77GSiGu3FWWZPUHBfREH
         cvdj+hgxPqSnluJMRj54rUJ3ODI5WUWSncCuPlOXBseCtHU5YKgSEMA+885YMB3Txyym
         HvH2Fg4ay8l9uPeGZCpENlg8W3tntc65iaesKMoYDO0hjq3OVO+p1vEyWh2iNRs9A6/L
         xg2tNvvoIlbk/0WL7cA5TAWXwiPEotP2MgXsXZt3S9xOQ3NTB9NfH4OLEdQZBKm1qwA+
         Hu6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjWqR7GbtBXkAU3bPXqdW2ELfnTqKrzCY3q5DrnuQ7MQ27ycEm2nUstEi5YPJo/BP4dnyxuwViNKXXi5R0@vger.kernel.org, AJvYcCW34KDRQafjyCzHbYRAyE357lt+Avcu/sShopnZhucrodBszT6O9CHP86u3Oa/oA1f2JLy8Jf2YG5sP99Nd@vger.kernel.org
X-Gm-Message-State: AOJu0YzmZ5Yp113e6NCP+GucaRynlSAzSshXPjN/+BtldI39VqEsGI+7
	deEIKb36xj5P+UJsOYehYTNaFQhXuAI69oQtveSdOLhHDTywRmnG
X-Gm-Gg: ASbGncvy16kDMQ1sbWrHwCudLP6y8UIQ6I2F5vmsrTOoENwDv4HkFV173gw8AAbwYXj
	a3fgbrAZtALUzcWcNY0Mnw+tFmin/rLBF9iPFG2co74UGvEM/PQAM9RDLz5IQXbvGjLpV1Qd0n1
	wz0Fdsu0tXiFkx024CwX9Ff//wMH4ZX+0djleJnkKlGzOL1n33UJ4oG2yJmG0pw+AMub7aIds5P
	oIwbn3cdkCOyjDR/KyRSEOCGPvnWtslbybZBQtSP5zYGtGWKWJ64uM6Wpmrg260/HczG+71Tc4m
	hrZvxvI9zWh7DlGZIqnt0cVw+ePkvA==
X-Google-Smtp-Source: AGHT+IHoIjoei3x+6cFXgCR+zscvE3MBDu+8qDVIkOz5icvFioeiJHBP+vzkJYAVHpmiZ+GIpJS9UQ==
X-Received: by 2002:a17:90b:3f90:b0:2f6:f107:faf8 with SMTP id 98e67ed59e1d1-2f6f107fe30mr8889956a91.24.1736866870547;
        Tue, 14 Jan 2025 07:01:10 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f559451b3esm9632739a91.37.2025.01.14.07.01.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 07:01:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <64a44636-16ec-4a10-aeb6-e327b7f989c2@roeck-us.net>
Date: Tue, 14 Jan 2025 07:01:08 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page-writeback: Consolidate wb_thresh bumping logic
 into __wb_calc_thresh
To: Jan Kara <jack@suse.cz>
Cc: Jim Zhao <jimzhao.ai@gmail.com>, akpm@linux-foundation.org,
 willy@infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20241121100539.605818-1-jimzhao.ai@gmail.com>
 <a0d751f8-e50b-4fa5-a4bc-bccfc574f3bb@roeck-us.net>
 <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <b4m3w6wuw3h6ke7qlvimly7nok4ymjvnej2vx3lnds3vysyopr@6b5bnifyst24>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/14/25 05:19, Jan Kara wrote:
> On Mon 13-01-25 15:05:25, Guenter Roeck wrote:
>> Hi,
>>
>> On Thu, Nov 21, 2024 at 06:05:39PM +0800, Jim Zhao wrote:
>>> Address the feedback from "mm/page-writeback: raise wb_thresh to prevent
>>> write blocking with strictlimit"(39ac99852fca98ca44d52716d792dfaf24981f53).
>>> The wb_thresh bumping logic is scattered across wb_position_ratio,
>>> __wb_calc_thresh, and wb_update_dirty_ratelimit. For consistency,
>>> consolidate all wb_thresh bumping logic into __wb_calc_thresh.
>>>
>>> Reviewed-by: Jan Kara <jack@suse.cz>
>>> Signed-off-by: Jim Zhao <jimzhao.ai@gmail.com>
>>
>> This patch triggers a boot failure with one of my 'sheb' boot tests.
>> It is seen when trying to boot from flash (mtd). The log says
>>
>> ...
>> Starting network: 8139cp 0000:00:02.0 eth0: link down
>> udhcpc: started, v1.33.0
>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
>> udhcpc: sending discover
>> udhcpc: sending discover
>> udhcpc: sending discover
>> EXT2-fs (mtdblock3): error: ext2_check_folio: bad entry in directory #363: : directory entry across blocks - offset=0, inode=27393, rec_len=3072, name_len=2
> 
> Thanks for report! Uh, I have to say I'm very confused by this. It is clear
> than when ext2 detects the directory corruption (we fail checking directory
> inode 363 which is likely /etc/init.d/), the boot fails in interesting
> ways. What is unclear is how the commit can possibly cause ext2 directory
> corruption.  If you didn't verify reverting the commit fixes the issue, I'd
> be suspecting bad bisection but that obviously isn't the case :-)
> 
> Ext2 is storing directory data in the page cache so at least it uses the
> subsystem which the patch impacts but how writeback throttling can cause
> ext2 directory corruption is beyond me. BTW, do you recreate the root
> filesystem before each boot? How exactly?
> 

I use pre-built root file systems. For sheb, they are at
https://github.com/groeck/linux-build-test/tree/master/rootfs/sheb

I don't think this is related to ext2 itself. Booting an ext2 image from
ata/ide drive works.

Guenter


