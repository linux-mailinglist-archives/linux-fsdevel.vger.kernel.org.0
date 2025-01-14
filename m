Return-Path: <linux-fsdevel+bounces-39178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C95A11286
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 21:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE70163D65
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 20:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C42080D9;
	Tue, 14 Jan 2025 20:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSklKTE7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47668493
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736887907; cv=none; b=AhxrghhaXqisF45kgaadJzGg9NFQaWvc5gBCsZUUVoavAOS42QVYyj2SVJWpX2FiDi2nQOrag7hogaNJRQYqz0OCsv/tGCv2x0twWY35Xii0dZcgLEKSE3XKdkDj/lgC3btkSkNJigEojCUZ6LZ9lhYgubrwfjyQM0PM9lI+D88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736887907; c=relaxed/simple;
	bh=CSKQEqQG6YXGolt5sUa7RV8ZojlyhuY5dvPzzWPM0es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQf5cTmp1SNVw7j/fW8bdID9D2M70mvcbGa0fwo3iDrEJcGYmirAzo8icxE148JOd4D3C810GpIPnCwzND/cnTRzly8KxzMAMvmXav+fofwjMDHjxlPAC1YT+XBpjncQKeWEZcoVFgl2pusQ22uuVXTD2XiQT04/pmbGwTe67tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSklKTE7; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678cd314b6so56361501cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736887904; x=1737492704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yI8ELS3CrLfvjr9n1M8dG4jWDZQ1aT/IxMYt+noPB1M=;
        b=aSklKTE7gpO5os5oVdKiF9njyDJOGzdEOXBnC3hKQuKhGNX9g4/os2YFSdH3cMV1It
         jlkySfM+hjGdohfPTZwnEKXo6O+0QuU2N/a32LMkMiSfc6FJp+Loo4b2u2PLOvN2u13e
         atWwk57ITL+OprOff+/jlrL8atJfuaAxboM3DUz4e02wdWC/VGnFgRYpTMZ6UvpY7hO/
         QvRh8Ua34XCY63cfIXtv2di5qVbZGd0rZED5sglREJaz57V0IiRoZg0Ygh4Z3BGwbZkM
         ve8axl1cnDYqn0/pOATJaYPwC84yBvNKvRGoxl8Bgj73OU6LdEfGNBPmgcxf/yyUwQWp
         RsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736887904; x=1737492704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yI8ELS3CrLfvjr9n1M8dG4jWDZQ1aT/IxMYt+noPB1M=;
        b=xMKxhlVRKiRQLWEByYUnBY/Mj9hsIuS5XFUOI1mPxALditd55iaLLUbPPjFOveSsuN
         4UDrblhGiL+iI/1b2NN3rhkaCSZsgx0Ey3eLIHrcvdKdUmfAbW93t+j2JaQM/vOl4KK+
         G1GO+QPk3xZ5aJCE8AqmWvpMUrzPyzl+g1AQh14ylSkRv47p+aeP5zINrUFwMvJkDDEi
         e2Z2PjXSJa4aJ4FOJjLDo/a3Hd5aEnG0SRSLqe2YhQgUfCapCyWAvJeHnGs3H87t57UF
         Q8aLx9l6FuHMaYiqSsDs+JB5mTzT3ICkKsD4Lm7aXsfsnjDK4y1+gk+50pzecFC0IXcA
         LxTg==
X-Forwarded-Encrypted: i=1; AJvYcCXfW6Cp4+MUaR6RMivKulTh3FY4usm5pNAHa31Bj4vukai8BoHqIRgvxTdg/7a4isDF5TDll+c1gP1O5G/Z@vger.kernel.org
X-Gm-Message-State: AOJu0YziINIONq5Mh6eMqZW43Yw3sp37xMWoPOia/OgBAPBXbtJ6jQee
	Tk/rnn1mwGcFSZtdJj4lTf/goi6HVzpSrC4GlFFs4lAtpXAGmMQdiUkihXrD8YmyYTzr0MGQ1B6
	W8rz5jmdu56W/t1DeOI+9R283HuY=
X-Gm-Gg: ASbGnctGMNuDZY/QbpF6N/s+2F1l1xccCi2oa4QKyirwIdPcF6utnh9yOexJ9LuFYA6
	0DXfkN++cSdj9JIKbFZWWVbnJUZlb9r7Hwx/pHvE=
X-Google-Smtp-Source: AGHT+IGlSQh0zQseImd09NZxrO5yO6mkSZv2LQugburHsunToKK2iHUYzz0o/WdE2zNxSjmv93TYm0E0geCjgi0AGIQ=
X-Received: by 2002:a05:622a:81cb:b0:46c:7197:58d1 with SMTP id
 d75a77b69052e-46c71975911mr355365991cf.13.1736887904449; Tue, 14 Jan 2025
 12:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
 <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
 <CAJfpeguSXf0tokOMjoOP-gnxoNHO33wTyiMXH5pQP8eqzj_R0g@mail.gmail.com>
 <060f4540-6790-4fe2-a4a5-f65693058ebf@fastmail.fm> <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
In-Reply-To: <CAJfpegsrGX4oBHmRn_+8iwiMkJD_rcVEyPVH5tBAAByw4gSCQA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 14 Jan 2025 12:51:32 -0800
X-Gm-Features: AbW1kvaGat4QtPsnY-5ZYlWa2hyF9YwThPdM7CmUWonPOgPdCtmGyee-hOXHTTw
Message-ID: <CAJnrk1ae=ZFrc_5+m10Tde0TkcWU=cJK-ppy+-ss0Dn2bch2Tg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>, Jeff Layton <jlayton@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, Zi Yan <ziy@nvidia.com>, 
	linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 2:07=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Tue, 14 Jan 2025 at 10:55, Bernd Schubert <bernd.schubert@fastmail.fm>=
 wrote:
> >
> >
> >
> > On 1/14/25 10:40, Miklos Szeredi wrote:
> > > On Tue, 14 Jan 2025 at 09:38, Miklos Szeredi <miklos@szeredi.hu> wrot=
e:
> > >
> > >> Maybe an explicit callback from the migration code to the filesystem
> > >> would work. I.e. move the complexity of dealing with migration for
> > >> problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
> > >> not sure how this would actually look, as I'm unfamiliar with the
> > >> details of page migration, but I guess it shouldn't be too difficult
> > >> to implement for fuse at least.
> > >
> > > Thinking a bit...
> > >
> > > 1) reading pages
> > >
> > > Pages are allocated (PG_locked set, PG_uptodate cleared) and passed t=
o
> > > ->readpages(), which may make the pages uptodate asynchronously.  If =
a
> > > page is unlocked but not set uptodate, then caller is supposed to
> > > retry the reading, at least that's how I interpret
> > > filemap_get_pages().   This means that it's fine to migrate the page
> > > before it's actually filled with data, since the caller will retry.
> > >
> > > It also means that it would be sufficient to allocate the page itself
> > > just before filling it in, if there was a mechanism to keep track of
> > > these "not yet filled" pages.  But that probably off topic.
> >
> > With /dev/fuse buffer copies should be easy - just allocate the page
> > on buffer copy, control is in libfuse.
>
> I think the issue is with generic page cache code, which currently
> relies on the PG_locked flag on the allocated but not yet filled page.
>   If the generic code would be able to keep track of "under
> construction" ranges without relying on an allocated page, then the
> filesystem could allocate the page just before copying the data,
> insert the page into the cache mark the relevant portion of the file
> uptodate.
>
> > With splice you really need
> > a page state.
>
> It's not possible to splice a not-uptodate page.
>
> > I wrote this before already - what is the advantage of a tmp page copy
> > over /dev/fuse buffer copy? I.e. I wonder if we need splice at all here=
.
>
> Splice seems a dead end, but we probably need to continue supporting
> it for a while for backward compatibility.

For the splice case, could we do something like this or is this too invasiv=
e?:
* in mm, add a flag that marks a page as either being in migration or
temporarily blocking migration
* in splice, when we have to access the page in the pipe buffer, check
if that flag is set and wait for the migration to complete before
proceeding
* in splice, set that flag while it's accessing the page, which will
only temporarily block migration (eg for the duration of the memcpy)

I guess this is basically what the page lock is for, but with less overhead=
?

I need to look more at the splice code to see how it works, but
something like this would allow us to cancel writeback on spliced
pages that have already been sent to userspace if the request is
taking too long, and migration would never get stalled. Though I guess
the flag would be pretty specific only to the migration use case,
which might be a waste of a bit.


Thanks,
Joanne

>
> Thanks,
> Miklos

