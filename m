Return-Path: <linux-fsdevel+bounces-66516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D46C21C46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 19:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D07C14E9F40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 18:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F16836B989;
	Thu, 30 Oct 2025 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LT4RK4+E"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567A6228CA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 18:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848771; cv=none; b=hukHfX0RgVS4hgK69vHrJTDS+yxq/VarKGhUM/eTGm4a/GrLa0u+BJOZNS/kinw08wEknlGzwCaop1t2vUr8VwD15BVHFiqFDmzGk3sDB82BGOXk9DYluOfVVkrLgjeuTq5mlLWwjtq+w20ugat1i+kTfyb4ak22T1T2EcKgZhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848771; c=relaxed/simple;
	bh=PZVE37wwRcSG8WWfpheVX28dn1/Jp9IJqc+83vrL8jI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qy0L5gSoSghhe4iSWWAdPnDlaHVQUF1SIhpRcl0cGybGbiocHHvYjWRO7CTOl9BOAM9NU0MLJ6uj49iLR9roP0u4t6IXuUQMEu56TcJ6K62hCaPDApKLKQRJEL6q8uRwUckLusos6t/hDkAapGy3K/9LuXktNcvGVxTVXVKrUgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LT4RK4+E; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70406feed3so171834866b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761848766; x=1762453566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FG/tgMR93DSZXM9XUANIqdTVWOdWVYK0sFlihrocsYU=;
        b=LT4RK4+EdivPgn2/uyQ0bLs26QibMbtUtcX38jxcAKa4lei7rpqqKLBRDdufvev+sl
         8LQ4S9Bb9KxpVEUCa2c1hUqz5KFPEJ3M2pIMcTBMysf1ugmM+pQ72NVyo0b1MRnT4Us0
         MVck/i8Ny+WK0Lj3zP4gQ2kwc/CqIkAOoOPQI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848766; x=1762453566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FG/tgMR93DSZXM9XUANIqdTVWOdWVYK0sFlihrocsYU=;
        b=rm2CdXFf6EepbA0QPTdKkEgJfv3jdyV407I2/+FYpOo86GVyDXo+dln2l1F464tqAw
         laM/8VVgKV8xetW026gXNekGbaXa35crnF46E10CkaMXZlP9SuEbemL2lX9tC3QVzIbF
         VPHyo5HSlj6cgO40BJuRTxrsLfii51yAsZSMTXyoVQauCQ0tQrLv5vQlJBiR2kmwMgJM
         QNEB4i667OcQTQL7CYmswwJZtVeBW/V+fifv3KyL6HjPdfymZfuItB7xHYb6TWa9906j
         3gbC1cGDY+6AMKLNpfiKdh4DfdzuD7MEMs98jBgTgvByS5sxG3LIYVg2Axuya2og7XC9
         C5XA==
X-Forwarded-Encrypted: i=1; AJvYcCWUF1gdUEBgiQH6G78iehtrgTDB738ikSW+07iPx8qC02jTr75xUh28TZF1KS+ppYYa71U1ke2VluzHldIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1usYspDaNfI43/KDvOWx2LJ7gtS4MGuMNU2KQ2K/PFXvwJcPe
	jsmBUNeQHMl17AE8b1iDVw7Jhx+ADt+VjfJStEjcAmawwzgvnb3HpNaW+y2LneZz6PcFjOQxHZk
	srzMYKz4=
X-Gm-Gg: ASbGncvaOuh0/1otxEmNuryjfyIlpi6pSoj8S9lIOljCa4dnhcmgcNWF2nZufWQFyrs
	FZZg4afuL+pYrQiOFSw6uhjWgnV9UZjwVZXThM3v/n0tUo2bVRRMQnGW5TltwqwTWJrLe7sZ+4J
	kDuF1deVAYL2uVdCUOBFORriFlIhE1+hf/4xBJ8lNu39oDfiDOLg7b7vHy6PEtXmpzqHqbSCkF5
	Xpc/YYN3yk7j0riG8te7AUrJtZlAEv3InsSlAIYJZyav8iiOAKBNQ4iP2EETKxw7qSRnks8pX5N
	qVgNOHOOzy0eCP27TZtktIOQUtG1cmiEzG2o/QE7sttcb49dgJqzq8IFbpblLRhWRb97+jlKI9s
	E8y4Q4wnbNv8+avZHOEQ3/ktxNQzz6YqnnYckipVGpV/WZX87xEmyS07NnWAS5/kQ7/5nv5u8kB
	bSeJv/kYAS31cv0S+IRFXMNK9m1ThY9PqSvnJrwi64Fog9VBSU5Gdnddh+SR+F
X-Google-Smtp-Source: AGHT+IEPOgGs0QVw3nPVfhasiw2GEq+YugavfPB4Zk0vpYE2GHXdGte/6ohBYKwbmg6zLVZn3U8gUg==
X-Received: by 2002:a17:907:7fa0:b0:b5d:7a22:ae41 with SMTP id a640c23a62f3a-b70701a8902mr49737766b.24.1761848766322;
        Thu, 30 Oct 2025 11:26:06 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853eeea7sm1826231366b.47.2025.10.30.11.26.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 11:26:04 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c31c20b64so2135294a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Oct 2025 11:26:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWySEAvW4YH0DYajcFd04Otxo7fsdzCJCZQHVKWnUZ2zXbN692cDgnqJ7p4SaziWwzVlV6rMuwQnhl/7Vbm@vger.kernel.org
X-Received: by 2002:a05:6402:2711:b0:628:5b8c:64b7 with SMTP id
 4fb4d7f45d1cf-64076f7cb44mr434963a12.6.1761848764039; Thu, 30 Oct 2025
 11:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030105242.801528-1-mjguzik@gmail.com> <CAHk-=wj5o+BPgrUNase4tOuzbBMmiqyiYO9apO9Ou-M_M1-tKQ@mail.gmail.com>
 <CAGudoHG_WYnoqAYgN2P5LcjyT6r-vORgeAG2EHbHoH+A-PvDUA@mail.gmail.com> <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
In-Reply-To: <CAHk-=wgGFUAPb7z5RzUq=jxRh2PO7yApd9ujMnC5OwXa-_e3Qw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Oct 2025 11:25:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifyJz+WCZxHo6FLht380Y7uQAxX-=RqNh7u4978zhggg@mail.gmail.com>
X-Gm-Features: AWmQ_bkokgorRPDRmv0GASJlLRuWoPF2zAAWRYoR--ZWtsDTk3dH-mNwE000pik
Message-ID: <CAHk-=wifyJz+WCZxHo6FLht380Y7uQAxX-=RqNh7u4978zhggg@mail.gmail.com>
Subject: Re: [PATCH v4] fs: hide names_cachep behind runtime access machinery
To: Mateusz Guzik <mjguzik@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 at 11:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ENTIRELY UNTESTED PATCH attached - may not compile at all, but
> something like this *might* work to show when a module uses the
> runtime_const infrastructure.

Hmm. I tested it, and it seems to work. And by "work", I mean "show
real existing problems":

  ERROR: modpost: "no_runtime_const" [arch/x86/kvm/kvm.ko] undefined!
  ERROR: modpost: "no_runtime_const" [arch/x86/kvm/kvm-amd.ko] undefined!
  ERROR: modpost: "no_runtime_const" [fs/erofs/erofs.ko] undefined!
  ERROR: modpost: "no_runtime_const" [lib/tests/usercopy_kunit.ko] undefined!
  ERROR: modpost: "no_runtime_const" [lib/test_lockup.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/acpi/acpi_dbg.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/xen/xen-privcmd.ko] undefined!
  ERROR: modpost: "no_runtime_const"
[drivers/iommu/iommufd/iommufd.ko] undefined!
  ERROR: modpost: "no_runtime_const" [drivers/gpu/drm/drm.ko] undefined!
  ERROR: modpost: "no_runtime_const"
[drivers/gpu/drm/radeon/radeon.ko] undefined!
  WARNING: modpost: suppressed 29 unresolved symbol warnings because
there were too many)

and yeah, I think it comes from access_ok() use.

It turns out that all of this "works", but entirely by mistake, and
not really properly.

I picked the default value for the runtime_const pointer of
0x0123456789abcdef because it's easy to see in disassembly, and
because it causes a nice oops if not fixed up because it's a
non-canonical address on normal x86-64.

And *because* it's in that non-canonical range, it's actually "good
enough" for access_ok() in practice. But it sure as hell ain't right.

I think that for x86-64 and for the short term, the right thing to do
is to make access_ok() be out-of-line. Nobody should use it any more
anyway, it's a legacy operation for back when doing access_ok() +
__get_user() was a big and valid optimization.

So I think the other thing that kind of saved us - but probably also
meant that the bug wasn't as obvious as it should have been - was
exactly the fact that it affects that operation that really nobody
should use anyway.

               Linus

