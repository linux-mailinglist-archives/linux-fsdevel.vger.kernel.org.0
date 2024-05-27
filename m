Return-Path: <linux-fsdevel+bounces-20273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D38D0C8C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 21:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB1411C2121F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 19:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B91607A4;
	Mon, 27 May 2024 19:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XJYmeRAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0A15EFC3
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716837646; cv=none; b=koeL/jfRMk97SzMCn/rTen0bRt61yOz1N6QxoHMjILzbnNG96x/clax/Yrz/ogfCQw7ZeqweX2QXQiiPDW+F+lg+4tpJrivthN2m7+b5yvrus4Rd3hrOopekxfpCkSD7fNnFRhB/TdxYRfpLAUslE3EFWZVgJOKXh797qX26kIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716837646; c=relaxed/simple;
	bh=4EkNz74OlBGEC6z1YuEiLXE4v6QZ8njYb41SVknyWCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLqYPVARwNe/dsLTv2NjOdDmgYyxF6Wq9Mqy7Y90zkGocEkMDNwpT6Lkh+ug88x6EN6LhyiPo79rkzAu6CiwESigYixzk9/zLHdXlhEg8dzKiBv67xmg5XfNJLUv/89WCNA0gQLziGfRoceAUVdBltqzFuDjXBOSIFvSRpsrD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XJYmeRAg; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5241b49c0daso108684e87.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716837643; x=1717442443; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=av+hI6RrZwvLerv2odhQfSwHlj6qlp1CeMI357Hz1qc=;
        b=XJYmeRAgGhO/FdmBIejtcsjHCys8YVC1ZdXwgNSjd7pDJD8nskptMptyt2ajPt5xjP
         U1cmGmtbE+gKw+OcqThwgTq5nqf/ocItEhOxwPpd2PSeF7ZVP8boch6QcTxsEnSy+nIf
         6mf99+t/O3dYgajoB+9hcs4dJn8bE2r4Vj+Ls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716837643; x=1717442443;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=av+hI6RrZwvLerv2odhQfSwHlj6qlp1CeMI357Hz1qc=;
        b=hF+wAodcLWs6RycWcHFnNJUpccLvedokqdoJF/7BOT9jRTFZbxtmN/Z01cT4UhQH8l
         jVSx372hlOPgafSy+DAeA8gZT5TvfNJoDJbHbfwUrRD0YmRbGfEMuC2gH1KEXC5PTxnZ
         zFiweHTC1AOyqNmt/+nT4YEVzsFR3Ns/aeI8E8pzkL8U+nT6wbRPIp0kctXB9Qa8CSiv
         cm6ohSSUPnIxONNgigwBmB0RWCkWueZe6KjUxKsaqP50o2Y/voNVaXFL2KHnDLI1bOdW
         VJw2eNO/Ed2FDAQabOSsDoX1uKpy0FA+p3+tp+lNBEX9O4mjxgGFNkVxC/hHZkz6LD2d
         x+Sw==
X-Forwarded-Encrypted: i=1; AJvYcCWISmB7BnVk1UpVF+DfMpV++BH1/u9a/qKNTOx3BAQXQ2x8dIZ8ih/DM08tLZQL93IpcMRlvHiwqOlqf98nwtHzNP8tV+VdoaM5JRgkUA==
X-Gm-Message-State: AOJu0YwUVnC+URVW1MEV7ZLc5v9GYaCBxOPfjIVAxyPuTFVIq6rwms8r
	PWLDZGYWaW5mg2t477u8lutT4jb2s3J3rkj4CjxO6gY0BlQKyL+TWXJUm0eLFb2sTo1z1407r/h
	JQp5C8w==
X-Google-Smtp-Source: AGHT+IGY4oG2g4cU1t5nZyYpoGQBdx0ZP0FPTXJ7ggvRT5I/9CkReTRSQXUqe8ix1AwDQBRHtn+wNw==
X-Received: by 2002:ac2:4d8b:0:b0:521:cc8a:46db with SMTP id 2adb3069b0e04-5296519a4dfmr6544379e87.37.1716837641900;
        Mon, 27 May 2024 12:20:41 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5296ee4a645sm687130e87.68.2024.05.27.12.20.41
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 12:20:41 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52962423ed8so76941e87.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 12:20:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcWcnavyC0vvUcFo7ipozGVBE1pm9aEo7dY4KgKED8fjhF7qdAKkNGTVCwgIDHwY6iTBlEe6CxMtID1tYMLNsas/rfL91h+WCaHh9SjQ==
X-Received: by 2002:a05:6512:224c:b0:51f:d989:18f6 with SMTP id
 2adb3069b0e04-529645e230emr9748602e87.13.1716837640937; Mon, 27 May 2024
 12:20:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV> <20240527163116.GD2118490@ZenIV>
In-Reply-To: <20240527163116.GD2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 12:20:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
Message-ID: <CAHk-=wj2VS-ZYPGARrdYVKdexcC1DsERgG1duPojtc0R92w7CA@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 May 2024 at 09:31, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Alternatively, with a sane set of helpers we could actually _replace_
> struct fd definition without a huge flagday commit

It wouldn't even be all that huge. We've got less than 200 of those
'struct fd' users, and some of them hardly even look at the result,
but just pass it off to other helpers (ie the kernel/bpf/syscalls.c
pattern).

With just a couple of helpers it would be mostly a cleanup.

               Linus

