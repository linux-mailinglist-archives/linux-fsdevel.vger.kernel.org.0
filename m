Return-Path: <linux-fsdevel+bounces-9101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F083383E303
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 21:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCBD2875E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063122626;
	Fri, 26 Jan 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YMWxv2La"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7322F0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706299252; cv=none; b=Cl85zHDsjBhE1jP0R2cM8ZyH4LBHfY7fx78ec9ulY4+o835bYLzfBIdqOIsKiNI1olHm9m/YeIZ4VdhWJIS4jXwaqL4vvOwM9I5HfimCKKkgU+Ma6hQnoV+YFfJmXXh8L1hUsTgU1owSbXB+ZkTtECDpoo6e8rz/IcMkwEnYqQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706299252; c=relaxed/simple;
	bh=fcxQ3bc2/ycZVVRavVndN2TW1bmrjhqtW752nshgov4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YHD87IkFRKMVMfARFIDVIUpZC1cJEvbPlhV4wUqqVmanmHmWApNAvP464OdjJQQXQgdhA0+146g/Gz/VJUU+AEqh5nznPlQ39G2uvXMk1hjmkMwQATiy9/hMvO0F5J5S442PK5XLMZkNzgLAqWrfLo3F+8YxGm+gR6nF4tmDFjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YMWxv2La; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d76f1e3e85so22725ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 12:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706299250; x=1706904050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MimXWUdcIvN0nH3+dB3+knWCETvDzwsFYg6Za1niF5A=;
        b=YMWxv2LaOd1dcfqzupCcwMB+CtjBdtFEUGJpYmamncMy6fKsXW0Pu9UsOeA2A0nA7m
         awROwFafV0KwQC4whgnD5xgIlVL6+WIlHXiq8Lg34EpAlTJUqRzYeubb9gEBR4GZzVVD
         V7EkNkJoK2HfHltFPpNivyhioX4CbuUO8mNUOjLtrzKiBSsS/Cy2UZEpA1z4EA1iyNpU
         X0giY/smB78dF2ZLkSBGGu7S35WA1DhtFf/9pZpswzRWDmzt6pmlkpd9X2vXu8E/1Uu7
         BFStjW4ngBX2zwBWlpmFq9ciWL3KFpuov4e/cEuHpwdHruCSMmsInYIoGeTSzomm+0ZW
         Y4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706299250; x=1706904050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MimXWUdcIvN0nH3+dB3+knWCETvDzwsFYg6Za1niF5A=;
        b=Pj4fbWwyACBs1iz7Ov3xyPiMzPzwyQF7sIlnXoCanxyMdRkIuVDKxYYEaUtLjL8Ycy
         pGlkVC9M8YTerkekvrgYrIXNfMRL+T9KrJtl+pBPS0819be6H6DAInGPaYPifa6ZifWp
         eOC6205hgvYv9Zm4wEofQAK5j3yoGX0BJrDX3cv7d4htCgEiDpaccS62Gj9XXSOrXJ/z
         E4+TjTdCUaZRhrpGHw8CPJ09/Pd/U2wiztdWAVAu5OIiNe84+j99y6oLCjg4T9b/jkJa
         l8FcmmT+/QPBAM6lOZuYFEW3mr6+65r4IwbRO9iqyJxRsAVFUPV7RUsCEcgTYvNs6gYj
         uklg==
X-Gm-Message-State: AOJu0YwqiOiouY0hznA/wwHe337l3nolCCVqq/5YCW1yco4ZVDnxA3NV
	MdMaBScBWeLz4AaJYVtU0vm+KrgneopcxwCU15aDJKghgyn/7VR6MeLfXICVSF1zFYCMZaZut70
	NFgLbJc0GtL0nnA83QT79q4J4TIuEyZr6PGXV
X-Google-Smtp-Source: AGHT+IFUiaxxx/fnNfe3njsMipgqF2fdYzG/YBwFDzOMI+2YRba8r80bUR3upqDy6QVJlcre5NJrJ1mYmBGhuhzNf/E=
X-Received: by 2002:a17:903:1246:b0:1d8:a782:6cc2 with SMTP id
 u6-20020a170903124600b001d8a7826cc2mr127996plh.13.1706299249979; Fri, 26 Jan
 2024 12:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125164256.4147-1-alexandru.elisei@arm.com> <20240125164256.4147-12-alexandru.elisei@arm.com>
In-Reply-To: <20240125164256.4147-12-alexandru.elisei@arm.com>
From: Peter Collingbourne <pcc@google.com>
Date: Fri, 26 Jan 2024 12:00:36 -0800
Message-ID: <CAMn1gO6hx7yaFHEYVbkpPocAxQmQc3JBgppcNSJw9SUfyvjwbQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 11/35] mm: Allow an arch to hook into folio
 allocation when VMA is known
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oliver.upton@linux.dev, 
	maz@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, arnd@arndb.de, akpm@linux-foundation.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	mhiramat@kernel.org, rppt@kernel.org, hughd@google.com, steven.price@arm.com, 
	anshuman.khandual@arm.com, vincenzo.frascino@arm.com, david@redhat.com, 
	eugenis@google.com, kcc@google.com, hyesoo.yu@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:43=E2=80=AFAM Alexandru Elisei
<alexandru.elisei@arm.com> wrote:
>
> arm64 uses VM_HIGH_ARCH_0 and VM_HIGH_ARCH_1 for enabling MTE for a VMA.
> When VM_HIGH_ARCH_0, which arm64 renames to VM_MTE, is set for a VMA, and
> the gfp flag __GFP_ZERO is present, the __GFP_ZEROTAGS gfp flag also gets
> set in vma_alloc_zeroed_movable_folio().
>
> Expand this to be more generic by adding an arch hook that modifes the gf=
p
> flags for an allocation when the VMA is known.
>
> Note that __GFP_ZEROTAGS is ignored by the page allocator unless __GFP_ZE=
RO
> is also set; from that point of view, the current behaviour is unchanged,
> even though the arm64 flag is set in more places.  When arm64 will have
> support to reuse the tag storage for data allocation, the uses of the
> __GFP_ZEROTAGS flag will be expanded to instruct the page allocator to tr=
y
> to reserve the corresponding tag storage for the pages being allocated.
>
> The flags returned by arch_calc_vma_gfp() are or'ed with the flags set by
> the caller; this has been done to keep an architecture from modifying the
> flags already set by the core memory management code; this is similar to
> how do_mmap() -> calc_vm_flag_bits() -> arch_calc_vm_flag_bits() has been
> implemented. This can be revisited in the future if there's a need to do
> so.
>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

This patch also needs to update the non-CONFIG_NUMA definition of
vma_alloc_folio in include/linux/gfp.h to call arch_calc_vma_gfp. See:
https://r.android.com/2849146

Peter

