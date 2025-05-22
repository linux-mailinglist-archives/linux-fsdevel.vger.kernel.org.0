Return-Path: <linux-fsdevel+bounces-49685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F2CAC1038
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597111BC51F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 15:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FE299A8A;
	Thu, 22 May 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR4I8zlA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22592F41;
	Thu, 22 May 2025 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747928770; cv=none; b=h1s/d4cMo10h4ZxGZC5egXPR5T/f6SnrG8DLm1WJc1CwTwgI6iIgtDnRe+U2maM07lUJn7lx7Dg4+tVD+cka2uUCDb54T4bscpT8wSQGdSwx42g1T2kfryt4vACW0E1BW7fbIumFvolYjE+XTEdwwnnm9gI+FI1GTPGm+7twUik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747928770; c=relaxed/simple;
	bh=HHFfb8zt1W7b7687wsmntPJNHJRczR0BfGUhfr1rO0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5l5rjrabkk8z5yXrJTKr7AG1p70YI9S+Rexp2jb5GH7E66lIWy0S5cPloAEnzRcVjo10+9yCEY4LAhYFr6W6Dp/Xj5dX/EXJ2N9hWKZ5hhiH3CEIGVF+HaGe+aLMGMWIEvgs/+XnGjnxe1k0ToHXITRch2q8MQjmG1cCyxuLyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nR4I8zlA; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso8242936a12.1;
        Thu, 22 May 2025 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747928766; x=1748533566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgiMoj0zBLI77kFJsTbxWoQIzqomQqgDgEkdUW1inN8=;
        b=nR4I8zlATON7G7djPMbVEPEP2Tv+1guLLF3GoEjemHndALHVllUFNzwA9TPCBZ/8O4
         Zlv5dgs1fTb3L0kRtpHvtZaaAbNX7ZQBnltDHCKoZsg89Dc64GgKkbUlyz7s0sBdfwJe
         I/dP4b2Nh0I05f8FBVvToCkkmD5/YuwyXJBes4MNqTd74QHzVVhhllOy+VVrAUdOENEG
         nCEd10Q+AEuBBv2jH+k2ZWC83L4aAFXR/rTlM1vp6gK2PU3AEHik2tP9mKXhOupLjarH
         TmLIv1OCkX/ngurevIf0OqSBA9lU5XvEXSWzoPOcSLCewnDFaNdqc7v4I+31iJRxvW1B
         oCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747928766; x=1748533566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgiMoj0zBLI77kFJsTbxWoQIzqomQqgDgEkdUW1inN8=;
        b=qQYEAoV/OLnV1Q29URM8MBT11F2OGzDXXuHEok8ygI3Jx9CBCcPoZlcs+F3ghrXCBh
         +pBgMjgXZiSCpbnhM+1t4utiDfWuQINiEjmqMRMlvH09nomQhc1tCvUgE3qbBwiZ9ik7
         GKV1Hg8jkwr14kYSEfmLotJj0RSV6jNlomz0bGywgj68PefnkReXjaxQtg1bKgTMwKmi
         X4Rm4mcJx9RAGgtNfL6uNUa3xVcY6mQ+5fikh50ggqX5ToUXWc2C2KxM7jVmqJlKZiJO
         O7laah7/yBj7e57qn05efe5l/PNUW7emIUY7sgEBGvtbAgAdJfZZo9lMZnc4t97nfGKN
         oSmw==
X-Forwarded-Encrypted: i=1; AJvYcCUuvMxQdPZ6jFhUT85Gy2TPzt3K970u7AlFsj94/bxX/ja7qM7CtbtKKJPVO4xZYYUgvFChxLCfPxSr0hivyA==@vger.kernel.org, AJvYcCV5F6JgKpuL0u30nsqcKXfMs6VQGmLGvIRDw8DnL5MTH+T25GiNXZOePPs3LF3GC7/HFekcPk/t5ctWUVpR@vger.kernel.org, AJvYcCWN3UVwRTNsFbRjyZQnoxnTggGuKsNUlBccIvTVFG0nocglS5Ke5EnEBfykeQKZnSvbG+5pSo5qb44=@vger.kernel.org, AJvYcCWpwV0t6VRY162+EkI9JKBW5PiaZcb4wpMp6Ia0dOPjitjOxJbZIMMAMtHOuofW9hKBjltawU4cw6+o@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3clqHUj/H/GkaUYDKuJuWkyoVhIIx9KWMY7/rEdQNHxLWSlx
	RmDs4s2VheXr87AMd2fJEIxoViJDnN4z65mUgAIWvrSUy+9r0lqnB0y+TLuG8Q/tbTcb4XPrlLU
	jWzHR2pdRmjlDI/3+jgBepUFGEPKDDb8=
X-Gm-Gg: ASbGncux20VyprPbNovNl6lRnS1wqx3SNP/yWluISrr0KcfIvL7LlOyNDPX1aferlO1
	P+x6tp6f6vFTykay5N13AXaG+cDNGa2cl4Z+r+TY+zIs4yAe7TnltgSLghS0vWoSuQnmTjg1cna
	zyBY+gDHv/1pf/gxfZvuht/DuBFR1mP33RcFaUUhYOKVo=
X-Google-Smtp-Source: AGHT+IFCqHZ4nii59QrK+Jhw+rDrywqjWTrMjDZMLq2ull6eKrj9OenDertsGsb8tK4eBZqLTUn9pP38DriMvIz7YVc=
X-Received: by 2002:a17:906:6a19:b0:ace:9d35:6987 with SMTP id
 a640c23a62f3a-ad52d441f89mr2374003266b.3.1747928765733; Thu, 22 May 2025
 08:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-13-john@groves.net>
 <CAJnrk1ZRSoMN+jan5D9d3UYWnTVxc_5KVaBtP7JV2b+0skrBfg@mail.gmail.com> <xhekfz652u3dla26aj4ge45zr4tk76b2jgkcb22jfo46gvf6ry@zze73cprkx6g>
In-Reply-To: <xhekfz652u3dla26aj4ge45zr4tk76b2jgkcb22jfo46gvf6ry@zze73cprkx6g>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 22 May 2025 17:45:54 +0200
X-Gm-Features: AX0GCFtyU3N_Zhefral0ZnR18iMPx5aO1xlmLEfo3wUu9EslWmr6-Y8DzN_FaFM
Message-ID: <CAOQ4uxj73Z8Hee1U7LxABYKoHbowA4ARBFDv434yDq+qn5iMZw@mail.gmail.com>
Subject: Re: [RFC PATCH 12/19] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <John@groves.net>
Cc: Joanne Koong <joannelkoong@gmail.com>, Dan Williams <dan.j.williams@intel.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Luis Henriques <luis@igalia.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Petr Vorel <pvorel@suse.cz>, 
	Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 6:28=E2=80=AFPM John Groves <John@groves.net> wrote=
:
>
> On 25/05/01 10:48PM, Joanne Koong wrote:
> > On Sun, Apr 20, 2025 at 6:34=E2=80=AFPM John Groves <John@groves.net> w=
rote:
> > >
> > > Upon completion of a LOOKUP, if we're in famfs-mode we do a GET_FMAP =
to
> > > retrieve and cache up the file-to-dax map in the kernel. If this
> > > succeeds, read/write/mmap are resolved direct-to-dax with no upcalls.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
...
> > > diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> > > index 7f4b73e739cb..848c8818e6f7 100644
> > > --- a/fs/fuse/inode.c
> > > +++ b/fs/fuse/inode.c
> > > @@ -117,6 +117,9 @@ static struct inode *fuse_alloc_inode(struct supe=
r_block *sb)
> > >         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> > >                 fuse_inode_backing_set(fi, NULL);
> > >
> > > +       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> > > +               famfs_meta_set(fi, NULL);
> >
> > "fi->famfs_meta =3D NULL;" looks simpler here
>
> I toootally agree here, but I was following the passthrough pattern
> just above.  @miklos or @Amir, got a preference here?
>

It's not about preference, this fails build.
Even though compiler (or pre-processor whatever) should be able to skip
"fi->famfs_meta =3D NULL;" if CONFIG_FUSE_FAMFS_DAX is not defined
IIRC it does not. Feel free to try. Maybe I do not remember correctly.

Thanks,
Amir.

