Return-Path: <linux-fsdevel+bounces-13138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A06C486BB5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 23:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30EECB27C54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 22:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730537441C;
	Wed, 28 Feb 2024 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RVg2hVA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8AE72924
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161042; cv=none; b=sibdaRZJKo3bpOynCG5OMGmNa3WI4mp61IUjWPAnTS0vBfggqVlHwyytxS3od4YEzJG4wbA6rMb43GU0HM0AOA4OM5d6Tr1AKCYsDYgsMYgxkndGaTEFENnBiS7Wa8llQuUepdyBViJkzQMplKarSiJk5DWKLjYJI2VgTR0l9dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161042; c=relaxed/simple;
	bh=rFdeaF8OvHp8ycIMfjI32IqX3BMfkKmkCnOldjcHl/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhYn4EYKx/mHUtUPCh0a2HWLK/mWal4Lg9oftYR8GC+JnUkeZ2dhbr/KCBMExgQXa8MOK1aFftmhT4+VEuhg1SEFPpv3Vajwe+ekL7OtfxlsqJNZakMXA1W3UgOph1Rxdf2lUJOs0FlvN/s8rF50KmTSualQHhACQR1nBHGY1aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RVg2hVA1; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3f4464c48dso39044366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709161039; x=1709765839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=RVg2hVA1htW9QrV231XmRu8rVE9dxV51l51q/PZmKI+VP0e7zdBrJXCL0nGQqa9K9C
         09+83yEVgQjs1xoJ9udWq6U/MWN7IG479Bsb37f36UhtGM52IpxZf9N5YyuA9SDdJAXd
         Nmd/L3ZsB9AoxeA3ynprcqaMgKBNcmkKqhWSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161039; x=1709765839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XmDUVGJ7uYNuJQyRX/NAFGYz0phL9n1ekfsCjXQN9T0=;
        b=Pz5C6Vv8qt4B2pK+yha3LHfNlAB8au+xsn+G2o11ZhRiuwESdkQhI266JjolG52Ejv
         Q6QczckcS92xS8Hfs+RQUZEDEJs+V6rbaRt1v69rvGub5P8BzBlhwigU2kApWOwQY8/F
         ssdf4rUrzuPAVAcER/hZCQy4LGZSYNJztWVY0C4QAkvq3Az4AMzsX83Ze3T7l2yP7odU
         zkDwAsPDH+ygmEG5BMSyRLQGMJt13syAQaAxTKxSf3LdYmfY0c2diayQXnpSNx+Zqxgq
         /+J+RiTUz54V+mbZdxukQ2XXK/NUmN7PxjXff+vyTLrXHpHFje/H0G8gYLkTRk4IdT2r
         0JbQ==
X-Forwarded-Encrypted: i=1; AJvYcCX587q0wkxtl7Gcgy4O44tEa/+B3RCaSf6q1aK5F9qNwvkROyVNkM1FGjaxgZFXA4zuMwb+iK60Abk/fIR8ebNkpGef5t70B+yCyefH6Q==
X-Gm-Message-State: AOJu0YyF/1hrhBtJxh5+nspfTG6iFeN79cU5tr+V3//a5nmI2bOirSTi
	qMt4MDtfwGkySMyRRLnIf0XMFEEICAu3UXspCRZQfxyy1AfwRoTZ8a05fNUw+jz3Y3b40UBtdok
	hgW3L4Q==
X-Google-Smtp-Source: AGHT+IE9l1WXYMVcQohIyPmBVzAUnAkjl7Co9OJLCVNk/j6RFadTCPsXPGfMKCejXtVK18v+VfVD4w==
X-Received: by 2002:a17:906:fb99:b0:a44:277c:1683 with SMTP id lr25-20020a170906fb9900b00a44277c1683mr207483ejb.53.1709161038892;
        Wed, 28 Feb 2024 14:57:18 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id m26-20020a17090607da00b00a441ff174a3sm4710ejc.90.2024.02.28.14.57.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 14:57:18 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a26fa294e56so62359166b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:57:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGTXaYg1jBlbfGtNtkU4nk1Y8ln4KrsVTpnrAWp1072f8gFBJfqwyGRDtaQjS9Pu6fFYyzAwijfOcEU8646W8s0jOwyzU//iDoZx/5ew==
X-Received: by 2002:a17:906:b7d4:b0:a44:f89:8104 with SMTP id
 fy20-20020a170906b7d400b00a440f898104mr218606ejb.42.1709161037880; Wed, 28
 Feb 2024 14:57:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
In-Reply-To: <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 14:57:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Message-ID: <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>, 
	Christian Brauner <christian@brauner.io>, David Laight <David.Laight@aculab.com>, 
	Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 13:21, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. If the copy doesn't succeed and make any progress at all, then
> the code in generic_perform_write() after the "goto again"
>
>                 //[4]
>                 if (unlikely(fault_in_iov_iter_readable(i, bytes) ==
>                               bytes)) {
>
> should break out of the loop.

Ahh. I see the problem. Or at least part of it.

The iter is an ITER_BVEC.

And fault_in_iov_iter_readable() "knows" that an ITER_BVEC cannot
fail. Because obviously it's a kernel address, so no user page fault.

But for the machine check case, ITER_BVEC very much can fail.

This should never have worked in the first place.

What a crock.

Do we need to make iterate_bvec() always succeed fully, and make
copy_mc_to_kernel() zero out the end?

                   Linus

