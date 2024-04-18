Return-Path: <linux-fsdevel+bounces-17219-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD198A9138
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 04:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32F6B21ADB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 02:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72AF4F1E0;
	Thu, 18 Apr 2024 02:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TvU/ncvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887252AC29;
	Thu, 18 Apr 2024 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713408176; cv=none; b=jww+KGpDaT58YaPxAaUJ+RCraOp+Z2jlLSk7/JooobksBs9PRYI5rlrpr1SV6+AUZ5LovxjgsyXqF/7KpsMdif6FDA/MjDH8h1SMAiXjssTru7UrDKNWXTZlIAWYC7y7zG/2GA+yMGNQoG5Jg+XPECtimgMOwQoF/G0bAkBztt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713408176; c=relaxed/simple;
	bh=nc0l6I8uY2Sfpbn0gl6LiAY4AgSqwND6FWwyoGGgez4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hF/HhLm+HrPTNS3RkQ009hlEuDsPCR7qEwrt7jufSZyEd2X3SgCf/bkoqh+X7LMV2hnL+3ObMKQr07GV6NPcgxCVxup9VXVafDkZ/fQu1k48RiyXY0eJ+a89/3RtjmZkDs29g2jQ1AD2VmRBDaHZwP4TGrjUGNunHxgPxCWfwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TvU/ncvk; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d715638540so4336601fa.3;
        Wed, 17 Apr 2024 19:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713408173; x=1714012973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TQOSEIxhOk2cmOktSZ5shcHbGjzSHGcTvMcNwlLnO0=;
        b=TvU/ncvknU4OO7x/d+H/i7v+aVx0L4D2OZ5zKHQhLaNO33awmWPMK/F9pjnMgS1Hmr
         qd4o5rbk++VlBWiiWbHKhvT6bqNGKbEUUXRxBfgS68vq7T6P6RzzwhNzOJhPAQVZmfEt
         sNGiSUzbwz159WYJlBz/iHOkGQ4XZ7bARxbRABTfLQiTYRXZvGc/5+3k0UYmhYi9fDNQ
         t9GnUXG5k3xtsNWuZVwM2XTdcPQpQFvE2bMhZXIUxGTgk82EnM8Rv/RFdTH/F76zhIgF
         H7DG609LeFN4bjgYHWG78vAyPw8tlZysa8shkAX/bLPHJJbbzhCoQSFD9w7CYV1vE/OV
         KPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713408173; x=1714012973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TQOSEIxhOk2cmOktSZ5shcHbGjzSHGcTvMcNwlLnO0=;
        b=ZLiYNu7afm3FQNdME3Da3dIB3GkQh5L1wf0hBOSNvszRpUor56k7OcyoJSQNU+JDd1
         Vz8GnRbaQY7Ijt8weQ0ARuxQxvYLULKT0NniLorJZ43GuEyL3bPlGf4gOBb2zie7oDHU
         TPo1L5b5ASv/XY7wUHJaowOnaxbIssa12jwvoZBp/gMHO9cvSWy8XgG0erz+OeszHzGO
         5F8Sr+2tqAIaTpjxW3u1fJoNVaI7zmUBEyIEurhL2+wTOzAMmW7VJyeHl40Yr9hlhPo6
         lOYz6ZK2YEOMlDwN0rusXcUAAFRyN0v7VIXgjSAj0fl6uLO8VMAQOgUmVZkmJa05EG6O
         R1yA==
X-Forwarded-Encrypted: i=1; AJvYcCXWmnpWN93NxUjLqUlquJRxPfQy1/pM/Mueq8hc2d3id7/rgkLZ8ldeQ3zjFuZlB41wkUFPtxhmGaYTce2JYA4FFraJ/DIz02yGoNQNIUhXSdd9WtnlbEyC2CxvCZpWDAP1HjFgt86W7I4WBg==
X-Gm-Message-State: AOJu0YzmrKpBnJBPOBtLvQCNc3HIYFMgnKnDk5sxm/JfI0wqjkw43mRG
	Q/TeIoXrw9EDGljmPhbGV5EsZ03bCTKe96dTcqPHRUmD7wugny/VmBgBqq24sZUQgDqjeOb8/Pa
	EqyQy3BXERFRuLmYYTaKGvPIRSI0=
X-Google-Smtp-Source: AGHT+IGUEZNaH1Nq5WQddmFU8g1mQEhzGkckKwS8KO/2Erjlf+2TGH5g2oFxff0F3SECj/jdoY4ESxgMVnXuKs22ShI=
X-Received: by 2002:a2e:9402:0:b0:2da:d964:fc2b with SMTP id
 i2-20020a2e9402000000b002dad964fc2bmr435026ljh.49.1713408172451; Wed, 17 Apr
 2024 19:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417160842.76665-1-ryncsn@gmail.com> <20240417160842.76665-8-ryncsn@gmail.com>
 <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com>
In-Reply-To: <CAGsJ_4xv8m-Xjih0PmKD1PcUSGVRsti8EH0cbStZOFmX+YhnFA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 18 Apr 2024 10:42:35 +0800
Message-ID: <CAMgjq7Am+5ftvAW4X2xOhAZ+zotSR8gD8oG+_CV=pJvsqy2Oyw@mail.gmail.com>
Subject: Re: [PATCH 7/8] mm: drop page_index/page_file_offset and convert swap
 helpers to use folio
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Matthew Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, 
	Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>, 
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>, 
	David Hildenbrand <david@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 9:55=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Apr 18, 2024 at 4:12=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When applied on swap cache pages, page_index / page_file_offset was use=
d
> > to retrieve the swap cache index or swap file offset of a page, and the=
y
> > have their folio equivalence version: folio_index / folio_file_pos.
> >
> > We have eliminated all users for page_index / page_file_offset, everyth=
ing
> > is using folio_index / folio_file_pos now, so remove the old helpers.
> >
> > Then convert the implementation of folio_index / folio_file_pos to
> > to use folio natively.
> >
> > After this commit, all users that might encounter mixed usage of swap
> > cache and page cache will only use following two helpers:
> >
> > folio_index (calls __folio_swap_cache_index)
> > folio_file_pos (calls __folio_swap_file_pos)
> >
> > The offset in swap file and index in swap cache is still basically the
> > same thing at this moment, but will be different in following commits.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
>
> Hi Kairui, thanks !
>
> I also find it rather odd that folio_file_page() is utilized for both
> swp and file.
>
> mm/memory.c <<do_swap_page>>
>              page =3D folio_file_page(folio, swp_offset(entry));
> mm/swap_state.c <<swapin_readahead>>
>              return folio_file_page(folio, swp_offset(entry));
> mm/swapfile.c <<unuse_pte>>
>              page =3D folio_file_page(folio, swp_offset(entry));
>
> Do you believe it's worthwhile to tidy up?
>

Hi Barry,

I'm not sure about this. Using folio_file_page doesn't look too bad,
and it will be gone once we convert them to always use folio, this
shouldn't take too long.

