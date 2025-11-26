Return-Path: <linux-fsdevel+bounces-69850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D416C87D54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 03:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 79054354C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Nov 2025 02:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF09530AAD7;
	Wed, 26 Nov 2025 02:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B97LgetU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C0D2741DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Nov 2025 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124387; cv=none; b=hXLWPwyyMq5Y+viHaliTTnfRKcM+yb9PqJ59j6IcwbgtLxlpiXk4bjKSuZDE7kOA9HSV+yCPP+hHmpQjT1OeFZ/jLn8sTnUmPu2dTNc/3w+SiPLwtYjkbMkEe/zmiYSsaQH0IFt/0KYhCNQvzddLMfLuUYwABaXPiwacsi4/4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124387; c=relaxed/simple;
	bh=heab5ckAK1fFviUNmJ84I616BYytWgkpA71/+b3vHNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EoQRi8pWwrqpz0xlt/RkIMb7QEBfMttUJYX0blfDYSsapDpeIUYOCT0eTGoNt2SNC9ed0COKqCU/lsfQXoU6jV5N/TKStKWKRvpSqZ0Chj/gVzhQQuSOEAwS7inM0YKpL8ZTU7tCjUKeUKqx2b8DRMgtoy6Ot0PH31OUtEEIYSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B97LgetU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so8242089a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 18:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764124384; x=1764729184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3v95UxGSVtzFIEDr4NpXxfP+YCxHvXIzJX8kGy4Kd9M=;
        b=B97LgetU6OPd2gb8DdF4PQk+sPpxxNNBgmT45i6tfFdmcAvcze94fPtjnnBY3kd7GT
         UkrOl++KZf/g1+hnCj8li+AOHV1cAfsw1Z1TeGCbkoyYVtrPYnFWkRKiBj4VPqX1yS5J
         7ED45ihzMvJSkn2uVhx8idRZnrVnNQrIhW+iUvb1wMpXYHe2xwNEYxbBQ0wul+fg8ffh
         rb2/ITcasZUjr5VJZ2uNvDb1j1Uw2gqrEgDAVhCWUfW+jm44oW2OGDeyazrK9anhH5K4
         QCXmBgEA6SLB/h00aYNk2AEWmZaHrjk7n6vRmHbUVnw+nm5vy9QG9VxeH1sHzA4ycQvJ
         2fxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124384; x=1764729184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3v95UxGSVtzFIEDr4NpXxfP+YCxHvXIzJX8kGy4Kd9M=;
        b=xRnqA6KmFIsGwAzD49tMdzXJe/NDZ6KnsoCT3+vEdsf8CyaB8DVuac0y6N80pOvf8s
         d3Z2i6KL3NpfL41I1FSHWNc/OZyGaBcqVyNlRFhp4gB46f9Cvhrcs4T1Ygub8lRlvK6L
         /R66xM6J0FU3dad0UqEzRw3KLs3MudIihWHfakQDnA6QpGZNxqw7w0qDfp/9yDZ4wQ6+
         FvgvPfpOmqUd/8vhAxatEoihtZ86WxTKhl7Zk8Ik+0HYAAifrJ7ogLeGFBVozmxDRtCn
         kDnLCrGf5ixSJ/uxSDPk/+b2itA1SJz+fnuYd6JggnBhGapFxUOquFGtcPN1XeVO36Vf
         OgRw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7Y7H3mikp3OAufmTUhrb6LpkjhjAaUgEhOCTvMODj/sOXwjYuBM+qdhnMFS3GECOVhWsIPjIUMJqqkMD@vger.kernel.org
X-Gm-Message-State: AOJu0YxbD0NYPdB82oJDZenF5KEjYEQYWUO5+J8QXJcOx7dHn5L9Roc6
	JBDDBCTxM5ShoNhg4iWra09ApJ3dWPMSvcsGboezmKuJXcvjQ2AfMWq0kzBvXZLVYTB+gFuuy2N
	/WpyfFP2K3kXClzJe8rOddzF/8fz3tgo=
X-Gm-Gg: ASbGncuHyukct519aYWbfxME014urfhCsqcl5iFvECE2xp7ACQRqP/owVCDRD/8LdZt
	A+bZ3Vx4hi58a0XWdUJAO0Q12qosXQXHL0gJGPLPV3TjeNU8PQ9s+VDiRD9flBf01aDLAYy29I/
	pIxT5+mkjEfiJW8tt/xKz4Km5mSo/yM22bIR5vhOhHwVAEH/9Whv21hLRlAyk2iaIAGkCNqgr2e
	Ix13Tx53OJzWct4yv3QOmAbWFpTKSiWY9Nohtxbtt31/t9rrCZV+jSJedhm+gANKP2WUPVLzSWS
	DiaZNNNxk2YYpFVymruC0hffrw==
X-Google-Smtp-Source: AGHT+IF+R9gvPXQVy2/5W5kADTe/UK3jLDn10dS2ldcWO5W1Keeniw4mV8mQk79eRQMaCHSoHLSEGQ4B7JVsmZX/1BM=
X-Received: by 2002:a05:6402:3491:b0:640:96fe:c7c2 with SMTP id
 4fb4d7f45d1cf-64555b868c7mr16679409a12.5.1764124383364; Tue, 25 Nov 2025
 18:33:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120003803.2979978-1-mjguzik@gmail.com> <20251120003803.2979978-2-mjguzik@gmail.com>
In-Reply-To: <20251120003803.2979978-2-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 26 Nov 2025 03:32:51 +0100
X-Gm-Features: AWmQ_bmUE7wwcTcl3P55YqP47qzAjspL4dAnGIT-V5-LgPjeHGdkx_PZ7pt5GmA
Message-ID: <CAGudoHGTUtMKk=2NuSAZj6hZLEX8qPBLYo5qHXEjYMobV8=2BQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fs: inline step_into() and walk_component()
To: brauner@kernel.org, viro@zeniv.linux.org.uk
Cc: jack@suse.cz, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping? would be a bummer to miss out on this for the merge window

On Thu, Nov 20, 2025 at 1:39=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> The primary consumer is link_path_walk(), calling walk_component() every
> time which in turn calls step_into().
>
> Inlining these saves overhead of 2 function calls per path component,
> along with allowing the compiler to do better job optimizing them in plac=
e.
>
> step_into() had absolutely atrocious assembly to facilitate the
> slowpath. In order to lessen the burden at the callsite all the hard
> work is moved into step_into_slowpath() and instead an inline-able
> fastpath is implemented for rcu-walk.
>
> The new fastpath is a stripped down step_into() RCU handling with a
> d_managed() check from handle_mounts().
>
> Benchmarked as follows on Sapphire Rapids:
> 1. the "before" was a kernel with not-yet-merged optimizations (notably
>    elision of calls to security_inode_permission() and marking ext4
>    inodes as not having acls as applicable)
> 2. "after" is the same + the prep patch + this patch
> 3. benchmark consists of issuing 205 calls to access(2) in a loop with
>    pathnames lifted out of gcc and the linker building real code, most
>    of which have several path components and 118 of which fail with
>    -ENOENT.
>
> Result in terms of ops/s:
> before: 21619
> after:  22536 (+4%)
>
> profile before:
>   20.25%  [kernel]                  [k] __d_lookup_rcu
>   10.54%  [kernel]                  [k] link_path_walk
>   10.22%  [kernel]                  [k] entry_SYSCALL_64
>    6.50%  libc.so.6                 [.] __GI___access
>    6.35%  [kernel]                  [k] strncpy_from_user
>    4.87%  [kernel]                  [k] step_into
>    3.68%  [kernel]                  [k] kmem_cache_alloc_noprof
>    2.88%  [kernel]                  [k] walk_component
>    2.86%  [kernel]                  [k] kmem_cache_free
>    2.14%  [kernel]                  [k] set_root
>    2.08%  [kernel]                  [k] lookup_fast
>
> after:
>   23.38%  [kernel]                  [k] __d_lookup_rcu
>   11.27%  [kernel]                  [k] entry_SYSCALL_64
>   10.89%  [kernel]                  [k] link_path_walk
>    7.00%  libc.so.6                 [.] __GI___access
>    6.88%  [kernel]                  [k] strncpy_from_user
>    3.50%  [kernel]                  [k] kmem_cache_alloc_noprof
>    2.01%  [kernel]                  [k] kmem_cache_free
>    2.00%  [kernel]                  [k] set_root
>    1.99%  [kernel]                  [k] lookup_fast
>    1.81%  [kernel]                  [k] do_syscall_64
>    1.69%  [kernel]                  [k] entry_SYSCALL_64_safe_stack
>
> While walk_component() and step_into() of course disappear from the
> profile, the link_path_walk() barely gets more overhead despite the
> inlining thanks to the fast path added and while completing more walks
> per second.
>
> I did not investigate why overhead grew a lot on __d_lookup_rcu().
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> v2:
> - reimplement without gotos, instead make it look like step_into
> - use d_managed instead of open-coding it
>
> Technically this version was written by Al Viro, but this is just
> step_into() RCU handling with an internal RCU check removed and
> d_managed() check added which re-did anyway to make sure nothing is
> missing (that and some trivial comment changes).
>
> Since Al did not respond yet to a query what he wants done with an
> authorship and I had the cleanup prepared, I decided to send this v2.
>
> I'm more than happy to change the author and drop my name from this
> patch if that's most expedient to get it in.
>
>
>  fs/namei.c | 31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 8777637ef939..2c83f894f276 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1951,7 +1951,7 @@ static noinline const char *pick_link(struct nameid=
ata *nd, struct path *link,
>         int error;
>
>         if (nd->flags & LOOKUP_RCU) {
> -               /* make sure that d_is_symlink from step_into() matches t=
he inode */
> +               /* make sure that d_is_symlink from step_into_slowpath() =
matches the inode */
>                 if (read_seqcount_retry(&link->dentry->d_seq, nd->next_se=
q))
>                         return ERR_PTR(-ECHILD);
>         } else {
> @@ -2033,7 +2033,7 @@ static noinline const char *pick_link(struct nameid=
ata *nd, struct path *link,
>   *
>   * NOTE: dentry must be what nd->next_seq had been sampled from.
>   */
> -static const char *step_into(struct nameidata *nd, int flags,
> +static noinline const char *step_into_slowpath(struct nameidata *nd, int=
 flags,
>                      struct dentry *dentry)
>  {
>         struct path path;
> @@ -2066,6 +2066,31 @@ static const char *step_into(struct nameidata *nd,=
 int flags,
>         return pick_link(nd, &path, inode, flags);
>  }
>
> +static __always_inline const char *step_into(struct nameidata *nd, int f=
lags,
> +                    struct dentry *dentry)
> +{
> +       /*
> +        * In the common case we are in rcu-walk and traversing over a no=
n-mounted on
> +        * directory (as opposed to e.g., a symlink).
> +        *
> +        * We can handle that and negative entries with the checks below.
> +        */
> +       if (likely((nd->flags & LOOKUP_RCU) &&
> +           !d_managed(dentry) && !d_is_symlink(dentry))) {
> +               struct inode *inode =3D dentry->d_inode;
> +               if (read_seqcount_retry(&dentry->d_seq, nd->next_seq))
> +                       return ERR_PTR(-ECHILD);
> +               if (unlikely(!inode))
> +                       return ERR_PTR(-ENOENT);
> +               nd->path.dentry =3D dentry;
> +               /* nd->path.mnt is retained on purpose */
> +               nd->inode =3D inode;
> +               nd->seq =3D nd->next_seq;
> +               return NULL;
> +       }
> +       return step_into_slowpath(nd, flags, dentry);
> +}
> +
>  static struct dentry *follow_dotdot_rcu(struct nameidata *nd)
>  {
>         struct dentry *parent, *old;
> @@ -2176,7 +2201,7 @@ static const char *handle_dots(struct nameidata *nd=
, int type)
>         return NULL;
>  }
>
> -static const char *walk_component(struct nameidata *nd, int flags)
> +static __always_inline const char *walk_component(struct nameidata *nd, =
int flags)
>  {
>         struct dentry *dentry;
>         /*
> --
> 2.48.1
>

