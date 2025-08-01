Return-Path: <linux-fsdevel+bounces-56498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474E2B17BC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 06:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F915A6197
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 04:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE621EA7E1;
	Fri,  1 Aug 2025 04:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4BDHeZ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027DB80B;
	Fri,  1 Aug 2025 04:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022229; cv=none; b=qWYtrn+Kv5iEGZR6h2G1Nc0kPRjC/LwYGbX+ixvL9O1VYQx3UWPLItF07FUcuIwNDYl9/pXv/4S5fMGQHmQcsFUlPpdX++qYhykTbuUxCWrEGn0hWu9DzjY6eMpSndeuRB/bVXGTVsJpUOwku427Eo3FPUjzbit8mAhel9G3uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022229; c=relaxed/simple;
	bh=jBgOLIUY3EkUVGIgWztwk/fefH7v1CGKX1hl/rS9vus=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=p0Xne28gh4Eiv67Up/p69ttBk+EEXkmmYNY0j+sNJ0DcupkNX5ocI8Db2FejyRiIXZElkOSAVCBpfcEhYbtuF2YJXFhWUXtinb1V74vS3+PBXLzF71eVrDBldVFr9sHY6TrVogeHll7N5vjVJti3PpEbLg3VJyGbcmWfDiPdVeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4BDHeZ3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so590095b3a.2;
        Thu, 31 Jul 2025 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754022227; x=1754627027; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FNFG0goKRFNn6WAYQtw0Gyc6OtTnvSZYrWlxnJqfeJg=;
        b=U4BDHeZ3d8FUwiPkbkSD9K+og8pKAOWyMEjnCBBKMGf7SfbDqALaRqhrEU5Rd0k5BH
         ATdc+860qqCbHXfHhRxYKHCTm9sVoie+BzvvOAjx/UPCLIEKKVeEfuF5NUXQuHXl94mV
         6Iba2WAX2nuIY9S70lTqiUy4Rc4UZXuIZU06kyvcp4G7rzq9bpIknhFoewki8xmxqndG
         WGhgX5iG97IuFgDF/EVDrSPQZeF4WYbbdYY8VrPWiHtfdpZO0xp7Vzolv+eeOZJU/uSM
         3NsYo1YecMtGbs+/Lq7jB008Ne9o2iZSco6dLYh1yoCr2Cn0B86ohThlxrFc+D/bNI+N
         sjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022227; x=1754627027;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FNFG0goKRFNn6WAYQtw0Gyc6OtTnvSZYrWlxnJqfeJg=;
        b=QXR2i/0PTwJUVw61+BSumjVfhJcz4m1b0AEIGEa4t6mnLJ4jSKQck7HfzygY5Qfy09
         ixVOYIRfXpF3zMQj5zVAw1uRlFLLENWyPo5JtD69Bw/c10xMVXUk8IAIpuWAcJE3VYbu
         tD8cqsfhSgHdABRML0iod7cXuvYsEBaCAlK4tTEv/gh65AKQAeCbdFCwy6cmVoi0i7+R
         HneZod83SHznQXjwqYmVshNc3NGdp9b+PrniJMJJps3n4o1z62J95H9e6S6P7S5p7keg
         IfN6XckDymfx5rdhq12ku9lC1r9VeHtqbLGoe8DcYyy3NgjX3t+nyf8wjR0T4GqYgLCI
         rntQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKGpor8olxouuryVgvKgv5/Rt91QwHU42WQnUYZyVA1qw6njasGbN7YPkFnH7ZeviIqqheIJUy/uRMuA==@vger.kernel.org, AJvYcCWE+6/pFoAMin+Kw2s5u5AFt5IhqWw8Ab4qAi0WNOW0uQOgKv9sJlLtEpegseEDrpkWyBr5C2YrTBbC8bggzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfg2aHjj0y4g1O4on0c+cb3aUlgLcfIYhcR0/qw0WDOSyx7V26
	GdizxQ1DKJiIPEnzfybws34ZTYPrQ2mJa0HFjOVL9XdXMG7XBVI82391
X-Gm-Gg: ASbGncvwi7NbsfOpE9VHC2+O70khZacX789td6utH5x2U3GuQyNZtNennZwqllP9HYb
	pfIPalUBxnITr0+q7dl7zpM1GrF/PVeZTQ8Asr5Dtbvbe6B+bLf8PknxauyIXgpC/qsC8Fiw+Qn
	VZnE7tKWI5/b8rCpxpADNicsvrNSOj47yM+i5qeEqephCIs4ytg90hmUw7S2KMOYooZOuhXJ1Jm
	91s7r/r0zbuSiYaT8/NxkgnU3G22z3/Dc8UJBnSAYfYwUiRBDOv2mqT2k9RjyF1m/huyLPM6CDq
	IMXNCEvR3gzn+AZjIrJM8tbOm8JyrI/0E6N3lpRVtGIHnOfO1NTGCXfdlJ9rAtwRA2GIg3ghyYz
	4aqq4gEcILL72lc8=
X-Google-Smtp-Source: AGHT+IFYpTrv1dKIphQdIwKL1PvNWrKjfBnLAZqwJKaFm7GvpRXCHXO9Ik+FatBqLwjSU63HnQ9A9A==
X-Received: by 2002:a05:6a21:9998:b0:220:4750:1fb1 with SMTP id adf61e73a8af0-23dc0d0444emr17449915637.4.1754022227221;
        Thu, 31 Jul 2025 21:23:47 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8f800sm2922802b3a.42.2025.07.31.21.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:23:46 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 1/4] mm: rename huge_zero_page_shrinker to huge_zero_folio_shrinker
In-Reply-To: <20250724145001.487878-2-kernel@pankajraghav.com>
Date: Fri, 01 Aug 2025 09:48:18 +0530
Message-ID: <87v7n7r7xx.fsf@gmail.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com> <20250724145001.487878-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> As we already moved from exposing huge_zero_page to huge_zero_folio,
> change the name of the shrinker to reflect that.
>

Why not change get_huge_zero_page() to get_huge_zero_folio() too, for
consistent naming?

> No functional changes.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  mm/huge_memory.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

-ritesh

