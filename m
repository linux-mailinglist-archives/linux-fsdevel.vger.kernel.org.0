Return-Path: <linux-fsdevel+bounces-10374-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 487C284A944
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 23:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD37E1F293D0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 22:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E661AB7EF;
	Mon,  5 Feb 2024 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="exyIA6j2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1711DA2E
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707171869; cv=none; b=XMOqKmDqlKPmFAlYd8CSZaN4MFymmMdmMnYo1bnfOQmA03uDXyF878WiPso7k5HBVe6UIjnL+nTJrUwkLwV1kjvx2C8KIEjc37WREUFbJdfStOM7Lcr+hVrSvgdraOin0EJEwBXSzmCF3+7oZbWWAKfBk+hcxCGrlBCtlwsvuV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707171869; c=relaxed/simple;
	bh=ZrnXtFKNo7DqcRc5LJERAqUuIv19bdc/Qa6WrZVBydw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=YJaou5/7N1FVnkXzrxSEhmyFyDe5VAIY8lWiSWdnspItkJlF8jyMRFnFZFCrTC3FyILgYHd1ETDRblyFhA+Yle1ysnjClb2zA2SuOW2gNfih81atFx7lzWENWFqg4iKFWbpB9I3H2PIUr0WhsK7k1+VeerXGHcczii5U5oyoJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=exyIA6j2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33b436dbdcfso475347f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Feb 2024 14:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707171865; x=1707776665; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PU8nezW/KDwZaT+7b+MCWSrRoGQq7aEXwFDNWTCaMDQ=;
        b=exyIA6j2Bo2Bv5IPQyvmVV92nexBJobNwZGW50NQv6h9owpsscoav8Do6mRI6EvKFR
         ZdLEO5vB3rO4TpMUEBZVyNZjam02LZIqXw8Pr9hfjr/m8/oIdXzR1VSyeqq2f0ZhfhBI
         V5XlkN1ugclwbJAuvKTD46XSBYotWL1mFuZCWTFADXxJeaEHQBcKSoSPitdYrifuctjP
         tKsTF2rIaZN+oa2Zs1rCPGG7tPbzhmGlhuc7CO7znOuFV/QdWsSLFo2Nfb+A6hRydIFk
         MsTgSn0rIJH0aGY/ziHk8RO2zusPylL7nOO6FEtt9o9UVGReFqlGvoSX78eQ6KFsJDeC
         Gibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707171865; x=1707776665;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PU8nezW/KDwZaT+7b+MCWSrRoGQq7aEXwFDNWTCaMDQ=;
        b=Jw/6QErQJblH7gzPzn9W/eotU3Bj4SEHIheHxBaeR5ppSLhPV3CluipjkqHlHe7d3L
         HwGHt3zxuy5zARuprFWHiRP9CJwfoRgpPeo2TtfpgIA5P6XZKHbX2g6v08Q5x3E6/IgY
         adLWXDh+6vjPQdVyrdgKBFfvLEvu7O+kFckRrobSep9To8R8BfnJ2xk3BiyiJnVRadX5
         jfIyIBxOIqQXuEiI1+uR3mUyuxVn0Xwta95HqL6HcHTIBV2/DnqFiRUBb7wcCvQ7hvGU
         DLQti1bQBgxjeUst0K+DS/mbrBzkBbwPt7dCLo+yr1xE4zhP/dIX6E6j0oezOrYhVtpk
         l64g==
X-Gm-Message-State: AOJu0YyETgbJg+M6QwAxcLpmp+c+z87BEhiWvbGwxSZ8xtb0WSqP85J/
	zgPUX4uZjhnOzJ/tiQumlI8H401vSoboYjdiz1YytnbD/ulHpZYGEP2GzWGUS3Ab9OCra4WFMtr
	eSm/pPnFEAKN6hbz+zimZJ7nlCgXu+jnPsPDj
X-Google-Smtp-Source: AGHT+IHmPQVc505MdGAGxqA5acadtkePUJKzVkLTjW5NfvEQ1pquN8eiiEGYTM+kG5NzjrE0qjzqF+bieBlOlA2t0t0=
X-Received: by 2002:a5d:4d06:0:b0:33b:4020:8710 with SMTP id
 z6-20020a5d4d06000000b0033b40208710mr186536wrt.61.1707171865396; Mon, 05 Feb
 2024 14:24:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com> <20240129203626.uq5tdic4z5qua5qy@revolver>
 <CAJuCfpFS=h8h1Tgn55Hv+cr9bUFFoUvejiFQsHGN5yT7utpDMg@mail.gmail.com>
 <CA+EESO5r+b7QPYM5po--rxQBa9EPi4x1EZ96rEzso288dbpuow@mail.gmail.com>
 <20240130025803.2go3xekza5qubxgz@revolver> <CA+EESO4+ExV-2oo0rFNpw0sL+_tWZ_MH_rUh-wvssN0y_hr+LA@mail.gmail.com>
 <20240131214104.rgw3x5vuap43xubi@revolver> <CAJuCfpFB6Udm0pkTwJCOtvrn9+=g05oFgL-dUnEkEO0cGmyvOw@mail.gmail.com>
 <CA+EESO7ri47BaecbesP8dZCjeAk60+=Fcdc8xc5mbeA4UrYmqQ@mail.gmail.com> <20240205220022.a4qy7xlv6jpcsnh7@revolver>
In-Reply-To: <20240205220022.a4qy7xlv6jpcsnh7@revolver>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Mon, 5 Feb 2024 14:24:13 -0800
Message-ID: <CA+EESO6iXDAkH0hRcJf70aqASKG1eHWq2rJvLHafCtx-1pGAhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd operations
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com, rppt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 2:00=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Lokesh Gidra <lokeshgidra@google.com> [240205 16:55]:
> ...
>
> > > > > We can take care of anon_vma as well here right? I can take a boo=
l
> > > > > parameter ('prepare_anon' or something) and then:
> > > > >
> > > > >            if (vma) {
> > > > >                     if (prepare_anon && vma_is_anonymous(vma)) &&
> > > > > !anon_vma_prepare(vma)) {
> > > > >                                       vma =3D ERR_PTR(-ENOMEM);
> > > > >                                       goto out_unlock;
> > > > >                    }
> > > > > >                 vma_aquire_read_lock(vma);
> > > > >            }
> > > > > out_unlock:
> > > > > >         mmap_read_unlock(mm);
> > > > > >         return vma;
> > > > > > }
> > > >
> > > > Do you need this?  I didn't think this was happening in the code as
> > > > written?  If you need it I would suggest making it happen always an=
d
> > > > ditch the flag until a user needs this variant, but document what's
> > > > going on in here or even have a better name.
> > >
> > > I think yes, you do need this. I can see calls to anon_vma_prepare()
> > > under mmap_read_lock() protection in both mfill_atomic_hugetlb() and
> > > in mfill_atomic(). This means, just like in the pagefault path, we
> > > modify vma->anon_vma under mmap_read_lock protection which guarantees
> > > that adjacent VMAs won't change. This is important because
> > > __anon_vma_prepare() uses find_mergeable_anon_vma() that needs the
> > > neighboring VMAs to be stable. Per-VMA lock guarantees stability of
> > > the VMA we locked but not of its neighbors, therefore holding per-VMA
> > > lock while calling anon_vma_prepare() is not enough. The solution
> > > Lokesh suggests would call anon_vma_prepare() under mmap_read_lock an=
d
> > > therefore would avoid the issue.
> > >
>
> ...
>
> > anon_vma_prepare() is also called in validate_move_areas() via move_pag=
es().
>
> Probably worth doing it unconditionally and have a comment as to why it
> is necessary.
>
The src_vma (in case of move_pages()) doesn't need to have it.

The only reason I'm not inclined to make it unconditional is what if
some future user of lock_vma() doesn't need it for their purpose? Why
allocate anon_vma in that case.

> Does this avoid your locking workaround?

Not sure which workaround you are referring to. I am almost done
implementing your suggestion. Very soon will share the next version of
the patch-set.
>
> Thanks,
> Liam

