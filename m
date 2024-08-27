Return-Path: <linux-fsdevel+bounces-27471-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07505961A37
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 01:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9353285322
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 23:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E65D1D45E4;
	Tue, 27 Aug 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3h3K6Lv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3084A2F;
	Tue, 27 Aug 2024 23:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724799741; cv=none; b=kCtbqIg4nmzEe8licwmekQFgQG+Dt8xEDxNawxwIQp//I8gNQuuKG9CtxMPy7BRLlfrPdOdW2o9/4uVAVMXW336hnl0xY2UfHCpwnc4VWo3jW05qBr1RsBo6aiZUPvHA3jLozzeL7gF+o+tA1Rstp1FH+EDjqpy4lec6yNlz1+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724799741; c=relaxed/simple;
	bh=aN3wvplxnEkJNWB6e3FRobmew1d8gq+z9FfCJCoctoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T4Pae/IQDKt1dMUZizNYA7Wwkq+yt7v1veF4lxOmH7Liw43I1SEdB2TssPrGk4uBFXMfkqyDp2pIYOQrVMkbf1XHf6Pm3naw/6u5K7MDPpl47rdr2FbtH5bsz4uLPFjr7jQEz5nU2iETKewbrhRBQWAcsu17BwWJ9huIXowQx18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3h3K6Lv; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2d3c396787cso4996562a91.1;
        Tue, 27 Aug 2024 16:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724799739; x=1725404539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hSStAUw3Qx6QkF0OnrghhTzt3BXY7UayCueKvU7alM=;
        b=N3h3K6LvP4a9Q4PXjoKEEojUuchKrCU1QETXm6P9yvJPjvphtHL/JCmiCwGBPuEBMc
         9y0k1j/LH59fnzBrrNoslyBxAkokl+psGustLyxe5rrr/bNLHpLTfgKFOh2cGEdWziPh
         1ok92oocuBiuzIaJXGHTLqFqFQTL1T3/oU2X6VxwGGd0m80VIrRIrJVzzcda5xBtjJ2l
         K54B6pce7liF5lWWzEiTJ3hGpvrL+ClSKi9Vue4P/XRk3d+2uP0m9MFvvqePXI4HxUdQ
         20J7MLsR5Moya8JYEdvPglLNhZLQhlh0v0I3wOLd9J15hfBBg7JrgA19WqW1aKGrUQVy
         7ntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724799739; x=1725404539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hSStAUw3Qx6QkF0OnrghhTzt3BXY7UayCueKvU7alM=;
        b=ZoOnJLrrbMl4zAPYN4puLzN9gFA3J7JaQoMQEs2L2Z2H2mdV53dCDtG5vppxs7NECh
         CGb9d3ZTBzOJqb/K7UVVsksA61O3LdwrD+ynkNcRfFAYqrA7i/4g1xbhJLudseanVM9o
         jHFQimJjfhTbDZjxViJfEDMo+LzZ3ABY6Q0IneAflGO9Kem/4ij4IIYf8RaoWcJyXHKd
         EwIhc0uu/u5YlTfIGoh8dUto1QuqmpMp80ly0/PzaFcjjSqQptWJwDSvhV2aiicd9/V5
         25AhpvKrZWxLz4fwVNMLhVIi+PegXed2x9Brs4p5fv2RFVHsYeMZTUamu8pbE9Q2rkNL
         XZ4w==
X-Forwarded-Encrypted: i=1; AJvYcCVgAgBH0hrs7y0bN684VMhoYyCa5V7hjwo5qHoCjH+VWhohe4rR683RvEFBwvuIt7ZlpO7hJADR6YtbKyGucptcQnoaILGM@vger.kernel.org, AJvYcCXY0p8IbGX2JgGM41IXpOq4epMduytjESZSmWrLHpkTIAF80CnBQXssiLFzUwcznwKnvAuBWIZcPhIt5IO1@vger.kernel.org
X-Gm-Message-State: AOJu0YyOtIs6qXGmHmlA17h2xT2bxAdcteDR6vL11UlLEeXsGHIez9mt
	0hjp+Tfa2vy/JN/36CCfBcgr4f8hRKW2MpTuKdI+VRsYyLU0A3piV641wn8YdwKdZ7LeKwQ3wA2
	kFuDVN/Z1qF1yrJKdcgE+Zfo6nhs=
X-Google-Smtp-Source: AGHT+IE/C4tyGWbqzvmwyYSHWdAU5LiFllOzgG/sDOnknjD6iJEBs2ushl7zp8rKIjp6qt+/F8nPlNgtYfr+AtzZX28=
X-Received: by 2002:a17:90a:600c:b0:2d3:c2a0:a0f5 with SMTP id
 98e67ed59e1d1-2d646bc144fmr14136794a91.11.1724799739321; Tue, 27 Aug 2024
 16:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813230300.915127-1-andrii@kernel.org> <20240813230300.915127-8-andrii@kernel.org>
In-Reply-To: <20240813230300.915127-8-andrii@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 16:02:07 -0700
Message-ID: <CAEf4BzaiAWzAU8w11w3C+ws7rdSONZ5S3_7OOXy2_AW1Rwf3zQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 7/8] security,bpf: constify struct path in
 bpf_token_create() LSM hook
To: Andrii Nakryiko <andrii@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	LSM List <linux-security-module@vger.kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, viro@kernel.org, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, torvalds@linux-foundation.org, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 4:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> There is no reason why struct path pointer shouldn't be const-qualified
> when being passed into bpf_token_create() LSM hook. Add that const.
>
> Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/lsm_hook_defs.h | 2 +-
>  include/linux/security.h      | 4 ++--
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>

Paul,

I just realized that I originally forgot to cc you and
linux-security-modules@ on this entire patch set and I apologize for
that. You can find the entire series at [0], if you'd like to see a
bit wider context.

But if you can, please check this patch specifically and give your
ack, if it's fine with you.

Ideally we land this patch together with the rest of Al's and mine
refactorings, as it allows us to avoid that ugly path_get/path_put
workaround that was added by Al initially (see [1]). LSM-specific
changes are pretty trivial and hopefully are not controversial.

Thanks!

  [0] https://lore.kernel.org/bpf/20240813230300.915127-1-andrii@kernel.org=
/
  [1] https://lore.kernel.org/bpf/20240730051625.14349-35-viro@kernel.org/

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 855db460e08b..462b55378241 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -431,7 +431,7 @@ LSM_HOOK(int, 0, bpf_prog_load, struct bpf_prog *prog=
, union bpf_attr *attr,
>          struct bpf_token *token)
>  LSM_HOOK(void, LSM_RET_VOID, bpf_prog_free, struct bpf_prog *prog)
>  LSM_HOOK(int, 0, bpf_token_create, struct bpf_token *token, union bpf_at=
tr *attr,
> -        struct path *path)
> +        const struct path *path)
>  LSM_HOOK(void, LSM_RET_VOID, bpf_token_free, struct bpf_token *token)
>  LSM_HOOK(int, 0, bpf_token_cmd, const struct bpf_token *token, enum bpf_=
cmd cmd)
>  LSM_HOOK(int, 0, bpf_token_capable, const struct bpf_token *token, int c=
ap)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 1390f1efb4f0..31523a2c71c4 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2137,7 +2137,7 @@ extern int security_bpf_prog_load(struct bpf_prog *=
prog, union bpf_attr *attr,
>                                   struct bpf_token *token);
>  extern void security_bpf_prog_free(struct bpf_prog *prog);
>  extern int security_bpf_token_create(struct bpf_token *token, union bpf_=
attr *attr,
> -                                    struct path *path);
> +                                    const struct path *path);
>  extern void security_bpf_token_free(struct bpf_token *token);
>  extern int security_bpf_token_cmd(const struct bpf_token *token, enum bp=
f_cmd cmd);
>  extern int security_bpf_token_capable(const struct bpf_token *token, int=
 cap);
> @@ -2177,7 +2177,7 @@ static inline void security_bpf_prog_free(struct bp=
f_prog *prog)
>  { }
>
>  static inline int security_bpf_token_create(struct bpf_token *token, uni=
on bpf_attr *attr,
> -                                    struct path *path)
> +                                           const struct path *path)
>  {
>         return 0;
>  }
> diff --git a/security/security.c b/security/security.c
> index 8cee5b6c6e6d..d8d0b67ced25 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5510,7 +5510,7 @@ int security_bpf_prog_load(struct bpf_prog *prog, u=
nion bpf_attr *attr,
>   * Return: Returns 0 on success, error on failure.
>   */
>  int security_bpf_token_create(struct bpf_token *token, union bpf_attr *a=
ttr,
> -                             struct path *path)
> +                             const struct path *path)
>  {
>         return call_int_hook(bpf_token_create, token, attr, path);
>  }
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 55c78c318ccd..0eec141a8f37 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -6965,7 +6965,7 @@ static void selinux_bpf_prog_free(struct bpf_prog *=
prog)
>  }
>
>  static int selinux_bpf_token_create(struct bpf_token *token, union bpf_a=
ttr *attr,
> -                                   struct path *path)
> +                                   const struct path *path)
>  {
>         struct bpf_security_struct *bpfsec;
>
> --
> 2.43.5
>

