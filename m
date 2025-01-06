Return-Path: <linux-fsdevel+bounces-38470-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FA9A02FB3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 19:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 814043A471D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D481DE8AB;
	Mon,  6 Jan 2025 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bquqX4g0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823DB2CA8
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187835; cv=none; b=XmUOcX4AC6pLy19eqYCq2vKZUKyGvoohO4JkalhyHm2Lv+k2l7Z4O1UbeiRcxfsNHwQx2W4gSYAC78ytTd08zrA8JtO7D9cPsU1qpL/Az0a2mqdJ9ymipNf1JJ3JZqNZcTMMHoUs0RTLGvfaG9jNL09BltBEgo0afqgmx3Z5ODA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187835; c=relaxed/simple;
	bh=TCuBGDlgZtn0A5qFFfFQiT5BF6SjaTL0WnN9UBeSG7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J1yC6FqDl6gZQiK04gH3y+or4dvKs5uXYpLDQEfjrfeaLBGlIlPphwMhzIi/4um4QqdVnjDz5u4spsow07om+CkJtDwrMP8GmBwkORkDVNInXw7N5irKcOjBIRjTYKhoCE4nvb2pM6FvpYd3c1+JObXnWyGRoBYh1XtiibIbqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bquqX4g0; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so27163549a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 10:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1736187831; x=1736792631; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9C9P0xT7GrC+VUy9GSfOL4LEV9zTQaKhjEjhdCNLeTQ=;
        b=bquqX4g0p2j0KD1RLiRbgWfhLZ/Tyq9pWpc6niyO6YMCnkNm/quPIH2OYkND4vvuVv
         tufX8RPePDfouje0JpuuSaJZ9UvRbTML7JVKnmqSeoy/oRblAycHeIdNszP3sQ+ML2dx
         Ig+roCjERJ3IsBB0snCakxodLlSa0CvArT1jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736187831; x=1736792631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9C9P0xT7GrC+VUy9GSfOL4LEV9zTQaKhjEjhdCNLeTQ=;
        b=WFnRX8ziaL1/srs+jd2h/G8Ly3zQAAFQbOAFLj6VpTQYAGGbeKN2nYITDHiwgEEabi
         1eBwoK4rhotvO8s0WlDdX1Oqy/vPU33clxpNXqdRyrjR2KhMPKf4VsXSOi60WnJG0E4F
         T0zsUQW3Unz3GeoEMXCLLp0e9LgfKSYlaO93+VZKu4HEZ7iyMVz+/7YN4uzE5qV6uCWF
         YiqiobeUjgo2eI9mzLCMU0F6FKVvy77OHe8Qg8V8bIhMkYdtH108Qn7Snh40S8v1naT3
         8zEkQ5EhIIu2p842Vo5VgIoT3Y4wSdGLlihUsH9s7DeUI0vdLKbf/8k5gVhiNM2ORk5g
         p7VA==
X-Forwarded-Encrypted: i=1; AJvYcCX+Zh1Q8bRkglEY3AK0UhZmLW7Q6u3tBAUYYg4TmWbTTu/fPgiKHw3zA8A3YV4fiyM1fFnCWsy+PGhNzHK2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywng9jjngR/272688BK74M3PP0C1IyCSCNutVvZwNNCDStsZMMe
	nIwcVeR8bP5bWJpoqN3znO11thbZyWRh/Rc1jsEMX5TczJIY9F2n+aSb5Gk0wuPyyJIuB69b0lz
	LQys=
X-Gm-Gg: ASbGnct50teOimHZR2BG71O3QhLohHVey2LDJlehpPVknvF1iejc+s28Aj16dpaKanc
	oAk4SXRrHmMxGqoSqAkt546IQTWy8EsDmHcbR/rlsUtzy0lFnCiKTqhDeWi+0WDUqX8/Jo+6FV5
	mcZ6Z9ovxs/5nfrSUUahe7VZGyVpRXa5GZjL3OkkSa36SKChlGdrFIag7WbkrIsH8YZqvqXMqLi
	IpJK8BLHu1tliK0VLIHINUTgxyQbNIxRtgTzyHx2yTETftcDmdErw6E9cR65sH8rROA1C5N0vVw
	8xr4v91ZIXlr06k4qhEgLV0/wrv2N+E=
X-Google-Smtp-Source: AGHT+IGGxoC5cxHdupzx8zCKph6YcV9QqAwmqsSLVKB3qulg4oOXOkiUslogRkkW+riFePZMzkPShA==
X-Received: by 2002:a17:907:3ea8:b0:aa6:800a:128c with SMTP id a640c23a62f3a-aac28749357mr4678624966b.11.1736187831570;
        Mon, 06 Jan 2025 10:23:51 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e82f138sm2278746666b.17.2025.01.06.10.23.50
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 10:23:51 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so2461621066b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 10:23:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmiN7chuYH9zvx/dMMz6vIkosKBGE0tlNbJBacb+mcotgEATeGSx11WMlk9N3YwqhDKunEHMtO1inc5nKY@vger.kernel.org
X-Received: by 2002:a17:907:7d8a:b0:aa6:66eb:9c06 with SMTP id
 a640c23a62f3a-aac2874939bmr4684203666b.5.1736187830622; Mon, 06 Jan 2025
 10:23:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241229135737.GA3293@redhat.com> <20250102163320.GA17691@redhat.com>
 <CAHk-=wj9Hr4PBobc13ZEv3HvFfpiZYrWX2-t5F62TXmMJoL5ZA@mail.gmail.com> <20250106163038.GE7233@redhat.com>
In-Reply-To: <20250106163038.GE7233@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 6 Jan 2025 10:23:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
Message-ID: <CAHk-=whZwWJ4dA-r54eyEZaiVpEK+-9joKid3EyPsHVRGAgEgA@mail.gmail.com>
Subject: Re: wakeup_pipe_readers/writers() && pipe_poll()
To: Oleg Nesterov <oleg@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Jan 2025 at 08:31, Oleg Nesterov <oleg@redhat.com> wrote:
>
> To be honest, I don't understand the wait_address check in poll_wait(),
> it seems that wait_address is never NULL.

Oh, it seems to be historical.

That *used* to be how select worked - once select() or poll() had seen
that somebody returns a "I have data", they set wait_address to NULL
because there's no point in adding any wait-queues any more at that
point.

But these days they do that

              wait->_qproc = NULL;

thing instead.

It seems to go back to 626cf2366085 ("poll: add
poll_requested_events() and poll_does_not_wait() functions").

So yeah, I guess these days the wait_table pointer is never NULL
(where "these days" is the last decade+).

> That is what I tried to propose. Will you agree with this change?
> We can even use smp_store_mb(), say

I think it's clearer to just use smp_mb().

The whole smp_store_mb() thing is a pretty random thing, I think we
could / should probably just remove it. It's basically a combination
of "atomic store" and "smp_mb()", and at one point we thought that
doing it with an "xchg" instruction would be better on x86.

And I don't think the one or two byte shorter instruction sequence is
worth it, definitely not for something like updating
entry->wait_address where there's no actual point to making the store
itsdelf atomic.

                Linus

