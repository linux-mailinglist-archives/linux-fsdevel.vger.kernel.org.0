Return-Path: <linux-fsdevel+bounces-66321-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AC1C1BCA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC4B65E3EBF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B182E0901;
	Wed, 29 Oct 2025 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CR4ItZ9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1562DF13B
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 15:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750536; cv=none; b=dGHKTjBWPROgStCC1zCkbsWRDYjP6QUjBk1fiYqOfOZMpfru3R9zWjmuiQtOprSb14rmvrV2MSTMNFcvaESuqArQqEKFRmN6zubJ72YyxchwgDNPlPYjIrWUmHfPVF6D44558mAZbeIlEAGO16wjTvD2h9mhSFaNwixrg/s/jw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750536; c=relaxed/simple;
	bh=pB94C7kPrYSAxlvhyehWFWqV6sR9eKAIcw2W2uEuiRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=npllONyNnqxLv6tzKzXIYahPJ3aSbcwVIClE7hwXpscingdyjlemIVdBU3mOXi87/29JGszcSa7JdULtdJifLBEiT9vCXicgigC7VuHZJpsJojGmNJuqi7SQxQV2d9jjkPln58hhr9DnS/I1KMfIxi3gfx2OQ8y7dGwLhaBxGRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CR4ItZ9n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so13801939a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750533; x=1762355333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWh76PP8SfKKjG0pMeYPtMLj4ZkKRRhoTpYTJJfEHZs=;
        b=CR4ItZ9nFZ+utiN7AkC7jW5orQBrF1NkzuNeG113Y6WYgA1bqZUXaDL3kjbUbPNmYB
         GZdNy6i+EboUw87FJAqUXM/ky7yYTBW+/qX1nLHWcp9eIgTca8/O+/8I5+MIrD7umSoc
         8H1zsFrS2/kwRWt4ZxWnKUjmPxPlZYw+SFAh0Idlh+GRVLEdLMaYqsZQnGT8OMdVpnu5
         S6O3SnG1YLpnLq14vWJzpzJqMqqLqYDZNwgg1eEfoksWZy+8/1nA2i9YS9huLSNYNJV6
         nCpfrYN2gmF1uy8R49cA6Hg4xMjd2M7dcDj8P+M5FCz7vgT98dw45uTilfUgdBniY6Jw
         fGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750533; x=1762355333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWh76PP8SfKKjG0pMeYPtMLj4ZkKRRhoTpYTJJfEHZs=;
        b=bH5u9FNxcBj20P3OfNIydTJ2J4QPBTBB/bSOp92RzN3FkXXcCwG94p3uh37hW6mXPN
         XJ9hBH9OxifLuP23tFtgeSYuEidt4FhH3HQZ/PEBv8F713TuUEncTNHA4lTAaTfsl5Ta
         N2qcN8nAL/HdyR//blp1FgUJZk4Eh5ycTiP2zqvqVtZembMnALpkUYkusijV6Wa7SFkr
         YPB0ofVjgXsFL7HUt0Oq9aD3Hz/zowfCaXFa3Dg6NZ3pCZT3sXILb4Zh95OV03n3U7EM
         TZCid4Pm/8LnThBEbwR1V58xg46B1vQX9/SrIuEkUUG5TswHbcziFxChPcrDcT4BTtBh
         lD4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbJFjZ1EX4DyZyxRIE/CcdYzNgWRb3PrKiof25k+82TqA07rnnovE8n5eQApITCDbp+42aIIX/HnU6CW3z@vger.kernel.org
X-Gm-Message-State: AOJu0YyETtGPR/Y3LjPejvQPqB+eeUFdcvTk1DgGMeY4eCXDuCeNy/hS
	UH4l6CJ2AN4knMjhiFb9JdwQrXUzrWVtuCzrkWsX/0A3s/3lGvRza0iJ6CwCmzZMnxJDr4MQYHt
	yRKbn7gUx8ml28TmDQ5nBF13QS2d0ot0=
X-Gm-Gg: ASbGnctH7EsUnjzhnzJnav2lG1AN090guZ5l9x7zkQP3x2/gpzv+JrMUgeKZ/6ZWS0h
	bX9RlErD8LFKCk7m2Qr95AChBLK+RjAqrCATYpiDLF6Pt9/Gqn2d1+2RQcIIH3acOwvToU8KiXg
	tzSnWoVmdmgdnzlnk1bICCCSqrglH5A8oMYeq6FgtABawreFKZXDU4j70q1wzHvN75k1ft2jzT0
	gw1KOW78oNbL3U3hOYfN73ActWXkEAR4unxQAXEk6ZlmIaiNXPhdTESZPvX4Ll3UKtxdOs4mrmT
	T++G0+hIMfhSQMa4YOPE+ZUojw==
X-Google-Smtp-Source: AGHT+IEXSkBuzSyvc9QTdpw+t/LbyAMbPQDaHOlChqWwbq247x3QM//46PQpilrawaF80E+nqaix/QeMVOudWanVNt8=
X-Received: by 2002:a05:6402:1ed3:b0:63c:33f8:f05e with SMTP id
 4fb4d7f45d1cf-64044251d98mr2597431a12.22.1761750532597; Wed, 29 Oct 2025
 08:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029135538.658951-1-mjguzik@gmail.com>
In-Reply-To: <20251029135538.658951-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 29 Oct 2025 16:08:40 +0100
X-Gm-Features: AWmQ_bl2NSRme7C9fCgHqa9CUb0wHphZYvyxaW8JRN8tVXA4dZUYtnKuH3PY_1c
Message-ID: <CAGudoHF4i7m=aMGhC-8gcOo9m82VyLaawP73Y-8wdwgVqg0Wcg@mail.gmail.com>
Subject: Re: [WIP RFC PATCH] fs: hide names_cachep behind runtime_const machinery
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 2:55=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> All path lookups end up allocating and freeing a buffer. The namei cache
> is created and at boot time and remains constant, meaning there is no
> reason to spend a cacheline to load the pointer.
>
> I verified this boots on x86-64.
>
> The problem is that when building I get the following:
> ld: warning: orphan section `runtime_ptr_names_cachep' from `vmlinux.o' b=
eing placed in section `runtime_ptr_names_cachep'
>
> I don't know what's up with that yet, but I will sort it out. Before I
> put any effort into it I need to know if the idea looks fine.
>

The good news is that Pedro Falcato stepped in and found a spot I
failed to add the var to, this clears up the warning.

However, after further testing I found that kernel modules are not
being patched. I'll be sending a v2 with some more commentary.

> ---
>  fs/dcache.c        | 1 +
>  include/linux/fs.h | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 035cccbc9276..786d09798313 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -3265,6 +3265,7 @@ void __init vfs_caches_init(void)
>  {
>         names_cachep =3D kmem_cache_create_usercopy("names_cache", PATH_M=
AX, 0,
>                         SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL)=
;
> +       runtime_const_init(ptr, names_cachep);
>
>         dcache_init();
>         inode_init();
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 68c4a59ec8fb..08ea27340309 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -2960,8 +2960,9 @@ extern void __init vfs_caches_init(void);
>
>  extern struct kmem_cache *names_cachep;
>
> -#define __getname()            kmem_cache_alloc(names_cachep, GFP_KERNEL=
)
> -#define __putname(name)                kmem_cache_free(names_cachep, (vo=
id *)(name))
> +#define __const_names_cachep   runtime_const_ptr(names_cachep)
> +#define __getname()            kmem_cache_alloc(__const_names_cachep, GF=
P_KERNEL)
> +#define __putname(name)                kmem_cache_free(__const_names_cac=
hep, (void *)(name))
>
>  extern struct super_block *blockdev_superblock;
>  static inline bool sb_is_blkdev_sb(struct super_block *sb)
> --
> 2.34.1
>

