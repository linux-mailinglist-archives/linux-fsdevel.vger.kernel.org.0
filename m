Return-Path: <linux-fsdevel+bounces-59878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 092D3B3E824
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9614C1781AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95906341AB7;
	Mon,  1 Sep 2025 15:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Stosj4/A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6560A338F5F
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738976; cv=none; b=nfV3l0ULcecMpzDVdsYktj38Ai6RYlb9+jR9p0pQzohTDTUqMM/jB0+Os98lHufksVrjyWzkH/Hwd63zdT1XU72oqPdi2m1LzzW8HVIjgJBo2dXggVyzjfpyN7kXdstKR1BqGvPxSCBKj/BVh0VknPC/tVV1GEfJbSMoeA/kTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738976; c=relaxed/simple;
	bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epMN+Rb4JrBnBLv0Dgealv4oKWiMfsq/JqN0rlaCHOFLlitk7pkx2qby4BGcODSLNBjh5qlxHsMg2f3OdZm25hvKqfGbvWaLksvj0p1MJqRQDsuUqR8xyRqfanEVdHlJiNfCoTQIjE0s6e7LNhCEjFqEl5tpAvX4b1UeyjFW9JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Stosj4/A; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b042cc3953cso128419666b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Sep 2025 08:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756738973; x=1757343773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=Stosj4/Aq8oxFTo/ihuTjbA+4h14ygVQT2Vf3seTTjcfK1EGSTxLiJycvkGy4ZyMoU
         UuJxeAYE9u8W27b33iGd/Bdg8cFCGz/B5skbr9E/lH5WCRebN+rF243H9EE7OUDgc56j
         0o0z/j9f/kqJVKgLaDDaDw9jlvsUczS6Ncjk9alHAju3nvtIU8LVmgCDxE8jjs6jD/2x
         zXolOkwsMN1k5Mb3l0poWo2hHZxLaVzVU8biozCFy9xcOIfHMwbbep6S5ZTEdxSlUELX
         xpE9+65K/5q3c/ZK8xnWhTROPQoG39E189LT9qFoCkqjF0INIDFTs2Ec/R4UEa0NXk15
         C/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756738973; x=1757343773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGz5s3CgG5oZbwfB15yu/ysF7dSGyM9kka20nq6+kjg=;
        b=sv9O+ToQWirr20pdnpxbbsXqF51G+G5WJxLpbXJF2S+aoyIs18Ypl612rXeWxb9daI
         tfVSmwUQdyLVOUy0EUDFnuninlsmg3TgLdIFY5yr9OUD2XT5coNt88BR7ZfIOTIqueEQ
         XBv1YRjVF4/38iXbFknZs4BBLvQBlcRpnhkdOoEUm54SuxPedUt0sM/mjxqbaD6/qrMg
         SMqOK5KACFB+XZHIEJnXF2zNklJSuTO9xESk3y9mRpnS90J+aOTafHsSOKMm8oBge8qd
         dXeMBhsxVffNE/+OfRIYAaSbSWtbmQxc3zx6xUv5mYDtheBjSd9A9xZiEdjmH+Z1Jw0y
         cFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWM/Z7fWOGVPvmPRXMLxgdKfRmLATP0zfPkmXQDdx3ZsnJ96yjHRPHj434z7fKGNJYVcMz9im/QDM1EGtiA@vger.kernel.org
X-Gm-Message-State: AOJu0YwopnheANNacpzw+pfY8j9Vxo8eUAaOn/Y792CppcEXFo6XzUjG
	zMasGvjUasj7wlUtOJCkjRNhE5A8Auw9CxjwNc51SRcCz3UIG4asPVLpan5v9ylAMWqajEtGX/S
	1jdrP9JoqZM9tnAp/JyreENeF2H0s7xww3EVoggJn0Q==
X-Gm-Gg: ASbGnct4LlOSZyCNsRMkLN7VxNhFlGoowwhq/hbP2ROKixr3gDGBXHDOCtD1FaTtHVV
	Z/SmJ45BZ1XnFb2kgnDt4BC9u0Tzik5k4w6AutBO30nEoFuMZtMN+iGR1qw30ZVEKi3AFg/MBML
	PPann+Ogaiq9DT8t7m8fve0LIdb8Y2r5OWndTy7KuhjKzLciIISsw+G2rbFJQ3wMRVTvV5ShDTA
	rOdSgzJe92LtCXXz5vfdh22fQ5V+eBAalw=
X-Google-Smtp-Source: AGHT+IFezK1h8zD4ulbO+LoYFx9UJvceg5e5MjfORD1cX6aK9EX6zhmOpTUVOQiq+Ui4qjbP7WefWWIq7O/4+eTMSZU=
X-Received: by 2002:a17:907:3d42:b0:aff:d39:e350 with SMTP id
 a640c23a62f3a-b01d8a25c91mr803197066b.3.1756738972529; Mon, 01 Sep 2025
 08:02:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-7-max.kellermann@ionos.com> <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
In-Reply-To: <ce720df8-cdf2-492a-9eeb-e7b643bffa91@redhat.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 1 Sep 2025 17:02:41 +0200
X-Gm-Features: Ac12FXwscizWLWhMN1KX5yHTr-lGd0ZaL5gCF07LzPcgk8nWDqkiCbWTaVe_QQY
Message-ID: <CAKPOu+-_E6qKmRo8UXg+5wy9fACX5JHwqjV6uou6aueA_Y7iRA@mail.gmail.com>
Subject: Re: [PATCH v5 06/12] mm, s390: constify mapping related test
 functions for improved const-correctness
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

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM David Hildenbrand <david@redhat.com>=
 wrote:
> > -int vma_is_stack_for_current(struct vm_area_struct *vma);
> > +int vma_is_stack_for_current(const struct vm_area_struct *vma);
>
> Should this also be *const ?

No. These are function protoypes. A "const" on a parameter value
(pointer address, not pointed-to memory) makes no sense on a
prototype.

