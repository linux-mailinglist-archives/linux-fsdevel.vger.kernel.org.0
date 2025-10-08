Return-Path: <linux-fsdevel+bounces-63612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 43519BC61D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 08 Oct 2025 19:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 444AE4EA2CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Oct 2025 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9EB2580D7;
	Wed,  8 Oct 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OZ7qzY2t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567D41E32D3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Oct 2025 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759943049; cv=none; b=ovvLLzAbFCpNLySj1+0IVR62eYR0Fx4ia2i7ewFsJUPjqEq5r06se0PxOUeiWXH6Wo7Yv7Jp7PtvG1thUGr3/CRfoyTSY1x53ny5A8ZASMPQXbQ0wELL/Jiw41Su8OIeyE2SBXdEBXyBBoYppgYebTrtTNTjn577UFzFOdk+MH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759943049; c=relaxed/simple;
	bh=vhcBtUhS5dOmZrbQaeOTEj9QEKALj5hrYKH+ldezhmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mi665EtRAKYUg/Vuwz3oPjPiJnS1lZKg7HciwhNId9/92Mezfhna0UWzp+8ps7wkoTjIGIIyzNA0/JJ/n9N+7N1xZ6gfB1Nw5v4Ukal7UuklPqH+NntCj5W/9UdQAlQE08hikql96qKSW+zd9m9zTgjYNHJp+cU1xRDuLuHbQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OZ7qzY2t; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fca01f0d9so65840a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759943045; x=1760547845; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hB4y1UGEVpwhub5wcO6FK12pD+0ug2lV04A88O4v4vw=;
        b=OZ7qzY2tkadbV6qGeKEpDRvL1Rh36EWG2k4UqMx2n/Njf3DJtm7rC9YaggJ7kje/ae
         pkfAhpO2gKRI89ozkXamR0CPJ1xto2WoDEVN0LlDN8i2/Q6bLQ+eTMRaMRzqzEnJmEo4
         DpTd8xkCCL2JIgrMAEkYqd0ITPsNOruK2XFM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759943045; x=1760547845;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hB4y1UGEVpwhub5wcO6FK12pD+0ug2lV04A88O4v4vw=;
        b=gqdmIVkoBsPWUUGbr+hIfKzd0N1/Ad49kudONFxMXLxOx3OnFDLbBvX6iXD7GR4M51
         w84ftfp27DxlIkyo5IHze+QS44ouknZY5xPsbbJS/n1Lpe+vGzXnHhYm/74TAA+aOto7
         JqxuTQBTN8O+Ik/NK7KQqgTv+d7IYbnpANV32PDCU9PpSJpvBNhi/j1RMiNNfIGaXufJ
         75Gf29t+IvaGvecyJRL727wD2YWRx1DyAvmfZPYTHT/vvxfzhIuI01ETQDl+GL1IV/Wq
         8UxSbPUg3VCDFLqwU258M4ZQFRUIrQM7YO22GYPd2DFGChKvKqwkS6HbKr3A76r/E32C
         7JTA==
X-Forwarded-Encrypted: i=1; AJvYcCVAVrE027Hzy+kZ4ZqJb8wW7KWEiUWB6E9/R0wZer8Ugb40pIYYgZsluQSqSVDVeP9jiTYtWn04LyGXVAdH@vger.kernel.org
X-Gm-Message-State: AOJu0YziGQyDLmHUCA3/4+5M7x2hDPb+ETQV7Ve1E0yOqO9jo4za5OSO
	3eB7AFNQm+NWaWnSbR4PEn2erLcu/3O7bX4/Ebjh/Fee/uWfrXcWFW2/rdgYKJ0NLLLxfxwC3ao
	zGmMT06Y=
X-Gm-Gg: ASbGncuYylQgOJPH92BiM5rtmJwzjfTYBBCt90uZrztH62xlwhrDufEY5FP12pt1KsA
	j78/63PxPcxvl5zp39ZZ/P7DiyQvBqDBhELPAnaFbkCzlRD9drdcgTWrl6ZutAXkYt/Tkt1cekB
	k02La5DkYqoCqmr5zXFyFMXpruANcHJmECiM6R7WKzezuhpPaeFTwymGwAuIAXH/5Q9pl56Dqic
	QYRLf0Vkqr6ScXANBVnliPz+p5NYV1JDGNAGDVOfwTjPcsMLyzyh4FU84hwMIaocJtzKy5r0lkV
	/RqKcg5bmyl/m83IMSBPeq9SjF18Y5meVrDPeQRLlODO52VNe+cAaLoUQv/pmlR20Nqa0liONXo
	gUGLqnCkq/okH/WjEKyM/kOhApwVQe9OOLOHDoCsL/Z6/oJfeeX7QB7uy/JZb1erWJ6aSDAUX7l
	z4H6gCroltv0uNragq79e/
X-Google-Smtp-Source: AGHT+IEAQfPTNjKWCc6k7YmAlvBMLLO+oSrlupAvLyJ+eYYUitC/Fl3+ZP9dm919aSnYyi6OPq1f8g==
X-Received: by 2002:a05:6402:5244:b0:633:d0b7:d6d2 with SMTP id 4fb4d7f45d1cf-639d5c3eb8amr4051204a12.18.1759943045307;
        Wed, 08 Oct 2025 10:04:05 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-639f30d5136sm394958a12.14.2025.10.08.10.04.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 10:04:04 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso104244a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Oct 2025 10:04:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwPN3BOcl8Q2GQUmD7pytqpVZ856aeiboZ9kTNQQXDQT4VKhHSby5dC/n3AeOYLeezTfFzSAYriqIv/03+@vger.kernel.org
X-Received: by 2002:a17:907:971b:b0:afe:d590:b6af with SMTP id
 a640c23a62f3a-b50aaa96bb0mr522464266b.20.1759943043731; Wed, 08 Oct 2025
 10:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whThZaXqDdum21SEWXjKQXmBcFN8E5zStX8W-EMEhAFdQ@mail.gmail.com>
 <a3nryktlvr6raisphhw56mdkvff6zr5athu2bsyiotrtkjchf3@z6rdwygtybft>
 <CAHk-=wg-eq7s8UMogFCS8OJQt9hwajwKP6kzW88avbx+4JXhcA@mail.gmail.com>
 <4bjh23pk56gtnhutt4i46magq74zx3nlkuo4ym2tkn54rv4gjl@rhxb6t6ncewp>
 <CAHk-=wi4Cma0HL2DVLWRrvte5NDpcb2A6VZNwUc0riBr2=7TXw@mail.gmail.com>
 <5zq4qlllkr7zlif3dohwuraa7rukykkuu6khifumnwoltcijfc@po27djfyqbka>
 <CAHk-=wjDvkQ9H9kEv-wWKTzdBsnCWpwgnvkaknv4rjSdLErG0g@mail.gmail.com>
 <CAHk-=wiTqdaadro3ACg6vJWtazNn6sKyLuHHMn=1va2+DVPafw@mail.gmail.com>
 <CAHk-=wgzXWxG=PCmi_NQ6Z50_EXAL9vGHQSGMNAVkK4ooqOLiA@mail.gmail.com>
 <CAHk-=wgbQ-aS3U7gCg=qc9mzoZXaS_o+pKVOLs75_aEn9H_scw@mail.gmail.com>
 <ik7rut5k6vqpaxatj5q2kowmwd6gchl3iik6xjdokkj5ppy2em@ymsji226hrwp> <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
In-Reply-To: <CAHk-=wghPWAJkt+4ZfDzGB03hT1DNz5_oHnGL3K1D-KaAC3gpw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 8 Oct 2025 10:03:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
X-Gm-Features: AS18NWDZIu5RNvY1OZ00h_c_VuBUBbSYmDpRpxsYacEd419cgpTVj3E3FoQRX_o
Message-ID: <CAHk-=wi42ad9s1fUg7cC3XkVwjWFakPp53z9P0_xj87pr+AbqA@mail.gmail.com>
Subject: Re: Optimizing small reads
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Matthew Wilcox <willy@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Linux-MM <linux-mm@kvack.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 09:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 8 Oct 2025 at 07:54, Kiryl Shutsemau <kirill@shutemov.name> wrote:
> >
> > Disabling SMAP (clearcpuid=smap) makes it 45.7GiB/s for mine patch and
> > 50.9GiB/s for yours. So it cannot be fully attributed to SMAP.
>
> It's not just smap. It's the iov iterator overheads I mentioned.

I also suspect that if the smap and iov overhead are fixed, the next
thing in line is the folio lookup.

That should be trivial to fix by just having an additional copy loop
inside the "look up page".

So you'd have two levels of looping: the outer loop over the "look up
a folio at a time", and then the inner loop that does the smaller
chunk size copies.

One remaining pain point might be the sequence count retry read - just
because it has that smp_rmb().

Because while the *initial* sequence count read can be moved out of
any loops - so you'd start with just one fixed value that you check -
we do need to check that value before copying the chunk to user space.

So you'd have one smp_rmb() per that inner loop iteration. That sounds
unavoidable, but should be unnoticeable.

SMAP would done in the outer loop (so once per folio).

RCU and page fault protection would be at the outermost levels (so
once per the whole low-latency thing).

At least that's my gut feel.

              Linus

