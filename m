Return-Path: <linux-fsdevel+bounces-51215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC9AD4792
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 02:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34648168FDB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 00:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04A49641;
	Wed, 11 Jun 2025 00:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix7qs+1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878B5695;
	Wed, 11 Jun 2025 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749603375; cv=none; b=j35bMFGyOAy7se/lXdbdoHUEtOs8NYNiSb4sc5anrLSll9FBN8PUD3qQu1L05L1SwpDkvVZtBL8OqtSQqO4ueHZwtUudlerTP3O2iSdObSJNsd2JthN5jiLXxjTxvvC6gsT79Oo2aHJVfszVYy3v2ugXTb5kJpzRQBs+BvPl204=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749603375; c=relaxed/simple;
	bh=yW2+s1S0dYwBFjAXmnAj4igW3DXypljO3osHyrjTWuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbhJYwScE1o4jB2AANuh96Fo6OxPh7zkCip4muhUNszep23bIUQXUlUrcZbRC8UKntNHrTw1UqS1gsORhIJf4UHiT9z+wU/66pdTbU1cuPoJarwQbAi2+ZF2Bf42bKmlpANESGikAMvyTedrw0luKljz6zfmPgZU8NkgMqUoElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix7qs+1O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEB6C4CEF7;
	Wed, 11 Jun 2025 00:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749603373;
	bh=yW2+s1S0dYwBFjAXmnAj4igW3DXypljO3osHyrjTWuo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ix7qs+1OOS03g3OgEyAqtA3tJ1Km6thWuMpTMlUAB4t3wtHZs1xKmfp4yAhk+kPXD
	 u9cL2ZGQJmwYFaQgjA6n2vk9Bv2plghnHQEop9bltf4sJopPBhGfV7kKTCZasn53hO
	 2AYpoTZsAwqVOg+OvKXDphjI0SGVu7CWFyIu2YlWbLxi4WAhuF/3l5d/Jwz7wCJR3x
	 nR0RkqB7mIekEjtAFKb/YgjSzVnwk9/iuNFhIQH0cKuGkUFFUdK+iwmYZn3PQX3c4J
	 wmhjVvKBqb0seaoFY/mD9B6DneC1383fkc48KhXl1UGdZBU7Z9vOXmj47Dz0lJ9g6Z
	 bUuSzQBBQBf6w==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso66824376d6.0;
        Tue, 10 Jun 2025 17:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/kX6uL4WK6/foPfomJNn7nDoRlg95354czakrcZ0wqm0uAMxgjJgqNq2N9c6zn28MY2TIOdt9MvAR/WIo@vger.kernel.org, AJvYcCX81Gk5VdtTdnrAjfNKlSBsLpQEE/CIaaQicfKhf/Hc5gfmk5umZ+gxQQuNoQyu2TaTXwy6cD8anFPa5o1YEQ==@vger.kernel.org, AJvYcCXB4etdv/Dg8BAf9r69SVd526/OmWqRDsxCJIFRmt31seehrIK+C8q2lfKvlHcvOMdhGD8gHqT1YtkcBxbVRfMLp0AYdUTe@vger.kernel.org, AJvYcCXYeGVn645RuHHGhb96oqWh9pRLyAdXnqX+f/2Wlj5uAekt2g3NVqB1xkLioIdmMaraKSo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbe5WWIKoezrujSp+/4xyxgfU9hGx7HAN203stASTv1fMmpqNv
	u18AsS8FshYU8ODD354JurqT44hSC1/T+3LOmZhlkgQPpTsy51Lriu1+5dOlgRtsdV82MUqXErW
	lbjtWez9cQqqziSRYa5Y/0bufUUnKVNY=
X-Google-Smtp-Source: AGHT+IGSVeuJ+FOXkPbiyzb4l38dn5Y2lPF187pto/+/yD/Nj5qfj6UaX5J81ibPmEr9a8rn1ItvqlL0uinCvFk/UwU=
X-Received: by 2002:a05:6214:e87:b0:6f4:cb2e:25cc with SMTP id
 6a1803df08f44-6fb2c375cbcmr25386766d6.32.1749603372419; Tue, 10 Jun 2025
 17:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606213015.255134-1-song@kernel.org> <20250606213015.255134-2-song@kernel.org>
 <174959847640.608730.1496017556661353963@noble.neil.brown.name>
In-Reply-To: <174959847640.608730.1496017556661353963@noble.neil.brown.name>
From: Song Liu <song@kernel.org>
Date: Tue, 10 Jun 2025 17:56:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
X-Gm-Features: AX0GCFvEtC27CfJCDtYJnIsvh1XG7Q2O9NKGpEtUlKwZpyuicB1tN-YkqmLZmHU
Message-ID: <CAPhsuW6oet8_LbL+6mVi7Lc4U_8i7O-PN5F1zOm5esV52sBu0A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/5] namei: Introduce new helper function path_walk_parent()
To: NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, mic@digikod.net, gnoack@google.com, m@maowtm.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Neil,

Thanks for your suggestion! It does look like a good solution.

On Tue, Jun 10, 2025 at 4:34=E2=80=AFPM NeilBrown <neil@brown.name> wrote:

> The above looks a lot like follow_dotdot().  This is good because it
> means that it is likely correct.  But it is bad because it means there
> are two copies of essentially the same code - making maintenance harder.
>
> I think it would be good to split the part that you want out of
> follow_dotdot() and use that.  Something like the following.
>
> You might need a small wrapper in landlock which would, for example,
> pass LOOKUP_BENEATH and replace path->dentry with the parent on success.
>
> NeilBrown
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 4bb889fc980b..b81d07b4417b 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2048,36 +2048,65 @@ static struct dentry *follow_dotdot_rcu(struct na=
meidata *nd)
>         return nd->path.dentry;
>  }
>
> -static struct dentry *follow_dotdot(struct nameidata *nd)
> +/**
> + * path_walk_parent - Find the parent of the given struct path
> + * @path  - The struct path to start from
> + * @root  - A struct path which serves as a boundary not to be crosses
> + * @flags - Some LOOKUP_ flags
> + *
> + * Find and return the dentry for the parent of the given path (mount/de=
ntry).
> + * If the given path is the root of a mounted tree, it is first updated =
to
> + * the mount point on which that tree is mounted.
> + *
> + * If %LOOKUP_NO_XDEV is given, then *after* the path is updated to a ne=
w mount,
> + * the error EXDEV is returned.
> + * If no parent can be found, either because the tree is not mounted or =
because
> + * the @path matches the @root, then @path->dentry is returned unless @f=
lags
> + * contains %LOOKUP_BENEATH, in which case -EXDEV is returned.
> + *
> + * Returns: either an ERR_PTR() or the chosen parent which will have had=
 the
> + * refcount incremented.
> + */
> +struct dentry *path_walk_parent(struct path *path, struct path *root, in=
t flags)

We can probably call this __path_walk_parent() and make it static.

Then we can add an exported path_walk_parent() that calls
__path_walk_parent() and adds extra logic.

If this looks good to folks, I can draft v4 based on this idea.

Thanks,
Song

[...]

