Return-Path: <linux-fsdevel+bounces-2606-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B97E7036
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 563A81C20C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F5C225CF;
	Thu,  9 Nov 2023 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P113lzxw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D506E22329;
	Thu,  9 Nov 2023 17:27:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329DBC433BA;
	Thu,  9 Nov 2023 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1699550832;
	bh=/iXik9FGY/j8fU7q/WT2BYxZ4459aBKtixWI7gW0Gy8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P113lzxwo814DeFndWkAaSyJ+DLb8VNTEP7P6j/vCWGSSKY2QDBBCpyUJtXKsvZt8
	 yVSynsnJ8XhLaIqnbxNEa9vIPier0gLp7yXoMzqsfeZ25GvHh45wYNq+pLR/4wNIBl
	 YqtZ8j7nGGcDw1o6QRhQLfQDovsx9kZS0r7BiWJc=
Date: Thu, 9 Nov 2023 09:27:11 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Andreas =?ISO-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-ext4
 <linux-ext4@vger.kernel.org>, gfs2@lists.linux.dev, Linux FS-devel Mailing
 List <linux-fsdevel@vger.kernel.org>, linux-xfs
 <linux-xfs@vger.kernel.org>, "Darrick J . Wong" <djwong@kernel.org>,
 linux-erofs@lists.ozlabs.org, "Theodore Ts'o" <tytso@mit.edu>, Andreas
 Dilger <adilger.kernel@dilger.ca>, Andreas Gruenbacher
 <agruenba@redhat.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
Message-Id: <20231109092711.cf73f30a2fa84d4400377839@linux-foundation.org>
In-Reply-To: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
References: <20231107212643.3490372-1-willy@infradead.org>
	<20231107212643.3490372-2-willy@infradead.org>
	<20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
	<CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Nov 2023 01:12:15 +0100 Andreas Gr=FCnbacher <andreas.gruenbacher=
@gmail.com> wrote:

> Andrew,
>=20
> Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 0=
0:06:
> > > +
> > > +     if (folio_test_highmem(folio)) {
> > > +             size_t max =3D PAGE_SIZE - offset_in_page(offset);
> > > +
> > > +             while (len > max) {
> >
> > Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> > the final page.
>=20
> not sure what you're seeing there, but this looks fine to me.

I was right!  This code does fail to handle the final page.

: static inline void folio_fill_tail(struct folio *folio, size_t offset,
: 		const char *from, size_t len)
: {
: 	char *to =3D kmap_local_folio(folio, offset);
:=20
: 	VM_BUG_ON(offset + len > folio_size(folio));
:=20
: 	if (folio_test_highmem(folio)) {
: 		size_t max =3D PAGE_SIZE - offset_in_page(offset);
:=20
: 		while (len > max) {
: 			memcpy(to, from, max);
: 			kunmap_local(to);
: 			len -=3D max;
: 			from +=3D max;
: 			offset +=3D max;
: 			max =3D PAGE_SIZE;
: 			to =3D kmap_local_folio(folio, offset);
: 		}
: 	}
:=20
: 	memcpy(to, from, len);

This code down here handles it, doh.

: 	to =3D folio_zero_tail(folio, offset, to);
: 	kunmap_local(to);
: }

Implementation seems less straightforward than it might be?  Oh well.

Has it been runtime tested?

Anyway, let's please change the function argument ordering and remember
to cc linux-mm on v2?

