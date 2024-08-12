Return-Path: <linux-fsdevel+bounces-25679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FB94ED8D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 15:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84BD91C21E23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D675217B50F;
	Mon, 12 Aug 2024 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+tBdt+j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA46D4D8D1
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723467632; cv=none; b=njCQ99+ZXY8OSFeYrpE5S4/Jl4xJXOurmpJ+erkrwdN5kNtga53dhDNvv10+YTrm8txdTs/fO+4Knx2AfRnVBzoPy9PFPW9it8FzexOEPBeDi50oEpRx3+s2FUmxFWTWSytgAdykwLgnhxZvKTsDw7cxgyoErMT+LQlfhzFV2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723467632; c=relaxed/simple;
	bh=wRfI3FdFEJ3MkaXnIoLgQ90LoAHwRYhh3fwjWRkFJ5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ9Pb5tI/YkQltFmBWf5dKLPGuc5tBbMthtzAuRyXLAJrg0wM7Q51cuyI2U2Nry5TsIFzF2b4A3YMZTUUmjffauRCMGGIlQSFgt4zOshfoJ/1HxuCmwWUUFbQ6yfsQPQJ7Vs+GL5U1SWMsj5HLCA1BnC+9AYh6/wPfIfPgNRT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+tBdt+j; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6b796667348so34585116d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 06:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723467630; x=1724072430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wRfI3FdFEJ3MkaXnIoLgQ90LoAHwRYhh3fwjWRkFJ5I=;
        b=V+tBdt+jbu/8dOtYqZIhSVfUYmqiVlI5g3N2e0Z0D5Cqf+fafYwh502zGIy01S1yuV
         UndrijeAxsISHsWm5F7TbXBFoGkD48Z5XRRoRJifiGoNI6CLSDbaKGhRow2KvVsIsEL3
         NUpP6hqxAVY2FCYpHyqlum0GeaGtp/mUVO0RnNCQZ4TXHr9pKdkaqqMZPaGgYEH9Q6JD
         gudY4cYO1wZYc9CpnMv9wNPJ5EQ4c3Hjt7YlXD9b/zswzfmemzamr+i/48Z1uC+WTveb
         r2+VWAOYm9f3s12wpVrjm4CRMw/Gt9cakrl5EIBrGppNe0bfSwL+O0wnY3+GzTPoGSbK
         SgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723467630; x=1724072430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wRfI3FdFEJ3MkaXnIoLgQ90LoAHwRYhh3fwjWRkFJ5I=;
        b=goP9Vw+gd0QRBD5GY/jhC99D/dRQ4LyBTdLfxDIOvidbxW+mXSey1H4AY9H0NLUUn/
         SiBc6KI3wCXvdjnLWqb+W4p8XLsZ8O2FJ9JfyeK3mTyvChR3a9qO2CPOq/tF7z8mcTTi
         WjHWy3+O2QgnTf4Pl3tWqGJ5+mYi7aI2K/L4rFPcEWVGQG4vvuhDtYZu9hPieTJnCy4X
         nVzlvdkiB9fWosiVZe+CHNQpUmWh5tZqstqDSwk7MGpB7lhc6xLXIsATa5fsJ/kGfKu/
         JEC8+GbV6P3uHGVm5i8BJp3ZGdqJRlDNmPRD9YGFcospraGSY/phrujF8sszXv8bnHoH
         MxZg==
X-Forwarded-Encrypted: i=1; AJvYcCVyFId/YH3O/Et1LuMxpfPt805ssvGcu/tVN+kFZIoN8KD7tu5FZZT4cyLYXRGnxaNVpm5yDrjIRjQNSC1aZHBoNcc6voYuIgTPVWE7OA==
X-Gm-Message-State: AOJu0YwR+Ol7QSBA1IvrRS3k90vZ+Nlr/HgFI4A37l+SYWX9IiZj1cQj
	i40iIS8roYhVUN10sfqcOHXTFK0VH2UFcNpScXSyj3UCZDXzBm5FdnQwuEUBEOOUqmX+g/5RCIJ
	Hod/YtxJjGLAqQW999d1FOcnYk1o=
X-Google-Smtp-Source: AGHT+IFrFB3KO4+jWsUGUYpYpu9veYHWvnx3aSQt6EztweIohhZIrswF8wq3QcozZnQgSswagyVouOHj0SWC2V3/Aes=
X-Received: by 2002:a05:6214:3f8f:b0:6bb:b18c:f67a with SMTP id
 6a1803df08f44-6bf4fa9314amr73076d6.26.1723467629482; Mon, 12 Aug 2024
 06:00:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812090525.80299-1-laoar.shao@gmail.com> <20240812090525.80299-2-laoar.shao@gmail.com>
 <Zrn0FlBY-kYMftK4@infradead.org>
In-Reply-To: <Zrn0FlBY-kYMftK4@infradead.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 12 Aug 2024 20:59:53 +0800
Message-ID: <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Add memalloc_nowait_{save,restore}
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, david@fromorbit.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Kent Overstreet <kent.overstreet@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 7:37=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 12, 2024 at 05:05:24PM +0800, Yafang Shao wrote:
> > The PF_MEMALLOC_NORECLAIM flag was introduced in commit eab0af905bfc
> > ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN"). To complem=
ent
> > this, let's add two helper functions, memalloc_nowait_{save,restore}, w=
hich
> > will be useful in scenarios where we want to avoid waiting for memory
> > reclamation.
>
> No, forcing nowait on callee contets is just asking for trouble.
> Unlike NOIO or NOFS this is incompatible with NOFAIL allocations

I don=E2=80=99t see any incompatibility in __alloc_pages_slowpath(). The
~__GFP_DIRECT_RECLAIM flag only ensures that direct reclaim is not
performed, but it doesn=E2=80=99t prevent the allocation of pages from
ALLOC_MIN_RESERVE, correct?

> and thus will lead to kernel crashes.

Could you please explain in detail where this might lead to kernel crashes?

--
Regards

Yafang

