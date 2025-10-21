Return-Path: <linux-fsdevel+bounces-64963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9111BF782B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F314049F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908C343D63;
	Tue, 21 Oct 2025 15:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XxWPW0vl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620E3342CA2
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761061842; cv=none; b=cJ5AK5PufK6Ck0fq70l4XeG/iKiW0HVxbQ7O8fN+NXgv52qN5d/qLG0dr5FJCKcspKUzZaI0pUwGdeEemYPAirL93JVw1CzvXcTHmHNVNBm8nYWmlWsXGs/pnwkRaicCW9nH8I6IjRS45qsA4QqQH+MvK3RuNPcUSfUqpiqupCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761061842; c=relaxed/simple;
	bh=w/7b/vcrnwDmzcCJFmEGmVXMR8uWlmKwT0l7hIVnP3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EUT2muKLDpevMfMcfu8ARyd5SVGX0WXs90uKM3mVKqeSOZtnKqYYZDeTCH9iqSsn3H2/tBFXfuN4vS4PjtuZWiyiWBnzVJzmru2MVPV+CGTK5Awl3+9e6fAAHliRUjREcgZp08J/uaEYwfHHFmbpck1FG+P2fOSuvTfVAibUgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XxWPW0vl; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c2d72581fso7212174a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761061839; x=1761666639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSX4wv/8cP4pcdwROoiiFUZrKHWnfYkhVs1Qya+vg78=;
        b=XxWPW0vl7ap1Ze2/3uo6HOr1qlDnhYJ5NbCnN7lNpU21Z1hFnRbHLdVG87+0KXfzVu
         Qv9O6BKUSRGhnvCBEQBpH53ubzY8xEcxJpV97KpUBSn4tU/PbXhTTz1him5fTNeRwJ7P
         GqpzcByT0ehPyve2Ltdkv3o8fWKEk9j3OMjLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761061839; x=1761666639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSX4wv/8cP4pcdwROoiiFUZrKHWnfYkhVs1Qya+vg78=;
        b=lCHtVPz+/K9coYq1rukRGebbuk6KMRjrum7pbosyfcMWwOzqcFHv5QeoPbLUaKv4hc
         QI8wepQFWgOxs6jyOBluoqb5PbYmcjW5l9bnLzT45ziAoOX3o1t/XOuMtZH5LgjsPLWi
         FVzS8WqDPWQLdl023vj4iEzo5H2qgL51tm2Vx/ISScjTCeK7uK3uwxRpOHpFkOC1tDco
         Px7ZHcR3LemaHKM9yOlhj0cMgZBdGpZAddMDiEFiNAnvtVb7v+E9PkujlK02f5lqHHC7
         6q6LLcWQgW/15w7ahlE5v8H1dlKSLMcoRCrU1oXp3ZAF3yThdK1i/jpSpFalaY4X+kit
         mdRA==
X-Forwarded-Encrypted: i=1; AJvYcCXw5hdxwrpyoIT2Bxk3AAo1ykh02o6NSmZVRxqZLdKOk2+nIFz/phXn+ngTlvn9frCskp5NJBwv8utCwFZE@vger.kernel.org
X-Gm-Message-State: AOJu0YybIukwbqasuAAmfBfbVGLViO/CiVXCEAE6Et4dpyPF+jthhEU0
	A3ZWUogwqckA/QKV3enStHEtEeuNbZlQm1DsbF4yXlBluHuKlZ1c+YRcVc6DCh0MKW9h0EIw7vQ
	SZt7gPkdspA==
X-Gm-Gg: ASbGnctzlaSDbJG5yh1Mpz+1Fgj3gfl1bJEfY5WEB+mqKSAyP7v2C/530NZ3Jg72G18
	mVceTP9r0lAzJtTR/HSD6DofTUQf5aKf1FGtmwtF9uPbOYxrbuLSjL8J2SR/43Ha1DdZFZr6Mbu
	cMHeE5fiVtNrg06wPQEDA7zvc8bC47k0pWTk+d+BqvAafe/60Jgwfls9kK1vpXRUq/3TQ5GW3NR
	w75xhEPFRAqSOCteTFxkWPvRDZoiKCJUsIrS3u1l2aYgO/BJ+PoO6cwzPzncQqCxuqR3uCkOzv1
	rYiJ3CW5hahlX8TYyhtLnbaKGd0ff2jZWJROO+AVrTj4ArxLxtnWU6SFWIZpRl798H0y+OVx2C7
	Q9bLF6Z+eQL0uribVCvNOQZeI2QkFZ/FmVAht9fkQQEoy4VzIgL1kGQn6WypoJS1cKEm66+D74P
	SNSYU3WLGjpJSO+tIXtY1QgXMzHKfRsV1WtQyuYUADXZxaOmIBZw==
X-Google-Smtp-Source: AGHT+IGyap5GYffATdza1Wv6Dg5e1R9qveklN5Y3kSBdo+H2garQUbF4o1y3+Pn0UxZZTVu4QZhMGA==
X-Received: by 2002:a05:6402:144e:b0:63c:2d6:f471 with SMTP id 4fb4d7f45d1cf-63c1f6e047cmr19143887a12.26.1761061838608;
        Tue, 21 Oct 2025 08:50:38 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4869746asm9669055a12.0.2025.10.21.08.50.37
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:50:37 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c11011e01so9427833a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:50:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqwVXWoHO1CRvTXXy2PxGJID13SWVxK95x710/lU7LmCOupO0Cu9B99hDnhH+hw+XeQ/lITZilDZTPYR22@vger.kernel.org
X-Received: by 2002:a05:6402:3554:b0:63c:4d42:993d with SMTP id
 4fb4d7f45d1cf-63c4d429b92mr11883163a12.31.1761061836721; Tue, 21 Oct 2025
 08:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <20251019215328.3b529dc78222787226bd4ffe@linux-foundation.org>
 <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
In-Reply-To: <44ubh4cybuwsb4b6na3m4h3yrjbweiso5pafzgf57a4wgzd235@pgl54elpqgxa>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:50:19 -1000
X-Gmail-Original-Message-ID: <CAHk-=wigaATtHqwU+KHRzf-t2jGmD=zT3tGnJVD+4MAk86tpNg@mail.gmail.com>
X-Gm-Features: AS18NWBOp9VJpCXyIKnJNta0lggyjzqPvsPMHPbiYL935bxgvLcEoC8FIS9Zxss
Message-ID: <CAHk-=wigaATtHqwU+KHRzf-t2jGmD=zT3tGnJVD+4MAk86tpNg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 01:33, Kiryl Shutsemau <kirill@shutemov.name> wrote:
>
> On Sun, Oct 19, 2025 at 09:53:28PM -0700, Andrew Morton wrote:
> >
> > A use case for alloca() or equiv.  That would improve the average-case
> > stack depth but not the worst-case.
>
> __kstack_alloca()/__builtin_alloca() would work and it bypassed
> -Wframe-larger-than warning.
>
> But I don't see any real users.

Yes, and we've walked away from alloca() (and on-stack VLAs, which are
really exactly the same thing as far as a compiler is concerned),
because it makes static analysis much *MUCH* harder.

Let's not ever re-introduce dynamic stack use in the kernel.

                Linus

