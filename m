Return-Path: <linux-fsdevel+bounces-72521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE72ACF9191
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 16:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EC95304F647
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 15:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66793446B6;
	Tue,  6 Jan 2026 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BDwIC1fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FDC3446CD
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767712922; cv=none; b=psa4TGEKxcDxCxJqcHH1SRliG9nxvkUadSt2hdctPTzr+jCPWwT6aBZx1Z399P5fOpBuvMmu1gJhs+i9sydedrdSwJ1IMYYYBo3Y08Q6mtzr29cDPa4RV1mveFQQZH7Tzg5LDcc+IVlHwhkwRyAJa51Et5hHcCFUxsdUJRIil0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767712922; c=relaxed/simple;
	bh=chwd1Z9g7UHWnZKthUKUkKtm8anU6pxU07itOfmSx50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTY5FbIEl6N1ftINvxf0oQjsy3YR8ZlHmcYdFvbjPWNJmE/+S7EV/Ggy94nCYKuUr3LCGdK0iY+Vo/w9f8uyloWEblza8T6F9Ir3XNTehWz0bs++u3YKE8KhTz/olbrxhMyLHj1iGHer2g6EBWMWgpBdw5pXrgP0wB5ReWSDHuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BDwIC1fs; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c2f74ffd81so99475285a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Jan 2026 07:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1767712919; x=1768317719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kDrYuR7f2Pn0DSNXMOjTYToBLnsosSITGyOOy6cQwP4=;
        b=BDwIC1fsoXbH92FjW0DvkOMMHZu26mvd4Gp+o9M5SqFYGsp01qbca+mOuW9bULpZan
         3DBXGYv3cwypfk7VMi7xe6J3/b5qp7cJ2t/Zxde08zryUH23fBv2swhCsV53y//XQScu
         M76s37GE8gU+HKqoNXEqXn8PzPe3sz41FPuyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767712919; x=1768317719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDrYuR7f2Pn0DSNXMOjTYToBLnsosSITGyOOy6cQwP4=;
        b=ivTsEluil2eNWNHZmlmir6b1Vsn91oErdCCbiY0Q0dTHmN7pULcSZ6KDLQzNZQRjMi
         GXyy593jQYQTIdz/F898dzzK1uNSsiMjgiMhNzhmr7/jQxriq1QV02SwFpl1U1xoQqTf
         05FzgI6oP2JwEvyCMfkhQIz8gpDwthsHkcXLVV2Mgj34W1Lqqf/I6LLaeZ/q5JdtFcG4
         3+8fikozVzUt3bbuKt0tv226WqURN9Pn6C3p1BuG2zZIVP4ZhAG1ubHzMi6ybk5ZIKHn
         beNWoFOlqme7Rx9AZCI6AP+et/m1mKDpNMY1ot67IZdqALKR56hMfK95MvtyYjIrlqud
         ee9A==
X-Forwarded-Encrypted: i=1; AJvYcCXEOPn7OlhM/X5YB3xxFis6tmNJIbcTvCtTDiM/6++ChR5F+wj0UO1QKLPtIBCNL4szmLnK0ScDU7ZPuwDC@vger.kernel.org
X-Gm-Message-State: AOJu0YzisoZZ7yrNdu543IVAEDyU3yXzDOim8q8eNGjoC0YoUl1ZHJ/8
	etqJFqacvB19jtdJIQEcd+H4S7FDxBo0H97rI39TGYon3tO5dqgnTc5coXrP8W9p2bgEucIJ5/W
	J9/7s+a/92e2lsKV/TTPK3Nhk+VF3BqJVRBoEwYR5Jw==
X-Gm-Gg: AY/fxX6C4UwnUEuPXzY0WyAYoAJqHq4hebb0JGiZQc4e4Yx6NkxoGnwtsLDo5vPlUQ9
	CzNxZGZr3nCaQvb3VhWcUm3AU5hrkhWR8+0kieb+Ap4kDNShubkZHF1s5Q5pLmkbWGgFe3Krnv8
	FeiYyn8wdobniIeyUyLSWqPdM2Y9ORBtwAFrUI/J6+YQMW0o1F+WDtlJgwrZGY+B9HXPEpC9wCr
	sXObmEc4fgi0pfTiXYYDG/u1xUmDamKh2pCOcSGlGNUcBnD6oAuZpn0oGcBLzvfvW/9ug==
X-Google-Smtp-Source: AGHT+IG6x7TKsUXj3KNtvBJi28N3SPu+7OrwOmTZbCRv6Zs3ASMjrBAiIU9+/w94vT2g2n/bhHHtuQObAHsd0eFiQw8=
X-Received: by 2002:a05:622a:4d9b:b0:4ed:698c:ef58 with SMTP id
 d75a77b69052e-4ffa77ba942mr34208171cf.41.1767712918964; Tue, 06 Jan 2026
 07:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <ypyumqgv5p7dnxmq34q33keb6kzqnp66r33gtbm4pglgdmhma6@3oleltql2qgp>
 <616c2e51-ff69-4ef9-9637-41f3ff8691dd@kernel.org> <CAJfpeguBuHBGUq45bOFvypsyd8XXekLKycRBGO1eeqLxz3L0eA@mail.gmail.com>
 <238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org>
In-Reply-To: <238ef4ab-7ea3-442a-a344-a683dd64f818@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 6 Jan 2026 16:21:47 +0100
X-Gm-Features: AQt7F2oAK8j14O2kOinzrAvBRjc34kIOHPAKtgLXconX1Vvn5FAQInffYN1YFNw
Message-ID: <CAJfpegvUP5MK-xB2=djmGo4iYzmsn9LLWV3ZJXFbyyft_LsA_Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Joanne Koong <joannelkoong@gmail.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, 
	carnil@debian.org, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Jan 2026 at 15:34, David Hildenbrand (Red Hat)
<david@kernel.org> wrote:

> I don't recall all the details, but I think that we might end up holding
> the folio lock forever while the fuse user space daemon is supposed to
> fill the page with data; anybody trying to lock the folio would
> similarly deadlock.

Right.

> Maybe only compaction/migration is affected by that, hard to tell.

Can't imagine anything beyond actual I/O and folio logistics
(reclaim/compaction) that would want to touch the page lock.

I/O has the right to wait forever on the folio if the server is stuck,
that doesn't count as a deadlock.

The logistics functions are careful to use folio_trylock(), but they
could give a hint to fuse via a callback that they'd like to have this
particular folio.  In that case fuse would be free to cancel the read
and let the whole thing be retried with a new folio.

What we really need is a failing test case, the rest should be easy ;-)

> I'm not sure about temp buffers. During early discussions there were
> ideas about canceling writeback and instead marking the folio dirty
> again. I assume there is a non-trivial solution space left unexplored
> for now.

That might work combined with the suggested callback to fix the
compaction issue.

But I don't see how it would be a generic replacement for the tmp page code.

Thanks,
Miklos

