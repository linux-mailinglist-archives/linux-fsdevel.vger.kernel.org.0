Return-Path: <linux-fsdevel+bounces-40455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A95A23763
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 23:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE69167321
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF71F0E4E;
	Thu, 30 Jan 2025 22:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="nFvqrBsQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB112C499
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738277491; cv=none; b=VnEtG09bg0zxIpbg31Jhz5Pvuwzw+vI6kuirM1wOSGhFP1eIEUEP/CBG7uhauSHE690KjiIqrYsUNWH5Auha6ZwkhQraYSqAz/Hst1meeBL9+M1BKSlmEjV7AEpMUfbtOl2KtL6Vn2DMrQo2huuf1nP5n2W32IBkUZYRRw0XzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738277491; c=relaxed/simple;
	bh=ti7w6CRHkrqd0IDlVhqC4JHX2yOFuIIoAj5p0M7BSa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thIOL0CFd2pSHXHztvpZCJ4ZcWQhRWaLhhump8j+oP/UHOOr4u7o5PjCi3YWEntOYF7KUcLgW6vtm7d1reWCG76s7YU8d3KIkNF2w3bjDDMna5NRo+L91dB2nRKB58aTuFWzkfvejZNLH+ecxzdokW37XTc0qKFxLMjjiLQ60kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=nFvqrBsQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so23810635ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 14:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738277489; x=1738882289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YsRtCyp+q48o9GAx0yRVfhg4A0nZnuPXs9zRLa3TOGk=;
        b=nFvqrBsQ6b3VCuF99jXtfXlu/oYOkNOjJB2WsoJWCgajaMM4CWrzaK1Ax04qCXtvqR
         hkGWDxkgFweIsJMRAWKkSWiTRAFYoKP0g9NrjDCRBRzRlHwtNoJvdK5nV2Wbk/IrwCQ9
         uLlAysuuk01cuaIBe0g3z2T3tFOXUgw5JK4WL4kib31v9IVcySpabDFH/bvcEj2J5Ibw
         3m189nIzuc/qy+yF/3QygH6vAJBrfx3WNBkFloC5VKyV1gxoZdzc4HcTRR3V1DVBCHh8
         J6l7YH75/1m9rFTq8LxIr5kVBSfjmzGt8bhBSvnjG85noacS43Bvx5HGMkLEs/VbaqvZ
         iFOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738277489; x=1738882289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YsRtCyp+q48o9GAx0yRVfhg4A0nZnuPXs9zRLa3TOGk=;
        b=JZ4nUAKR4umB1+/RV/qGrzODzyhTy9DxoTVj/GWdvZyZAL6rHhRrLvSwDWJ+oPDUsS
         rEF1X/35tN05t9pdoGOc74ugH5oxdVk31Mo28Ho5I9wpI1dwsubm6pbpJm3bdbuIZRta
         vrLQCC33Z5gjrqwW6O1YnFs6gf5FJ0jCxKTmLegQzzWxEb5fZY9tBAiIJTv6Z/ELLplX
         X1c6X3tRdawcztV0RUMzi2aBXT5cPecUDBEdNu8FEtLo4SFgNJJOzPRxWJ1ge707jkzE
         5+Xz/xu0LjZaebAEkcgnptGwxUdAkTYmU3YAIuTR3kHE5P6/iU0GhUXKzeyk4o3lJ2H4
         MrKw==
X-Gm-Message-State: AOJu0YzZqli3a+5cDaaCNvLAZtcJ2QaGqmWPF9v33gHkus6L+HKmgmc6
	4iGoGwrtV3rJzDZROd4NWICD7x++5pBIY2+ClT7Qm/LH7g9BLgCL9eeMf4HYv74=
X-Gm-Gg: ASbGnct0Cde6DaPOLVPAyYOqJQ14gSnsBKh1ae1cK52sjqnrQUpmaYKRrb7SGhxu8TZ
	9HYkbiAyT7EGdUHS8V7EOmJG7crrcaRN9HpjUrGp6ARANajCmHzw3I1dt2zod7fhijQn+Fba6GQ
	dl4DZlU6r5UY/yNCEqpsRupLZeB8TGSmBAgtfvouYVfK5YdUzw5kYYihvNijrdrCzdWZg7xXg17
	GdxWrrMr1HFTrT/UfqO6KAxaEIz03F6UUYO/SyMstpdImAWxpRLGSyEEFmD/Q/j6BuU1rCbqq1z
	sEBntMn3Fit8vQw1jCFrqvgAoxBMP2S1Hl3UyvlgfM+vSrmPSiTwhA==
X-Google-Smtp-Source: AGHT+IGdEVgyOULsHoR+MeADJSq8M1VpnWoiEtZNPtZ9iuQk0dasC0oI9axrYbgXXSeLrV1Bl1HgZg==
X-Received: by 2002:a17:902:d48e:b0:21a:5501:938 with SMTP id d9443c01a7336-21dd7e38e38mr135478525ad.52.1738277489389;
        Thu, 30 Jan 2025 14:51:29 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::7:ba76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de31f79fdsm18753605ad.64.2025.01.30.14.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 14:51:29 -0800 (PST)
Message-ID: <6ff53b63-d7b1-4072-b8c6-181e885f6d6c@davidwei.uk>
Date: Thu, 30 Jan 2025 14:51:27 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Content-Language: en-GB
To: Bernd Schubert <bschubert@ddn.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>
References: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
 <a3741a38-967c-44ad-9e73-64628048027e@ddn.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <a3741a38-967c-44ad-9e73-64628048027e@ddn.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-01-30 14:05, Bernd Schubert wrote:
> Hi David,
> 
> I would love to participate in this discussion and the page
> migration/tmp-page discussions, but I don't think I can make to to LSF/MM.

Thanks Bernd! Looking forward to discussing this with you.

> 
> On 1/30/25 22:28, David Wei wrote:
>> Hi folks, I want to propose a discussion on adding zero copy to FUSE
>> io_uring in the kernel. The source is some userspace buffer or device
>> memory e.g. GPU VRAM. The destination is FUSE server in userspace, which
>> will then either forward it over the network or to an underlying
>> FS/block device. The FUSE server may want to read the data.
>>
>> My goal is to eliminate copies in this entire data path, including the
>> initial hop between the userspace client and the kernel. I know Ming and
>> Keith are working on adding ublk zero copy but it does not cover this
>> initial hop and it does not allow the ublk/FUSE server to read the data.
>>
>> My idea is to use shared memory or dma-buf, i.e. the source data is
>> encapsulated in an mmap()able fd. The client and FUSE server exchange
>> this fd through a back channel with no kernel involvement. The FUSE
>> server maps the fd into its address space and registers the fd with
>> io_uring via the io_uring_register() infra. When the client does e.g. a
>> DIO write, the pages are pinned and forwarded to FUSE kernel, which does
>> a lookup and understands that the pages belong to the fd that was
>> registered from the FUSE server. Then io_uring tells the FUSE server
>> that the data is in the fd it registered, so there is no need to copy
>> anything at all.
> 
> For specific applications that know the protocol that should.
> 
>>
>> I would like to discuss this and get feedback from the community. My top
>> question is why do this in the kernel at all? It is entirely possible to
>> bypass the kernel entirely by having the client and FUSE server exchange
>> the fd and then do the I/O purely through IPC.
> 
> Because we leave posix and it is rather fuse specific then.

Yeah, good point. Another line of thought is in ease of use from the
client's perspective. Yes, they have to do a back channel IPC with the
FUSE server to do the setup. Though it could be as simple as using one
of the many ways of passing and installing fds between two processes,
e.g. io_uring or SCM_RIGHTS.

But the advantage is that DIO write() is the same as before. The kernel
takes over from that point onwards, all via standard kernel concepts.
Doing it _purely_ in userspace would need completely custom code.

I think this is a useful addition to the kernel and FUSE, that someone
else can make use of without needing to write their own code. If there
is a +1 voice at the conference, that would be a great result and gives
me the confidence to go and build it.

> 
> 
> Thanks,
> Bernd
> 
> 

