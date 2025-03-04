Return-Path: <linux-fsdevel+bounces-43160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22BE1A4ECBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:06:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488C6169B1E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF22259C88;
	Tue,  4 Mar 2025 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cXdq4LAA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237D253352
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115059; cv=none; b=sU0aL+cKWgN+RhkH9WP/2CK1l+Z3cyJPG/wkNwnMsk/9YMwmiC3EeUs5ojZvfff2h+oYnfsIwBmZ7+fGL04hUXJm8x9oBf9onb2Og/klpMmQHDbMtP20mS+ak6vGDiNDo291Q73SGs+C6pLNCTYwqw/Vgpcow3Dujnfhoa8Bbys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115059; c=relaxed/simple;
	bh=AxRo0zwXpsaIo65pvoetfqMIqPPXFYbyNGJ0gjZ0tk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/d09geDibDqhbSdHZGRW6OPKti9ddDo/Ej47jdGfgIjF4IJeGQx7+A2fEq0Krt5KmGsbMbTIzXtYoRCcCkeOD3tHBjbZWcFtJK6ITc8iBguYI0vcculOoyBcT9sFLqM1RP2tHgsXtGAuYGo3uebOzwlIIfHy2nSu/zfhz4OS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cXdq4LAA; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abf5e1a6cd3so564116966b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 11:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741115055; x=1741719855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dkh2pb5EhGcPf5n6D2I0IyHjDxbdm1W1H8kQF4e+QHw=;
        b=cXdq4LAA2hWCNedsuqgPV38x2B7dpbxGRRuv0ex8X1l/CiNoMwFZTu0EWD65oXuVbf
         aGKi/1T3BFMYqQQHidLlEbuK+mWTeZYjmT4RrfZ/hk+FTnxnENfNIok4ejrdjUyPDmiU
         PkAfea82tjZKvFXdaLXgt6vPl9lDg3KunlW/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741115055; x=1741719855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkh2pb5EhGcPf5n6D2I0IyHjDxbdm1W1H8kQF4e+QHw=;
        b=u/5FXpEp8PrUhzGLvyptmW5dfD1fnSBBxu+URVx7ggL3Ocwi84bQKEs7wuoM1/cj6w
         1FgfcBAZWE0CoeOmeVcO0Pq8WPD8KkuUz0Mr2MlbWnj8fvbw5s84jMvD3KsAhB15LOPa
         Z3lwiiAIONE/Nw0Ofz4e8HISQi6ZefxgZsmIrAWpezrxJnKyIvnNEl46VEeYojUFA5OV
         PcigN0JslQDfhpi/ctjp1//PiFG1qJWJYyUFuI9FGMJ3e2BPEK3OkwhyuIURecDUgndE
         /+XBpUkktW9LTuJEL2uVACThOKSL++FbOd7GaOmu9IA9lys4ajQL40y2mRHH5F271yUl
         ltnA==
X-Forwarded-Encrypted: i=1; AJvYcCXVBWRg/fRIabI/8C3GkBDZsWmX4trnIy1QIcP31AAg+V1NVLu5QE28mks1Wv9G1J9Nt4mX0tpyHCXsrlMd@vger.kernel.org
X-Gm-Message-State: AOJu0YxwYbELtKPS9WhsYeYPMYLhIFvqtriaCyQrUB1pUCTle6qupZpX
	hWE6GijsUagwlq2qztK/fQuTGeHiGqEP3IK2dLTkLaIKltShmvBfBN40rKRtUEjxoy5rDdMUBw1
	ue8cJ4Q==
X-Gm-Gg: ASbGncsyoKu7d94n5I+m0QqMdMwPtaK6rwmqFWN5bxPc6IpPgMz8tTNtNK0K2wElXV/
	9qWGNJKI+WDz4kAa17oGI9x4lKJPFJlSHZaHmvQmQB3zzbuzP9LmILBdgb1YQUgFspNHvVmkJcz
	Uycs+hOWIi6zZXGw8kINFRq+3wh9XDPZhpctuffOxJD8OmmfMsEHsI/Xrub2Ntj4hC4MtRjNqGZ
	BUYlMibhtYdY3aXMJ6IEPS6ZxrGMRz6IKO3RUuvXsuVa8Vlo3ofsG3DgCGkgS2KoMgWry3B/IOz
	7oKWJb4FyfgopQnXYqFIyltVtvrTAXTYt27XiHaoJo0AU1I2mzc0uztMAdF10jWindFBhbQZ2aZ
	ssnPWE5W7xb8Ns3PffeU=
X-Google-Smtp-Source: AGHT+IExU4dfX2rSkN36gco4mLVF7KrhTtTw+JMNPGbD+aoA4MzfOmsdhXQYed0VnL+BDGFpANxXrQ==
X-Received: by 2002:a17:907:6d15:b0:abf:7832:bf5 with SMTP id a640c23a62f3a-ac20dc7f9e3mr33418666b.34.1741115054938;
        Tue, 04 Mar 2025 11:04:14 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1acfe9a5asm317593966b.119.2025.03.04.11.04.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 11:04:13 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso10355469a12.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Mar 2025 11:04:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBQsQbUrUNgwTlyvETZ40kZooEzP7YomvwPTyJUKrkK+HE6m+dZ/8gK1y9nqOka7UnzirRSoAtZN/Tq2im@vger.kernel.org
X-Received: by 2002:a17:907:970c:b0:abc:b8c:7b2d with SMTP id
 a640c23a62f3a-ac20dc6f379mr42747466b.32.1741115053374; Tue, 04 Mar 2025
 11:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <20250304135138.1278-1-kprateek.nayak@amd.com>
In-Reply-To: <20250304135138.1278-1-kprateek.nayak@amd.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 4 Mar 2025 09:03:57 -1000
X-Gmail-Original-Message-ID: <CAHk-=whfrgndT5Y8PJtHtFwhuef2eCEr46NUdsMD9MVEom_HXw@mail.gmail.com>
X-Gm-Features: AQ5f1JoQsXqnCtGHgj_JQVYfx3eeBRZjtvg4HR-JParHdoIQOMiLW8mY8t0w6ig
Message-ID: <CAHk-=whfrgndT5Y8PJtHtFwhuef2eCEr46NUdsMD9MVEom_HXw@mail.gmail.com>
Subject: Re: [PATCH] fs/pipe: Read pipe->{head,tail} atomically outside pipe->mutex
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Alexey Gladkov <legion@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Mateusz Guzik <mjguzik@gmail.com>, Manfred Spraul <manfred@colorfullife.com>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	Hillf Danton <hdanton@sina.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, 
	Ananth.narayan@amd.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Mar 2025 at 03:52, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> pipe_readable(), pipe_writable(), and pipe_poll() can read "pipe->head"
> and "pipe->tail" outside of "pipe->mutex" critical section.  [...]

Thanks, applied.

                Linus

