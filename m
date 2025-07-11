Return-Path: <linux-fsdevel+bounces-54599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A97B01740
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED761C448E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 09:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDF62517AA;
	Fri, 11 Jul 2025 09:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcou9FrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFD424EF8B;
	Fri, 11 Jul 2025 09:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224915; cv=none; b=CBrVgtSgqSpLlOvfZo/ITawUhvDggONw7AYYayKKJREeGEO5HeynDAmx4/CFF9iRD8gCRdWKWBhbPnu9TQYz3agQCB2MqIIBePhj/Pfqft7X+aBVUaslFnX8sqwsPUYQaLywItrpzY3BxYdVXJEuCIr643PJ1mfHUq3vPzVxlMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224915; c=relaxed/simple;
	bh=Nj7J6nXf6EIGihTEI/dKrkPfpx4tg0ChZr6+KkbVkmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lHlTi5lncZT1VL8t0d0/5j7h8fs2uTDVmOl0KUAYls6lNRRSTE/qCTzspujETn4uYg9K5QSlPXy7Rij92vlMf9fD6z3GHgT1PnMK8Zpq8BUPtCif00S7CDjInA5fdktWrKFp2G+rSpmHa2+o5YhOFJxDHanX+op/Rct30NY+0B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcou9FrN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0c4945c76so297692366b.3;
        Fri, 11 Jul 2025 02:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752224911; x=1752829711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nj7J6nXf6EIGihTEI/dKrkPfpx4tg0ChZr6+KkbVkmg=;
        b=Lcou9FrN2OY4D4uExZxa2TqxP2HbMyuDJ2VUgMFjIxERsjBvg9dG0h5w1LGkv26MZZ
         7b/ACJ/4XcWXdopz9Ji3Z/8TM7tKvmDsdmBEuDG16M7otygY0hovsTopDGnN9F33KVNI
         Y5B+dRfAb1Pe/4gDAEZzzhfK/h/iz1xsADy/3hS9/ARzDTyv+xJ/KuTnlEZiZRXKqEWZ
         tYz6N0CBBhlRXvblTTgWC9gfRHShr7NC4IacWGGDM5DsCkBEWCWbvFH3kx/ZtQPwMZTP
         9pLIqPbFh3U4pgF1ELGUBGZQQ1WG5E6lqlRFyb8FD0htaVx+I0aNcqjsSHNrlaTldq7g
         mMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752224911; x=1752829711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nj7J6nXf6EIGihTEI/dKrkPfpx4tg0ChZr6+KkbVkmg=;
        b=Z80hDG8eRnQRkUhmkM5QEUz+gvy1E7kTtKsQcWsQsYs9pWGSsD/wkHP7eFGpUsW0h4
         1z33u25K6AZB1YzAZvBXgIw5nQGMZN9ictY1jDCEzW2T1knpn0+mG+08ZrChHHbGP2Qh
         Si49IjX5dYF8wUocuHJOUYwDol9OusRx03VZrGbhAhUbLs1JMAxFpbXfY2j0AZI/oCr0
         Ye/1kF4snQg21Gx67pnJMGIYkaJlVxSg2caro+oCONf7F9qYODeOqkNCOk5T29XHcweM
         +XLIqThEG8e9lXLbJuj1uPeT7ryVG8+WmHjgTaq8LB1duUpmCsmuzosb/TJgjcNy82Yi
         pRRw==
X-Forwarded-Encrypted: i=1; AJvYcCUhEh5KoyACB1gHyQKA4GVmf0YoOJg64yQNddzGPNukMyEJ5+uG3YucqcQAn/4Aim29xdMUx+N4iDShoyry@vger.kernel.org, AJvYcCVEgmJibEtGNl5jE7i0vcFu3L0kjp7bXx9EP3zImRTSAlPEMY4lYlcRY+fGajsKF6cXGepUg0+Bd2di5lX9@vger.kernel.org, AJvYcCXzsdU1cfvIYzMUm2PQ4ko0CXcAgQK6QYW5QD6MbQ1c0XNPIiA1gwE2fCRMlis99cphyk/4JwmnB06fP5LHfQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1UNqqRnAr4Lxcu5S795By8PffVVETmpYoZlixMxGSvOpY4CC
	b9y9LElOcpf7QA+zKQiMkDEX4YVx40+paTpy2MKjVDR/Up02hsJ2sV6W3Q8Qt6cyKLS6vX2JpyK
	fI0RUNlNL0w05LzpKSBJASRqK+z/l718=
X-Gm-Gg: ASbGncs928yS7z7Cvglh8UIDnWHZExTaJdgW72TaiX6B0b5GP4yzflY2n+nc7RZoyW6
	aQQk7nzkkvUm69796DaXXL+laa4sKMtaSnp3IA4QH56HgPH0mcf/Rkb6mTDINIf6X/hzBDzlaRg
	Z5tj0FcpnkTfdn/aO0e/eM7TI9Frkyki2vecx4fMSPZOUQHspoJcOAKbvXKlzs5YiArdIuTWMG1
	fTaf5M=
X-Google-Smtp-Source: AGHT+IG1YYcHAeZiqZFaK5ljgjVkAy0KRNHpUydfYKy/gl74gsXc8uopJeolrt27FRZKbrU9Dw+3gPI3w2NYlHr9zDs=
X-Received: by 2002:a17:907:fdcc:b0:ae0:e123:605f with SMTP id
 a640c23a62f3a-ae6fc219d10mr224645866b.39.1752224910305; Fri, 11 Jul 2025
 02:08:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
 <CAOQ4uxiwv8F9p8L98BiX8fPBS-HSpNhJ_dtcZAkqM02RA0LuVQ@mail.gmail.com> <00854dc3-538b-4b62-953a-68d0b9ff2295@igalia.com>
In-Reply-To: <00854dc3-538b-4b62-953a-68d0b9ff2295@igalia.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Jul 2025 11:08:17 +0200
X-Gm-Features: Ac12FXxoQTkDPfiYp1X0wbTqwcmgCow12DHl-0IhhCKIBgWVtWf2ia3EoZe5Bpg
Message-ID: <CAOQ4uxjCmZkWd8x27hiLTU0tFA1N9+Nj9T5bviiDuF+Q4ANKvg@mail.gmail.com>
Subject: Re: [PATCH 0/3] ovl: Enable support for casefold filesystems
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, 
	Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 10:54=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@ig=
alia.com> wrote:
>
> Hi Amir,
>
> Sorry for my delay.
>
> Em 09/04/2025 14:17, Amir Goldstein escreveu:
> > On Wed, Apr 9, 2025 at 5:01=E2=80=AFPM Andr=C3=A9 Almeida <andrealmeid@=
igalia.com> wrote:
> >>
> >> Hi all,
> >>
> >> We would like to support the usage of casefold filesystems with
> >> overlayfs. This patchset do some of the work needed for that, but I'm
> >> sure there are more places that need to be tweaked so please share you=
r
> >> feedback for this work.
> >>
> >> * Implementation
> >>
> >> The most obvious place that required change was the strncmp() inside o=
f
> >> ovl_cache_entry_find(), that I managed to convert to use d_same_name()=
,
> >
> > That's a very niche part of overlayfs where comparison of names matter.
> >
> > Please look very closely at ovl_lookup() and how an overlay entry stack=
 is
> > composed from several layers including the option to redirect to differ=
ent names
> > via redirect xattr, so there is really very much to deal with other
> > than readdir.
> >
> > I suggest that you start with a design proposal of how you intend to ta=
ckle this
> > task and what are your requirements?
> > Any combination of casefold supported layers?
> >
>
> The intended use case here is to use overlayfs as a container layer for
> games. The lower layer will have the common libraries required for
> games, and the upper layer will be a container for the running game, so
> the game will be able to have write permission and even change the
> common libraries if needed without impacting the original libraries. For
> that, we would use case-folded enable ext4 mounting points.
>
> This use case doesn't need layers redirection, or to combine different
> layers of enabled/disable case-fold. We would have just two layers,
> upper and lower, both with case-fold enabled prior to mounting. If the
> layers doesn't agree on the casefold flags/version/status, we can refuse
> mounting it.
>
> To avoid complexity and corner cases, I propose to have this feature
> enabled only for the layout described above: one upper and one lower
> layer, with both layers with the same casefold status and to refuse
> otherwise.
>
> The implementation would be, on top of this patchset, to create
> restrictions on the mounting options if casefold is enabled in a
> mounting point.
>
> Thoughts?
>

Good plan, but I don't think it is enough.

First of all take a look at this patch already queued for next:
https://lore.kernel.org/linux-unionfs/20250602171702.1941891-1-amir73il@gma=
il.com/

We will now check for ovl_dentry_casefolded() per dir on every lookup,
not only at mount time, so you need to rebase your patches and adjust the l=
ogic
to per-ovl-dir logic - all entries in ovl_stack need to have same casefold.

The second thing is that from vfs POV, your patches do not mark the overlay=
fs
dirs as casefolded and do not define d_compare()/d_hash() methods
for overlayfs. I think this is wrong and will result in odd behavior
w.r.t overlayfs
dcache.

I think that ovl_fill_super(), in the case where all layers are on same fs =
and
that fs sb_has_encoding(), assign ovl sb->s_encoding =3D upper_sb->s_encodi=
ng
and call generic_set_sb_d_ops().

As a matter of fact, I don't think we even need to restrict to all
layers on same
sb, just to all layers use the same sb->s_encoding and I think this
will be pretty
easy to implement on-the-fly.

Then in ovl_lookup() when composing the overlayfs stack for ovl_inode,
IFF ovl has_encoding make sure that all or none dentry on stack are
ovl_dentry_casefolded() and if they are casefolded, mark also the overlay
inode S_CASEFOLDED as well.

Please make sure to write fstests for the new functionality.
You can base you test on my WIP test for the patch that is in linux-next:
https://github.com/amir73il/xfstests/commits/ovl-casefold/

Your changes are going to change the results of my test
to allow lookup in a lower casefolded subdir
and so will need to change test expectation and add file name
case insensitive lookups to test this case.

Thanks,
Amir.

