Return-Path: <linux-fsdevel+bounces-74572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD1BD3BEA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 06:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A63C4ECA6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 05:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7B236165E;
	Tue, 20 Jan 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnYRsEGV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350B53612D5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768885898; cv=none; b=sOrQJr8UftaEd16tIBHoXUTWz/aunccGt3zzEdIAciLigvinZl7AtLc4r1aEWbfhM01LS7FaRmTwlshAHv5dEFCGfYGmYlcQF6x0QBY1wzpQqm6TbdrI16uZ1TeQEtsLKiX3FfMqgZkju2Iagf517DWU4dYv2BO0JeyD3Py20Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768885898; c=relaxed/simple;
	bh=oDIqt6WmCg1YfFSfuc1P7pjEgerXid9fxV54dDZIVcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tU2LdSuT4e9AVFypIpUeSzI639lhKKMVxSTROgfQLq2jOCJhvyhB94byWsNHAtcS2sFMbOZePRpchEiX4R04ZQxvBWpEmuYoL3R5/EJkZ73BSSaObb1qnCs/0IcUxeSZhYnxERHzR/NVo0U5Q2k9+6QHrlCuY5cYh8oX/GS7h6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnYRsEGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153BBC2BCB1
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 05:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768885898;
	bh=oDIqt6WmCg1YfFSfuc1P7pjEgerXid9fxV54dDZIVcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qnYRsEGVi8BoZdtFYFxtCZhoPthFSWnOzxjcI+kQi4wGhvfozh8CHlidqYsraNrE0
	 1LQDe88L3sWru6iiuK1CYkFjc0x3RfhCC8R67kJeXK3CMOi/wNoqBj6T/0OJENz4/3
	 ro/C0PCrWUSDs3WO/frWxvQz+72arN4BAoemEwtRW0CfYCM6g9+f1t8oiPnBWwszkJ
	 WT7eZ66MRGvmtv6kksdFllA2sdDLBM7GWccZu4/ChmEEymAfH8Z8F1jtJvKevp2RCZ
	 EsRuSU0/j56gaSPmQk93AdAGMndoueRtWbVFxSNKNZCcWj6KV00g3hx0XhgVJWPvHv
	 UZdNaepsB2IHA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b879d5c1526so731323966b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Jan 2026 21:11:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzcJYubAlbtraImoUzDzaxwzGgcH2Nwb4LLdlZ7qw7MWvpmGssCPOr0NBQuVZvKT4M4OusL6dqTkG8DbMO@vger.kernel.org
X-Gm-Message-State: AOJu0YyzxAFMEcufELqrKDH6GMRthFYSwgBJ90WQE9Om8T3fcqtZoS2K
	jk2K2zD4r/0s1tVBeteiSGctG3DWh9qjHg8O4QbmHJOXpd5nytnnFsvssMn3bL6F9LNIeh0S+Eo
	OK6jApdyx3cBr79bDDURWz2mLT3baXYY=
X-Received: by 2002:a17:907:6d06:b0:b87:6f65:3bc9 with SMTP id
 a640c23a62f3a-b8796bc459cmr1128709166b.61.1768885896318; Mon, 19 Jan 2026
 21:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111140345.3866-1-linkinjeon@kernel.org> <20260111140345.3866-7-linkinjeon@kernel.org>
 <20260116085359.GD15119@lst.de> <CAKYAXd_RoJi5HqQV2NPvmkOTrx9AbSbuCmi=BKieENcLVW0FZg@mail.gmail.com>
 <20260119071038.GC1480@lst.de>
In-Reply-To: <20260119071038.GC1480@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 14:11:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8R=mPVR_ezDHRZqiKL9n-i5QRuDZnaK+poipBtCJtE=g@mail.gmail.com>
X-Gm-Features: AZwV_Qis_-_x-qFuKbWmpnxTB8ZTg_fPapfqZNq4eenrDzTzrBSfNppY3jl6UGo
Message-ID: <CAKYAXd8R=mPVR_ezDHRZqiKL9n-i5QRuDZnaK+poipBtCJtE=g@mail.gmail.com>
Subject: Re: [PATCH v5 06/14] ntfs: update file operations
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

On Mon, Jan 19, 2026 at 4:10=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Sun, Jan 18, 2026 at 01:56:55PM +0900, Namjae Jeon wrote:
> > > Talking about helpers, why does iomap_seek_hole/iomap_seek_data
> > > not work for ntfs?
> >
> > Regarding iomap_seek_hole/iomap_seek_data, the default iomap
> > implementation treats IOMAP_UNWRITTEN extents as holes unless they
> > have dirty pages in the page cache. However, in ntfs iomap begin, the
> > region between initialized_size and i_size (EOF) is mapped as
> > IOMAP_UNWRITTEN. Since NTFS requires any pre-allocated regions before
> > initialized_size to be physically zeroed, NTFS must treat all
> > pre-allocated regions as DATA.
>
> What do you need IOMAP_UNWRITTEN for in that case?  If the blocks have
> been zeroed on-disk, they are IOMAP_MAPPED by the usual iomap standards.
> If you need special treatement, it might be worth adding a separate
> IOMAP_PREZEROED with clearly defined semantics instead of overloading
> IOMAP_UNWRITTEN.
By modifying iomap_begin, it seems possible to implement it using
iomap_seek_hole/data without introducing a new IOMAP_xxx type. My
previous explanation was insufficient, so let me provide a more
detailed clarification. The concept of an unwritten extent in NTFS is
slightly different from that of other filesystems. NTFS conceptually
manages only a single continuous unwritten region, which is strictly
defined based on initialized_size.

File offset
0                               initialized_size                     i_size=
(EOF)
---------------------------------------------------------------------------=
---------
|     #0               |        #1                 |            #2
| Actual data   |  pre-allocated        |       pre-allocated              =
 |
| (user written |  (within initialized)  |   (initialized_size ~ EOF)  |
|  completed)  |                                |
---------------------------------------------------------------------------=
----------
MAPPED        MAPPED                  UNWRITTEN

 * Region #1: must be zero-initialized by the filesystem.
 * Region #2: does not need to be initialized.

Since NTFS does not support multiple unwritten extents, all
pre-allocated regions must, in principle, be treated as DATA, not
HOLE. However, in the current implementation, region #2 is mapped as
IOMAP_UNWRITTEN, so iomap_seek_data incorrectly interprets this region
as a hole. It would be better to map region #2 as IOMAP_MAPPED for the
seek operation.

>
> >
> > >
> > > > +             file_accessed(iocb->ki_filp);
> > > > +             ret =3D iomap_dio_rw(iocb, to, &ntfs_read_iomap_ops, =
NULL, IOMAP_DIO_PARTIAL,
> > >
> > > Why do you need IOMAP_DIO_PARTIAL?  That's mostly a workaround
> > > for "interesting" locking in btrfs and gfs2.  If ntfs has similar
> > > issues, it would be helpful to add a comment here.  Also maybe fix
> > > the overly long line.
> > Regarding the use of IOMAP_DIO_PARTIAL, I was not aware that it was a
> > workaround for specific locking issues in some filesystems. I
> > incorrectly assumed it was a flag to enable partial success when a DIO
> > request exceeds the actual data length. I will remove this flags and
> > fix it.
>
> It only does short I/O for -EFAULT, which only happens if the nofault
> flag on the iov_iter is set.  See the big comment in
> btrfs_direct_write where that field is set about the explanation.
Okay.
>
> > > What is the reason to do the expansion here instead of in the iomap_b=
egin
> > > handler when we know we are committed to write to range?
> > We can probably move it to iomap_begin(). Let me check it.
>
> If it works better here that's also fine, just document it as it looks
> a bit unusual.  Handling the cleanup on failures might be a bit easier
> if it is done in the iomap loop, though.
Okay. Thanks!
>

