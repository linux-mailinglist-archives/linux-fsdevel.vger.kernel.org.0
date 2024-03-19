Return-Path: <linux-fsdevel+bounces-14846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F9D88080E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 00:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683F32849FF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Mar 2024 23:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86F05F569;
	Tue, 19 Mar 2024 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c/QF7TMa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7357874
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889815; cv=none; b=AG2qXQvOLJ64fL0iiPj7urAQkRVFQQMaA7gtGPxV5DCDna3vOECJlH2kCViYcg/NQc8dgoAiCf8v1WuTyM75BwmkuY2o3U5fj2yD6EikBIsl6eDILgNj75V7ZA51AwGtt8wFx53Uohp8GJ8mUaQv82VcP73DRTJAZbCR/WLd0B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889815; c=relaxed/simple;
	bh=n2hwhhpCp+wrS8iH5XBuAd5W5hKp1kphMF+/gXoFfXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=imq1MjARIEZdp81uwGGkoVwSnEEWokSoPAIWWmPf7P8lBbIffjRHc/wPIqesUOmKQLDKpspQmge1k6rhtxhF9n25q4O+/xyxnlW5YDi36XtD2nA41pKH9k/ipKS+G4r3+sGhv5vvXqNS/SPBi2zkd8WS3GxZg2X5ri8Vk4EKkPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c/QF7TMa; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5563867276.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Mar 2024 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889813; x=1711494613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+dHH9ODplRPDsF7SLLanW1hsK5MRMZ53v3XJwlytqw=;
        b=c/QF7TMaLp6yUZO44kvhv4DltTfXDhHCHdYZxZY51HjneZ14x8gZrL+qr+oql8uVnL
         HJWKL9ghAvhcw+W2Fqk1teId9IpRR4NDF9ty3xv8puyvLZIPq0F8+To4fHZU5Y3uPU46
         ISrYhRw//mbf/dUE7Pwcw1k3HYujLXanZv/1W4JekHu+LCO2dPElFLsbRMYaG9m/4Q/p
         Ma8LeMFPZ4zEnxN1JxfdQJ324TBJGpHfT9Umt5B+vDPGdDCZTuofMYxS54iQ6MqaOpL8
         FJFv0SfoWFso7z3O6fb9536wLzo1J3YElC6/Wb0W9dEbyhz+xyeXDh0k94z8bubCsnoI
         RPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889813; x=1711494613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+dHH9ODplRPDsF7SLLanW1hsK5MRMZ53v3XJwlytqw=;
        b=XD0/fhV3HibEBqJqMKHngJ9rZMmI5ikFBg/Mfeej6qEOS11Uw55fYsCuTAkMq1IRjS
         N0+Hu2ALVr+/v8Cev/0muQyDr5QZVeXdQ3CTUIqXkNDYKLFNMeyEHaFDpWRgx7pbq4w2
         iULj6oJhO5/KYw0dL4o85L+pw00aS8CcNO+PFMwlrpW2wP029N1gkUK7azOcaeOHMkR3
         92YNAlRlv/qDxcrXcCVczxknqYK93cB/C73z8hud/xxvjpu9yOUEIJu2nTcpUwnaHQ6B
         eizL+5vik6z1D5G4YRbHfEDBobI5SPsauSB7ssrYDdSv0I1GfQI7qrPJg02xhmOqYTRz
         YWHA==
X-Forwarded-Encrypted: i=1; AJvYcCXoRyiW43Xpte049eZnCW9Th5nbzC0pT3AxwUu6FIY33icK9wCt/f0pI01C7v2faeZ/0VlYG43RmwWx3euxU53x/wpjIAWDr4XYB/kodQ==
X-Gm-Message-State: AOJu0Yzc1XjiXkmqVijvhyWvX45FXnC+a7lG6MlM6ftqDuIYgZVxYZr9
	u5gCS8X0UQcQibBN2V9orfFKLRI6jJPeZF1GZSxLOHV+MaIFp+723CMHy+kSY06JSjipwc6rcyQ
	+wbRsd2biGGv0arfzGTF7bRu2TK/nu9/fBBCj
X-Google-Smtp-Source: AGHT+IG3Yh4bbfa1wN00q4KaF6p48afEQKOxM8IY1af14YL2d/7MolgsUvabXrQz8hWdkCEJDKcZlgNSYZvMusHk3aM=
X-Received: by 2002:a25:a547:0:b0:dc6:cf96:2956 with SMTP id
 h65-20020a25a547000000b00dc6cf962956mr14662766ybi.44.1710889812886; Tue, 19
 Mar 2024 16:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315181032.645161-1-cgzones@googlemail.com>
 <20240315181032.645161-2-cgzones@googlemail.com> <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
 <5368DC74-41CF-4450-AF6F-FFB51EFCCF99@kernel.org>
In-Reply-To: <5368DC74-41CF-4450-AF6F-FFB51EFCCF99@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Mar 2024 19:10:02 -0400
Message-ID: <CAHC9VhTpTbVL4=tchR3Bpcfe0Hsijf5XJ6wsEvU7cu8eUy_iDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Alexei Starovoitov <ast@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alfred Piccioni <alpic@google.com>, 
	John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On March 15, 2024 1:22:39 PM PDT, Paul Moore <paul@paul-moore.com> wrote:
> >On Fri, Mar 15, 2024 at 2:10=E2=80=AFPM Christian G=C3=B6ttsche
> ><cgzones@googlemail.com> wrote:
> >>
> >> Add a new hook guarding instantiations of programs with executable
> >> stack.  They are being warned about since commit 47a2ebb7f505 ("execve=
:
> >> warn if process starts with executable stack").  Lets give LSMs the
> >> ability to control their presence on a per application basis.
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >> ---
> >>  fs/exec.c                     |  4 ++++
> >>  include/linux/lsm_hook_defs.h |  1 +
> >>  include/linux/security.h      |  6 ++++++
> >>  security/security.c           | 13 +++++++++++++
> >>  4 files changed, 24 insertions(+)
> >
> >Looking at the commit referenced above, I'm guessing the existing
> >security_file_mprotect() hook doesn't catch this?
> >
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index 8cdd5b2dd09c..e6f9e980c6b1 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >>         BUG_ON(prev !=3D vma);
> >>
> >>         if (unlikely(vm_flags & VM_EXEC)) {
> >> +               ret =3D security_vm_execstack();
> >> +               if (ret)
> >> +                       goto out_unlock;
> >> +
> >>                 pr_warn_once("process '%pD4' started with executable s=
tack\n",
> >>                              bprm->file);
> >>         }
> >
> >Instead of creating a new LSM hook, have you considered calling the
> >existing security_file_mprotect() hook?  The existing LSM controls
> >there may not be a great fit in this case, but I'd like to hear if
> >you've tried that, and if you have, what made you decide a new hook
> >was the better option?
>
> Also, can't MDWE handle this already?
> https://git.kernel.org/linus/b507808ebce23561d4ff8c2aa1fb949fe402bc61

It looks like it, but that doesn't mean there isn't also value in an
associated LSM hook as the LSM hook would admins and security policy
developers/analysts to incorporate this as part of the system's
security policy.  It's great that we have all of these cool knobs that
we can play with independent of each other, but sometimes you really
want a single unified security policy that you can look at, analyze,
and reason about.

Regardless, my previous comments still stand, I'd like to hear
verification that the existing security_file_mprotect() hook is not
sufficient, and if its current placement is lacking, why calling it
from a second location wasn't practical and required the creation of a
new LSM hook.

--=20
paul-moore.com

