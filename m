Return-Path: <linux-fsdevel+bounces-11795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7478D8572E8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 01:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0620C1F216CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Feb 2024 00:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874E4134A6;
	Fri, 16 Feb 2024 00:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="oprrFOsq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B435134A0
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Feb 2024 00:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044737; cv=none; b=dtZbdT/6Zsv2m5358AQQ+hRxNAaqtacqwXFwDZwQGNPctsui3Bo4FFwDBcZcGyzSPxsZtcRB0ec7KEZNA/2Fp338680t54f2whPr+QdYscAFad8BAkxNrED6j/85H7GSOXdeFFqxrbTCruA3jtEDrkqTuhODxiPQpRJuwIHimL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044737; c=relaxed/simple;
	bh=2xy53qgS2iJInA/5BDMVhpj6cwRaWAAd3dI3MMe55Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMdE7SKwaDDDDZa/yIDpbSP7t0QJqSJ0afqZG2fEM3W4jBY6zIkv891zhJUX2XpITLYC8UkS2SQh5HBrVDvls/KVsQssw22QcFTJtT+fR7Igh6f2DTCaY1U8rttFzxb6HLqRe+fy0Rhj/NnnIgXizDIYwcra5k0wRWF16Jb+Sic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=oprrFOsq; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso1580258276.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Feb 2024 16:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1708044734; x=1708649534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xy53qgS2iJInA/5BDMVhpj6cwRaWAAd3dI3MMe55Gw=;
        b=oprrFOsqJykOmX8zng1ggw/imPDsjP6LsR952+nWuOFcMP55GT6qRXSMZ7iao+wvx3
         WyWo8YOFsZFcykfBc1fpkddIvOIefHY1ew5KhnSwVRbl0cuQLLSe2hdNkrClwNbFQdVz
         ZLLHM901XdhT4Wg0hIMGbVvRCJ7bKVT3BqIkl0n5fsUs2C3jqqmp3uhy74PniTQ/fnB4
         09z3O1C7oi7SXImOFm4B0yvnXfwRFQgvrfLhybhp6hzEyv9sucLkYc3h2hQ7+5nYH3RQ
         xYNOPi4ApnHeUeQNFx/EtYkBrvJMgwZCb+L5Hneoiu4xvljcPp8wH4LVfLea0q6ClKQx
         pMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044734; x=1708649534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xy53qgS2iJInA/5BDMVhpj6cwRaWAAd3dI3MMe55Gw=;
        b=FxqV/NCCx9BrrNjzHDacyAMJl5Hk+0CdCQ1+WlH48Xpns8OB83gB9Eb0Kt0yVdkYCs
         Zr3wl/dMzncB3AQHCqETiM4YhZC+8DNje5O3U8n+dngT+PYq1naZkiKKkHY7s4oTmCVf
         x7gzTwS1RsONFJEvA7Em2+VOAF9WDZ9gmFJknYpNzf5rTGT1Am7GotH17AgSwJcKllEP
         9HDSjnr7X7NAQnKgRHFZ/h4mH5jv7K3ANViQvhgJ2hLv6TmOib6Zm6geysUcd+fqjMvh
         LK7LmHwKxmq8WKOOiJQiDSO0lxSw6YEoW5DmHnM3o2IfVTqFxP22NeTITcjpomLSUuYy
         3kOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa6fRmHMXS5ZFroR59ndASoLd2ozOPCt7oLI+llaKvov3rsGL0uQwSflMCDsfIHJReFcLYrY9tG58fhl04pk/HhoV4G+YmGp+I67Qh8A==
X-Gm-Message-State: AOJu0YxqjK+fGXsCVnX7x8mIQNZQS4Z9JgoJkQQRz3+ZLNOdz1BtfuQb
	9ins3T5F59nUa1OJtc7WjdtdSFQyYK4OReXL7Ezji2hvO3Uhoaq3+KvT8zol48bdU6l/RiofvSW
	qava1yw2dEmnqxqLqTWH9bbMGKAu1K0zZmt978Q==
X-Google-Smtp-Source: AGHT+IF9ZHlLR5v29XCimN/Xs8jNPLkvB/7wYRz01k7De6cwDyVRO4dJIc/6HTgOV7JHuNofEVjinUHjv2Bb5KdehIA=
X-Received: by 2002:a25:ae85:0:b0:dc7:4671:8ae8 with SMTP id
 b5-20020a25ae85000000b00dc746718ae8mr2779603ybj.65.1708044734239; Thu, 15 Feb
 2024 16:52:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214225741.403783-1-souravpanda@google.com>
 <20240214225741.403783-2-souravpanda@google.com> <20240215161441.c8a2350a61f6929c0dbe9e7b@linux-foundation.org>
 <CAJuCfpHF=yxV9+=pUo+5DwSjvF=r2y7A9_8LHsUGUSoP7EUNXA@mail.gmail.com>
In-Reply-To: <CAJuCfpHF=yxV9+=pUo+5DwSjvF=r2y7A9_8LHsUGUSoP7EUNXA@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 15 Feb 2024 19:51:37 -0500
Message-ID: <CA+CK2bDH9E_nHs4FVYxuOUcddL_asOTTXHJd1FuVmGfEGNeZXw@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] mm: report per-page metadata information
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Sourav Panda <souravpanda@google.com>, corbet@lwn.net, 
	gregkh@linuxfoundation.org, rafael@kernel.org, mike.kravetz@oracle.com, 
	muchun.song@linux.dev, rppt@kernel.org, david@redhat.com, 
	rdunlap@infradead.org, chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, 
	tomas.mudrunka@gmail.com, bhelgaas@google.com, ivan@cloudflare.com, 
	yosryahmed@google.com, hannes@cmpxchg.org, shakeelb@google.com, 
	kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com, 
	adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org, 
	weixugc@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:40=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Feb 15, 2024 at 4:14=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 14 Feb 2024 14:57:40 -0800 Sourav Panda <souravpanda@google.com=
> wrote:
> >
> > > Adds two new per-node fields, namely nr_memmap and nr_memmap_boot,
> > > to /sys/devices/system/node/nodeN/vmstat and a global Memmap field
> > > to /proc/meminfo. This information can be used by users to see how
> > > much memory is being used by per-page metadata, which can vary
> > > depending on build configuration, machine architecture, and system
> > > use.
> >
> > Would this information be available by the proposed memory
> > allocation profiling?
>
> Well, not without jumping through the hoops. You would need to find
> the places in the source code where all this matadata is allocated and
> find the appropriate records inside /proc/allocinfo file.

Another difference is that memory allocation profiling does not report
memblock allocated memory, this patch reports the amount of per-page
metadata allocated by the memblock allocator in addition to various
paths that are used to allocate per-page metdata after the buddy
allocator is initialized. Also, the memory profiling has page_ext
overhead, so it is not practical to unconditionally enable it
throughout the fleet.

Pasha

