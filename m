Return-Path: <linux-fsdevel+bounces-57445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74DB2190F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 01:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B02C461DCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C773213AC1;
	Mon, 11 Aug 2025 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa11slbQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3195158DAC;
	Mon, 11 Aug 2025 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954115; cv=none; b=Dz83hYgxC3N7cYDoYr+PQ5Ilmj/qTZ2J5vxQCxtBpM08enRZOrq7nq5aCC2HpfoqqQiXAttQE/RtsQXmW2nPlfMZ/KSEghs33jY0uikvhhQmAIEQKhy476dAW9Wa3yJUPfbY0uvGHutWJgo0dUKWaHXoP1J6V29K7HHEmdNJ7/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954115; c=relaxed/simple;
	bh=lqHregKkdWycKOTQnCw5rLyaGSV1Cm2ndgfKxFmsV/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFKBjcuG4etiz7Ra59zRz3zaBkTfr3Dj9OmgpCU1W0nNWS9ev1lQ4m1/bEkilGKgeK/xhb1FgkLEh+gAQ09fiOyc6komR5k0KXtjHoGLcPLODAcjl5jR6K8yn1+huvSlZNby7tW26FqW0VruWAr6T4QYovs5gvvuutbapVgDpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa11slbQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76bde897110so3950537b3a.3;
        Mon, 11 Aug 2025 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754954113; x=1755558913; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WTkp5HBq7+cYLzP9grKqIkwbrTAXkZVfrq7VgOeO6Y=;
        b=Aa11slbQOiTTyC5poa09xFoaMNMQ6pAjAO7NGSFz7Eni1OVW3ft9FJIrDdxyI5Scbn
         bDn0B3cf6hPC0rpn2GEwerBkecNzecx2Ar3vBBaF5MlP1cMMurI6Uyc1NKz5Om1bF2p4
         ldkPRejhjJHbxKU1fbApNzi0090+MnkUIfngFYxRBPKxajhKPId8dmsM2exS8JCLVJ9n
         m+OHqKNC+FECvvub+fmOyuVdwmhWSDEtKlccDwOD7IOlZPb6HuEMC+MXd2CzngbeWjUr
         wbdhym0DthIscwCMJnIkUJJF8HtLgO1ZWzVxw11xUYxW+yrbL/IUSy5fOytFQ15GqCx4
         P4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754954113; x=1755558913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WTkp5HBq7+cYLzP9grKqIkwbrTAXkZVfrq7VgOeO6Y=;
        b=b2LylCvTZ1GUhvBMPOHYsmInjbCPzT9Yr1+kF3IN1ie09CVd75PwKlor1IiM6qcKZI
         LvZhB8S1U2gyMbd09tvqnWZR6X+SEi75IMdQnFce6ip0ZQGioYvka57TRvteoVcbtJSD
         CvzV0+06RDYsP3IWJcbYqHqfONxK/tRGST26GCmcNHjq9/xZNXPY3I78BHdJ5lWc7Kn1
         M5YCzBTmhhtbFxZZ/bKKgMY+7CKZj4RXegZZvMzDTw7zmgAvh0T+B7VHv+nJ+V5FNo3Q
         BRrSJBc+9LiuuwTlOx25uPpvl70GIQQhBYQ7uuJjQ5rxS5gFMQVzSkbNwVZlrJzSBGtJ
         6vrQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4ZVFEi25FP+n4Xlz3N+4amqXVV7vJHzo8l6olr8ZTeP+/mSGTQTETkBr8MBfEWHwt174tY1EzXqTUqvmKeoPn@vger.kernel.org, AJvYcCVZKmazCpo0gO5cH6E86ws+x3z/tyOvYCyHhb0jocfUYQFfbq4CHxHv8MepscWwDPMjd7UB+MMZB6vZwFGv@vger.kernel.org, AJvYcCW9tZZeABTofqpLUBwaPS/WutZNc5jAcAlN6OgGnhe/FIIsMnxzxwSzKes5RbQ27InP5SlXAS/byTd78k03@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmyjbe3fuNqeRnvhOGw/0M+JwVVRthtyHMarTnM/vUqSPeo9xF
	dNduo7sDyGL8Y4cH6C8YTe61lX5MP1FUgDyMgPv9KMd7s+9EVuTl+FN5exZU246Tyh7RxJtFK/A
	PgL1OcCA4gKUMcs+++DZyCqf+/Ai2EHA=
X-Gm-Gg: ASbGncsNJomm3Q878USV9pitPQREcn7HCxRl1nbftDYJZQeCEsABpPMWLwEb4UhrVef
	GpUlTeaIu7exoV34eAQYovE4kYBFLnXYjOvxdqqM7MWzLagaIJ0IDk5kpIxo1Rsaf7OIfJt5r+m
	gWG7Zk3plMi3GaGyJAnOCEz5i2E3J2x/BCQU47pkCxrB3VOZmF69YGXEGPhv+UL3zXdSTfUhDNn
	wCJXnjbmBAicBLlrHznVOM=
X-Google-Smtp-Source: AGHT+IHr1K/yJjlq6Ye1Sy8M8F+wQq/Rw7tGlOYrfGgCsGUOTDbj0Iu2trznQNcP3D2ebbnUU2V5lVrfGLyj6GAmXLg=
X-Received: by 2002:a05:6a20:3944:b0:23f:fbb1:c21b with SMTP id
 adf61e73a8af0-24055046d01mr24530175637.17.1754954113102; Mon, 11 Aug 2025
 16:15:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808152850.2580887-1-surenb@google.com> <20250808152850.2580887-4-surenb@google.com>
In-Reply-To: <20250808152850.2580887-4-surenb@google.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 11 Aug 2025 16:14:58 -0700
X-Gm-Features: Ac12FXwQt_eww5uvpy4ERMVpxcDuQGrIx4kEQc7H4eeLVmpPLimhRUNjaij0L4k
Message-ID: <CAEf4BzaRgFid5WDsNGOzE=ysc6jPcSAmB0MwRHYdtSbm-vLrWQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, david@redhat.com, vbabka@suse.cz, 
	peterx@redhat.com, jannh@google.com, hannes@cmpxchg.org, mhocko@kernel.org, 
	paulmck@kernel.org, shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org, 
	josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net, 
	willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, SeongJae Park <sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 8, 2025 at 8:29=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> contended, we fall back to mmap_lock but take it only momentarily
> to lock the vma and release the mmap_lock. In a very unlikely case
> of vm_refcnt overflow, this fall back path will fail and ioctl is
> done under mmap_lock protection.
>
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: SeongJae Park <sj@kernel.org>
> ---
>  fs/proc/task_mmu.c | 103 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 85 insertions(+), 18 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

