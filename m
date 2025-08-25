Return-Path: <linux-fsdevel+bounces-58991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34BCAB33B54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 11:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17D63A42DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881EB2C3261;
	Mon, 25 Aug 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T7KT1Qha"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F4F393DC5
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756114931; cv=none; b=M2IyLqboo4/g6suZ1dYcKElPUPKx1oY3A6YZNgfGRJQbs2kezoZ4z1G3yJW9Xwr58uEk9YLPzmU6CSPY+uFTRg9A4y8pmoOf4BGL19Y8nrK2JC59Sq6ONcF8dtOPwTcUMNQHW07ObAT4ZgIGophYgGrqNb4VbN4Ic/9Kiv5WM7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756114931; c=relaxed/simple;
	bh=qSxAdEFkr92eN+3eEeJ9Yx+AdgaO5dXFSmZHlto/gbY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHLyipijgHrFcZOOuQEb+zWpELiWpgsKqtZP6m2bRfAVqh5UorODiEnZiWJ/Hav26EigWBvSHz41OBeohYfnCUaLrxLzI7x3fIOM99E1Z/F+ajDd9yljPP3oy+8POvsxp8TfPlNEcOYTSsKusJhOFT3Hckyc/vaA7eT81MtnRW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T7KT1Qha; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61da7b78978so1563149eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 02:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756114928; x=1756719728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GRu22p3tVeEW2VrGOdoxPvOS1mLmNVegFteBbU78nI=;
        b=T7KT1QhaStHCSKMvU7GPD2OmBkxi0cCXr3UmxNrRBbY+rXsozpojT9GP0Oo0Avidn2
         LyZ/A9hDc7l6Ju4MGsoVGzUjGLfSzpnS9JMMdf4bUwNAlSQa3IIjieSIuyQJAkuoNwe+
         VYlCu6LKO8xYSBeXQKG4PSOVBkILLEyQKwPTaTnz7uJqdNz1IU6R1LM9ZSd8zr+ueqHP
         Fu2PWhU3GMy8CLg3kjKZ67D+afTpvCJnrFjq4/k5ZGFPSM6JWBB3wH3IeG4lSUPmra9w
         bGp9GUC+o5Vc8dvF8aDUhXGyzbBlkfZk3Z3PPyd4nrXI7UOhXu6Fs7Qkuz6uJa6AE2M2
         3UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756114928; x=1756719728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GRu22p3tVeEW2VrGOdoxPvOS1mLmNVegFteBbU78nI=;
        b=Kk9o/XUuGMtLi4RcXzybVftR/7pUppBFi2p3CWjTuDDrauCyPJO/gwSpgZMsiciQCq
         /+rh7wEaSiizIAz1iFvAs3Ktb8XvuhM6PKEY6B95p5778Dgv+qKAZV8VwbL5DojHtIiD
         rsZu9EECZzY+ef3DYqOBsc6og3ypy9IyVzvNbH0gIQoTnxQBxg3QDckVYW5HhlDfpNVB
         7UaVRFcVnFdmr07p5uZNvvxyj6z6fbn9wCSRwWX4EPPc5JnSOaNuaIBXBYcUFr9pHFmq
         ydJ1UbJoaD8W0j4dnD4Uy5ENubk7raER4p0wmxeqU9ZjsEhQJ4396O8TSqXOEI/qeLYi
         JjZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmQhscXQKJJplcGBIveMqG8IQxylwHSTNVzZbISsPRFMlwgAnLhNyPlB70schhDiiSUVBrFQO8etJLqSpp@vger.kernel.org
X-Gm-Message-State: AOJu0YxkJcMlucx+7eUCy0VclW2PLlcYszsHy9KGBITzgAESbbyTcfdJ
	KoNSDxn+pnVyPeZP35PCQEgp/9s2VCXdxd8cX/gNx/jINUX7NiNrYOZ0CIa4/4rk8hW+1e567Ch
	mZk/rKnCtYY/Pqg9EuO/M6Di90GJ6b5cR7gECBvl6ww==
X-Gm-Gg: ASbGncuOMzb49BhelaAKwMyXynC6+nQYeX1PkTP4dCjmE27D1WmUXiiB77+KOsXw7KB
	4whwIMggHVUUhYidR5iXmlWf3FyfGOh4kx5tDhqSHI8fH35c7Y61QDCI8S7Bdus9GIsyrbnUmot
	GjQ7rxPsG86Re63iKtu2Qi7AVZyKJ1Fv9zoVvgP2+qJz4CNpJ/Xpectzxs0/68xkdhnwa00wTCD
	IYfiOsUJJnT
X-Google-Smtp-Source: AGHT+IH9whC+Nt+KP6zMOInVqQwfTRZ9vyaBO1gLszlXrDLuQ8rxx0C4w5IQE2c6Fn1IFfz6+QQxtpnzgbhuqH3KxgU=
X-Received: by 2002:a05:6808:1883:b0:40b:2566:9569 with SMTP id
 5614622812f47-4378525e610mr4960520b6e.24.1756114928355; Mon, 25 Aug 2025
 02:42:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org>
 <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com>
 <aKwq_QoiEvtK89vY@infradead.org>
In-Reply-To: <aKwq_QoiEvtK89vY@infradead.org>
From: Fengnan Chang <changfengnan@bytedance.com>
Date: Mon, 25 Aug 2025 17:41:57 +0800
X-Gm-Features: Ac12FXxB3S3g0sTu8keoah4lgnqnAcyUyXsuVt_e56y_rQP7QRz4QmS_1ZuROw0
Message-ID: <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
To: Christoph Hellwig <hch@infradead.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Matthew Wilcox <willy@infradead.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=8825=E6=
=97=A5=E5=91=A8=E4=B8=80 17:21=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
> > No restrictions for now, I think we can enable this by default.
> > Maybe better solution is modify in bio.c?  Let me do some test first.
>
> Any kind of numbers you see where this makes a different, including
> the workloads would also be very valuable here.
I'm test random direct read performance on  io_uring+ext4, and try
compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try to
improve this, I found ext4 is quite different with blkdev when run
bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but ext4
path not. So I make this modify.
My test command is:
/fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
/data01/testfile
Without this patch:
BW is 1950MB
with this patch
BW is 2001MB.


>

