Return-Path: <linux-fsdevel+bounces-64798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8258EBF420E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 02:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218DA18C5428
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 00:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072670824;
	Tue, 21 Oct 2025 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJHocsw2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA99AD5A
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761005661; cv=none; b=c/a/5abRUw9dsX95q76GmwaHZjlO5jaDtHsEG8pEzzGHmNvKI26ZwnzYxTABAphmxaidXsGSw/AiB7wdfj4krCBzYgnXpReIDt4G+EkDAzwdX1pphkotQrUtIKMLWIxe+RXkdJWv/siNlacWaKyZxXo4B9G5zIsxtzL9ixSe+68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761005661; c=relaxed/simple;
	bh=0KpPKIXCRO/KJfg/sFIh9mEBAeWgFBH1Rwh6MpvEXXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTUHLsH+CRu43ndpwDswlXPxruQpWWZle1RZPGWpWia6hRGb6Qhk0AHaz7rFV5b5wWBgmTr6ay2CJqjYYaCIA0ASR59UUxpkxZQLa4Pkrbn014RGAhebni/qykEjSe08ROG++QbdVUCZr0T9Q0vL62cYm3ClQuZdrUrGsftM7SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJHocsw2; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88e1a22125bso675346385a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 17:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761005659; x=1761610459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ui8DMzsFY6zqaDaV5/75lTx0Gmwu4XTBa5L7MWqUMxQ=;
        b=fJHocsw21mCB2ZY2Vnb3RJYzgOWWxy3Tu9yLtBxKS9GNfb9Q9AByVq+N5gXrvZ4aUs
         1ENFHpzHkEpdC8GWPNqwhrofpWplJ5Docm2y3hf0+WEIX8YOak2qfWEW4sdiHWzU3SJ3
         Yr6nAkxcAeVgJ4GZrU/wjjA80fbVaz4MfLwsww38+zy4+zL1lkMUx7nt3qG925kfnXn0
         eoVR29cT+AA4wHR9FR9qQ0GBZJuzQUGXzPsfUvp1MfD4+KkvPGapTci1ZYiNNDYz0NsT
         QHov3P8zuDXRodLKod9rnCjvTLfHzX/KHDof114DMvAOxzHrQUT9aZBJfLoIYFLkdfkH
         mvfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761005659; x=1761610459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ui8DMzsFY6zqaDaV5/75lTx0Gmwu4XTBa5L7MWqUMxQ=;
        b=Cw9tub8wEpBHuiqGi1wnZnDP8cYjSQIFsIPncCYrBuQiu51gUinO+UxdL487ev5OIz
         2wWA+45kyS0B6sV7qbBn/v/H/RP+FSSfXt7Y9aD7W+iCj10TTn0zzESmqVDa++WbdNIT
         jFkzYStbwlF/q3x0bllgSR3Dp+rljTmqu11CmJg6ugZv1INvtMkqQSthjiBqH/QKNF4z
         vh/1r2Q6gUt9TtfzeHLcburtDmLwW3omrJ9C9z5ltjT+b65ht4hWmcnpQNA0uy44G1al
         4AAYLcqY41bdpz2GPG7XSSlnlkLTMoMChCha2zGjUbiyrX35FxwuQSzExBz+j+uOzBFh
         7OyA==
X-Gm-Message-State: AOJu0YwIxFTIixRwFE1qomU6IFpB+Cn/rrfcAQ8M1fNEsJOlhN2RIP+v
	pMrkeAN3BmBlLch0HWbiRXML9OjLoIxp1H+lH4j3ETcZLq+Ar/0yI0kGThP3x/yObUt3pEVDQnT
	VOF7+Ifw6fxDqMO9k+pvjb1xwxxpNUwo=
X-Gm-Gg: ASbGncs4ra+MdVPw9xp1jQLkXEXN06sExrCQm0v9pe+aGJspx7+B/t2mAFpIVrd7owL
	PFqLlAT73G3VXiD9bQkw5c6BI/f3dkjrGR/0cr4cNa5V1BTuLENPYGU5nlcuGIuZu1sE1pNyJFb
	if8rK1JDnigq1mra2LxSLXwhHW4zTBCL9OhpS+bAxf3HJ9VGHhgJf03PuT8X1WLoaAMquMAee6q
	7a/Aq1zN/jBRDz7+OlWq22hPzfMtbAwg60LzJbkjcfJcLLYplVrcKb7LGv9ukGt1mef6Rg4tO6X
	NgzVhtxdi/YklHlVGE6eQYCgerw=
X-Google-Smtp-Source: AGHT+IFbi7roFVVLG3VRbRv2vUoOUhhzYMKWJpmCLVGWc6aaAHXM4zeW9tJOWQsYfgHBUQ85Ghk6YK2OfSr/WKJb5FA=
X-Received: by 2002:ac8:4249:0:b0:4e8:a464:1083 with SMTP id
 d75a77b69052e-4e8a46411a5mr114717011cf.54.1761005658930; Mon, 20 Oct 2025
 17:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003134642.604736-1-bfoster@redhat.com> <20251007-kittel-tiefbau-c3cc06b09439@brauner>
In-Reply-To: <20251007-kittel-tiefbau-c3cc06b09439@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 20 Oct 2025 17:14:07 -0700
X-Gm-Features: AS18NWBZPYaiU7LDy5QEDqgaPTc4fOwEctpwqOwtUrXF3pD2hGNbq7TTOushC1w
Message-ID: <CAJnrk1Yp-z8U7WjH81Eh3wrvuc5erZ2fUjZZa2urb-OhAe_nig@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] iomap: zero range folio batch support
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Brian Foster <bfoster@redhat.com>, 
	linux-xfs@vger.kernel.org, linux-mm@kvack.org, hch@infradead.org, 
	djwong@kernel.org, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 4:12=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, 03 Oct 2025 09:46:34 -0400, Brian Foster wrote:
> > Only minor changes in v5 to the XFS errortag patch. I've kept the R-b
> > tags because the fundamental logic is the same, but the errortag
> > mechanism has been reworked and so that one needed a rebase (which turn=
s
> > out much simpler). A second look certainly couldn't hurt, but otherwise
> > the associated fstest still works as expected.
> >
> > Note that the force zeroing fstests test has since been merged as
> > xfs/131. Otherwise I still have some followup patches to this work re:
> > the ext4 on iomap work, but it would be nice to move this along before
> > getting too far ahead with that.
> >
> > [...]
>
> Applied to the vfs-6.19.iomap branch of the vfs/vfs.git tree.
> Patches in the vfs-6.19.iomap branch should appear in linux-next soon.
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
> branch: vfs-6.19.iomap
>
> [1/7] filemap: add helper to look up dirty folios in a range
>       https://git.kernel.org/vfs/vfs/c/757f5ca76903
> [2/7] iomap: remove pos+len BUG_ON() to after folio lookup
>       https://git.kernel.org/vfs/vfs/c/e027b6ecb710
> [3/7] iomap: optional zero range dirty folio processing
>       https://git.kernel.org/vfs/vfs/c/5a9a21cb7706

Hi Christian,

Thanks for all your work with managing the vfs iomap branch. I noticed
for vfs-6.19.iomap, this series was merged after a prior patch in the
branch that had changed the iomap_iter_advance() interface [1]. As
such for the merging ordering, I think this 3rd patch needs this minor
patch-up to be compatible with the change made in [1], if you're able
to fold this in:

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 72196e5021b1..36ee3290669a 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -867,7 +867,8 @@ static int iomap_write_begin(struct iomap_iter *iter,
        if (folio_pos(folio) > iter->pos) {
                len =3D min_t(u64, folio_pos(folio) - iter->pos,
                                 iomap_length(iter));
-               status =3D iomap_iter_advance(iter, &len);
+               status =3D iomap_iter_advance(iter, len);
+               len =3D iomap_length(iter);
                if (status || !len)
                        goto out_unlock;
        }

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aJf1cgpzmDz0d+8K5gOFBpk5wh=
qPRFsWtQ0M3dpOOJ2Q@mail.gmail.com/T/#u

> [4/7] xfs: always trim mapping to requested range for zero range
>       https://git.kernel.org/vfs/vfs/c/50dc360fa097
> [5/7] xfs: fill dirty folios on zero range of unwritten mappings
>       https://git.kernel.org/vfs/vfs/c/492258e4508a
> [6/7] iomap: remove old partial eof zeroing optimization
>       https://git.kernel.org/vfs/vfs/c/47520b756355
> [7/7] xfs: error tag to force zeroing on debug kernels
>       https://git.kernel.org/vfs/vfs/c/87a5ca9f6c56
>

