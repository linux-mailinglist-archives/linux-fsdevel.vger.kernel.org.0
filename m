Return-Path: <linux-fsdevel+bounces-12571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F208612C0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 14:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC8EC1F250CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4787F469;
	Fri, 23 Feb 2024 13:28:44 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F737EF06;
	Fri, 23 Feb 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708694924; cv=none; b=fJGHgYsb7STaD3hY9f8SCM8ymHX6jmRFUx5FkFYHAld2++7EXt8usLM62HSQDwgrVIA8M49uJsuMUvpDVbtQ90pMvUe7Jt3y0H5mI5qh+9hlSZoGJZkJr32BKvNi8D+iEugkXI8UdVJcUTw8fH3Qti/npQO/fHpd1v9P8030CZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708694924; c=relaxed/simple;
	bh=HBeXTwP6V8GWzKbXvRGCp7ccI5d7wCs1JlCvNNA4GHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lLAmV37TeJrS0868ZmI5DACCuvGjw6pVlL4L4ZwoSzDSepJYc6+rZyKCLTsVOdbOnrsXdwyHbYtvpeA9maJiQirFLLkfhnzFBbKH5iCPtg1LdTg42EzTYD3t5dYBqXshJ8MPZtOuAznU4DAJmztqUrvoSUAlc1kPLJu+21aJsWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=auristor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5640fef9fa6so1031126a12.0;
        Fri, 23 Feb 2024 05:28:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708694920; x=1709299720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1pxp9SZUqXTyshzqGMBNW9bsQ0Wd0IUJwu8yD4N1umA=;
        b=HOG1nzCsRuEXxOwPSJE9AJdYkDcwzkcOhgSep+WfpVlaBhA8xHpewLkA3fv8FoNiKv
         hfAcML83H0Yd9Y7+jfKip347YLQOHz6++lBcxZJNzYYAMm7jful2NhiY2pwX59PF46Nf
         ea+F8DmT0eS2CPYVy0RO4E3wjAmsYRlzO93RAPgP6jBZBBLdkU5tp4Sq0rvWvb4OxO7w
         iwBgIRQCOT5jkJLJokFFaXMxPMrpqLn6NAnQQDDqHp/r9VNqS4MwlGYmbYO8zaGaLa0C
         xWghFDBCYpQvxZzWI8oFZvpzE7MkNjTyjpzKsedgZ2gs90bwtozDQvkJp2EfuUoBhv3U
         VcYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfdRP0EKionPRCOXZxVEw6WHSanrK4mcaqBpcW5PGcFk4NS6MHYMMgh0dANOHDUS+r95hHH2kHDEaIs3IIDnBEweAxYHj7pGVmQzRNLyC3Efy82ln9ivh9qoTUFdrIIXouIJHr80Rd9tvspw==
X-Gm-Message-State: AOJu0Yx/yqbJWPoiwvBM5d/f3fxUIQUzpOPenBtkztcXr/Czntcv6AGe
	R9LkTqryfBVS0y9MA67U1/ZyWIZ9Jyzysp7/vXMI4SlNXf0DRpJ/SpE7nmaeNedRmA==
X-Google-Smtp-Source: AGHT+IEt5ukyCi6juaBcTv7LG71P8GlHsU0WQp8yd08i4vXieMWXhl1JUOTBc4ePdp8lzP3CGTjemg==
X-Received: by 2002:aa7:dd0f:0:b0:564:ded0:6072 with SMTP id i15-20020aa7dd0f000000b00564ded06072mr1391419edv.1.1708694919979;
        Fri, 23 Feb 2024 05:28:39 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id e18-20020a056402149200b00563c63e0a13sm6441222edv.49.2024.02.23.05.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 05:28:39 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so1020699a12.1;
        Fri, 23 Feb 2024 05:28:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV73BGPLkv0YBnNqC3XFBVNfCbK5ED+QYpxfdQ3SbDuGtx1sbt8YKzM8aZczd9S7S8VSBvBVNBDNA6MTUJNRBRUVxEPrfJyjMFAbrKLBECPNxVV3hahmLsschQ6w0UVy8iD5cXbQJTgCqvTug==
X-Received: by 2002:a17:906:a112:b0:a3e:4404:dc7 with SMTP id
 t18-20020a170906a11200b00a3e44040dc7mr1404625ejy.23.1708694919517; Fri, 23
 Feb 2024 05:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <786185.1708694102@warthog.procyon.org.uk>
In-Reply-To: <786185.1708694102@warthog.procyon.org.uk>
From: Marc Dionne <marc.dionne@auristor.com>
Date: Fri, 23 Feb 2024 09:28:28 -0400
X-Gmail-Original-Message-ID: <CAB9dFdvDitrof7a4Df1ziJJHnfqNModR7ZxBD971VCZuxyiEZQ@mail.gmail.com>
Message-ID: <CAB9dFdvDitrof7a4Df1ziJJHnfqNModR7ZxBD971VCZuxyiEZQ@mail.gmail.com>
Subject: Re: [PATCH] afs: Fix endless loop in directory parsing
To: David Howells <dhowells@redhat.com>
Cc: Markus Suvanto <markus.suvanto@gmail.com>, Christian Brauner <brauner@kernel.org>, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 9:15=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
>
> If a directory has a block with only ".__afsXXXX" files in it (from
> uncompleted silly-rename), these .__afsXXXX files are skipped but without
> advancing the file position in the dir_context.  This leads to
> afs_dir_iterate() repeating the block again and again.
>
> Fix this by making the code that skips the .__afsXXXX file also manually
> advance the file position.
>
> The symptoms are a soft lookup:
>
>         watchdog: BUG: soft lockup - CPU#3 stuck for 52s! [check:5737]
>         ...
>         RIP: 0010:afs_dir_iterate_block+0x39/0x1fd
>         ...
>          ? watchdog_timer_fn+0x1a6/0x213
>         ...
>          ? asm_sysvec_apic_timer_interrupt+0x16/0x20
>          ? afs_dir_iterate_block+0x39/0x1fd
>          afs_dir_iterate+0x10a/0x148
>          afs_readdir+0x30/0x4a
>          iterate_dir+0x93/0xd3
>          __do_sys_getdents64+0x6b/0xd4
>
> This is almost certainly the actual fix for:
>
>         https://bugzilla.kernel.org/show_bug.cgi?id=3D218496
>
> Fixes: 57e9d49c5452 ("afs: Hide silly-rename files from userspace")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Markus Suvanto <markus.suvanto@gmail.com>
> cc: linux-afs@lists.infradead.org
> ---
>  fs/afs/dir.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/afs/dir.c b/fs/afs/dir.c
> index b5b8de521f99..8a67fc427e74 100644
> --- a/fs/afs/dir.c
> +++ b/fs/afs/dir.c
> @@ -479,8 +479,10 @@ static int afs_dir_iterate_block(struct afs_vnode *d=
vnode,
>                     dire->u.name[0] =3D=3D '.' &&
>                     ctx->actor !=3D afs_lookup_filldir &&
>                     ctx->actor !=3D afs_lookup_one_filldir &&
> -                   memcmp(dire->u.name, ".__afs", 6) =3D=3D 0)
> +                   memcmp(dire->u.name, ".__afs", 6) =3D=3D 0) {
> +                       ctx->pos =3D blkoff + next * sizeof(union afs_xdr=
_dirent);
>                         continue;
> +               }
>
>                 /* found the next entry */
>                 if (!dir_emit(ctx, dire->u.name, nlen,

Reviewed-by: Marc Dionne <marc.dionne@auristor.com>

Marc

