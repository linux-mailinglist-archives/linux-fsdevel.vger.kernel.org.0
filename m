Return-Path: <linux-fsdevel+bounces-59907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 529F3B3EF8D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 22:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5BB7A4663
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6872749D2;
	Mon,  1 Sep 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6mYNYou"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD7E4207A;
	Mon,  1 Sep 2025 20:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758184; cv=none; b=UYiYfVor9UFMDPCJREpd1mUQe/3m/cM1P2wj1frZtpUfKP1VVhZ/ahTmoOEB6ygA7+Z9duGpygHfdTO3nrM8GCeQNsNQuE5H6aP2wbsciE2Xdm7OkRT3Z700k2FpGPDXPIPAkDgADTma2mgrp4N9TcpFopzOZUufEGmIhb5YzfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758184; c=relaxed/simple;
	bh=d+ArmJp6V5Z7be49dlLKnOypdI2yvRmKYBqy0RC8Wg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNggJkswMUYKm0jRyRaCI9gOtmpMdirbyZlNk4iVS/71mHG05Ga6f4oX66lf4PW8bgKN74qMYP5KZDLdHdhdhby8Cvcl4bEfr/rg/dRriwhAhxToe7oiCMfFv79yAu/RhIuPT98wuookcEDUB8j9k/mxesZ4lcLxbvbDYVr0HOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6mYNYou; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cb4370e7bso6971342a12.3;
        Mon, 01 Sep 2025 13:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756758180; x=1757362980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+ArmJp6V5Z7be49dlLKnOypdI2yvRmKYBqy0RC8Wg4=;
        b=Z6mYNYouqedCgwb4lA37G7ICtUUuQR/gJyoo0bXx6BAwd5/owQd9ubmoJrVLhD6Rcp
         B7+tplyRNOwjyXFCPUL+pFrwf5/T/rdi1qkUJL8K8ofJxebgspTs4JQoj8+r2mzQmxy6
         TLmUvK4REr1WbEeqTIgzQy1mxa7I85P1PzIo9OL1aRjUhWpXfL596wY9084+++5pa4Om
         ZDzjA4oS6npvI+r9qZpsJVYQf1+l+ODzcLLcrlSxzLs6raDqgOK+PFZtIAykQaxGVBhe
         0mLvhJTf/W4z9wiFXRLp5vLDg0ADmM+rf5q515fnWEdNh9FMwRHozHohxRqu+7dsqnjd
         FiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756758180; x=1757362980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+ArmJp6V5Z7be49dlLKnOypdI2yvRmKYBqy0RC8Wg4=;
        b=BJpaLPBLTj3/CFXTVGGejLaojlp97oQg1Hv+PbzFN6B98aNWMRU11rab+I5fAdTLD7
         tA0NyrrG0pSvmwMfOx2JBcZFgzNdQ299oDl4X9WdhDe/m8DhhwuMvb8moH1lPnvDbSK0
         V/ldAHuWZHYN2BYcG7ecQOIS6RKmLMwxK9xfxPgwJ//5FotJNUhjb+0q4qlGCbcgyLD4
         oQQH2lsV0AKRX0ZPNv1eyj7yZPYt5sBTUBjc0a+RfIF/4JFOoXAYOFHgkMJG9jU8S/QU
         ANVz1TtqNhhffjr/VCpoPlPjDVYsAdsUGC1nOvJm61bLMkRpWO32AUY6XBzJAzxQzz84
         nnbA==
X-Forwarded-Encrypted: i=1; AJvYcCUxeTkZZJrwZc7T3yYR8JyFxmTeZc5DTwCk8jNFrwBimx9CeZakLUd/6bY0h6q9Dd5ZzX/bH9zOgZPqvSBJ@vger.kernel.org, AJvYcCV979vmfd92umSoPAeG2O7jmF8LRTXHCnHZFD5zw40Z0bEJ8/G/fod/MDLuQTAsC+tO843GsxIDAEjXBAAl@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKt30n7K2u8w26u1CcwulsS8wNg8kfzgzILpUC1fplLRuXMMt
	YPl3HKOqSYVnm7YgJILM1yxlmN0DdQ0l9IU6i16BBtIHFwZEoEIuOp+QFW0IwA7uq7VJY8u+ny9
	9ZvhkZ1AwX+E9plDs2oAhH528BOwXHto=
X-Gm-Gg: ASbGnctY5ITHD9jx7Do+doWO9dXWX676i2/yP/1N1sgSC+QMFmhwhLnvT4fRtT6LHB7
	4iodn7kvCkQRjoGbb9+7ZVWjBS1gECDuPtx5iFxV2sXu571TT9QARqX3E+LyifJgWJwF6l13AJE
	Pq2SEN12SDewYhv2u5Xo2/5ka6VuSVgF5XUjIq+66NzeoV0EJijCjOwpNjmz9eZSitReF3whhRQ
	XG2R2+mxVGkIaoBAQ==
X-Google-Smtp-Source: AGHT+IHtLctVX3kJ8Mnlh7i8vnVh4iEaWVlmw1PjIIx/AAHOV/Zbwa7Byp0zBy2F7V/wNMSrU9XVRyW2XqzquKGwW30=
X-Received: by 2002:a05:6402:84c:b0:61c:e99d:fdef with SMTP id
 4fb4d7f45d1cf-61d26988c6amr8927384a12.2.1756758179893; Mon, 01 Sep 2025
 13:22:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6e60aa72-94ef-9de2-a54c-ffd91fcc4711@ispras.ru>
 <u4vg6vh4myt5wuytwiif72hlgdnp2xmwu6mdmgarbx677sv6uf@dnr6x7epvddl> <7a2513ea-a144-4981-906a-7036d92d4dcb@app.fastmail.com>
In-Reply-To: <7a2513ea-a144-4981-906a-7036d92d4dcb@app.fastmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 1 Sep 2025 22:22:47 +0200
X-Gm-Features: Ac12FXwhsQR2ej-z8VdsmTBsKGjbFnukDoBkIlvMNfU5h4mvfQ8k8h1hYprZLCw
Message-ID: <CAGudoHE_RFXT9n8U9X4TD_9gp-raFjXLuv9yk8eLsngi6f7YZw@mail.gmail.com>
Subject: Re: ETXTBSY window in __fput
To: Colin Walters <walters@verbum.org>
Cc: Alexander Monakov <amonakov@ispras.ru>, linux-fsdevel@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:57=E2=80=AFPM Colin Walters <walters@verbum.org> w=
rote:
> On Mon, Sep 1, 2025, at 2:39 PM, Mateusz Guzik wrote:
> >
> > The O_CLOFORM idea was accepted into POSIX and recent-ish implemented i=
n
> > all the BSDs (no, really) and illumos, but got NAKed in Linux. It's als=
o
> > a part of pig's attire so I think that's the right call.
>
> Do you have a reference handy for that NAK?
>

https://lore.kernel.org/linux-fsdevel/20200515160342.GE23230@ZenIV.linux.or=
g.uk/

> > To that end, my sketch of a suggestion boils down to a new API which
> > allows you to construct a new process one step at a time
>
> In this vein I think io_uring_spawn work sounds like the best: https://lw=
n.net/Articles/908268/
>

Indeed sounds like the same core idea, I don't understand why tie it
to io_uring though.

> However...if we predicate any solution to this problem on changing every =
single codebase which is spawning processes, it's going to take a long time=
. I think changing the few special cases around "sealing" (fsverity and wri=
te + fexecve()) is more tractable.

The problem does not concern every single codebase which spawns a
process. It concerns the few which are heavily multithreaded while
creating binaries they are about to exec.

If they have to be patched in your proposal anyway, they may as well
use the new API.

For non-affected consumers, I was mostly thinking make and shells just
from perf standpoint.
--=20
Mateusz Guzik <mjguzik gmail.com>

