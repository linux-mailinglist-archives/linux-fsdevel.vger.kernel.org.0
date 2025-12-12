Return-Path: <linux-fsdevel+bounces-71211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F18ECB994C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 19:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD9830680C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 18:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA2309DA5;
	Fri, 12 Dec 2025 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsWmcSGk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2Dkrg6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0943090C6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765564746; cv=none; b=Bs+M49BniVemxnpyNlDTpUYOZKlCQMFR+2/vjy4b48xxn1ORrjmwPWrYnLHzT4h3uGYpPvoQEoArfesSoZqvH4NdwZ66apLt8Yq61OVqKmXxEC+PfpHyMPcNbQaSULwAq/8qv1VgWJzDRgnodBNeazP9p3Tf563iJOMSe6mDwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765564746; c=relaxed/simple;
	bh=dLsbpgsSJC1W+T0cNsr09B1iHIS4Zi7oilDjEomJ0IE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pF/xpNwv0auyXBnHhL8Rtgl9nIFBS7/NTmYOVTqgayo1Ve8FATYgfwAsf0dyPksnxxGlbbosbdWO3SLVtC8TU5aScqCtGFA6RzQl/pE1WsIR0o7mJf0vfYO2cwKy2850vuKm/2xtRA3GJkxRS0L/ZKpmOLGDLkKu1rDocbRshcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsWmcSGk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2Dkrg6o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765564744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S+hpqhx3308ATwYzN1NtxlgmadEIegTDoxPGbpzieio=;
	b=SsWmcSGkHtaKJOSJI7cYE8NylnQqf8Bv4w+D+bPlExmFzhCei+8hpDHxkAQJW/MTWCWQLc
	ncfuS1yb74zRzvnU4OEOpsh12VF2DhzBljpubsnH8v5qw3tYfIV5h4ednMosBJbup/jVmn
	uZg+g50t8zeJTAYcbbWT+haQwednHO0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-xMmEGlxNMgSgi29CePX74g-1; Fri, 12 Dec 2025 13:39:02 -0500
X-MC-Unique: xMmEGlxNMgSgi29CePX74g-1
X-Mimecast-MFC-AGG-ID: xMmEGlxNMgSgi29CePX74g_1765564741
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6495ccea18dso2891662a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 10:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765564741; x=1766169541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S+hpqhx3308ATwYzN1NtxlgmadEIegTDoxPGbpzieio=;
        b=A2Dkrg6o87kBQvk2DjgZFzWnABp6PVYu/SEb3ZS/wz+IEnvDls7MCuyQKfhfk+qFKY
         9PSFlab6s7eLuGYezMJkdiBESMwnI50cBOs7BoE8xP1YYc+AQ7GNTgNMHVb4el+OlxkC
         yS98Xma/vh049Tghy6Gw7HdNQ/NW7Ymtd3Hx9ZdUeaX05J+DARttvYU0G1O3sL1Irmnq
         GYy359m3g+3OeEiKWyZF1rwGs2P5tRibMjtSRjCEeMy2k/mIJk42NZtsIrfN0iEUm1aj
         0dZOjMFO5/TrmivP6JeGoIC5lB5cM9b/8PC/34JF+uGLJO364ICAklOCBiFBbNtWmfTD
         16hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765564741; x=1766169541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S+hpqhx3308ATwYzN1NtxlgmadEIegTDoxPGbpzieio=;
        b=W9+hV6FeXVfXdN5lXbU0MHXbhBm4EeCqXvOUehP00VeP03mh5Un/lrZdOTIALIq3p6
         ilC4Vd/9+HDaHgfBc5QeWewQ0heHB8qFJdC9DuA64nqKB5qyeR5/anRlvKjPqBOy/Lpv
         SAIX+KUA1Gte6ITJInbVC4cyZAyOrf86gVb26/sq/wWBh2KJlv6bIufEq3RXxMwKcgOg
         PIBKJtvsvnqvBkI7MtCaAudgMDfrDsZ0bpntxCdyb7AGPjT5b3rQroeR9F8S1fbEsc/0
         Aa+5qcZLKtKLcIBi0w8IaFeico9Qk+M1IlMelM0WctmQDkOsuZvQGGJKSQbsi5+6hh16
         JAUg==
X-Forwarded-Encrypted: i=1; AJvYcCVYrdrOu5nIgtB33OxJKkrMjeCbZUyFT92MYBTnBkqiL48gsOQcZyKMGvdPbRDLyfr0f1lHFM+0DKqqj7Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YwsePk7hNXEZY7UYBkl8ech00MBjT4tc74kU9/vTZXwylpaiVu9
	3+4s29Mz4V/9UqKAlTCMxo1UMWXiTYDnSono5dlz5tATEmdFQY2LAUWrKNAUeFxhWdm3RwUzVZJ
	8/eWtNq+Hh4RCkuD3W45+MWDi0PYoPaubC2UcwNDle3/3xxuxQrCtuFD1Y9Oe0sMXsMwVEucE+u
	5CyGw1j9uK6LYoRez7U5o6X11btB+J/VdvFrWPLX+I
X-Gm-Gg: AY/fxX6h9qF4D+YZ1hHvw0sLe7blfpiUsMH3q1VJMeI36NILsrdhEU1LAwHWe/EaRaO
	Tp2Q0RVKbo4bPl3fZP6uh5z5x8omml8wYLrPWjB+3XZQPYYdypaYqloBUxtFcjydYh5ZpZlmEro
	BUw6RDihUa6vUicb7qRCpzE99Xw0AiYYrsiM/9NBJkz7tOWYsPv4Ofd8t0wC41
X-Received: by 2002:a17:906:9f88:b0:b72:6a39:49d7 with SMTP id a640c23a62f3a-b7d23c1b192mr329952666b.33.1765564741265;
        Fri, 12 Dec 2025 10:39:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFH5hEfEk+Qd/TQuO5dmZhx0Ve9hkd3hngFGgcBfMa/BZ+7n602U9F6HYZJh/uoPAXYcPduxx52GHJ646gbZCw=
X-Received: by 2002:a17:906:9f88:b0:b72:6a39:49d7 with SMTP id
 a640c23a62f3a-b7d23c1b192mr329950666b.33.1765564740878; Fri, 12 Dec 2025
 10:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210200104.262523-1-dkarn@redhat.com> <aTnn68vLGxFxO8kv@casper.infradead.org>
 <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
 <aTwIAwjeSrALbVww@casper.infradead.org> <7pottkepdngwjiz6mi6rby67a2xpm65ulx3oflzhrv275efq3y@e64lbkl767eb>
In-Reply-To: <7pottkepdngwjiz6mi6rby67a2xpm65ulx3oflzhrv275efq3y@e64lbkl767eb>
From: Deepak Karn <dkarn@redhat.com>
Date: Sat, 13 Dec 2025 00:08:49 +0530
X-Gm-Features: AQt7F2o9HVOS9-O3c1b2kzj6ir7__uDkNTKy0pS9_N14HeUb4y18fmVn6ULV2e4
Message-ID: <CAO4qAqKX=LA1PHjGJ0BO1YWE04BneJmZmximqqF0BQ1i6emhNA@mail.gmail.com>
Subject: Re: [PATCH] pagemap: Add alert to mapping_set_release_always() for
 mapping with no release_folio
To: Jan Kara <jack@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Liam.Howlett@oracle.com, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 12, 2025 at 11:17=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 12-12-25 12:18:11, Matthew Wilcox wrote:
> > On Thu, Dec 11, 2025 at 10:23:13AM +0100, Jan Kara wrote:
> > > On Wed 10-12-25 21:36:43, Matthew Wilcox wrote:
> > > > On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
> > > > >  static inline void mapping_set_release_always(struct address_spa=
ce *mapping)
> > > > >  {
> > > > > +       /* Alert while setting the flag with no release_folio cal=
lback */
> > > >
> > > > The comment is superfluous.
> > >
> > > Agreed.
> > >
> > > > > +       VM_WARN_ONCE(!mapping->a_ops->release_folio,
> > > > > +                    "Setting AS_RELEASE_ALWAYS with no release_f=
olio");
> > > >
> > > > But you haven't said why we need to do this.  Surely the NULL point=
er
> > > > splat is enough to tell you that you did something stupid?
> > >
> > > Well, but this will tell it much earlier and it will directly point t=
o the
> > > place were you've done the mistake (instead of having to figure out w=
hy
> > > drop_buffers() is crashing on you). So I think this assert makes sens=
e to
> > > ease debugging and as kind of self-reminding documentation :).
> >
> > Oh.  So the real problem here is this:
> >
> >         if (mapping && mapping->a_ops->release_folio)
> >                 return mapping->a_ops->release_folio(folio, gfp);
> >         return try_to_free_buffers(folio);
> >
> > We should have a block_release_folio(), change all the BH-based
> > filesystems to add it to their aops, and then change
> > filemap_release_folio() to do:
> >
> >       if (mapping)
> >               return mapping->a_ops->release_folio(folio, gfp);
> >       return true;
>
> OK, yes, this would work for me and I agree it looks like a nice cleanup.
>
> > (actually, can the !mapping case be hit?  surely this can't be called
> > for folios which have already been truncated?)
>
> You'd think ;). There's some usage of try_to_free_buffers() from the dark
> ages predating git era in jbd2 (back then jbd) which is specifically run
> when we are done with journalling buffers on a page that was truncated -
> see fs/jbd2/commit.c:release_buffer_page(). Also there's an interesting
> case in migrate_folio_unmap() which calls try_to_free_buffers() for a
> truncated page. All the other users seem to have a valid mapping.
>

Thank you Matthew for the suggested change. Your suggestion seems to make m=
ore
sense to  cure the case. If my understanding is correct, with this
change the failure will
happens in filemap_release_folio(). The current change isn't solving
the case, as it
doesn't mandate FS to declare release.

As Jan mentioned, about the jbd2 and migrate_folio_unmap() cases
(honestly new learning
 for me, @Jan) this change should be okay. I will try and do some
tests with this. I will share
the updated patch.

Do let me know if I missed anything.

Regards,
Deepakkumar Karn


