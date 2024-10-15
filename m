Return-Path: <linux-fsdevel+bounces-31932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2590B99DD0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 05:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85BACB21EED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD0172BCC;
	Tue, 15 Oct 2024 03:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJ/lnWLJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E930F1714B5;
	Tue, 15 Oct 2024 03:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728964505; cv=none; b=rhnQKwQfrDG3IS5Sk4iPRcnrZfF7l5T1AqtFvwW0hm4XUe4TFUyOc3+lxvjfyMJFisngfbDg1alG8R0BqEnSVAykZCZmKDMTDDpZRqLGAIFUiseY5oGpRMJw7cfAaD94xMpMzUr5mH2HrcsseDZwbcVfqi3XyIyBbj2Td0BwK4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728964505; c=relaxed/simple;
	bh=KI/Qz7cxw65EHK5Bp+NdZUO/jaY8mHil+i/4r1vDHd0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=i4BkefY+uYuvADZNy+/rdP+9gitkrSaxh6zNMqmoj5Ag6A+KqcDJqvjAa3SPxEUIgn7anZZmzl3ERPOf0LkSSJnYTX64lb51LdqCcTpHDmbw1wfcjbGCJMrEEqXPSkWi5tXdFg5/o9et2RK3uPGxtPCB7C8LgU8e+e69RBBhVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJ/lnWLJ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2ed2230d8so2657319a91.0;
        Mon, 14 Oct 2024 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728964503; x=1729569303; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EwhfU04qa08VdpSL0tNj51VKQuJPyj0qdelSnsnP5Es=;
        b=SJ/lnWLJrjV5ZO312Efr6RFzVaSSpxRO7r4Uq8Cxq6kTT7fmRkNcknTC+dGp6ZBBCt
         ecMLGnn2U0rCjfALBNaruPxNRIXFlze6GIEQf+6F5xv86c2/xoWJRUbpMUTEyH0QbUJL
         oLemP/H66QwbVJp8q/4nLqC12w5idDK9GaaalNo8mZz1PZVKsyzhqyYQQ/P606E9klBN
         uvopdt5xPU15utlHNWjNRHtRXek2X4nYodOdu2RI+pBV2ePPnOPBIDDLPssbA0KoDdt3
         cCRbBZi2JuwQxppeIGTl3eryQY6fHnq3Gf684gRJVnOly7FskE6jUyszc7dnec/bWlkP
         75zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728964503; x=1729569303;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EwhfU04qa08VdpSL0tNj51VKQuJPyj0qdelSnsnP5Es=;
        b=UcLqSTY7c/n6Ev0VCqpLJosQI7iW6Nw/1mmYLItM/FsoTGNFH17XpLwiZWalsCf+1A
         cYTi2GBgg67N5qixG+8zMyhaJuS1besl+rRL/X8zo/MWZxImSsuRmaGt9LzEHSl0Sfn7
         pb0x0iGHUvC8c19G34UximTQhwGG6TcqUyr5nchobH64xpUmtAU/nkPaS4ITUl3Uyopi
         HG1tqT5E6s3LF2H7fSBzNKJyVZOiSGqBpTt+ktvFjVOnHNwtRgqj/nmDa5MtljoIrQBU
         VGvEuO6T18oI+jomSAuoc8aO7k4Oyfg0eZ0hpLx1sYkzXz7oqgVjF0tPn6UGui3S3ghD
         d1sA==
X-Forwarded-Encrypted: i=1; AJvYcCVjhMV70uvNglqxd8hGC2WCNEuCprkiyDM+xV7+Dgx8I+RzTDq8AszhDo5cdUazA0rLPH1gV0wcfY2b7et9@vger.kernel.org
X-Gm-Message-State: AOJu0YyIt3Y1RFUYaVQleLSxTbHOjN0/6WWSvPW6QMmu7Gx3O4txNDFd
	z658NYgTX8PeiZnTXbJvxkPNZ/TagcBBS65+N+Q5tEm/G9RJNAH2
X-Google-Smtp-Source: AGHT+IE5uz8bQGnSjGv7Zq4zoHqC75C9XdFXBNAqfmc2Qvu6+tYDj3jsq21cphHruML1ji5dqk6CJg==
X-Received: by 2002:a17:90b:1b42:b0:2e2:e91b:f0d3 with SMTP id 98e67ed59e1d1-2e315431d7amr12707892a91.29.1728964502982;
        Mon, 14 Oct 2024 20:55:02 -0700 (PDT)
Received: from dw-tp ([171.76.80.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e392f5f6f4sm404415a91.43.2024.10.14.20.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 20:55:02 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 05/12] iomap: Introduce IOMAP_ENCODED
In-Reply-To: <ZwehmQt52_iSMLeL@infradead.org>
Date: Tue, 15 Oct 2024 09:13:32 +0530
Message-ID: <878quqyqsb.fsf@gmail.com>
References: <cover.1728071257.git.rgoldwyn@suse.com> <d886ab58b1754342797d84b1fa06fea98b6363f8.1728071257.git.rgoldwyn@suse.com> <ZwT_-7RGl6ygY6dz@infradead.org> <ZwehmQt52_iSMLeL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Oct 08, 2024 at 02:48:43AM -0700, Christoph Hellwig wrote:
>> In general I'm not a huge fan of the encoded magic here, but I'll
>> need to take a closer look at the caller if I can come up with
>> something better.
>
> I looked a bit more at the code.  I'm not entirely sure I fully
> understand it yet, but:
>
> I think most of the read side special casing would be handled by
> always submitting the bio at the end of an iomap.  Ritesh was
> looking into that for supporting ext2-like file systems that
> read indirect block ondemand, but I think it actually is fundamentally
> the right thing to do anyway.

yes, it was... 
    This patch optimizes the data access patterns for filesystems with
    indirect block mapping by implementing BH_Boundary handling within
    iomap.

    Currently the bios for reads within iomap are only submitted at
    2 places -
    1. If we cannot merge the new req. with previous bio, only then we
    submit the previous bio.
    2. Submit the bio at the end of the entire read processing.

    This means for filesystems with indirect block mapping, we call into
    ->iomap_begin() again w/o submitting the previous bios. That causes
    unoptimized data access patterns for blocks which are of BH_Boundary type.

Here is the change which describes this [1]. The implementation part
needed to be change to reduce the complexity. Willy gave a better
implementation alternative here [2].  

[1]: https://lore.kernel.org/all/4e2752e99f55469c4eb5f2fe83e816d529110192.1714046808.git.ritesh.list@gmail.com/
[2]: https://lore.kernel.org/all/Zivu0gzb4aiazSNu@casper.infradead.org/

Sorry once I am done with the other priority work on my plate - I can
resume this work. Meanwhile I would be happy to help if someone would
like to work on this.

-ritesh

