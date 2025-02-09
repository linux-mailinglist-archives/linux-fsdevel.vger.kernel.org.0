Return-Path: <linux-fsdevel+bounces-41318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D8A2DF12
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 17:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8113A5A15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 16:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C911533991;
	Sun,  9 Feb 2025 16:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="N3aIdHsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CD9250F8
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 16:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739117962; cv=none; b=sabB0aunLvI2gZqtSnzqxQmMXOBWBUfWAeMiR15YK0RQhPjzDZy9Yomsk1IVXKasKJ7mwukImPrxRUkm2BOhh2AFvBb8GfWib+c4/RWBaymvi/6QsEgDEp8F8jt8WWPv0uImWItWuKQg5Qnr1SsP/dEK8RZwjkI6kVyj2X59Y+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739117962; c=relaxed/simple;
	bh=QsRlFlNtuwsiwdyTUqZGZDEWdXSD+N5+y5+nyJtLAZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5fIXkcV+q0bDHgTCsri5VMOYKMbvxuwGjTVUi/8P542nxXB7YuccWpplqBiHgMSpbILVK3WbkBxqOwLmpU8iJevrOVjVZBDDOg9x5+WYZ4gcgxXWuQTjHVQww5NThz58wnKMMSMXvZ4LVnm4GxFoisXvd1o04pIWhkFyqSiopc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=N3aIdHsq; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-844ee166150so87644739f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 08:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1739117959; x=1739722759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gXQx3/dns57ed9Cxe6iLVKhzTeWO/F2Up09lnLJFods=;
        b=N3aIdHsqz0Q3JI1ccKicHgMRavDg/Zq4YlBaqVRHo5QrxODrokEe7DFohQeOANu9P9
         Oea0itdOUqHGW8qNUJNt7w1tZjKEZJ3U0/O8G58WAINBdMshBuBdlfHaXfVKBvpR8EMB
         0eMyQQCVMEsyRuqBthkHNOHsQhVg6/EIjO+RbhkorbjhYLhVKFabijYiG96BNkjSm1ip
         C8etpbWPtvjbxfr1WkzeJm/202MUjgEDEBeHIjbU5nVP+xSFeNuaZFY29SBfc4w1U7o+
         DCIDGBpjCcszRpnojwuiIl0nQWSObQSVLcpt4q35IMa6lVvCEIlBvsDg4LAVewcVixVX
         L/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739117959; x=1739722759;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gXQx3/dns57ed9Cxe6iLVKhzTeWO/F2Up09lnLJFods=;
        b=mDuB52lq4MeGEFiBWdSdCdXFZIu3Q4nwz9C4emGAuCxb8oN0MO4Un8Ucz5CzfbDwjp
         bOohQu5mPiiUa+A8qSfXHFbcKnh+QTxctt21jNoXsWswj4C2lEJVPAf8MnTnU0z/awxl
         A4I7me7kA5ZUylLzXgGLY02zQPxlhL3Y0vILtWPasqc6YTTVLphsRqZiyBW1svbnpExl
         fju6zkeN1PsvBrOKr/PFamZ2D9Eh9TEFsHwQc22UyeW8VJJvaI/o/uuPdC6WrLCdvenf
         Qu699cEWZU/IGb5Xk2yx/dtViMzIg2zgeD3iwi6uJoGKPJDg4cQkqyOi9vtaGzA55JoU
         62qg==
X-Gm-Message-State: AOJu0Yxf85H7lpcg91RQrTeTA5AF0LMmdBc2NOVOgqziChrOUmKhWJfI
	6rVriZFJ7W9n1onpfxHEXdnkoV5ltxjWQV2FBWW4bcf9IPNv6KgpS8o2PlYlS2g=
X-Gm-Gg: ASbGncs/+UpV6FrOG1orYkA1Yw5uXNRQiRCzwL9wjBcM3WkF9W29UTq31eW3W1HjCcL
	09bayNahPrH+vr2cmymHKgzoEeMCSF0MApXZ4FSLOsUPpszWxm/g78orKC6qA03UpWC24kjaJlB
	fU24/iKeVUQj/xxxROYVt63TGUF8LKri62mVWBP0QIjInSxRrtMmBqGqEkiOyzTSFbXsw0OahxL
	7WVGFjwrwlOz7N82r7ek5CIVVTywn9nKVq9qVV63nRdJUe+3BxT4t8fQUBPA9GvBc7xlMHk1J6l
	Z7u2CMsIkQcU
X-Google-Smtp-Source: AGHT+IEs5YC/UO3XWASQJkqV6mpEg/j8y98hig4oKW4DiUU6YXn0am1U+7oENSNQYqia/I5TuA93QA==
X-Received: by 2002:a05:6602:3e83:b0:844:e21a:e805 with SMTP id ca18e2360f4ac-854fd8f1dfamr938286639f.9.1739117959139;
        Sun, 09 Feb 2025 08:19:19 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ecd79bf6cesm1450831173.23.2025.02.09.08.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 08:19:18 -0800 (PST)
Message-ID: <a00b6a2f-29c9-4215-96ef-1fa32ffa85d6@kernel.dk>
Date: Sun, 9 Feb 2025 09:19:17 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] io_uring/epoll: add support for IORING_OP_EPOLL_WAIT
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
References: <20250207173639.884745-1-axboe@kernel.dk>
 <20250207173639.884745-8-axboe@kernel.dk>
 <48bb1b42-b196-4f17-aeee-7b7112fbb30c@gmail.com>
 <e1ccb512-fce6-4ea9-bcc5-f521d088605e@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <e1ccb512-fce6-4ea9-bcc5-f521d088605e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/8/25 5:24 PM, Pavel Begunkov wrote:
> On 2/8/25 23:27, Pavel Begunkov wrote:
> ...
>> But it might be better to just poll the epoll fd, reuse all the
>> io_uring polling machinery, and implement IO_URING_F_MULTISHOT for
>> the epoll opcode.
>>
>> epoll_issue(issue_flags) {
>>      if (!(flags & IO_URING_F_MULTISHOT))
>>          return -EAGAIN;
>>
>>      res = epoll_check_events();
>>      post_cqe(res);
>>      etc.
>> }
>>
>> I think that would make this patch quite trivial, including
>> the multishot mode.
> 
> Something like this instead of the last patch. Completely untested,
> the eventpoll.c hunk is dirty might be incorrect, need to pass the
> right mask for polling, and all that. At least it looks simpler,
> and probably doesn't need half of the prep patches.

I like that idea! I'll roll with it and get it finalized and then do
some testing.

-- 
Jens Axboe

