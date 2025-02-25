Return-Path: <linux-fsdevel+bounces-42615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B49A45090
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E869F189C28F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 22:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB1E23370D;
	Tue, 25 Feb 2025 22:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q5kIXR3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678F204F9B;
	Tue, 25 Feb 2025 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740524171; cv=none; b=mDIUILxAtSHeyqKEkOM72MuZSAXhPooit//w317o/fpCgOrT7XTwi6Vdz5Lmwv2VdZxVGVvvfzkI2U2sPgAyghCdfIBkkeZKYFEfHbV9tWVnkW29lWpgtVfvgR10sk2D/n2eg0zu/tNyKrjtBjOBJ83E80QBmgdbGHgMOL65jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740524171; c=relaxed/simple;
	bh=WP5ICD/fUvspwcDOC+vCPGstk3m2lObTd1WmHN0cTTg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Go+a/21rPPQd0dPwZd5fTn/R8eXPcEWspVfa70bwpII30YGRcZWpwHAvsmxbBccXvxn0Yi2Q6wE0FNUyJq2UUjqI/y06BIdSlmlM6+M8o9ufoEKModPkbiKb1Bt/NEVEFzaqh46R8TYSdqoF+vEaPiHLw0zzjHTqZWrDUjTkNqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q5kIXR3v; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30a2594435dso2993491fa.1;
        Tue, 25 Feb 2025 14:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740524167; x=1741128967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgEgO8Ju/firUMwZDW4ea1qs6sMMAvv6pWGk9qZ2srE=;
        b=Q5kIXR3vNlZPwuOh8yaGs+Dv0XMT4ecnpzNL97taumi3QJQvM3GpWd+4CQ0DbRAmv0
         lmsJ3o5wXMLdgwDtqJT+eHkpyIPbn/m5ckwl5nfMjVc1F+3jjU5S0N3mF4wAFe94bmbq
         Yr9Azcmp7dEfSavusOBf0jzZUxvT87C8tNgSRG2+DJf436igi7yAts5vxZ3Ez2HnZDrY
         t/Q6ODyzUqWadwBGfpfVfre+Vz3xcoKNEp4Aoc+/UZCZLrzBJxImib67ZOQETNARVFrG
         gWP6zmTmA1K2nxwtKGYeBVJJWVxEYmI5ER0657xEFliaAL2YRXvycXhFXBa3mnlS9G+e
         RI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740524167; x=1741128967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgEgO8Ju/firUMwZDW4ea1qs6sMMAvv6pWGk9qZ2srE=;
        b=qN0IMBgObkmrZDnG0R1s/ZpX0P3ipX/Qp5h6wazVOl2MMxbtCZ5GuKfxmPkS6lLP2f
         7XSwJ1aNhR4+ZGtGdQlhJTDqwAgu0+0YoDQKW+D3PA2G6RfY1d+JsRoB3NGjiARdRu9Y
         9g6v8DDfN1hmnTQE2pLWyYsER0TNAPHZtnbryXeqO2ZYGOlw1GiVeFvOOO9L15mcjHz9
         PxTqYAl5pjx25flqvJOXcG6+s6FANemYskvBbm6gdPrXXgNvTqPEkYKqCCgF+wZNUAZl
         WNjj94n+6wIXtZIGqM0BikBz9Uj2+DECSkiO42NOcDooIvwR0tSQeCDgcUCynsSyKPMZ
         PxFw==
X-Forwarded-Encrypted: i=1; AJvYcCWrelgw74ZxewTeNa6i4Oz52nhpiPceJRWuXlpsUHqX1k7WY4QF2GBzxsc5CHizvecAAYR/IeZxD015@vger.kernel.org, AJvYcCX3sbaBOpuAhIddJLmfWCsP6pFSV9AYgD39QFehI7JRkKtzA78rsOAB4fD92O+6CSgUSjrLhrDH3iPnvw/f@vger.kernel.org, AJvYcCXSj4qe3IdDZYArXLkdmCzt+heOvVxz+BTApjhhZcPuk4Tilr7kEY2JbC46egVWdfIs/iMEeaQzKjm0OZAWqw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKQMGdmXo4W6nvvAisD73/FRrH2KMaKXovzMvFxz2YKkxkFWj
	lyaZucLwVziNqVADfh6zmaJu8ioaQxeTXw5AgBXZjLrJ18CKzVt/dDuDWJ82fWR4pjbR0yOdKb2
	oSvBCUx6Ke1P+n49/QkFo59u39H0=
X-Gm-Gg: ASbGncuOefNfUS4+ec/R7DOsmQf3DpZ1D2k5UpZSNWiBnXh1274RJOD8hMxPEntbDzY
	tED0BxbkJnYxSFdG6/iqZgUl6YrtvYXKz6g/cRVPAWPII/91h70l3ILkw3J12+h+k7XxU7Uld8y
	JZjnjDcMo=
X-Google-Smtp-Source: AGHT+IHwSWJ7XNj4Mb9xUjz4kISutQjQS5qgcJOweA9fncToSusgnMBoMCQnx1ZOHcc9hRULT9kO2A2WM5J2rYS4I5k=
X-Received: by 2002:a19:4317:0:b0:549:39b1:65d4 with SMTP id
 2adb3069b0e04-54939b16edbmr1848816e87.0.1740524167158; Tue, 25 Feb 2025
 14:56:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2433838.1740522300@warthog.procyon.org.uk> <20250225223826.sm4445vrc56mfuwh@pali>
In-Reply-To: <20250225223826.sm4445vrc56mfuwh@pali>
From: Steve French <smfrench@gmail.com>
Date: Tue, 25 Feb 2025 16:55:55 -0600
X-Gm-Features: AQ5f1Jo6XXLVbjx1gBz329g2rRAPrhuHDOb-nfzLQJUf_2H9sBrfoXnqj9dxnNE
Message-ID: <CAH2r5muYgfd-GmwQKt-ZHgt7Up57j1OEJy-6e9OdN--aiQHDGQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix the smb1 readv callback to correctly call netfs
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>, 
	Jean-Christophe Guillain <jean-christophe@guillain.net>, Paulo Alcantara <pc@manguebit.com>, 
	Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the quick fix and reviews/testing.  Merged into
cifs-2.6.git for-next.  Will run some additional tests on it tonight

On Tue, Feb 25, 2025 at 4:38=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Tuesday 25 February 2025 22:25:00 David Howells wrote:
> >
> > Fix cifs_readv_callback() to call netfs_read_subreq_terminated() rather
> > than queuing the subrequest work item (which is unset).  Also call the
> > I/O progress tracepoint.
> >
> > Fixes: e2d46f2ec332 ("netfs: Change the read result collector to only u=
se one work item")
> > Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D219793
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Steve French <stfrench@microsoft.com>
> > cc: Pali Roh=C3=A1r <pali@kernel.org>
> > cc: Paulo Alcantara <pc@manguebit.com>
> > cc: Jeff Layton <jlayton@kernel.org>
> > cc: linux-cifs@vger.kernel.org
> > cc: netfs@lists.linux.dev
> > cc: linux-fsdevel@vger.kernel.org
>
> Thanks! With this change, I cannot reproduce crash anymore.
>
> Tested-by: Pali Roh=C3=A1r <pali@kernel.org>
>
> Steve, could you please include this fix into some queue? This should be
> merged into next -rc.
>
> > ---
> >  fs/smb/client/cifssmb.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> > index 6a3e287eabfa..bf9acea53ccb 100644
> > --- a/fs/smb/client/cifssmb.c
> > +++ b/fs/smb/client/cifssmb.c
> > @@ -1338,7 +1338,8 @@ cifs_readv_callback(struct mid_q_entry *mid)
> >       rdata->credits.value =3D 0;
> >       rdata->subreq.error =3D rdata->result;
> >       rdata->subreq.transferred +=3D rdata->got_bytes;
> > -     queue_work(cifsiod_wq, &rdata->subreq.work);
> > +     trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);
> > +     netfs_read_subreq_terminated(&rdata->subreq);
> >       release_mid(mid);
> >       add_credits(server, &credits, 0);
> >  }
> >
>


--=20
Thanks,

Steve

