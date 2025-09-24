Return-Path: <linux-fsdevel+bounces-62675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AB5B9C655
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 00:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C65174FBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AE227FD7C;
	Wed, 24 Sep 2025 22:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwoJgO5e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F92027FB3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 22:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758754596; cv=none; b=jbfKdi9GlIMQlM+bKtHUs9yiFNgPbrvwSU5QFa/GoNJIck91IqsJd5ZZpRibkA57lX/aWgi9WGpwL0ZEKzv47OOET//bakyJAcrkM059JOBGDCXl1zhgGSGfNQTYpXX077CUo0WOnB3EC60kwtPWXjH7GCoMpj4UiEn9C4Si/ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758754596; c=relaxed/simple;
	bh=Op6DNkPC6eHPtYfufa74RLj648Tv43squgVRXyUVfnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LhvJbCdzQ8cnDI2WOyNkC+aXjHH6L2wEvn3jVCaxDxI33hvI6ScpjmUgezWVPcnuffcYU5KbtL2ogX0lppq20Bj22KrkV9A5WH3jlr8tTighYbnZx4iN4HCAgqsaY5p7uh03Zwq/cdlIEzWhbIkbZGhAwpxkpc57y/EGvXtQiBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwoJgO5e; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-858183680b4so49285885a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 15:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758754593; x=1759359393; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5B+Zh9yFHo6Xolwu3opD/Diih25AjkCAs1FmMFIzwVU=;
        b=DwoJgO5e+q5F7FSQnVw9LAiWfS+IXaWOsio72wK7KbLl4ISRKjUKWy07k+nXoumPzQ
         XwUR1iAMvEtLk9bXe93Z0nYUkHLmCeDwoL7XZz7cbG9D1N+pIlemQb9QtmMtB1nt5u77
         Mh+V1jxeFH6GolL4b2keHNi6ezr5sqDw8BzVnAQOvzOc/T3F7rIXDoLGlnOx/nsEQi1z
         Etu0CMs2UtkLIf/vkt10+TVLDSuApGXSQOLfQyFUjfSTEfuDW10lmLYhJQQ9kAZYeecH
         LZeaUgCX4+dWu8NOJEdOJRge+zg4VTTPusdvjvQNo8tmcc3V53XSbytmrpulQML49EBs
         ENGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754593; x=1759359393;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B+Zh9yFHo6Xolwu3opD/Diih25AjkCAs1FmMFIzwVU=;
        b=Hcx+uE5jRb4U0fQHri23MVLEUXoi23cPtogApFeXCTnAmKtyZxjZYC+Y1cDjOAb/XB
         A6g76/kptyP+RpqZszThPLeEVn8+WNgvgdQQnWwbqAO8W/8fIx8cJjSl/bjS664KTw1Y
         es4igvq8wUOQRyC6LAsb7PI8Az+JAHGPFZB49wVxaun96wSnkKqgamN1aSDuxFWotDV0
         KqDH08jJaov3WVPn8lmwlOTz54quSZG0OQeijjPTcp3iMfckf7t70BcjB1DmHYmUk7mg
         2gYazHkgyN0Vd1Xq/6YbbrcE7WWCD4Z1Qw3Y2pRUo6ELNbIqQ+NgrYxBptvol2tvHjTo
         XK0g==
X-Forwarded-Encrypted: i=1; AJvYcCVlP2nL9IBtf8Qg7HLF4Kyo2H+1WChUZ7I3pzlVJm34472F7cejPs1oLyDQulZFy5PPcBsPXXbpeoerqnpn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+SVLZcyx+iZa+l9EPh4PPbw12HIWv86ZFO9Qz+1AHwVDZ+RFp
	MSmgVmt7UaXzhU2uaoi6MC6stUKIBUsFljfwVNTbiaj0CfgFytex9I+7cgszS2tgHTisex6NXto
	P9k87ZyUlvQkNXMO/DLXHwlVCQs6S6VY=
X-Gm-Gg: ASbGncsoBnmcwbbjWyiyNYfmvR0HN/tdIdIdW4Njwuf8lmDx/kvJVRR1xEYW+kEXprO
	3LmZZ47lQ3wyeEOxOAF7Z3mSePD/z6Aap5vIRi2rsi0TCbPHJzlZrR5LD5DMjUt4yZAJ7QnX9pj
	qyAO0gr3AF2Sc+xJgeEJCowy9IJ71IylIIic1lrwUZWSlw2L0FxbwvTmVxervJfcZHucAcYGU3+
	qGaOCAmt6htmbBx5xDDf2BjxLWY80eBD07pPjyW
X-Google-Smtp-Source: AGHT+IGzPzKs0y65h3LIZE6940gB4vV72Qyi3WZ6TBql4rL2B63TcdhnpA6Y4/6LPYw9/CuHLQab903G3U6TadwRTxg=
X-Received: by 2002:a05:620a:394f:b0:82a:5c45:c625 with SMTP id
 af79cd13be357-85adec4234emr191180885a.12.1758754593415; Wed, 24 Sep 2025
 15:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916234425.1274735-1-joannelkoong@gmail.com>
 <20250916234425.1274735-11-joannelkoong@gmail.com> <20250918223018.GY1587915@frogsfrogsfrogs>
 <aNGWkujhJ7I4SJoT@infradead.org> <aNG3fnlbJhv1cenS@casper.infradead.org>
In-Reply-To: <aNG3fnlbJhv1cenS@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 24 Sep 2025 15:56:21 -0700
X-Gm-Features: AS18NWAkh7IUvbVhGBD_bsGuTPZgO9EW5ULTCeoQsEee5-TykTnYOZdbSiLkTe8
Message-ID: <CAJnrk1ZoZqnX8YOBJBnNpr65FpMO_wNJBg42NCAiB1_c+Zr-ww@mail.gmail.com>
Subject: Re: [PATCH v3 10/15] iomap: add bias for async read requests
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, 
	miklos@szeredi.hu, hsiangkao@linux.alibaba.com, linux-block@vger.kernel.org, 
	gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	Ritesh Harjani <ritesh.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 1:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, Sep 22, 2025 at 11:33:54AM -0700, Christoph Hellwig wrote:
> > On Thu, Sep 18, 2025 at 03:30:18PM -0700, Darrick J. Wong wrote:
> > > > + iomap_start_folio_read(folio, 1);
> > >
> > > I wonder, could you achieve the same effect by elevating
> > > read_bytes_pending by the number of bytes that we think we have to re=
ad,
> > > and subtracting from it as the completions come in or we decide that =
no
> > > read is necessary?
> >
> > Weren't we going to look into something like that anyway to stop
> > the read code from building bios larger than the map to support the
> > extN boundary conditions?  I'm trying to find the details of that,

Doesn't the iomap code already currently do this when it uses the
trimmed iomap length (eg "loff_t length =3D iomap_length(iter)") in
iomap_readpage_iter() for how much to read in?

> > IIRC willy suggested it.  Because once we touch this area for
> > non-trivial changes it might be a good idea to get that done, or at
> > least do the prep work.
>
> Yes, I did suggest it.  Basically, we would initialise read_bytes_pending
> to folio_size(), then subtract from it either when a request comes in
> or we decide to memset a hole.  When it reaches zero, we have decided
> on the fate of every byte in the folio.
>
> It's fewer atomics for folios which contain no holes, which is the case
> we should be optimising for anyway.

I think we can even skip subtracting when we encounter a hole and just
tally it all up at the end if we just keep track of how many bytes the
caller asynchronously reads in, and then just do read_bytes_pending -=3D
folio_size() - bytes_read_in to offset it. Actually, looking at this
more, I think it must be done this way otherwise handling errors gets
tricky.

I had missed that this approach leads to fewer atomics since now this
gets rid of the caller having to increment it for every range read in.
This approach does seem better. I'll make this change for v5. We
should probably do the same thing for writeback.

Thanks,
Joanne

