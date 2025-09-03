Return-Path: <linux-fsdevel+bounces-60162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEDB424E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429741BC345F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 15:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEC1257836;
	Wed,  3 Sep 2025 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njgPp9pC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E424B1EDA02
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 15:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912593; cv=none; b=ZvRYio/Czeq34OaHFKtK0RYE8NZb5zCZ2v7Jds81fXmjCGKL1y0xUyymXuudr2H3XFyod/kzABm+oKq6xcV8PFq/puPWxwnP51pKZctMHZYX6X2WJLXpP3hn5L3z5C7i+prfp842E/E6ycxJ4kRlBxArwSXdWJ70HAFrtVeS2m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912593; c=relaxed/simple;
	bh=zVchQmNmstxV/v340kO5PUbzTbO58G0b1llRhj9RZ8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cd5ztxF0Jwtewt9KED/WzMwVZxxYIHTLBbI6ALC0480otbDWMXUthONifi4WE7h0iNHoMs2GWbkywm0vxW9An0Z6n4gnNOAJcYXFv2zf4/IdD3Li2GzZyPwar3Y0C3V5a+iWD6cn1OK61lX3oNZHuExX2bOCe/s+RNm9/mMG/NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njgPp9pC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61caf8fc422so11703379a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756912590; x=1757517390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zVchQmNmstxV/v340kO5PUbzTbO58G0b1llRhj9RZ8I=;
        b=njgPp9pCA0sUJ/wP8bI6xDhL0vhUoSqByY80r7FAOvpmEcuo/M7EYrEYqAoSxeQsQM
         zjWHnGnFClDqkQcnGcFNlbRg/lGsmJ5Nyxy/tQqjW1WmbJliT6NYurJ/FQCPgVP6xB6e
         9IDrVXVcORzT8rsyq4BKe/g8AsPFLaFFIph3i6oZiipiud5t45EXWwTOHLaY+4iPQNSU
         69+7z1Dql0i+pRkVDzFkK5gMyZlgKJJMbdMyXL0hM7cUylQOxFZ6d0bzYcINaIa1C1vl
         K4LWJGsYgDc3jRlT2vPdl+whvDxJSWNmbUMnAqpis8rFIkvt1ea+CBLuu+PuFjfVDnoV
         hd6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912590; x=1757517390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVchQmNmstxV/v340kO5PUbzTbO58G0b1llRhj9RZ8I=;
        b=Ds8ZWGyP05HWbJ/YnBDw4p59yPkhus+u5wgLrsBl6iMnCfYnKtqQXdFnXX8tw2719a
         v8C0zo9b0Bj3BQTcmeKOiRToD1WveRmkRYjdZjCm4UadpiWM7NeaqPJwVIEuzxlt9peK
         XIMGuPc2yj5Sza3OI1irSph3svR75KHxGsaG6ZoxgVNbiXBv/gU6NltXbv7+yg5Hw0tV
         GCepgpdKJjbgBUEO41dT2Anf0msDQCGkpC3RAvHl1Zifps506owB9QaokPm2XJ/cYGIp
         HObpOGppnbgqlrkmkfQ+ndNnwo5VvgWdyDP2g8cdDNLeIwZYJDpZVGZ2CpTldUpj6zh1
         vnEA==
X-Forwarded-Encrypted: i=1; AJvYcCU5trSkpiH23ThAbx5BPYrfbUIJdzSngKz4Sm2+nUo/G+4O/Vx9mw9NTpJvLjQxVscHBJUcN4Kv5U/Spre9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+LTSZOqJO/Tjt+o+3dNan26HQRgsQlVlQItoYdcT0tsC4+D9v
	GiubnfOQ+SLVZm+oAm61tQDNhQTtjXSYwXNL3q48NLPohfBva5ntvh7Sy8cYVm00LNdDj/go/9d
	Fdog8mg5q9kxT8zFZnkLCT3YorHB0TJE=
X-Gm-Gg: ASbGnctXILvSWcsb6E7TZz6UBcgIlkDXBg5qmk7GGbIVp0o3AjQeLUYjr6NXoyiXRzN
	u/kJTgdS6xWD0b5AIniA6ufgmMKiF21s/KG/B4jWlNw1Qzy9MN+Y0fLNuynj2GCo2LTZvZGh421
	O57+Sax+s+eT7OeBe+cEr92gOcBichmurEXEY7mnFMOjzZfY4CUu4GpAaZNFL5ddebLjRrNw+F1
	U35vzk=
X-Google-Smtp-Source: AGHT+IHs/cG8B1qTnq/KAI55qAcJuv3DrpgnFzqX9iXhJEt4AAAW11rx1wdXgaMdfz0f4jELPI86IQ10rFWkkJjln4k=
X-Received: by 2002:a05:6402:35d3:b0:617:9bff:be16 with SMTP id
 4fb4d7f45d1cf-61d26d91616mr14492461a12.22.1756912589986; Wed, 03 Sep 2025
 08:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902145428.456510-1-mjguzik@gmail.com> <aLe5tIMaTOPEUaWe@casper.infradead.org>
 <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com>
In-Reply-To: <d40d8e00-cafb-4b0d-9d5e-f30a05255e5f@oracle.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 3 Sep 2025 17:16:16 +0200
X-Gm-Features: Ac12FXz47kPqS6TNNjWLG_Dgr2G4hvPtcroNPSanG0Td8n6Do6-bREbq9xpBlF8
Message-ID: <CAGudoHE4QqJ-m1puk_vk4mdpMHDiV1gpihE7X8SE=bvbwQyjKg@mail.gmail.com>
Subject: Re: [External] : Re: [WIP RFC PATCH] fs: retire I_WILL_FREE
To: Mark Tinguely <mark.tinguely@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>, ocfs2-devel@lists.linux.dev, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 4:03=E2=80=AFPM Mark Tinguely <mark.tinguely@oracle.=
com> wrote:
>
> On 9/2/25 10:44 PM, Matthew Wilcox wrote:
> > On Tue, Sep 02, 2025 at 04:54:28PM +0200, Mateusz Guzik wrote:
> >> Following up on my response to the refcount patchset, here is a churn
> >> patch to retire I_WILL_FREE.
> >>
> >> The only consumer is the drop inode routine in ocfs2.
> >
> > If the only consumer is ocfs2 ... then you should cc the ocfs2 people,
> > right?
> >

Fair point, I just copy pasted the list from the patchset, too sloppy.

> >> For the life of me I could not figure out if write_inode_now() is lega=
l
> >> to call in ->evict_inode later and have no means to test, so I devised=
 a
> >> hack: let the fs set I_FREEING ahead of time. Also note iput_final()
> >> issues write_inode_now() anyway but only for the !drop case, which is =
the
> >> opposite of what is being returned.
> >>
> >> One could further hack around it by having ocfs2 return *DON'T* drop b=
ut
> >> also set I_DONTCACHE, which would result in both issuing the write in
> >> iput_final() and dropping. I think the hack I did implement is cleaner=
.
> >> Preferred option is ->evict_inode from ocfs handling the i/o, but per
> >> the above I don't know how to do it.
>
> I am a lurker in this series and ocfs2. My history has been mostly in
> XFS/CXFS/DMAPI. I removed the other CC entries because I did not want
> to blast my opinion unnecessaially.
>

Hello Mark,

This needs the opinion of the vfs folk though, so I'm adding some of
the cc list back. ;)

> The flushing in ocfs2_drop_inode() predates the I_DONTCACHE addition.
> IMO, it would be safest and best to maintain to let ocfs2_drop_inode()
> return 0 and set I_DONTCACHE and let iput_final() do the correct thing.
>

For now that would indeed work in the sense of providing the expected
behavior, but there is the obvious mismatch of the filesystem claiming
the inode should not be dropped (by returning 0) and but using a side
indicator to drop it anyway. This looks like a split-brain scenario
and sooner or later someone is going to complain about it when they do
other work in iput_final(). If I was maintaining the layer I would
reject the idea, but if the actual gatekeepers are fine with it...

The absolute best thing to do long run is to move the i/o in
->evict_inode, but someone familiar with the APIs here would do the
needful(tm) and that's not me.

--=20
Mateusz Guzik <mjguzik gmail.com>

