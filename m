Return-Path: <linux-fsdevel+bounces-63701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E93BCB39D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 01:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2123480FD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 23:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF4728A1F3;
	Thu,  9 Oct 2025 23:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aMd7P99H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67528850F
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 23:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760053853; cv=none; b=jrjzD62QLDTpJhdY64NByDgztrQ5isRW+h+wekaJMyvr6FVyth4VyxMjxh2KLhBS5arq6aBRQCCdWgZv3qQJ3q+FMThsmMzl69Nsgziool2E0tgnDQZUVD5P8BN/GyAnGg4smzy8+zH/CpgSpZn6QOVgnu6Pbyw2UmaKbm85288=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760053853; c=relaxed/simple;
	bh=RBllid+aFWJXPFcDfK2K4LligRlxSufDVtshFkolupE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfkatgJp8MowUopYk0dsjAz1HAQPabFnvBTxF9CjK/L6PXrbSZTw5eZHGSc3BwNmv50lAEISmSQ7aNuVq7ZIJgUuoWn8WjOrZ8VGszVPWZtXnsfUGRSatzIgMhJ4lIgb/K70pJIc5ikC3o63Ztezwaui6Bb7g+sAhAmv6JE8PIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=aMd7P99H; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4e70609e042so3561501cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 16:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760053850; x=1760658650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duqVUT7go4ZxqESg3UfMQLseHStSvb4cyv2AmihGRqU=;
        b=aMd7P99HMdyKxbj1Df9FQ0LIct+grQh7Iw6Lrs0lNw3+OorXg+IZGHdaukKaqFEE0u
         CDqc2AXBc2i+Lh8liAYO8/GadSGY8LXuVbeJApaxGUvybh53h/peOEu7oBiToD1p1Cpw
         w86uwRV+7V9iZlmNSXgmXwCSwkqAQQxxE4qRQcVEIzD+gXCP89VPlmvOwlRqNmlDiVG6
         fV7GNQUSIhuSx0AxP7cX3oItljKbKftWMGq9yMFSSdOYj7vpFJtFRhAM6PcbH5efEceg
         sAUDA5aWEdiScdhsfXB+jFWtnQQNCHAlqU90bE1AogoHue5gx6njxy68DOld0cm0aByW
         +72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760053850; x=1760658650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duqVUT7go4ZxqESg3UfMQLseHStSvb4cyv2AmihGRqU=;
        b=vdnZVOl1N4YAzh4RrHBTibFXUyTpPS9qafIISxxf4Iab79WzhlhTtRA9++IiyJrm77
         5fx4VZth/zrb2evLT1IksRDTjeMucz2RYDZ24NzR96EflBbBs/gg3K6u/RqgHPJropu3
         UZfK4TNFyZn6+i4nt3E6gdUUd8k8YSN2mqf8SPyzmlIPpG1CAV9w+TYy303yF9XcJqpD
         1JR7YxqIjuqdmh7kiGeSiqsv3RMabWPbbqcS0JEIp67XKeqJRMYVzs9gvCDEF4WkkCGJ
         YKnGV7GlBtmb6ov3dEoiWQzuDa/xZpxWUfmVxyFbjVX9D1IZXYmfSgELSYqIGVLMnpX6
         RIqA==
X-Forwarded-Encrypted: i=1; AJvYcCXEqQydp2esSIuFf2JoAtwO3KSu/iROh69Jfu+l3WiMJ827fANceBP1sTJBfGvODATw2Csl9LFUrxVctYxA@vger.kernel.org
X-Gm-Message-State: AOJu0YyecswkWDa23Zw9EeQW4TNIXfeqwNY1LANfH/+MLProGpYOepR9
	GQkP89eLpEKSAAyBrVtdYHGNs70aCZT5WI8iwRLQ+WbiSDCOIhJH5bpGku4tx6m4sPVTCOY2Bp8
	lYSd40It1PhpyDNwZFSMph0znXKikLTHVo1O7CXRe0g==
X-Gm-Gg: ASbGncvm7fjtEj478X//2pUiaqc4hX6vRrZL2FAPjazolOjVFiMsiUoB+S2oxRie7mw
	jitZxsoXCIxufqVHw840x6LS3DyHV7VPoEbMUgYzZM5JXcj/IWpvtoRJbb2S+RlJXCiK0dt2ulf
	/RwPB81VYNeVOTX1+Egm84sedSDBkUcPCJEwrzEq7zLs3MQqS44RPpPeOAkWbyw8aNEbzsubcVf
	NOKiDKecx27Hq2lyV51CZpgDb5K
X-Google-Smtp-Source: AGHT+IGzqqa1G0zf+VY5jF5o2/K3FQsYskXGylhSVDPQarH8ovd8yjaXj+2lxEhldlKlDevfO9Pxw709v3uWNVO/hiM=
X-Received: by 2002:a05:622a:1144:b0:4d2:1a1f:135b with SMTP id
 d75a77b69052e-4e6eaccc2d9mr144181361cf.3.1760053849859; Thu, 09 Oct 2025
 16:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929010321.3462457-1-pasha.tatashin@soleen.com>
 <CA+CK2bB+RdapsozPHe84MP4NVSPLo6vje5hji5MKSg8L6ViAbw@mail.gmail.com> <mafs0ms5zn0nm.fsf@kernel.org>
In-Reply-To: <mafs0ms5zn0nm.fsf@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 9 Oct 2025 19:50:12 -0400
X-Gm-Features: AS18NWA4BkWoWx107a5jn9RdQA3zHB-3kx_1Bn3qMWWFPgKkAAD4CNjnYqMlYPA
Message-ID: <CA+CK2bB6F634HCw_N5z9E5r_LpbGJrucuFb_5fL4da5_W99e4Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/30] Live Update Orchestrator
To: Pratyush Yadav <pratyush@kernel.org>
Cc: jasonmiu@google.com, graf@amazon.com, changyuanl@google.com, 
	rppt@kernel.org, dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, zhangguopeng@kylinos.cn, 
	linux@weissschuh.net, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, gregkh@linuxfoundation.org, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, dakr@kernel.org, 
	bartosz.golaszewski@linaro.org, cw00.choi@samsung.com, 
	myungjoo.ham@samsung.com, yesanishhere@gmail.com, Jonathan.Cameron@huawei.com, 
	quic_zijuhu@quicinc.com, aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, lennart@poettering.net, brauner@kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, saeedm@nvidia.com, 
	ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, leonro@nvidia.com, 
	witu@nvidia.com, hughd@google.com, skhawaja@google.com, chrisl@kernel.org, 
	steven.sistare@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 9, 2025 at 6:58=E2=80=AFPM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Tue, Oct 07 2025, Pasha Tatashin wrote:
>
> > On Sun, Sep 28, 2025 at 9:03=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> >>
> [...]
> > 4. New File-Lifecycle-Bound Global State
> > ----------------------------------------
> > A new mechanism for managing global state was proposed, designed to be
> > tied to the lifecycle of the preserved files themselves. This would
> > allow a file owner (e.g., the IOMMU subsystem) to save and retrieve
> > global state that is only relevant when one or more of its FDs are
> > being managed by LUO.
>
> Is this going to replace LUO subsystems? If yes, then why? The global
> state will likely need to have its own lifecycle just like the FDs, and
> subsystems are a simple and clean abstraction to control that. I get the
> idea of only "activating" a subsystem when one or more of its FDs are
> participating in LUO, but we can do that while keeping subsystems
> around.

Thanks for the feedback. The FLB Global State is not replacing the LUO
subsystems. On the contrary, it's a higher-level abstraction that is
itself implemented as a LUO subsystem. The goal is to provide a
solution for a pattern that emerged during the PCI and IOMMU
discussions.

You can see the WIP implementation here, which shows it registering as
a subsystem named "luo-fh-states-v1-struct":
https://github.com/soleen/linux/commit/94e191aab6b355d83633718bc4a1d27dda39=
0001

The existing subsystem API is a low-level tool that provides for the
preservation of a raw 8-byte handle. It doesn't provide locking, nor
is it explicitly tied to the lifecycle of any higher-level object like
a file handler. The new API is designed to solve a more specific
problem: allowing global components (like IOMMU or PCI) to
automatically track when resources relevant to them are added to or
removed from preservation. If HugeTLB requires a subsystem, it can
still use it, but I suspect it might benefit from FLB Global State as
well.

> Here is how I imagine the proposed API would compare against subsystems
> with hugetlb as an example (hugetlb support is still WIP, so I'm still
> not clear on specifics, but this is how I imagine it will work):
>
> - Hugetlb subsystem needs to track its huge page pools and which pages
>   are allocated and free. This is its global state. The pools get
>   reconstructed after kexec. Post-kexec, the free pages are ready for
>   allocation from other "regular" files and the pages used in LUO files
>   are reserved.
>
> - Pre-kexec, when a hugetlb FD is preserved, it marks that as preserved
>   in hugetlb's global data structure tracking this. This is runtime data
>   (say xarray), and _not_ serialized data. Reason being, there are
>   likely more FDs to come so no point in wasting time serializing just
>   yet.
>
>   This can look something like:
>
>   hugetlb_luo_preserve_folio(folio, ...);
>
>   Nice and simple.
>
>   Compare this with the new proposed API:
>
>   liveupdate_fh_global_state_get(h, &hugetlb_data);
>   // This will have update serialized state now.
>   hugetlb_luo_preserve_folio(hugetlb_data, folio, ...);
>   liveupdate_fh_global_state_put(h);
>
>   We do the same thing but in a very complicated way.
>
> - When the system-wide preserve happens, the hugetlb subsystem gets a
>   callback to serialize. It converts its runtime global state to
>   serialized state since now it knows no more FDs will be added.
>
>   With the new API, this doesn't need to be done since each FD prepare
>   already updates serialized state.
>
> - If there are no hugetlb FDs, then the hugetlb subsystem doesn't put
>   anything in LUO. This is same as new API.
>
> - If some hugetlb FDs are not restored after liveupdate and the finish
>   event is triggered, the subsystem gets its finish() handler called and
>   it can free things up.
>
>   I don't get how that would work with the new API.

The new API isn't more complicated; It codifies the common pattern of
"create on first use, destroy on last use" into a reusable helper,
saving each file handler from having to reinvent the same reference
counting and locking scheme. But, as you point out, subsystems provide
more control, specifically they handle full creation/free instead of
relying on file-handlers for that.

> My point is, I see subsystems working perfectly fine here and I don't
> get how the proposed API is any better.
>
> Am I missing something?

No, I don't think you are. Your analysis is correct that this is
achievable with subsystems. The goal of the new API is to make that
specific, common use case simpler.

Pasha

