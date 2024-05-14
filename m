Return-Path: <linux-fsdevel+bounces-19461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBA58C59CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAA46B21245
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 16:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D559F1581E0;
	Tue, 14 May 2024 16:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="bbcSV4UF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98ABDF60
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704580; cv=none; b=BkknxEHE85T82rh+WKOhhGI1OzU5Qmgrv6OiqSJpdTZg8fm+kNSvbzFVqHvRQWCdu1Ys8JK0UfGorU84lKbN80Zn7NWI8f5zY4G9N2vGF3Ju4uvoAX/VfiQdFpuYlSK1HwuWEBpWHqfvgnRm2L+mBAti5fMEIAf+5qv3L4lIwpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704580; c=relaxed/simple;
	bh=lm+zhJ+yPtQcaxB+DKN/ywbe63ow356lfn1e+/P5Zxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7REbpd9VPhSxwCM3UkcAVXrN7hV+k2M6PiNerqzsv1ZQcgsHzSRhqfR1t1pCmY+KcgJTSL0YFL339V2sZGIdOG2vZIVEOeEoLU+OlgcYNFEGRDx0Y1SJ8oeGqSTos6hMGLhXdRZpRwFYSbSDrw7wZ9/36EveReOlPETq9GQD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=bbcSV4UF; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c99e8e372fso2275266b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1715704578; x=1716309378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TVXdzVMs1VeoT7/U5XZ7/BvuwzKdJTwIaeZHIZqw7zs=;
        b=bbcSV4UFzJsbP5mMpHOFYut4XuYNmBfsAL7T60TICH2Cub+lahYkA6RzoU4cg5srgB
         CEAW61/zCE2oyb2kW68vmsx11r26b7rIHKBqJUIO6mAXg9+kLFAgqqo4ouB6Mt0HWJKM
         OEqnW0uJhpLfMqtSLMXn1GQElhBO1I8khFoOIXpYDjTDlPlmKxA8WuTlHmyGaypizKb0
         nr3XhWT1O3ctslWJac8dKpCMbZuKmVV10ennSTDZ+bmL5yGV9vvwuZ6bBpaYz8s2zBP6
         HQQTLskU/G7XPvmIIIIRpfNNuJVRGC7FMDsuZjhIVSYxuC9973CrC2g3qoD1IwPEBv89
         rnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704578; x=1716309378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TVXdzVMs1VeoT7/U5XZ7/BvuwzKdJTwIaeZHIZqw7zs=;
        b=IpPJZCGo3mkMqAdWMfh2BgvHiBwhHDDqSP7GUTd50ZLV+Fi097PVNAZt3efTPX/H33
         l37qoXCOTNdVcPKscSaU0EE08tWBNYW1Br45WwmbC1YChoTrXpA8ZHlk7ugHr/z7Kjy/
         YrI8+ZQ/TGHhdBW9UkMrUfE4EXuJ7KPwcLCRsLF9cIEC/uMBvuYMwrKZ7HDjUQXw4OAr
         OXXifaFJwABBVHZ6+eV9rObuvoPM8P8gxhY41VvwZFCVuMOYMzG8x3FUEqfWr+SHpIt4
         ONW4QxsIlCPIxO0ex++4S03XPKIW8FWI2VS2Zn42tOCRLwCQYWuUKEtd+lksVHC6CXkx
         aB/A==
X-Forwarded-Encrypted: i=1; AJvYcCUI2TfuFTdXSxCGbCTR6ImlgCpKihfKCgXabXHAJc2ZQhkqMUPYU7mEPwH81AHZkWwj2raQmzeMBSvDtIg0o4PRRu0Ep7AsPzoiRNZ+5w==
X-Gm-Message-State: AOJu0YyazSats3myUFyV9gJUvQAPypyxHf0A0jtjq298MLD5MNfimeYg
	AnC8uA5BGfYwrnLkPWQQPXrbKomgsz45EyBdPGEcI1+SZr7FsSyYm5pR09c1+SgZny4sW5/ys4X
	vLApdy6CV7DWjogTE/Tal1vIJwYY0Tg5uaMWKhg==
X-Google-Smtp-Source: AGHT+IHXhf/LB/P+OFo+FdOeXpiwPNJZ/SCkFpjq//2iG7aZGRrWYAAU+buSwBUrPXCFyNB00v9UP0HfL/s7mpQsvk8=
X-Received: by 2002:a05:6870:80c9:b0:22e:dd56:a72d with SMTP id
 586e51a60fabf-24172901007mr17239397fac.26.1715704577857; Tue, 14 May 2024
 09:36:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514163128.3662251-1-surenb@google.com>
In-Reply-To: <20240514163128.3662251-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 May 2024 10:35:40 -0600
Message-ID: <CA+CK2bCFWoLL0o2s=WnUyxPaDD09OeuHK5gqkLc6UiGC7r5sRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib: add version into /proc/allocinfo output
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 10:31=E2=80=AFAM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> Add version string and a header at the beginning of /proc/allocinfo to
> allow later format changes. Example output:
>
> > head /proc/allocinfo
> allocinfo - version: 1.0
> #     <size>  <calls> <tag info>
>            0        0 init/main.c:1314 func:do_initcalls
>            0        0 init/do_mounts.c:353 func:mount_nodev_root
>            0        0 init/do_mounts.c:187 func:mount_root_generic
>            0        0 init/do_mounts.c:158 func:do_mount_root
>            0        0 init/initramfs.c:493 func:unpack_to_rootfs
>            0        0 init/initramfs.c:492 func:unpack_to_rootfs
>            0        0 init/initramfs.c:491 func:unpack_to_rootfs
>          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
>          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha

> ---
> Changes since v1 [1]:
> - Added header with field names, per Pasha Tatashin
> - Fixed a spelling error in the changelog
>
> [1] https://lore.kernel.org/all/20240514153532.3622371-1-surenb@google.co=
m/
>
>  Documentation/filesystems/proc.rst |  5 ++--
>  lib/alloc_tag.c                    | 48 ++++++++++++++++++++----------
>  2 files changed, 36 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesyste=
ms/proc.rst
> index 245269dd6e02..4b71b3903d46 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -961,13 +961,14 @@ Provides information about memory allocations at al=
l locations in the code
>  base. Each allocation in the code is identified by its source file, line
>  number, module (if originates from a loadable module) and the function c=
alling
>  the allocation. The number of bytes allocated and number of calls at eac=
h
> -location are reported.
> +location are reported. The first line indicates the version of the file,=
 the
> +second line is the header listing fields in the file.
>
>  Example output.
>
>  ::
>
> -    > sort -rn /proc/allocinfo
> +    > tail -n +3 /proc/allocinfo | sort -rn
>     127664128    31168 mm/page_ext.c:270 func:alloc_page_ext
>      56373248     4737 mm/slub.c:2259 func:alloc_slab_page
>      14880768     3633 mm/readahead.c:247 func:page_cache_ra_unbounded
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 531dbe2f5456..cbe93939332d 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -16,47 +16,61 @@ EXPORT_SYMBOL(_shared_alloc_tag);
>  DEFINE_STATIC_KEY_MAYBE(CONFIG_MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT,
>                         mem_alloc_profiling_key);
>
> +struct allocinfo_private {
> +       struct codetag_iterator iter;
> +       bool print_header;
> +
> +};
> +
>  static void *allocinfo_start(struct seq_file *m, loff_t *pos)
>  {
> -       struct codetag_iterator *iter;
> +       struct allocinfo_private *priv;
>         struct codetag *ct;
>         loff_t node =3D *pos;
>
> -       iter =3D kzalloc(sizeof(*iter), GFP_KERNEL);
> -       m->private =3D iter;
> -       if (!iter)
> +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +       m->private =3D priv;
> +       if (!priv)
>                 return NULL;
>
> +       priv->print_header =3D (node =3D=3D 0);
>         codetag_lock_module_list(alloc_tag_cttype, true);
> -       *iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> -       while ((ct =3D codetag_next_ct(iter)) !=3D NULL && node)
> +       priv->iter =3D codetag_get_ct_iter(alloc_tag_cttype);
> +       while ((ct =3D codetag_next_ct(&priv->iter)) !=3D NULL && node)
>                 node--;
>
> -       return ct ? iter : NULL;
> +       return ct ? priv : NULL;
>  }
>
>  static void *allocinfo_next(struct seq_file *m, void *arg, loff_t *pos)
>  {
> -       struct codetag_iterator *iter =3D (struct codetag_iterator *)arg;
> -       struct codetag *ct =3D codetag_next_ct(iter);
> +       struct allocinfo_private *priv =3D (struct allocinfo_private *)ar=
g;
> +       struct codetag *ct =3D codetag_next_ct(&priv->iter);
>
>         (*pos)++;
>         if (!ct)
>                 return NULL;
>
> -       return iter;
> +       return priv;
>  }
>
>  static void allocinfo_stop(struct seq_file *m, void *arg)
>  {
> -       struct codetag_iterator *iter =3D (struct codetag_iterator *)m->p=
rivate;
> +       struct allocinfo_private *priv =3D (struct allocinfo_private *)m-=
>private;
>
> -       if (iter) {
> +       if (priv) {
>                 codetag_lock_module_list(alloc_tag_cttype, false);
> -               kfree(iter);
> +               kfree(priv);
>         }
>  }
>
> +static void print_allocinfo_header(struct seq_buf *buf)
> +{
> +       /* Output format version, so we can change it. */
> +       seq_buf_printf(buf, "allocinfo - version: 1.0\n");
> +       seq_buf_printf(buf, "#     <size>  <calls> <tag info>\n");
> +}
> +
>  static void alloc_tag_to_text(struct seq_buf *out, struct codetag *ct)
>  {
>         struct alloc_tag *tag =3D ct_to_alloc_tag(ct);
> @@ -71,13 +85,17 @@ static void alloc_tag_to_text(struct seq_buf *out, st=
ruct codetag *ct)
>
>  static int allocinfo_show(struct seq_file *m, void *arg)
>  {
> -       struct codetag_iterator *iter =3D (struct codetag_iterator *)arg;
> +       struct allocinfo_private *priv =3D (struct allocinfo_private *)ar=
g;
>         char *bufp;
>         size_t n =3D seq_get_buf(m, &bufp);
>         struct seq_buf buf;
>
>         seq_buf_init(&buf, bufp, n);
> -       alloc_tag_to_text(&buf, iter->ct);
> +       if (priv->print_header) {
> +               print_allocinfo_header(&buf);
> +               priv->print_header =3D false;
> +       }
> +       alloc_tag_to_text(&buf, priv->iter.ct);
>         seq_commit(m, seq_buf_used(&buf));
>         return 0;
>  }
>
> base-commit: 7e8aafe0636cdcc5c9699ced05ff1f8ffcb937e2
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

