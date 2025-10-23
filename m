Return-Path: <linux-fsdevel+bounces-65393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6A1C03AD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 00:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D298D3B2861
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3327B27F00A;
	Thu, 23 Oct 2025 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXTwMCnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868515DBC1
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258467; cv=none; b=ptdXOJpeFZqViKem7OrOGKkJEUx/RvJ2o/WD/pKAHi1dO4lvK61OS15FDfPO2AJsdpCSsj2kzRaP1wFOxr7aATAWL3/9L9GhEY7g1zrYArKkKP1+FQ2zHUZ6Xfu+2GVHK3pE7eHKzHlFIA2mIXM59CMBI7CsM1wyLamC54SIVI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258467; c=relaxed/simple;
	bh=Ht/H4IDanITDdvpWF9h3fY89G36nY3NBYoaNv/vtMfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Weh5zJ14VbsMigs2UYozVyGnp1vyj0nO8tY7gkV+Wp8ykoXkWCeWl4j34WVP0EGj2B49z4h+qigPIKfadhcDXchc/9rwrGblO7LpdDb0fF4/M8pvMNpQw2LowwVpi5Z1ZwLWHHyQrVAXgqOLSSV0MIch6L6iLzjSEpFdm0WX5b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXTwMCnK; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8923b2d9954so94202585a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761258465; x=1761863265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ht/H4IDanITDdvpWF9h3fY89G36nY3NBYoaNv/vtMfA=;
        b=OXTwMCnKLi80zfWzgk51qNtwp0bsMbQRsS9hLJl0OlZ02O0+2TvdRQG0fglrAnX/UE
         CrZqJMxN0EHY/8DK3x7KM0P3KJ6gmAo9KwB++VkYEFm/Kg2c8rfpdde1P3OImzXq1p4q
         481T576BySEX69+UX4yp5FFJSlzWTluW90Vlwr/aJjYUoDniNswMr5TaIMx1Vjo86VLu
         hltFqODLM8kDy115Ohj8TWHt0RF4kIdzqsPHQ3FR2Eqfi/OwwsY7QqgsliHrE8deRtyW
         1ayEMmBLp9YyPlMfbsz2liHNeE1Uj8OoJuOGgyS6AiTj8d7VqhcsZjrOIRMLB7n8fa2v
         4HVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258465; x=1761863265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ht/H4IDanITDdvpWF9h3fY89G36nY3NBYoaNv/vtMfA=;
        b=HkGVH46o/TQ/Ot542xEgiMJo6Xcvbu49HlGQ11RHLYmc/p7bXCLm0XFB9j9KBdBMz+
         xraVt5SBdKGsxgWyoNekNeUcUBjqySMsZno6mxdpuQIhxUp7tgdDXI34qPc77bSWAQ5b
         qo/soaDqIJZne3SdA8wOoOduGEwB7EOQ/yaCUEND/v8q4JX0duNG2Sx1iIB+q9hM+xnx
         hu2aPbsd/AV1mlYeyJFwwOukbfysXwT1gi9uXqdkZD92PGKGyCA6heE1LDCqNO1nq1cY
         QQWF2PFATxBmN9EQz30SfYJQ6vFjeFKcUBfa6Ycm+l+zvzwT9HLe7WoiQ3Q9Kp7/5ZK9
         H7XA==
X-Forwarded-Encrypted: i=1; AJvYcCXMeZyu40ETOkZXMcGC2VygZHDMQzIsU25cx0Hpd31OncYEpBu6+SMGYnsKv7gjFTVElWJY3Oh5CoKbx+Wg@vger.kernel.org
X-Gm-Message-State: AOJu0YzlK0xhDTI6qvzKCYrMmz5JnylgVJ48epuuMV0skjJ12npW/oAN
	7GkvaYsi67OEzUD+tThxfiNrZ5pkeyuArF+3rEKPFcPK9WcdG2pY3LZqluTca2AKprPGcgL9T2z
	a/idxbsCsCsQAHxQ17uqXgV/tV8T8K3E=
X-Gm-Gg: ASbGncsRZgVpCldjsqbP0Fn3OyOF1lKD6XS0wm5FZmM5jIRnkNLa1/GRu16vaeCwFAz
	MABRPrFOTUNVQoQbrI3S4xhAoeWE2M+rESFn5hraKhV8uc4BY4IpYcrx6dmqjEBeJFhLGJB9Zdt
	8OgrjOEtM0Xfmxzma6O72i836Ux/NCO+p/XRO0f8TAEoTaMqtK5BAzFWAXz+BeJ7nusdyO2tuvC
	YYLFcCvNaw/KzRhoXtilfUtgb6yQdpHVgfu69Ez/YKG4jvJNu5mTZzqV4Qg4KyeTZvuFOzJbFCy
	V1oc+0wriYOy51L2QdymbuYoSA==
X-Google-Smtp-Source: AGHT+IEqPSTAdbJIuw7V8OhE4iYhquEpQZEkg/hRnGLy7fsxyODr+iR2/8L3Tdpo3a789XZXj8WVS9ab4iXfSWNh0KU=
X-Received: by 2002:a05:620a:4586:b0:89a:68c5:25e2 with SMTP id
 af79cd13be357-89a68c52a81mr980105885a.8.1761258464878; Thu, 23 Oct 2025
 15:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-1-joannelkoong@gmail.com> <539ebaba-e105-4cf3-ade4-4184a4365710@ddn.com>
In-Reply-To: <539ebaba-e105-4cf3-ade4-4184a4365710@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Oct 2025 15:27:34 -0700
X-Gm-Features: AS18NWBRLx6d4Pi7z3Z4LF-7BAg8SzzICjuHP4C2-0sftJMPTo1_GSlYHJsX4kQ
Message-ID: <CAJnrk1Y2cKgc3snAK8jJpVn5EJpLPE87nqxjcE-eKBWK0TvUgg@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] fuse io_uring: support registered buffers
To: Bernd Schubert <bschubert@ddn.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:43=E2=80=AFPM Bernd Schubert <bschubert@ddn.com> =
wrote:
>
> On 10/22/25 22:20, Joanne Koong wrote:
> > This adds support for daemons who preregister buffers to minimize the o=
verhead
> > of pinning/unpinning user pages and translating virtual addresses. Regi=
stered
> > buffers pay the cost once during registration then reuse the pre-pinned=
 pages,
> > which helps reduce the per-op overhead.
> >
> > This is on top of commit 211ddde0823f in the iouring tree.
>
> Interesting, on a first glance this looks like an alternative
> implementation of page pinning
>
> https://lore.kernel.org/all/20240901-b4-fuse-uring-rfcv3-without-mmap-v3-=
17-9207f7391444@ddn.com/
>
> At DDN we are running with that patch (changed commit message) and anothe=
r
> one that avoids io_uring_cmd_complete_in_task() - with pinned pages
> the IO submitting application can directly write into header and payload
> (note that the latter also required pinned headers)
>
> Going to look into your approach tomorrow.

Thanks for taking a look when you get the chance. The libfuse changes
are in this branch
https://github.com/joannekoong/libfuse/tree/registered_buffers btw.

Thanks,
Joanne

>
>
>
> Thanks,
> Bernd

