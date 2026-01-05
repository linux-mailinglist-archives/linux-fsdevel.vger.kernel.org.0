Return-Path: <linux-fsdevel+bounces-72407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1351CF5708
	for <lists+linux-fsdevel@lfdr.de>; Mon, 05 Jan 2026 20:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8418530A0D83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jan 2026 19:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D88280CF6;
	Mon,  5 Jan 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctkWunSJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7528750B
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jan 2026 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642958; cv=none; b=kI1H+eifV20sz5sEfQRgrkUkycDvzwDPAts4siowb4akM+4SrY7OryxqI5CKnAwbmbZh8oEDLhr6P/VMwkm3tRU0+RtxATlOdNUdfxizBNxRwKA11u9YB3roAby5IlGP4duWckQ5+orAY1rfuc0MB9GdlViU6QC3hHrvBjl3Wxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642958; c=relaxed/simple;
	bh=B/KCutNmTXc3sPl8xG1vSOW3KcxjghTl22c98nbAzLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bk8A9YPscC+TrLuleDTTuyHFpV+g3Z9TAsJxijbzBU5AD6uBWeiovaubVuE842ur52BpFe+xn6+RwZiOkEEQjFtc/qAJ2D1PwhWDHhTY3uvc04h+mpUvuj4C9CTErNAZLqwAej08MojOH9D6Gl36oUs84txvnL8QD3akJmBs2gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ctkWunSJ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4f822b2df7aso2810171cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Jan 2026 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767642956; x=1768247756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iog+hYgLiZRC3g3lYFmRjl8SBSTmMSwxCWcvManxv3I=;
        b=ctkWunSJttS/uY2z77W3YgS1SoXFgjaGRw4R+iTuIn/377xURXpYseqRkC4hGQ/ean
         wGKSc205PXyouI+kIdFrt6DAtmqu4dUoh+9v0QolmJcwpGFQuV2FBWwGXSVA7SiycSkQ
         90OAC5lWxO0pVxS604dUiTObqgbaWbek3yWCbgl8lzjIMFu9sOfvR53ZWRYSxy6ytpgs
         PlJoSYt5Y7tuByVhIRCTRiafdZynoODg9T9ov3ecjA5zg3kvM2N5ozWgn9V2ArWZi01d
         7wsSqXw7beFWUkoYGrgTrh/YyankYCX5ZHaJEiEet6lo8gnU4AkA37BW+6m7FURfvbk/
         lp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767642956; x=1768247756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iog+hYgLiZRC3g3lYFmRjl8SBSTmMSwxCWcvManxv3I=;
        b=XIif4NXHzTAAwfd9xP1FsWhulZFeR7ARKoydnTuoxZ2GoOQbOIdciS7N2/RgvL7f9C
         4kIlWpjap2n0wqFhZuYaeQnSN4tNrjIvddoSc3MlOALeMLWumOccjSIoxSVlMvIyFPWP
         D9/TDxorV/6mPZw3Fal2lXiOrZd0oXUnB/C4TgHxu7/k2qzsdia3fXeoG4LLXbrA38uS
         W/K1IJ+oW80mICzgvVUzjuTYkZzGpHX5Obr+d1Ih4E+9/rLd2PTA5bcTuZI0WvyhASV/
         0MGcy3Gnlw5a5Xsh5R3yhM/t9W6hmcdZFhrUkti/arZ0DmW8T0R37ByrBKkGgXRY2VRB
         wocA==
X-Forwarded-Encrypted: i=1; AJvYcCVlDJgU0wJhjTNINiN+JhRkae6KOT7+a+1VyO2WuXgDX5ilqTvEORYm0YkxVEwqBxECFzau6lRdCuS2SrS6@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+VaJ6wONnrFi1OxNczk+f39Q5owPw5wA4Ytv+I+KozQKcUGRv
	56z33YFTBsjpO7QAg8Zw6BwMwaSGIE+WwbJf/3fwf0znpDWxwSUQj4UQjUok5Tp9uLanqIt6LEY
	5/UZlgbVcGlZqiKkIO2tMG1sZRa6aoBw=
X-Gm-Gg: AY/fxX5t5IwZtjpuiJhR32tCXU33ckC3prqntbKRkUs4u2kP6ar6An8nWlKgNEgoxbw
	8yjphJVERM739pkajeIXhnqexAgRzwI7FM7zmeft+MsAFshbk+zB8kSDXlt4mJUz5QJqg1MjmDz
	hGMobYOqpPtYR1S4duCejoFIzgCYW+Cv9csH7fPbQBo+2QLncgf9EPIb7kSPIsToqLr3eFwnYBm
	jklPamL3NtyZQJfqJ+gJy1WEOfozrzYaV3G/OFUNwliGrSI5lLX8OiC01lYaJqKk7M9cg==
X-Google-Smtp-Source: AGHT+IEcXiL8f+s52fan8QBIB8gC3RmFY4+fpmlXK2z6PXVY35c7s9hfXufUtxNhmOF/muXn/qtrDW/8Z7clxD7o+HI=
X-Received: by 2002:a05:622a:198f:b0:4f1:e99f:7d74 with SMTP id
 d75a77b69052e-4ffa76d7eb2mr10837171cf.12.1767642956158; Mon, 05 Jan 2026
 11:55:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215030043.1431306-1-joannelkoong@gmail.com>
 <20251215030043.1431306-2-joannelkoong@gmail.com> <20260103100310.7181968cda53b14def0455b3@linux-foundation.org>
 <9f9343f6-c714-4d2f-985b-e832c6960360@kernel.org>
In-Reply-To: <9f9343f6-c714-4d2f-985b-e832c6960360@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 5 Jan 2026 11:55:45 -0800
X-Gm-Features: AQt7F2qxuG4z8c8Qm515xNGzMMbs8p-UQIVayICF-AA8ax8cqWJEnRx16FYQQIw
Message-ID: <CAJnrk1YhqsoNGFocqbDhbU00c1ZZCqGrDVDf1ZCFqubPLQH4qQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
 in wait_sb_inodes()
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, miklos@szeredi.hu, linux-mm@kvack.org, 
	athul.krishna.kr@protonmail.com, j.neuschaefer@gmx.net, carnil@debian.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 10:54=E2=80=AFAM David Hildenbrand (Red Hat)
<david@kernel.org> wrote:
>
> On 1/3/26 19:03, Andrew Morton wrote:
> > On Sun, 14 Dec 2025 19:00:43 -0800 Joanne Koong <joannelkoong@gmail.com=
> wrote:
> >
> >> Skip waiting on writeback for inodes that belong to mappings that do n=
ot
> >> have data integrity guarantees (denoted by the AS_NO_DATA_INTEGRITY
> >> mapping flag).
> >>
> >> This restores fuse back to prior behavior where syncs are no-ops. This
> >> is needed because otherwise, if a system is running a faulty fuse
> >> server that does not reply to issued write requests, this will cause
> >> wait_sb_inodes() to wait forever.
> >>
> >> Fixes: 0c58a97f919c ("fuse: remove tmp folio for writebacks and intern=
al rb tree")
> >> Reported-by: Athul Krishna <athul.krishna.kr@protonmail.com>
> >> Reported-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> >>
> >> ..
> >>
> >> --- a/fs/fs-writeback.c
> >> +++ b/fs/fs-writeback.c
> >> @@ -2751,7 +2751,8 @@ static void wait_sb_inodes(struct super_block *s=
b)
> >>               * do not have the mapping lock. Skip it here, wb complet=
ion
> >>               * will remove it.
> >>               */
> >> -            if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK))
> >> +            if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK) ||
> >> +                mapping_no_data_integrity(mapping))
> >>                      continue;
> >
> > It's not obvious why a no-data-integrity mapping would want to skip
> > writeback - what do these things have to do with each other?
> >
> > So can we please have a v2 which has a comment here explaining this to =
the
> > reader?
>
> Sorry for not replying earlier, I missed a couple of mails sent to my
> @redhat address due to @gmail being force-unsubscribed from linux-mm ...
>
> Probably sufficient to add at the beginning of the commit:
>
> "Above the while() loop in wait_sb_inodes(), we document that we must
> wait for all pages under writeback for data integrity. Consequently, if
> a mapping, like fuse, traditionally does not have data integrity
> semantics, there is no need to wait at all; we can simply skip these inod=
es.
>
> So skip ..."

Sounds good, I'll send out v3 with these changes. Thanks for the
feedback, Andrew and David.

>
> --
> Cheers
>
> David

