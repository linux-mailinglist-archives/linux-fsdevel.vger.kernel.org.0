Return-Path: <linux-fsdevel+bounces-38308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D6F9FF1EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 23:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A99B16183D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Dec 2024 22:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763EC1B21B8;
	Tue, 31 Dec 2024 22:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IbiOGEWP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044B2187553
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 22:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735684335; cv=none; b=QxYld9FJCS3gpneDiyzR/s/pEtGO6bHfdKU5HCirc6SzLPY7yNn72uLjIA3Xny2fdbXCx7/dCxAprkdUqvOPv9CDdlwCGtHza+BTv4YDcDdpfc7nM3S9dT0azUktDf5XSHYhAdVSCV2VagRjhAm/7qW5C3l7Ug4oExMF1AdF05k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735684335; c=relaxed/simple;
	bh=kTQNLI0IhKdpQeiEtyNTkl/Wo8X0iByk3RGH1nm668s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ipd65W1t6HO5HgxkFtZ5/bJI7Tpplhsp7IK5lInbqR/mcXCxWdDtijMau+Vqm+54kbJKi69qIBrHh7qKI7SVcsgc9EibNNPYjqaMUaHLIEZbhFhu4EgYrmJ8Je/q/kGvM4kCF2WLQp3DEoTmwq61JhfMiIKO/ctVgmFa+LUNQCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IbiOGEWP; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1005511566b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 14:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735684332; x=1736289132; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FVwpZhyKp+x37AZUyDxmhOLZKSAQ3+X963r7X8OC6wM=;
        b=IbiOGEWP4n370+NNzqSnffVQGQe/XE1hhQgkRMeHToujg/uFYhzvfCj7+6eBGd450B
         Pv7ahZtS+vYRcY511D85TC4TsHKfu7vJppi0920GnX+4N1D/HpQZvkMciKPf++kAgNLJ
         2W8f/DFOivRJ7Q54UAm5EQceQWB37clOWJqVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735684332; x=1736289132;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FVwpZhyKp+x37AZUyDxmhOLZKSAQ3+X963r7X8OC6wM=;
        b=HKo5x40GdkqpqLb0Zd7foPQGDKfsD1wOExahkRFpQbUqx/RqN04udBb7MQC47U6adw
         NvDgjE4KtqfyxZK3EPS/jBgllQNUhqGewNQ6CkHgEn6/riWzXcdTsKaoDqt4JZU77z4E
         0QkBH7FYKj/WzLiqyUP58tVWALu/ZZ8vFk8pq3TCxO8g+G/anqZy/hQJycJk6uB3cjDH
         pMBsj2b0mkOS2hduvPpAhnUvp4F7fmM5HQhgzmP8T7ReLmcF1nq2kQJR6c7Wl963CW9Q
         5jTiipbGCVRVJ+wy+wTToNc4/2XmW+amDJSEHhUU5U5GQxghtyc4iC+vNhIsjeXJDYgV
         xeHg==
X-Forwarded-Encrypted: i=1; AJvYcCVvhPFXNDDa2RYeGoGmla7CZEAHV40eOPoqP7khnKwC/ICQoUB18xtTtw33MJrD+WHB7uynH8MurGqFi0pr@vger.kernel.org
X-Gm-Message-State: AOJu0YzanORfhBqmHkbwzM1wMtbn4SofKBS6l7Ir6p4VuRWQoGjKmLtn
	FOfuod9DyghFk74KIBAnaRB0VZybdNdFKF0llpXoqR60P4r505KQXsdpbwJufVjdj0KFKssUEQf
	cQlY=
X-Gm-Gg: ASbGncvovv+PAGiS9aMsdzD00DrU5UjrnAUmrqLu+loM6qUbt+olOQWm6YUx7J0ndoJ
	kTPlJaPsGg/cTBUyJNN/8DzBouLcVFOldgkXff3oIrPcgMH2rWsB2TKRLtBQ/BVf2dskTuAPAv2
	Ee15fUH3jLGPKBqOYmVc2iNz5sYBiaicpVnydHXMFGtNZJDxPCuXy02ZxeEL/pPn8J1PdcGL+4I
	sUeMQSrtcZPrvPyR4AqhgyGPsnAfGOsXJrRQB/6AL91dpW5GBRr4EugST88lVCIUdzv11LkYWmb
	6UsKQ+oPyR9tDiHsIvJgCG37blxO+BM=
X-Google-Smtp-Source: AGHT+IE1+WRgp5jDfSfccNOliDIIeZ/uCRqFpeQIn/GxIvtkCYBVQs4YIrWg/K3/Ef8ziTouWIs7Ew==
X-Received: by 2002:a17:907:8dce:b0:aae:df74:acd1 with SMTP id a640c23a62f3a-aaedf74c300mr2529478066b.11.1735684331742;
        Tue, 31 Dec 2024 14:32:11 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae4345sm1621567166b.84.2024.12.31.14.32.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Dec 2024 14:32:11 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa67ac42819so1446251266b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Dec 2024 14:32:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWYD297a9HNJoIxU30rh09HPWSn3uDZi/35op8Fxog1pLugpJMHJOHNrOpS9zqddb/aV60UPJQFpTt+NLYV@vger.kernel.org
X-Received: by 2002:a17:907:940c:b0:aa6:82ea:69d6 with SMTP id
 a640c23a62f3a-aac2ad9e63dmr4490406766b.18.1735684330662; Tue, 31 Dec 2024
 14:32:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230153844.GA15134@redhat.com> <20241231111428.5510-1-manfred@colorfullife.com>
 <CAHk-=wjST86WXn2FRYuL7WVqwvdtXPmmsKKCuJviepeSP2=LPg@mail.gmail.com> <20241231202431.GA1009@redhat.com>
In-Reply-To: <20241231202431.GA1009@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 31 Dec 2024 14:31:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com>
Message-ID: <CAHk-=wiCRwRFi0kGwd_Uv+Xv4HOB-ivHyUp9it6CNSmrKT4gOA@mail.gmail.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Oleg Nesterov <oleg@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 1vier1@web.de
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Dec 2024 at 12:25, Oleg Nesterov <oleg@redhat.com> wrote:
>
> But let me ask another question right now. what do you think about another
> minor change below?

Probably ok. Although I'm not convinced it makes things any more readable.

> Again, mostly to make this logic more understandable. Although I am not
> sure I really understand it...

So see commit fe67f4dd8daa ("pipe: do FASYNC notifications for every
pipe IO, not just state changes") on why that crazy poll_usage thing
exists.

Basically, epoll (and FASYNC) create *events*, not "state
transitions". And people have sadly depended on getting an event for
each pipe write, rather than getting an event on state transition.

So epoll and FASYNC can't depend on "users only care about the pipe
becoming readable". Which is why we have that poll_usage thing, and
why the SIGIO is unconditional.

The

  #ifdef CONFIG_EPOLL

addition is straightforward enough and matches the existing comment.

But you adding the FMODE_READ test should probably get a new comment
about how we only do this for epoll readability, not for writability..

Technically epoll might notice "read done" vs "became writable", but
nobody ever reported that, so we never did that poll_usage hack for
the pipe_read() side. So "poll_usage" realyl is very much a hack for
"user space depended on _this_ particular thing being an event, not
that other thing".

              Linus

