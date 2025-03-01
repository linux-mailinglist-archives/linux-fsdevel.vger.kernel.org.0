Return-Path: <linux-fsdevel+bounces-42886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5575A4AC45
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 15:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF89165A0C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Mar 2025 14:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938661E32DA;
	Sat,  1 Mar 2025 14:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b="lSlvFD7/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92F19D8A7
	for <linux-fsdevel@vger.kernel.org>; Sat,  1 Mar 2025 14:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740839675; cv=none; b=SXbZ+iu4AVpwmGDBZrDEQ3FZcsagBXo06FGkpyFcP4kICb+iTkqgOdRQVo2wALPCDMHuVOXD/tffHhMi/lYTUlvoSjQ1J1x++cnvHC3BrbZryMUlvVC7d5o4Qf8urN0Ah/lnQPDnjcMIlpagxQWWrvx7b/6BghKY7epyFBao3jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740839675; c=relaxed/simple;
	bh=tp6qxbDMAEWnkv84GCofiZINr2DVyFoMzihPdFT6EY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OluW6tGhmJC1Qf/dnkffM8I7rp8RwHnXK4sxdS5+XmQcQOKOM9/KKATxZLnbsGpEua8ZcLQihIigdQPOuB2kWqgydAt9H731iYLaVp4nCRwhuUL6LOdd0nP8UlKQgyvzaOKSM+w3FIrd+P9XEzS4HCNFYGDIGlI/LBblqR2e8qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20230601.gappssmtp.com header.i=@omnibond-com.20230601.gappssmtp.com header.b=lSlvFD7/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2fa8ac56891so5018262a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 01 Mar 2025 06:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20230601.gappssmtp.com; s=20230601; t=1740839672; x=1741444472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kRvL22zEpxH2EhNMGf6qrh+SBeflk+iuDbirlLHJ2Ho=;
        b=lSlvFD7/4nRVCBESxDmJ4AEWtgBMIlFgX80FhDn/I3i67lZyd79s1QfMmWbi147+fM
         TcsPij2NYE/iLLFQfu1rVem2yH9yz7IAZPDqWXm30EeLti+C/2MDeBgIU8GLiF1A0RHG
         RDILzzp4OriigdIEteWDlrVxn+LXAm9AsV+ZyPLcTuRjGJ5bYnPn60KV2lJoJLUVqfZ8
         oYdTitJyWYfDRMagBw9dkd6X+ZXVNfC3iIzKSZOckofItxQ5HZweSw8cPqZnE6D4xlmu
         rWPkol1c0s6Qma8kCjS06mTKRPPFuDv/iLdGcypJwmH8vjOfU6YV8kEqLo0w8pnGog7t
         +KJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740839672; x=1741444472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kRvL22zEpxH2EhNMGf6qrh+SBeflk+iuDbirlLHJ2Ho=;
        b=ha6I16Encsi7tP3JC3NmTAFEwg7U+Nhcby8XbPfnD6hNt1eeE0/u8LXXECkf3/CKlL
         X+TrKbkO5mpNcHM9NWHDRfYqTZMyYyfHtCHBNOA3oRAI1HrCvhXfhUmoBLjieyo4O2Gy
         BSMnqiTIdEsJR055XIDfXMOHcOy91Q36GT2RrS06+1rLO5xJZvy1Xq6+gug7ufCLdTXs
         pkSMT5MOfkPRuHhfmOprymb/UJgTYiqvNXmTr5TfWxBulV0my/az291TOhOdfS01sN37
         IBFbKejMGJYHc2GuaNPbO4n+aNYMcmdsaJEAbo3U1t7H0BLlu3FehxvzFqol7sXArg78
         m9OA==
X-Forwarded-Encrypted: i=1; AJvYcCXuPW4jT0X2yO+3zqla6gx92Cv0S5eHxIvusKytHI9MlTFDolr6LDrtGoQxot1zqitalcIfl6h3g/KQSycB@vger.kernel.org
X-Gm-Message-State: AOJu0YyzenNYMZb71c0UI7jGZGnPGZklv9nuGugxCS+b63s6OIVuaw8l
	AEP1jPdJUcLikmrkxrWeIqJg63Pf06HeHT/DL2ejlLZvcQfw1Azmrw3JkibjsBbdZU8MQeyAOTx
	0SkO/PK/mY67ovN2m6cxpPYx+xYmNvKnefi8WNW0DyTLJ5Hk=
X-Gm-Gg: ASbGncvaQgcyh92YbrHZV3Rq2TcEtDJYlGXaB1R6TIquhVkcVCj3fTrtm959xciDtTP
	b1TvgZRHJTSWqbhF3vxwismLwVvFzNUQQq4HI6vWD2DCqrijAboCsNdIjScbxSNY9BLaPWrPL36
	7EaFchJ3j/BM/F43p2JJCWsz7dBI9zdIH9uiOcrA==
X-Google-Smtp-Source: AGHT+IG2MDZpDQqNkppDXUSzX4Sjtf+ED0oQh7rhEBC8yZ8/cdt3wYjqVBsvqKAyrFOW5m102lktBHFvZoMzrkowF8o=
X-Received: by 2002:a17:90b:4b4e:b0:2fa:ba3:5455 with SMTP id
 98e67ed59e1d1-2febab2be02mr12468480a91.7.1740839671014; Sat, 01 Mar 2025
 06:34:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224180529.1916812-1-willy@infradead.org> <CAOg9mSQ2o0zaBhY37bBfR9CDKv=-EY3SzxEh0mFYiNvEjZaZKQ@mail.gmail.com>
In-Reply-To: <CAOg9mSQ2o0zaBhY37bBfR9CDKv=-EY3SzxEh0mFYiNvEjZaZKQ@mail.gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Sat, 1 Mar 2025 09:34:20 -0500
X-Gm-Features: AQ5f1Jp9bivAtQbkUoP4gYt-35pWuI4JnGMaw3cJdHeXfMBUEDasgjZB3DOKLng
Message-ID: <CAOg9mSRbk=76L-kNhJAXgH3VJS5uipxY59ezO71DzFSCTk2KkA@mail.gmail.com>
Subject: Re: [PATCH 0/9] Orangefs fixes for 6.15
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org, 
	Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Matthew... Thanks for the patch. I get no xfstests regressions
with it...

-Mike

On Thu, Feb 27, 2025 at 3:18=E2=80=AFPM Mike Marshall <hubcap@omnibond.com>=
 wrote:
>
> Howdy Matthew... I got your patch and deciphered the note
> about leaving out the include files. It is compiling on top of
>  Linux 6.14-rc4 now, and I'll let you know how testing goes...
>
> -Mike
>
> On Mon, Feb 24, 2025 at 1:05=E2=80=AFPM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > The start of this was the removal of orangefs_writepage(), but it
> > quickly spiralled out of hand.  The first patch is an actual bug fix.
> > I haven't tagged it for backport, as I don't think we really care about
> > 32-bit systems any more, but feel free to add a cc to stable.
> >
> > Patches 2 and 3 are compilation fixes for warnings which aren't enabled
> > by default.
> >
> > Patches 4-9 are improvements which simplify orangefs or convert it
> > from pages to folios.  There is still a little use of 'struct page'
> > in orangefs, but it's not in the areas that deal with the page cache.
> >
> > Matthew Wilcox (Oracle) (9):
> >   orangefs: Do not truncate file size
> >   orangefs: Move s_kmod_keyword_mask_map to orangefs-debugfs.c
> >   orangefs: make open_for_read and open_for_write boolean
> >   orangefs: Remove orangefs_writepage()
> >   orangefs: Convert orangefs_writepage_locked() to take a folio
> >   orangefs: Pass mapping to orangefs_writepages_work()
> >   orangefs: Unify error & success paths in orangefs_writepages_work()
> >   orangefs: Simplify bvec setup in orangefs_writepages_work()
> >   orangefs: Convert orangefs_writepages to contain an array of folios
> >
> >  fs/orangefs/file.c             |   4 +-
> >  fs/orangefs/inode.c            | 149 ++++++++++++++-------------------
> >  fs/orangefs/orangefs-debug.h   |  43 ----------
> >  fs/orangefs/orangefs-debugfs.c |  43 ++++++++++
> >  include/linux/mm_types.h       |   6 +-
> >  include/linux/nfs_page.h       |   2 +-
> >  include/linux/page-flags.h     |   6 +-
> >  7 files changed, 116 insertions(+), 137 deletions(-)
> >
> > --
> > 2.47.2
> >

