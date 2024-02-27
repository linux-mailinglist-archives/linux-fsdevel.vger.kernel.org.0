Return-Path: <linux-fsdevel+bounces-13018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EE86A332
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 00:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AEB1F29854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 23:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1CF55C34;
	Tue, 27 Feb 2024 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E6QKlIeM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356011E86C
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074857; cv=none; b=Jd1ua0LNV6HOinNKlUtKbrUEmAJZtA6VtIaoOSzO5gf+FO6SGsLtcXB+H2lKFQYI27fEc76oiAIz6hZIsopBMgcVnM6Lnad4Rjmj7/+izW9/OYEN5N3aJ91S59M21ompnFLtiGb+/xUB6W2v5KoP5YdEV8Wa7jY/KtHI4zRa5sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074857; c=relaxed/simple;
	bh=RZTLC1S/3LWCQ5FBQtRCDZ3q+nhtmpRsyNZn0snlnLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DCqPlqVYAP4uunWYUbz3VD1yBZs9Kfj802nbJTyBUGlcmdvIs4Fxpvfer8JvLyqqf66RI5Dpwf5jhDbe4L4g1K5GxnpNRNrKHLBzU0aqf/Avzu6dfcP5rKYhHVQECyywp3oMM+r2nN34Vk38/qfmYw74J5ljl80egx5YcleTC30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E6QKlIeM; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512ff385589so3266363e87.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709074853; x=1709679653; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qx5LsTA5UJ6d2mahuUcCwGHEn051J8mbjCOCRjCOkvs=;
        b=E6QKlIeMLR7ZygdONasdOkV10ln2WP9cC1IrSOZULGWZJ38+FvkS4goAKiVRfxY7x/
         JR7bszPkiI7H3av8MMFNSWPYxap7hFfTWz+ZjHih3jBqFD+0S1sOute6wtt86C318qbc
         vVV5m1oTns8XOpvzCJo+HkY21sg7a/IuIAXMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709074853; x=1709679653;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qx5LsTA5UJ6d2mahuUcCwGHEn051J8mbjCOCRjCOkvs=;
        b=eOTj2q/AWBHRywgWMkFIvy50zKdC84xB3S42vYf3mxG9GJN5sVtueUInQrdhDJ2zWs
         +Q39LLmZOkp9dTA+gWug5v6peqTp62TBc27X4y9eLHNn149O6RxwFksyGyM9SH146JtC
         5UNyLKvlPFlaClwXXb+hSZ0B999BeDw6Hn2vdyBTMgmcNpX4QcW9sZK7lXlHlsMAv9D0
         ErUkhWw+4mlYBGXAMxE2C+ZJ9pcImqNL9474Xm0hz0FPQ5RztxGqZPbKyS583J3rMcq/
         YuHS0H5n3A2kamOhE3mPEY8usvXcto63/9fFa45yzVMgERySnOzVeT4SbDM8Kh9+1HZI
         0OWw==
X-Forwarded-Encrypted: i=1; AJvYcCU+j1EJD+iVz33yp8Vi45rpM4ML6JuNOL/WewB1dFcVSN2pKVStKcV9YpsPn/byG7seJSNnCGRP1jrVoib065pvl7l0l4oVw2pPTmWWVg==
X-Gm-Message-State: AOJu0Yw7HzDEpgIsKeEBfxt9vF1QX+HoT6aAhBZhtK9eFnGoTG//wxjc
	vq/rZhUVFWoeZ4yHeOF76ztNkQb54NZ6q4NIhCnCEm3DLR6Pcuy/ySfrlq59q12J+HBOAtdR0W3
	vJiToRQ==
X-Google-Smtp-Source: AGHT+IHX0ChoN8IXXsNVbNNAVSazdHxE4G5udpAL7N8ER2xOja+t7MDoSWd3YHL8qRSZErfBbEov9A==
X-Received: by 2002:a05:6512:1196:b0:512:9dee:44fe with SMTP id g22-20020a056512119600b005129dee44femr8234830lfr.26.1709074852984;
        Tue, 27 Feb 2024 15:00:52 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id ti9-20020a170907c20900b00a3e94142018sm1204204ejc.132.2024.02.27.15.00.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 15:00:51 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3d01a9a9a2so496385966b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 15:00:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWnnfbcYYbkUJwVwQON7+MRD17n0pLEs0rKi5Z6EutPxMCS+yqi8GxAIofHtHS1mAoW9CAqVANpPkzsWcvBdqQDY3sp5zS8obzH99DEzA==
X-Received: by 2002:a17:906:a44d:b0:a3d:9a28:52e6 with SMTP id
 cb13-20020a170906a44d00b00a3d9a2852e6mr7525309ejb.50.1709074851487; Tue, 27
 Feb 2024 15:00:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area> <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
In-Reply-To: <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 27 Feb 2024 15:00:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj8C3aMqHfo92JGN469xUOwN4UuHP2sxmcXNMPpaJNcaA@mail.gmail.com>
Message-ID: <CAHk-=wj8C3aMqHfo92JGN469xUOwN4UuHP2sxmcXNMPpaJNcaA@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 27 Feb 2024 at 14:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> For example, a purely "local lock" model would be to just lock all
> pages in order as you write them, and not unlock the previous page
> until you've locked the next one.

Thinking more about this, maybe that doesn't really guarantee much.
The final state would be that even with concurrent overlapping writes,
one writer did its overlapping write fully and you'd never have mixed
ABAB kind of results, but you could still have concurrent readers see
the two writes progressing concurrently.

Of course, since readers aren't serialized as-is, I'm not sure if
"readers can see intermediate state" is anything new or relevant
anyway.

Maybe the worry isn't worth it.

                Linus

