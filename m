Return-Path: <linux-fsdevel+bounces-71038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78538CB20A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 06:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC68E30180AD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 05:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3DA311964;
	Wed, 10 Dec 2025 05:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqvK6JdJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82605224AF9
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 05:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765346374; cv=none; b=o8n38Ss0OaICwOZi3vmx/nbrRmi91ZistMz5ub5NMVTCOcASPh5Nlbdds2z8Fj2+5GXQokkqsgPp6ZUmDjCaSwye1JnwajwGCC2SwDwDnM/kz2ZZ+pnVPqcU4zJEhUxFeBvRjqmrH+kQ6NUofqjyArcNKNsFFTFrsw5/esrQNqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765346374; c=relaxed/simple;
	bh=GTRCtGEyCPeIDAEAsYjvD8gFAZcZN/SMX8UD5Q3ZU7g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cmi+iS5890Vf1eozLwG+Kj6p/FmnOYTsyrNS6+gZrcSxXKmYX/+O5pQHLS90inRiK7IKh+hV7D+c+tWbrz6scT5TfUZrmI3coJUn31lVeouexfgriI2hXRdCInHIj5SHGV+nvPq5RwTtLLj8LgOBEm4zsQiDtLEGUvNfhkhJFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqvK6JdJ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64471fcdef0so60754d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 21:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765346371; x=1765951171; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AkKmEmlmy8ELaJoQUHf2BKQunA/3LKCRjsVDxaDzqrg=;
        b=oqvK6JdJFcG6MMgKCrtELZ1klGDw+kOoASSqR8Lb6xhVf7QYDkhbsDzLjHKCdcKmAu
         DG1Ylt948CufhY3YJO4lUhrgLZbAL+v43yg5fNadlfqVJ5LwJUrANax8QczEE6kf2OhR
         cu/3NTTpaBX0Dbn5OxLNfZdFVyPqioIfzYzHK8iVgct7mli9dapcW2leVuxNG23Sprt9
         oLGiJ8i06f5S0VXVwRypTsj89R6mBVce+sz0hJ/dTX+7FU20EpStGpvRhGahauKXuJP2
         cTbiFG/+IBDQZJkwF7MY2dOaNyw/T6RGzToaxamSHXAsfCavpLwZGDC3pI8vTp+4YkxS
         CXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765346371; x=1765951171;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkKmEmlmy8ELaJoQUHf2BKQunA/3LKCRjsVDxaDzqrg=;
        b=QWc16bcvK542j7INRspzIN/9wWw3M1X77TaUq5pxJ1p8HuUXzFqfL/JA5yc0cxP5pp
         0c0cXSklE8iYBaDZFTqngVYae6jw7n90OBiRwU804qBa56f2/Yrdq2kwkqLY4CSZCxvj
         XCc8R+lmlGtkp3QhHbfRTALLUW52aatvT/NEtSWQ4LSmdZ2iquodiMxTf9YWweYoRFLp
         fksJY8RptnQ/ENnpeZneqG6yec26SzCjRnD0QDF6qDrVwCyoryvhtHuRCKt0+u9xV5Ut
         b525qkck5v4y0J4NOHX8KzdCqkF1DRAmWObeZR+1xffUBg5UWvMS64WvUBsfGxihTOEO
         XI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiwo6oOnO0VlNjONYy5xzea/KUnzPixEbzaZorSvuOmAT0qBnoFnFdmdc1OSbR9viW5Y7Cd9A7dR0Fxb+s@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo81bxyhiyfYsBhm7keFU99gNfkn+rx7SznNrJ4KeuK+h5P3+X
	M63tvHniM+zPTVJ2RonsNU11R2OzFl8UQe/OJyHmDpVYRXXnccM5m5D/phUxVHPGWQ==
X-Gm-Gg: AY/fxX7K5Y7AP3I1QBlDDQCsAkj1ahQr0/UmEMpu6PG+FiXH9j+Zi6j1OBRVD2GlfVO
	dwui1Q56Qb4uWuFL5BZgc3wHyzVbbVXV7ltrM5IRgUgjiTsRfCnmaZ03mo6gJELw+5LOH/Ccp7S
	wWzgHH6lFfUpJU0+/koRnAQ1iT+KXNPuAcCdbYrB3Sb+Ofspttvt3DHtYkf600IaqkJ2QLE4MaI
	CxM7ZUc4IL0j2IFIIzwGB82+bwiuBPB2baEX/K65u0oeZJ3GLnDkszfqOASy+0pvdzyM0moqgin
	YDrkkUOPCrLcBdBuMG/w5KTAzUMGtA99QJq5Ny1kmXmnbcz6BcqEA5DPNdQlv4YvueB/MP2l25x
	2ZKg8eo79BahA3+zCe9xyJYJZmZGxUBxr3XYwiUg6BKgL5Vx7mB2a8WAM2N9kmG0nfZlBArPQd1
	aP55UwpQFx4rY59PCw5bRd8rAvlpFIlU2Dl+TlUvwWbF0Me+QAr03aV4gRelR9TJfgvoM0XGoLZ
	ws6OPp3HQ==
X-Google-Smtp-Source: AGHT+IHnYfs/FNwfsBlpEOywYrB4YmggQz7ScEEsHZ6ji5edm/7oBhWYVx7J+CQpa4h3kxU6P5oVKw==
X-Received: by 2002:a05:690c:3382:b0:78c:7b51:bdf4 with SMTP id 00721157ae682-78c95a4faacmr21928597b3.13.1765346371280;
        Tue, 09 Dec 2025 21:59:31 -0800 (PST)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b779458sm67535757b3.35.2025.12.09.21.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 21:59:30 -0800 (PST)
Date: Tue, 9 Dec 2025 21:59:16 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>
cc: Hugh Dickins <hughd@google.com>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>, 
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tmpfs: enforce the immutable flag on open files
In-Reply-To: <mmfrclxjf2mmmohiwdbgqhyyrlab33tpnmtuzatk2xsuyiglrp@tarta.nabijaczleweli.xyz>
Message-ID: <57e2e227-e464-bd7f-f69e-573a772cd4c5@google.com>
References: <toyfbuhwbqa4zfgnojghr4v7k2ra6uh3g3sikbuwata3iozi3m@tarta.nabijaczleweli.xyz> <be986c18-3db2-38a1-8401-f0035ab71e7a@google.com> <mmfrclxjf2mmmohiwdbgqhyyrlab33tpnmtuzatk2xsuyiglrp@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-805250018-1765346370=:9638"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-805250018-1765346370=:9638
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 9 Dec 2025, Ahelenia Ziemia=C5=84ska wrote:
> On Mon, Dec 08, 2025 at 08:14:44PM -0800, Hugh Dickins wrote:
> > On Mon, 8 Dec 2025, Ahelenia Ziemia=C5=84ska wrote:
> > > This useful behaviour is implemented for most filesystems,
> > > and wants to be implemented for every filesystem, quoth ref:
> > >   There is general agreement that we should standardize all file syst=
ems
> > >   to prevent modifications even for files that were opened at the tim=
e
> > >   the immutable flag is set.  Eventually, a change to enforce this at
> > >   the VFS layer should be landing in mainline.
> > >=20
> > > References: commit 02b016ca7f99 ("ext4: enforce the immutable flag on
> > >  open files")
> > > Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczlewel=
i.xyz>
> > Sorry: thanks, but no thanks.
> >=20
> > Supporting page_mkwrite() comes at a cost (an additional fault on first
> > write to a folio in a shared mmap).  It's important for space allocatio=
n
> > (and more) in the case of persistent writeback filesystems, but unwelco=
me
> > overhead in the case of tmpfs (and ramfs and hugetlbfs - others?).
>=20
> Yeah, from the way page_mkwrite() was implemented it looked like
> enough of a pessimisation to be significant, and with how common
> an operation this is, I kinda expected this result.
>=20
> (I was also gonna post the same for ramfs,
>  but it doesn't support FS_IOC_SETFLAGS attributes at all.)
>=20
> > tmpfs has always preferred not to support page_mkwrite(), and just fail
> > fstests generic/080: we shall not slow down to change that, without a
> > much stronger justification than "useful behaviour" which we've got
> > along well enough without.
>=20
> How do we feel about just the VFS half of this,
> i.e. open(WR)/chattr +i/write() =3D -EPERM?
> That shouldn't have a performance impact.

I don't think tmpfs should implement half of the ext4 behaviour (at
write time) and not the other half (at page_mkwrite time): it would
leave IMMUTABLE on tmpfs as neither guaranteeing immutabiity, nor
behaving in the way IMMUTABLE was traditionally supported.

I do think it's surprisingly asymmetic, that IMMUTABLE should forbid
opening for write, but holding open for write should not forbid
setting IMMUTABLE.  But that's the traditional behaviour, which
surprised you, and which those ext4 mods improve upon for ext4.

But I couldn't find any filesystem other than ext4 and f2fs
implementing it that way.  If the VFS and other filesystems agreed
to implement the stricter IMMUTABLE (I imagine relying on i_writecount),
then tmpfs would probably be glad to participate; but not go its own way.

Hugh
---1463770367-805250018-1765346370=:9638--

