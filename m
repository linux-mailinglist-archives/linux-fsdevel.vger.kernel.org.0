Return-Path: <linux-fsdevel+bounces-18539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5708BA387
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5EC91F24833
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9685B1B960;
	Thu,  2 May 2024 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgWLnKKN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A528957C87
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 May 2024 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714690477; cv=none; b=YRBOHGxsGdqufGFxfQnRzg+JhsNPBXg+K6bavwQihzG2qfLFCUSv9Yc5xLB2luLXVAIL0xjR0ZagTCWXhr8nOdKkuaaabjpU9hcEEJpqp6o9SkCARAdo+3SEgyHlYX3EecVJ6mJX9JI85FiTmmd0plAFGDjQnREdRceQCq8XQoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714690477; c=relaxed/simple;
	bh=T+UuNbIZBMEGFibn2/SgHQMg5uXvr4RBP5NW+k6VmiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjhlJA9RH8BaPEJGDx6qte2Wc5Rft9uYzFP6VDix8o4/sOCeVf41vvi57s4kuD9+RdTXRgeq3ZX1FJfUojyqam7jv3Qdq8TfJTk+MyRWSg4t2uDloajoi28R9OiM5uTjQjvrM9BtNHikW5tBGIfcD91TWEajtF8Slxan65DOJU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MgWLnKKN; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso1996a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2024 15:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714690474; x=1715295274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyICWSI1cM8GOz3sU1eVA0B3CS15+lbjDpFSuRGR+Cg=;
        b=MgWLnKKN4kEO/GrTv2EiI1yIpsNH80g4MhqP7kycYCSneXr/fte5u8pQDQ1/5eti+f
         Uv6S6Xi03B0Sw0Q47ajDub79C/MSXNtyRRzwtPQehk3/Tz1Bg9+4V0hUDOJk5v6VpRsQ
         Awzu7uK42VbeQs4HMw4jV6XuO6aDT4kHNo+3LxNzczTBkEV0HXH/nZc7KOKYpyn+UT9c
         SWmC66hZWQw//p/XtFuCPwCoDt480LkMecoJO0brCj2+LFR/azW4eUnNaCLXr/n0lvJ/
         x8H7Bdrq8gC3JD5428mf4n8OLvUwnLqOozS5Z1qsZVdQm1Gzmp8GD8MKRSUrhP3bJ/kT
         yIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714690474; x=1715295274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyICWSI1cM8GOz3sU1eVA0B3CS15+lbjDpFSuRGR+Cg=;
        b=gW22je4Z6cXwTbrSsgub7Xzvf6ldsQj/C8Bxg4CHfisnOYpPfRjH/dfMoVgSNUIEqe
         3FPbx7oR26I0GkMZLNWkxcvzHhu23HJFLfNl/KJ34nyg7laokGCVORTiDETQzRda+IbV
         80tyzmF9BtT87PPI2EVsL5oiX/XWzyCUk1wuAtQXZtFmYIhUtfs/K0TSvtYyJAIMoQ+/
         ynik2ogVJwc8myVc/BO2uh/gANpeCT25wZ5jcPTizdh2sQG8VBgwLzQuwJaB71YBXbch
         zT6/FZQSOSVFBbFzYWyBHTmiLawW5o1TJ/JI62O/dhaaBUHHl3CM9G3V4cQUALDOAhaQ
         6oCA==
X-Forwarded-Encrypted: i=1; AJvYcCWW2DfiU+2GeQEDkeBfkI2pKdzQyX8HJIMv8yJQM0eVKC1VgeAk+J/lYbPgcKMASOPTEYthhddV2NbWo4k3zvOOXKFEKW8lAjA9pPfRCw==
X-Gm-Message-State: AOJu0YyFqVzJ+OqSw9FGhNo0lGd5qGyy2rZSs/HTrZNJPewE94PmMWa+
	Lw7lQSCsuDnEYe6ZNhBnKS3++h2wtx24TwFXeZLk0epuLMOCloGG/TPQmve1kF2zdPkMlEmMhnv
	VURymjAv0JPE6SE34/HiZ+Xyg8QF5/TGEKRyO
X-Google-Smtp-Source: AGHT+IHUpFN1HwN88U/dPawni2hB3Y1RKlrNTuS1Z087x30/mKoL8VMzPAwnvWTcOTSQDXoDRVAyK4o1cHhfwp6nPtI=
X-Received: by 2002:aa7:d448:0:b0:572:a1b1:1f99 with SMTP id
 4fb4d7f45d1cf-572d0c0e124mr33966a12.1.1714690473701; Thu, 02 May 2024
 15:54:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502222252.work.690-kees@kernel.org> <20240502223341.1835070-1-keescook@chromium.org>
In-Reply-To: <20240502223341.1835070-1-keescook@chromium.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 May 2024 00:53:56 +0200
Message-ID: <CAG48ez0d81xbOHqTUbWcBFWx5WY=RM8MM++ug79wXe0O-NKLig@mail.gmail.com>
Subject: Re: [PATCH 1/5] fs: Do not allow get_file() to resurrect 0 f_count
To: Kees Cook <keescook@chromium.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, Zack Rusin <zack.rusin@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, Matt Atwood <matthew.s.atwood@intel.com>, 
	Matthew Auld <matthew.auld@intel.com>, Nirmoy Das <nirmoy.das@intel.com>, 
	Jonathan Cavitt <jonathan.cavitt@intel.com>, Will Deacon <will@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-kbuild@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 12:34=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> If f_count reaches 0, calling get_file() should be a failure. Adjust to
> use atomic_long_inc_not_zero() and return NULL on failure. In the future
> get_file() can be annotated with __must_check, though that is not
> currently possible.
[...]
>  static inline struct file *get_file(struct file *f)
>  {
> -       atomic_long_inc(&f->f_count);
> +       if (unlikely(!atomic_long_inc_not_zero(&f->f_count)))
> +               return NULL;
>         return f;
>  }

Oh, I really don't like this...

In most code, if you call get_file() on a file and see refcount zero,
that basically means you're in a UAF write situation, or that you
could be in such a situation if you had raced differently. It's
basically just like refcount_inc() in that regard.

And get_file() has semantics just like refcount_inc(): The caller
guarantees that it is already holding a reference to the file; and if
the caller is wrong about that, their subsequent attempt to clean up
the reference that they think they were already holding will likely
lead to UAF too. If get_file() sees a zero refcount, there is no safe
way to continue. And all existing callers of get_file() expect the
return value to be the same as the non-NULL pointer they passed in, so
they'll either ignore the result of this check and barrel on, or oops
with a NULL deref.

For callers that want to actually try incrementing file refcounts that
could be zero, which is only possible under specific circumstances, we
have helpers like get_file_rcu() and get_file_active().

Can't you throw a CHECK_DATA_CORRUPTION() or something like that in
there instead?

