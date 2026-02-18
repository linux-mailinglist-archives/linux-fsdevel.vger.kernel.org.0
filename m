Return-Path: <linux-fsdevel+bounces-77636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qVjBEDBBlmkvdAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:46:08 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1160515AAC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 23:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2E202300D4FB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Feb 2026 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380AE337BAB;
	Wed, 18 Feb 2026 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NiksL/pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE833064A
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771454762; cv=none; b=dyiyGcXub9IZDrnK9Zk202EAhj8YtFwLYDipgBsU/ilOxb7s0qQeV2yRomkxKdOmW4pAem6MhkCTtAY0lNY5u0v59YuEIPp2R/YyjBfF3EDCsvvM/kpQgfUr/zYajeDIZJjcR3BLXPAYWIy7W5S+NQNB5CuaMEvcEkNZrIABHrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771454762; c=relaxed/simple;
	bh=FFDEPYtr3QqZ2+iT/cYuDyzKzHMlEFuhDxie2HS8cg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tKNidWltEHhaOKKCLOfplirnh5TGtc9kRpiR0gffyOy+1e78Y6B63lMbDhnOH7c7wLKw1CnXtXAdBnf5nOIx5sWeAMUayag+R/SpjkzuIIpCYCurAvwfwkTPleuTx6JNVQFvmeWafNBvxc9s4jGpDdPVViHJsFmv/6L5HdfOUF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NiksL/pC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-65a431e305eso460745a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1771454760; x=1772059560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tYHnBFKWR6B1KP5wAQMPuEKl9bK+9korwepvhy0dM2g=;
        b=NiksL/pCh/c3sBUKyfjAuXSDTBmk85ZPujB5Kl6cO1gXcH+H1flm80RKdlmSZtwIi4
         vC8fgNXm6PUzaHa92sY0w3ttXq4/ZyxZVde81JhIFPXGkveT841RVA+9bl/ElPnsXKru
         5hhSWnsdj4jxpZ+dkJyRmpCv2VqNj3gWZpCjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771454760; x=1772059560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYHnBFKWR6B1KP5wAQMPuEKl9bK+9korwepvhy0dM2g=;
        b=V4fLBe2zInymkdLs59tT5zpgqRO/zGnhROwB9entbOLZRBJIisWp+z2p4b7FKjjmR9
         a37NUPQ3/n6vElPmORpR0/YY15Gjza+YrtDFBDcUupg3qP98CGk78aIPsyW4cGNAJftA
         IPdh4nnnNBmLe06znfqrdETv/6XNn2Dz8ZjmC0y5OLu1Eys1ZAevi2MIBjW3usWuv6bb
         AwI1n7OXt+oQYobg3zoksTErhjo/TjF684ATEkIyrje8+o+9AOpESropGxa/UFKG0aSY
         gqdYbTyaC8z3gBL2H3BAGSJs+kXLTO0P9+gJq4+KOPSOBo4YxF+bp7vy7VXmVOg2Ob5a
         fTMA==
X-Forwarded-Encrypted: i=1; AJvYcCX7onZLaKydDcKoR0sN8whUT8vNEMj+ktNVvoB60cD/ewz3OwU+t77LcSAmE6PveBZqZHWkXvBcjqDJiTE8@vger.kernel.org
X-Gm-Message-State: AOJu0YznIUEVCKHueDYzsL5mNxEZM9ZxQFMauSCFm+YJxWbUn7ueC0cM
	yXPUyq4JI1GezbTgocVq5vqXgywcJu0iojw27WvMiQ4SYCu+2OeqFaYXnRDvpEZv7PMyXvnK9dN
	pkpxINYFjQA==
X-Gm-Gg: AZuq6aLE3FDvcLVbgZ8pytU/Urg7aIbBIuV8vGjeW/xoktsCeAUJxppFY/i6BcNHW6f
	M0IdRPkyS94WBI1e9N/a/XHOjp+Fcy/7LTXJVbkSVOVH3U46As5BceHsZQR1Lb0uMS2FJt2KHER
	Tj0G1awdVwjG/aGTEAq4yhOoYC4kXwiwzhDoB/GWU+vIm5RiPoTanx9v2uNixQMxNG33qApyt3m
	bHrGAo3DCT4BgcZ05fgM+6RGhnPc0MR5/SAfO83gJ9hSWDYRWqHjuLpJmNxCo/8eoy4ym30u6BT
	M38vBDRrEodcrBqzfZ65RWWxBP8TzLn893j2jrjkMIDGbRe8j/R8fA3kgeu/xuWrknTjwN/x+Ua
	WXwd24mzVRtSWH8JwYOohMyeSnh3mis8NHLBtVZvJzdQ7+sN/uIcv34vWJfSKmBbdmD+zyqDqa5
	Fk36GOsSo4a/Cf8c3W53C2ewViYBStM1DD2Pl0/LX+qTq+7RyF/2cA06c4cix2okAGnJCVFMeJ
X-Received: by 2002:a17:907:720b:b0:b8e:56d1:be76 with SMTP id a640c23a62f3a-b8fc38f15b6mr794133666b.1.1771454759503;
        Wed, 18 Feb 2026 14:45:59 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29d571sm3404062a12.11.2026.02.18.14.45.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 14:45:59 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b8871718b00so55071866b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Feb 2026 14:45:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVyNsZPu8IM1wRislKeV46BLlITV1/rbB2IaVas2MF8tGKw+1yGQ4sLu6CFAJNNOR4t9+gjRgCjsnwHgF1i@vger.kernel.org
X-Received: by 2002:a17:907:7fa4:b0:b87:225f:2e74 with SMTP id
 a640c23a62f3a-b8fc3a31062mr1035846966b.14.1771454758285; Wed, 18 Feb 2026
 14:45:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217190835.1151964-1-willy@infradead.org> <20260217190835.1151964-2-willy@infradead.org>
 <CAHk-=wjkyw-sap1dNkW7v8at8MvF3j5wshC1Gw3XEpHBbBw6BQ@mail.gmail.com> <aZYoXsUtbzs-nRZH@casper.infradead.org>
In-Reply-To: <aZYoXsUtbzs-nRZH@casper.infradead.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Feb 2026 14:45:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiXCcnp5VuAZO7D7Gs75p+O4k-__ep+-2zapQ4Bqkd=rQ@mail.gmail.com>
X-Gm-Features: AaiRm52JQQwmaA8zeXg94BvZ8UZePdZasRmr1dxFOzE3NsiDpRGG9uM9CSDoJ7k
Message-ID: <CAHk-=wiXCcnp5VuAZO7D7Gs75p+O4k-__ep+-2zapQ4Bqkd=rQ@mail.gmail.com>
Subject: Re: [RFC 1/1] rwsem: Shrink rwsem by one pointer
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	FREEMAIL_CC(0.00)[infradead.org,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-77636-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 1160515AAC8
X-Rspamd-Action: no action

Oh, I already said "this looks good", but I take it back. Looking a
bit closer, I noticed a problem:

On Wed, 18 Feb 2026 at 13:00, Matthew Wilcox <willy@infradead.org> wrote:
>
> @@ -612,8 +594,6 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
>                       struct wake_q_head *wake_q)
>                       __releases(&sem->wait_lock)
>  {
> -       bool first = rwsem_first_waiter(sem) == waiter;
> -
>         wake_q_init(wake_q);
>
>         /*
> @@ -621,7 +601,7 @@ rwsem_del_wake_waiter(struct rw_semaphore *sem, struct rwsem_waiter *waiter,
>          * the first waiter, we wake up the remaining waiters as they may
>          * be eligible to acquire or spin on the lock.
>          */
> -       if (rwsem_del_waiter(sem, waiter) && first)
> +       if (rwsem_del_waiter(sem, waiter) && sem->first_waiter == waiter)
>                 rwsem_mark_wake(sem, RWSEM_WAKE_ANY, wake_q);

This looks wrong.

Notice how "first" used to be done before deletion.

How it's doing that

     sem->first_waiter == waiter

test *after* the deletion, which makes no sense at all, and will never
trigger, afaik.

I think that "&& first" was always pointless, because
rwsem_del_waiter() would only return true if it was the only waiter,
and if it was the only waiter then it was first by definition. But now
it's gone from "pointless" to "actively wrong", because now that
"first" test will be false.

So I think the whole test should just be deleted. The return value of
rwsem_del_waiter() is already the right value.

Anyway, this is all from just looking at the patch, so maybe I missed
something, but it does look very wrong.

                Linus

