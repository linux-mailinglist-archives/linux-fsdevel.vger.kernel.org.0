Return-Path: <linux-fsdevel+bounces-48515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F9CAB04E2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBFC1B66096
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C941F9A89;
	Thu,  8 May 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aeZzYuqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EB78F34
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737207; cv=none; b=R5JHkg5BxgJQmoojTIf/mtZ+kPzHjRomrfLIpDJLVqtpOZ0I5iy2IX40n0e3rqotNnlx7QN39iGe8YfAa7ikCzLsgZ+FrIzwbipwrrbPGU3/H81Wb7A8oXs1yROOA01ItgXBixiJVbIk/Hn4XILGLBxpiWDEpM7KYU55P29n9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737207; c=relaxed/simple;
	bh=mZg3A4ogx+Cu463bf8RVpgQC+gBQEOdP5OUhAgzF3qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjUTdnmURc9S83zP0/5m+pIYRt/BomdpFwoaxZqFsUa96nNwVmFzdt9IF2wh1PlXwymYFPvYlkAeN+WwP3ekXu1aMI0mo6rvhm4ZZiwGk0vG3JfM5RbKg2NOO1Gl4MIZc6qWpDxS4+4xDGIFhFffL2mYUghup+WAhbz0ZsWsfzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aeZzYuqC; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2ab99e16eso285504866b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 May 2025 13:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746737204; x=1747342004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZg3A4ogx+Cu463bf8RVpgQC+gBQEOdP5OUhAgzF3qg=;
        b=aeZzYuqCQ4IUhdJLBGzBHnKVSY3yjqfSccCRh6W20i+lOmALBzjWxODLmbgYD+54Xm
         wuQ3IWkM0JsfS0EI6p/EsYHE5/NrvTZjYwJ1PXWTXPyAOXCj6H4nJMH+8fQW7aBwbwJ1
         b2dsJLhNmyZwUaDMfiKZlZGBvn4F36gvFk47KUEUrmFNHlOZtxY45VBXAUQdoFXZPZRX
         N+vlRF+qFbSUujt+1Sz79gxEb4nEYG5W+VC32HOsNAN5+NelcEW2p/6JMNa3KPyyioc/
         dkCZJGQDVOlW2VgUSZCslzzg48eoSJApWVrLL4iMtWJN4ovCKR55pvPzlbQuCdDiw0uE
         nIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746737204; x=1747342004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZg3A4ogx+Cu463bf8RVpgQC+gBQEOdP5OUhAgzF3qg=;
        b=jXi7rW+Dbm0teVIsfe6+nVXXcMtjyAPHcT02O+jVVI335XEKlaEMQ4E6TLY2q8z1Ro
         OsyoJ7tN1qHhoLhuAu3HJTtuqhS2XhyftpYsRKM/ZzdFh3z6L0qYQiWQo6Ac9DTPL2eS
         buWZ9UlrQHrwowW84zGocYxtL67Q/zrpxs4zyB8YJFH5NCfuvrX/IhBm52AkAIYQzN66
         05QAYWViCFfzOx9D+85D28up87FsMGt79rSu+n19dBxSPyEuItfcgPIj4D5WD2aY2uLy
         gYZ+Q6DEt4vjezIplGpQwBcAWVq8yAPebzzXSjo3BrCuJo/8wk7dZhxCZBJvpRODgSUE
         bqhw==
X-Forwarded-Encrypted: i=1; AJvYcCVbzUOMFvzrq2Gjlaq1npISUc93ZEB2Ar6tRTBfuN+47BSpiCQFCCawog+YtXX+GzvSyBc9mmhhF7mLZ7jf@vger.kernel.org
X-Gm-Message-State: AOJu0YzRArhurteCBDmlH4dP4akVBue4SU9HFAtnNrK+bo701FWuok2E
	5GulfVV9lfVM6GjRYXsl4KGYdPttrOb3j9a3chn9AwZrVbI1yG4GuDjPUuXia4DRY8cbip0QAxJ
	CPEBXUQxXR56fvpZRCNJdgYBZ3TFxl7rYji0T1w==
X-Gm-Gg: ASbGncv+rhQyd8oQwND2RmVGm0nWfKbYYHZEThJxfbwMCmb6h0Pfs1/+xozV2MqhenM
	c0FScN7vsPuEYkuf4DOgI/PeTnNLGxYqa5BJ5lKL7ZGv0/+LSmBPsuvXFYSAbCHQCs4CAFkNT77
	F8T+vdBqTb2N3vhfIlQSf6hw==
X-Google-Smtp-Source: AGHT+IHpeuPOuNJMavA47nUtb0VN0TQvWikiAY9vOx8G1IlbkcTgiPioS1J/T3QqXyCYIl9d5vdwpcy0yBoZad0Kb+I=
X-Received: by 2002:a17:907:6d20:b0:acf:4c4b:f8e1 with SMTP id
 a640c23a62f3a-ad218e940famr118182866b.7.1746737203678; Thu, 08 May 2025
 13:46:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250419100657.2654744-1-amir73il@gmail.com> <CAOQ4uxj1-8uFp1ShzcC5YXOXfvOrEMLCcB=i1Dr4LaCax03HDQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxj1-8uFp1ShzcC5YXOXfvOrEMLCcB=i1Dr4LaCax03HDQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 8 May 2025 22:46:31 +0200
X-Gm-Features: ATxdqUF_jbFORqKYARjGEMZlYLISidH92CoKJLAzP_8CoFpRWhH_IBo--D-_REE
Message-ID: <CAOQ4uxi+pxS74QCLi5H8f0rj8A_1-kRxVs6qf_-C_0rwS66wfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] User namespace aware fanotify
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2025 at 1:48=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Sat, Apr 19, 2025 at 12:07=E2=80=AFPM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> >
> > Jan,
> >
> > This v2 is following a two years leap from the RFC path [1].
> > the code is based on the mntns fix patches I posted and is available
> > on my github [2].
> >
> > Since then, Christian added support for open_by_handle_at(2)
> > to admin inside userns, which makes watching FS_USERNS_MOUNT
> > sb more useful.
> >
> > And this should also be useful for Miklos' mntns mount tree watch
> > inside userns.
> >
> > Tested sb/mount watches inside userns manually with fsnotifywatch -S
> > and -M with some changes to inotify-tools [3].
> >
> > Ran mount-notify test manually inside userns and saw that it works
> > after this change.
> >
> > I was going to write a variant of mount-notify selftest that clones
> > also a userns, but did not get to it.
> >
> > Christian, Miklos,
> >
> > If you guys have interest and time in this work, it would be nice if
> > you can help with this test variant or give me some pointers.
> >
> > I can work on the test and address review comments when I get back from
> > vacation around rc5 time, but wanted to get this out soon for review.
> >
>
> FWIW, this is my failed attempt to copy what statmount_test_ns does
> to mount-notify_test_ns:
>
> https://github.com/amir73il/linux/commits/fanotify_selftests/
>

Hi Jan,

This selftests branch is now updated.
The test is working as expected and verifies the changes in this patch set.

Would you consider queuing the fanotify patches for v6.6?

We need to collaborate the merge of the selftests with Christian
because my selftests branch has some cleanups with a minor
conflict with Christian's vfs/vfs-6.16.mount branch.

Maybe you will carry only the fanotify patches to v6.6 and
Christian will carry the tests in a separate branch?
because the fanotify patches and the tests do not actually depend
on each other to build, only for the test to pass.

Thanks,
Amir.

