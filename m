Return-Path: <linux-fsdevel+bounces-13748-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3B1873608
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 13:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBF6B1C22FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98D80022;
	Wed,  6 Mar 2024 12:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ZxmTINy2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6517FBC0
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Mar 2024 12:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726733; cv=none; b=cJ6KTlw4P6R9JPRazwLOMpPiqGTS6iYDyHnbSwaFq/jLCBwfJlFNts3qBxgEbj4hM4h/Yym4jwMxSnDt1ZHcRkryZPmt5/Y9GqUanC4/KuOnZ1UiV6CNvBKRf7eoyz5YU5pSJhrwcsL21rMCwcTO+U/bm5gMI+imJmHtRwmDk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726733; c=relaxed/simple;
	bh=mQQs1EFIy6cUXGKjJECkP040wa7X/nRY4hPc2rW/q60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sry1MbCznAmNF92pXF+XF36sHCj5uEAyNb68d9myu9x9afeT0rpYKsAlYS9YKbodUpoRvOP+o5TK8sxNnmpA+tEd5xQAQe+vxshqnFSBfX1VsWD0fJ5NNMXIf2Cs6Nthzb6NO7hyChN7rsD1CPwcp4CRTtA61+yyoZVNaJKQjpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ZxmTINy2; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a449c5411e1so686817966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Mar 2024 04:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709726729; x=1710331529; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XY+7Za+1aql30Pw2upIoYUaonhwvVoEqAX4whkFzjIQ=;
        b=ZxmTINy22PjukoxlJh+xu2YsT8XpdR/E1RqaQP89dENQIrKxcUW+um5xwwtmJ4QWe9
         uudcNLrqYgfQaeceZU3BdVREbEtVFNfuyF2kllGLznaKuik5ISDl45dzlpiyRbYMKjBo
         dGeVqdbBVeAbY4eynlFGvlNHqoCP6PBAV0MOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726729; x=1710331529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XY+7Za+1aql30Pw2upIoYUaonhwvVoEqAX4whkFzjIQ=;
        b=M6oZW2SSpjsHwjXQBicIXxtI4DJ5ekaj9IcwJqUbw8qL16YhWhi3zRHeei9dBxDXEN
         e+PAyiGJrOe2OzxPbg4RTrEgNaIiuua2YJ9+M07GX93ZID0c/rWOSkE6gTbxqU9nR0kW
         9uVoluaTNhQBkdIiV5w0BAe19fpm8Hh2ykRRLvEUnI3yHGZOxzw23LaZVtSS6HUJd9VT
         +7qvVZwCAAIQgV8yh/6C63bPTWVTbzlbEMrGJ8or862Gc9bfxisyNPEMqp94hyTnMuIN
         uBiYW0aVk2wPiXcvsmjYFqrwB/MGQycUNioUjkB6De8KAktmM8r5lDPwsB9Z2TKYmJoE
         tqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrlAqoqWKsJ+prmBswmYwjMaerAu15nrvVF1AD/nEp28BCm3KdGc/ggxbufHRQ4sw8Vs89RC4qw5m1OwLIaoZHlXp7FBRFHRUPGeyL4g==
X-Gm-Message-State: AOJu0YyWV+SF6VSDkM1GOLDmRgVrV5bGXkcyCoLm4wluX6HLAn2bs8Pu
	+3lq8IduosJd91vEdUB/g0qopP7fFH//xqgquuea9mR9CThdLZ/fbPLCQszp9PTwHy5fDUMrwjJ
	AFCRKxHRLuOvKVnEK7r2NTAMtvW+BoYgewZB41Q==
X-Google-Smtp-Source: AGHT+IEqSap/dVxgYDi4Ef/ajNPQzeDWKChZuy6Wwjo82aRv3qQnIGU342V/AljMYll2seVjEJOSE2pw7cL48nK3T9k=
X-Received: by 2002:a17:906:fb93:b0:a45:9347:e3d6 with SMTP id
 lr19-20020a170906fb9300b00a459347e3d6mr2516460ejb.66.1709726729015; Wed, 06
 Mar 2024 04:05:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1693334193-7733-1-git-send-email-lei.huang@linux.intel.com>
 <CAJfpegtX_XAHhHS4XN1-=cOHy0ZUSxuA_OQO5tdujLVJdE1EdQ@mail.gmail.com> <a77853da-31e3-4a7c-9e1c-580a8136c3bf@fastmail.fm>
In-Reply-To: <a77853da-31e3-4a7c-9e1c-580a8136c3bf@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 6 Mar 2024 13:05:17 +0100
Message-ID: <CAJfpeguuRXO01hdmEr5ffMUNDyp5VPTYToOENjacYNAd1nu6Rw@mail.gmail.com>
Subject: Re: [PATCH v1] fs/fuse: Fix missing FOLL_PIN for direct-io
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Lei Huang <lei.huang@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 12:16, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:
>
>
>
> On 3/6/24 11:01, Miklos Szeredi wrote:
> > On Tue, 29 Aug 2023 at 20:37, Lei Huang <lei.huang@linux.intel.com> wrote:
> >>
> >> Our user space filesystem relies on fuse to provide POSIX interface.
> >> In our test, a known string is written into a file and the content
> >> is read back later to verify correct data returned. We observed wrong
> >> data returned in read buffer in rare cases although correct data are
> >> stored in our filesystem.
> >>
> >> Fuse kernel module calls iov_iter_get_pages2() to get the physical
> >> pages of the user-space read buffer passed in read(). The pages are
> >> not pinned to avoid page migration. When page migration occurs, the
> >> consequence are two-folds.
> >>
> >> 1) Applications do not receive correct data in read buffer.
> >> 2) fuse kernel writes data into a wrong place.
> >>
> >> Using iov_iter_extract_pages() to pin pages fixes the issue in our
> >> test.
> >>
> >> An auxiliary variable "struct page **pt_pages" is used in the patch
> >> to prepare the 2nd parameter for iov_iter_extract_pages() since
> >> iov_iter_get_pages2() uses a different type for the 2nd parameter.
> >>
> >> Signed-off-by: Lei Huang <lei.huang@linux.intel.com>
> >
> > Applied, with a modification to only unpin if
> > iov_iter_extract_will_pin() returns true.
>
> Hi Miklos,
>
> do you have an idea if this needs to be back ported and to which kernel
> version?
> I had tried to reproduce data corruption with 4.18 - Lei wrote that he
> could see issues with older kernels as well, but I never managed to
> trigger anything on 4.18-RHEL. Typically I use ql-fstest
> (https://github.com/bsbernd/ql-fstest) and even added random DIO as an
> option - nothing report with weeks of run time. I could try again with
> more recent kernels that have folios.

I don't think that corruption will happen in real life.  So I'm not
sure we need to bother with backporting, and definitely not before
when the infrastructure was introduced.

Thanks,
Miklos

