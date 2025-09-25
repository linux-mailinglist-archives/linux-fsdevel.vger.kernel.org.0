Return-Path: <linux-fsdevel+bounces-62683-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF38B9CEA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 02:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67C897A5AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2502D29A9;
	Thu, 25 Sep 2025 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bml3NIEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF473B1AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Sep 2025 00:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758761078; cv=none; b=qyMDgIuRjGHwYulB8UnrXqgSsgQSK9GEJDQpSSd2PY3OD5YBeFM0R2CZu+y26+hq/almO+POIVvufinxisC9NTlyrF12oE9fUmCUVCEoISUolt5Wpp/qlN2CVd4gDdOXq9FeF+BzG7DZaeUCH3f3r6mK0ZgaR4mkOCs/t/dasBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758761078; c=relaxed/simple;
	bh=Z0Pgw6DbrPIEypZdEpibIJwSO2DkG0IXdkqXmO5fy8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7asb19k5d1o22lyyNZ72Flo6G3lJdHrmmqbj7FVBryUopKYYIcIpkVbUhSOCYBBJW1oB56depxnVOAldJG9OFdbplTHESfVLp/adjaZr8q7eELhpIWEOdKQB/WtLvPP5M3F1I3NDm/84l6RVPefIZHJWGojnwobbMg4APg4mcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bml3NIEv; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea5b96d2488so410115276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 17:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758761075; x=1759365875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcKD6S8aofw7oAZ7c/lGRvBhYoMYKXS1JxMh/VvXmb8=;
        b=bml3NIEvJnBUIc1kJP3wAHKc2crVTgmqvDmNcNIDP0z6nIz2Q0Lp16At5CiO1wbVCk
         GKvhIQ1mttG0wgzlw4CqIc6+bJdL1VbyUP1fB3ZRqwdKYcl1ozttbW5ki2DfAFrL/8nf
         3h9Ewp6WUe0kTPWGnwtpjpcOCD0KISH49CItnFKo8wA6BhWT4CMPxdyysUElmleGad5l
         gh0z4wzM7VrZDmn+JZoGROUK3ny0iN7TZQc+dSbeA/Z9imvlcMBUD26XP7cdf9UoQ3NN
         75ztNgSpSU1S5+AaENLN/ynq8LIEhi9dzJKjVPYq4w5HPI1NKRw5b2AmsCsbg/tJ5jW2
         DikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758761075; x=1759365875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GcKD6S8aofw7oAZ7c/lGRvBhYoMYKXS1JxMh/VvXmb8=;
        b=PxLIyjDJ4e9b1+/3RrcRdtrCyGB8UXFXPU+BnawG9mLTjH5eMiFjHdbUt5BZLeeYdx
         3LxcHVQuh4OaBwY4AzoMcd64tMYgXRsmuCSlC+ic8TZMMS5UDoOh6eItiFcbrfUCHdaU
         cwbGWfyhT7M1PHURGAysInLHX0C4y7vVbvmhiCTVV4OYBY/MI0B5QHkek0s3V+almuDN
         A2tJc5ieNWSauTYzUngfMNvh7gjFDbFPvhSi+6QHIxVEs4E2vKaI6btjKCj0kuc72QOZ
         Yayv2BEw2HmYGqMArhvb6zXIDu5fI8et+0qrqwAUwYkivM1FPPNFhwuMW0yoZJHQL3zq
         9jsw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ+iy/MAZTLgZ57n/ieBxQWMUsgfTmwljcn3L41OxAWRqYTpG7+ZG0fFTPuc70rMCwZRrRJvLWctBxyIgs@vger.kernel.org
X-Gm-Message-State: AOJu0YyLQKvI+63dJqGNEKqww9YAj6OdC2h6d/WCpU6Z6azs71nXf7Ks
	xd5nagk3ozHRlJlnYsqzQBfg2sjacxEepRpGkoXKNU8lgRrsD1PvDvIn0lY/wL8azrooQDPgi7S
	CJMjuOCr4/hlgmt51W7K9JqDGwVnVoPw=
X-Gm-Gg: ASbGncu6PSF2F6kjAUYADhyL3VKoqZJ8TqbuhcwNbgyWDn/KFLlIOkX5nWme3Q19pvs
	5D9K7hCUlRSP2xLMubkcuxWM/bgF5jeHZo0SuO3bpom+UqnHsaalvpWyh5SNq88SDtgYlJCLgbK
	PgoQRerM2rTYrNlwiqLuKLx0NnGUN3lF66Y46YiZKrPbZybWmihHXvY/fMahmqZmN4IN3ktBD+k
	hX4zHPGuB6qfd+wiBftaBNmgs2B+plBkAiBT18W
X-Google-Smtp-Source: AGHT+IGPwxcmJ/F6M0fbyKlAHdtkVJzcZ/qUm1JE2dAlPJ4gk/LYmTsQfbIlGUshB10dV/BSdFi3LAjUox3NSPOyQ5w=
X-Received: by 2002:a05:6902:4202:b0:eac:cf24:889f with SMTP id
 3f1490d57ef6-eb37fcd8e89mr1355391276.53.1758761075589; Wed, 24 Sep 2025
 17:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924232434.74761-1-dwindsor@gmail.com> <20250924232434.74761-2-dwindsor@gmail.com>
 <20250924235518.GW39973@ZenIV> <CAEXv5_jveHxe9sT3BcQAuXEVjrXqiRpMvi6qyRv32oHXOq4M7g@mail.gmail.com>
 <20250925002901.GX39973@ZenIV>
In-Reply-To: <20250925002901.GX39973@ZenIV>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 24 Sep 2025 20:44:24 -0400
X-Gm-Features: AS18NWDXSuhO3uVQGoOdQ6qrAvEolUwAeJHd3mMcBA5ENzzIzHCfFsixbO1o2UI
Message-ID: <CAEXv5_hEXggxe5EwSHV8SK21e6HNmfYFSE9kx=ojwEobtTTGLA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add dentry kfuncs for BPF LSM programs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, kpsingh@kernel.org, 
	john.fastabend@gmail.com, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 8:29=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Sep 24, 2025 at 08:08:03PM -0400, David Windsor wrote:
> > On Wed, Sep 24, 2025 at 7:55=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > On Wed, Sep 24, 2025 at 07:24:33PM -0400, David Windsor wrote:
> > > > Add six new BPF kfuncs that enable BPF LSM programs to safely inter=
act
> > > > with dentry objects:
> > > >
> > > > - bpf_dget(): Acquire reference on dentry
> > > > - bpf_dput(): Release reference on dentry
> > > > - bpf_dget_parent(): Get referenced parent dentry
> > > > - bpf_d_find_alias(): Find referenced alias dentry for inode
> > > > - bpf_file_dentry(): Get dentry from file
> > > > - bpf_file_vfsmount(): Get vfsmount from file
> > > >
> > > > All kfuncs are currently restricted to BPF_PROG_TYPE_LSM programs.
> > >
> > > You have an interesting definition of safety.
> > >
> > > We are *NOT* letting random out-of-tree code play around with the
> > > lifetime rules for core objects.
> > >
> >
> > File references are already exposed to bpf (bpf_get_task_exe_file,
> > bpf_put_file) with the same KF_ACQUIRE|KF_RELEASE semantics. These
> > follow the same pattern and are also LSM-only.
>
> You can safely clone and retain file references.  You can't do that
> to dentries unless you are guaranteed an active reference to superblock
> to stay around for as long as you are retaining those.  Note that
> LSM hooks might be called with ->s_umount held by caller, so the locking
> environment for superblocks depends upon the hook in question.

Yeah good point about ->s_umount, why don't we just create a new "safe
dentry hooks" BTF ID set and restrict this to those and filter in
bpf_fs_kfuncs_filter, where there's existing filtering going on
anyway?

