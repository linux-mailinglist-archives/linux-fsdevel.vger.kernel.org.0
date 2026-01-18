Return-Path: <linux-fsdevel+bounces-74297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F2D392CF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 05:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924153017EFA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 04:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E21B331328B;
	Sun, 18 Jan 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJfKVYwp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB6A23EA92
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768712086; cv=none; b=BN8qaTE9XVfRDGbktEJfqqfxFURzJj7HgtUqoV2dYrL1SaaKU7bf/NJo7Ts+3DEXUUdD5CGe3z9unzOvU2riBG4ZZUCsjU4kf7s8z6bmUG560ez0SqLrjeXNk+dyZK/yoHWu2u9XBZIkk+9gSiN7WULCNm0DM7ZeLfJfxnbt3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768712086; c=relaxed/simple;
	bh=ExMtnCQ6QOsfWsdbT7oYQ0pqUCd18KCWzzG9HCLr/zM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mNxGrSIjTsM81rW4JAXYLpjzFakRwAw2Kb7xe4TeMHE+vQWm0c2LpQ78cJJ115VwXYA400d/KM/wEfZ8QDX2N7NyfWBXw5WJ32sD9+ECWn1VU6/cm2EIPln0MKMAxu/qU2ULiO54Vv4eUbfeVUpCUnl7rGK4erInzssxISAEKR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJfKVYwp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B405C4AF12
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jan 2026 04:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768712086;
	bh=ExMtnCQ6QOsfWsdbT7oYQ0pqUCd18KCWzzG9HCLr/zM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jJfKVYwpab8hcoBT0mvpu+nYT7E4I/Ps4Iamtax/5KSrC9x6iFgNouedsDGZjnLU2
	 iwSgVpzXCVcj+NAlfaYHtrsVad6ASMI4uumc4f2GQb5TpNEdGhgWpb1FJg5eXioz4Y
	 uh2vBflpbqbaYoPkboYNwz2sakyYlaEYECg5Q0uKAAm095/Yfa3AvFDJlwqda3twYY
	 VYrMEE+JpYlFuTcIbjq+AX8z52jQbG9XSrlZsL02uoZJ+7ozKLhsw5dFV/zczKI/mQ
	 23MGfISxUtWnAwQm0J1TOs/fMofY0u+okbUOoTtQY9wA2mzv0DiumN90oaGI6j+dnL
	 BMEtp/FMwrECQ==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b872f1c31f1so431020266b.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Jan 2026 20:54:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWigrazFVNxvkgINQJCbQsjvyO8nZUL0kZC5Xq87SNw5KYLRH5JYFx3S7pkid/LjlkII/56UH0qHxS3kSsl@vger.kernel.org
X-Gm-Message-State: AOJu0YwcVmLCKTsID2OFQZwkAD1lXlNt/hHLo8jcgTvi6zKYGWylBu0Q
	5AtUlGbSp01iWLkXxgAKZEmUTmgrnMqUdIss6ieJNRtWZ9TSUzZONogi0XNpzcZZ4rgXEGmSV4w
	wf/h8QxRcdUVCqsTMHFt36yhg1M4q5Zc=
X-Received: by 2002:a17:907:d0b:b0:b87:1741:a484 with SMTP id
 a640c23a62f3a-b87930332bdmr711008366b.43.1768712084548; Sat, 17 Jan 2026
 20:54:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-5-linkinjeon@kernel.org>
 <20260116083012.GC15119@lst.de>
In-Reply-To: <20260116083012.GC15119@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 18 Jan 2026 13:54:32 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_4E4ftBU+qC=TD=_ECmmX-EgYzdDBf7GR69bUW7ETcAg@mail.gmail.com>
X-Gm-Features: AZwV_QgKAYmqCiUVjAH3NcCU_O3-dbLh5faqLy6nD9xJM2J1NI9TAW90jwVaZfA
Message-ID: <CAKYAXd_4E4ftBU+qC=TD=_ECmmX-EgYzdDBf7GR69bUW7ETcAg@mail.gmail.com>
Subject: Re: [PATCH v5 04/14] ntfs: update inode operations
To: Christoph Hellwig <hch@lst.de>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu, 
	willy@infradead.org, jack@suse.cz, djwong@kernel.org, josef@toxicpanda.com, 
	sandeen@sandeen.net, rgoldwyn@suse.com, xiang@kernel.org, dsterba@suse.com, 
	pali@kernel.org, ebiggers@kernel.org, neil@brown.name, amir73il@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iamjoonsoo.kim@lge.com, cheol.lee@lge.com, jay.sim@lge.com, gunho.lee@lge.com, 
	Hyunchul Lee <hyc.lee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 5:30=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> >  int ntfs_test_inode(struct inode *vi, void *data)
> >  {
> > -     ntfs_attr *na =3D (ntfs_attr *)data;
> > -     ntfs_inode *ni;
> > +     struct ntfs_attr *na =3D (struct ntfs_attr *)data;
>
> No need to cast from void pointers to other pointer types.
Okay.
>
> > +     struct ntfs_inode *ni;
> >
> >       if (vi->i_ino !=3D na->mft_no)
> >               return 0;
> > +
> >       ni =3D NTFS_I(vi);
>
> Nit: If you're touchiung this anyway, the ni initialization could be
> moved to the declaration line.
Okay, I will fix them.
Thanks!
>

