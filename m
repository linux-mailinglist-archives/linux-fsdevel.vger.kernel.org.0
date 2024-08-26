Return-Path: <linux-fsdevel+bounces-27178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFB095F338
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33F01F22915
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 13:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3301865F8;
	Mon, 26 Aug 2024 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if/p2FAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EDD15CD52;
	Mon, 26 Aug 2024 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724680153; cv=none; b=vGV6k82VE9VywVEDoOKRiZGuC54lwiWvW0eV1RTQMDli5feL+TpOI7JYwmJzH0HzgIKkCHEVmJe5WoGl/IBtJiel2ls7KRMwxMrHKUBvVKSpaxN+vryQWQ5qB16WRElLQFFguIKM8Sx4tkHJrqdrWUwPomGa5P3Ke4TafacH5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724680153; c=relaxed/simple;
	bh=AHXgbLM7oRnPm5/UkiMs59q0RJBlaAsbhTbSHfilH5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dGPacY/FHDU9HJOZXvwFBB6/7JwqMbgsEeyv/iu1VedywF1OcJe82e3v+jXt0Rhy4U4eN45fUwMJ56+ZFVAv4qcDJIzRrr/hwQaoJUfSEUAstqak0mPySD1xXwMSsyDEp5louIS9KrJgJAMmG5OxRAkE+VKLGeIZ4kF7wrHhKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if/p2FAD; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf6721aae5so21468356d6.2;
        Mon, 26 Aug 2024 06:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724680150; x=1725284950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMZYUnIgKkaD/MfzkLUl+wvAmEY2GmZ1AF06Oeo2Zdw=;
        b=if/p2FAD+/QUQpKHXKyyieHjUYrbNFQYq2UwC5fCIs5fTFHulIkZTYKWoZe36spyWF
         Do+GTKpgzGTvAWQZRcZ13Md0EUeaflCzMOI5+UI83+y9ABtRKTfVdr8aR+4rlkhhr9vr
         UuVVNxxIOFftm0PlivGuwQVZqiK+Flgpj+HB+h0NCjdAA/h/EDTir7bUiouy4zC5D8FD
         7RWLTfWp1tDmMUdbP2TIb2mj/Vy/Eu8+TM4PrapnGOD5RfTD41LmbNO5GfCCrWF7onNV
         Zb/1pqMCnhiHlLL03b8lZCPwN+NlQMmTiEJL7QjODqqMCCSk7U+AF7+0mShCp3CzlsfY
         YF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724680150; x=1725284950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMZYUnIgKkaD/MfzkLUl+wvAmEY2GmZ1AF06Oeo2Zdw=;
        b=tLMFUX6mHqc9nfnPfHdPzHzM+FQ5p6OalM9jqZfboAs1l7HEJHC8MgbtanlF/n7zFm
         0IBn0U3Aq0gne0360L708OT8uXl1RyM7ojC10H5bMzAe0t1lcNDlJRVyHCCr73/wTA52
         pdehH4OqfHZPCqTooKJdmbcYaUQpnTJRv8zLFO+ahni9QavDQsBaJ+idYXh6ROgqbw5f
         2JqKE+RF+o1uc6cEVC8CL0b1tRWJC/A4NRMtXrRmSGzWWHhCb3T+o1NB4quVbukNh4DB
         vX2sCyfEglJErt1h54ww8TflcqjE1lRUlNPPSNpD8MioSLFG+1U0IS2bjHm8SM7uCEkF
         R9iA==
X-Forwarded-Encrypted: i=1; AJvYcCU35dotnP7b0IHRud+kbqW5M4Kk5SuxSKnjjkAphY6GI9OngcFuHfESPKEinqsc+aaNcXqhqBWxqddhQqv7@vger.kernel.org, AJvYcCVxJfZZAAVC4RFaRk2DdoCqzHjjvP1TemNf3Cd8hPdl7sA0pbfhXe/jusR/BDOHIcj59rIRNppvhkerozHBU8bDUcetZ1wh@vger.kernel.org, AJvYcCWccEOK7KuYW6uAVsjf6yBSbECFOkoN24sH4jO4miu2SkbFsD3YZaBibCu174nYGeB3ehQFbxDT3BtwDsqRMw==@vger.kernel.org, AJvYcCXWFtI6tNf68Z/uakpLlA01ZBzaxHq5haRFzZxlnXIUkKD2OUPNKok+hxVtFGvQj/hoIGdrnqTOCh3GJJvHZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvywONcXWeR2N7hSYUqhyfJakNezJCCfB5HrE3WCar6g0PhXYj
	Kjeb1ZX+PfMrpdS1diTzY7cuJCC4pjoi7qHaMedy9oimIclK4yF/PdiA6M+uJGkiswd2KpwWleM
	csLiNPYoX5yGgQt8q7VGEU72seiI=
X-Google-Smtp-Source: AGHT+IHhatENG6fs2WRBlGagcLBUJVyB1UfWCUwlHlPUXJUhhWRHTDmi04wsvYcpBCIgnGxGVRbqKLCBbwHEGJFWnWM=
X-Received: by 2002:a05:6214:311a:b0:6bd:9622:4972 with SMTP id
 6a1803df08f44-6c16dc39d7fmr113979446d6.14.1724680150391; Mon, 26 Aug 2024
 06:49:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826085347.1152675-1-mhocko@kernel.org> <20240826085347.1152675-3-mhocko@kernel.org>
In-Reply-To: <20240826085347.1152675-3-mhocko@kernel.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Mon, 26 Aug 2024 21:48:34 +0800
Message-ID: <CALOAHbAU6XwN9ti0A1_KywpPqzgKxykWTxHYcYPQOywJo7FePQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
To: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 4:53=E2=80=AFPM Michal Hocko <mhocko@kernel.org> wr=
ote:
>
> From: Michal Hocko <mhocko@suse.com>
>
> There is no existing user of the flag and the flag is dangerous because
> a nested allocation context can use GFP_NOFAIL which could cause
> unexpected failure. Such a code would be hard to maintain because it
> could be deeper in the call chain.
>
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.
>
> [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
>
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/sched.h    | 1 -
>  include/linux/sched/mm.h | 7 ++-----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..72dad3a6317a 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1657,7 +1657,6 @@ extern struct pid *cad_pid;
>                                                  * I am cleaning dirty pa=
ges from some other bdi. */
>  #define PF_KTHREAD             0x00200000      /* I am a kernel thread *=
/
>  #define PF_RANDOMIZE           0x00400000      /* Randomize virtual addr=
ess space */
> -#define PF_MEMALLOC_NORECLAIM  0x00800000      /* All allocation request=
s will clear __GFP_DIRECT_RECLAIM */

To maintain consistency with the other unused bits, it would be better
to define PF__HOLE__00800000 instead.

--
Regards

Yafang

