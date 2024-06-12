Return-Path: <linux-fsdevel+bounces-21554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB7C905A42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 19:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8CDB2818BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866D61822E3;
	Wed, 12 Jun 2024 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="ufG+kSfE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EF316E895
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718214839; cv=none; b=LaRxcard7VQAShWUDQ68cGaen4PW7j71turP6ZOk3ZIEhlNBQJMFobk3M21iKYfuYzzu/ve+QCJFPHe2aQkMpmte705ZuQzG2/RphGD1GMRgQF0a/l2qREHMm6YwFIao1RQHDHZhAoPLvOnWeQcig5zeBhI0U1Gq/3ixNxwbcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718214839; c=relaxed/simple;
	bh=u2QoEwLJoX/vQ0Ubqa8Zd52sVn8RpYKvHli5EjglEuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ct/Wt/XXn3JCd9l0c3lG4KD9j8yYvafxe1/IU5oYvHc1MtR4NHEacdCih2ga4v5V6J2cWyVEj3/q862o+cYB5Su/T3e/o3JJ9u7/ebGrEgnRUn+khFiLhBk9z+MpEGZP92dB/U2Lr9N3Y/k4eG5VyTX5q4CTCm4gPHHvhApFLdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=ufG+kSfE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-44055ca3103so451211cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jun 2024 10:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1718214837; x=1718819637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMgLKSW0t1aEhKWe+AkntdQhxYy02qeLrR+2holCnSM=;
        b=ufG+kSfEBw2fv7uVH5tUqE4lo+dDlyN2LtlFRWqc0GYwUQW1slxI2/ABNNX/UThDNM
         zkkJYX2k+rHZZEjCAikFNW3uDbONbe+ahukKbcRUkf99Nuy86VE8ye7hsvuIIJCw2qQx
         Oj6slwXOHVt6GcdU/GCPTINP3UwNFU9z9SNmozsf8XIKUMB4vPbam5VRGyYZRZnYpe3U
         iWeR5kdpBfb/swvSlwzFyhppdN2lIWzVOgU6MQiixj/37ZEc5XlGZKeSEUF9xrqYxIO5
         BGoM72HYD2lNzhq/FEMCVmIupdPrS0X6g1uQtZ5p8GjyW8P8wWzvkFiWfcM2NnCdGDp1
         TBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718214837; x=1718819637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMgLKSW0t1aEhKWe+AkntdQhxYy02qeLrR+2holCnSM=;
        b=WGriEPNl7jtugshls6zw1VQRaBq2QWcRxSDNCK4qi+KnIw7xViTMQiEUS4+AJscwRv
         hwfK+NDko5DWqQLDVPVfdibw7hLAIrQmxNhmZzJoQIFgDgP49nipcAti1kCyk0wDG8el
         IFmgqghiHBLY/cnWycijt9rdZXtgKZYRSb5946skkTTqEJw4fnrlQjXZg19IZKRpGEJK
         VRxPVd43hBwukdLeJcbpP6h2JA8WSMrQScyB35O9dTJt+tlSV8RI1fKOMxiCGeDBiHp6
         HkCZezt3wfbqAH01MQ8iFtI0B9OHZvMfnU4WYtFtT+yEQwuX3Yss5xXdbInt4XiyCD8s
         M9ow==
X-Forwarded-Encrypted: i=1; AJvYcCVpTP1TtcaGBU9itJW4m8LoMkOG7FWCuFDZQeHim0ej5L8648s94v4d78boWhLYz/f9fcbnZ5qGRwCNcyGjvPKtFXyJU1sVsTTRFVP88w==
X-Gm-Message-State: AOJu0Yx5xe2MXiECXx6MwQdwkNQBkBu1I8qiosxyCbnvktXGdGJL2t3c
	ym3N1aky0sNobKcN17Lpck8eqq2rrvGMSjSduCARaqS/vbHFAWQRKAxiDJM9Zt7zW9jxmjTAvZp
	WlFcrlpftSyLaap8tpJzvjtrHCEdXGJEkcXBPjg==
X-Google-Smtp-Source: AGHT+IEboSl6cuP7DdeifGdtYnGd5qh7/n6H6xuvUtUtKpoRuNfSrEar8wpjtJrO/8OKTRTzH9jgVk6mIIwRg3sA+rc=
X-Received: by 2002:ac8:5aca:0:b0:441:37b:cd5e with SMTP id
 d75a77b69052e-4415abc6032mr37434341cf.5.1718214837393; Wed, 12 Jun 2024
 10:53:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605222751.1406125-1-souravpanda@google.com> <20240611153003.9f1b701e0ed28b129325128a@linux-foundation.org>
In-Reply-To: <20240611153003.9f1b701e0ed28b129325128a@linux-foundation.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 12 Jun 2024 13:53:20 -0400
Message-ID: <CA+CK2bA75p3LW95i79uiEfkg9AS0cKVfhKZMatHHQfRB4PJFZw@mail.gmail.com>
Subject: Re: [PATCH v13] mm: report per-page metadata information
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Sourav Panda <souravpanda@google.com>, corbet@lwn.net, gregkh@linuxfoundation.org, 
	rafael@kernel.org, mike.kravetz@oracle.com, muchun.song@linux.dev, 
	rppt@kernel.org, david@redhat.com, rdunlap@infradead.org, 
	chenlinxuan@uniontech.com, yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com, 
	bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com, 
	hannes@cmpxchg.org, shakeelb@google.com, kirill.shutemov@linux.intel.com, 
	wangkefeng.wang@huawei.com, adobriyan@gmail.com, vbabka@suse.cz, 
	Liam.Howlett@oracle.com, surenb@google.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, weixugc@google.com, David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 6:30=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed,  5 Jun 2024 22:27:51 +0000 Sourav Panda <souravpanda@google.com> =
wrote:
>
> > Today, we do not have any observability of per-page metadata
> > and how much it takes away from the machine capacity. Thus,
> > we want to describe the amount of memory that is going towards
> > per-page metadata, which can vary depending on build
> > configuration, machine architecture, and system use.
> >
> > This patch adds 2 fields to /proc/vmstat that can used as shown
> > below:
> >
> > Accounting per-page metadata allocated by boot-allocator:
> >       /proc/vmstat:nr_memmap_boot * PAGE_SIZE
> >
> > Accounting per-page metadata allocated by buddy-allocator:
> >       /proc/vmstat:nr_memmap * PAGE_SIZE
> >
> > Accounting total Perpage metadata allocated on the machine:
> >       (/proc/vmstat:nr_memmap_boot +
> >        /proc/vmstat:nr_memmap) * PAGE_SIZE
>
> Under what circumstances do these change?  Only hotplug?

Currently, there are several reasons these numbers can change during runtim=
e:

1. Memory hotplug/hotremove
2. Adding/Removing hugetlb pages with vmemmap optimization
3. Adding/Removing Device DAX with vmemmap optimization.

>
> It's nasty, but would it be sufficient to simply emit these numbers
> into dmesg when they change?

These numbers should really be part of /proc/vmstat in order to
provide an interface for determining the system memory overhead.

Pasha

