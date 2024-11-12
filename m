Return-Path: <linux-fsdevel+bounces-34486-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C949C6259
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 21:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F240B628B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 17:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940320EA2D;
	Tue, 12 Nov 2024 16:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RUTXOkI8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF13205AA7
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430763; cv=none; b=oLJ2fVZU5dbMkFiENIxq/lThjfDKvFdHig1uDf2LbbpO6p1Ue+wyZIlHc1LgnS5Z1JWN5WgYJ7jLFAkbV28hJNoBxxcLyci9ercvmtDt5nS7wI3xnTerv57g231OT5yCByrAIGcukR8iutlAAE6IjtblhM0D0FxF/SVZ3gohoBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430763; c=relaxed/simple;
	bh=b1jTEdtkPHakCF/IMGMMubosZyjuhF07sN6TNoysKrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PYo/5kaYUwuCrDoj77cPHSQ0but3Oz8qauLwol8igHkdx0INiT607dlImzbgqbMyhnaZ6EhirHL/92oZwaiYE2GQa636AzqJ7Tj19zk2C0uKjwN2dEewMgFJTk8OPNaUMtnW0MRzHd3yvci4kr2+heOI7/uTOZf+vEzArew0lEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RUTXOkI8; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9ee097a478so397223966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731430759; x=1732035559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZPEPxQtUZVtl/O/zpSarTmTSavN7LoRspL03/jTYy4=;
        b=RUTXOkI8HdlKelw/64aU4Tl7CzBpKXU0V8GLK67IeZHNtLnGTZ01umtK7annRScJlx
         +gMoDoXQen4N8a5SRJx4OPjYM+k5U0FUfTAwXvyDhkF4nPYnbRV92w5RvMvp83+MdEP7
         F6MEnZlG30f2ioqyT3QSRADp6ikh3fNItGW3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430759; x=1732035559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZPEPxQtUZVtl/O/zpSarTmTSavN7LoRspL03/jTYy4=;
        b=P1QO2ZlMJhHy7ycNObX4vSiYytWugHSoIZLhvkTpNln4jFANz8TWFqDdHXKZhvNphx
         DuMXti3nkYZ7oN/V0OgWIcHMhMLKtHY/FJO4tyJ1j348Q1fW3SXOqlPPNH2TyBoz0dUq
         AiWyFqpFrfKwo8752W7UQILxOitUV58W6EupbYC2vpsFm7moT19eQUOB/ysWj7ad9XMj
         ltIy6woEIahm9BVDfgx4yZYtEFR4llU66p49Y1Em63j5MWf7Y6I/p8luQn88tPNeaqAM
         3DgG0S1KTrM8eVy9Axu2HXSJPe5LJIj+oHlI2f5DktjuIlbLDFo9ffvg+OdyYTne6uIL
         3Tvw==
X-Forwarded-Encrypted: i=1; AJvYcCVNPDi41LXfMBB1prG9u4H4/C3YE8JVkeY5avscI4ee04IY0kf3cZRmm573yoP641Uyess+HZv9caYguuG6@vger.kernel.org
X-Gm-Message-State: AOJu0YxXfPCVY6C1vQXjoeQO1yu8aSOjAPmGqfLa4aMqFGI7JI099yv1
	YBupoq+LQVDLwLi6tV03ayS4JfukU26Yb82ZaBiGijEtZa++spSRynRJra25QfZa0Tn+Elk4E61
	BAOM=
X-Google-Smtp-Source: AGHT+IEvYGAaLuB1PYukDcTrD0wumVg46h+5uABBdqPKbuIMMrx0LL6HJLPDgOeiMcwd6V5QqAf4QA==
X-Received: by 2002:a05:6402:268a:b0:5c9:59e6:e929 with SMTP id 4fb4d7f45d1cf-5cf0a26e08cmr22376392a12.0.1731430759222;
        Tue, 12 Nov 2024 08:59:19 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03b7e7f8sm6114859a12.23.2024.11.12.08.59.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:59:18 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so74336505e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 08:59:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXuuaJoplqYMQaOB4Rf0WTSqAodx9RGccxeFtSnyv7oSRzb73vrsr36ydKC8tDBJM7SAFwvFblmroBQqOck@vger.kernel.org
X-Received: by 2002:a05:6000:1a8c:b0:37c:cdbf:2cc0 with SMTP id
 ffacd0b85a97d-381f1889e2amr16128594f8f.53.1731430758034; Tue, 12 Nov 2024
 08:59:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112-geregelt-hirte-ab810337e3c0@brauner>
In-Reply-To: <20241112-geregelt-hirte-ab810337e3c0@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Nov 2024 08:59:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whLGan4AvzmAaQiF-dZ9DRRV4-aVKj0WXVyB34HjuczaA@mail.gmail.com>
Message-ID: <CAHk-=whLGan4AvzmAaQiF-dZ9DRRV4-aVKj0WXVyB34HjuczaA@mail.gmail.com>
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() for highmem
To: Christian Brauner <brauner@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 07:36, Christian Brauner <brauner@kernel.org> wrote:
>
> Hey Linus,
>
> I think the original fix was buggy but then again my knowledge of
> highmem isn't particularly detailed. Compile tested only. If correct, I
> would ask you to please apply it directly.

No, I think the original fix was fine.

As Hugh says, the "PageHighMem(page)" test is valid for the whole
folio, even if there are multiple pages. It's not some kind of flag
that changes dynamically per page, and a folio that spans from lowmem
to highmem would be insane.

So doing that test just once at the top of the function is actually
the correct thing to do, even if it might look a bit wrong.

At most, maybe add a comment to that 'uses_kmap' initialization.

             Linus

