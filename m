Return-Path: <linux-fsdevel+bounces-11520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C3D8543F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C79D1F2455B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44FB8125B3;
	Wed, 14 Feb 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mUFE9aVm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9F0125A2
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898756; cv=none; b=YXBN1BMuvakUugcVjStAvr/zJw0xBE8tIgJ+Qoq9DVKjUVSkz0cy3oZCN47Vaal7XfZ5pK/HF2KGk2ykfPXj3F5V+CElGkwrLOvrfUG+nW4uNohUvB2L0Fa1h9j0eJRYDQcy1UmIECtKYXJnffAUiq7qjO6CrGFuOPNvpLYNguc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898756; c=relaxed/simple;
	bh=ElnAr9DHEP7nYunCx25tX++1V3OQvM3ll/Xorv6IM5s=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TI6/ojwSaR1LCF+gF27LRHOVuCZ3TGxuJkzS+DKHTrfbBYQtbGTZz65GW0gq2krp6kghjXaOhd1uLZ99b9d06gVeHhmPrnZ0/M9f82d+ljllQWbofmbWSWw97+emywhkN016VqekWcV8phkvDt5DmQPeFSZyOOegVmM43BMhUU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mUFE9aVm; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6078f10ea81so12469507b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Feb 2024 00:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707898753; x=1708503553; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EowGhpcuh0EyoMt3zHeclmlBTkeX1MY7fmz7YockgbE=;
        b=mUFE9aVmiTGr19qaqw7xBtXxYy3pU/EvmVooXIVT7HTT7OyhsRxhi1vmyWhm19/4+X
         g15YFxhMzhKamoVQkV18GULHnJroj6nsp0jybtWJmghw1RG9ZNUfNmxwYhMdZqpvolpG
         ph6UDOLSbPIKWxLQ46tPEb151/47hE3GtO7b4G8fpX7pnok/0eKacOMBvVRES85ljd91
         yFNgFawScHMMb6RS+WvAgIUmEOauZbWbXV1I3cFVrJxYr6cKZS00epS/4Q3V5d1tZ0za
         2UyKZN7FXRKMHEg9B6Tn4q3U1vXdOCztujJKi4nfwbzRK+W1Yl5K0yKVYr+dFO9mwVTD
         dyaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707898753; x=1708503553;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EowGhpcuh0EyoMt3zHeclmlBTkeX1MY7fmz7YockgbE=;
        b=JkjXJKgnMKZIMjWILjjX+slzYdhGV/5j6cM7iVkz1lSKbXaiJ0T9qyFMVU6K32oZCY
         +BTndKplFqH6uasxwVurRwRyZCJgg+ezkPtpXotXWUuyTxeN44e746kSdJ7sAkwIFIc0
         YJWwLerPrPITRauZ0+jopQmXg8NznkvqSMl5ZjMz/q5Qrom0L+Zwa/URSAenNGQbV8Wk
         pKxwVc6oo2cRbyfDlPC3CXsA9zaFXbO9BfiSIs1NNKX8Ofe703aca/xw20PHqDNpyw6x
         15j92bDwaxJABPmivbGFweNJTJtHvqblr3bMDf0JUI8sxxNe3hXPfSOxDbn/2jbGEG5B
         kUog==
X-Forwarded-Encrypted: i=1; AJvYcCW0v4w/lJlamkstbf87toikhyc1wdyLgcgPWeXZv8QysxEfw5UEguz5oiILZRZb2LGMin+zRMszdQpSQ7a5WToVxUbfj/fgFlMddk816w==
X-Gm-Message-State: AOJu0Yz4KWFz3PetYQjuFwqt1am7cQKbrggc7P07mQd6yq8ewZbceJvS
	AkWCZHrwHqJfNImyJBKuej0iNteFNNiQBlFtzIFmsUGn71MQREP+MegqtAdbuA==
X-Google-Smtp-Source: AGHT+IHqYoqEypNi9wnArveOMraBDtVuUqYUixO2E5ej3DdGO9Z4R9k3lqi2DM4dxUGTJrGaTQmDkg==
X-Received: by 2002:a81:5d07:0:b0:607:9102:c1b0 with SMTP id r7-20020a815d07000000b006079102c1b0mr1685222ywb.43.1707898753073;
        Wed, 14 Feb 2024 00:19:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWeKf+t/wtObAJ5yzuxLLk1uV2DgKWUHZl+UoG4E9deVoH5YJDDYNbHnSlkrA36KlPWiWRvi2dInd12LmZLWVRIIa5kbVzaVS4MCwF/W0MKAU5Od5EkZ6V6J5veO5qdQibunqsRxCk6QqQZYOiV7NW/fG2GCSd/2lRuCrErD2xRoHllPoAVDDPVPVqfkeF6ziT/qE9j9q3Bg8pz35x3Fg0oV0NDkqoRewKZ
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id ee4-20020a05690c288400b0060778320f39sm942764ywb.1.2024.02.14.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:19:12 -0800 (PST)
Date: Wed, 14 Feb 2024 00:18:46 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Christoph Hellwig <hch@lst.de>
cc: Chandan Babu R <chandanbabu@kernel.org>, linux-fsdevel@vger.kernel.org, 
    linux-xfs@vger.kernel.org, Hugh Dickins <hughd@google.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: shmem patches headsup: Re: [ANNOUNCE] xfs-linux: for-next updated
 to 9ee85f235efe
In-Reply-To: <20240214080305.GA10568@lst.de>
Message-ID: <0e8d50e9-4254-7acc-e9b4-9b6ad63a25da@google.com>
References: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64> <20240214080305.GA10568@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 14 Feb 2024, Christoph Hellwig wrote:
> On Wed, Feb 14, 2024 at 12:18:41PM +0530, Chandan Babu R wrote:
> > The for-next branch of the xfs-linux repository at:
> > 
> > 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> > 
> > has just been updated.
> 
> <snip>
> 
> > Christoph Hellwig (17):
> >       [f23e079e024c] mm: move mapping_set_update out of <linux/swap.h>
> >       [604ee858a8c8] shmem: move shmem_mapping out of line
> >       [8481cd645af6] shmem: set a_ops earlier in shmem_symlink
> >       [9b4ec2cf0154] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
> >       [36e3263c623a] shmem: export shmem_get_folio
> >       [74f6fd19195a] shmem: export shmem_kernel_file_setup
> >       [eb84b86441e3] shmem: document how to "persist" data when using shmem_*file_setup
> 
> I would have prefer an ACK or even a shared branch in the MM tree
> for these.  But as it's been impossible to get any feedback from
> the shmem and mm maintainer maybe this is the right thing to do.
> 
> Andrew, Hugh: can you commet if this is ok?

Each day I hope to reach looking at it.  I sincerely believed that
I would get to it yesterday, but no.  Later on today?  We shall see.

Hugh

