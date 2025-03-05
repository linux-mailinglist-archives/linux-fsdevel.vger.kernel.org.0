Return-Path: <linux-fsdevel+bounces-43279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFE0A505AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 17:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59247188C6B8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 16:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68071A7253;
	Wed,  5 Mar 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ePFCYoO3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ABE1A5B8B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741193453; cv=none; b=BdOVNtHc1WzISB80nKSaKTdJr6Du7vBCPrsrNKqJve42MrX4EqUQkK8l1243ms9VkneOJBCKd65nlMuUno36vrql+p0Vxk1UHdFybRy16ln5wGG+XtIqWyDCvbOzCYcPdR9VgvTjKh6TzXp9Qr3RO+xUz5wso1S/2rf6buHKBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741193453; c=relaxed/simple;
	bh=ES3B4ydqeVIBq5AhSYvRXGBPwvfrSwoyy7i06aA6QKY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kIWm5YMr/0DdRRDZfB3hsWWW7gEGMFCkRQTofLm/R2sL5DHGP9H7qjHUU0aP5NdzgOvMysSuYe1/Ei8TLanEKTU2wlumQCtj5MoE3YCgiMujr3nwxT8TfCNxqkH5N6b67XiRA6xbVf4fWjpNsNJl9ENME0Hrmkja7eJalJSYRds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ePFCYoO3; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e4d3f92250so9799350a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 08:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1741193449; x=1741798249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IKNxmurIaMvHrB/Je+WV/izNtxkUNd8xxxAxHkdSWn8=;
        b=ePFCYoO33nRHfwsw+MuRuMr0YlHiAEuWRXTMpqLmL3kY8w+vLexSv15HeHZrqxkWux
         ForJAYdjzCU2+/+V/jTNlP1ZG3DXZGqbP/Ymx87fK25tAKpVvd4JwHSdseYSy6v7x1Os
         q1Jmb/I6Aykq4szZpe4rYIE/hGo+NSZWKjq8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741193449; x=1741798249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKNxmurIaMvHrB/Je+WV/izNtxkUNd8xxxAxHkdSWn8=;
        b=s3I4b53ljlZZ6WNXMFkn1MZMriZ4Uh08YgObyAvbJFwPJpsB1CVKfrAh/z+c5ZhWZ9
         U3kWK3A4G8sac5I+fcCzYfxKgDNUbWXdJ+SP1tr22jfHxC1XRZn/DvYJO24HJiL9WL86
         P7AceRw6eA1HflOQ7LF0vOya9o+8A5V70XbvdQ9fD6bXdjX6MxeCbAhqoxivPoe1LrZn
         /kW0Su1K2Fl8f1A+IZkrSBmdLUxuVwYwm6IwXeXQY203sdFrEyfX7+Xq7+fgSX3TQ2nN
         olRC5D7ttlraelt5gQbZfiZ/VduSA7XxQhLph6DR3lfAm0jXl3OwJgaePQSDx9XF9pfU
         ya7g==
X-Forwarded-Encrypted: i=1; AJvYcCWLgRF1N3dkLuo5QuLq1dQUvlMa8EyF0Tj7OuxnwbCjEBXAzvxEgWJA6wTcZcJqh02+z53w3p246kxg0mRo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ZEeEpNICpapeWSspSlUPeJxRHH9a+V5jYrwRfO+6+Fqm/Qt3
	OHpVQ/aJeYGBcPLu6sshU0VyjV+hZnTBjDN7x/0AgAFvpJPhUjU5gVe6844rRA5/tAtQ94Ob+aY
	tQasNqw==
X-Gm-Gg: ASbGnctuflkKpkC5Qk85Dq6uJOywGQiHoUzWk90wSqGOkDmOnHAcdNa3qRTbe0LHDmh
	NKcErXVuQJirYQejdhdrC++8xR9xoLEQlN6P1WHNdUwf9uC4KngFzqmMCyaxelKAN6ahKB7AZaK
	ElMnEJ0Up7vEQxbMyd/BNwCwrsBVJrkEUOOj5EbawgwLs0szccgMTilkK1VAvdQAPdRaW/Qx9c7
	hNObyWDdH9OCrBiNvU5McMcA9Fexz6o8NIDZw8uKHzxKnSw5TWHJBFDchbEv9DocVVq1LZDNCpK
	bb4PdA0rLw/afjSw3gbuYUVFSyMT8S9Jk74Ahvpen3AiisFvkIUvaGUDyZvhD63LeCjM2vL9/p1
	2LBVmmVKBZgqsk54Xb2A=
X-Google-Smtp-Source: AGHT+IFcuKbfCqeF7FMIHjXzCYsl/2ixZYk2EURB9rAYmWNLJL96D6WwH5vfstolDRRkpXM6iDHmjA==
X-Received: by 2002:a05:6402:42c8:b0:5e0:5605:211a with SMTP id 4fb4d7f45d1cf-5e59f3d2448mr3783200a12.18.1741193449030;
        Wed, 05 Mar 2025 08:50:49 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c43a53a2sm9764762a12.73.2025.03.05.08.50.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 08:50:47 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso1026208066b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Mar 2025 08:50:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXeoGoRMWvz/6qPucDOiNihd2ISOQ3Y8GF8PKLp0NirmSayK6L+o5RFE4Pmn4eR02j3QYEHiIosC9fKrtCT@vger.kernel.org
X-Received: by 2002:a17:907:7b87:b0:abf:6b14:6cf0 with SMTP id
 a640c23a62f3a-ac20d97e7e8mr378423166b.12.1741193443692; Wed, 05 Mar 2025
 08:50:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228143049.GA17761@redhat.com> <20250228163347.GB17761@redhat.com>
 <03a1f4af-47e0-459d-b2bf-9f65536fc2ab@amd.com> <CAGudoHHA7uAVUmBWMy4L50DXb4uhi72iU+nHad=Soy17Xvf8yw@mail.gmail.com>
 <CAGudoHE_M2MUOpqhYXHtGvvWAL4Z7=u36dcs0jh3PxCDwqMf+w@mail.gmail.com>
 <741fe214-d534-4484-9cf3-122aabe6281e@amd.com> <3jnnhipk2at3f7r23qb7fvznqg6dqw4rfrhajc7h6j2nu7twi2@wc3g5sdlfewt>
 <CAHk-=whuLzj37umjCN9CEgOrZkOL=bQPFWA36cpb24Mnm3mgBw@mail.gmail.com>
 <CAGudoHG2PuhHte91BqrnZi0VbhLBfZVsrFYmYDVrmx4gaLUX3A@mail.gmail.com>
 <CAHk-=whVfFhEq=Hw4boXXqpnKxPz96TguTU5OfnKtCXo0hWgVw@mail.gmail.com>
 <20250303202735.GD9870@redhat.com> <CAHk-=wiA-7pdaQm2nV0iv-fihyhWX-=KjZwQTHNKoDqid46F0w@mail.gmail.com>
 <87h6475w9q.fsf@prevas.dk>
In-Reply-To: <87h6475w9q.fsf@prevas.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 5 Mar 2025 06:50:26 -1000
X-Gmail-Original-Message-ID: <CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
X-Gm-Features: AQ5f1JpWO33IMmOwg7UfUdLzDWyAOlX4zxQSS4AWUM-aJeee9tnDsKOQREulDIo
Message-ID: <CAHk-=wh6Ra8=dBUTo1vKT5Wao1hFq3+2x1mDwmBcVx2Ahp_rag@mail.gmail.com>
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still full
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Oleg Nesterov <oleg@redhat.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Sapkal, Swapnil" <swapnil.sapkal@amd.com>, 
	Manfred Spraul <manfred@colorfullife.com>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>, Neeraj.Upadhyay@amd.com, Ananth.narayan@amd.com, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Mar 2025 at 05:31, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> On Mon, Mar 03 2025, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > +/*
> > + * We have to declare this outside 'struct pipe_inode_info',
> > + * but then we can't use 'union pipe_index' for an anonymous
> > + * union, so we end up having to duplicate this declaration
> > + * below. Annoying.
> > + */
> > +union pipe_index {
> > +     unsigned long head_tail;
> > +     struct {
> > +             pipe_index_t head;
> > +             pipe_index_t tail;
> > +     };
> > +};
> > +
>
> -fms-extensions ? Willy wanted to add that for use in mm/ some years ago
> [*], and it has come up a few other times as well.
>
> [*] https://lore.kernel.org/lkml/20180419152817.GD25406@bombadil.infradead.org/

Oh, I was unaware of that extension, and yes, it would have been
lovely here, avoiding that duplicate union declaration.

But it does require clang support - I see that clang has a
'-fms-extensions' as well, so it's presumably there.

I don't know if it's worth it for the (small handful) of cases we'd
have in the kernel, but it does seem useful.

                 Linus

