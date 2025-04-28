Return-Path: <linux-fsdevel+bounces-47520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9474EA9F479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 17:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8087A8AD5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 15:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4965279905;
	Mon, 28 Apr 2025 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjeOEH7+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0DE1D5176
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745854336; cv=none; b=lOs8QaLUU+Y48LlpWpxOTHLlk3Yj2Uq9aCBlwtgcjYZ4gNKvdkzdKXubLfZcMJUq6wbBpC5oLg9ouTW9t8FentCwU7zqD5c3Gj6EfVwO4uOpGg8x+Hzogxh4/2p0lzI1Etay3pZRPoylsIU5ZGnVIA//r8x/Gy1zN1Krjue3dHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745854336; c=relaxed/simple;
	bh=nmLbr0QfBL7nDQ7Do+E6unI9CTORi+km8ON0wncACA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KiVsvCDP8Jt2cRQtV+1h+FMBRN+KFcp8im7bJcssN3VfUYCqLzyavrxDHz9C1tAD9pRNmXYbpj9Kmfa2vFOj9RKbWQ7K1zgQYNC4CPSt3mD7UZ6aosjDwnLukB/wjvYN6b+aUY3Zt+Ctpm6xQ44AxlKTDHkhx69kKQkbkmshi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjeOEH7+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f632bada3bso13238a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745854333; x=1746459133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmLbr0QfBL7nDQ7Do+E6unI9CTORi+km8ON0wncACA8=;
        b=sjeOEH7+Ed7TnYSkULaRue/yU+jUj8YS9JQoWphU/VLE3tg0mUHBWZx1IW/QTX3tLN
         7P0v/KxGE+dM+w0m2zc8rtN/ySMpnYVL8bjsS0ILg0Zs8NsbzhswKDvESmjyQKOlNGml
         klK/5/du/8qIVSVpyM2OyyOvhsg4NuFFWOzmiK8MR92V3qYMwkFvkhr7lNG4oiD0hm2I
         TZXZI679+n6N6neGm+22/W9KbC0g0Pvjcda677fyTrZuG7kibHMmBxBIZIv7jU47snMY
         DKC/r3iX3wI80OWXeNbpDp5XnlRp0xDAY/ibFlmLp/hiOSY5HlLXZYVxqGDrySOR5ZdU
         ay3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745854333; x=1746459133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmLbr0QfBL7nDQ7Do+E6unI9CTORi+km8ON0wncACA8=;
        b=vnCdeVkI9Wr9iesEZLBDeWzfWk+aFDsXOEmvoiQOaRbUpsgUw8luzP9VzZ2cC2w/Q2
         ftFdqgBMen080D/POoP+dCZNPDTmSI6Qs7YZD2TnVkyOj0ymAmYmoX8Kgrpdj2Cy+rYm
         e7/wD+5uYWGbrzL6DloLN0F3CzZca9ph54q12YoyOtygmggXuYyIRdBlXovvyjUICAll
         tZyBHcHnU7/y20h7QQ8CJBLaA65+exzzg4GlXzhVyHebm1rxIiNhPvmWHMb4R79yyNXn
         CmiyIjh/ZyuEn1nzx0V7ONTjTf3X8UvTFGg8LnHR36E62fMzMl+qW5683AABgZkDfMWO
         XiEw==
X-Forwarded-Encrypted: i=1; AJvYcCVF8UJ94dmSfGX9fqsFwpgcXAGfn+9tUCUR7qrXHw+zkJox4svMP/qlRKXs1qWUfFeKlDR6maCYJSl2H+h4@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWtlwzQXRcyYzVJmAkOSvpwGocdcHxjEkv9NOGe6z/+FvLsBE
	PhGREWgbtvFFgG2JoUc2ObRHOj519vwLDELnub8b7oFLWkMeziAMeHF79WMqqbZ3nZlOrpxUCQq
	66h4luWesb/seIRG3eSCMH4lRxCuFA3YfdYA0
X-Gm-Gg: ASbGncuUq8JptFO3Qnv+BtMUBMzFr8qlKbhl53HKtiy9zHDZkdIvm2tHyLofOLV4k1P
	p/HFqeDOgiwX63jNmtloIlEHEaIlhimtAHYSwjeuMT/66kMILyTAEisQxLRvOV7jljX3JHbOCI9
	3qWwgd9D70Ji1cLHHvyKLXsk9RrvpSqrYosOxmXfY87AnIpW3Gfw==
X-Google-Smtp-Source: AGHT+IF84Nn6NPsX+bxWPTXrEhUGbnt9K3w1eGwhLr03ufZxPzsGNDvb4a3p1sU4AnDqKiUv8LwfHFBw+Zzmb6mKrYo=
X-Received: by 2002:a50:c34b:0:b0:5f7:6082:70f8 with SMTP id
 4fb4d7f45d1cf-5f837abd157mr13740a12.4.1745854332470; Mon, 28 Apr 2025
 08:32:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aAZMe21Ic2sDIAtY@harry> <aAa-gCSHDFcNS3HS@dread.disaster.area> <aAttYSQsYc5y1AZO@harry>
In-Reply-To: <aAttYSQsYc5y1AZO@harry>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Apr 2025 17:31:35 +0200
X-Gm-Features: ATxdqUHBaOfNMT6PjLtYaAWGm-NqUOuuf1CIY1n4CW21Em6RAd9g-wvKXQNhUyE
Message-ID: <CAG48ez3W8-JH4QJsR5AS1Z0bLtfuS3qz7sSVtOH39vc_y534DQ@mail.gmail.com>
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Lameter <cl@linux.com>, 
	David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, "Tobin C. Harding" <tobin@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Rik van Riel <riel@surriel.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>, 
	Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 1:09=E2=80=AFPM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
> On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:
> > On Mon, Apr 21, 2025 at 10:47:39PM +0900, Harry Yoo wrote:
> > > Hi folks,
> > >
> > > As a long term project, I'm starting to look into resurrecting
> > > Slab Movable Objects. The goal is to make certain types of slab memor=
y
> > > movable and thus enable targeted reclamation, migration, and
> > > defragmentation.
> > >
> > > The main purpose of this posting is to briefly review what's been tri=
ed
> > > in the past, ask people why prior efforts have stalled (due to lack o=
f
> > > time or insufficient justification for additional complexity?),
> > > and discuss what's feasible today.
> > >
> > > Please add anyone I may have missed to Cc. :)
> >
> > Adding -fsdevel because dentry/inode cache discussion needs to be
> > visible to all the fs/VFS developers.
> >
> > I'm going to cut straight to the chase here, but I'll leave the rest
> > of the original email quoted below for -fsdevel readers.
> >
> > > Previous Work on Slab Movable Objects
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > <snip>
> >
> > Without including any sort of viable proposal for dentry/inode
> > relocation (i.e. the showstopper for past attempts), what is the
> > point of trying to ressurect this?
>
> Migrating slabs still makes sense for other objects such as xarray / mapl=
e
> tree nodes, and VMAs.

Do we have examples of how much memory is actually wasted on
sparsely-used slabs, and which slabs this happens in, from some real
workloads?

If sparsely-used slabs are a sufficiently big problem, maybe another
big hammer we have is to use smaller slab pages, or something along
those lines? Though of course a straightforward implementation of that
would probably have negative effects on the performance of SLUB
fastpaths, and depending on object size it might waste more memory on
padding.

(An adventurous idea would be to try to align kmem_cache::size such
that objects start at some subpage boundaries of SLUB folios, and then
figure out a way to shatter SLUB folios into smaller folios at runtime
while they contain objects... but getting the SLUB locking right for
that without slowing down the fastpath for freeing an object would
probably be a large pain.)

