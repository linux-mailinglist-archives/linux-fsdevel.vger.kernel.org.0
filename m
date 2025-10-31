Return-Path: <linux-fsdevel+bounces-66631-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76100C26EAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C9EB4F3CF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 20:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD3328B44;
	Fri, 31 Oct 2025 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHS6GT7a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6027D313E16
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 20:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761943130; cv=none; b=M/tSiG54HR9xZGa5BVnmNt8tnO5r7Y++YJUFvJeRFSLgkf5vImHSsRHlNDsCDE8AfNXLyyXU7iXxxVGezESiBt2T4EsgYmF8B118AHOxj0JHeTor3AQ58P+SClgwM5BWsO7A3wJmdOqM1jyg3KkFzYUjRmII5HI/hrVviSyQFcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761943130; c=relaxed/simple;
	bh=bMjQnmQsGW6/Z3vsUIyP2AsbNw0UTR9aWQ8vEEB5Yoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pc0Eqz9ECPF76knevnkuCnlL0qsDG9lop9VrnyhVk7O4Jmcb6X4xpQQl35mdLRxAWcWHlmEj6I8b/OOfhaaDC0aItne6/3jGRa9fgi0t4D3BWiR7O6AgXcnS3y46oqKcHvu3HmTv9vlHyXWVlh5XT+LMXLZv+h/Ln/OTx18XlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHS6GT7a; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed02d102e2so29882721cf.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Oct 2025 13:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761943128; x=1762547928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fL6xrr+aJADX4SCVP7OB3zhue68yQKdvUbd9JmOoCoc=;
        b=FHS6GT7a3q3NZMo6HWXA6Uw7qpwEc6N+Wv5crZa2XTK1jKgs38ela7yZb+tfO++ShT
         an0FMab/Z1aOGXbkSX9XUPuZ28/N0CP0tuA8+Scg3vDKnfbDcMRdr3K2NsRVhYQ6nwG0
         u4DhDoicM/bIiyjEcdYd0cQMrBGVRQxdU6z9ixinmuQnA6/sTrz13ipWxyaqPAUpbOIF
         k/IRLHmHyvje2AcBxBEKonl+vKqWGHmwFmAoAcmaqKLwJ3O5aKbVqcJdAbzDOsor6PY2
         sK42iCrvOCk5KBSulZS1UqwliBYh7Fs3xGFUQ/feCylhR/hYN/+W6KuZghjpTdHd6Kyk
         rOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761943128; x=1762547928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fL6xrr+aJADX4SCVP7OB3zhue68yQKdvUbd9JmOoCoc=;
        b=ek7pEJ+6ZZwV41av1v5Yw8K5CEECKPegW0Rv4JkzV64h4rPw01ZWSmWQ/M1nQtS2pk
         Q8mrrqzCtholgLaIf6Uxf3TTFIODTJgyxxaSIqEQ+SQNOAaONSIc7/UyC+DOomAw6/SD
         Zz1i/kyoVw9AAuPjPWuLJ5bZNUPeIPdHY5tw8+23KDVXvBrRSLS8zKe7fDQ4B1Gs/TdO
         xnUfley3vQiO34KGsMJ0OOOStHEDNVn6qDwBNa5feMY883yZyQ5hhPjazeGhXw34d8rA
         nX7k5UueaYFCADnYlOQ6qYqxKkIcJgGzKVWwPbrEh0gXGUXPTqYz27gtnmuPzh6SxJAD
         MZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmCRs1jHJAH8TokgPXG+yKe+y+U47ToP+xH/wSSxKTl9ZfWCswPmgopA9HzJqkOqJToRN1Y+c3ZUwkqRth@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAE6499qSID4+AwPx4EDG/p1iMEu4b3VHrfwdEgSewXq/WCkg
	vJjMsX5SGjSsou/NmUU0+VNNz5kPdZhl4cjogh8xvcHk/GFXdBwBm8Nc2aNqehVw/xqV0WxT6ix
	F6NMsbEIqIbUvIyi5RK7uGS/GQJLNB5smxcfmu44=
X-Gm-Gg: ASbGncsFLD7+PmsHyo+nnF9lDEK5CQZ5jUakRDAbSC9E4FIwxsEFykNBjNjHSlccsdM
	tWVxHf1kbnTAqghVhsrGq523IPyzcw47lYvg0ZDCFnhK9UIfzHO/Xx/yd8wsEhReHocbSPhtZ3x
	I1sF2jLi8LxyC6kpRSv6WuxZbcBr9kcJwK2kFlEH1lxkazMIIXeUjrPIRaTWQNV10n4FXzgy/UO
	9s4IKGYQaT/V0P36d85zmdJN27qtXwnKG6Aqg3NPLTl1J7sOUAYdANb+dAoZCpPsqsVQvyEEm2l
	tlwpqvBytv7uCagQ+A4qL+/PHr4Re1cdNtILPvNRffk=
X-Google-Smtp-Source: AGHT+IHzkZZql2GDWynJfgneYQp2HB+C8ao4BOK3glem01RW/n0rYS8l1CV0b2YcNwvDS8OjglPLadSCnupbl4g1ZyY=
X-Received: by 2002:a05:622a:999:b0:4eb:a7e7:dabf with SMTP id
 d75a77b69052e-4ed30d5137cmr73260961cf.15.1761943128311; Fri, 31 Oct 2025
 13:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028181133.1285219-1-joannelkoong@gmail.com> <20251031-gasflasche-degradieren-af75b5711388@brauner>
In-Reply-To: <20251031-gasflasche-degradieren-af75b5711388@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 31 Oct 2025 13:38:36 -0700
X-Gm-Features: AWmQ_bmImBrIPmOzbR8zlRZ0sD7-AXwS3fkSY7dSrWi6BjHQHg2Xh7_id2SImes
Message-ID: <CAJnrk1aojoPm_BTnwA+o-5xufhzSiK0JAARpFCQmZ0hZLCLtRg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] vfs-6.19.iomap commit 51311f045375 fixups
To: Christian Brauner <brauner@kernel.org>
Cc: bfoster@redhat.com, hch@infradead.org, djwong@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 5:39=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Oct 28, 2025 at 11:11:31AM -0700, Joanne Koong wrote:
> > These are two fixups for commit 51311f045375 ("iomap: track pending rea=
d
> > bytes more optimally") in the vfs-6.19.iomap branch. It would be great
> > if these could get folded into that original commit, if possible.
>
> It's possible. However, your rename patch will mean that it'll cascade a
> bunch of merge conflicts for following patches in your earlier series.
> IOW, that can't be cleanly folded.
>
> So really the race fix should go first and be folded into 51311f045375
> and I think that can be done without causing a bunch of conflicts.
>
> The rename patch can go on top of what's in vfs-6.19.iomap as that's
> really not fixing a bug as in "breaks something" but a cleanup.
>
> Let me know if that works.

That sounds great. I'll resubmit the race fix as a single patch, and
have the rename patch be part of the other iomap changes series [1]
which will be based on top of the branch.

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20251021164353.3854086-1-joannelk=
oong@gmail.com/

>
> >
> > The fix for the race was locally tested by running generic/051 in a loo=
p on an
> > xfs filesystem with 1k block size, as reported by Brian in [1].
> >
> > Thanks,
> > Joanne
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20250926002609.1302233-1-joan=
nelkoong@gmail.com/T/#t
> >
> > Changelog:
> > v2 -> v3:
> > Fix the race by adding a bias instead of returning from iomap_read_end(=
) early.
> >
> > v2: https://lore.kernel.org/linux-fsdevel/20251027181245.2657535-1-joan=
nelkoong@gmail.com/
> > v1: https://lore.kernel.org/linux-fsdevel/20251024215008.3844068-1-joan=
nelkoong@gmail.com/#t
> >
> > Joanne Koong (2):
> >   iomap: rename bytes_pending/bytes_accounted to
> >     bytes_submitted/bytes_not_submitted
> >   iomap: fix race when reading in all bytes of a folio
> >
> >  fs/iomap/buffered-io.c | 75 +++++++++++++++++++++++++++++++-----------
> >  1 file changed, 56 insertions(+), 19 deletions(-)
> >
> > --
> > 2.47.3
> >

