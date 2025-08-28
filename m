Return-Path: <linux-fsdevel+bounces-59596-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C0BB3AE71
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029E2984530
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C01276059;
	Thu, 28 Aug 2025 23:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TQ4po9GA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18EC1C84DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756423939; cv=none; b=lZUzTggQfe2XqEE95uaKdrRhmj7FsfMAG+jbC1cKvJoIWvVyOOSDFU7a9pDIzIvIrhcRBizsJmutgfvi05Ejf8EJDoZkXnxWmfkyub3ZM/TDgH467Ezd+9v+kxWEPscXoWZx1MsMR5O83D3VkfWTSP5aXxT/XNVFk+BnOP56H3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756423939; c=relaxed/simple;
	bh=WxKW4694XprcKdmHA8mOveIDifrGPTJI88q4do/6Tos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UfwP9M6da1w4aBeSPaBxEkIsu9iS4nUezFMj/u9brVQ98xJl2yURSUaa5KXSTqS5h+Vjd3ZFi0uoP+qpuqWmO5VwiIKxQ7SxssQQ/OAUnDDoC6V/cICPeX3yh9aYwyxhMZGQWzFRc4PSGYAFLniKLzC+j+aryZ3CD1q7UaCWW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TQ4po9GA; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afebe21a1a3so258344466b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756423934; x=1757028734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4eUNeUMEmKGM7Aq/WYE6pFr6pRnKLnSxbV+da0cYaZc=;
        b=TQ4po9GAdrScFYh51JoIQTGJ++brZ/vmFNndad4rbLdqY3q0Zen9VnhCr06jTELej7
         OwgZhc0FldhEdnSeQNub+wG8Q6CiLNBniqAA+rMvVmOTqRUCpeOmWSQ+CHzjvw8544WE
         mD4nZzPHdbB4YFeUQ3LVJAKPtaFsnZ/hstcuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756423934; x=1757028734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eUNeUMEmKGM7Aq/WYE6pFr6pRnKLnSxbV+da0cYaZc=;
        b=v9PKSKSS2kHnSwtu+UZE51FzZLV/s1cOjGSAJs4KXs0ltKtAbvwlGV5WouwSRnfIID
         kQP+tnvrdxpXNaTFowxn5+9010DHxoEYWuXCkgaswnZhS6S/y1mCm7PD1jlsdBpG99Pc
         6/G5q1mwPqGLmqA689NxFaKUxaI6XmmIpZhTLvUrXnyU1lAa1NUPnsP6sNqfB25oOxY8
         yq7zzDjhNc7RqQUpk7XyC0MW9tfpwsnxc8mNAkaujIPFfbomylEME16u/7ZsgQvTpxg/
         NyM/2tnkjRcODp5pH4G9sQ8rq5Jw4egZiO8ufDSL38cCwJwKp5bMWexp16f738aDtljZ
         Nlag==
X-Gm-Message-State: AOJu0YwqWcLK8fVWFJ++WPQRVUXUDJ0Mxhry7Pdw0DOVeG+sZzUm4z3Q
	IN4Jcy5bLLk0+3wjTy5e9mB5+XuH6yTSP3tfECIIvE3+2326nMAHkzfKUo3NxWXjMsO85DBWtgG
	m0y+co4wH7w==
X-Gm-Gg: ASbGncvwGVJgNlb6fYugxkhHqOGkuVJ9kEsRmEv51Zq6Yd7bsk34kXX697rHuBlyI24
	gssXpJ4L1H60Fq349hjzNGwjXzHOZ4TTfbJCK8fxPVeYpgNSethQzchMq7WILt0mHv1ADZ+0SZK
	pxVG37PP1JJwGIp1R2taaGebK7b1dxtIT8jvfspT+aYMp4zbho/gZuBx9APuDk6ZEDI3xHJHVjE
	VfbZUPGWxfbA9DN9u70M5IeP1jPef3iI7JGYxOLvd1Ng7Jhe2Kee5Yus+OJYVJW55cThqoyhBFe
	7SjL3J7MiuwhWvyzoFwmWIk0ZI4TbPF68W/8YhNYfWtKuMPECU6m/DjBcs8FjcGWiC4AaNkwSda
	94SoIr7eI3cfp9TqdkeVVILtZ8hQE/zr+8DA6+Bf2ARatySWi2TsoJk01T93IxbR34eXRxsL9AC
	qIZVDmyYg=
X-Google-Smtp-Source: AGHT+IGVCEEpow+dcDI19LI9D3rf0Dc+uTGIHwair4Ua1/GL1JQWI4gSYuBBYRT2VFUjumqa+M5zdg==
X-Received: by 2002:a17:906:4786:b0:afa:1d2c:bbd1 with SMTP id a640c23a62f3a-afeafecad36mr1094117866b.30.1756423934029;
        Thu, 28 Aug 2025 16:32:14 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc1e5d6sm61290566b.91.2025.08.28.16.32.13
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 16:32:13 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb6856dfbso278881866b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 16:32:13 -0700 (PDT)
X-Received: by 2002:a17:906:f582:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-afeafec9809mr1018008766b.27.1756423932845; Thu, 28 Aug 2025
 16:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828230706.GA3340273@ZenIV> <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
 <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
In-Reply-To: <20250828230806.3582485-61-viro@zeniv.linux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 16:31:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
X-Gm-Features: Ac12FXzvPp-xxvlS-BX2cEKksjKvQJKPepsrrsmpCmjPq7N1Rd-2qCJmdeEh9d0
Message-ID: <CAHk-=wgZEkSNKFe_=W=OcoMTQiwq8j017mh+TUR4AV9GiMPQLA@mail.gmail.com>
Subject: Re: [PATCH v2 61/63] struct mount: relocate MNT_WRITE_HOLD bit
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 16:08, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> ... from ->mnt_flags to LSB of ->mnt_pprev_for_sb.

Ugh. This one I'm not happy with.

The random new casts:

>  static inline void mnt_del_instance(struct mount *m)
>  {
> -       struct mount **p = m->mnt_pprev_for_sb;
> +       struct mount **p = (void *)m->mnt_pprev_for_sb;
>         struct mount *next = m->mnt_next_for_sb;
>
>         if (next)
> -               next->mnt_pprev_for_sb = p;
> +               next->mnt_pprev_for_sb = (unsigned long)p;
>         *p = next;
>  }

are just nasty. And it's there in multiple places (ie
mnt_add_instance() has more of them).

Making things even *worse*, the other case you changed (s_mounts) it's
a "void *", which means that it does *not* have casts in other places,
and you still do things like

        for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {

so that 's_mounts' thing is just silently cast from a untyped 'void *'
to the 'struct mount *' that it used to be.

So no - this is *not* acceptable.

Same largely goes for that

> -       struct mount **mnt_pprev_for_sb;/* except that LSB of pprev will be stolen */
> +       unsigned long mnt_pprev_for_sb; /* except that LSB of pprev is stolen */

change, but at least there it's now a 'unsigned long', so it will
*always* complain if a cast is missing in either direction. That's
better, but still horrendously ugly.

If you want to use an opaque type, then please make it be truly
opaque. Not 'unsigned long'. And certainly not 'void *'. Make it be
something that is still type-safe - you can make up a pointer to
struct name that is never actually declared, so that it's basically a
unique type (or two separate types for mnt_pprev_for_sb and

I'm not even clear on why you did this change, but if you want to have
specific types for some reason, make them *really* specific. Don't
make them 'void *', and 'unsigned long'.

            Linus

