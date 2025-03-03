Return-Path: <linux-fsdevel+bounces-43002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21621A4CB70
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 19:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1745A3ADAAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4329822E3FF;
	Mon,  3 Mar 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M1LVSZkD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5FF1E7C25
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Mar 2025 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028167; cv=none; b=VB6MxkKPxklwiagpYyAoVE4nv90RQ00oouNVChP56oo3P5KHJNxAEF89YkTNOtKQiH7TPRL5kIE1lBdh3aFvyK+33fAJs8bs74QePL3qo//o+hnbdTVvqviuXGKlFkv3uGy1aPiaQViTPew8YofYLN3igsD1DwCIqJgZeawi+Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028167; c=relaxed/simple;
	bh=40lZ1B3I0WpagjJJY3c7pknBCiXUw+PnTGKE9/WolFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gjmuy6qyqcQy/2YESOPWCT6I34+JHEFBYd3sg+9fAlrQNDF4J1KV0XReYR6seiE/qv0XwzVLw1fhXsZmKro7yY5XvT+FQuUihKbsZjMsQ/8QwE95v4VF9ZwNEWijZ0K2FkXYy+rq12DTsY0uUahHpnrzvLn73blmLi7tdb7//+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M1LVSZkD; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so934144666b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 10:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741028162; x=1741632962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fSfhJwWsj+zXdSemjGaY4k9oeyz7B20wLL/Ct0QzSTI=;
        b=M1LVSZkDldcz9I4LJA5X3gQprKLSrcONjSFUo36f3NJbn33ZccfEagbWcekmF3keEq
         OzAprCqaQGLCQSISRvXNEmvydUq1eolauvf+EBwpiwtIv3V2tiQF5CP8VRxO+K6caEIq
         bmAmgtHlFzvxH9rzPpwzaWbK3gsCPtLM7Z68c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741028162; x=1741632962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fSfhJwWsj+zXdSemjGaY4k9oeyz7B20wLL/Ct0QzSTI=;
        b=RsgiKt2kNIms1KHYTikHQhS/L0n1My4LcC4O9h4T+OsZc4tiOE9v7X7N5JTxCJZQBU
         qMXBKLkHgbkUS/mBxbitNeF6PdkKRyItFaPTsljUeuCszKzPdKNd+0YG/8W0E/s/VpUM
         NQAqoXL0faVh2p+Xifn4Gw7F2r0+2p4A/lRnfOHB6DlgBKW6CSMY98dI5auvr0jvkAhX
         uNRiwnAWLRAuKPpYYLfKr6FRAhkvK2eGfT5MiBuDdNgmcl+d07CWLVlPp/IHVoH3hV9D
         8B7G9Pg8TUrFNvCkjS6/bEnzLzlfuj0x69BOiBn8kXsQRaPHQfPO6vv8FalfEvytFlzx
         FRKw==
X-Forwarded-Encrypted: i=1; AJvYcCX+QTEa4nUSIO9/U7U9AN//xOBdLTx6rJBqST1nhVUfjMGqZpPQUEVIgy+yUSpJho3DUBhHQHYlZIGHSafx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RxyqAqfzk41fPe4Wg3Ty3bNQ6iWJqYqdQSoU4drviqyEfU/X
	D3pIUz+kZq21Hgk508McdW25KwgBeW8VWu7g70Cwl0I3TZfnagvKju0rJ4suHcZR49+ssBlQkPW
	AEjk=
X-Gm-Gg: ASbGnctEV8CU500rWoi3vMK84ESV/A8hLvCCgio/KeWQbEN8i1BGDZLAD1r8HJul4pA
	mFWTDNyWqXdKlcuOLnMZQdhmvb9N1A3P782dBH8hbRNCjHNh/ydfHeU3FFyvdc5XUOhBvh18UXr
	dTVF3Jmo94M39KS2Ijw4BaboXENj/joyLcC0NYfSgyLckIqCCxG/ZFoK5FrVPEdOmEG+BRDur80
	oGWb/oBfj2wNp5sbW5rm/yKppRo+/lLh+gT2mmedL6wWj7ljIFrR6X4zhtURvQ0xhYQyR0RJNWl
	RKp6DouShWwXpZz7FVBcIGf5Zr8sA261vE40Ysu4vte5owfngocs3ysBPHnQZ/UsK0MmVzN+rmI
	C5/C0EQ1di7C/m1NnM0o=
X-Google-Smtp-Source: AGHT+IHsvFy/W+tdirBvB76TPh9f/U0gKww2GlvreqeYoTz+U/fMEEoKkdClbqPuRPvzQV5F6MMDGA==
X-Received: by 2002:a17:906:1990:b0:abf:3e68:6583 with SMTP id a640c23a62f3a-abf3e6866f5mr1446380766b.41.1741028162193;
        Mon, 03 Mar 2025 10:56:02 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee4c9sm845032866b.97.2025.03.03.10.56.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 10:56:00 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-abf64aa2a80so350983866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 10:56:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVeYKnd9TZPSPDAKNRra0Jey8Yfmt3+vhHxVc+SheSMYLMLIgiwMTesXKT//r0vSm+2Pad7lFNkgsc4YD52@vger.kernel.org
X-Received: by 2002:a17:907:6090:b0:abe:fa1a:4eab with SMTP id
 a640c23a62f3a-abf260d496dmr1907190066b.25.1741028160310; Mon, 03 Mar 2025
 10:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <qsehsgqnti4csvsg2xrrsof4qm4smhdhv6s4v4twspf76bp3jo@2mpz5xtqhmgt>
 <c63cc8e8-424f-43e2-834f-fc449b24787e@amd.com> <20250227211229.GD25639@redhat.com>
 <06ae9c0e-ba5c-4f25-a9b9-a34f3290f3fe@amd.com> <20250228143049.GA17761@redhat.com>
 <20250228163347.GB17761@redhat.com> <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com>
 <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com> <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
In-Reply-To: <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 3 Mar 2025 08:55:42 -1000
X-Gmail-Original-Message-ID: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
X-Gm-Features: AQ5f1JooMQOhgpSZJUgMFpU_jRsla4fjvec84mqVPfIW7QyBHFNNtlSgyObw66Y
Message-ID: <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Oleg Nesterov <oleg@redhat.com>, Manfred Spraul <manfred@colorfullife.com>, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Mar 2025 at 08:33, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> The stock code already has a dedicated routine to advance the tail,
> adding one for head (instead of an ad-hoc increment) is borderline
> just clean up.

There's currently a fair number of open-coded assignments:

    git grep -E 'pipe->((tail)|(head)).*=' fs/

and some of those are under specific locking rules together with other
updates (ie the watch-queue 'note_loss' thing.

But hey, if some explicit empty/full flag is simpler, then it
certainly does fit with our current model too, since we already do
have those other flags (exactly like 'note_loss')

I do particularly hate seeing 'bool' in structures like this. On alpha
it is either fundamentally racy, or it's 32-bit. On other
architectures, it's typically 8 bits for a 1-bit value.

But we do have holes in that structure where it slots.

             Linus

