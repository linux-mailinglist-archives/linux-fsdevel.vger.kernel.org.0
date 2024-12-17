Return-Path: <linux-fsdevel+bounces-37647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CEE9F508F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 17:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4679316C0A9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2024 16:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11031FC7C9;
	Tue, 17 Dec 2024 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gavZpxsf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B230A1FCCE0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 15:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451133; cv=none; b=cU/9zx0UCbA0x90XMDCVtJzVcNp2Ke1xv/TEhBThqnHr9DGIf4ihLvas4+nExRcr0orvS/jHeWoSsIiLYzvTmHAWcO8JV9lacfDid68RbTVFYeb0JWpjKSMZjfCl0fXjKnqUV+vizH2WbKYeVPyawemVHTXgrPUS31Ia2o8w2mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451133; c=relaxed/simple;
	bh=gsA5pAyjtX0qVT2WbTkVDtu22GuA7Mebo18DhBH1U0Q=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GKc6v9LBw5elrNT6Q5TOYf73p+pzciem+8swgKi3cXXaJmimxqWK515CLIqfTdGkW3h89zz69L6f3Qtu8yYUpgX6xahv2FC9wd84jKuPVvu36DQjYPLT9B7LtMyNhzxt4EmKQX8tiZshBrJeYZcG6sqRH4CWi5VVMXZzCPqzj5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gavZpxsf; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a7d7c1b190so18915595ab.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2024 07:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734451131; x=1735055931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZJT06ty20H6WtPaauact9KbtRVZiQjgmvMtjzhq0hVc=;
        b=gavZpxsfNI0TJlgmt13LrvQVS+6Iu7bvdt2GB/FyO9IJqlKGzQU1kSGX+9JN8EH2DX
         a5MseuzzeXVRZA7Uvi7iXDjw7/5iuJ8axH5VyYwaWizMo/wTwrByMfBLDKEr4L8yS9i7
         1FL07joLEHAIRy0MbBF0ArTTd6tGxzbskNQgxBsTo8qmiZI21pV7WcB4pWESLC1eXHJc
         uHncGniVdlGhlot8ps4EEm3tILCrYzrJvmNHf68pX2RjVzr/7iZw+mKlXKOSCKWhy+Ha
         pGu6/O/rW5zvV/7W+fCGdI+Q8alIkekjgCxuoEpPscCPFCWDgcxUrTa+noNmAojlcI/g
         5/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451131; x=1735055931;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJT06ty20H6WtPaauact9KbtRVZiQjgmvMtjzhq0hVc=;
        b=por8esYZtXAZ0gmSAycTp8/c5SLfYZAwjebOjwNBuj5vLtKlh+S+/tCT3ky8fL79XI
         K0sD8PahxrlXzJW41XENlZ9NiJpJ3aYWSq8TupjhrW22KJr6N4ix+YcT8+ToNsGq7raR
         7sdsFcEYLeLBZ2gcKR7xnNZUyGCyIGxMF61wqbX3A5SX1nlteGNnruHaVFokaESh+TLA
         qtVtaGL+91Kz95ceOGnj5q+pAOV+7NJz4KxqQVTRQ+5WqpzdiaRAY7DmJLgzXJncMaIg
         KvaemiRQD1Z4Ql8/YIl+wA2ftwzJP9JYI+odWc6YRl1bj6FRsBRMEF9gyhs0UY3x2QSl
         vkxA==
X-Forwarded-Encrypted: i=1; AJvYcCVVQukryMATP+9X1TfWMq7scHbEBxmCB1TiznWth63uZgmY5HOeL26848NdHjC2i+3qei62e0iqp/dqB+Lm@vger.kernel.org
X-Gm-Message-State: AOJu0YwU7V4cjTw9Pw6639SJdMxAJfWx17zjjzBfizciJ+W0kTBXmylV
	9WZ+j5JoKdb/fODYGkeL2Wr0JFzQ8GyFlGfJjbjt8IQOjslQMc4G/jzxO/aB8D4=
X-Gm-Gg: ASbGncvrWJHd4Pvzk4gnIWZqa2HXiGov/9O0NeottNGOEkFCdodRR9AlXS4X5BJTYsF
	9d7rsKfus8x82+OAA6gbBWcnnLgj1KHPmXr3/7Jf+lLmWhF23ixVgnCWbBL50DkNm7vM3ANKqj3
	ft3Xj5bJFACx2bM+FuNW+qvC28HNcbsQHHOFfkvAINrKdZZv/mth9NvJ19Nxu68Fgq9YW8ZUq2D
	5dEvYW/f9NRhIfJyV6RL/eIUJKB8Wy3Y2P8uFvE/8tgequrUPGa
X-Google-Smtp-Source: AGHT+IE65wyIeAPpjgOmu8zfqSd7Oth34NZ1pDfThXWwJjWL1Am00bD9KAdAU8o5NaJjN1gi6luqAQ==
X-Received: by 2002:a05:6e02:1d83:b0:3a7:1dcb:d44b with SMTP id e9e14a558f8ab-3aff60208c9mr140556935ab.11.1734451130910;
        Tue, 17 Dec 2024 07:58:50 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e036866fsm1751445173.22.2024.12.17.07.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 07:58:50 -0800 (PST)
Message-ID: <9c5149dd-c901-470e-8696-ae84e0bba975@kernel.dk>
Date: Tue, 17 Dec 2024 08:58:49 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v7 0/11] Uncached buffered IO
From: Jens Axboe <axboe@kernel.dk>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241213155557.105419-1-axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20241213155557.105419-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

I'd like to move this forward for 6.14, but getting crickets around
here.

-- 
Jens Axboe

