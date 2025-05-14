Return-Path: <linux-fsdevel+bounces-48960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F3EAB6AAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 13:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C094A69CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B42749E5;
	Wed, 14 May 2025 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IxAiFxTg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4141B1F875A
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 11:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747223827; cv=none; b=mMGJohiJeTtuNWuVZDL77qw5yXcZ+sby4NK2jxkwSYzLOYZ64fuykGbyXFg0DmxBLbnzVPBllmqbieSaoLZFalQDQxnSLmhKEYWU03xs9YWRrIxUfmgTdxTrlDZGIIPppr3HoemA2GcHlKWL4VTFFU9CM0mKFlmv8Po27+WGYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747223827; c=relaxed/simple;
	bh=z3DaPFihoK23TL05V6hxbQztAMEFNMjAk2PlRE/6sBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=glKa5fMm2SrzSJ3i6hSHg+8YWfru3BzXNh8VFtPhIrWdd8K6Bk6v3rF+U6ErQavxgXn9fWCjDxkQKardxS7kbr36xHEHRSXfvE/anap2mznrK0ufkDQB+dYgCbi2xfDT9vCFEW9IleW5cHaNexNnzlelJstcTmBuWKKXQQP/kFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IxAiFxTg; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47688ae873fso73989191cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747223824; x=1747828624; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z3DaPFihoK23TL05V6hxbQztAMEFNMjAk2PlRE/6sBs=;
        b=IxAiFxTgv8tQK2Yy+wu26B0Fnk44mujyu0S2agQRNBoNYkR5OfGSUG2C44RdMzMTky
         2Z0uVc5jwyK2Y0qtkaI25Lh4E87/OBLb3CfITlop0N4c8TfPh3cAAdlmkBPy/E6NAqaJ
         r2tSX6PMwTNBb29xGFj3kd7t+1yDpHu1iveu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747223824; x=1747828624;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3DaPFihoK23TL05V6hxbQztAMEFNMjAk2PlRE/6sBs=;
        b=Ut0yLWnK8sgfsmQ5FLVDqm/6vY3Za1kjHE7/ekT2Hdnn2AHyaYHUMVzfqyDcNdf0Wl
         9iSufCbhMEJBG19uRRuOgaXamdP1OlZLjYayRRG24TcTWO7LFOjsooN3gk6RURhuDibV
         veNbBE+Gf5vuoLPbo+Id137agJ4gYumrDEZoTosgsTF97474pedBLNjto51yZ7KAzLPX
         +f1baXYh8e6Nq27ylETNa/KTWUEX+U25nMo7AMyEBluetJRquRYyA6R8uu8maJKZvR+F
         uzOqj/JBd/kzfsDlxF0DnTDoLNUqYKWjvV+a1ow+jZ7hc+pvXRUnqRStVTsZG5Sk75cL
         mUhQ==
X-Gm-Message-State: AOJu0Yw3lU6bIm2HuB462rNLPLwACWbhyzLbcLnK2laVinuVr1agVnJu
	DzgmFQhkpsYnSPbkAQmKJmhZj46z3mzR1uvZEjylwmQhkuy2jCJPtDdw+LHAp7NRummFEtjORvh
	00/KYl7VDbbQ80sa5As41ew+rlQZrmKpGmawQhA==
X-Gm-Gg: ASbGncsHSDCIhX6EEJ83nBzVqhj8FNnTd9nuLEhlqX8u4S9SpOwxscLq4vt9F6/O1AZ
	3pdDV/6nO2hz+doGBDyIGEemAI2u72vrPUYjLhQ8D8ef4IET+1scF0EUIRcIVzcN15SamY/RuXa
	qTSHT6l5ztZ7Fz4yPgwY+lyW7TAc4lpAE=
X-Google-Smtp-Source: AGHT+IHkKUM1mgu6Fjfnaem8QmDzbacaGBn9KHQ7E9DxvC+GSZzWF/EvKQ7FJWl2JOqSbHPcVFIXmPfPLG+9ZFI9cms=
X-Received: by 2002:a05:622a:59cc:b0:494:77f1:61ac with SMTP id
 d75a77b69052e-49495cccf79mr53183551cf.18.1747223823991; Wed, 14 May 2025
 04:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422235607.3652064-1-joannelkoong@gmail.com>
 <CAJfpegsc8OHkv8wQrHSxXE-5Tq8DMhNnGWVpSnpu5+z5PBghFA@mail.gmail.com>
 <CAJnrk1ZXBOzMB69vyhzpqZWdSmpSxRcJuirVBVmPd6ynemt_SQ@mail.gmail.com>
 <CAJfpegsqCHX759fh1TPfrDE9fu-vj+XWVxRK6kXQz5__60aU=w@mail.gmail.com> <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Yz84j4Wq_HBhaCC8EkuFcJhYhLznwm1UQuiVWpQF8vMQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 14 May 2025 13:56:52 +0200
X-Gm-Features: AX0GCFvBpmh1Yr-MEbqg3xW9iRqVg0raWSd_iTUCTmEbRccXvs7cJ-kILWY7H0g
Message-ID: <CAJfpegv+Bu02Q1zNiXmnaPy0f2GK1J_nDCks62fq_9Dn-Wrq4w@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use splice for reading user pages on servers
 that enable it
To: Joanne Koong <joannelkoong@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	jlayton@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 May 2025 at 23:29, Joanne Koong <joannelkoong@gmail.com> wrote:

> The results vary depending on how IO-intensive the server-side
> processing logic is (eg ones that are not as intensive would show a
> bigger relative performance speedup than ones where a lot of time is
> spent on server-side processing). I can include the results from
> benchmarks on our internal fuse server, which forwards the data in the
> write buffer to a remote server over the network. For that, we saw
> roughly a 5% improvement in throughput for 5 GB writes with 16 MB
> chunk sizes, and a 2.45% improvement in throughput for 12 parallel
> writes of 16 GB files with 64 MB chunk sizes.

Okay, those are much saner numbers.

Does the server use MSG_ZEROCOPY?

Can you please include these numbers and the details on how the server
takes advantage of splice in the patch header?

Thanks,
Miklos

