Return-Path: <linux-fsdevel+bounces-66830-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C24C2D259
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 17:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A34607EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 16:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE84314D39;
	Mon,  3 Nov 2025 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJm1QDIE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B70314D01
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Nov 2025 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762186971; cv=none; b=rktE912HqcsdqVzrAOSjd4EQr3cggUyj4QxkZLMTjKp3c03EsnXVJsDnvcndK6GsO7pRICpvKjr2xO7lyV+dXT9OQsMnyOyuU2ZFHnoTAHZzvLin/AtkgYqR2gssgRn/Jg0tKIVRh8RpgRazCpDsAleATo11qJhCbWaR0QAhZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762186971; c=relaxed/simple;
	bh=MAqh8a5N+ZsOAGEcWjRLDNWJ4Cf1BpHeOMi77RPjhlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XE6g4a8fZ+rlCU3uU50p6igwnP2jidxaGa3B2GQWaH25GrKIvkmg8b9o3ZluSvWIY1LXYRxi5M8ad+VKlst/sWXMUfnCVi+QXI6C1+4lOA0pbrc5Nj5hO3GzTP8UFpVxJ8ZeyvC+OIUWnMYaiMTh/e2xrFI0UEeaOVyRPMJw1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJm1QDIE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so4415049b3a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Nov 2025 08:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762186969; x=1762791769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=cJm1QDIEvy6vQsHD2LLXTwJJJf4Mpe4/+xOPU31gpiXO/voaC5GoTJdUP49sLohvUe
         VIT0lc7p9a59kWz3sRDeNRIp71R+3k+NRLHa0uOyqjEfnoLkSwpEHgF3+xHG0rIW1z0d
         tFnbE6XgB1P2J/c1jChgyGO80pQHfClydnR3caIx3ckCib4P0qgDptgqoieL3rWnI4tU
         YNGBeWXsxrFna+hB5hpNmNKR4ZoFxvPEWlEKPLX1TE3XYWiz1tuqhTRQ4wwi0EtxK9hG
         a3059MRX9Km7YEESIe1OlxhdYoslcqhX0Hatum6onHcJ4RyA6vH5YOLuqMkS3voyNH4k
         PBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762186969; x=1762791769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfeI4do2p8OwX1bs3r/PVpU23cvBEdcK3KBLEfo+aK8=;
        b=QEEB4OTDhZ1norfqUQUV+46vUNjjNw9p8fa4/7sYvMBjLCxVz+4V1PaILMALvHIcLN
         CkfqyDNsjI9X01rsV9OPvuhzSrSQFKayCpD9+P7Wv3tNK4oaV5h2XSAEEzzBHUvFVyky
         36LzCcX7Mq9lwewbFGpcP4cNqeK3HbnRx25tgxV/ckKcG7B5A2ZJOlmNpIH28xtGpL7a
         G5FFTnL1aOKz3mNN/cEDo5kf9vkXDaM6T+sHHTYvBSgaOJd64/Oq5faGKCMF7cUj/HLa
         XarlKV2ZIXNPMUAOmcMIboSEdY/uqniljTZb0YRIuja7A4qcLAvTeKGOs/1XUSeDyIR6
         ic2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX5US+5Hqgt/kX5nwbfO9UNPOpyBRvIXyiC9QythgbvHTERsTNCqZ99cMFpPD83JGnSsO7xkHO1Q9dueujy@vger.kernel.org
X-Gm-Message-State: AOJu0YzhTqArKedaTsuFuS9HKki7YG+1AEPmUWxVhh8fLfXMHig8ZOSV
	S+W7E+qyzn+uNn50YbVwL9vsJaRccFxzkIkqQGF4i7MbGdJXBULWI8Op
X-Gm-Gg: ASbGnctFcXq1YOQ8FieKQ+GnNL3n2DU6ha/ZKCOhrnnHBU6YQuD8MXtbRkgPOfebHOf
	xwCRG40dfKKMmwG8j/f2MYDspaOn2zHBASIKBSb4h3jSuYAliXCt4bx5uHN4qJnNcVqjbpnGEMR
	0h7VOC2OV9fj3Zv+G7Io/gfOfV7I5+PHavah2LpBPKMMgVYZX6kBG/FptlWORRRHlN7b3uL+tcr
	0MD0hMvF3hojsP+MpVAkdgi8UyRzJiTbomh2cPVG38ll2WZwcP7Hsb0oAMZYvbVG+uVvNIxCS/u
	snzOw0LB5pDup9Yt254DIXyr4aVEovaUpYUbQsdLBGL425gxsdmkrgi+5cFRUQx45eh2C0xI5/w
	mv9G6n/VexizrU+LUNqe9lqewsThjotF/qxOfbzJG2NL/BlNTTpIz1QsSwvAT4A9Ql5P7CVyTVG
	6WRsCrqW9LqZciA98jqLEi90+CVuxmy8TKeL6mmkcA96PWs/ChHbTJwlkVEffJMnpqEG3YMkYKg
	uNVBrQ2JuU=
X-Google-Smtp-Source: AGHT+IEQaEN/YRqaD9Q0fZ6GjLoywGPuwEKc41YzWo/EM8FatoGxq2+IaYk2SY8ba4sIfOPAOnQ3UA==
X-Received: by 2002:a17:902:ecd0:b0:295:9b3a:16b7 with SMTP id d9443c01a7336-2959b3a1914mr60038095ad.4.1762186969039;
        Mon, 03 Nov 2025 08:22:49 -0800 (PST)
Received: from ?IPV6:2409:8a00:79b4:1a90:5d7b:82d2:2626:164a? ([2409:8a00:79b4:1a90:5d7b:82d2:2626:164a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295743772e9sm73908245ad.66.2025.11.03.08.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 08:22:48 -0800 (PST)
Message-ID: <a89cb9af-784d-41a6-9f1e-dfa28d09be29@gmail.com>
Date: Tue, 4 Nov 2025 00:22:20 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fix missing sb_min_blocksize() return value checks in
 some filesystems
To: Christoph Hellwig <hch@infradead.org>
Cc: Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo
 <sj1557.seo@samsung.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 "Darrick J . Wong" <djwong@kernel.org>,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251103135024.35289-1-yangyongpeng.storage@gmail.com>
 <aQi4Q536D6VviQ-6@infradead.org>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <aQi4Q536D6VviQ-6@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/2025 10:12 PM, Christoph Hellwig wrote:
> On Mon, Nov 03, 2025 at 09:50:24PM +0800, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> When emulating an nvme device on qemu with both logical_block_size and
>> physical_block_size set to 8 KiB, but without format, a kernel panic
>> was triggered during the early boot stage while attempting to mount a
>> vfat filesystem.
> 
> Please split this into a patch per file system, with a proper commit
> log for each.
> 
>> Cc: <stable@vger.kernel.org> # v6.15
>> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
>> for sb_set_blocksize()")
> 
> That just adds back one error case in sb_set_blocksize.
> 
> The Fixes tag should be for the commit adding the call to
> sb_set_blocksize / sb_min_blocksize in each of the file systems.
> 

Thanks for the suggestion. I'll send v3 and split the changes into 
multiple patches.

Yongpeng,

