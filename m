Return-Path: <linux-fsdevel+bounces-28189-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DE6967CC7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2024 01:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 916E0281A26
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Sep 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB85185B60;
	Sun,  1 Sep 2024 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arzHjtbj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA81D13AA46;
	Sun,  1 Sep 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725234080; cv=none; b=jn6WDNCRYXQDCnjZhqfh/bkLwHgrXaG/HXeXrbNk8d/uXeGIVS0SwrMaYrH8hMCj5JGtqvSWhIi6dBs5/kiFjQEUv1QG0PUwdUKr+n17cv2k+RjBL8jdvYoNvpLX5hmahkylSmcY7x0rk3Mu7nTfvsHBMJ3oeMiMRAMDHJrdVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725234080; c=relaxed/simple;
	bh=MOF3+IXawLy9SIlMBfajQDdPJDqrahG9DjBoz/9HRR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOgZpEBsAM4IP0ekTYYDqkc7c/62Lp7plbe3S2VREwrKcKT65PfFeWLX0eBtSDuwvMWfk13hd10Hkb4jbzPXFNOwTUT86dI8kZjr9qzHOnS526jdsxj/UE/r1DjCSFAzeTbkIIP+O02qLi93mIuxhN+NXbfggYh2Dd8T0DRox8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arzHjtbj; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f406034874so42614521fa.1;
        Sun, 01 Sep 2024 16:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725234077; x=1725838877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=arzHjtbjkzNva0NcZZQaRqGAZxNO6Lh3o6l+UU2Arh4H+tVW798SAR2UCOrLI85isa
         nJwkbpzxGya80LVPj/Nn/0gf/8xN/Uc4hdC+T1Yfonjb2v6RB2L/IhkZKBtaSqCvudMH
         I+YoR/JGYRcuPaNq/4evVMyRUV7hC4KPH+2S/Jv2JCkJtw+ONHr13uEEi+4KITOmshxk
         H4QXE4X9dEu/T0tYkaTZju5t86pXcAp5AvISel8G4C5CSB1I0tj75l4KTQvFQqiA1uSY
         I6K1GNd+InOBTDkFJxniF34q0MIi5a+n/9fHzoowRoPvY/fGUZ2CxKi7CwaYMlH3LPii
         /Cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725234077; x=1725838877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OptCrhRONfMIpYiriIyIArvvwMoZ9X5KBzqF2jB2C8=;
        b=waznXLgd3mWb0iMtWfRbSWkq87KDjTRhPIQWhw7hN7hIvxvrbEALUkM00o12fTeHNt
         DMjrLZUc3O3K7A4NaboZoSuwrDPH2aJEJzym5VAu/mk5nrqhbwfBaazrB7T6qgecbefD
         QmDhLuIKb921BprNEcgkfaGdRdMr5ECRNnXqDCZ2mPzX42mMpUhWtmre1F7KD2kzg6Gh
         bOSlzNIXr6TcvZqy19FWvhjBZhf4v/F3jl+bwj7Ck/rPWZRezKs3DqWNluhJDDG8IPju
         /Szy5F5a9iRKNxiPpJJT0zgD09iO4b7q2L7HStrxQPWnR+2UxZT5EbjX1QfJFwBeg3kE
         xhzw==
X-Forwarded-Encrypted: i=1; AJvYcCW2WoS4s9Z4Qn4M1KtXSzTcL3Aul4nO6uUodBkWrwJ9bfJaNjChDczkUSqvQ7MZOq/L+k9NySV3uXeg@vger.kernel.org, AJvYcCWjXI0NEP2OMcY8wLX3S7HyHyct+1ZBhBuffBCWDWbPynBNvKiIq+WjpixlDlvRziYHrq2ujiOmtmzEGImS@vger.kernel.org, AJvYcCWneAzEXWcSHYNVC1oQlehYE25R/cdqhtchh27McfWs8iICrJD2yeOswEspqbymTOc+UBx+y2YmucZSWA==@vger.kernel.org, AJvYcCX/5Q7MUN9+OyEOJDOQlnorKI0unzZHhIxfpQBHYD18LEXPl1puaEjHjGFahTAGyneUoiSrfdFao9Y0XJVzCw==@vger.kernel.org, AJvYcCXeNIORl75gm26DiltzaxuA54PZPO3nP+V+vPamDPkGUSyVKEKNsKiBlTHc250qR12Nskb9fZIn7LdZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxRN2v1a0ibF37XCS/OmRsosa9pLSsDlRDfTYzN/I88B02/5In8
	L/dx/yKp/VVYCbC6/4MVFkUc9Id6+IMlTYwMmGdZpcHYEVHdyNN2pAVeEvNqimwyMT+mILpw3Rd
	IhgFvWmLPuzbtMbkoRTfKpRE77+0=
X-Google-Smtp-Source: AGHT+IHrpw2kTpvaZiyKJAHMxmQ/fhZpxqRdKI1vFWTY9ydD57nABAkwYo+y3SH1kUAvMU7Md95wbwacKxJ+67IyRxg=
X-Received: by 2002:a2e:be29:0:b0:2f5:23a:106b with SMTP id
 38308e7fff4ca-2f610890868mr90286721fa.34.1725234076595; Sun, 01 Sep 2024
 16:41:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828210249.1078637-1-dhowells@redhat.com> <20240828210249.1078637-5-dhowells@redhat.com>
 <20240830-anteil-haarfarbe-d11935ac1017@brauner>
In-Reply-To: <20240830-anteil-haarfarbe-d11935ac1017@brauner>
From: Steve French <smfrench@gmail.com>
Date: Sun, 1 Sep 2024 18:41:05 -0500
Message-ID: <CAH2r5mv8merj9J=UK-U2xsSArL2s9zuRP-bZHnM39jU6Ujx9JQ@mail.gmail.com>
Subject: Re: (subset) [PATCH 4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
To: Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
	Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, devel@lists.orangefs.org, 
	Steve French <sfrench@samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks like an important one as it fixes multiple xfstests see e.g.
with the patch:
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/213
vs without
http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/212

Can add:
Tested--by: Steve French <stfrench@microsoft.com>

On Fri, Aug 30, 2024 at 8:12=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, 28 Aug 2024 22:02:45 +0100, David Howells wrote:
> > Fix filemap_invalidate_inode() to use invalidate_inode_pages2_range()
> > rather than truncate_inode_pages_range().  The latter clears the
> > invalidated bit of a partial pages rather than discarding it entirely.
> > This causes copy_file_range() to fail on cifs because the partial pages=
 at
> > either end of the destination range aren't evicted and reread, but rath=
er
> > just partly cleared.
> >
> > [...]
>
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.
>
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
>
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
>
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs.fixes
>
> [4/6] mm: Fix filemap_invalidate_inode() to use invalidate_inode_pages2_r=
ange()
>       https://git.kernel.org/vfs/vfs/c/c26096ee0278
>


--=20
Thanks,

Steve

