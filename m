Return-Path: <linux-fsdevel+bounces-68770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0153C65C31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 19:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4033E2908E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 18:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975DF32860A;
	Mon, 17 Nov 2025 18:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U1wXuAMv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC24324B30
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763405070; cv=none; b=QQWeqaj4h7QkThCyBne5+1mfvdLuJhzevY3PRAWTQ48XPvcX4Doxo0JE+pjPJ45uPZrR7Ve0s15PLa4fJ6K+hwwWDglSci+HhfDglip23LO5PD+2UdIbmikHVPnMvAdlhnxSpUq9hst8jogaeLSqX+ewAH1sHg4aexhMfPNF6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763405070; c=relaxed/simple;
	bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BcstEgXkIPSKZfiFh+4QW3y3J8GRDuCQKHMBfp2AzwAkQ47GG602omgLfX4sfTIdLotfn6HjTFke0EZNeTD7+TeDdUYs+A4PsVZY9JPBnfDthuOVG/XEBQl4xm2/C3XL3uuV/6f2H2AFhsUhoWg9QmT/yGG3ilbzBCI/K6ewYus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U1wXuAMv; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso7928724a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Nov 2025 10:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1763405066; x=1764009866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
        b=U1wXuAMvZU7H0GNii+4j0rqaGkT1q8fPJ2VYzWzk5BBRfi3AZb+E75Hh+E3Y7ceJt/
         VWYw53hkjadxriHVmIMTZXBsuOHjieT6j8+rECYPtom1WXUeReurtU+002gtohdNlwbd
         eagID9PSa/ZpAlLJ7QVTUIw+VypfLC4Qwu1yIFv5uJPxi5l9wIzHKDzl3uvVKgzcbwT+
         HW4AQYTBtXFoD6XrXlC/dfzGrc+hjtrOplon40hxVux7N4sE9BXPuMQa2mN8Hb9fSwR+
         qRIF5F3VKifEy3y5SCRyekc7ggqn+lA23DuDEHZ4+XB/YtE/KHeeWh0/O0kDSCVLgSUq
         FIfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763405066; x=1764009866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jMrH/ZmNqpYeJLFgobm11jMJ7I0km6rEckJ6Z9B2Uqg=;
        b=f8JWk644jfpbhmFTk4odF+yqR4TurH/mNuDTobiE4rjqCdQBivP7OXgobug1B8USJz
         bZpEq19GB6JO1U6dQ0ycuROGTbrfuomWhmFv0lHM/+sZe/cld/PMWx1D6NQtzDNxmuUC
         6FF/ieQ+KsxT/h86JIGgjx5MtzJtiUw5PHLaSyER1t4kUlbCIQc0AJUBN9dATo2csC8q
         q2J3yen+JjCqkKsO7nwgccPGniwYKjm+2W6QsMj6r7eGIyDQs1Lg/cRkUO8epkksS4RA
         GyahOIjDMVjYLRdr8ILEwBz0mcne/X68zLbkO9G+riWfoevrUq98/4GhaBiqzjh2nUdY
         K0rw==
X-Forwarded-Encrypted: i=1; AJvYcCU2nY2mbGauAlAYJFKA/WNTp4g1NDluGzfEn/Izr/KwrnrS33lTwH9H683KEE1WSetJ2E/B7HMyqDfLK5By@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6lbDavA+gRt1FetLjugrFRqXuK5D5JQOCE8uVDtzbtN3mNaO
	a4SpUh71yWbXuY76Q+qBeZVIJM/avBWZNw89lBlHVZ1DYld7kTE1qXaJKld785xtrcZvpjrxsWZ
	vcJWPY4rFLB0QVCzT5b+U4eKSSy13Y/4MGFt8R69Zxw==
X-Gm-Gg: ASbGnct1g8/W45NYuM3+M1U5icPmSva0RRW/o8gok9PpTgt/jWRcO8OrKticGL+2bUy
	PK8XKpocrI57neBlLZVVANXfLjfYVqkjQLLOvYuZD87QxOIFTscX75EneE2LdzJ8qAYcpFGrSgP
	W9RWnFKpe5VA1Tf9UoVtyZVg71CdI9+8vJxshLTe9fbebIWMHXpsl8uomCuyBH8HqyGI/AUMw++
	Xi/PvsVLaLfxIG5xtx2qiiethTiYvGUqAxaQX+eMZIK2JvcepxZAmZHrS93y0EqNLKGXeszVnlh
	KX0=
X-Google-Smtp-Source: AGHT+IGuvNw77dXDtTPV0AYardMXM6grq7vkCAHZp53MffW9vtH9Ev6zRMSce2XWGa9IMF6cKfb7xBeYsNCCNwLKBNY=
X-Received: by 2002:a05:6402:5213:b0:641:72a8:c91c with SMTP id
 4fb4d7f45d1cf-64350e9b333mr11717643a12.27.1763405065655; Mon, 17 Nov 2025
 10:44:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115233409.768044-1-pasha.tatashin@soleen.com>
 <20251115233409.768044-14-pasha.tatashin@soleen.com> <aRr1aw45EYSFTCw9@kernel.org>
In-Reply-To: <aRr1aw45EYSFTCw9@kernel.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 17 Nov 2025 13:43:47 -0500
X-Gm-Features: AWmQ_bny7bEklZsVXOjnwEc2I8Kpi65plOcoXCf1e7YrheuK91-BqnEf_WUIt4k
Message-ID: <CA+CK2bDpLfxLZMwNZLmg+K+uU4YaUefJx+xfD+kQchKpkHping@mail.gmail.com>
Subject: Re: [PATCH v6 13/20] mm: shmem: export some functions to internal.h
To: Mike Rapoport <rppt@kernel.org>
Cc: pratyush@kernel.org, jasonmiu@google.com, graf@amazon.com, 
	dmatlack@google.com, rientjes@google.com, corbet@lwn.net, 
	rdunlap@infradead.org, ilpo.jarvinen@linux.intel.com, kanie@linux.alibaba.com, 
	ojeda@kernel.org, aliceryhl@google.com, masahiroy@kernel.org, 
	akpm@linux-foundation.org, tj@kernel.org, yoann.congal@smile.fr, 
	mmaurer@google.com, roman.gushchin@linux.dev, chenridong@huawei.com, 
	axboe@kernel.dk, mark.rutland@arm.com, jannh@google.com, 
	vincent.guittot@linaro.org, hannes@cmpxchg.org, dan.j.williams@intel.com, 
	david@redhat.com, joel.granados@kernel.org, rostedt@goodmis.org, 
	anna.schumaker@oracle.com, song@kernel.org, linux@weissschuh.net, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org, 
	gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	rafael@kernel.org, dakr@kernel.org, bartosz.golaszewski@linaro.org, 
	cw00.choi@samsung.com, myungjoo.ham@samsung.com, yesanishhere@gmail.com, 
	Jonathan.Cameron@huawei.com, quic_zijuhu@quicinc.com, 
	aleksander.lobakin@intel.com, ira.weiny@intel.com, 
	andriy.shevchenko@linux.intel.com, leon@kernel.org, lukas@wunner.de, 
	bhelgaas@google.com, wagi@kernel.org, djeffery@redhat.com, 
	stuart.w.hayes@gmail.com, ptyadav@amazon.de, lennart@poettering.net, 
	brauner@kernel.org, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	saeedm@nvidia.com, ajayachandra@nvidia.com, jgg@nvidia.com, parav@nvidia.com, 
	leonro@nvidia.com, witu@nvidia.com, hughd@google.com, skhawaja@google.com, 
	chrisl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 5:14=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wro=
te:
>
> On Sat, Nov 15, 2025 at 06:33:59PM -0500, Pasha Tatashin wrote:
> > From: Pratyush Yadav <ptyadav@amazon.de>
> >
> > shmem_inode_acct_blocks(), shmem_recalc_inode(), and
> > shmem_add_to_page_cache() are used by shmem_alloc_and_add_folio(). This
> > functionality will also be used in the future by Live Update
> > Orchestrator (LUO) to recreate memfd files after a live update.
>
> I'd rephrase this a bit to say that it will be used by memfd integration
> into LUO to emphasize this stays inside mm.

Done

>
> Other than that


>
> Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thank you.

