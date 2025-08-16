Return-Path: <linux-fsdevel+bounces-58081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DD8B29019
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 20:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7380FAC402B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9AE2EAB95;
	Sat, 16 Aug 2025 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMij7Coy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66B2E8885
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 18:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755368910; cv=none; b=ikQppmFtoB5JO1f8V9oO57YfvZtBak7rJFHBhq/jONea7nChXFAzXHdvJfQAYKifHFIG1dTowLnbn7ZfGh0rQbj7ObO2eia12R8bKswZ9cfnG5LtA9WIUFN8Cd6hh245B5lbktJ8Y8qEhPVOsBz35rjw0Qn/C+Er4NKu86KTl/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755368910; c=relaxed/simple;
	bh=rZgnD0zZFc/ywO/kew9ze9owGRvbbsp0tSGSf4cIUhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajkYN8w0xjMlDYKDTDD08c5ghnoJlnhoXEFdb082epACWcTcgJB6dEGVPWsx0oCbEbeUJG4mGWTDuLWzbKDI4GnnV7d1pxrtHET/R+6Tp4TDgSAIz3ArLLXN8BT9pf9FC6tBqp4ebdUAk/wOiw9aLwSQ9AMgTCCt85DJ3kOYtIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMij7Coy; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e57fa6e5dbso132125ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755368908; x=1755973708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5yC7S8oCiJG7TFutzjycr6CeD4ZzxSCBJoO8pVq8kw=;
        b=jMij7CoyL9jU/S8PrRG+HZOglnmC52l+C9OSYLYe5NOeAB6MnqulJD9GMQKyVdXg7J
         rkigHGQy3U91P6mQG/Wrn3gYHbeRpMdmO1kJbkoVL+tQVsfaEIlPyQsoQAIiiudj2f9F
         1EdPFkO5DXarQS3y8Dvl5SuFhdbdqYWgU3Li3tbGEUPuKQUjdG0J9PMTzvvYCxdqJUu4
         vyGPRucU9x7gOnWtSjOGZb5gPNuVl2hjyClxYvkLqq5KUTaHc/A6BQCOEUxSTuMd0mom
         D6tFsOJxxSxwAYRQGkfpPKCoJbiFkvrmDZbnz8KcIjGeq96dQe7KwOqLyHgooaO8ShdQ
         SVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755368908; x=1755973708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5yC7S8oCiJG7TFutzjycr6CeD4ZzxSCBJoO8pVq8kw=;
        b=rQrAHQj2/kp2gny37nx3msAZJLBPPahVTnUgNCksQcgGfDHMut0FlQEtprZJwTxbmk
         ljhbTJ0s3DWZSjLC+s3lpDQ6EE8MkZGe+asdEXMLH//V1pSQh2Kgyu5I1scoG3MNYBKj
         Atf93dlLXqwHjluJUqAaRIUx3c/KvhGa6fkrzGxHnDFKOWA2sIvVKemi5irv7L3pjuij
         BvAbyfqwKUJ+NOlzh72hXDdlDuSzChuex/2o5Aw24ASV+ojWjVElzOmaWqxKJPjYO/m+
         hBLPlL3yfANkX0Dbe24T+sRny4jf0ZXZdR1G3D7LHCyB3YdTG6sBKze714QOC4WvEOqw
         zlxA==
X-Gm-Message-State: AOJu0YzqV249W8OCoGcJKZhWlqNDTpGobclzBl7exMWoT6vuBSDhHEjs
	czGvgP0pqRjvDIQnYHOeKAYj9HeeP1XOMEOqB29vN5uGd/ZvizS+ESNUmkDeb/2A+RTBRLdTSln
	K01RSZ2i/e22bg5J9E+KTddhxfiYrbA5QKnZKuMTS
X-Gm-Gg: ASbGncsQhh9znyGMlgt7xpZ/2hbljX1SdFNUHuOTa/I3BkDi7aB6OevyaWcghTS2VMm
	zp2yOlzzLm/nIOX2YuAtunTOQzJqC5Im2D+W+uCmZfVaY9vzz5pXa/U/zOZKG9UNRnbZr0gfAPA
	iZ/q8Nmpt8/IuIOwQctv0bVrTBPxPzpsIzd3BwXG7bI2PV1/xr9Euj+vFhvRq4s7A1oBPxbcCw8
	vCJAlg=
X-Google-Smtp-Source: AGHT+IG5k93sJe300fdlxnct8tJ9zdfWStAVS4BKWDLqOI3cAdjmJkF2gBOyq02tpGhbV3MZbq0vTU17zIGVB2kTMFM=
X-Received: by 2002:a05:6e02:2184:b0:3e5:7d5b:8ac with SMTP id
 e9e14a558f8ab-3e5836aaa1dmr4489355ab.8.1755368907414; Sat, 16 Aug 2025
 11:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815233316.GS222315@ZenIV> <20250815233524.GC2117906@ZenIV>
In-Reply-To: <20250815233524.GC2117906@ZenIV>
From: Andrei Vagin <avagin@google.com>
Date: Sat, 16 Aug 2025 11:28:15 -0700
X-Gm-Features: Ac12FXxJJu2rlJVPcM9KvxRWr1y8nXeaMflbMQKb07wEOPrwwRhy_BjY5InFBkU
Message-ID: <CAEWA0a5VvrVuBiBk3hFTzh2o3tswhRd69Ukjzd4qTBPYMwpNDg@mail.gmail.com>
Subject: Re: [PATCH 3/4] use uniform permission checks for all mount
 propagation changes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, "Lai, Yi" <yi1.lai@linux.intel.com>, 
	Tycho Andersen <tycho@tycho.pizza>, Pavel Tikhomirov <snorcht@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:35=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> do_change_type() and do_set_group() are operating on different
> aspects of the same thing - propagation graph.  The latter
> asks for mounts involved to be mounted in namespace(s) the caller
> has CAP_SYS_ADMIN for.  The former is a mess - originally it
> didn't even check that mount *is* mounted.  That got fixed,
> but the resulting check turns out to be too strict for userland -
> in effect, we check that mount is in our namespace, having already
> checked that we have CAP_SYS_ADMIN there.
>
> What we really need (in both cases) is
>         * we only touch mounts that are mounted.  Hard requirement,
> data corruption if that's get violated.
>         * we don't allow to mess with a namespace unless you already
> have enough permissions to do so (i.e. CAP_SYS_ADMIN in its userns).
>
> That's an equivalent of what do_set_group() does; let's extract that
> into a helper (may_change_propagation()) and use it in both
> do_set_group() and do_change_type().
>

Al, thank you for the fix.

Acked-by: Andrei Vagin <avagin@gmail.com>

> Fixes: 12f147ddd6de "do_change_type(): refuse to operate on unmounted/not=
 ours mounts"
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/namespace.c | 34 ++++++++++++++++++++--------------
>  1 file changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 1c97f93d1865..88db58061919 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2859,6 +2859,19 @@ static int graft_tree(struct mount *mnt, struct mo=
unt *p, struct mountpoint *mp)
>         return attach_recursive_mnt(mnt, p, mp);
>  }
>
> +static int may_change_propagation(const struct mount *m)
> +{
> +        struct mnt_namespace *ns =3D m->mnt_ns;
> +
> +        // it must be mounted in some namespace
> +        if (IS_ERR_OR_NULL(ns))         // is_mounted()
> +                return -EINVAL;
> +        // and the caller must be admin in userns of that namespace
> +        if (!ns_capable(ns->user_ns, CAP_SYS_ADMIN))
> +                return -EPERM;
> +        return 0;
> +}
> +
>  /*
>   * Sanity check the flags to change_mnt_propagation.
>   */
> @@ -2895,10 +2908,10 @@ static int do_change_type(struct path *path, int =
ms_flags)
>                 return -EINVAL;
>
>         namespace_lock();
> -       if (!check_mnt(mnt)) {
> -               err =3D -EINVAL;
> +       err =3D may_change_propagation(mnt);
> +       if (err)
>                 goto out_unlock;
> -       }
> +
>         if (type =3D=3D MS_SHARED) {
>                 err =3D invent_group_ids(mnt, recurse);
>                 if (err)
> @@ -3344,18 +3357,11 @@ static int do_set_group(struct path *from_path, s=
truct path *to_path)
>
>         namespace_lock();
>
> -       err =3D -EINVAL;
> -       /* To and From must be mounted */
> -       if (!is_mounted(&from->mnt))
> -               goto out;
> -       if (!is_mounted(&to->mnt))
> -               goto out;
> -
> -       err =3D -EPERM;
> -       /* We should be allowed to modify mount namespaces of both mounts=
 */
> -       if (!ns_capable(from->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +       err =3D may_change_propagation(from);
> +       if (err)
>                 goto out;
> -       if (!ns_capable(to->mnt_ns->user_ns, CAP_SYS_ADMIN))
> +       err =3D may_change_propagation(to);
> +       if (err)
>                 goto out;
>
>         err =3D -EINVAL;
> --
> 2.47.2
>

