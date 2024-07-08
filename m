Return-Path: <linux-fsdevel+bounces-23332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875B892ABBF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 00:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 159891F21746
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 22:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FD514F9FA;
	Mon,  8 Jul 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c6txaJqS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990214F13A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jul 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476485; cv=none; b=Bkz9rhLICWmfr8g2ddRRmFmMWvGoMVdvJUtr/mHCPsiLnHHgUXI3JBJZG90y2aACINgUY2carVot85E5TJ3mrRff9NPPXzIURQfOfw8b8Wl8nOOMt3kwOqIZ456T9HAQ+bzvM3KqrEfLPPhIzw3WlpJ5CASJLi0Ai8+gyjY1OfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476485; c=relaxed/simple;
	bh=l03sVvdiatScP8Ji7LS+51efo1XSZO8mK8zgUFzmJb0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PVVY75mdUTrjEpw+8u9AvQz+GkNxhMZbTDE2CUtm4DQAK+TCD6p5VbxAoCaOlml2cboc4qD3hozR9u05CFGhhBRVKLnJVOIM5q4IuftiDtX1Wqcz0kzSCuH+/GJOFCDoFOcd4MGb1+CBiwci8BzIcUoSlpGHKXINUN+Z6ZvDvEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c6txaJqS; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso5507a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jul 2024 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720476482; x=1721081282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7bTn4O9eTr2aCFrLSGHovaOIDt2y0TRFcSEpZcps+A=;
        b=c6txaJqS6Ki2CUPrvyQzKfnl8agf/jflzpSrhBegMCgJMdzWyE1yPGl3EHeUnjRqS7
         FZr0smtAZkCeRoGHgRD8zKTFVpxlbw2DDkrZ9FZE4KLkobwe6E8L4CReaAT2jeid8VOq
         R5+U+p/a3RvQxjOwd/XAte1z9TrMsmVWV3Mtqf2+KssLNK/Px1qL3+4aVyEBhsi7xlK+
         jcY3AqzrUE3bak3fj25i6lrQbtSDnzaRHqx6dIkzvPYqI6qZwQsjnaAP2+e4PJTeWSCK
         c/JKePu8wg4B2VJn6c4DrJTSM7FbdWLPNQYErl5x6m2cpqmJdaiX44c7d0oug5cU0V6w
         agZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476482; x=1721081282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7bTn4O9eTr2aCFrLSGHovaOIDt2y0TRFcSEpZcps+A=;
        b=BXT1iFds4H3bspWIiOUEiunfLopT/GwRtRPO9qnFt3m09HVVNLVybF6+I2Zs6d7HF1
         G1k+MOeX069Zuj9m7WCZUL2bE2Zz4LxZSDGvZOAejLPIBycl3wA8QMPGH0MWco6T2u+x
         9bDeOhJkrQv2K9bbT0Ymq4M4Hf0IsLBjf+8CTlwAYtav1xRrjPh+YhmhFKNoFed/kugP
         Ckil43QWzqw/J2H7mzGE260JvT0XX/jxpcOlR2dsCjV1sYIZtIh/Kuhb8/jxyrkbjbGh
         GFJ9ZAzo3lYyoT6hl0+tsHhnTBemyJHogC9ZEwJi0GXS6kkfxYD8wRkPO6OzbdA8gPy2
         L+Bw==
X-Forwarded-Encrypted: i=1; AJvYcCUdsTjMnLQUpUTCg3dUIVFWUEZWjOqS0brci7EhMjDFcun5OXMXfW0wowntq32RE3zBAwmnukuvEn2wnzsfueRFlR4dsqnmm1LyMFVOKA==
X-Gm-Message-State: AOJu0YzGlIrqx5f2QWLhcHVhkkRuNbvYudmHqfK3aTuyq20OA3eGAQQh
	MNWJngKeiyEYaQL53b2taIyohuPZMyK+7wYiq+awYGIOJ2rMNaqkopLhm7MRIJkMhoQ2Gv1B3mG
	0fng6B/jnktvHZk9A4g7t8MnRqYESlE7oj0wN
X-Google-Smtp-Source: AGHT+IHvwrZF+sD8hiUMuOI0mETWWoP7JD1Mi+rw83YkQOqjyP7kYFiISHKE1V9Tv7EGbEO+Y6qMxWIETtxF0JNU+kY=
X-Received: by 2002:a50:9fc1:0:b0:58b:21f2:74e6 with SMTP id
 4fb4d7f45d1cf-594cf64511dmr86189a12.0.1720476481691; Mon, 08 Jul 2024
 15:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240704190137.696169-1-mic@digikod.net> <20240704190137.696169-3-mic@digikod.net>
 <CALmYWFscz5W6xSXD-+dimzbj=TykNJEDa0m5gvBx93N-J+3nKA@mail.gmail.com>
 <CALmYWFsLUhkU5u1NKH8XWvSxbFKFOEq+A_eqLeDsN29xOEAYgg@mail.gmail.com>
 <20240708.quoe8aeSaeRi@digikod.net> <CALmYWFuVJiRZgB0ye9eR95dvBOigoOVShgS9i_ESjEre-H5pLA@mail.gmail.com>
 <ef3281ad-48a5-4316-b433-af285806540d@python.org>
In-Reply-To: <ef3281ad-48a5-4316-b433-af285806540d@python.org>
From: Jeff Xu <jeffxu@google.com>
Date: Mon, 8 Jul 2024 15:07:24 -0700
Message-ID: <CALmYWFuFE=V7sGp0_K+2Vuk6F0chzhJY88CP1CAE9jtd=rqcoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v19 2/5] security: Add new SHOULD_EXEC_CHECK and
 SHOULD_EXEC_RESTRICT securebits
To: Steve Dower <steve.dower@python.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Paul Moore <paul@paul-moore.com>, "Theodore Ts'o" <tytso@mit.edu>, Alejandro Colomar <alx@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Casey Schaufler <casey@schaufler-ca.com>, Christian Heimes <christian@python.org>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Biggers <ebiggers@kernel.org>, 
	Eric Chiang <ericchiang@google.com>, Fan Wu <wufan@linux.microsoft.com>, 
	Florian Weimer <fweimer@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	James Morris <jamorris@linux.microsoft.com>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, 
	Jordan R Abrahams <ajordanr@google.com>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, 
	Luca Boccassi <bluca@debian.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	Matthew Garrett <mjg59@srcf.ucam.org>, Matthew Wilcox <willy@infradead.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, Scott Shell <scottsh@microsoft.com>, 
	Shuah Khan <shuah@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Grubb <sgrubb@redhat.com>, 
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>, 
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>, Xiaoming Ni <nixiaoming@huawei.com>, 
	Yin Fengwei <fengwei.yin@intel.com>, kernel-hardening@lists.openwall.com, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 2:25=E2=80=AFPM Steve Dower <steve.dower@python.org>=
 wrote:
>
> On 08/07/2024 22:15, Jeff Xu wrote:
> > IIUC:
> > CHECK=3D0, RESTRICT=3D0: do nothing, current behavior
> > CHECK=3D1, RESTRICT=3D0: permissive mode - ignore AT_CHECK results.
> > CHECK=3D0, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, no exc=
eption.
> > CHECK=3D1, RESTRICT=3D1: call AT_CHECK, deny if AT_CHECK failed, except
> > those in the "checked-and-allowed" list.
>
> I had much the same question for Micka=C3=ABl while working on this.
>
> Essentially, "CHECK=3D0, RESTRICT=3D1" means to restrict without checking=
.
> In the context of a script or macro interpreter, this just means it will
> never interpret any scripts. Non-binary code execution is fully disabled
> in any part of the process that respects these bits.
>
I see, so Micka=C3=ABl does mean this will block all scripts.
I guess, in the context of dynamic linker, this means: no more .so
loading, even "dlopen" is called by an app ?  But this will make the
execve()  fail.

> "CHECK=3D1, RESTRICT=3D1" means to restrict unless AT_CHECK passes. This
> case is the allow list (or whatever mechanism is being used to determine
> the result of an AT_CHECK check). The actual mechanism isn't the
> business of the script interpreter at all, it just has to refuse to
> execute anything that doesn't pass the check. So a generic interpreter
> can implement a generic mechanism and leave the specifics to whoever
> configures the machine.
>
In the context of dynamic linker. this means:
if .so passed the AT_CHECK, ldopen() can still load it.
If .so fails the AT_CHECK, ldopen() will fail too.

Thanks
-Jeff

> The other two case are more obvious. "CHECK=3D0, RESTRICT=3D0" is the
> zero-overhead case, while "CHECK=3D1, RESTRICT=3D0" might log, warn, or
> otherwise audit the result of the check, but it won't restrict execution.
>
> Cheers,
> Steve

