Return-Path: <linux-fsdevel+bounces-52402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4255AE3135
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 19:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3D57A5D7E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jun 2025 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31F21E9B0B;
	Sun, 22 Jun 2025 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ej7Ehh/t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0F5258
	for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750614023; cv=none; b=RGqF7jB/CQmIxxCkq3DVHr5QIrdiOMuMOFqKKtw/gRzzMrH9f5Qb4wdUm4Qhe6D2wdcBOlpYbnSVECjQGFh09QdcGSZjcVkvbQ7qp8r0ql7+kOHUfHki6vVCYQzE9KsdBF8lBPmD15y6Tak/X76IF/W8G1aJX15YLt9veG3h3pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750614023; c=relaxed/simple;
	bh=Vu/cjXBuEzCHpIce+L0jRe+1E1hqsjb10YN0nM4h560=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W8MvkjjJm/FF7y6ODkK0peqzbDRVPEyTRaNtBB0to/O/p7vtr7AzSxk2WLZCD+qd/N/psKjDf7t69g4KtAjOq7uUDO1MCKyOSKO/p728lStmNr62+tLINlPqM2BE+hmq52uXRj/kfjJlm0Zk0MaHJdHjCJUSYvdUJZtthhuabXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ej7Ehh/t; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so6227175a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1750614019; x=1751218819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg9hmyFycp3ZDNw8sLAPP4qprGRUQKA22JNcWYg14/Y=;
        b=ej7Ehh/trWssNZ+jamRNpJbPf9JgQkfVPL2M7pPn9UGVo5VVAbowG2/6slZgEDrma2
         eEL0DIVDdd6IamU2lMKRpKTj0edD691arla6CagEhLCZX0ZDxF5QbOL8DKoxSiEEfJjr
         yp9DIa7VQBmDFXqiKa964wgIV+1G5MdAL5S5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750614019; x=1751218819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg9hmyFycp3ZDNw8sLAPP4qprGRUQKA22JNcWYg14/Y=;
        b=wYYOvW/TUQPngHLjmpWrUKSH4POvSMIJEYgk6ne3LfG95tIMasmMlF/Axq23WappZX
         S6t4PCZhU63h+OED67Gj62KTb6Flyadc/BXCY2VBW9v29PSpgZFp1ShQzjUw+cQjwita
         ZQC4YZSnpnSVkHITateWgga5EuE06cf5KFW9Kc3U4vCoZLajjcaK82Ve3X4NkyxKde7M
         QTZv3ill9DYrQdIczUd4+BX98u/UG5zuerHNsYnPZzU7n3eDXI6EYh3eykAvRHNeRnBw
         nj6wek6HNZ8ebb0wvWL7aO6mJKUHN+DVnebp05q61gQR1hD6FfWvm1YIvvlZFOIPD3Hi
         ju7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvG8Oz0k1UoggnB69H9nkVEBCpwAJ0taObyfSgAnbYKkEeVAG4+fl9wKdtc0mSGIOFLK/IeJBRNPnPZw/n@vger.kernel.org
X-Gm-Message-State: AOJu0YxKuUXRjnXWjEbQmKJqp5X1OL2LPmZuFt/WSkEDVQJS7KAWnhD3
	2sLixZmxJeVMxIv+iM+dRXyCEg5dmNEav/jIAO3s8WsgHPv17HzAKYDfCsYtjT7Azx1j6aEOp+b
	+CywuIJI=
X-Gm-Gg: ASbGncvGUBIRbfQT3xYw7/dZiTLJi1nZDsescLApjP3mJ8S14aad+2M1BsOGVywFU8N
	Y0yiX+mbfor+yR1Ec0FqTguxqC1NiCPGWtgvq5to6seZ5MVEXC4f8QxAFAEZaioODVckAgpTY2N
	xpf/054XiMZdEMgaFqfx83fzJXjqmhx4tCRMeyBixN3rFw/KoTC59d7BRbXnZImoQ5C/WDRd+qf
	Fw2Jzzt0VUyijiBaYi4zHzJNm5Gr5lOHdrMmvCCwwx8x8Ma8bofwt3aozbqa+gBtMFlvyUkrb66
	1k0EU3/X4rJ/XXF547fKetHkqlU+o7bdr2R6Z8jTPXAzG16KmL5ogKGzhx3EXREEgoPqAvd5TpH
	LKBi+KFBUEzvOrnnpN5ecDZZ1hyonEG0SG+UTjkl5Lqkgylg=
X-Google-Smtp-Source: AGHT+IF74/haEB2BDEv5ooQAo4ibP2E93UCpXmU3zSRaVvWO8MUsxIQotAnxbl9bq6ySvKJY2/8QIg==
X-Received: by 2002:a17:907:d06:b0:ad5:8594:652e with SMTP id a640c23a62f3a-ae057b3d94dmr855315366b.35.1750614018688;
        Sun, 22 Jun 2025 10:40:18 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae054080e9esm569006266b.77.2025.06.22.10.40.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jun 2025 10:40:17 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6097b404f58so6227142a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 Jun 2025 10:40:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVVTZZ3FnvVnQjG8KGgb1l9K4qJQJEt7wYmPM/7NF1gYL+TaNCd4WYr7QSRsZIu/lJos9NWp4Zwc2AfnmL@vger.kernel.org
X-Received: by 2002:a05:6402:13cb:b0:600:1167:7333 with SMTP id
 4fb4d7f45d1cf-60a1ccb4175mr8817971a12.10.1750614017461; Sun, 22 Jun 2025
 10:40:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750585239.git.christophe.leroy@csgroup.eu>
 <9dfb66c94941e8f778c4cabbf046af2a301dd963.1750585239.git.christophe.leroy@csgroup.eu>
 <20250622181351.08141b50@pumpkin>
In-Reply-To: <20250622181351.08141b50@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Jun 2025 10:40:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvyNdkYHWfL5NxK=k1DCdtyuHCMFZsbQ5FyP3KNvDNPw@mail.gmail.com>
X-Gm-Features: AX0GCFvQX_rPJUp_TeA-MaZrJuZOHr7f0zzM4dAjSAouwLFkdoxMjL44_Wohcms
Message-ID: <CAHk-=wgvyNdkYHWfL5NxK=k1DCdtyuHCMFZsbQ5FyP3KNvDNPw@mail.gmail.com>
Subject: Re: [PATCH 5/5] powerpc: Implement masked user access
To: David Laight <david.laight.linux@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
	Andre Almeida <andrealmeid@igalia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Jun 2025 at 10:13, David Laight <david.laight.linux@gmail.com> wrote:
>
> Not checking the size is slightly orthogonal.
> It really just depends on the accesses being 'reasonably sequential'.
> That is probably always true since access_ok() covers a single copy.

It is probably true in practice, but yeah, it's worth thinking about.
Particularly for various user level structure accesses, we do end up
often accessing the members individually and thus potentially out of
order, but as you say "reasonable sequential" is still true: the
accesses are within a reasonably small offset of each other.

And when we have potentially very big accesses with large offsets from
the beginning (ie things like read/write() calls), we do them
sequentially.

There *might* be odd ioctls and such that get offsets from user space,
though. So any conversion to using 'masked_user_access_begin()' needs
to have at least *some* thought and not be just a mindless conversion
from access_ok().

We have this same issue in access_ok() itself, and on x86-64 that does

  static inline bool __access_ok(const void __user *ptr, unsigned long size)
  {
        if (__builtin_constant_p(size <= PAGE_SIZE) && size <= PAGE_SIZE) {
                return valid_user_address(ptr);
        .. do the more careful one that actually uses the 'size' ...

so it turns access_ok() itself into just a simple single-ended
comparison with the starting address for small sizes, because we know
it's ok to overflow by a bit (because of how valid_user_address()
works on x86).

           Linus

