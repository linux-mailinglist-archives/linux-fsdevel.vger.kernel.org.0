Return-Path: <linux-fsdevel+bounces-40441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F8A236AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 22:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE95163E82
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE35319DF60;
	Thu, 30 Jan 2025 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Z4SE22L0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B0F1EE7C6
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738272540; cv=none; b=cDQY2U+vnvj6oVpAek3hD76UI4Gy64LjYc2PA8wwVQFRiXjuZviPtO5wB0mhWZWOc6fzJ/mujS5wWQc4RztEF2z38lP94BwVZqtDY7Py44J+pGo7o7PUcrtP2MMzmVd+IHlPVWQII3RfCB0Z8UERmmzD0WVFpjkFR0QxBvHsp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738272540; c=relaxed/simple;
	bh=UWDg6CCmzLtCB1hcWaV07L06mjDBLFBIWsBB0+LOFn8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=n+KhA7TvMuVoCrk1iqMysAs9OOigCQwDbvJ0LHv6MebwUt1+1ZTZctQbHml8FEOT33khyKPqR7Nh68B55eEhc2hqucoGPTrS5+x/tRvAs9MkjwBNLL0e2N6k0hhFkx1tjbvSlP/g34sdb/Xb+tGJfnaykZmYI0oJYKGsRpt0uxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Z4SE22L0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21bc1512a63so24688755ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jan 2025 13:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1738272538; x=1738877338; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWDg6CCmzLtCB1hcWaV07L06mjDBLFBIWsBB0+LOFn8=;
        b=Z4SE22L0RJZvotCutcPI7VOBbWGaO6WZcHbMPOsUld0CuZMlER1MfDvmO8vC4Vlkli
         STomQF9efM9aydS3fevBykOTNT51kiB5Ck54/WnpFKu1r3rUfArpDNM6JAFNFjDgGTFs
         evUJPwH4y3XZarPtVCFfxm1J6XpLscs/EEUEaVzJP0GfWxTPsKWOC2W0+ij419X9Ie0G
         WsSoSqWBBwUqF4Md0jGBHuNQU8m9weo5QzqXiA6vCqArUIbXXEk3vw+F2JHcvF6c7IPR
         mkpjV3Yb9lV8MBUr5Bv1AYnXcZtMHg6D5lJT6aRVtKxRgYwgawemHHOipyktS8gGEAwJ
         6aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738272538; x=1738877338;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UWDg6CCmzLtCB1hcWaV07L06mjDBLFBIWsBB0+LOFn8=;
        b=Dl/LhG+Od6FlzSYA5keqOCMcYcPgpB+BAXP1ExiHp1WxL/NctDEevMxwuSa/jjanoz
         cuE11UnyAwOEm3JN/4AtwLobHSYk522UmKS/BE/7FEOBvVpl86UPnsmQl2Ji7bJx77ne
         zkB9kNgCGwFEYvzC8cARmB+6p8jfIdVBB2qIl+9mFUylCaFLF0ZIQJuG10/VEQWfmiUc
         RE4MHnRGWnGWruO528nhgArT4xU0aDHAsD3vCYrk8onTnMzSXhldV7aO6ambj27hS4we
         jo9DICtPOczdIxfOU1GvLc2ldIbZNBXO29oHda7cxCKE/gcINwIgJyMWjuaV7IeBsh7m
         XJKQ==
X-Gm-Message-State: AOJu0Yww/g1nLW2e8vQeOMMhNC3xBqyslVCoxAJL5fU07rcqqSgCn+O3
	g9f5ZM+BOumbS2LCdQbT1HzriZ2gOR+bT+/Obw4UZ+RToc6cj6Bl4U5pNfc4zGA=
X-Gm-Gg: ASbGncvWukulARuF+ITk2txXPaAXJdrUzsZvNckMY1F+CZAO+4OXAufEVHlaNWLX0qk
	q5qfG8GeGTukNJwcuElmGk5I22xu3BUN7jejDJC63ovG+Mb6ft7gIRaHtpFya5rhHswz4q3pejp
	r3nBngrQFK7hGWfowmbpAXdAMcb3x2touUSSm66HS0KbDCqvsfxvK+lHqdGlYAvCHlCy3NyyOAB
	B22JS6KGeFZ78Ktd2nwYymgKHZUkN+7Tz1FwwlVr8cfZY6C+r1oBG67+8TrK5GG9F9MKFja6zvF
	BKYB342uuTDWVoMpFNMHWMxsmXQnbgK+SWIxm0qC6qbCKBSFQ4BgiiKMw+A=
X-Google-Smtp-Source: AGHT+IFjBbTaUJWfqLNF7bEQ1rciYemN0V7YWHnjgLKPHzY+UwDe2+h32D/Go/IaX8uSs4pFJUMcyg==
X-Received: by 2002:a17:902:da85:b0:215:a18f:88a8 with SMTP id d9443c01a7336-21dd7df9041mr120961155ad.51.1738272537897;
        Thu, 30 Jan 2025 13:28:57 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::7:ba76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de3303a8fsm18476935ad.197.2025.01.30.13.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 13:28:57 -0800 (PST)
Message-ID: <dc3a5c7d-b254-48ea-9749-2c464bfd3931@davidwei.uk>
Date: Thu, 30 Jan 2025 13:28:55 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, Bernd Schubert <bschubert@ddn.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
 Joanne Koong <joannelkoong@gmail.com>
Subject: [LSF/MM/BPF TOPIC] FUSE io_uring zero copy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi folks, I want to propose a discussion on adding zero copy to FUSE
io_uring in the kernel. The source is some userspace buffer or device
memory e.g. GPU VRAM. The destination is FUSE server in userspace, which
will then either forward it over the network or to an underlying
FS/block device. The FUSE server may want to read the data.

My goal is to eliminate copies in this entire data path, including the
initial hop between the userspace client and the kernel. I know Ming and
Keith are working on adding ublk zero copy but it does not cover this
initial hop and it does not allow the ublk/FUSE server to read the data.

My idea is to use shared memory or dma-buf, i.e. the source data is
encapsulated in an mmap()able fd. The client and FUSE server exchange
this fd through a back channel with no kernel involvement. The FUSE
server maps the fd into its address space and registers the fd with
io_uring via the io_uring_register() infra. When the client does e.g. a
DIO write, the pages are pinned and forwarded to FUSE kernel, which does
a lookup and understands that the pages belong to the fd that was
registered from the FUSE server. Then io_uring tells the FUSE server
that the data is in the fd it registered, so there is no need to copy
anything at all.

I would like to discuss this and get feedback from the community. My top
question is why do this in the kernel at all? It is entirely possible to
bypass the kernel entirely by having the client and FUSE server exchange
the fd and then do the I/O purely through IPC.

David

