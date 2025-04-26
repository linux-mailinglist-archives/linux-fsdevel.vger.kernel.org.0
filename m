Return-Path: <linux-fsdevel+bounces-47436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA82A9D74E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 04:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F731BC5306
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Apr 2025 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954321FFC45;
	Sat, 26 Apr 2025 02:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TFNjCBA2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063C17A2F0
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Apr 2025 02:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745635653; cv=none; b=Jq6FaB8XQW/RC5yqvKdVFAtAqSGwNwQRvFJ3Nc7+6sJMZeJBLGQLvJqYB8FtI4ALeA98skvo165aN3w4wNuAHmMRw9KBx73c7sU5f4x5ho/bzAUfksnfXqTU5ucwd0UUPVUEz/+x4zf/A91as90iRhRP4Iv/Fuk9qWk8u95Qp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745635653; c=relaxed/simple;
	bh=dEmOUfiZRIXIVolwLjkWI1ddw6yx/lDkW5uzEFubTfg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QCYgrDXlh3oCB6NL3mwzn0ZKsisnMTdvBWYW1shCpwFY1AtN7e0IcCun735n9fpL6Pu2XwDz7Fzdpzxx9jKWr8y6WIOQqZhwgkogWw+ZbnSIyjbm3BRI4bRSwhiCTDnhC3DvksrO//tuDAYbH/Yz+kDovFJ1+bCYHJlUSmsHOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TFNjCBA2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2c663a3daso552918166b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 19:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1745635648; x=1746240448; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d+Vis1nKLgTG0tNyn050nySpncZ/GwqyHhgeT6wraGk=;
        b=TFNjCBA2DEOmrhZny426VOGwa/IpfZCKWEtkq8rGeEvvzu49o36r0fuTIBk4UOFt6m
         x6TNC1Emaiml+foO7cR5dRV1KuCy6ZpyNkI6qFUJxBzGI4O6kZwiBmCmkzHS4Ux/pa5J
         u6zW3gQmC2UrQ6XgquJxAc2wi4Jc74GT7W7LI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745635648; x=1746240448;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+Vis1nKLgTG0tNyn050nySpncZ/GwqyHhgeT6wraGk=;
        b=rgQ4jYI9UbHly6t9+AnEOm7eOqrieA33fdjlL+5OUWHB13l1UPcSMMxANCtOMMkZ5T
         5Sgqh18NYiIovaa8zeAhSWnBsyDVyFIjHTb7MzVQ2k/fGgMeHYcMCZVGH0UJYdR3+dXa
         V9uGaVYQJROE7vj5fqBe2btgf1GL96DLuaHsyTrQQddo2g9MuBSWRgBkA+hoSTj3nicx
         5dhDr8ZToB7C5sr7ds+mzIJawA2HP5iva4WPfUn7NbY4bx1aiQyWxo0JOlZbL5yYR3HB
         +xGjcOrdF3r7S64avx9w8VXMII19myz0p988uZ4kviZVfBAh6MSkPKmXzp4X43DpZb91
         SlOg==
X-Forwarded-Encrypted: i=1; AJvYcCV+WFglgS7uA3rbPqsEx3QbuBw2CW+UTjHo+f1mjPXTgdvCRYUB6ZYyqbYh4cvBt6DQ358U6XNYbzNvGCsb@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/l9+sA6jA+Zv4VWG/qqmuUifnaBIR4TgQzzNWqwzWUibt6qBx
	b3tYlmvNpCBrb4w0DhMrX+kgkcRIsxFd2T0NH0lyUZVRXx7oAZowh3F+W2FDyzgeRuCSbOgGRMz
	IxSU=
X-Gm-Gg: ASbGncv0GHCVJXQuiu5EmHPjz8W/4mCRcQlBAdjdMm/ZOdyC2LwalK8alHtRf6j7Z/q
	WAsFWY5qtf73U8vu0vlUyy5g0mY1tDJ/PCALUesoAFoWYJ2sboZJJBFIrS71S58whX9KhdmR35X
	6fOpPxzB12oTSkoufuu0K3Qav+FOYvoMChC1DWgodYRm0OO4h5EuKcafr99FGmWTPInQ/NEBHvP
	M3smcV8kpXYbPVYFtnHlluKOC0+cCUKyn31ON1ne+WeKdnC/0hh7qu2X8D5tSE4+Y+vHYyR3DIE
	HEFr5GA/4TPd+fsIUdSJM0CXUVPfDoM/+PkwhrfYYjAPT5n8e4auHTm6JBHXMVxOWWYcsCDeQfV
	0xuElPl2AnMJqcNY=
X-Google-Smtp-Source: AGHT+IEqQ1k9GYVlBmTW4QF0lC4Cp6/BFTAjhMRU7mvE7GjXv+lfUEQsOhHSgMq9y+td82kXMCeGRw==
X-Received: by 2002:a17:907:1c0e:b0:acb:8aa6:5455 with SMTP id a640c23a62f3a-ace848f79bamr119887666b.19.1745635647656;
        Fri, 25 Apr 2025 19:47:27 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ecfa8f7sm226389766b.105.2025.04.25.19.47.26
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 19:47:26 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so5335853a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 19:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXGB8veTyI3G+3OOtO3wHn3KBYh0IM/iCFxO5xq2ruax6ub0BkEu+tYU0/2R6R/VYYeJtj5iG3mzuORse5m@vger.kernel.org
X-Received: by 2002:a17:907:72ca:b0:ac8:197f:3ff6 with SMTP id
 a640c23a62f3a-ace8493ad90mr121410766b.28.1745635646503; Fri, 25 Apr 2025
 19:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com> <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
In-Reply-To: <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Apr 2025 19:47:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
X-Gm-Features: ATxdqUHnAFqikS6_GN0pI3h-AB6C0IvbAMYuZ-wE_sCeheyXsgajo17SdM6k4eQ
Message-ID: <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Apr 2025 at 18:38, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> >
> > The thing is, you absolutely cannot make the case-insensitive lookup
> > be the fast case.
>
> That's precisely what the dcache code does, and is the source of the
> problems.

I think you're confused, and don't know what you are talking about.
You'd better go learn how the dcache actually works.

            Linus

