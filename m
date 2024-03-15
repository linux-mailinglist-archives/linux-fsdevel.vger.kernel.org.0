Return-Path: <linux-fsdevel+bounces-14528-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F58A87D4F0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 21:23:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CA0283F0D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 20:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E85475D;
	Fri, 15 Mar 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XB4ZyyJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D31F922
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 20:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710534174; cv=none; b=AINUQgiKL3JMIOJJDVpT0+jBtrLaNMqpiueF3ijkckAm6NtbyJpwWaSBBQ2Ahzm9EfjCviWy/lvgbBioCM+8TDbF9ai2sNIhnL6cOpeH9aI+YlTdxcEsmWIPWMXvu/oJeHIL0oF6tpw4UaAEJAYRbpK1wqsODNGzt0EWb/LCboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710534174; c=relaxed/simple;
	bh=xZSS2f2gCT0y1k6tpzS9qV9cCYSPvpyvWSzVNaUjPrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYWa4xqEG4p6kdCvuDzEo70cvvKMzmw7ttXHiaR/YPyVef7AlCrP37EfBax+wzMZBLa298b1Y5Akx6QGsj8lc4pYHZJCS9iURL6IKbtHzsNQ5oN8wPEOF6Zf8wiy97HhrtqdkFtC8Go9Rlo/r7DUj9Vd7WIWVf36zXAQsQ2RQ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XB4ZyyJu; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2516393276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Mar 2024 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710534171; x=1711138971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBonRzz3p7T5k46qGOTqJyZ8xFk1UhNgPyID6ocUfTs=;
        b=XB4ZyyJuzM7rgGL5nryd/WaB2TWhPjhRsn4w7PCVt3H4AAt/9gwSMlpzS+ETTG4zmU
         tB1t/CpAvmJH2R7vGaI40QB+HawuYmGfzx6HnMIs2YcDh0EKwMAMZVRrHspuuezdeOr3
         5m5N4Fzx71mQtMebd4jhOJ0SgDzSmFgUUzlPPLEBNHFEI+waRxflmbDMCerS2DKWC3gG
         N3TmrUzhX7j0+Bx1bf+o9v1KWVghOTst1Nd8vaK6rkQJM5rGU9n4yJy6Q6Ff96coSVJm
         JLXR2uo0jPYN0YNyNGRklgfrHHczlZUkdG9Awt65u4h6124MR5a0ThZ3gviNyhybJ1MV
         9m8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710534171; x=1711138971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBonRzz3p7T5k46qGOTqJyZ8xFk1UhNgPyID6ocUfTs=;
        b=pyF8lS9foN8TWDiH70afyDEwvsugyOoFRaeTHo/BgSKU+kaL5AzeQD6QaEx4glKfUc
         Tuyae7dZP0on9YgKUIXEaXT8QCrFiLmzRFkkwe0NhSfl16NVikAW3qLH8eMccrcZlLoG
         5/sR0cLvptHDg5Z6G8p2iHhUSRz5/vr3S9TnXHh6ABk04bmGQCcfxqGwPKp99P2pswBq
         NPlKWxDGgK6dj5y0dvevXnRARz+XcmUvB6g7anaA2ROkgAug4kxRLx8TAaG6FZrWyIWD
         FRPMRVyVfyC09Vq4CaaJQQkljmEm69Iy7igU7JmGtactp8aVBY3GRX1Ce8SxpGbwbBkK
         D3OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOog6w33wExsvVE5M94MtGTVHF8PEoEZJ6Y7DcguBaxd8ihqfSnaLTZH/7enkGTjQtn0iCk8IjV82l8xi6+HstHm+VH8UIQsUSB87LRQ==
X-Gm-Message-State: AOJu0YxoQWPsS/4wG1G1qB1syzB+hUhVjALUIL+hGwjRRjHa0zl+3Z+8
	Z47hzFJvjDaxCZ6jpMcs8eRL5GMbbyB3e297VqAeO9cwAjmAgtNOccTM/cP3jEjTOkZXecf59nN
	64dLMavoNSgcgCsTH1a8D51mM5+GsHAdjGzeA
X-Google-Smtp-Source: AGHT+IGSDFt1vIKYhod9g2539+aNN1VmiBEvQparnLMX4WXbzqChdKXl44697jo5nxySNaWvQPnKlRRV0GqAJ8FZpbw=
X-Received: by 2002:a25:b31b:0:b0:dcb:aa26:50fe with SMTP id
 l27-20020a25b31b000000b00dcbaa2650femr6505753ybj.15.1710534170699; Fri, 15
 Mar 2024 13:22:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315181032.645161-1-cgzones@googlemail.com> <20240315181032.645161-2-cgzones@googlemail.com>
In-Reply-To: <20240315181032.645161-2-cgzones@googlemail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 15 Mar 2024 16:22:39 -0400
Message-ID: <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Khadija Kamran <kamrankhadijadj@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Alexei Starovoitov <ast@kernel.org>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Alfred Piccioni <alpic@google.com>, John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 2:10=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Add a new hook guarding instantiations of programs with executable
> stack.  They are being warned about since commit 47a2ebb7f505 ("execve:
> warn if process starts with executable stack").  Lets give LSMs the
> ability to control their presence on a per application basis.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  fs/exec.c                     |  4 ++++
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  6 ++++++
>  security/security.c           | 13 +++++++++++++
>  4 files changed, 24 insertions(+)

Looking at the commit referenced above, I'm guessing the existing
security_file_mprotect() hook doesn't catch this?

> diff --git a/fs/exec.c b/fs/exec.c
> index 8cdd5b2dd09c..e6f9e980c6b1 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
>         BUG_ON(prev !=3D vma);
>
>         if (unlikely(vm_flags & VM_EXEC)) {
> +               ret =3D security_vm_execstack();
> +               if (ret)
> +                       goto out_unlock;
> +
>                 pr_warn_once("process '%pD4' started with executable stac=
k\n",
>                              bprm->file);
>         }

Instead of creating a new LSM hook, have you considered calling the
existing security_file_mprotect() hook?  The existing LSM controls
there may not be a great fit in this case, but I'd like to hear if
you've tried that, and if you have, what made you decide a new hook
was the better option?

--=20
paul-moore.com

