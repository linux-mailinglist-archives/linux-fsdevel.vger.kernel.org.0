Return-Path: <linux-fsdevel+bounces-52953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47218AE8ABE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 18:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEE3A1C25FF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89A2DAFA3;
	Wed, 25 Jun 2025 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDq3wA9Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A072F285C9E;
	Wed, 25 Jun 2025 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869885; cv=none; b=eeQojDwyAgGyrNOABOgWnFYXWEV6RTkwUsJwrWt9qtCUgyLG+Ltfbw+1l2ALMc7ebNfQdhVrnQgggkgCRd8HPsm+tOxX7gMPbfe3Tki6ggbWupvqIvcFMKNsfSx8hGlC5KDKSRaIoMlgcv1oGHtVLRdjAuYan/DdIleZM3CsGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869885; c=relaxed/simple;
	bh=Xr9CsPOp6WcYt9Kq4OQjxQmD7ucdPm6PZ/Br4gkyjdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3oDglcvCm0gvWIqe+KAYFD47BtrL9aq6T3x3jAElH0Z2CNFnvVq1UZnYocKmqCOGKPQU67qLD4E4ABA8WbqrWW2DNWmqPOJ1Wd3RINNq43f6shm6bD1OWpSGJc8dERjIpYWsQV/YlQKqh/Hm7PCALPmrmDW4KC0wER+Bwb0r/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDq3wA9Y; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a44b9b2af8so931631cf.3;
        Wed, 25 Jun 2025 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750869882; x=1751474682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARfY5zPdbMWR4dmRIiBvFi5s9kvzkJcvkpzDRoJBEK0=;
        b=kDq3wA9YQKIauXuSci6EGrPMlaXNLKmnMRxd1X7WcDPTz/+V5Mugd0astdO4UIrN+7
         tu0dKhqqoNgVNJliVCMW8jAAC6JtzrUI0LwCrLgPws7V8o67QwmhkMUTNbLFUyNx+oWu
         N8nLq/rVjYUT8oIZLumrmISjwH/AHaJgdx8TuUt+MTiuGSTFJzFuLvRo0jyobplkh9cD
         MZq28SYUZImUdy8RxOHMiYaitJvOcv6Od9+NL45Ynx0RoYnly5TURnUKSKi0UxF4MCyA
         xk51dYGYw02G3rcqlGggNos34mdfSf5MecWku9PNaiiPbS4oufplJ1Fttx7egwDSUSit
         hWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750869882; x=1751474682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARfY5zPdbMWR4dmRIiBvFi5s9kvzkJcvkpzDRoJBEK0=;
        b=NmiDc/t2XzPqZOUGNtcb9WWZY4Ej2sd8OKDsPfmIvqPTfci4ByqvDimoAIF/Ht5zMc
         VkSQKhZ8FD1dlULhD4Aec+84LPM5Oa+nZ9jYTT3PFO+VwhhyaZLVCbPF8l/mxK8QzuhY
         PV3fmXAounp48eSoppBPbUrRIzeNjFVRZbPb494uM7uItfq4U/eM2ppyK81SaluHCDHD
         zVkqCf37+cCHix+JpmFuEOvige3/wQQ8Qd6ZybSDoNHiP4ro4gEA44znhW5YFPuHLr8T
         qazOTij+bltK+m3EMTBE3UMbcdlOxBCIWBdZuZWag5DsHPRYCHCnyIExM0jZgg6gdK+c
         lz5w==
X-Forwarded-Encrypted: i=1; AJvYcCW6lEWNw2ZBA17+ladNSlyk9E8ES48xp57L8dP5cBOdpJ5dermh85LWlCXW1PLf692gxcn6H4GO7TZu@vger.kernel.org, AJvYcCWljiwvJBOGbLJ7gPpLjF1Gm3jnXSblEyDPs7owMLnPCaXqwnuOwVDXo/cAfQO0Rfp7YPVEgpvOo80IPw==@vger.kernel.org, AJvYcCXqe7k99AekvRFzdfIn9CCFmK7uNCsWELWmGIkLKAdXudIimGZbheYc4te/fNad0LX1yxIXCV8UfoPT3ZkGIg==@vger.kernel.org, AJvYcCXtahdHXuq7sf0tZCkDPH7HakmITHpuqxUraVtCyLXLd7tHt5kqo+BKw3NAZZq3EAJ7taGN8Q/T+inZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhdE1dhWvcW3Sb9+ScRtKPGcFyUOzSvVfPIL+oV4sp1qGLP1dY
	2BEULeAy24lclvGdT4mBWwRvRckk/tISkeRIThIyNRempzaw4Lkfas4H6ptKiDotG7/rKjO5NNo
	Gn+9zWPfeMC5ulbVeeFHrJw/UVH6EnjQ7hxaHfms=
X-Gm-Gg: ASbGncvdUUefheonC3O1+6gSkQQ0yLTrT1dmKohn+LDRdOMmln2806RJ+wJ4GwUlbgK
	MdEbRehcVn8wKer3F00KJuT2YBv4JHdytnGMsQC1WUwIO5D8dxg2zJqmZiCO7wn4JyYUBopxXKV
	9iBlY9262RXSPrtuODR0KtSsyo1phtKKOm/BR88S7Cbflm4kLHgo58CpWmpdgZDpCPAVsEYw==
X-Google-Smtp-Source: AGHT+IEt1TZjaS3R5h67itrFgkyntPJUD/CIMKEaOvyxiUhcZBapd1BPlkAKLlT0ccLQcSXu/Z+jtrxAl9OMK4WdDic=
X-Received: by 2002:ac8:57c1:0:b0:49a:8542:b496 with SMTP id
 d75a77b69052e-4a7c07d54bcmr54002001cf.25.1750869882315; Wed, 25 Jun 2025
 09:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com> <aEZoau3AuwoeqQgu@infradead.org>
 <20250609171444.GL6156@frogsfrogsfrogs> <aEetuahlyfHGTG7x@infradead.org>
 <aEkHarE9_LlxFTAi@casper.infradead.org> <ac1506958d4c260c8beb6b840809e1bc8167ba2a.camel@kernel.org>
 <aFWlW6SUI6t-i0dN@casper.infradead.org> <CAJnrk1b3HfGOAkxXrJuhm3sFfJDzzd=Z7vQbKk3HO_JkGAxVuQ@mail.gmail.com>
 <aFuWhnjsKqo6ftit@infradead.org>
In-Reply-To: <aFuWhnjsKqo6ftit@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Jun 2025 09:44:31 -0700
X-Gm-Features: AX0GCFsfnY2NRe1Yl1NZniTcFCNWF9j0FX7uW-sdQQQn_7h6m7fdnADoW5ryf3M
Message-ID: <CAJnrk1Zud2V5fn5SB6Wqbk8zyOFrD_wQp7B5jDBnUXiGyiJPvQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
To: Christoph Hellwig <hch@infradead.org>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, miklos@szeredi.hu, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 11:26=E2=80=AFPM Christoph Hellwig <hch@infradead.o=
rg> wrote:
>
> On Tue, Jun 24, 2025 at 10:26:01PM -0700, Joanne Koong wrote:
> > > The question is whether this is acceptable for all the filesystem
> > > which implement ->launder_folio today.  Because we could just move th=
e
> > > folio_test_dirty() to after the folio_lock() and remove all the testi=
ng
> > > of folio dirtiness from individual filesystems.
> >
> > Or could the filesystems that implement ->launder_folio (from what I
> > see, there's only 4: fuse, nfs, btrfs, and orangefs) just move that
> > logic into their .release_folio implementation? I don't see why not.
> > In folio_unmap_invalidate(), we call:
>
> Without even looking into the details from the iomap POV that basically
> doesn't matter.  You'd still need the write back a single locked folio
> interface, which adds API surface, and because it only writes a single
> folio at a time is rather inefficient.  Not a deal breaker because
> the current version look ok, but it would still be preferable to not
> have an extra magic interface for it.
>

Yes but as I understand it, the focus right now is on getting rid of
->launder_folio as an API. The iomap pov imo is a separate issue with
determining whether fuse in particular needs to write back the dirty
page before releasing or should just fail.

btrfs uses ->launder_folio() to free some previously allocated
reservation (added in commit 872617a "btrfs: implement launder_folio
for clearing dirty page reserve") so at the very least, that logic
would need to be moved to .release_folio() (if that suffices? Adding
the btrfs group to cc). It's still vague to me whether
fuse/nfs/orangefs need to write back the dirty page, but it seems fine
to me not to - as I understand it, the worst that can happen (and
please correct me if I'm wrong here, Matthew) from just failing it
with -EBUSY is that the folio lingers longer in the page cache until
it eventually gets written back and cleared out, and that only happens
if the file is mapped and written to in that window between
filemap_write_and_wait_range() and unmap_mapping_folio(). afaics, if
fuse/nfs/orangefs do need to write back the dirty folio instead of
failing w/ -EBUSY, they could just do that logic in .release_folio.

