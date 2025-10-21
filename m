Return-Path: <linux-fsdevel+bounces-64940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 927DEBF743C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F5E188CCBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E77340A7D;
	Tue, 21 Oct 2025 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NUKtoHt1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6877260B
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059224; cv=none; b=VpNzx/+mlLfgvcwJ0bZGJC/2NkxWyUdQzXmdsRuObxkjXojb5M0xHtyvnnK1x0oisVFes3U4+uTynbjb/p/B9uXkvV5N+Q+hQF2dGEHQ6lS2GakxaqIqDpwYTlz533E+t3Ort71YLX3Ydr50wsgSLVA/0/7zM2CyFgNqtDakHCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059224; c=relaxed/simple;
	bh=OBPNoahtqLQlrv9m+tCXzf5F3/neltQCeKhi/sO8Jc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGP1AbY58x59nELt5y3J5MuQBqaFHKf9QzqNT5QTtXkmPn8rYuw+CavUaBcUY2vvSLQAtoDQllqD7PyMgt+AS+jYbTnHqXjTyokglnzgU2Ev00KiVRq4COxvY0SC5zKSxsIH7UNcolI3W0wQ2IYIpm3zh/QB1ZF4GxPef8GMCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NUKtoHt1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b64cdbb949cso938956266b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761059219; x=1761664019; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=NUKtoHt1GtEbaQBjrtLAkfgDsFKgVV+j0qyP7k5kNjFR47b9E7ouWBt2Oc8hNrU8cr
         EJndBmLv/Hh6i/gYMgM7jUARiCaE/5Raraq0bxl2kbtGrnFLj0kPylPjETXs3/QJZAAL
         eQT68HbQo1BvnjZ4U0MXU7cOC90jco+zV7lc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761059219; x=1761664019;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5p3iIWVRp3NUhUS8ltDIPiH8ErmpKdyMg8XkHtjDt5U=;
        b=vabtwRYZAgnbTFUpryahZQ6kwMKvMKL0aIK0vYdYldOaEp17QtL/9TSccb+2C0sY8j
         uOJ69vz1wupDHdZBgA40tIFuSVFs6p7F5Eg2RyNVlryZmRBIr4OqFsiXBm595rWykyQS
         19ZBdAzPgRNLQJYRbp2qbYvvQPKll/B8kWuNICyL5BD1W1keF7NCqYqs7+p35d03fkAd
         vdnBz2aWTjIWG/laKsCc24UE8OMtzlZCBSXioqqZAEeF4GjWiJQGERPir67E7lI5Wx3h
         pQPgH11020tFXIZ8qs7sehxM5EXasn6Ey9XDFiG14jKXpqDHB+zwisbvSFfcH1LaYT4E
         g2+A==
X-Forwarded-Encrypted: i=1; AJvYcCXVT5VlLE/s/lsKT/2fI42tzwSAfoxo0xUejOv6Eh0zA1C8GKBam1dSI8Hcs51ReUQswiR9Ptr5zd+Eahfb@vger.kernel.org
X-Gm-Message-State: AOJu0YwjIF+4qrzc2q7H2yQBRuGVMCEup0kImIRE0nC25rJURkcOcxhY
	pnVh16RvBsFb8g7AA38cKASA3ypcrnz1NjjUNScggBsAJYl6CXcmTeq5lQo6kMXXOQmkm1TP/As
	RAn9GIDA=
X-Gm-Gg: ASbGncub4ImxICXMYEwcYadXypjMZ/QD6oIfeIY/tdm9JMMlBXwT1tL/kvOQwpjheCS
	jtatAsfkSUr1EO0IgQf4aujm7oqnqeeIhJxR9MTw1ZQhq/7r8N+8/vjPpNUGjohRtd1s42FF9W2
	7vPdly5s6AmQqsyosdiOpiMNdEGl774v10G8YgUPqJSG+xX8I6Vdlzm7ckV1GM2TJwgZNHm3ptD
	ALyQE0WCSabP9YJzA2JxcZcJ2YHVkfR6o8vdcnZ7bupsuvVHM8Yhnm24Ddfy0n6CSs2e6Qt+yZV
	pfhi7ru67qA18gBNz/Vmwm6+l4IIDGFC/zA7gDD1ffZ3GdcAWHO7+jIN9Lu8uq4aQGAiPZ5/IJ9
	Ef7nAm2a+7tZlRDUc9d2BYWS4kg4rlqjmgKetjyY2HAiBqJzPx6vRyqzKT9DVJXf1AhpYogOgSL
	JL4XLpZhjZTyNHsBTulc+AwC6Vwpj7c/N7IaloO3soOky3/D0mjkox/8kBYjxMzu4Pzna+8Zw=
X-Google-Smtp-Source: AGHT+IFn/A7G5UPrV/lJnpY94Pfp49f9Kf6E8gSyAZHeMPls6IwR7LkD+a36SxW3Fm9D2BeFlw5YSg==
X-Received: by 2002:a17:907:948f:b0:b3b:d657:482b with SMTP id a640c23a62f3a-b6472c5c5cbmr2005588566b.2.1761059219464;
        Tue, 21 Oct 2025 08:06:59 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83960e6sm1089536166b.33.2025.10.21.08.06.56
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 08:06:57 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so7667428a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 08:06:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVPy/zzaN0lC0NAmm7HhCqheaDxDosUHl8Clx4tJTxQk1hkMtRFmgM7ajTvlXluF8/MWX+eM0IBw6G4Ky3X@vger.kernel.org
X-Received: by 2002:a05:6402:1ed2:b0:631:cc4f:2ff5 with SMTP id
 4fb4d7f45d1cf-63c1f6c39a0mr15531402a12.25.1761059216055; Tue, 21 Oct 2025
 08:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017085938.150569636@linutronix.de> <20251017093030.253004391@linutronix.de>
 <20251020192859.640d7f0a@pumpkin> <877bwoz5sp.ffs@tglx>
In-Reply-To: <877bwoz5sp.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 05:06:38 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
X-Gm-Features: AS18NWA4hFVtubdvPHiqdyKph2ZRKrwMfjnw6C6eEZqbhQOMaKTPF5q4gpdDvSA
Message-ID: <CAHk-=wgE-dAHPzrZ7RxwZNdqw8u-5w1HGQUWAWQ0rMDCJORfCw@mail.gmail.com>
Subject: Re: [patch V3 07/12] uaccess: Provide scoped masked user access regions
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Laight <david.laight.linux@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	kernel test robot <lkp@intel.com>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, x86@kernel.org, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org, 
	Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org, 
	Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
	Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 04:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, Oct 20 2025 at 19:28, David Laight wrote:
> >
> > (I don't like the word 'masked' at all, not sure where it came from.
>
> It's what Linus named it and I did not think about the name much so far.

The original implementation was a mask application, so it made sense
at the time.

We could still change it since there aren't that many users, but I'm
not sure what would be a better name...

                   Linus

