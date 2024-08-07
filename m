Return-Path: <linux-fsdevel+bounces-25330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EB94ADFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4688DB211A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 16:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C14136E0E;
	Wed,  7 Aug 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="caXuQ8UT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119F512AAC6
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 16:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047900; cv=none; b=RAgPKGo5IWX9aycpYQruoEsE6WgbBuXnla1bgC6O5t9bgJ5v3pBm72dgiKiG+MABNAvaG53AV0qhbwgY0MgFXWqulgbuMZhhGeD/O2xm9CUv8gqLBcG6HL+asVHGtqRVyPJCwuYhcRBuMsaKKUULKryxdgLwA1bQ+3xArTFsWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047900; c=relaxed/simple;
	bh=6lPMOQH431GKWxLLmMbzAnj9XuawpFfji+CXA1tfKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1cVLtRgXXiIOcMlK8ZBoT92IgVHnnP/rTZwBfLyvp27csWY2VQOIXLp7/Cd/cwkuxzU/dOQbY2STgEw05EYM7k7xygcioFxyaJR4FVDfF+kwcepUBu/YMop/twmJ5t5p5NIVH7IWRxVcK8UCXPkBglQIjB6s007OPkBw5Els1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=caXuQ8UT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723047897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L0C9YfRuY1PQLeP1M6aYawPuUYOmUOGm2Mf6dVrGLnI=;
	b=caXuQ8UTPBL9Eqjus7yya+tWYEAS/QJA0qQMD8XksCgyn1JOHMgrrF82rg1lF5znQMcIw/
	gjAW5jKTEkgQmvJyM1ktr6s4jvTAm6q/63QjzgzWwWhvx/m43m9fGfP3bj6zClKY2GEFde
	3Lr2/04FOHXoe6NNcOi8V/N3Ye+Xma0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-BlMvfLYpOOGP_td5eeutTA-1; Wed, 07 Aug 2024 12:24:56 -0400
X-MC-Unique: BlMvfLYpOOGP_td5eeutTA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1ff24acb60dso316835ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Aug 2024 09:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723047895; x=1723652695;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0C9YfRuY1PQLeP1M6aYawPuUYOmUOGm2Mf6dVrGLnI=;
        b=bUpBfLUerOgOq1CWHdDtWTA6RaXkxVQXn+FuMUXeBxFb0gPelWVyW/nfZPE3lxG1Kz
         gXphPehvboyNaTKlRt3k6zmgWLsSFXeCqpBNl+f+azOxApYlWdLoVcLQQg+bos8ZNr1y
         aEn/h0MxHnrbcIaznHENFj/IuxM1qtm4kJhb6HNQ3Iq0zhylGVksv+LKGUViI5kXlE2G
         DAu9re1CgBwIqI092QJ8fGUanYinjKnEYuwUBxYuU+sVCFEA9hSeRxR5nAGkqgpvF1S1
         Pf2iheon3OHbC4H1OW5t+AvgoAgD58j6vKuNWSAB06xmYqZpPc/PRYMv1OuH+SzGjhuA
         xN3A==
X-Forwarded-Encrypted: i=1; AJvYcCXP0Ugm7N/t8EPd2HNYmoRocczpmS0sPMdP3clhhnlKIHHBvVl9pLlZs+tSmBaA70onhDV67BCB086PWyiH+IcdmX/TPFMBZzzqclvpPw==
X-Gm-Message-State: AOJu0YxSXwUcMFzyKjJbAPYKaiKkHTOCIAAq6G23QWJY78SSB0igCKqj
	ZEf5D1xXppTvKZ0e6D1+Enlk1Xav04I+xVUjcOY2bRvaGnqEmxY+HB/SaFoaY/Ctg3FX58fbIuq
	2vUcPaK2RHq2STRi90OyPmLzDAXxxr0qf0D8PFXPC1D+JiFnhpONAxAh0U47mEpoGYngkJPuO9Y
	D6h2ER5NMqlkLXsB+TQhn+H3/bdvWeVa929F8UrA==
X-Received: by 2002:a17:903:32c8:b0:1fb:80a3:5826 with SMTP id d9443c01a7336-200853e6263mr46329675ad.4.1723047895457;
        Wed, 07 Aug 2024 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmpmXkhAE5hUqLSQ0+2y7OvmcWYO6zPANJy3anj8AtdA79ZKNfIl9VuRJiROff7yJ5+Aj3W7cRzHoSavKmZmI=
X-Received: by 2002:a17:903:32c8:b0:1fb:80a3:5826 with SMTP id
 d9443c01a7336-200853e6263mr46329295ad.4.1723047894949; Wed, 07 Aug 2024
 09:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719175105.788253-1-willy@infradead.org> <ZrNm1gh6Fsm0tIil@casper.infradead.org>
In-Reply-To: <ZrNm1gh6Fsm0tIil@casper.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 7 Aug 2024 18:24:42 +0200
Message-ID: <CAHc6FU76ioJT4UDRPQNMZ94QOgs6ReuM2WUcSAD4irqERmGckg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Remove uses of aops->writepage from gfs2
To: Matthew Wilcox <willy@infradead.org>
Cc: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Willy,

On Wed, Aug 7, 2024 at 2:21=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
> On Fri, Jul 19, 2024 at 06:51:00PM +0100, Matthew Wilcox (Oracle) wrote:
> > Hi Andreas,
> >
> > Here's my latest attempt to switch gfs2 from ->writepage to
> > ->writepages.  I've been a bit more careful this time; I'm not sure
> > whether __gfs2_writepage() could call gfs2_aspace_writepage(), but
> > this order of patches shouldn't break any bisection.
>
> ping

Thank you very much for the patches. I've had a quick look, and it
looks like they should be working now. Testing still pending, though.

Andreas

> > Matthew Wilcox (Oracle) (4):
> >   gfs2: Add gfs2_aspace_writepages()
> >   gfs2: Remove __gfs2_writepage()
> >   gfs2: Remove gfs2_jdata_writepage()
> >   gfs2: Remove gfs2_aspace_writepage()
> >
> >  fs/gfs2/aops.c    | 30 ------------------------------
> >  fs/gfs2/log.c     | 12 ++----------
> >  fs/gfs2/meta_io.c | 24 +++++++++++++++++-------
> >  3 files changed, 19 insertions(+), 47 deletions(-)
> >
> > --
> > 2.43.0
> >
>


