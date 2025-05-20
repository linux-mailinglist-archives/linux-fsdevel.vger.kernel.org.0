Return-Path: <linux-fsdevel+bounces-49515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D357ABDD50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 16:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E4F3BBFFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 May 2025 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6C24501D;
	Tue, 20 May 2025 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QR/8TPl/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA53024290D;
	Tue, 20 May 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747751610; cv=none; b=hkNr5jkwovdIyyEwvgBMUxYHF95/urVi87vjl7xlrBNQrpDO9vbDDOcvCA5ZPYvWom3fKH25BJMxt5ZowkST9rogd4kevshGIwgFjSCRm8EGsDg9RihNELRZA5+dmj+s1TbBgyuCM0FrjW6aVbr/e2ssZt/POokAtJibgchyysY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747751610; c=relaxed/simple;
	bh=8iI1J3ZgarD0harWDKfKAmvjN5IOTKu+McZtK6H2ccM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WvVUZxZpvyxldReWpTKKxtEcXEh9KYtAtEh/J/bKbMnWchbRbFgMEzbuA3938rFvLBnpee2S7EvnARyE36lPCEEk8sKkDpLl2HC+5LaAudJBT/QJofFkMlyjzBU/TXrWn1AieFTc/5N7Zay4q3PvYPOt+Q3AePFhQ8W8Eegt1RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QR/8TPl/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad5297704aaso886680066b.2;
        Tue, 20 May 2025 07:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747751606; x=1748356406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skqxCutqMBERu++ynJRArdD2cHdMY8od/873evDrCUA=;
        b=QR/8TPl/nfxC2q7gLMJQVzNIU/3b/KYDxfwntZQNNKnxAQ/t+wOExkEjTAy9ab0b9c
         NaBJFD6tnGaZQ+1XRmOK+LHuFROBU5PgkUZn5XsGNYdw84SpMea7VIjRPRK9GUbROlPf
         6yTZZBVL7HjhiM5IoaNBDg3ytd6onkOisiumOo31zalTgZeUU5a4m6JaeY+gwenxgq1p
         UuSruRfI099JqbZtNC1KbxGfc3Ni9OQXVQ6Wo6D836y2YJoAyumNXTBNPzN2llF8ngTQ
         7+xsbSbgjT/0rR6jTn74DNiIpMtGfNcJdP9dtvyXuHPfgdQ59cqXDQ5K2k1D31QzMK3V
         kY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747751606; x=1748356406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skqxCutqMBERu++ynJRArdD2cHdMY8od/873evDrCUA=;
        b=JPzStZtxsiOIjVHEVrx8XwzDbAYTPmS0G4TiL6XhQsy8NvyfMWVwkjISHRUxVn3Tmx
         0Q0pxx1Osr0GMJCpwT59hm/wUB7IpptqbTLYHTaKJhvX6rWbnq7I8XlkUBMwSpDM1aYG
         ghrVk1iJ9QCB0ssVf9uRw+SvkDc98tMOJPDswtPjLT9ZlN7YFYXsKTFntgOWmXstEcN+
         LaNEQeR77IATe8BqnXJaRe0pHPfTHNuHUL+8o7PKjBAih64R1+u49yRBaQEu8W9f9whi
         CnHSxBwH7o7x6A4yep3v+tOD1y2YTRn/+ILPQG38Spxi4kfVNt5rs58UVdAiMWuSNH4F
         3TtA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ8tc+99EVDc71A6LuPq8FCN/kVzJ2GaREHhJk27VHSH5D3Rf1fjrIan1l069H+c3nUVKBO+IWT3+Fn1WNGw==@vger.kernel.org, AJvYcCWhd5Ynws32flV5K405aMJE1BLytUGModhVVSoR5XGcq+v8a8lUTU58IrQ9iEWZcAvb0/C08432YY/St+z8@vger.kernel.org, AJvYcCXZTSF3M2rbCchKNX3OFXWCdJgH1NGDnpl/70OpcDGyeA8s18CF537e2NlkLPqxY/q2pz6TkUM7OHXlA6R+cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9F/L1N/d1STSHlUvJ6YBQtDB4df8NmFMyqTbk39ntIRKnyq8
	BuTxhiFiYh3babhFXm3ACw+Bc6CCe18HlCGWHYw2uu9Yf7xliSlSxb4ltGUdXm78TQ4aRwu4E4w
	Tdr8OFqAb09WbNLUMKn1e1jdPWLnQ1zs=
X-Gm-Gg: ASbGncuCkjclF+rHnj3Ro2m52nTwe9hmPkYoYvZMO2FxJ1UXqyhk1atVEcoTWwzFsnH
	qoK7y1YfvgRHSekxP0av08odhoJ/7uhfspxB/qazSJGC16g/A4e5Tf+Hra32a6nTyprUKQMMdQv
	2oJZhUMZa3F7iA6CtWGMjaV2UMkPTJQ9mk
X-Google-Smtp-Source: AGHT+IHVFDQUfDhzVWuHavHmyfFDUVSBk1mCtqjdNFD8Tbgzcf7WpV5Da2Wh680mw44GTQ30JSks6nR4ZUQKlhECUVg=
X-Received: by 2002:a17:906:3acf:b0:ad5:3055:a025 with SMTP id
 a640c23a62f3a-ad53055f958mr1159631066b.6.1747751605751; Tue, 20 May 2025
 07:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520051600.1903319-1-kent.overstreet@linux.dev>
 <CAOQ4uxg8p2Kg0BKrU4NSUzLVVLWcW=vLaw4kJkVR1Q-LyRbRXA@mail.gmail.com>
 <osbsqlzkc4zttz4gxa25exm5bhqog3tpyirsezcbcdesaucd7g@4sltqny4ybnz>
 <CAOQ4uxjUC=1MinjDCOfY5t89N3ga6msLmpVXL1p23qdQax6fSg@mail.gmail.com>
 <gdvg6zswvq4zjzo6vntggoacrgxxh33zmejo72yusp7aqkqzic@kaibexik7lvh>
 <CAOQ4uxg9sKC_8PLARkN6aB3E_U62_S3kfnBuRbAvho9BNzGAsQ@mail.gmail.com> <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
In-Reply-To: <rkbkjp7xvefmtutkwtltyd6xch2pbw47x5czx6ctldemus2bvj@2ukfdmtfjjbw>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 May 2025 16:33:14 +0200
X-Gm-Features: AX0GCFs3uIGlKS2e_SbTljkNn7JB3BFRnIpoJrABp_l8XO6h5grs8_mb9jdwHio
Message-ID: <CAOQ4uxgOM83u1SOd4zxpDmWFsGvrgqErKRwea=85_drpF6WESA@mail.gmail.com>
Subject: Re: [PATCH 0/6] overlayfs + casefolding
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 20, 2025 at 4:12=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Tue, May 20, 2025 at 04:03:27PM +0200, Amir Goldstein wrote:
> > On Tue, May 20, 2025 at 2:43=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > >
> > > On Tue, May 20, 2025 at 02:40:07PM +0200, Amir Goldstein wrote:
> > > > On Tue, May 20, 2025 at 2:25=E2=80=AFPM Kent Overstreet
> > > > <kent.overstreet@linux.dev> wrote:
> > > > >
> > > > > On Tue, May 20, 2025 at 10:05:14AM +0200, Amir Goldstein wrote:
> > > > > > On Tue, May 20, 2025 at 7:16=E2=80=AFAM Kent Overstreet
> > > > > > <kent.overstreet@linux.dev> wrote:
> > > > > > >
> > > > > > > This series allows overlayfs and casefolding to safely be use=
d on the
> > > > > > > same filesystem by providing exclusion to ensure that overlay=
fs never
> > > > > > > has to deal with casefolded directories.
> > > > > > >
> > > > > > > Currently, overlayfs can't be used _at all_ if a filesystem e=
ven
> > > > > > > supports casefolding, which is really nasty for users.
> > > > > > >
> > > > > > > Components:
> > > > > > >
> > > > > > > - filesystem has to track, for each directory, "does any _des=
cendent_
> > > > > > >   have casefolding enabled"
> > > > > > >
> > > > > > > - new inode flag to pass this to VFS layer
> > > > > > >
> > > > > > > - new dcache methods for providing refs for overlayfs, and fi=
lesystem
> > > > > > >   methods for safely clearing this flag
> > > > > > >
> > > > > > > - new superblock flag for indicating to overlayfs & dcache "f=
ilesystem
> > > > > > >   supports casefolding, it's safe to use provided new dcache =
methods are
> > > > > > >   used"
> > > > > > >
> > > > > >
> > > > > > I don't think that this is really needed.
> > > > > >
> > > > > > Too bad you did not ask before going through the trouble of thi=
s implementation.
> > > > > >
> > > > > > I think it is enough for overlayfs to know the THIS directory h=
as no
> > > > > > casefolding.
> > > > >
> > > > > overlayfs works on trees, not directories...
> > > >
> > > > I know how overlayfs works...
> > > >
> > > > I've explained why I don't think that sanitizing the entire tree is=
 needed
> > > > for creating overlayfs over a filesystem that may enable casefoldin=
g
> > > > on some of its directories.
> > >
> > > So, you want to move error checking from mount time, where we _just_
> > > did a massive API rework so that we can return errors in a way that
> > > users will actually see them - to open/lookup, where all we have are =
a
> > > small fixed set of error codes?
> >
> > That's one way of putting it.
> >
> > Please explain the use case.
> >
> > When is overlayfs created over a subtree that is only partially case fo=
lded?
> > Is that really so common that a mount time error justifies all the vfs
> > infrastructure involved?
>
> Amir, you've got two widely used filesystem features that conflict and
> can't be used on the same filesystem.
>
> That's _broken_.

Correct.

I am saying that IMO a smaller impact (and less user friendly) fix is more
appropriate way to deal with this problem.

>
> Users hate partitioning just for separate /boot and /home, having to
> partition for different applications is horrible. And since overlay fs
> is used under the hood by docker, and casefolding is used under the hood
> for running Windows applications, this isn't something people can
> predict in advance.

Right, I am not expecting users to partition by application,
but my question was this:

When is overlayfs created over a subtree that is only partially case-folded=
?

Obviously, docker would create overlayfs on parts of the fs
and smbd/cygwin could create a case folder subtree on another
part of the fs.
I just don't see a common use case when these sections overlap.

Perhaps I am wrong (please present real world use cases),
but my claim is that this case is not common enough and therefore,
a suboptimal EIO error from lookup is good enough to prevert crossing
over into the case folded zone by mistake, just as EIO on lookup is
enough to deal with the unsupported use case of modifying
overlayfs underlying layers with overlay is mounted.

BTW, it is not enough to claim that there is no case folding for the
entire subtree to allow the mount.
For overlayfs to allow d_hash()/d_compare() fs must claim that
these implementations are the default implementation in all subtree
or at least that all layers share the same implementation.

Thanks,
Amir.

