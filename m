Return-Path: <linux-fsdevel+bounces-39299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878CA125E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852FA1880500
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4A87C6E6;
	Wed, 15 Jan 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ge3vhiaT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6E24A7D0
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 14:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736950928; cv=none; b=noDNK5/7JSXwZivfu1c/46qR2VRMpw4FTnduuvQFiNuBWdPS3xat5hlyEYbJ1PqtAqEhmgcai2dXGjZZhQDVoYfvcoSTiGe/FyUOsYEcjCCbEc4cWXFPDsUIXd4GXQ+IlapF84r2G/Vy0ARs1dfA8lWNsA6HSOzTH0ovxOWePHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736950928; c=relaxed/simple;
	bh=ZpNCaGxLUFXdw93+hpnk6scIhRKltwNHo+b61K1Jcdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QENAFKQ3UUN7Hty1XXnqhc1k0RzixpilZpXUr4wo43PGwPsmKhTjpfUPVVd7oihOcKavpNSI+I0pfUTVFOquogAtiHIOGgNw60+nYJFCkzze46kc1BYJCbGetXST+21lrtE9TGt7sFTLLpeFAA5asgZ0mPMwV+ct7LCZNiMLmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ge3vhiaT; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso618465966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 06:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736950925; x=1737555725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZpNCaGxLUFXdw93+hpnk6scIhRKltwNHo+b61K1Jcdw=;
        b=ge3vhiaTT+GHUNY9wfKp401tv9LgZus1P/eCc95fYnVkig5Lo4TpmQQrRc9tA7863L
         tv/npCY9DtqMtoFjIsvr9/8ba8T3d0pD9uxietTtpKecJQEouRmz8t1n3XKjsUQCurvY
         OaYT82agPCVzUn0mFecrUynTde4HWUgJQRfgjiokZv1xE56QI+tbmpCTnL/+RmvL5GE+
         pLtAQxaRT7RNrgPml1ELwvVH/w29Q7AoVik3KnJyLftHXRk2zqs0E3UxI1q6DHoMXy77
         AyBWFDcp8gfYQnNPmAp/f+9bAunmn83HdoRZlpvR40lX/Tmz1Lo+wsR/ie3o145KdO5v
         ypeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736950925; x=1737555725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZpNCaGxLUFXdw93+hpnk6scIhRKltwNHo+b61K1Jcdw=;
        b=nFkpuXujYYwPrXKi1LTMzCnFZc+EIzZmAwgNBYUfVp/Ce4iCStNk1EV/94J/Z8E2zl
         mP77Hr6S6aJ//aBiZ4hATFRhAAgLwiZZ3UxybWNoxtcDAlVZywt77CIjqHlZtKeTN+kq
         GwfzPvFEuv1xBssf1z1BQh8orpIOp4keI/Bb3gGdnOtknbaFFk2JtOFrvgGE8Rtqfxtp
         EoY7F5yBgXRCtVdqAa9X0U1zW9YMzwBi2Oc9BvBHLTWV8CkpNJClGDJ6G97nEN+1OwCE
         RorrqyWaBGSTZ357oxIBG1MgIU892bcYdOxgf0IZ8xmaMF3sSFhBvmCN7XZOcoiaQq5o
         PqYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu0vBE6N1DNwbdNPyYOf+7QIRrXLDwfDQkwSOXYgu4eQvP0A+8ewGx7rnbQGqdDdwPocBmLGxTYS6bFr3c@vger.kernel.org
X-Gm-Message-State: AOJu0YzATJs0S+HeDnHxSsuBPwXtLqRmwgbJKgiZlkj092MZYlpFlwoY
	/HlSA2GDVy56aG0K0PxpFlfzagTMv3QC1zoVeB7eLet6AUCE079+d1rDDrg1EBsN+Oi+poi5ehy
	e8ZYYzE7OXSZvGVL5rqIbhcwAtd8=
X-Gm-Gg: ASbGncu2BSXoYIDVqFt4nSQePzkaDqHxsWQ3Veshhfbj5gEVb50JGfTY3DpMdm5BjUd
	PAW+c1MuC+yy8ARFIHB3VTa2ey4RGFBggS/2dRg==
X-Google-Smtp-Source: AGHT+IGLJ7ogFsKvkeEut7+IPf2Nvn/0WbXgOqesdp3s7FRRqdDRryVXxhP3JbWwPE+O4c2IxEyTfuY/uH590XIRMhw=
X-Received: by 2002:a17:907:3f95:b0:aae:b259:ef6a with SMTP id
 a640c23a62f3a-ab2aad3a453mr2845127566b.0.1736950924154; Wed, 15 Jan 2025
 06:22:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
 <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com> <CANT5p=rxOnq_jtnOpMTKA+ycKYzkJyjESbAkE5zj20h4XtE0Ew@mail.gmail.com>
In-Reply-To: <CANT5p=rxOnq_jtnOpMTKA+ycKYzkJyjESbAkE5zj20h4XtE0Ew@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Jan 2025 15:21:52 +0100
X-Gm-Features: AbW1kvaUCHcOHyshncYTFWiOBUhFR2gWq_OQcImpg-Lrap4n5gI-Z1Qaoz55BkE
Message-ID: <CAOQ4uxhBWV3DfqaE=reuPjh8w92wwujA6Abj=Gt0YvapR4m_1g@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 12:27=E2=80=AFPM Shyam Prasad N <nspmangalore@gmail=
.com> wrote:
>
> On Tue, Jan 14, 2025 at 6:55=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Jan 14, 2025 at 4:38=E2=80=AFAM Shyam Prasad N <nspmangalore@gm=
ail.com> wrote:
> > >
> > > The Linux kernel does buffered reads and writes using the page cache
> > > layer, where the filesystem reads and writes are offloaded to the
> > > VM/MM layer. The VM layer does a predictive readahead of data by
> > > optionally asking the filesystem to read more data asynchronously tha=
n
> > > what was requested.
> > >
> > > The VFS layer maintains a dentry cache which gets populated during
> > > access of dentries (either during readdir/getdents or during lookup).
> > > This dentries within a directory actually forms the address space for
> > > the directory, which is read sequentially during getdents. For networ=
k
> > > filesystems, the dentries are also looked up during revalidate.
> > >
> > > During sequential getdents, it makes sense to perform a readahead
> > > similar to file reads. Even for revalidations and dentry lookups,
> > > there can be some heuristics that can be maintained to know if the
> > > lookups within the directory are sequential in nature. With this, the
> > > dentry cache can be pre-populated for a directory, even before the
> > > dentries are accessed, thereby boosting the performance. This could
> > > give even more benefits for network filesystems by avoiding costly
> > > round trips to the server.
> > >
> >
> > I believe you are referring to READDIRPLUS, which is quite common
> > for network protocols and also supported by FUSE.
> This discussion is not completely about readdirplus, but definitely is
> a part of it.
> I'm suggesting doing the next set of readdir() calls in advance, so
> that the data needed to serve those are already in the cache.
> I'm also suggesting artificially doing a readdir to avoid sequential
> revalidation of each dentry; or a readdirplus to avoid stat of each
> inode corresponding to these dentries

Well, if readdirplus is implemented, then "readaheadplus" could be
implemented by async io_uring readdirplus commands. Right?
io_uring command would have to know to chain the following
readdirplus commands with the offset returned from the previous
readdirplus response, but that should be doable I think?

> >
> > Unlike network protocols, FUSE decides by server configuration and
> > heuristics whether to "fuse_use_readdirplus" - specifically in readdirp=
lus_auto
> > mode, FUSE starts with readdirplus, but if nothing calls lookup on the
> > directory inode by the time the next getdents call, it stops with readd=
irplus.
> >
> > I personally ran into the problem that I would like to control from the
> > application, which knows if it is doing "ls" or "ls -l" whether a speci=
fic
> > getdents() will use FUSE readdirplus or not, because in some situations
> > where "ls -l" is not needed that can avoid a lot of unneeded IO.
> >
> > I do not know if implementing readdirplus (i.e. populate inode and dent=
ry)
> > makes sense for disk filesystems, but if we do it in VFS level, there h=
as to
> > be at an API to control or at least opt-out of readdirplus, like with r=
eadahead.
> That would be a great knob to have for network filesystems. We have to
> rely on heuristics today to predict which of these patterns the
> workload is using.
>

It seems like the demand existed for a long time.
Man page for posix_fadvise(2) says:
"Programs can use posix_fadvise() to announce an intention to access file d=
ata
 in a specific pattern in the future, thus allowing the kernel to
perform appropriate
 optimizations."

I do not read this as limiting to non-directory files, and indeed fadvise()=
 can
be called on directories, but others could argue that this is an API abuse.

Mind sending a patch for POSIX_FADV_{NO,}READDIRPLUS?
make sure it fails with -ENOTDIR on non-dir and be ready to face the
inevitable bikeshedding ;)

Thanks,
Amir.

