Return-Path: <linux-fsdevel+bounces-56535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAB2B188EB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 23:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F123A5A0A71
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Aug 2025 21:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0EA21B185;
	Fri,  1 Aug 2025 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkhvV7JO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4191013A258
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Aug 2025 21:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754084863; cv=none; b=lqYP/JJ/UIPDFjeIjSus9k3PxTEqfy8w274OTC7snfC9QbU/I2MY5OJ899/PX/7zw8PdDiMr+Kxe7yRClSfa5ngCxVXXtwUdsnvWeRQcjmtTwfBBLEqpg5WcRgNP3KvfVcA3QmBqrOX7EpscDg+31ZtNqmrrmCBDuFe638YvQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754084863; c=relaxed/simple;
	bh=k157+JI1r22QvghvRDoSO0n3FR1g+DG1J4GSrZXyutE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNRZYWlHzPzIW38leaHFYzoNeaDzZN2tdpDEkiPic9GXQOomBVbC5YHfUY3y4XCzKBL3qCylQkz83zODTU52FXNiSQeYGbYamFP8J3dBpmjBQDTFkd1mAWo/2XNljX6dbRv7wnQ5ssSfZuaDPs1Y0OV6U/Yb06JIaHcRLxFHikA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkhvV7JO; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4af123c6fc4so4005351cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Aug 2025 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754084861; x=1754689661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzab8vfejFy6BGVYexdP79Amr1wH4zaNM7RRQ0cASzc=;
        b=SkhvV7JOkoxSTFM4pXbxzfldXJiwugqWvdX4/sXXS8vw/oSzqn49BWcCEoyRV6rNc8
         GpvVoI66SMtkvGYJzoIngomLsZfFQmr5k+3cxgJgkc7qco4GsSe89f+jWsP2PTwapxjL
         skNjllmet1af6NS0hvfOOp0UWsIPVLEYMljis4RIXjX5z5sHH7bhLG4E1gtitqprju4R
         9A//MYJECNfUb900WfZsfT+cXkzJYD68jg67td3sdgFhe94C9JLn5uodDp+S3Iz1GSIo
         qyynL891ncb1TsiON0E7Pv5xUktCMB9nTLPXty7qGQlAsgWbhcD4iBB/tzcWkNJp8P8Q
         t+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754084861; x=1754689661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qzab8vfejFy6BGVYexdP79Amr1wH4zaNM7RRQ0cASzc=;
        b=KZ3cAcSa3jwk71PggtUsRw7LgJbPIkKO6u4BnBY6EcFyAewcODqpPZ9bPjISodcxI2
         p8b7YFg5NMjycVqX2clDj5hJ4iPZg6m9y0q+WFhMbNdIBzu7zmM/9OED9B86S9PWUJL7
         e0BGXal3Wocsb4GYBUFyBId9fel1otv1OFwC0zEF9vVxMyNFpD5mBMecPyJGxSsDmlGn
         /524kfGdQQ6Bhddd6fJ0+p8/73CsikZc5n1YzXka3/CUbK0/X4u8bk+zGeGadagj/VAD
         Qa/XtssNX8/Mjm8PtL9ZANTTr1kNxirDmOGIkTcI1TD06Q7vsmGLqDZsNArNdc+0Cvjr
         hldw==
X-Forwarded-Encrypted: i=1; AJvYcCV04K8m6d6h1zh4UaGR8S6L8mT1cjoiVzFm91n3zdhavscNzIUVYzmK1yhz3Am8YQkLKgt7m/z6pJ4AluOh@vger.kernel.org
X-Gm-Message-State: AOJu0YykScoBu6adTOrMFFoSmxPhAk6L4euS6S8tlAK0kdqJzbTgNpFB
	eGaaz2cOgjOn/7DppgWCI3rq3R2w7d538zDQLWYRd8RF3B6eje0g1CmB5ALykqsXZsUh17ZpE5D
	TaMBzNQSYqad2NU1Pvz/aTTLxg4UxDG9Fu7iL404=
X-Gm-Gg: ASbGncuLLiGS/TmRjTwqIeMJLygbXT/9AbIHH0bPeisQQlZcfzcYp+jel6lfnv6WObu
	oz7vrIPSrcuIFcI8a04Q9uvFRih5fRUrIWBzDguPpa/ImQ9CqVmub/x/fELU315/uEHd3lOKqYL
	gmtzya7O1NINB/TteNfRRNpb+YejWPGixENT2yBWhXe/XnE/B44nmKLwT0BbuQy2sDzliySl3Np
	rGvhlGnzSI+S+61aw==
X-Google-Smtp-Source: AGHT+IF8Bkr7PS7/P+w37YpYpvkm4jMRLLF3escBy9onGRRvAuSm5oEUYJawRmHEiGCmm5CjW7kphVKyIhE0/EfAlgM=
X-Received: by 2002:ac8:5716:0:b0:4ae:fa71:9ea5 with SMTP id
 d75a77b69052e-4af10d11525mr19086791cf.48.1754084860965; Fri, 01 Aug 2025
 14:47:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250801002131.255068-1-joannelkoong@gmail.com>
 <20250801002131.255068-6-joannelkoong@gmail.com> <ghghf7cynwbmthtozlthggdscnmgvkmnq6s3gkcl4qp2zxubee@azmf2dxubund>
In-Reply-To: <ghghf7cynwbmthtozlthggdscnmgvkmnq6s3gkcl4qp2zxubee@azmf2dxubund>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 1 Aug 2025 14:47:30 -0700
X-Gm-Features: Ac12FXxaOUKnRnhsre2EUbUqbED2JQEbEAQrHEZ5LNAO58jwZ4eXF6jMaZEnX1g
Message-ID: <CAJnrk1awAjCY6HNp0F2QUEkA10O_ZABr_QpJ29JdzRGq7E0ffw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 05/10] mm: add filemap_dirty_folio_pages() helper
To: Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org, brauner@kernel.org, willy@infradead.org, 
	hch@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 1, 2025 at 10:07=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 31-07-25 17:21:26, Joanne Koong wrote:
> > Add filemap_dirty_folio_pages() which takes in the number of pages to d=
irty.
> >
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ...
> > diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> > index b0ae10a6687d..a3805988f3ad 100644
> > --- a/mm/page-writeback.c
> > +++ b/mm/page-writeback.c
> > @@ -2732,7 +2732,7 @@ void folio_account_cleaned(struct folio *folio, s=
truct bdi_writeback *wb)
> >   * try_to_free_buffers() to fail.
> >   */
> >  void __folio_mark_dirty(struct folio *folio, struct address_space *map=
ping,
> > -                          int warn, long nr_pages)
> > +                          int warn, long nr_pages, bool newly_dirty)
> >  {
> >       unsigned long flags;
> >
> > @@ -2740,12 +2740,29 @@ void __folio_mark_dirty(struct folio *folio, st=
ruct address_space *mapping,
> >       if (folio->mapping) {   /* Race with truncate? */
> >               WARN_ON_ONCE(warn && !folio_test_uptodate(folio));
> >               folio_account_dirtied(folio, mapping, nr_pages);
> > -             __xa_set_mark(&mapping->i_pages, folio_index(folio),
> > -                             PAGECACHE_TAG_DIRTY);
> > +             if (newly_dirty)
> > +                     __xa_set_mark(&mapping->i_pages, folio_index(foli=
o),
> > +                                     PAGECACHE_TAG_DIRTY);
> >       }
> >       xa_unlock_irqrestore(&mapping->i_pages, flags);
>
> I think this is a dangerous coding pattern. What is making sure that by t=
he
> time you get here newly_dirty is still valid? I mean the dirtying can rac=
e
> e.g. with writeback and so it can happen that the page is clean by the ti=
me
> we get here but newly_dirty is false. We are often protected by page lock
> when dirtying a folio but not always... So if nothing else this requires =
a
> careful documentation about correct use.
>
>                                                                 Honza

I think races against writeback and truncation could already exist
here prior to this patch. afaict from the function documentation for
__folio_mark_dirty(), it's up to the caller to prevent this:

 * It is the caller's responsibility to prevent the folio from being trunca=
ted
 * while this function is in progress, although it may have been truncated
 * before this function is called.  Most callers have the folio locked.
 * A few have the folio blocked from truncation through other means (e.g.
 * zap_vma_pages() has it mapped and is holding the page table lock).

The documentation doesn't mention anything about writeback but I think
it applies here similarly.

I'm happy to do this another way though if there's a better approach here.

Thanks,
Joanne

> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

