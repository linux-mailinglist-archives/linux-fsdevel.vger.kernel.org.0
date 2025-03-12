Return-Path: <linux-fsdevel+bounces-43833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0263A5E5FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A73DC17D370
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 21:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D771F0992;
	Wed, 12 Mar 2025 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0vdGSez"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09591F0E25
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741813045; cv=none; b=Sk9LWMiq7kC2G/UT/y/X6ag5BTuMksJ3TgDP9FlglXVF4oPOcAPtH3kCRt/bH//lmW81900uI0OPEW6+lKNdDZhbhJGn5WzuLfehh3eP7RPHfTu+z+Yxb104OueY/ypUbSFKJkxnrpeDPXl0M7WLWrNvMhktrAWmdSlVJpVRqNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741813045; c=relaxed/simple;
	bh=hWLmRQlu6su8qwX6geP2oMXctHQ9DhFclCPqDI2P8ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noXhgCI65KldatbQIIAfcgAmllD86obM8IFC+ogLXtZ/Gy+DRaRCPH+qvDvVhoCaKa1f79RWmpveWyQplHqWVlAyY1UldHZoQfrRuqXvZXzBsSuPti9WsIuuIRvsaFCmWyzMnVdffk8nOK4r6ZE4nQAgpaDPnHRomnuKLGc45As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0vdGSez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741813042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slUJe+JHhJOnq30PEtJv6XBCtRVaMaEHLPY3w2dXjCU=;
	b=A0vdGSezksR6SG4T9D+Kr+UxQwtZlIKsr0kXpq774s2dvMrsRYNBUaTXVihaw1BTm2aLs3
	BQ5M2pWGGOs/2b13QUgCrO/uFsp8125SbnXkOcLvLjkGxlTkN79o5aCZvMEKRhNUB+vCJN
	Ld+DLQT0XyBBNe0JBJ9+ld4FDn8Un5c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VzfpiSpEP9eSYlwbTmBTsg-1; Wed, 12 Mar 2025 16:57:21 -0400
X-MC-Unique: VzfpiSpEP9eSYlwbTmBTsg-1
X-Mimecast-MFC-AGG-ID: VzfpiSpEP9eSYlwbTmBTsg_1741813040
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cf446681cso1017775e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 13:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741813040; x=1742417840;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slUJe+JHhJOnq30PEtJv6XBCtRVaMaEHLPY3w2dXjCU=;
        b=JL5+DPv7vpQU788b30dmRN/a9MWpdfUNz+i3Zpyj1ox2VlpXxWF9IJ20OEiGo1Zv78
         GTkAPCl2SckidXP7rE6IJFH0JUbcJohN+Jpn+4Z85jhRZX58mdAdTjGPCnM5NeCjZwLi
         nx3sYqJs5W/IZMGFt75lKn7cWCfa2TkRJIfbpVVAziXpsv6Qi6hDQFpgAOuUd8HF/u3R
         XbfmDMgFFhNoNaegg7rpAvMIH/T3ozjudqxItIUvaeZ8Al1AGjw7IFjGEjU8vj5dTaV4
         U8c8Qnc67/RhhBoYtoYq69G462UWWjkA1S51gOhwhWj5C8tkVSGhfKB89qtqpJ7lalQa
         Bo1A==
X-Forwarded-Encrypted: i=1; AJvYcCUdaAc21xBlzgMEfgITBE34dwTKCpbFYufXwmhf2Wb1Lg/m20Kx6+kI0+9W+CHw5uAY7zR/KS8wBk876dma@vger.kernel.org
X-Gm-Message-State: AOJu0YxFENpzJU1dv4/0BA+0FuXoAMlosQzII3n26oVXnYzUh4pyS16m
	hqIfFxDo0iG+cTaqq4nXn9LtAFxdmuc7sx+QPkLX57R62aGs4EtlcQh0KiHwpitNqcQXHeXKwLa
	u9NOrZvsoOi/AHU1IuOJQqa4gc4w9MgnduO/s06tjEv9Unq4IwZGyuyNDDjyTP71KXYsjFTk=
X-Gm-Gg: ASbGncuu/EWB0apRBor1zcWidcfgah73aNzGH8mlD/J9toKrIT/x0jGsFd5I54HIIEJ
	KM0W3ytuX0H9+phj2CLLeIQSsoKJ9b0XAeDxfRucf6zIDaXOXkIBmyYCP178180L8qxWNg61MnB
	VJkiuvtjRZqZo9yXoEiV5kLfWx0gsOOyEgM70myQNgBASpfR4htI4IRVcCYUhNSyOa0dIk69YUn
	Kgd95FbUA/mN+GVv+s/vtarxpOJh5UzukZe9ym44Ho0E217vZuan9HQW+xQlEJg3ebI2ukR2YvA
	DyWnXA0K+g==
X-Received: by 2002:a05:6000:144d:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-39132d9908fmr17334973f8f.40.1741813039723;
        Wed, 12 Mar 2025 13:57:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/+BK82Z+aTDjO7POooWoHYU637cwTUeXYPG2W8VKTA2QZ3BgBHzUd7t9xStiQ+fOSVcEVA==
X-Received: by 2002:a05:6000:144d:b0:38f:503a:d93f with SMTP id ffacd0b85a97d-39132d9908fmr17334939f8f.40.1741813039371;
        Wed, 12 Mar 2025 13:57:19 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfcb8sm22470458f8f.33.2025.03.12.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 13:57:17 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:57:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nico Pache <npache@redhat.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	jerrin.shaji-george@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, arnd@arndb.de,
	gregkh@linuxfoundation.org, david@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, eperezma@redhat.com, jgross@suse.com,
	sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
	akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
	roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, nphamcs@gmail.com, yosry.ahmed@linux.dev,
	kanchana.p.sridhar@intel.com, alexander.atanasov@virtuozzo.com
Subject: Re: [RFC 4/5] vmx_balloon: update the NR_BALLOON_PAGES state
Message-ID: <20250312165302-mutt-send-email-mst@kernel.org>
References: <20250312000700.184573-1-npache@redhat.com>
 <20250312000700.184573-5-npache@redhat.com>
 <20250312025607-mutt-send-email-mst@kernel.org>
 <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA1CXcDjEErb2L85gi+W=1sFn73VHLto09nG6f1vS+10o4PctA@mail.gmail.com>

On Wed, Mar 12, 2025 at 02:11:09PM -0600, Nico Pache wrote:
> On Wed, Mar 12, 2025 at 12:57 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Mar 11, 2025 at 06:06:59PM -0600, Nico Pache wrote:
> > > Update the NR_BALLOON_PAGES counter when pages are added to or
> > > removed from the VMware balloon.
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> > > ---
> > >  drivers/misc/vmw_balloon.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
> > > index c817d8c21641..2c70b08c6fb3 100644
> > > --- a/drivers/misc/vmw_balloon.c
> > > +++ b/drivers/misc/vmw_balloon.c
> > > @@ -673,6 +673,8 @@ static int vmballoon_alloc_page_list(struct vmballoon *b,
> > >
> > >                       vmballoon_stats_page_inc(b, VMW_BALLOON_PAGE_STAT_ALLOC,
> > >                                                ctl->page_size);
> > > +                     mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > > +                             vmballoon_page_in_frames(ctl->page_size));
> >
> >
> > same issue as virtio I think - this counts frames not pages.
> I agree with the viritio issue since PAGE_SIZE can be larger than
> VIRTIO_BALLOON_PFN_SHIFT, resulting in multiple virtio_balloon pages
> for each page. I fixed that one, thanks!
> 
> For the Vmware one, the code is littered with mentions of counting in
> 4k or 2M but as far as I can tell from looking at the code it actually
> operates in PAGE_SIZE or PMD size chunks and this count would be
> correct.
> Perhaps I am missing something though.


Can't say for sure. This needs an ack from the maintainer.

> >
> > >               }
> > >
> > >               if (page) {
> > > @@ -915,6 +917,8 @@ static void vmballoon_release_page_list(struct list_head *page_list,
> > >       list_for_each_entry_safe(page, tmp, page_list, lru) {
> > >               list_del(&page->lru);
> > >               __free_pages(page, vmballoon_page_order(page_size));
> > > +             mod_node_page_state(page_pgdat(page), NR_BALLOON_PAGES,
> > > +                     -vmballoon_page_in_frames(page_size));
> > >       }
> > >
> > >       if (n_pages)
> > > @@ -1129,7 +1133,6 @@ static void vmballoon_inflate(struct vmballoon *b)
> > >
> > >               /* Update the balloon size */
> > >               atomic64_add(ctl.n_pages * page_in_frames, &b->size);
> > > -
> >
> >
> > unrelated change
> Fixed, Thanks for reviewing!
> >
> > >               vmballoon_enqueue_page_list(b, &ctl.pages, &ctl.n_pages,
> > >                                           ctl.page_size);
> > >
> > > --
> > > 2.48.1
> >


