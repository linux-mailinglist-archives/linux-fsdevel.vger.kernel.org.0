Return-Path: <linux-fsdevel+bounces-47438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDC2A9D756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 05:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691841BC3BB9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 233A62046A9;
	Sat, 26 Apr 2025 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g49FwGw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCEA1F8EF6
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 03:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745636670; cv=none; b=AdC85sr1AxEMV0mtwWrz3uLEQlhlur4GyhC9XQTXSThC2U3hbA9c5EYwPpTfFDznTjPVJAZ4+5LEdA8gpQykV7hwJUlDgy9Wz9Lru2jrUizPCLl+EyNbYMIaVjgOGcvnxydApjKAdWo7/zllAlGoe8BQLZSzVU7W6MxDFBvQYpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745636670; c=relaxed/simple;
	bh=GTJ//8V8E4lhqHArq3UxGsIGl6/VT0BfXlXZWxH9QFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7MLxky1QRwg+U+4iiGEizBc5L9vXEqcTKMUur9JGnD5Yy0fUo0i2WFwMpC6S+fT14ybi+OhNWFf9ceGsc9KdFvblWqkIJKrFTFMK980TPFrJ9Oa4dmnnIRnRhWb3B/m8jYZS9RaLwx0QELQma+MXFYB1qRzuJ6j7SHmbkEkFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g49FwGw1; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac7bd86f637so773372766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745636666; x=1746241466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oPhqmcKvY9AvewH7vCAuPy8QpwgWU5A4tiUVrwJrrSM=;
        b=g49FwGw1I1RVSUaf4Q5tvN2QrbCVvl7PUJw2EyA8jTr/ni9xu4Qh5/gPL3zq+OgjfM
         oURQxZTI9HWxecyIF9qdWwzkzG+T8Usj32Idi7/1l4XkgQ3yuPT0WjBxBm+RgH+Cierk
         BAQk7CvG7Bx/6mj7XI8YW36rXruav6bUTOMhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745636666; x=1746241466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPhqmcKvY9AvewH7vCAuPy8QpwgWU5A4tiUVrwJrrSM=;
        b=pviI1vgeRMLEdlkkVPemCs0g1DY9oIpPCzpuX0233dLV/5TqF6o4IKd1B9f9pJTLcN
         ARhThs21Zh59YVdXt7LGwdfO7Ea7vPjIZBdNaZ9HnLK4mxGu1pvWEjQQPgTq2NJAtejI
         Ft6vcKjxVWBmhTE1g96JfdMQliLXwvvWO8Zq498Es6JH5Sl2SF7X8xPeaNd2RvLsB7bt
         5SEl5rzlFPMsm8O9HS9vbJtVEwvBdAdS4W3pcS9xQnu21NnFpS2bRJyBCpLIjgJpD0qn
         lmOwWIfwGnic4XVfWA8x9Rb8nAkB6PlAmrz42wO44Eq63DmktXkeWRsQvAMiOYtCn3MW
         qltw==
X-Forwarded-Encrypted: i=1; AJvYcCVEGv0OxGTLkrr1HgS/bOc6dGLe6/Rwsxg/vPtsJ5DausmdbbC4WBcyOytQsKdKDtNoEp0CDPdfRGZFg85t@vger.kernel.org
X-Gm-Message-State: AOJu0YyKUhI9oiodAS8pxoyk95QV7txe+UV38Kvmzf7QMX2G2lW2b3tJ
	j70I34n3leLOvuihLUM3QGQx7DTwWb5Nn2SZ/Wqr1jqUfxksTwp2xE6WP+ApGQcTg+WSrFHzCpa
	7uDg=
X-Gm-Gg: ASbGnculugmbGq5G8HvLDhZiV23BGQveoeojilgiPaUoW47geZ5Ka52c6rNVrrSL80R
	dK6ULpbJIglGP0O0zdPATmX6A13FUPco4eGozSuDEpHXh2NU37MwG3zcXqbCldOjDlcobbmn4Vc
	gXBXKbik8STULJjjcfgFsvnNHH9c9fms3STqhkFu/JP3sj4MCaAvM32SbR94VaigvdEXL/mGo0Q
	2+syRJR9EqlOn6mDvSL7hYyVlxV4hVU2wUjj3oG3w+gBFoU7uw9OKq/LYT79/aSLwEf2Bvg1lTd
	oeb017mj59wEltPgTZjGWtRs/DaPSOo4FbRj9aVn/3tao7ekpjU9wPd8dY0NIKm8d7BKJYX1kXm
	pft+JV1X6jrRGLBE=
X-Google-Smtp-Source: AGHT+IG1blzjjzrOR/SW396VZVQW16sCRAsbhflaenebVwC3sVQQ/M1Ul/LoyK7039WixhYb8QEO4Q==
X-Received: by 2002:a17:907:1ca0:b0:acb:aa0e:514c with SMTP id a640c23a62f3a-ace7339d4b8mr408115566b.2.1745636665735;
        Fri, 25 Apr 2025 20:04:25 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed726a8sm224276466b.150.2025.04.25.20.04.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 20:04:25 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2aeada833so568087066b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 20:04:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlFZZyGkNIS32G02/PC3+gpn2+oryCDYzXvruXx/PNJ/nOhVCS0HyZfVMwQyF0+yAVDp0huWqJ3FoC9ZHN@vger.kernel.org
X-Received: by 2002:a17:907:7da3:b0:aca:95eb:12e with SMTP id
 a640c23a62f3a-ace73540c92mr337021266b.24.1745636664671; Fri, 25 Apr 2025
 20:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com> <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
In-Reply-To: <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 20:04:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
X-Gm-Features: ATxdqUHS8znrEYMOPUF1a-wv9B602cVOVCl5sRHxinjIxR42DruVX1W-GKZj2oA
Message-ID: <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 20:00, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> No, what I wrote is exactly how CI lookups work with the dcache. Go have
> a look.

Kent, I literally wrote most of that code, and you are claiming that
the CI case is trying to be the fast case.

Not so. Get a clue. The CI case is the "nobody cares" case. It goes
off and does nasty stuff. It's very much designed to *not* affect the
sane case.

The things you complain about may be exactly those things. You just
don't understand the design.

             Linus

