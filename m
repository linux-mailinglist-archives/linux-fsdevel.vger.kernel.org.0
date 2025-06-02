Return-Path: <linux-fsdevel+bounces-50328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 133C5ACAF21
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D102A1670EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 13:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20134221568;
	Mon,  2 Jun 2025 13:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfP8Ij3p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E55235968;
	Mon,  2 Jun 2025 13:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748871388; cv=none; b=ppw/zyA1MyzAXMLkRt9yorev2MNYRMguy28iPL8WcKVj7elwOY48HD7xYjbsGfBO2UKayq73ZrLv1xiSgardrBuNCbR06kwjo36kxARZHTXiforBkKhMkgwtZ0jCd0BJmZoFb0EudOSUo63e2eQatAjI1s39zY/juP5b9TREJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748871388; c=relaxed/simple;
	bh=yYIZGQBuFhHt1sSpCGfcE/+38yjhI3Qd/vFnUS3n7ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTnmFIpxM5b7szTOwGVGIFd6sXcjcCkRXj/94QtucGvZjicQ2lflPNb9gbUcNYzSohyGfO27VWy8nW2YGX6IzBRijpbIMaJPrK3Ne/rhO9yZUPewF1+z7ZQEbLUlCNXJJNjTr8m5tdoqMrYhudP/i+LLjiSB+94N/VRS5MDrrEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfP8Ij3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5541C4CEF7;
	Mon,  2 Jun 2025 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748871387;
	bh=yYIZGQBuFhHt1sSpCGfcE/+38yjhI3Qd/vFnUS3n7ig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cfP8Ij3puq2LLuTwhq6fAcrxPYCv782dyBduEpFyi5roGbLqa/PeyOwc/K/QKWNhx
	 2ckO5ro7iFqhprBUy0ggkZUZGkXaJWfMacNbr+omya4NSZEEgfDICRha7uVbJmd0d/
	 HjfY9qLFypeniLgoIGfMlnxWLOIHb3GQtN/oApkTJMpGAyW7rZYH5fsL5JwO8f5R4G
	 rXkCTD7+GKPXYZR/2AxmZ8ctzjDopgNgKXC9AG/TeoufwRs2tIZfiTSyExnm91E4K3
	 oBQ4oo5eq3SHwJPYBRMCDVaDQHXnQ219iUnpRCuRlrDbLwLGIIOAnpGpwBY2K3W9Sv
	 zQd4rCecRnxSA==
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a42cb03673so60268851cf.3;
        Mon, 02 Jun 2025 06:36:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUG0fPNN2dqz5Yx4G4gwHcT5auVqliQ+Cvhs7U339+bOzmb4qlMksGE1fphlwfG0s86/uBBhuF9MNgQho+jXw==@vger.kernel.org, AJvYcCUgA/XLNMjh6kP9QKhzGQFSdqkHO0xJzcqHbvj6zE/ROuDItpdHEzaqDcm/x0eFvo7uaGA=@vger.kernel.org, AJvYcCWcJDf1NFlj6oIoJEu/WdtgddvVOnSf1hKo5stSIHM7/Ws9baH1sbbMOpqaY0RODAq6R0giFw+bR58PdeiPnW09oDasrAA8@vger.kernel.org, AJvYcCX+r1D6uFZFtfaAe6irmUkJM7WMPx+h7u+TpQo4GnwaLlq+FmW08hAdBTxb/8dwHykczXemKW1Qhqg7lDpq@vger.kernel.org
X-Gm-Message-State: AOJu0YxpOmIqy32cUVxarxIiC++nACwcoFlJOoIdHHNdRs2tHwkq8RmF
	hUiOBEkGmRGfaSm028AKZaRbmZWdXvC/LOf52D5e3HfNGHuPvoqGIdnSZl62TyGf6E5oFBuNJjT
	mYeE8Q1V9G3Ig+7kbUSWvR8ExDxO6uVw=
X-Google-Smtp-Source: AGHT+IFnaxclk8wKk+p4lZT7/tGTTg7GviThvM9sxwdY2MN6ZEoN7ZjrbV7y8+zsvm/2hTQZKpQH7c8+sorCksEdz9U=
X-Received: by 2002:a05:6214:3003:b0:6fa:c99a:cdba with SMTP id
 6a1803df08f44-6facebb25fdmr215338396d6.14.1748871386997; Mon, 02 Jun 2025
 06:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250528222623.1373000-1-song@kernel.org> <20250528222623.1373000-3-song@kernel.org>
 <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
In-Reply-To: <027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org>
From: Song Liu <song@kernel.org>
Date: Mon, 2 Jun 2025 06:36:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5BhAJ2md8EgVgKM4yiAgafnhxT9aj_a4HQkr=+=vug-g@mail.gmail.com>
X-Gm-Features: AX0GCFtIYCGZ2rdbW1qxGntJdE5zDJM2U5n33aRf5NCou1sXG5anK88K_CBn9GE
Message-ID: <CAPhsuW5BhAJ2md8EgVgKM4yiAgafnhxT9aj_a4HQkr=+=vug-g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] landlock: Use path_parent()
To: Tingmao Wang <m@maowtm.org>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com, 
	amir73il@gmail.com, repnop@google.com, jlayton@kernel.org, 
	josef@toxicpanda.com, gnoack@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 31, 2025 at 6:51=E2=80=AFAM Tingmao Wang <m@maowtm.org> wrote:
[...]
> I'm not sure if the original behavior was intentional, but since this
> technically counts as a functional changes, just pointing this out.

Thanks for pointing it out! I think it is possible to keep current
behavior. Or we can change the behavior and state that clearly
in the commit log. Micka=C3=ABl, WDYT?

>
> Also I'm slightly worried about the performance overhead of doing
> path_connected for every hop in the iteration (but ultimately it's
> Micka=C3=ABl's call).  At least for Landlock, I think if we want to block=
 all

Maybe we need a flag to path_parent (or path_walk_parent) so
that we only check for path_connected when necessary.

Thanks,
Song

> access to disconnected files, as long as we eventually realize we have
> been disconnected (by doing the "if dentry =3D=3D path.mnt" check once wh=
en we
> reach root), and in that case deny access, we should be good.
>
>
> > @@ -918,12 +915,15 @@ static bool is_access_to_paths_allowed(
> >                               allowed_parent1 =3D true;
> >                               allowed_parent2 =3D true;
> >                       }
> > +                     goto walk_done;
> > +             case PATH_PARENT_SAME_MOUNT:
> >                       break;
> > +             default:
> > +                     WARN_ON_ONCE(1);
> > +                     goto walk_done;
> >               }
> > -             parent_dentry =3D dget_parent(walker_path.dentry);
> > -             dput(walker_path.dentry);
> > -             walker_path.dentry =3D parent_dentry;
> >       }
> > +walk_done:
> >       path_put(&walker_path);
> >
> >       if (!allowed_parent1) {
>

