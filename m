Return-Path: <linux-fsdevel+bounces-36113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40DE9DBE23
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 00:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5492811F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 23:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FE71C4A1A;
	Thu, 28 Nov 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsEOPgJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E5719883C;
	Thu, 28 Nov 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836701; cv=none; b=Ve+VDDGYtNdRMuAV9l5u26Q164C+jo2t9z9x4hqr46c5uz3KFED37K4MXB3FYnKVFdxRoTnRIidv8RPeCNMSC6wb8aXi59EVSCH0n5qMFQerwykbLde6JbR1+ERvTsmQ0IsRzFWM/6bs1Vl98Fh7cQDLrv/lt9d14QBb1mnAAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836701; c=relaxed/simple;
	bh=P/GbuJNHBbVPRQbBHDh8eD3ykRKkmp+tIUbLBq7NJrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7R3IHQwH8hsGzaRL0hBP5/tQMSN4VFA3OoF+KYXP6I9n/dyg5r2QdxW+T1xdhTPA3lATAtKLMdn6eeujrUczxpDCPjYVMmKHVklzQ4+g98MN1ZxcAsL4dQ/RWK2W8GrqLqhmxvO0B/puc9vdX/HYtX8VNw4MqV4elTYdfwMUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsEOPgJp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so2377204a12.0;
        Thu, 28 Nov 2024 15:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732836698; x=1733441498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JMmQ+euJeUI1bvgZvShMNChaRMxgihGmPY37bUmkejQ=;
        b=NsEOPgJpLnwnxTFzP3Y/l0al5wkDS5/nkGCBc9jPzZ0y29yzgZ5oSuYFjiRKPldiX8
         ZCNri+TDqovPIFZ6QWuL3lVwMVpCCbnqIqS1D/z/Ax4RM+hjlflEMUbisYCa7cN/aFMY
         S/e/Vp6E8rjF7eO7tQ+0j5oVPYQLe3kZL9S/XDzr/svWZdrabkVKQjEjAOgxIJSfLO6S
         +HU/V19AqcMBKfK1mMcxo9KkYqFyEYRS/yPMn8Ei6qHDkgChyRsikVabt1/r7wuYl35I
         9GwVT1B/c/RZ6+MKOBEOwo31rDSmUiXI8EYBK/EInr21hUH/YUN62lOos4vqADsl35na
         /YVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836698; x=1733441498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JMmQ+euJeUI1bvgZvShMNChaRMxgihGmPY37bUmkejQ=;
        b=N0nvC37AwyQXceR5RC7kH4yTbE96Y3+cpMU/fIf+bH5JtmjB1p+/KOx7dppyLUDH5T
         NEXYG3cMwgY1rHmsfHyxoPbSlR+eOdRS/+mYZsIIvyxPn9P1nQkN+PtlANyKu1ZN/kg8
         GJFS0NAEmpv310NIyu0qCnrByrNliVi5KXmAPojdLOxX55LGDEiMe2bC+lbAwgQngv1D
         KIJ9xMwRfyVQHoeLe0L6k4yaOb0d/w6pb/YFVhlygbYErZ54TvNIBMf5+fb1cX+2sN68
         3IXg/uwnKlVbRi6nNkklkwQes5xYLkA80osMQYKYEzVDzwk6+N6bumLBvZ+H7p+Jxs/8
         hY6g==
X-Forwarded-Encrypted: i=1; AJvYcCUeFJKeGxNTZvkpapj72+2oXNmt4fVfD5hoiL3qHacninrZNfq+fHHNnx2OxAKUKQZZXYwzUPUm/6jLJg==@vger.kernel.org, AJvYcCUf3KytBz4gFRMIPW0Up6m5BelhWcZdbAcDLU/Fn1rEDmsWKcwhfqJoO6r4U19V66nCZ035eFSJFhUPYHVcoA==@vger.kernel.org, AJvYcCW2EZprrutc+Moldf4Xz6PhqvglZnBgEe7N4GD54F+dlmWzXmZJZ+cyxM3IZMDZpg1s9ZXeLmiVi89JbbhN@vger.kernel.org
X-Gm-Message-State: AOJu0YzmcL8wtFa02e0TWQLtATcm+v/NZWo+GU7sMzg+VzXN9rAy7H2L
	1S8Elg+v+22gOeLBFPRO7ge9Ym8NuHTihHqsA9FyU1sB1348gnwvhxUR1HGrNxfGDl/FQR8n/Yf
	sPNA9mv8IQU3Z5l0UpLndNs1SIjk=
X-Gm-Gg: ASbGnctXEaXw33pP6efBgwzGWJDi6QtXcRw6rsnTpagkYHG+Wqaa495GgdKC6iFMWWs
	fGz84qiLOMklmE/S5HBGcLZDU2T77niM=
X-Google-Smtp-Source: AGHT+IEugrJLH9v+xP61oVG1eZv0KhzLh9Qaq3n+mLo5AN/FqfweRFAco/52Brjfc3g4jpsXZ8JRgfpACIvxebaJg1Q=
X-Received: by 2002:a05:6402:1ed4:b0:5d0:975:b1c0 with SMTP id
 4fb4d7f45d1cf-5d09516035amr5686024a12.11.1732836696288; Thu, 28 Nov 2024
 15:31:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
 <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
 <3947869f-90d4-4912-a42f-197147fe64f0@amd.com> <CAGudoHEN-tOhBbdr5hymbLw3YK6OdaCSfsbOL6LjcQkNhR6_6A@mail.gmail.com>
 <5a517b3a-51b2-45d6-bea3-4a64b75dfd30@amd.com> <Z0fwCFCKD6lZVGg7@casper.infradead.org>
 <e59466b1-c3b7-495f-b10d-77438c2f07d8@amd.com> <fb026d85-7f2e-4ab5-a7e1-48bf071260cf@amd.com>
In-Reply-To: <fb026d85-7f2e-4ab5-a7e1-48bf071260cf@amd.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 29 Nov 2024 00:31:24 +0100
Message-ID: <CAGudoHGnNDOQtmNXTG4dphNnQW1MD7idAa0fmvk8fBPF34sUCw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, nikunj@amd.com, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 12:24=E2=80=AFPM Bharata B Rao <bharata@amd.com> wr=
ote:
>
> On 28-Nov-24 10:07 AM, Bharata B Rao wrote:
> > On 28-Nov-24 9:52 AM, Matthew Wilcox wrote:
> >> On Thu, Nov 28, 2024 at 09:31:50AM +0530, Bharata B Rao wrote:
> >>> However a point of concern is that FIO bandwidth comes down drastical=
ly
> >>> after the change.
> >>>
> >>>         default                inode_lock-fix
> >>> rw=3D30%
> >>> Instance 1    r=3D55.7GiB/s,w=3D23.9GiB/s        r=3D9616MiB/s,w=3D41=
21MiB/s
> >>> Instance 2    r=3D38.5GiB/s,w=3D16.5GiB/s        r=3D8482MiB/s,w=3D36=
35MiB/s
> >>> Instance 3    r=3D37.5GiB/s,w=3D16.1GiB/s        r=3D8609MiB/s,w=3D36=
90MiB/s
> >>> Instance 4    r=3D37.4GiB/s,w=3D16.0GiB/s        r=3D8486MiB/s,w=3D36=
37MiB/s
> >>
> >> Something this dramatic usually only happens when you enable a debuggi=
ng
> >> option.  Can you recheck that you're running both A and B with the sam=
e
> >> debugging options both compiled in, and enabled?
> >
> > It is the same kernel tree with and w/o Mateusz's inode_lock changes to
> > block/fops.c. I see the config remains same for both the builds.
> >
> > Let me get a run for both base and patched case w/o running perf lock
> > contention to check if that makes a difference.
>
> Without perf lock contention
>
>                  default                         inode_lock-fix
> rw=3D30%
> Instance 1      r=3D54.6GiB/s,w=3D23.4GiB/s         r=3D11.4GiB/s,w=3D499=
2MiB/s
> Instance 2      r=3D52.7GiB/s,w=3D22.6GiB/s         r=3D11.4GiB/s,w=3D498=
1MiB/s
> Instance 3      r=3D53.3GiB/s,w=3D22.8GiB/s         r=3D12.7GiB/s,w=3D557=
5MiB/s
> Instance 4      r=3D37.7GiB/s,w=3D16.2GiB/s         r=3D10.4GiB/s,w=3D458=
1MiB/s
>

per my other e-mail can you follow willy's suggestion and increase the hash=
?

best case scenario this takes care of it and then some heuristic can
be added how to autosize the thing.

If someone feels like microoptimizing I also note there is magic infra
to have the size hotpatchable into generated asm instead of it being
read (see dentry cache as an example user).

--=20
Mateusz Guzik <mjguzik gmail.com>

