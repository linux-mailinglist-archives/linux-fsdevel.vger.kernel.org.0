Return-Path: <linux-fsdevel+bounces-49022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DDAAB7942
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 01:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76151BA4491
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 23:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2AE225A32;
	Wed, 14 May 2025 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDAvHWcy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DFA224AEE
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 23:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747263607; cv=none; b=B/p+mzlLCYAE9MBg80GcozhwNiijEsRFpFKED9dp7ggynemx2EXvBgli6HC108JQvsBgagNvSvzznwfxJTlxIow/4xRlHbryK37n3r4DNmjAfHEM/pxD7pffp6KMQsHAR0zCF6PeTOdAQGVKrfK4eahGCg9RCGIOTUk9VSlXyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747263607; c=relaxed/simple;
	bh=aIoHuLwjAoryXNuxDClBkhCgD+6ULYLoMAJNKaRzcPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4aWB9NsvogXNj+fx2gXhJ23LZp0riMxR42jpSOMLCRyV2xV9xGW8giihJPj3NQK/FDcFqGp+FjsqiUcDOvRca7/RSVxxQnMCHbdF1lUViaCKkpU7wjUPwuyn/YR3ACzJp62otuL8A5YuAO3DLXpsjIAFUtAv7XS3LBnivcCkHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDAvHWcy; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-48d71b77cc0so4821491cf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 16:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747263602; x=1747868402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mr/QOzsgrM/IXSl7ATss9Wo0jHsH6ZYdQ54iTejq6E8=;
        b=dDAvHWcyLEENyOYr2f2xHdF9vh9p9QedibKZn/rrGfy0aqAEjImiHYrSz42Sa+Vkcy
         mAfAlgo/nssNC2K5vehEvd1mSw2FwrLmg4zmRmUgG9ezuC11dcBueQtl12bbvwubB4mw
         qriQFmOxH4oqKYecSYPtAMXeC8p8HfP3WByTAGmeWD6V/NpawjHXRzgrr+BzpMc+2D+c
         hYmQOCXO5LfeXPD7T0EKXw/u3iZ6LLhOBq1B0CM5swU4cFZ9Kj0zC0US3uSPoMJFxdox
         0+154fQ8eZl0CGvZFu07VQdrhQiUzUyIyfeBSqQ6yprFh1Bf3RNzpWeQseCM2xYSQ46I
         +k+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747263602; x=1747868402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mr/QOzsgrM/IXSl7ATss9Wo0jHsH6ZYdQ54iTejq6E8=;
        b=g5xRbB3PjtSwt9J/+9RwmsKcuJjycKx/fBgQZa72VmD3abLLHHCEvTcurMxQLss8sh
         vXsHuYGcxIncMICbmQfr9D3pNopq+995IbjGqkRNk85D0dLalWdIS6EXXoSnZGZWSLnZ
         8oRTPvV15s+9eLQKTYcRFLQ+vDz9ZeEBP42O94hE7o/EKZEte1Ci5ys30gPZv0MtcxkN
         +4I68V1CeB5uhjbhDIs9/bTiU98+BftdsUGs5ZPmxM4qpKIY2D7/gIUa+8DD50jrCksJ
         rdPb8dh/NfnxxSqx75FOkoGifi5UpGfuhnheT1XKbWUYXL4ItstRdfXtxL/aZxWNfi3j
         AqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr8l5wfriXR1jESNFpqVIVx2S/23gRV0mO3DPaIvHAVSW210HwbmVpYm517EBBRWDYMktvzTDo6yhfDQCc@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7tVfv8olKKSHuYkmHvzCFgt6ALnp/ey1Vg5nVrrfHPadhnGWw
	kzxiLH/3MN5a7wRfSbpLh0sXqtS9Evw7Ng3S+qP5rprutuIU6PEOBMLmYf6W7CRWRvr9D1h0ePN
	wIcLPeZRfSSrA1lQ1P+XTXcFmQck=
X-Gm-Gg: ASbGncuD8DtDGQWNj679h7vDnSesE8sTp/Y/i96ldFCg8duE6hInfPoKS/xuOQFWAfN
	TddaSI/uS2pa5bnpY9/CPCjVc04zaak476FsAHt510XEwP/8O4/uBgPgEkv288TeqG1d/QSO/2H
	ni7xirlpwHmGnG2yRh7Ztwedptfvp1kT9T
X-Google-Smtp-Source: AGHT+IFSJyWwVSsVaFw21oFQqw0bGimGx7awcnHcRsiimxYTuT1e6ePEELXWkmu/vGi9hDCmF+yRuljsXWzSukih6Mw=
X-Received: by 2002:ac8:464f:0:b0:494:993d:ec35 with SMTP id
 d75a77b69052e-494993def2emr46126731cf.12.1747263601681; Wed, 14 May 2025
 16:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512225840.826249-1-joannelkoong@gmail.com>
 <20250512225840.826249-2-joannelkoong@gmail.com> <aCPhbVxmfmBjC8Jh@casper.infradead.org>
In-Reply-To: <aCPhbVxmfmBjC8Jh@casper.infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 14 May 2025 15:59:50 -0700
X-Gm-Features: AX0GCFuu3zuYwQbM9NTybwv5KS8nDMmQOWFmyjuT35XaE4hUzXVc8KwIShUSQao
Message-ID: <CAJnrk1baSrQ__HxYDv99JpZr4FtXKDrjFfEw5AoUfVnM4ZJMNw@mail.gmail.com>
Subject: Re: [PATCH v6 01/11] fuse: support copying large folios
To: Matthew Wilcox <willy@infradead.org>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, 
	bernd.schubert@fastmail.fm, jlayton@kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, kernel-team@meta.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 5:18=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Mon, May 12, 2025 at 03:58:30PM -0700, Joanne Koong wrote:
> > @@ -1126,22 +1127,22 @@ static int fuse_copy_page(struct fuse_copy_stat=
e *cs, struct page **pagep,
> >                                       return err;
> >                       }
> >               }
> > -             if (page) {
> > -                     void *mapaddr =3D kmap_local_page(page);
> > -                     void *buf =3D mapaddr + offset;
> > +             if (folio) {
> > +                     void *mapaddr =3D kmap_local_folio(folio, offset)=
;
> > +                     void *buf =3D mapaddr;
> >                       offset +=3D fuse_copy_do(cs, &buf, &count);
> >                       kunmap_local(mapaddr);
>
> kmap_local_folio() only maps the page which contains 'offset'.
> following what the functions in highmem.h do, i'd suggest something
> like:
>
>                 if (folio) {
>                         void *mapaddr =3D kmap_local_folio(folio, offset)=
;
>                         void *buf =3D mapaddr;
>
>                         if (folio_test_highmem(folio) &&
>                             size > PAGE_SIZE - offset_in_page(offset))
>                                 size =3D PAGE_SIZE - offset_in_page(offse=
t);
>                         offset +=3D fuse_copy_do(cs, &buf, &count);
>                         kunmap_local(mapaddr);
>
Ahh okay, I see, thanks. Do you think it makes sense to change
kmap_local_folio() to kmap all the pages in the folio if the folio is
in highmem instead of the caller needing to do that for each page in
the folio one by one? We would need a kunmap_local_folio() where we
pass in the folio so that we know how many pages need to be unmapped,
but it seems to me like with large folios, every caller will be
running into this issue, so maybe we should just have
kmap_local_folio() handle it?

Thanks,
Joanne

