Return-Path: <linux-fsdevel+bounces-62388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B0FB90730
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 13:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686B37A7BC8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Sep 2025 11:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2F305059;
	Mon, 22 Sep 2025 11:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nde1+5mw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530C27AC2E
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758541260; cv=none; b=f+5ePRheb1b1mF1qzbt+gyynCPwE3yhPQOP6zFjGpXU/132pCyEszUB2XikznANFXlA0pbqpQhYx42BXsJCRAsk7tT59uTZXcdVvmCWB7ppJZ/41AkTC7gZ7pf4D4yL0Z0E9YGQfm4YwRNzwGOfWxduN8yHWNOE9skW6Tl0OrdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758541260; c=relaxed/simple;
	bh=aPaErGgmbXGqvACGGtV+sP5/Bp1RbgbPMv/32zN9vRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMUOjv2UKx9N+Ozkk4BwKc5p7wORzwwM+dDmvd+GQzZDL39dRF6648tI+Fma43k971W0nFZkt0Dft7+seR4Gi7/Lcw9OPuzEp3UOrS+PYnHwqo13Lry5xmcnpGwvNLwPg3VxCx5Oy98gJYZ0S7u07yYIs5HnfX6+riZvdBbylFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nde1+5mw; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-afcb7ae31caso744648866b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Sep 2025 04:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758541257; x=1759146057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04z74R98bM0sfCQNq5YpIGFCni5y/NEJwPjehOYmg60=;
        b=nde1+5mwA9i16f8YMaGTfUf+63P3a0mKZJua8cfOlUxscN2meoJY/GNU1yVjdWfbcC
         nbsXm+eEIh2jC70c50Lph1jI0q1AQttD6XvMGZR3RrcvsVk4sMzLCqwauomoJNpHN58m
         wWhbi9CxbaQV2kmd+AK48dmDhaXvCW4FGsIDUUg33cIaQ6k1LeLc3Z5sPZMpFshJ1f68
         9VmE4hEpEr0tmZnnY5SbSOuIRGh2Ior6rrG61Gaa92lXkTW6DXcrOVDbAAhfhFZJt8CP
         zFXnOtaDdVEHjSOGpdi9JaQt5n9DM1aPMIQN0wM5K5GwZbuszoAyYs4QjRI5ByNjw2Yn
         Hd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758541257; x=1759146057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04z74R98bM0sfCQNq5YpIGFCni5y/NEJwPjehOYmg60=;
        b=u/NTTTw73s6gpgnqQhkBUHnQC786H0AhqG9iF4LfUE8aWHUqsAL+O+NNaicvA8lWcK
         d/jH/macNRqtSz8xc1f8qfXozyw+srupLVV+ZeD8v5k99BvnYKMcZz1W4caqPVntleYn
         7tuc651Mqqvs0oIMRVMEZZ7QFHfq8vovVLE/VFKAPDTOFP+ablxXJqD/1uMIzQWZqzLd
         GTmsWlQ8VEM3RqnxtVEMBHkRBz/B7+zuy+woP893pZb3Qr6JpI4EYfKrttHE1yTVHkH7
         0XXV7OQMClFxQZ8BVJHz03WgMBE0QJbaBXV94CC8bb2urc7YRtJ6GKWXHuuE5Q0Tcp9M
         G0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9GJiHc3ZAbPRYUeQK0J46ZnNKnROBqB5uAiG02asjSKZ37cyx0K4vTk1po71Yzq5+UfvhFtPWcBNumSIT@vger.kernel.org
X-Gm-Message-State: AOJu0YzjFHCqFVuK1Gf0g7N7oyZADIHVZvVSXHgX4frBHFrqnJ/Er/v/
	NnlbbLPaKvrVaRsQNezBg287jgIVuWI1tAvml5eR1Vyg9ic9J/7oduV40ntHv311ISfivGnU4Ma
	GcHhJ0Gk6I64rLYgTLrAMIoTVQu+89Jg=
X-Gm-Gg: ASbGncsEnQq8tyAXITtj5peXaqDRIiH/sI8ID60g98mgShDODiOfGPXQcqQN4Lid00x
	iW6z0rnsOE/sHBf65PpIeoHbIKUDiB08pLRKjVgFXiJ2weFJwReeA2H9fyfEvSrwsZSvtXMoyxT
	oyxGrSN/ObBTGbcqNDalyJ96zTvVF53SxhXnrwLpfD+v94aBVwPBH5rY6EtS2/FYBcc++Q/X5oN
	aeEhxqj3unJ84znx3sWEuYzcQtTYaQDr8jiBw==
X-Google-Smtp-Source: AGHT+IEoKYUb2hbctltECTBx23lnPTYILMgFVvmf1VmhRMku/GTeHmhyoKuTLZiEJXJZ8X/9p7bnSfuwpO8pk23TruE=
X-Received: by 2002:a17:907:84d:b0:b04:2452:e267 with SMTP id
 a640c23a62f3a-b24f4ebfebemr1319468866b.56.1758541256657; Mon, 22 Sep 2025
 04:40:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919154905.2592318-1-mjguzik@gmail.com> <73885a08-f255-4638-8a53-f136537f4b4c@gmail.com>
 <CAGudoHHnhej-jxkSBG5im+QXh5GZfp1KsO40EV=PPDxuGbco8Q@mail.gmail.com> <ui5ek5me3j56y5iw3lyckwmf7lag4du5w2axfomy73wwijnf4n@rudaeiphf5oi>
In-Reply-To: <ui5ek5me3j56y5iw3lyckwmf7lag4du5w2axfomy73wwijnf4n@rudaeiphf5oi>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 22 Sep 2025 13:40:43 +0200
X-Gm-Features: AS18NWBmMTL4ZSFEbiLsT0UBRmQh6SVMkgEq3_7KbEv4DQ9iOTcUeAUpn_jz6r0
Message-ID: <CAGudoHG6HgXThjeaeDWfngiNCWdikczgN_3Z_T8sKJt4CaR-ow@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] hide ->i_state behind accessors
To: Jan Kara <jack@suse.cz>
Cc: Russell Haley <yumpusamongus@gmail.com>, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	josef@toxicpanda.com, kernel-team@fb.com, amir73il@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:36=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 20-09-25 07:47:46, Mateusz Guzik wrote:
> > On Sat, Sep 20, 2025 at 6:31=E2=80=AFAM Russell Haley <yumpusamongus@gm=
ail.com> wrote:
> > >
> > > On 9/19/25 10:49 AM, Mateusz Guzik wrote:
> > > > This is generated against:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/=
?h=3Dvfs-6.18.inode.refcount.preliminaries
> > > >
> > > > First commit message quoted verbatim with rationable + API:
> > > >
> > > > [quote]
> > > > Open-coded accesses prevent asserting they are done correctly. One
> > > > obvious aspect is locking, but significantly more can checked. For
> > > > example it can be detected when the code is clearing flags which ar=
e
> > > > already missing, or is setting flags when it is illegal (e.g., I_FR=
EEING
> > > > when ->i_count > 0).
> > > >
> > > > Given the late stage of the release cycle this patchset only aims t=
o
> > > > hide access, it does not provide any of the checks.
> > > >
> > > > Consumers can be trivially converted. Suppose flags I_A and I_B are=
 to
> > > > be handled, then:
> > > >
> > > > state =3D inode->i_state        =3D> state =3D inode_state_read(ino=
de)
> > > > inode->i_state |=3D (I_A | I_B)         =3D> inode_state_add(inode,=
 I_A | I_B)
> > > > inode->i_state &=3D ~(I_A | I_B)        =3D> inode_state_del(inode,=
 I_A | I_B)
> > > > inode->i_state =3D I_A | I_B    =3D> inode_state_set(inode, I_A | I=
_B)
> > > > [/quote]
> > >
> > > Drive-by bikeshedding: s/set/replace/g
> > >
> > > "replace" removes ambiguity with the concept of setting a bit ( |=3D =
). An
> > > alternative would be "set_only".
> > >
> >
> > I agree _set may be ambiguous here. I was considering something like
> > _assign or _set_value instead.
>
> I agree _assign might be a better option. In fact my favorite variant wou=
ld
> be:
>
> inode_state_set() - setting bit in state
> inode_state_clear() - clearing bit in state
> inode_state_assign() - assigning value to state
>
> But if you just rename inode_state_set() to inode_state_assign() that wou=
ld
> be already good.

well renaming is just a matter of sed, so rolling with 3 or 1 does not
make material difference
that said, the set/clear/assign trio sgtm, i should have proposed it
after assign :P

