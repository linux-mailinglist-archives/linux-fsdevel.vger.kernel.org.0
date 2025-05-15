Return-Path: <linux-fsdevel+bounces-49102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7847BAB80A0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A0DA4E08D1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4428B50C;
	Thu, 15 May 2025 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ecLGFvnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D17288509
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 08:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747297601; cv=none; b=Xy8pGMA8pZ1yVH0yyQazHgo515WfdoAy2Xqc1+cVRcqCrMIpwhqnMecWLyhm6uUxIWgBXf3hwWGJmirO9wbVo8iqQydVUqNLR81DToYOGKPa6UcPT+SaecNwHkUxuE4B18TqWr/t8efII3yjsDNAEL+J8GC73xbAlXTFo0hu/zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747297601; c=relaxed/simple;
	bh=f5df3IY6dN2TJtDgqDwt7ZdlqMXFMfIK8b2AhZXSmTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twYsQTHGzgUuFS+C1jn1gmsoaVaV59MyPJ+ucSpyBBRoZC8psx9HPoFBZywF09v9TxzZ9q0+Atn120YfJzWXmXlbmT1cc0t14lle059v+67FPaXkWgS0SXFjaoMtCHXFxJ+YcYPsoqo284cet1K9E6LV07S5l/BbGk6IZerNwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ecLGFvnK; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4775ce8a4b0so10974991cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 01:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747297597; x=1747902397; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wulgkI3JK6GmISK0rMvjKppUQX8lLpj9k4nVJkkWvsg=;
        b=ecLGFvnKe9LMj/uT/uHSvSI+4LAUYXDw+aCjFeaUEtwA8i2wqrHvTadg5c2xy3NFrO
         NtnsBj2C//NsBhg2SwAIV4FwDsJsy4mxohqOEW6GvN2qir60M9NlPMIjoeq6sbPScYzl
         QBV40joxQjJOFIIjbuDjG1KxKffUg7yFODxPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747297597; x=1747902397;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wulgkI3JK6GmISK0rMvjKppUQX8lLpj9k4nVJkkWvsg=;
        b=k1rkIQBbiLpJSOkB2/kB6fWPALcblpYJcXeNtuwrWB15OhdfT88zlbApRvW97VHe8F
         DyK699NOAxJkJ1Veo0aMgIyLVUrspc1C0Livg1Ncpf7hNK2/xtneuMsCNe3J3jY4bH3T
         7dvcmfpMEJ3c9p6F0g+uT1sSNk3UoYuDCXyewYqOWSZUb2l6hYVk5XpKOkMJfbLRfCsH
         u5Hh9q9YZQ+pUZzH2qxJAs/R5x+drLZPbUz930PPO65ZsimXLEFtjWRvV8uTlr67e0MN
         qBWLjJZZE/maz3C0b/FRu+GwpyltXeSSk6oiKll5CcR1iTy92AaVqdgq6m1YyjHMyVRJ
         7eAg==
X-Forwarded-Encrypted: i=1; AJvYcCWnjDW22sAoPwqpFIlH2q1beu2q9Zk4iBS8zW73Yo78w3hEmgUlJ0l/3JoV8PVmrX4/bCEYoSAxEeIYaCRi@vger.kernel.org
X-Gm-Message-State: AOJu0YyeL1cA05Xal+XT0Ew7IWBGQZOi3z1Cogkd3kknS5p9PK2jmBPr
	jSSoatUe1v0mKqzzt1FuLVP55de0sRu8e0vGW+onHSm4gW2EdL7We72FwC2SsPPZcMucwTW9S6c
	O2EvrRaZJ49cED8qHw/QakCWEnZ+GmTOZ5rDNrQ==
X-Gm-Gg: ASbGnctY6gSEsLcxVoRB1MrN/iV+l0KwT1bupSRI1jF2VQwscMmrqmDac0il4V+nJZN
	lAPLtPh2mpr8mbnTfz/98YFkepo1GE3HPCxtttMrce5DzLkgiKFCU5yYAj+aU9sWSoq0nMH6/g5
	AzDbTmtQl2TL3MNNOD0iE1DDLJcXEdS1c=
X-Google-Smtp-Source: AGHT+IEobZFIhFnGtAHUWFaM7iQ/KbcVL4NnbYleX2SJXy12mbs32r4HS2NFKu8ETRKW3ez6hy6s1XibR8NSIt1qm6c=
X-Received: by 2002:a05:622a:1f89:b0:48a:2a08:cbef with SMTP id
 d75a77b69052e-494a32bb34cmr33936091cf.5.1747297597489; Thu, 15 May 2025
 01:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com> <aCPhbVxmfmBjC8Jh@casper.infradead.org>
In-Reply-To: <aCPhbVxmfmBjC8Jh@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 15 May 2025 10:26:26 +0200
X-Gm-Features: AX0GCFuaR7AiFOfz4QimmqPTsABhhLMQ_3g9dYn_IK0756NBjPf5eRD4Bgpdd-Y
Message-ID: <CAJfpegtrBHea1j3uzwgwk3etvhqYRHxW7bmp+t-aVQ0W8+D2VQ@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jlayton@kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 May 2025 at 02:18, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, May 12, 2025 at 03:58:30PM -0700, Joanne Koong wrote:
> > @@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_state *cs, struct page **pagep,
> >                                       return err;
> >                       }
> >               }
> > -             if (page) {
> > -                     void *mapaddr = kmap_local_page(page);
> > -                     void *buf = mapaddr + offset;
> > +             if (folio) {
> > +                     void *mapaddr = kmap_local_folio(folio, offset);
> > +                     void *buf = mapaddr;
> >                       offset += fuse_copy_do(cs, &buf, &count);
> >                       kunmap_local(mapaddr);

Fixed version pushed.

Thanks,
Miklos

