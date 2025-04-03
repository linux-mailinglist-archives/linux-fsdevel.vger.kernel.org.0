Return-Path: <linux-fsdevel+bounces-45616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5FAA79F8E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 11:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DAE03B23FF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554252459D8;
	Thu,  3 Apr 2025 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DXV6Yn3+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49362451F0
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670793; cv=none; b=t4Gwqlldg9m+3yty6XB8cMQiJ2Ez6DKtOzm+oFpFzGR7Ho+WdP4TfNSNrxPwoQP1xafW0UN7QWlPtE1Ta2K3g9XwjA/GRRYFs5vhM9u2gxk4mtQHpL2sS3484NKcQqL8RLMrjsceS4gR8nkOuV+FE04S6ZpvvlKS0ybi8CARelU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670793; c=relaxed/simple;
	bh=mGUq16/UmGEEMYrIY2tCZfZXSIRhMmrpOz9HB+k/VcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5lgnFYmokppZXXfIkIwcoUdxkp70/jgz9Ic6cYK2UvIixQ35YJv68xJ+3Swf7byJoJ10jfHN6/1q5MeRxlqYm6WdEk1g2G5AAwFgEXmQVVsgO6ytsn6y5YmmyQHFg41GeSH95Wu9Nvrw4uZKgutCPgM4Ifm9wBaykYh8xCQz9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DXV6Yn3+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so147054f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 01:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1743670790; x=1744275590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ICyC3s+pJ3fIMtUsu9o7pDmgGeOfPEFH4SmR3vdTuEY=;
        b=DXV6Yn3+5S0ihm7HYWBo6LFOlRmBONcNjHz37fbA5B+9HOzwUgILrSBqkb0xSwcToA
         5zkid2oWr0MBjJnt4v7QTmKiRcG9b4W7baVLFIa6HthbZ87/+xOBjTT4OLSGts8InM4a
         3cDlxfHlezx4895cqH7hI1+POYSNkdyrSyCuCzJhsz5+LQzMI625FtOiab7CZAbJ0Wa5
         DSIc0aqhij7k4BHQopLFTtrSVMRnHj4/79G7QAcl/FUknd/9I8KsmT5BS9aNqKt1EYdn
         O74YGGrrieXh61xjpuffq9Emd2Xm9j5OoDSQQmqZHWpnvh8HMA313ZBOoedJYUW4wIoL
         1cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670790; x=1744275590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICyC3s+pJ3fIMtUsu9o7pDmgGeOfPEFH4SmR3vdTuEY=;
        b=tOeEM8Mmi1mSREycNrj6VxKLl+Cdr89mpHtrAOLDqZOJ1RHXngBq7shT9pXKfDpH+r
         2BlLhvjZlujnsnSm80NLpRorLBYxvEOr/s9ptgDCW8UMvXc7991qRXW5OaDRiGghCHwi
         n4qaDCWqk3a2kN9FG08ksYcA1u0qM/WaGNe97sJuaNstY1iHnpv1bL/ozk1wrcBln6bM
         FcnmbsV7Ism61hilr5/x3z//WDydk5r9ibTM1TzScJ9x38UpGx47544M6MnKyNE/sDtw
         cirnwQxCuTTM07WWBruo6sbGtgvTov+6uV6TJyB6vFmt0hdzU3qIOkkg+J0XyJu/sIRc
         h1Og==
X-Forwarded-Encrypted: i=1; AJvYcCWuHxKj0GeDRVbgKSVSbaBYn/UmBoOvAE3B//v3Z5QVK+a7utVSPJe3IxAwZh1HZXh1O/we1wpx7OLu+nAZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP9vpCe7qGcJHTzgV1Zt1Q2Hdg+oOJWs7ATSs04Vb8TbGGrMk
	Kp2gV3lEJcZ/IR022/fDlOfrkY1oUkDp8sqR9ihWW7UrpyF/L+YBWDLlD7TdgOE=
X-Gm-Gg: ASbGncu/K3vU33/8VDSJfjUFGhIvAfSjvFUEk/zcpTcmLVdHHwW4dIla3M0iom+sFiL
	CiUPcp0tlws5gu3nQ4H2epuQxbHIbKjY0swRayzmAWpGscm6nuC+Tgm41fcouDLkrdZ2ui9W57b
	/CWOI2mGadcU/euAzfZEIepnC7bKK10VrsCAfdut6TGFrhUk3e66dnjd0UYIqwR1fJrboWw8XX+
	Eu/tPCXWEorwklKEtqFHKuDv7MMiGlcK0VNfO7pBx0L0E+P9hWPgl+6T6BcispzZyXh2uIVxdD0
	UiSIv1P2Id6k5qb1oc7tpuV2QxQmvr13GhP0Ep8W3eA5Zf/aR34w4YE=
X-Google-Smtp-Source: AGHT+IF6/cKhg/tRYLRyYy0gd6WLgBem2gk7vTyRY7tWsUc2r/1wFw8LOKnBmlJm7eilsE2eyynOmQ==
X-Received: by 2002:adf:f40d:0:b0:391:49f6:dad4 with SMTP id ffacd0b85a97d-39c2f945f61mr1028102f8f.41.1743670789943;
        Thu, 03 Apr 2025 01:59:49 -0700 (PDT)
Received: from localhost (109-81-82-69.rct.o2.cz. [109.81.82.69])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c30226dfesm1199443f8f.97.2025.04.03.01.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:49 -0700 (PDT)
Date: Thu, 3 Apr 2025 10:59:48 +0200
From: Michal Hocko <mhocko@suse.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Shakeel Butt <shakeel.butt@linux.dev>,
	Dave Chinner <david@fromorbit.com>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <Z-5OBJrdjDBj_nrr@tiehlicka>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <ad7b308e-64aa-4bd4-be1c-fbcdd02a0f10@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7b308e-64aa-4bd4-be1c-fbcdd02a0f10@suse.cz>

On Thu 03-04-25 10:24:56, Vlastimil Babka wrote:
[...]
> - to replace xlog_kvmalloc(), we need to deal with kvmalloc() passing
> VM_ALLOW_HUGE_VMAP, so we don't end up with GFP_KERNEL huge allocation
> anyway (in practice maybe it wouldn't happen because "size >= PMD_SIZE"
> required for the huge vmalloc is never true for current xlog_kvmalloc()
> users but dunno if we can rely on that).

I would just make that its own patch. Ideally with some numbers showing
there are code paths benefiting from the change.

> Maybe it's a bad idea to use VM_ALLOW_HUGE_VMAP in kvmalloc() anyway? Since
> we're in a vmalloc fallback which means the huge allocations failed anyway
> for the kmalloc() part. Maybe there's some grey area where it makes sense,
> with size much larger than PMD_SIZE, e.g. exceeding MAX_PAGE_ORDER where we
> can't kmalloc() anyway so at least try to assemble the allocation from huge
> vmalloc. Maybe tie it to such a size check, or require __GFP_RETRY_MAYFAIL
> to activate VM_ALLOW_HUGE_VMAP?

We didn't have that initially. 9becb6889130 ("kvmalloc: use vmalloc_huge
for vmalloc allocations") has added it. I thought large allocations are
very optimistic (ie. NOWAIT like) but that doesn't seem to be the case.

As said above, I would just change that after we have any numbers to
support the removal.

> - we're still not addressing the original issue of high kcompactd activity,
> but maybe the answer is that it needs to be investigated more (why deferred
> compaction doesn't limit it) instead of trying to suppress it from kvmalloc()

yes this seems like something that should be investigated on the
compaction side.

Thanks!

-- 
Michal Hocko
SUSE Labs

