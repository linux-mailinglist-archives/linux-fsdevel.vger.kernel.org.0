Return-Path: <linux-fsdevel+bounces-71190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88830CB8818
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4928308BA18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Dec 2025 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62BA313273;
	Fri, 12 Dec 2025 09:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6ZMKF5w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwO7R+ev"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42689199234
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532266; cv=none; b=fEH2XPTT+m9kGkCA9sOPqHFnXJ6X+H/efxxPH10fV6485uDKbeUs2H83mM52m2zoe8zrvqSXhxhNrzY82uRNyHXSVac1rn2lAeRjU9OIUM2daAO7Nnb9NFbm4MwTUjRpyy2bepvNIXbg8VYyCzszL4eYUKjPbyWQKoyEQii52Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532266; c=relaxed/simple;
	bh=Vqa2rgddM7JXBUKy3CEYX4duZqjHtaPestsA54FpxN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r0eDR3r7mJrPfLftpN9DmX5gJQpLo60wvWr8SI5jYvsBR9oCBnRpglGtuedyw5cOko27nGG91kTrLO5z7qarNczy4AZ1mH0YEmnvhxqn94ej5BkkNQ334fQ6YRoa4/YO2j6DqpIpfPwXHuZ9HwBMhQ+O029eWgzc8LzrpqvuLXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6ZMKF5w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwO7R+ev; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765532263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IeK2fmxKCyYFISZ4y5sIfqoCgkHvoGQR0PUve4ax1s=;
	b=X6ZMKF5w9kWDE9PXUsXsbHxdy/qsK2CgyfGqGUdYRtjJSGFtSE+T9zt7Iz8SXDKvAxtH4k
	T6uqEOVrZugQxavZ0JZesJwgcn1uc+QUcER5NHYgpURvzLtCi8Dz1njyDXiCH1Ti3kWWRo
	b9B3gLO4rFEW6YhQ892qME6sWZvFNec=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-MKqjc8UWO4ij0BGUDxsQpg-1; Fri, 12 Dec 2025 04:37:41 -0500
X-MC-Unique: MKqjc8UWO4ij0BGUDxsQpg-1
X-Mimecast-MFC-AGG-ID: MKqjc8UWO4ij0BGUDxsQpg_1765532261
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73720562ceso147325566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Dec 2025 01:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765532260; x=1766137060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2IeK2fmxKCyYFISZ4y5sIfqoCgkHvoGQR0PUve4ax1s=;
        b=ZwO7R+evAyA/MhIbWRvNfw/Cb9KFW24UTUmPWv9aOLWeZLTJonHDxgUlHHq2VPI87Y
         DcQe/aQhW2Jq6dcW8Dj9eDmhIG2pgmebWTmf15YlJzPxlsVC1eWEJKN2AZ3zNfLZZ6S7
         zR0POPcheUlCBUFE9Sj/6zaQVMmMiygeq2ni4NAxRuBrCFDY69aGbNsCELqfQKNqqNdw
         9e4hCr+OWf/vKMN/BIDRiNCGTmBZMLcfM+yPd4mmJkQwPFTFyFkhvNWOCdWVWg7lEpYE
         SmHAYeI5r0MnMbRQJcl4HgElmU2LMtXqnVL3JGO9hI/9KQfSq3dMNY+SuSzlQ8RUWkcH
         FIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765532260; x=1766137060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2IeK2fmxKCyYFISZ4y5sIfqoCgkHvoGQR0PUve4ax1s=;
        b=MgPm0CKmUiDO5HcmG4L7653gW2cE34WWYDeb3bA4/N68DStMlJb2k0KEA1AqWavxu2
         qdreGWc+1qN7F2xEcC2A9hb2uoWhXCL5J+giKhUJjFnwwA7bLCJybAiJUZiqB6OpuRfK
         8v5CIQL/jyPSLGyCSgXXQzTZ4/3shwPH0snQb0Cm+s6CZ3kgybUW5wFUqZH+1RrIU/Jk
         8RZB5e2cdK7EedQvBP05TgQaSEzW6J0FJjnCMlbmHstpTrnhQOZfDFATtEFH5GrfU27R
         49i3jDBmbZTlnWQdTIbVZYo+9/+1pnTaDWF+oou0uq43YzehnY3CmGhRBqHh4nm4wonF
         XuGw==
X-Forwarded-Encrypted: i=1; AJvYcCWiwJ8Y2pT5BLxq1GuBG77v9JgMEavBSMMbM86lv1WOF0s/cnLaqAcB6SbDrCZawXRsfytZVAXfiWfdGI7p@vger.kernel.org
X-Gm-Message-State: AOJu0YwxSENSLjqTyP11SHvEH4PAgPhyie7A5DUmjl1t+CwHD+YdCQrz
	v7diAK4ISY/gRnI0G7HegtFK11x4hPARGO3dRjphsMjtI0hgmnVKVrPVY1DQzY8LhvuXwHTj2CP
	joc14jemaKjn5iou3UgQloCJ+cnNVY+2nUY+D/ysU3EGxJgJSpI5k8TwljQKMtKWlyiJ4Suy60s
	BqgmTJh6I+J1X3QSkx2ax1c3OfxGIFoaZpa7X1+rJF
X-Gm-Gg: AY/fxX4T8UMzbz+T4YU4w9+TWKStgn1e6LBJePxm64241UiSjtY3lf8XB+in/IfzF4D
	s5VBYSj16bbWadhvrIFjoY/Pdgv984GtYivZmIKC61L1CB3mroS/iWNTVXVs2qulsf+A9D/WyI2
	XhcT/Za9vLktJmRTj2YFST89qln5xcg6kf97q9HoW4JbxpLG7f24nm/ZbC8CP9
X-Received: by 2002:a17:907:7e8a:b0:b7c:eb19:2094 with SMTP id a640c23a62f3a-b7d23b84741mr119342266b.48.1765532260512;
        Fri, 12 Dec 2025 01:37:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKs+YSpkXeGFW6Wdv9ENF6584RosIUQzla+swfnaa2obStfpBKi31WCvIbxALTkc4KySlIExdmg14SQGDHhR8=
X-Received: by 2002:a17:907:7e8a:b0:b7c:eb19:2094 with SMTP id
 a640c23a62f3a-b7d23b84741mr119339266b.48.1765532260057; Fri, 12 Dec 2025
 01:37:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251210200104.262523-1-dkarn@redhat.com> <aTnn68vLGxFxO8kv@casper.infradead.org>
 <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
In-Reply-To: <5edukhcwwr6foo67isfum3az6ds6tcmgrifgthwtivho6ffjmw@qrxmadbaib3l>
From: Deepak Karn <dkarn@redhat.com>
Date: Fri, 12 Dec 2025 15:07:28 +0530
X-Gm-Features: AQt7F2pbIgM3tqCd4EBNu9cORYdXSy43drqVb-wsluyzXe0wXWGaXmMb9M_9TLU
Message-ID: <CAO4qAqJVn95XZUfrYm4th=-bqWPcndTf3OzUaNkBho1=EvTUKA@mail.gmail.com>
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

On Thu, Dec 11, 2025 at 2:53=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 10-12-25 21:36:43, Matthew Wilcox wrote:
> > On Thu, Dec 11, 2025 at 01:31:04AM +0530, Deepakkumar Karn wrote:
> > >  static inline void mapping_set_release_always(struct address_space *=
mapping)
> > >  {
> > > +   /* Alert while setting the flag with no release_folio callback */
> >
> > The comment is superfluous.
>
> Agreed.
>
> > > +   VM_WARN_ONCE(!mapping->a_ops->release_folio,
> > > +                "Setting AS_RELEASE_ALWAYS with no release_folio");
> >
> > But you haven't said why we need to do this.  Surely the NULL pointer
> > splat is enough to tell you that you did something stupid?
>
> Well, but this will tell it much earlier and it will directly point to th=
e
> place were you've done the mistake (instead of having to figure out why
> drop_buffers() is crashing on you). So I think this assert makes sense to
> ease debugging and as kind of self-reminding documentation :).
>

Thank you Jan for your response, as you highlighted adding this change will=
 help
with early warning, making it immediately clear during filesystem
initialization.
Also as Matthew stated, the comment is superfluous and doesn't serve
any purpose.
I will remove that comment in another version.

Regards,
Deepakkumar Karn


