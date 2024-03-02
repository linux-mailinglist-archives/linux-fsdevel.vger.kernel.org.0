Return-Path: <linux-fsdevel+bounces-13376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B173A86F1C9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 19:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC0F1C20DD0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 18:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFAF2BB1E;
	Sat,  2 Mar 2024 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Zo3annmV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79C2900
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 18:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709402836; cv=none; b=k8GXHnbWv5L4mP7gpiHEW9ugjAXoQRMLKTMx3sNoz5R8XrCy+j3Lel0rldgj4UoabZyFEP2kpvLKwyn4dAPsh/kZ6RWHF5OBhVHUiatbffJc1n0rO+rLPWWtEVaV3jE9REv5BJeAnHAoyUOFsDaenoElfGOJYCdigqtPx5tpDfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709402836; c=relaxed/simple;
	bh=oPp+kEJm2yuQWRduHCnpZa6W+Rr0cKGzx+MpiFA+B7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfxUoq46E7iHOBwB31m7leJxuw5VqZMykDszWVd5/vn5efpX4lQqxklH20kLq18wJrjlAzdQcHvmAlgGglGphcau0BoFejQ9D5zGFVoDbIXhLIRB94j95/sLKLFhXCaUh+WPMW22Prq+F7au63g3MsFAkrvZJUX07JVWmuzDA60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Zo3annmV; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a43dba50bb7so456088666b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 10:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709402833; x=1710007633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=Zo3annmVtbDSNXGlWvuyvADnSauThCi909x2m3t/LIUIyLp+Tqn1ved+dx5fxjUmwW
         aX+zyO5N2jxyeB1J1QoNkeMDWxAUBc+e05KQ3SVzMYyOmJgPd1ZNljeNN15JjvmlOFdD
         wNrwZPM/TvoO/qhLJt0UwXogK/fjNDBhZ9ghE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709402833; x=1710007633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgHiAUIVGDD+1DgrVyftk8s8h5JugoTCX2MAvO9xGEU=;
        b=DQGfKUFWo8yLAq/1qwo04EBKWFNvz+krqcp/NavalbIoqCFfLTO9EJgUTTwdCqeA3+
         Z/ZwDd4MsVi67+wv7yKqLDoMWa8laa2UChzIKJvHnOaGVFS0905KfYtU5mlt2IO2QZnx
         T1+Bp7XqJsEaoAAABxMZuI4Kv/8NlkAXRWHf5C46yg5rDkynhFk+j6wz9RsI9yiGf725
         q4vwrV6J50c01UPkkk3hTswDdlaneUNPo4e9LXWq5ptT4pMRX3afMLRRZtIynMqawkJe
         YUM3rznaod1UTXJmqId5Yd11eKPJhdU8NVOH42Eqq2qGnVFls6lftPntEGoLY2cWDTG+
         CoRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDkDK8IMDNzwGl6Xr3Wgkj6+kuf4qfAfrwgUCFkjepIKrF/2anULUM8ntxq7vWutiNd+bjVCI5h8XC+VUuBTXPyPUex5K4Xrwz9cDX0A==
X-Gm-Message-State: AOJu0Yy3ppdFAiUNn5sB1COydNsEt6mZX43SMlzt8oNW9qW2DK0Z/zSp
	YBGLhAvfT5LndPi3xq7BhkaE2BMzk+2FbeFcipEYgrwEM1ASK4gvRwxd19xtq8ksYcYu5PAOky/
	Kym0jNw==
X-Google-Smtp-Source: AGHT+IECx7pKSL52o30yehVOWcc1IeQ2NEL9TYzdsfKHMHGvN2+qClrU92a/oPeogPhNvxwDvpKchA==
X-Received: by 2002:a17:906:aad6:b0:a3f:d2f3:d226 with SMTP id kt22-20020a170906aad600b00a3fd2f3d226mr3750147ejb.17.1709402833285;
        Sat, 02 Mar 2024 10:07:13 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906348f00b00a43e5f4750dsm2919881ejb.23.2024.03.02.10.07.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:07:13 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a36126ee41eso504986966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 10:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXTqp2CFKwA+L33NrZTuHOzykaZBqv/11klIPb9c0EYuiT39rhvzdlTgO9TDlXnMnHiwWwXIh14lfVBFvuvczWaHkB7CeKsqFvAbC9ufw==
X-Received: by 2002:a17:906:2c53:b0:a44:f370:e2ce with SMTP id
 f19-20020a1709062c5300b00a44f370e2cemr785292ejh.16.1709402832627; Sat, 02 Mar
 2024 10:07:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com> <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
In-Reply-To: <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:06:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Message-ID: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 01:37, Tong Tiangen <tongtiangen@huawei.com> wrote:
>
> I think this solution has two impacts:
> 1. Although it is not a performance-critical path, the CPU usage may be
> affected by one more memory copy in some large-memory applications.

Compared to the IO, the extra memory copy is a non-issue.

If anything, getting rid of the "copy_mc" flag removes extra code in a
much more important path (ie the normal iov_iter code).

> 2. If a hardware memory error occurs in "good location" and the
> ".copy_mc" is removed, the kernel will panic.

That's always true. We do not support non-recoverable machine checks
on kernel memory. Never have, and realistically probably never will.

In fact, as far as I know, the hardware that caused all this code in
the first place no longer exists, and never really made it to wide
production.

The machine checks in question happened on pmem, now killed by Intel.
It's possible that somebody wants to use it for something else, but
let's hope any future implementations are less broken than the
unbelievable sh*tshow that caused all this code in the first place.

The whole copy_mc_to_kernel() mess exists mainly due to broken pmem
devices along with old and broken CPU's that did not deal correctly
with machine checks inside the regular memory copy ('rep movs') code,
and caused hung machines.

IOW, notice how 'copy_mc_to_kernel()' just becomes a regular
'memcpy()' on fixed hardware, and how we have that disgusting
copy_mc_fragile_key that gets enabled for older CPU cores.

And yes, we then have copy_mc_enhanced_fast_string() which isn't
*that* disgusting, and that actually handles machine checks properly
on more modern hardware, but it's still very much "the hardware is
misdesiged, it has no testing, and nobody sane should depend on this"

In other words, it's the usual "Enterprise Hardware" situation. Looks
fancy on paper, costs an arm and a leg, and the reality is just sad,
sad, sad.

               Linus

