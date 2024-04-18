Return-Path: <linux-fsdevel+bounces-17220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4778A913E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D3E1B21C80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022414EB4C;
	Thu, 18 Apr 2024 02:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnRP/WzU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FA854672;
	Thu, 18 Apr 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408185; cv=none; b=GbxO5ISq61dsF10sr8LGpGCEwlSDe5KuKTpePvxlNAVhiaFkMz4m/XlQhTQxWd6odgTkRjwGWj2MQe7/V3qns23Tfyi72v9Sk44LoYJ+gpiCZ0v3W0pelqiFHg6ziEOAOJuSwqPQpYLD+EG1FSRGyhZMFOjlhfW4Evt0GfwhlqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408185; c=relaxed/simple;
	bh=Uxd1qPAx5E6F5mJHBCGrEZTgf0AAm5zPYB/SG3EV6QQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z1p45+9jbG0tuj16J32xxuXE8p0ZZzUgMWdhC8yflwb2YBkC6HVb0qGlXsygXQx/pFEtua9Ajqyg8jZ+M5vfb7MnWqa2RU3+TsUD/II/ZtwzmYJKHd4DxlPGTucjTD0ZIwrlY3CT4TA7Z7PFjnkLChijfJL4hoGlT2OukHctXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NnRP/WzU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so5093361fa.2;
        Wed, 17 Apr 2024 19:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713408181; x=1714012981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHdJ1IEQUe90imoIzR17oc110KfFYytLZPC+x7YJWuU=;
        b=NnRP/WzUyLHebsMbBGqFaPueYZubEnyVZEvNk+woBCt1J65HHmUp6TQNnXXC9NiEJm
         jzfZmHx2G352qQVb6xCcbteqtCBGr35szRbAa8vQkpjKkqhS6q/tRaltIDGL2Tl2snxO
         CABw6ldPN/iDR6i1J7l+BbWanJXNMuZUNg4MwG70zOWq8ZGP6uqsGx0PQ4w4v1V1fKvS
         BuFKKbnNA53KeFJ+xKl+C5zd5yRnKabmo/9qxmhyIjI8q3poIEC4AvBoun/EwbhkKR46
         1Y3NOM2vmtt3w0rIPxB7C5yFW9qksfbEzjk8hbdcuyMScsVPsfOOr5bJKK5NzD9rh7o9
         gleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408181; x=1714012981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHdJ1IEQUe90imoIzR17oc110KfFYytLZPC+x7YJWuU=;
        b=YDscnnzYoO5U1Ug5oeprhvKw66zaa1nv/OKsveSRnWAuqrmqaHUdwLPhNUVqJ7y11T
         oAz3ATQrI3+G3HuzIOQFt9MITBQcxlI6YHty+loziL820EIPdtdhJ1bs9xY83p34G6xE
         3FwFFDjJoRFSaiSVw0n7WpS4FEI0jO+ZrE7xywJ8olqLpxyXa/Hmkp/TMx9kLvmNcjot
         Xxc812oQQ8Icdj8vSy79thWNpK8k1Y5caTzPXHTH9xA5wC0PEHpFnne0rUzDLnOwkxTe
         oILuETG4mxssBDZHRCmRh4c+6WFH82aMJQhMx19sCuQMYM27qNv7Nn4h3DLd0se3/ufe
         GyVA==
X-Forwarded-Encrypted: i=1; AJvYcCVgujcg/Pd5qy+jKtg1nPoHGKIB5PjUmO/xKqrlJrWmsywPRVjUiR1vAcEzKeqHPllH4L7tu2pJVNEol0bwUQgyhf1yebeY4A/534kRy3nLoD/SLLUjINo2VmN0gVMu/sWwtrCHzVgVnzMFp7EVDoFic4REcMTV58ffMtfPy4DVDh3kabsEuKAR
X-Gm-Message-State: AOJu0YwEHdFwmVp2Mhpbeu4AGUfLPr+yI17xYy73AG7noYcYhJK6EGjf
	vHtOHtcjKJrfTim9RqoxPv7NYeKpoQQ6OR7a43wMl3valothC5Twsi6Y+MoHhjgXTPNZ44fKO5Y
	4C2n7ryvpeRtqFisyBFQIc2/wqvc=
X-Google-Smtp-Source: AGHT+IFTCKTPAyg4nwsmNHIvepg/We0wTvwYE5mzO9dl8NADN2aVUyszysFamFq45vti2d+xPYdRpaL2zC0wX27sKm4=
X-Received: by 2002:a2e:a986:0:b0:2d8:55f0:476b with SMTP id
 x6-20020a2ea986000000b002d855f0476bmr713852ljq.23.1713408180752; Wed, 17 Apr
 2024 19:43:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-3-ryncsn@gmail.com>
 <Zh_1TdrwJcBeALIG@casper.infradead.org>
In-Reply-To: <Zh_1TdrwJcBeALIG@casper.infradead.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 18 Apr 2024 10:42:43 +0800
Message-ID: <CAMgjq7A=B-jczrPnJn-4j_WX=wnNB42WpmGazkCZ0-QPBm-4AA@mail.gmail.com>
Subject: Re: [PATCH 2/8] nilfs2: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	linux-nilfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:14=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Apr 18, 2024 at 12:08:36AM +0800, Kairui Song wrote:
> > +++ b/fs/nilfs2/bmap.c
> > @@ -453,8 +453,7 @@ __u64 nilfs_bmap_data_get_key(const struct nilfs_bm=
ap *bmap,
> >       struct buffer_head *pbh;
> >       __u64 key;
> >
> > -     key =3D page_index(bh->b_page) << (PAGE_SHIFT -
> > -                                      bmap->b_inode->i_blkbits);
> > +     key =3D bh->b_page->index << (PAGE_SHIFT - bmap->b_inode->i_blkbi=
ts);
>
> I'd prefer this were
>
>         key =3D bh->b_folio->index << (PAGE_SHIFT - bmap->b_inode->i_blkb=
its);
>
> (pages only have a ->index field for historical reasons; I'm trying to
> get rid of it)
>

Good suggestion! For easier review I just copied the original logic
from page_index, I will update with folio conventions in V2.

