Return-Path: <linux-fsdevel+bounces-59879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F67BB3E90F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594323B4A59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D6343D98;
	Mon,  1 Sep 2025 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="IyVq172b"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3538F345733
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739193; cv=none; b=JLoA/JvfTashRrmF96JSWVekXgPO2N3mihorJP6M6MDR3RvSmj56s7fsBXsnAT57PB9S65ZQTV8hb8yyPOlCfRhKIw+7bSXh/7tSCtpOzHIwI74O+90CkIQl5k7RaJqst/d0JgP1r8nBLitX8r4RGAQrt6IslfTVqNCDvOWCmKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739193; c=relaxed/simple;
	bh=RTksJ8/0/nMOSHK1v6hFgH7Xl8rur3P7qYdlo1+hL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D1+arlffir18A5JxRJTdLqFJZkmmlgmcCBGJLlR5l8KS31jkeQjYLR5h1ZOSZ+iaIxtD0sfid+KXPtDeRhmxIDIpZd3igVlO/RqPSJOSYFhBPtIVgxf9LokEGpgofxk5e/1vZBsZFR0ru000mYY0SuSk1/xcdwzgYueHAmCYKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=IyVq172b; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-afcb78ead12so724123566b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756739189; x=1757343989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bwNSdY68Wls82Q0k25WMNjJlHUk0r0pQNA4NzN+C5M=;
        b=IyVq172bBaLcYBrl9lLB+7k/X6SfaztrXkqA6O0iqHoUsJ4lzBzbgcL9gvPUNB90wF
         V98plQRUO8aCDpp1TxjvHB4sNQbfgVaU1r6A/qMFGeOAwt3007eIRCKb6cX8QhW3JTl3
         /FMlQvPXhq074a/+q2pHf4fx0DL++gG4yrr5GeNqQvOsdLHbO21enQjAtsjibvnznilV
         r3fSbXiowoecUTw+tHR9UJ8TSH88rZurYZBrNKjX5xezi1TPDwQbmPIWhgi3iYkqLkHz
         iS/KNmAY4cfbOl7YDy7grDQCm8X9R8g9PgMFiSlE285UcKhVXiLstSkvjyjuTitCT+7f
         7b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756739189; x=1757343989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bwNSdY68Wls82Q0k25WMNjJlHUk0r0pQNA4NzN+C5M=;
        b=ILrjssSGL7sP5ToYNJBWNXkjf0Z/+da6TreN0BBq5QqEBw7+xAAr5NOVXAYdDcR4II
         uyyB+lnQgmSNJHJxcQ8K8Hq/I/3Koav3RtiMM59bwjCqUuMsMDNA51Dc/2LinZylRO42
         N8jhVOPgxlVNKpP3z8+WMJhs08b9IMGZWeCPJqFLwhHYZwxMc5NVO7hg/fj3T0HY65bZ
         68bq1+dPQW45+aGUboY4kL67OdTXMhWxmBjsaYG3de73oo0lRbuR+a8pfk1WgD9Mw8UY
         9w/JTc4G9gL+TTgNNAUSJqfs9EEmhqBdOPy0HgFzALk10TbfOAYbOqiCb4HGkkNC0C3E
         oe1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU9yFGt5SPpttl4vrKhAxEDHt/7SqPvUfpM6I03aXfyO7PJ50AHMIBj3lJiIHcR8ZPuWJ+uvMmxpCi5OrbJ@vger.kernel.org
X-Gm-Message-State: AOJu0YxTCXSpgBs3P73IKenZg6591tD2RcvZfRuHrrNyKEMWbMqQChDb
	hMbqMe8fP6iod5RTkPhc8zxne6hxaoCfVGM1GCi8aJdaH2pwit5D5g57UZNLkarsGDAX4HzuN+y
	0ItuyhHu6VRU4isYb7O7aJ6W2FRosExWnJ6xWBb4U4tAD1tMAFsGXjR0=
X-Gm-Gg: ASbGncuFsOVAnXyR0UqEqO4J6QR1XrQ+1SKVPGT7i8/zFIJWqex76/4I7Z4M0x+7I3J
	4XSXGXfGgD/iFvzhuI1y7evOQefX0PQXiayyXPoA79/+Ap2OKUfFyvrEJgx8enr49G30pGTCQtM
	0QuqL7KYq+joYI4PAZxFnGd86dB8nZgEz7Y47J7yEaQI3SM/CD5djI3TC3l9kr7a7CLqwkaIS9X
	FzAJ+/dnthSj2/heEGLLQFocDfBRB2v1l+4H3a1C0X7WQ==
X-Google-Smtp-Source: AGHT+IG0FxeUic5SFzE3UNYIN3B9+gaajPRoU8Y0dXCHXgh8kVRRqajKZHy7y0TqbZFDzgzomSvfHMhYlurHNOihACs=
X-Received: by 2002:a17:907:1b10:b0:afe:85d5:a318 with SMTP id
 a640c23a62f3a-b01d9755f83mr810176666b.36.1756739188996; Mon, 01 Sep 2025
 08:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-9-max.kellermann@ionos.com> <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
In-Reply-To: <2ad655ca-7003-4030-bb2d-1c4bcfda30cc@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:06:18 +0200
X-Gm-Features: Ac12FXwds-_H2NdWifPwev4VbqOwXfa3OcMVFnDeIo9bGQG09tjqsarnzZrb6S4
Message-ID: <CAKPOu+-_bPwE4sCcb6n-nfi3nWy6L0gBAoHgRz3qwdUHByE_Lg@mail.gmail.com>
Subject: Re: [PATCH v5 08/12] mm: constify arch_pick_mmap_layout() for
 improved const-correctness
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com, 
	willy@infradead.org, hughd@google.com, mhocko@suse.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	vishal.moola@gmail.com, linux@armlinux.org.uk, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, agordeev@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, davem@davemloft.net, 
	andreas@gaisler.com, dave.hansen@linux.intel.com, luto@kernel.org, 
	peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	x86@kernel.org, hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, weixugc@google.com, 
	baolin.wang@linux.alibaba.com, rientjes@google.com, shakeel.butt@linux.dev, 
	thuth@redhat.com, broonie@kernel.org, osalvador@suse.de, jfalempe@redhat.com, 
	mpe@ellerman.id.au, nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org, 
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 3:58=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > index 2201da0afecc..0232d983b715 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -178,7 +178,7 @@ static inline void mm_update_next_owner(struct mm_s=
truct *mm)
> >   #endif
> >
> >   extern void arch_pick_mmap_layout(struct mm_struct *mm,
> > -                               struct rlimit *rlim_stack);
> > +                               const struct rlimit *rlim_stack);
> >
> >   unsigned long
> >   arch_get_unmapped_area(struct file *filp, unsigned long addr,
> > @@ -211,7 +211,7 @@ generic_get_unmapped_area_topdown(struct file *filp=
, unsigned long addr,
> >                                 unsigned long flags, vm_flags_t vm_flag=
s);
> >   #else
> >   static inline void arch_pick_mmap_layout(struct mm_struct *mm,
> > -                                      struct rlimit *rlim_stack) {}
> > +                                      const struct rlimit *rlim_stack)=
 {}
> >   #endif
>
> Should both these cases also use *const?
>
> (for the latter we probably don't care either, but maybe just to be
> consistent)

Actually, it would *only* make sense on the latter, because the former
is a prototype...

