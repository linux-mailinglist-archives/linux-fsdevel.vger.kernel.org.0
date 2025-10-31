Return-Path: <linux-fsdevel+bounces-66637-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FBC5C2712C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 22:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96E4C4036FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB95328B67;
	Fri, 31 Oct 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IdznsmzJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEC0328B48
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 21:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761947207; cv=none; b=qt+GCus4ulVYZiYvw8A4OjPXMvnFaokgKVeOseEpPLuQ8Ubhr6CiGSm1AMJ7CS2taXKgWsnK2s0Qmfj49pj6sIkNeAjkh0qsuqKZZGFtCcPw7elyM/K/Wtb4Ia57+jnCnFnjIlI5NKtFkaceDwDizgv5o1ZgH/SM50fYopwIoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761947207; c=relaxed/simple;
	bh=lWFBDx2ODc9TCuhfEt3nuFs0i434016S0pXkIVIdcLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+dbSAINJ0UUmYfE5MiXamK/bj3bB4eQtSZVXzPtviyBPpnytI+g3jdkm1HC5pnMNycBAC2XNZIb7PckUqvD3J4ciXJfVQGtURpzLk1fOfCQze+DsfjxOMD8kF65iRBxgYfp2RddF6Z6ZHxbkO8Qs2wS71BJdCSPdYYosRCV/D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IdznsmzJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so4914403a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761947203; x=1762552003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ap26V4PqB3ACpx3v0DEE1m2RpaP2BujTR5irJcY+7c=;
        b=IdznsmzJOZIcK6AgTwFuzl3swYsERbzpHDrFoLexPH636HS6fWS6RGmHzWvg+CKwa6
         UwfSvSMbrshLvHvosAW34vK91zGkreOEotAz5jAj1q5h7Fo3YchBfn8GAbQl5jYZ6ElA
         PRr5LqNZ1i7hgH48xyBcQRoenp8c0gxCh3SQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761947203; x=1762552003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ap26V4PqB3ACpx3v0DEE1m2RpaP2BujTR5irJcY+7c=;
        b=hAJjwDi7hmv9wnRdIdCfqxViX2lqZW+E0WsU8ZstSKLlSzRJRk+Fn5UV5MuUtl+IDR
         u+gFBYBb5Sfa7WR0KO595lTOvhADwNFVPXRT67QMsli5ZW0aRHcyVHGZKZT1RkLQ/PJr
         9jrV3ZEeL4tPbDDztDeRhtrTVCxlMI46akcs435cbZG/h9D5mvndlOHWPdsCrqxAXxw9
         vM+CkT9WEyjBWp8/dBRnJ1f0+yBHzZ3B/diJud9kOxTHmMqhhQO5YWz0wEbrgg+YsdbS
         qV7mqkJrbVUrNIcBxgxFt/9I3gYGIxjZilJkJNLx6YyOr0wSvPJkRqZkyfFqD+eVI0kQ
         Mpew==
X-Forwarded-Encrypted: i=1; AJvYcCUKUpTElGFinMGhkn8mt/tO7/KP9RN2y5/4tzLgsK5owx+bTqDF+sJunvEv03tW/gBxQRc6eLp++i/xnPJz@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyWsy90R3p0tYNWgHTBJbessMl+o1e+sop1oDlNv2h/PLhQck
	jYLk8UHOsmUAF3aEelMnDEx9+r0Imi4+Jkkb45f/e3HrrKZCIsLyzUEIKy/JWwegi91WTk3YHd8
	NQJ1CR8Q=
X-Gm-Gg: ASbGncteWMQqSXEsjaNF5o7mDTzabRV/pHYBB3Q12dcGMRdmUtKz5KUfgdQcPIWbQ9d
	pM+i/Of1RQD3ovCnXZV8eUS8zguTuMbX3N1xsC1iz5iN0luJoiUuzXbk+94+mDkIbrgukuVaSY8
	EG/YCH3PVmcNgbW5SG1UzXpHoebeJtyu/wY9hr7WwCUFB7NrFEoms9Yp6JYUO8hUrZyvcaEkjT/
	4rsMgi/E9Q1kfFF6oXnMs15Z2OGnrYCyjK4LbfgUK3FFFdEDTFnRHqTF2Ov8JQDyfkacreLPEVx
	+2q5SSgw8W13PmU1zjM5Pex+Qk1+i7c13ZINwPIpbfif1Rb1bJI+SHc62CmNkLen2bMOyDkGLCq
	l957v7zIQZzB9voTNrIPoU17P/NqXpG2gLGg+40uhgLdRybMQEWA8RayTUuLsRH9oQ9gJoeShNH
	CiiyjDEfrzJ753SHaM62ttU1QAPXlpYoYCsbDr+bqV9nR8pZd6RoLwMxt58ATX
X-Google-Smtp-Source: AGHT+IEEuztiltSdVGbB5iI00UAPlHuUntKjUf7clM2NEUfTy100WELuyS1ZWfvKnnzQVObmaE6UJA==
X-Received: by 2002:a05:6402:27cc:b0:639:e712:cd75 with SMTP id 4fb4d7f45d1cf-64076f6c105mr4576289a12.8.1761947203473;
        Fri, 31 Oct 2025 14:46:43 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6407b390d7dsm2508866a12.10.2025.10.31.14.46.42
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 14:46:42 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64071184811so4046786a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 14:46:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXOFI4zYdi9lvMHLaH0/X7Ft9ExADEJ8jnaTGl/S648e2RsKSOqboXunXrMOZte7iD5wjx4Dh6d9lt2OwHu@vger.kernel.org
X-Received: by 2002:a05:6402:26cf:b0:63b:fbb7:88bc with SMTP id
 4fb4d7f45d1cf-64076f6c076mr4314088a12.5.1761947201720; Fri, 31 Oct 2025
 14:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjRA8G9eOPWa_Njz4NAk3gZNvdt0WAHZfn3iXfcVsmpcA@mail.gmail.com>
 <20251031174220.43458-1-mjguzik@gmail.com> <20251031174220.43458-2-mjguzik@gmail.com>
In-Reply-To: <20251031174220.43458-2-mjguzik@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 31 Oct 2025 14:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
X-Gm-Features: AWmQ_bnZTsOGUpX66wwDUEuZ9Wnk0waRdBkhsR3pIgRjF531SZpP31Vx6zbQtVA
Message-ID: <CAHk-=wieH3O61QaqE8GO3VAfStti1UZKVcPHznZX5i3YFtmB6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] x86: fix access_ok() and valid_user_address() using
 wrong USER_PTR_MAX in modules
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	tglx@linutronix.de, pfalcato@suse.de
Content-Type: text/plain; charset="UTF-8"

On Fri, 31 Oct 2025 at 10:42, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> -extern unsigned long USER_PTR_MAX;
> +extern unsigned long user_ptr_max;

Yeah, this doesn't work at all.

We still use USER_PTR_MAX in other places, including the linker script
and arch/x86/lib/getuser.S

So you changed about half the places to the new name, breaking the others.

             Linus

