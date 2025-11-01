Return-Path: <linux-fsdevel+bounces-66661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C4490C27985
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 09:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 752AA4E292B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 08:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CDF28853E;
	Sat,  1 Nov 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL/uBb+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DCC1C75E2
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Nov 2025 08:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761985181; cv=none; b=naKG5ENUKJFmlcrYRM4S1XtguLT/SWhvk1Fl3/F4CaRvUNQ0gNnFD/TZ46zFej8hYs8Ahvg6meSZzSv1/UloeRTlD/Hy9gFzX+sGDPSKMdwGe7swP5E8eVuCfIlyCtRlcsHiiIzNcD8/Hx/wiHntk2ydxVo0Ypvd1V2SmNMjnpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761985181; c=relaxed/simple;
	bh=0m1KiCxrcLAq57bvrNoE/GhvmNxPugLIsp03lfyd6uE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hr7v+ddtDiEnpiPCTCJOyITSobRuHcwVPpx8sYTihVGJMWgg4zAQLLmmDGQGxRylqTotaqb/miVIywCvMcMgMTkqLZdYSt+am/E20vqG6CkcDGXce72yDq35zm5WUzRT0WhmZqMOs08TbFEr/Ay7BtJp5NNe06tBnR762pLBY9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL/uBb+A; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b70406feed3so609902366b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Nov 2025 01:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761985174; x=1762589974; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E2fiys+iyv8ARWUS9urU0rDn8AzFYvrnowS3Ktzie8w=;
        b=DL/uBb+Aqk762izW6faOjCjw0wk2K447JAHxBe225gUfJAnonV6qX/7x5zxtvqhYdZ
         doTcCN5/dklIrAL68W640vtjIfqe4DcliwBaPS5zgREUglofi/w8BM1ukl6f6Cwdrqsc
         140QfR2lUUOwc34F3Pk1lIcnhwZqEcawk1fXvobOC8bydLpnNh1It0l64Jh7Wxdu3/3l
         o9TN8E9B6srNF2mjn3fsO7JaEZnRaKtrtc3ah0Y0kOHU2Izn6p9OaPCX5VeP+RpKHrpn
         snxAt30hflZPron2etPvXR0BPpLYo57lyPWvZInlN2prrnSnmg9dYnHsTRXCBzydcy4B
         PAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761985174; x=1762589974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2fiys+iyv8ARWUS9urU0rDn8AzFYvrnowS3Ktzie8w=;
        b=S+HhZyIV2sSg0Nk3J23aDZj/OGWqiO4BEpPNXgTqbaoO/hRD9f6xvmc2FQiqP7XMSL
         7O/vbWM2I0MniCV2HB1jRxyD2Di42ouTdL9gXPqM2mJyHdIAh+gY9xawKTFTckYCrf0w
         HRDyQ1mu79i0Gbgm1FQUIIwD55ite60fY20evZeHYb5a+AfHvH+CEJnG/fmb609PWziW
         t652JX/bTjw5J/WgRIHNj7n6YdsR+jlAh4gia1xaHAis+j2yWhLLlCri/aQuvWKeinYr
         0fcTh/VAaYWVfNG2sizpmDNzEs7P4/uViFabLFUKPaNlO/gfbBlQU7+8MLfXctCGnYVm
         l8yg==
X-Forwarded-Encrypted: i=1; AJvYcCUVzmW3qNKyGMLO6ElOt2OqeXVSiYbqRFIspSWQ+7Y7Lsa8FSjzKm00IwLX7UaPdYUsHdlEGyfd0pCgaR3f@vger.kernel.org
X-Gm-Message-State: AOJu0YyPUCvkWFU9nPwFiL67M5jgcfJQkNS6kycOHr31kDi/Go/qmF9g
	/PON9L4E7Cpy5Y8fwsHZVyKIVeJ6QtIb/Va0RU+AExyUV/bsNc8hDl/4rORd7Lk7b+JDyqhFTei
	bDtdSM25UVt+oYYbIQdhI/KUo53JhUZ0=
X-Gm-Gg: ASbGncvckWRXS2kK/zPSBFI861dmPenVr/x01H873vazNPj8xommwwFJ+csov9VJQIT
	wW/eHrEJhoOugWjpEdueQC46UtuwcyMyF9f0ZRBk0RlFE8EGtJbM8ovg8WJGUU0cv7FE3TFLU8G
	fv+D4lxhYrFHQU5d5G6h4nTnHwkEeZLRznvBoVTQFWCKrDfershkRWyJZdHua8+cXCqTdI6Sw3X
	M71V4DaL5JYymCpjVKwySVWkVRaHCjs4r/6qRiaZB7KqTJ7qiHr4qKAckEmLOx9JRHmUOhMbHDi
	nQO8oqRFtKZbUqk=
X-Google-Smtp-Source: AGHT+IHHZisxkG0pWkZYJfYt2yrPfxCqmDqjea0f1awr3nxsgakffV+oCCROQMtRitvrrYjVKn+NejJDkvxd+gn/2B8=
X-Received: by 2002:a17:906:fe4d:b0:b3f:3570:3405 with SMTP id
 a640c23a62f3a-b70704b3554mr533169066b.34.1761985173594; Sat, 01 Nov 2025
 01:19:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029134952.658450-1-mjguzik@gmail.com> <20251031201753.GD2441659@ZenIV>
 <20251101060556.GA1235503@ZenIV>
In-Reply-To: <20251101060556.GA1235503@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 1 Nov 2025 09:19:21 +0100
X-Gm-Features: AWmQ_bncJFNlDcLqUPC7424LGnLaX9bqYHTH-MSz1Ry6nI1Gke1V5yviwukC44Y
Message-ID: <CAGudoHHno74hGjwu7rryrS4x2q2W8=SwMwT9Lohjr4mBbAg+LA@mail.gmail.com>
Subject: Re: [PATCH] fs: touch up predicts in putname()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 7:05=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Fri, Oct 31, 2025 at 08:17:53PM +0000, Al Viro wrote:
>
> > 0) get rid of audit_reusename() and aname->uptr (I have that series,
> > massaging it for posting at the moment).  Basically, don't have
> > getname et.al. called in retry loops - there are few places doing
> > that, and they are not hard to fix.
>
> See #work.filename-uptr; I'll post individual patches tomorrow morning,
> hopefully along with getname_alien()/take_filename() followups, including
> the removal of atomic (still not settled on the calling conventions for
> getname_alien()).
>

Ok, in that case I think it will be most expedient if my patch gets
dropped and you just fold the updated predicts into your patchset
somewhere. I don't need any credit.

