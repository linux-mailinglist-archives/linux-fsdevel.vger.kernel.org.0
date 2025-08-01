Return-Path: <linux-fsdevel+bounces-56499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5CBB17BD1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 06:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1024D7A5F8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 04:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4641E9B1A;
	Fri,  1 Aug 2025 04:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dsYncnkw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB81519B4;
	Fri,  1 Aug 2025 04:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754022621; cv=none; b=B9s5m81lKa712iJoZHnktauw8SQvtGflwDUA3+mhWaq971q2KZK7wLQ36dpBS8anZV2DnhQhksY70OfitvrKxGt1arix+9WIiZRNNYQeTTHObnaPgoZjERQsXhNbYgLl26MqmR9jno3e/BhhbTYCnMyOI0JyLwAjOcGHw0O3uvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754022621; c=relaxed/simple;
	bh=piYJV8Y4LjN/W8XtRqLL1KO0JAveKpssg3VbBT7bOd4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=rZ/eZUqmsDmEzzfLHgAMUYR54CH3d7naz9lE+0lXFdQRXcbfDhAbqutVUmDQs0Eefd/3igcPOasNDJ3PjmUS7mB3pGuT+fC8Wg+TrCxhA6QqNot4X+8tAG00dOlbzTfEPr5Rh5e+s/8jxZAHYsekwfUgfR5oTA16v6YvaCi9FyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dsYncnkw; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b271f3ae786so1395982a12.3;
        Thu, 31 Jul 2025 21:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754022619; x=1754627419; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=piYJV8Y4LjN/W8XtRqLL1KO0JAveKpssg3VbBT7bOd4=;
        b=dsYncnkwJH0c3pkrIwmpq9HPZq5KVs0oSvMx0YjmSsNWzOu5pC7HzgLFgZhC/dXyt8
         7VZq1COcBjdImXlVRFqwhiryoQDqylykTC8iVB9kq9ZlTXhbvNI1Kkr7vIhgxvF0HUhB
         0P/gk8EaG4SB/rbyU5TDLrEFN2Ph6XFa5k80j6APE+G3LUDrfRoSR62SrU0TjJRRKHXo
         vpfjdTkp+gzIaFGIbxYwD8kxtkgLSWXuI9ikLytyUEa0xtvXi5bf5qVeH/tPc3XWzA65
         j0lgV4BbaDSSZYNQhVz202sJLAuuVzk9y2XH4eB2CCqSvNOlNHw3GzZRfY6Q0X/mm7dt
         PXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754022619; x=1754627419;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piYJV8Y4LjN/W8XtRqLL1KO0JAveKpssg3VbBT7bOd4=;
        b=o4/oeZ4t5lt1bUg7K9/NscfPIptqCNmxuVqGT+PKrddIQPR5vmRNBjehh0lRMHttvq
         j24gMrAjv5v1huFk21amcoa7m3kROM8S9DYW/RlQ5LPlyB5xIqpF/8SLVV19AOaIjw4a
         5FltlnpwFRxB9PJm2DLdXQ7E2DU33Zz0UFOVHjhfkROArR736AcuHapwQ2m65fX/l/ce
         oGb760kA0IZ/X9i4Jo7EhH0j4+YaiaH+TBVO/r0wyIfzn56cWO24c1TnJ8lJR7arqblA
         DDoluDTJ0VzLwqc4LjAHmiI6lb3jUMPyRMEQmY2evy6Y79KgVOgMBV2D3iXMAWymzPQ0
         EQTA==
X-Forwarded-Encrypted: i=1; AJvYcCWUpP2dd2Xw9be9xKLMCAVbi6Sw1EI5Hg6M1GjmB4dDQrtggZiME7RFXs47bVdZwdcRgngyrSlpb3VdfOaW2A==@vger.kernel.org, AJvYcCXOQSFrc7eqAdSqN+0PjDA8lkWiCHgUwmBLkIZh3P2ecgJ0tLdByvqm77I+i7J8aKccFzH23OAQctGqMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD9SOuSGvP5QIMBr0cnE5jAYMigTN3VNsvR7+scSp0A1iX86q+
	xZ4LmOyqbrZTzw/J0uYlQ80LRH621hE4Llsxo0vM6Tf8iH98B9KNjKfuZrNcfg==
X-Gm-Gg: ASbGncugpS2v+QRsYgVWU27MXwYjSX6XcbDlY1xiM2+MOCR+NUUz7SZRxJdJ29YvTXR
	i/YBOYDjYZ2UTZWmFObpWbPxo5XnztZAmEqM2C0Jo8nFjmu89/+lWadyNEsCkcFZMKqxQ7SfBcO
	EE166BPKm6zapBGZ5TLWKSjz9Y0cHGjfCIZ5HVwPv0uWBRenPDoN06jpmF/9sgWRM/e8UBqE0p5
	Lc30KYveIU1m5JCqTt7jLO5eVaRc2RSQKVQ/aMb/9ROd0mMh2fiJKYRdC2FtgOZDLKPBstYmH/7
	7+7pi3bdc0WjYLFaKdliaSzonJjqrceLFlXzDZV2OkdvB5xxpfG1kJOwPKt1rCA8jgBTTCxeuKf
	Rcn/8ouDeQRCeLr0=
X-Google-Smtp-Source: AGHT+IHsBcZ7jbf88T/H26yKkIr5RGXZAEkQ0zGeJsJopMViNuzkuMhxbnUjM/2qC4wMrVQtn4dP+A==
X-Received: by 2002:a05:6a20:12d1:b0:21f:a6c9:34d with SMTP id adf61e73a8af0-23dc0cf620fmr14523968637.1.1754022619024;
        Thu, 31 Jul 2025 21:30:19 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce8fa92sm2999321b3a.45.2025.07.31.21.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 21:30:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Suren Baghdasaryan <surenb@google.com>, Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, gost.dev@samsung.com, kernel@pankajraghav.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [RFC v2 2/4] mm: add static huge zero folio
In-Reply-To: <20250724145001.487878-3-kernel@pankajraghav.com>
Date: Fri, 01 Aug 2025 09:53:56 +0530
Message-ID: <87tt2rr7oj.fsf@gmail.com>
References: <20250724145001.487878-1-kernel@pankajraghav.com> <20250724145001.487878-3-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> writes:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
>
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of single bvec.
>
> This concern was raised during the review of adding LBS support to
> XFS[1][2].
>
> Usually huge_zero_folio is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left. At moment,
> huge_zero_folio infrastructure refcount is tied to the process lifetime
> that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive. And, one of the main point that came during discussion
> is to have something bigger than zero page as a drop-in replacement.
>
> Add a config option STATIC_HUGE_ZERO_FOLIO that will always allocate
> the huge_zero_folio, and it will never drop the reference. This makes
> using the huge_zero_folio without having to pass any mm struct and does
> not tie the lifetime of the zero folio to anything, making it a drop-in
> replacement for ZERO_PAGE.
>
> If STATIC_HUGE_ZERO_FOLIO config option is enabled, then
> mm_get_huge_zero_folio() will simply return this page instead of
> dynamically allocating a new PMD page.
>
> This option can waste memory in small systems or systems with 64k base
> page size. So make it an opt-in and also add an option from individual
> architecture so that we don't enable this feature for larger base page
> size systems.

Can you please help me understand why will there be memory waste with
64k base pagesize, if this feature gets enabled?

Is it because systems with 64k base pagsize can have a much larger PMD
size then 2M and hence this static huge folio won't really get used?

Just want to understand this better. On Power with Radix MMU, PMD size
is still 2M, but with Hash it can be 16M.
So I was considering if we should enable this with Radix. Hence the ask
to better understand this.

-ritesh

