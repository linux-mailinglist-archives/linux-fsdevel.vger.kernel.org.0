Return-Path: <linux-fsdevel+bounces-40950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC681A2987E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 19:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C40913A2C44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 18:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66CC91FCCF6;
	Wed,  5 Feb 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksqztk+f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9814F9E7;
	Wed,  5 Feb 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779226; cv=none; b=CHq7B6WouMwPqWFYiKMVx030RrsEK64cZQL9ixsQHWEKG6SXG9wfI3r3rlTgEmyS8/kSJy8yD3expMt8TDF3602TC/H2j9Ano0rygXQC/LHNnpBmUo4hg76gNVMMaMYw9V0SHJ/7x8a+lNkm8p26DrJ0foOUebCJTMHhxZI6PkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779226; c=relaxed/simple;
	bh=/1HF8aKgRp6scy77I1Zd7Np36szkQ4W9868XTiFtW6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN0EAqWLHx/XAshlwJQzlSSPZxw/qMUV2s6bdfkDiI78oWa72ZLwwkpFS7voaNiyMhZaiQ1U7oooljW6c0ZBZBJvzfnbPuzPODPnbosOX4HRzj73spF9OlIv98YjHIWXTf6wW3A9GBeRvFKdAs097dvtoFAqvJrv2QrFn2MGzQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksqztk+f; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467725245a2so1027061cf.3;
        Wed, 05 Feb 2025 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738779224; x=1739384024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/D9MnJCFkcjuwUXqpp70VuXXudp3QKXzPE6iWssawE=;
        b=ksqztk+fSkHhNcMGe5nsT46ojckDm9XBKYLG8xBiBI+gEA/7pimv1MZdYRYD5icbgF
         3HHx9TPsaGIqDMVMtNN9p6rUBWAHHzB/bheJJdx1hGOMrn/EkV3jKB3sizZ4TwvjTDCS
         3Kj0Hu2xkWzWNi8VtFPlUm0DluEdN5ryWgV9kT9wAIeDsD0+dUGX+h6iHltAHh3HvjiR
         Uy/DLm0YOciEERU9gbimYSDQfc73bCC6+69yG1LjriO/AboYXapidsuU+o7hZeROnLNJ
         g5R1t2E11xZ3vbQyT1KatxY+QvMOLuIeQVjxUlaiA0k4XF9aJjo3CMYxDD+seh/eHq6k
         Ik+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738779224; x=1739384024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/D9MnJCFkcjuwUXqpp70VuXXudp3QKXzPE6iWssawE=;
        b=gc4pS81yatCwmWF7QFApRU8B4ue9ToLVsJwVxtHwlaDZzSq8IIVrNYRXrMz8GA5sNU
         skgGZi3P2m9gjG/QFvFmz+GPULdvSLAmuoWGOCdPoU89jQf0mYH3stLET54KVIpOq5+X
         jhJ3RSjyC7AoSP+tYhJgTVoJ6b8HTiyKrGbGXdXd6kauZYIHGwPpbchwztwnNsUebHK/
         +ASjcYfr0S2zQgGstWoY5RE0jdCNaZP97rj+U65YThMjntyrEVEnc07zwDMwTxFr2x4W
         APn2tdpjQ7jX91oApVgWT/lt8NSaXX7huZ6jy0nyErsBBvXvxps046Xo2CkqNVj22g/a
         Zj3g==
X-Forwarded-Encrypted: i=1; AJvYcCUm6yzVwqDEZIzdXJ41Ali6H2A7bYz7Ef+u90j+XzYEF3hlKxvc/pPc+9KtPxMfeGmoLgWHZjHmIEx6j5vc@vger.kernel.org, AJvYcCXTiNu3okLeiaK3KsYgzXURTmj77tz8ZX4jra233poeySW7iWcDnacudhSIBm1wv7+gUNNkwhADLUrvWluM@vger.kernel.org
X-Gm-Message-State: AOJu0YxeDjyO5SGj1t5sg0+Vec2nBXqczfsOtFX3Ylhlf2hZv345wwtd
	ZEJ+nUIlvxRtyukFYVnWXtSRhU6jbvSCkPtn6AV9dyV29yN6k/I48LezUcMKfImmetQrYUiaNFe
	qyGqAjiUaOIICAsEF/57u5ofTsD8=
X-Gm-Gg: ASbGnctXHVLdI0gJ6ov+AKTrKxHI/Pz0rucfSf4fyUJuB5jQltU2uWDrnxZBkg5Zc/J
	7w6pUYxm+rNKjdnLTZlr+Lnayf8cdcYmK+Ku4Vvqg3ag5uWbwch9M0SNFhOhb2HgiiVWyrB+uy/
	psVfL3UyDJNESS
X-Google-Smtp-Source: AGHT+IEzTGZnhNuNC474OVgjAVnXn2L+DLA98Ge72+dnmnvXtvkNQ8EVpJV8eq4sMTi/Asa0wZ56gWLYgPKZ3WMUtK0=
X-Received: by 2002:a05:622a:1b13:b0:46f:d6c3:2dc7 with SMTP id
 d75a77b69052e-470281ced17mr60435171cf.23.1738779224037; Wed, 05 Feb 2025
 10:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
In-Reply-To: <20250204-fuse-fixes-v1-1-c1e1bed8cdb7@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 5 Feb 2025 10:13:33 -0800
X-Gm-Features: AWEUYZnYUbado6oKip81jO3b775na0CY30Gqmx7j0wb6h8phMN9Hi1xi3zrNV4I
Message-ID: <CAJnrk1YL==CtATQYEdA7M-HmpmP9o4ff5Jeg-_oaEa4XruA1Ag@mail.gmail.com>
Subject: Re: [PATCH] fuse: don't set file->private_data in fuse_conn_waiting_read
To: Jeff Layton <jlayton@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 7:09=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> I see no reason to set the private_data on the file to this value. Just
> grab the result of the atomic_read() and output it without setting
> private_data.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/fuse/control.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..17ef07cf0c38e44bd7eadb345=
0bd53a8acc5e885 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -49,18 +49,17 @@ static ssize_t fuse_conn_waiting_read(struct file *fi=
le, char __user *buf,
>  {
>         char tmp[32];
>         size_t size;
> +       int value;
>

It might be helpful if a "if (*ppos) return -EINVAL;" check gets added here=
 too?


>         if (!*ppos) {
> -               long value;
>                 struct fuse_conn *fc =3D fuse_ctl_file_conn_get(file);
>                 if (!fc)
>                         return 0;
>
>                 value =3D atomic_read(&fc->num_waiting);
> -               file->private_data =3D (void *)value;
>                 fuse_conn_put(fc);
>         }
> -       size =3D sprintf(tmp, "%ld\n", (long)file->private_data);
> +       size =3D sprintf(tmp, "%d\n", value);
>         return simple_read_from_buffer(buf, len, ppos, tmp, size);
>  }
>
>
> ---
> base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
> change-id: 20250204-fuse-fixes-03882c05c1b1
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>
>


>         if (!*ppos) {
> -               long value;
>                 struct fuse_conn *fc =3D fuse_ctl_file_conn_get(file);
>                 if (!fc)
>                         return 0;
>
>                 value =3D atomic_read(&fc->num_waiting);
> -               file->private_data =3D (void *)value;
>                 fuse_conn_put(fc);
>         }
> -       size =3D sprintf(tmp, "%ld\n", (long)file->private_data);
> +       size =3D sprintf(tmp, "%d\n", value);
>         return simple_read_from_buffer(buf, len, ppos, tmp, size);
>  }
>
>
> ---
> base-commit: 9afd7336f3acbe5678cca3b3bc5baefb51ce9564
> change-id: 20250204-fuse-fixes-03882c05c1b1
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>
>

