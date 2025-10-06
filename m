Return-Path: <linux-fsdevel+bounces-63491-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DAEBBE282
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26ECC4EE0F2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D244A2C3271;
	Mon,  6 Oct 2025 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WADEXV5y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B6C2C2348
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756602; cv=none; b=lM54q3BF/7enwjlgCuEr6m1RVuEvjonHLMUTRP7vWCDzqtSyKI+1pfv3DBvGnTxtuBHzzOCzxVEmfaEMN3T7rahQ4hSCjDUPjf+EpnAiQQF68SLFmwggSA6OuJFEl8VcFlet4qC7Qj6ZuF09BL+C6YF77aeC4kSt5Q703/wWP34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756602; c=relaxed/simple;
	bh=9RiibcQ8hYvWrHwNJrsOBQZBaxnayLS0Ew1MmhtqWo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aggZ8D7zL0/5zKXaBUJE9Gu8PJcR5E0LwQGLGkKMNIXvXjwaGEiocq6PVc/Z64HkLSZP7FWsbtR6uPFAB1NpV+5KOj00qxs0GvTn4eBIYNNfcgxWVbrlI4zkVS3zuOzCZlZNtBE1H0xqMvOw5sHFWSIcjqeJ0gXhU0o9aJ6XhKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WADEXV5y; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso10421852a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Oct 2025 06:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759756599; x=1760361399; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=WADEXV5yL2pC5NDHItmncaXGE0hSdlv5UmaUabVz4OMowbUupEA2eTTd1Uk3iqDpiF
         FEcLPKLKFnOS5py3TFC9kWn3ztjBCuztlFmOEfacKAQttpJJQxc/xbeAn65EotLasYzM
         sj8ai6VFZM947QQLp/mb+TyctQSb5Hchyz6+CiRLDsghMTeL5f/FpjefA3x2Ppw3oBZw
         Dp9PngFT4H8gkJp7Aa+ZXu0H2UAovDLOJlmufZsREgxIA7sA6pPxcgNTwUgwQxyKXSvn
         YJr02dz1QtQaS7yolIBlYpluGlBpvbkCcVAxyhuHgXGCdi9jTWs+D6PmvrU/3U3IxJ1b
         oqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759756599; x=1760361399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yONkX6le0asFqe/FiMMLWvsxiXDZUAvFOOTqPAZxMYs=;
        b=YC1ieQ1M7q6ngxE7uHCszcdlqmiLanmf2yQuVSOiwb2GOjJqQUPwH8iTR2UF5VaKR6
         ZfB6wcdnBpz18QE9s5lsJV2wThnBJNsAX+QwIxq0E6JWxS0RnUubL/jXrzRTuwfk7FcA
         tRQyyEYSAA+QZwhxGJiWRzDLNj+VooKuVMPn2kAaRQAaOICFlPm736cmCHPTyx00NLwE
         /xFNJ+CJDOWuXhMCugzCRFp1LWMPbcssWHiBTTsN63rLQ/E6KjSyPH1pt4csNydIv+7h
         YLfZ3JaQ/H23rZ8Qv0im7HWvio/t1zl9Eur678aFpFqUKiBf1G/P7Gj5ygG98H02L+tn
         gGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjrq49W+z59HJSGGecRL/Mlbh/IsepXT56gL1pTpIqx+Twig/cRF1caMwE86Oq9BcHt+1KIo+ygXKqmxYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwHemjDUX+CB0G5xrKbSVr0xzkintHUKA/xDAwACgQoaPKAo0UR
	EfTgU7xOvNkT8ZEQBhZMqcM4xojWGKJTY2nftRzp0hGFXQYvO6BYAYfviJi9PGx+IjiyJ1hJhN2
	tcThUU4gNOMBDwHLOcJh6Ftv4A8uc78sPpS+H
X-Gm-Gg: ASbGnct0yCDHzeF7oN7wHWwwLYmtMbWcA2d3Kpwsf8paAtfEo0u8/PPZn073V3zsRb0
	hzZzYNdJO4Fup851CX9GQQFVOHBGQx51ewHR4y6X9OvvhHH2fgtJvpl4Fnj2alvVHPHn+JzqQYd
	Y42SnoAX9CvP4A1+vCv7RvStkEzmtUhaniM1wMF2OU0waM2rAIKUrLfH3sljdc1D1QbyykY3zO2
	6ME8PmK+yTiQGUNwqUS9nHwl+7Up/omciTJP7gs94ld5rIfPATSIIGRILNHG3hbmgwPonJIoQ==
X-Google-Smtp-Source: AGHT+IGgfaKILwiIYhOJauD31uynKvUTNQB8TM3B4u9+8sn3XNc0LxMTwvmUPPVqZHvJq+WHY2tARoUrXupUK50gMkY=
X-Received: by 2002:a17:906:37c5:b0:b4a:e7c9:84c1 with SMTP id
 a640c23a62f3a-b4ae7c98631mr906398266b.7.1759756598374; Mon, 06 Oct 2025
 06:16:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923104710.2973493-1-mjguzik@gmail.com> <20250929-samstag-unkenntlich-623abeff6085@brauner>
 <CAGudoHFm9_-AuRh52-KRCADQ8suqUMmYUUsg126kmA+N8Ah+6g@mail.gmail.com> <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
In-Reply-To: <20251006-kernlos-etablieren-25b07b5ea9b3@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 6 Oct 2025 15:16:26 +0200
X-Gm-Features: AS18NWCEM0fjjZM6zlyL8ddYZ6bYQjBB781Tu0JzfRDs6qIJETdk0ZVa55ZRAIQ
Message-ID: <CAGudoHGZreXKHGBvkEPOkf=tL69rJD0sTYAV0NJRVS2aA+B5_g@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] hide ->i_state behind accessors
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 1:38=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Sep 29, 2025 at 02:56:23PM +0200, Mateusz Guzik wrote:
> > This was a stripped down version (no lockdep) in hopes of getting into
> > 6.18. It also happens to come with some renames.
>
> That was not obvious at all and I didn't read that anywhere in the
> commit messages?
>

Well I thought I made it clear in the updated cover letter, we can
chalk it up to miscommunication. Shit happens.

> Anyway, please resend on top of vfs-6.19.inode where I applied your
> other patches! Thank you!

I rebased the patchset on top of vfs-6.19.inode and got a build failure:

fs/ocfs2/super.c:132:27: error: =E2=80=98inode_just_drop=E2=80=99 undeclare=
d here (not
in a function)
  132 |         .drop_inode     =3D inode_just_drop,
      |                           ^~~~~~~~~~~~~~~

and sure enough the commit renaming that helper is missing. Can you
please rebase the branch?

