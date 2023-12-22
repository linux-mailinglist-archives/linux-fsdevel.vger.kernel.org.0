Return-Path: <linux-fsdevel+bounces-6807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6681D084
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Dec 2023 00:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 228321F23184
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 23:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FCC35F0F;
	Fri, 22 Dec 2023 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BhX1fWLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737BC34197
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dbdbe917d39so2276653276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 15:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1703288404; x=1703893204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xtZ7DoTLW1exe07faZsWlns7AQkFSE4d8R8G8FL+W54=;
        b=BhX1fWLha23oq5ZIgDUjH9vv1lGlwIVCi3GLw0JwRo0aG7XwYZv85+77LskHdlQo1D
         bwsIkS7xpvTFw8oAdgSv29mGaUrAvP5Wx/261gIhM/6zMeo8k42oB/b9HryLnDsJE8Cx
         GUytWtYtsKa24oI4PUJff9pGZFK90skjIWVkJFW+GNQC5Y5dcuxibGnU6oiPOsX5oH/h
         Y0L+oVrW5PSmYh7FetSM7oaX5V8tDNInJlKAZiXQBMZ6OpYSMCX46FBWXE+jLXKCAYan
         dodQ1jF0leo+SSkWoD+CU1evbVt2XuUFoQbJacILMO5Q4u2CKs4FahH5T3D6g3H192Ug
         jr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703288404; x=1703893204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xtZ7DoTLW1exe07faZsWlns7AQkFSE4d8R8G8FL+W54=;
        b=IiMHt1DciPoV1ngJAsmnkrfnV4W2W0/2VCYHcl0j4vN6TccIitxkJoYN6T5tsdqHMK
         DUx+sCdm/Xa2Xt+aIceAs8CeafqvgBqT8vD0rPxUqaDwgeHRl+XVikAFbJy9BI58EHkZ
         5WQezUfpsHrQAoN9P2XYrE6MXxPxAvLzBJaKDeUQfGAF1tVzL6bEmbLqxuJ6xpr9Fme7
         dP3/D0peRh1ulvRurB383YPkI+M3kySW09JAWA1jlly3S4rotnWS1PFXdBF8L2Vo/sqn
         NWV/nOiOxVZhca4c0fqK/oU2P74I4ggDNHiz1olZB7qw9HrNAaxabSMjY4iYZaISCjof
         Ti+g==
X-Gm-Message-State: AOJu0YxxW08sVSHL7ABNkIzh0IP20TwcEnI33WKx4G2WrpBPDnUmdM65
	8ciIDezrzVnYDplstUtvEIQvv7KPLm4TNQYSBWKgZQL72zv/
X-Google-Smtp-Source: AGHT+IFJ56Y4CS1sroZ1McDCZ+aO7O7hN62WOIlrr6chYjjZ1T/kSBIrM5eXZxDJkKi8QxYqJszlIDxKoUo1/cuCEUA=
X-Received: by 2002:a25:db4b:0:b0:db7:dacf:ed65 with SMTP id
 g72-20020a25db4b000000b00db7dacfed65mr1422088ybf.70.1703288404352; Fri, 22
 Dec 2023 15:40:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de> <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner> <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner> <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
 <20231218-chipsatz-abfangen-d62626dfb9e2@brauner>
In-Reply-To: <20231218-chipsatz-abfangen-d62626dfb9e2@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Dec 2023 18:39:53 -0500
Message-ID: <CAHC9VhSZDMWJ_kh+RaB6dsPLQjkrjDY4bVkqsFDG3JtjinT_bQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	=?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, gyroidos@aisec.fraunhofer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:30=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> I'm not generally opposed to kfuncs ofc but here it just seems a bit
> pointless. What we want is to keep SB_I_{NODEV,MANAGED_DEVICES} confined
> to alloc_super(). The only central place it's raised where we control
> all locking and logic. So it doesn't even have to appear in any
> security_*() hooks.
>
> diff --git a/security/security.c b/security/security.c
> index 088a79c35c26..bf440d15615d 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1221,6 +1221,33 @@ int security_sb_alloc(struct super_block *sb)
>         return rc;
>  }
>
> +/*
> + * security_sb_device_access() - Let LSMs handle device access
> + * @sb: filesystem superblock
> + *
> + * Let an LSM take over device access management for this superblock.
> + *
> + * Return: Returns 1 if LSMs handle device access, 0 if none does and -E=
RRNO on
> + *         failure.
> + */
> +int security_sb_device_access(struct super_block *sb)
> +{
> +       int thisrc;
> +       int rc =3D LSM_RET_DEFAULT(sb_device_access);
> +       struct security_hook_list *hp;
> +
> +       hlist_for_each_entry(hp, &security_hook_heads.sb_device_access, l=
ist) {
> +               thisrc =3D hp->hook.sb_device_access(sb);
> +               if (thisrc < 0)
> +                       return thisrc;
> +               /* At least one LSM claimed device access management. */
> +               if (thisrc =3D=3D 1)
> +                       rc =3D 1;
> +       }
> +
> +       return rc;
> +}

I worry that this hook, and the way it is plumbed into alloc_super()
below, brings us back to the problem of authoritative LSM hooks which
is something I can't support at this point in time.  The same can be
said for a LSM directly flipping bits in the superblock struct.

The LSM should not grant any additional privilege, either directly in
the LSM code, or indirectly via the caller; the LSM should only
restrict operations which would have otherwise been allowed.

The LSM should also refrain from modifying any kernel data structures
that do not belong directly to the LSM.  A LSM caller may modify
kernel data structures that it owns based on the result of the LSM
hook, so long as those modifications do not grant additional privilege
as described above.

> diff --git a/fs/super.c b/fs/super.c
> index 076392396e72..2295c0f76e56 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -325,7 +325,7 @@ static struct super_block *alloc_super(struct file_sy=
stem_type *type, int flags,
>  {
>         struct super_block *s =3D kzalloc(sizeof(struct super_block),  GF=
P_USER);
>         static const struct super_operations default_op;
> -       int i;
> +       int err, i;
>
>         if (!s)
>                 return NULL;
> @@ -362,8 +362,16 @@ static struct super_block *alloc_super(struct file_s=
ystem_type *type, int flags,
>         }
>         s->s_bdi =3D &noop_backing_dev_info;
>         s->s_flags =3D flags;
> -       if (s->s_user_ns !=3D &init_user_ns)
> +
> +       err =3D security_sb_device_access(s);
> +       if (err < 0)
> +               goto fail;
> +
> +       if (err)
> +               s->s_iflags |=3D SB_I_MANAGED_DEVICES;
> +       else if (s->s_user_ns !=3D &init_user_ns)
>                 s->s_iflags |=3D SB_I_NODEV;
> +
>         INIT_HLIST_NODE(&s->s_instances);
>         INIT_HLIST_BL_HEAD(&s->s_roots);
>         mutex_init(&s->s_sync_lock);

--=20
paul-moore.com

