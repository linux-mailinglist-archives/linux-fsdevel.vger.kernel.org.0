Return-Path: <linux-fsdevel+bounces-43831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2864A5E515
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2960E16EAA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 20:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CB1EB5D5;
	Wed, 12 Mar 2025 20:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHJ6vDlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434BD1EA7C8
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 20:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741810316; cv=none; b=YX8NxySELsUmLlApgL6Zj+X/sHxDTRjkw92m6T1oBd5mkoOK5PVHpaNPxk7vvuQbnlvJ8po/M7teL0v7Ft8V5wmRMOBl8nvEdPo1EvsrTFEaVgi/wsOQR4yz/tvpUcsBjuXepGKmunTBmvO/u9Lk+vTpN9dQvISmyRGKNLwUZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741810316; c=relaxed/simple;
	bh=nUvK5QSlWouoKts1hziqxpMybmXDATURg6I3GYwAYvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TtykFIEGgX3RmRLSsI4PAPno8AoBEHj96nsBMRwADpYv/VukCXhkxKYeVeVeBJnO6CuPPt2UUws36eo2aIM1m0P7Fb0lcpP9BP8ouI+kb8yhGkhudWMLt3mLhp4LFkTI6xEuCqpISaP4zy8NLq/7pYor4+UaBQ6CgMCp8gPqztg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHJ6vDlI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741810314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
	b=GHJ6vDlI2kLo7263FkCBa5A9zCaRa/bxKCnddOWgeKSThLNe+/sH7qBKMekFV5HzckGgSx
	SfjFlD3ewaJGvyWn/+Wp94wB4SsA54QDi6ro/XJTHXvlAc577dNWBSFx4bDg7Uj71SPSx4
	1Ft20tqroWOancCThVs/qCvwvLrIMA0=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-NLZemzWsO6-y0qr7iTDioA-1; Wed, 12 Mar 2025 16:11:53 -0400
X-MC-Unique: NLZemzWsO6-y0qr7iTDioA-1
X-Mimecast-MFC-AGG-ID: NLZemzWsO6-y0qr7iTDioA_1741810312
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e549c458692so389651276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 13:11:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741810312; x=1742415112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUM3a6gnZC/3zAtpJFYD7FtGrYIIZpsLuUMo7CMvX0I=;
        b=wTuCAI5s0tezs5VVWSubADyFJWANyLjy85/Ef9+KHfMh06IQmMQ+KpyGxMSV8XjSCI
         aSJUVVvBWjLGsiJEGmETZ/hNocditwJyYo+giiwwlE/CXo1Y7ffACSkrAgIsWL/MhTni
         +PbrBXvtcaD4I9QARu+uUeAA+FqW3eZoDH9wiHitkKo+SrCvW1KpqDTitWQgfjv4Skw0
         dnQ1gSTR4jE7HF4E8ym24OfZqLCEWupEolbacME2rxlyGHc6ZDFcObynk+wUYe3sUyzn
         Dz3LW/E2sh2kmzsFCB2UFNMRgYeRvNBfmOiC/sLeysfr2qjJvsw8clIRy1zqYQzPhn4t
         rCuA==
X-Forwarded-Encrypted: i=1; AJvYcCXYZhTequTOFbHEB/NfL7bNiAhE1WJeB1PO2t3ZdTdBLdqpF4+aWpEG779Hw/5l/+xfcP/BWtRA80aRViUm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/gYD/eUd4OJB4NqgLYA1K+RN4hkO4ZyOwTI4UojPxtA6qF5t6
	Ynn2h5q1YhUOof3XezfZyE492AIqbLdB8vu24qFfbwLxK4hHuxYF0PtAsVYiSwMhaBfooPcONfV
	t33jWPncGL/CIpgZPgt2o8RLMaD564ttS2dcielF9vB4v8A9j74Q6YFgOGflzKy7mztigUVbGLZ
	BG46/rnQ0LmrJh+vpDo8FiN+de4YcYHIPMpoboww==
X-Gm-Gg: ASbGncsdnbOgJZQSnbRL8lFZVWMcztjZGKhXv1TTXoGGx4Z8LPa+/1hHB2Jqaekgwaa
	FBTn/wG8oWL7kpsoDVhD/oJM7mqcmNtlw+YnVs5oVZb/ivIwjNNr9Yd7nHv6CauAo6kbk3RncVi
	Mbs11Qw/B3ahs=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id 3f1490d57ef6-e6371cf7f99mr23023394276.19.1741810312525;
        Wed, 12 Mar 2025 13:11:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFILEwS4y4Eu7CtZytQ1AMLlSYSOVDPPOZAL/URaaVOd4HXzYxT1BzN9xV4mLg1LOlVPDho5H2JPLVwRxAT/sw=
X-Received: by 2002:a05:6902:4908:b0:e63:71cf:7a25 with SMTP id
 3f1490d57ef6-e6371cf7f99mr23022141276.19.1741810296082; Wed, 12 Mar 2025
 13:11:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312000700.184573-1-npache@redhat.com> <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250312025607-mutt-send-email-mst@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Wed, 12 Mar 2025 14:11:09 -0600
X-Gm-Features: AQ5f1JpCzw-OMEiWJ5oWmnRpNTzG9s0Jia2dTAgWmtQzoaspW3JJPq9uXITvZCU
Message-ID: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, jerrin.shaji-george@broadcom.com, 
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de, 
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com, 
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com, 
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	nphamcs@gmail.com, yosry.ahmed@linux.dev, kanchana.p.sridhar@intel.com, 
	alexander.atanasov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2025 at 12:57=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > Update the NR_BALLOON_PAGES counter when pages are added to or
> > removed from the VMware balloon.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  drivers/misc/vmw_balloon.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > index c817d8c21641..2c70b08c6fb3 100644
> > --- a/drivers/misc/vmw_balloon.c
> > +++ b/drivers/misc/vmw_balloon.c
> > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballo=
on *b,
> >
> >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT=
_ALLOC,
> >                                                ctl->page_size);
> > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_=
PAGES,
> > +                             vmballoon_page_in_frames(ctl->page_size))=
;
>
>
> same issue as virtio I think - this counts frames not pages.
I agree with the viritio issue since PAGE_SIZE can be larger than
VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
for each page. I fixed that one, thanks!

For the Vmware one, the code is littered with mentions of counting in
4k or 2M but as far as I can tell from looking at the code it actually
operates in PAGE_SIZE or PMD size chunks and this count would be
correct.
Perhaps I am missing something though.

>
> >               }
> >
> >               if (page) {
> > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list=
_head *page_list,
> >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> >               list_del(&page->lru);
> >               __free_pages(page, vmballoon_page_order(page_size));
> > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > +                     -vmballoon_page_in_frames(page_size));
> >       }
> >
> >       if (n_pages)
> > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b=
)
> >
> >               /* Update the balloon size */
> >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > -
>
>
> unrelated change
Fixed, Thanks for reviewing!
>
> >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> >                                           ctl.page_size);
> >
> > --
> > 2.48.1
>


