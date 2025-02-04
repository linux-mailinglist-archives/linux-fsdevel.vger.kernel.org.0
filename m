Return-Path: <linux-fsdevel+bounces-40860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFD0A27FCA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 00:52:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678CD7A2CC2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 23:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BB421C190;
	Tue,  4 Feb 2025 23:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fXNPe+6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E0621B1B5
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Feb 2025 23:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713152; cv=none; b=frpq7xdkOjFFRj9djdW22v4oxsnofqHXZhjAB2SuWc7pDnh//jJZlslvrEwwIwxtxCSdubeOIBWqlHh5c++mY5sWOsrHt2Ls6A/km707Em9tikuAldxuXNyuvnTGQAA3/hhNHsjIs6qwHuWB3IlVp8YbeyfLnwmsIiU4m0dvGhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713152; c=relaxed/simple;
	bh=5l6ADnv5b2mbmvX0rsybSYCtEF2u5mxcpaeARc7J5ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oA0enT3JV2JgN1PFqTGZ0mzixT74K9g0mEneeLPUPmHzxubBzxfyclzEy726uqOkajLzClRZ0wbZyxdrE39Kh1YriPP5WyqWDYql0QPmY3cQvhymVY3M3+Mogqd/eOhOXZCychwuPQgRMUdq5Kn7ikrg/3iS6/qz3N2EL9LACVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fXNPe+6o; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6f6ca9a3425so43311107b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Feb 2025 15:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738713149; x=1739317949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l36A6AVJMDU9uRJ7DIwtIfqpyZuenOjv0s0yyt1jqr8=;
        b=fXNPe+6oaCfzKwi7DVu4dKmQ4cYlGMJjkxSFIdH3VjRVTiB4WqFkd/TMIcfrQl4GvP
         v5+piVlvipXBcUH74Fq08T0njLjXJq1qkkN1pgymJPArOJYF+sC/HvEtpOgATdTiNpIt
         x7h7u6X9TA4WY6lhbQpxmCFp41j1FzyHD0q4z7nEJqwmQlEltlP1BsqpjlsOqzmOvSK7
         gBz75tEA3wD2LedSWqjq16CZPOmDDyPLsESIGFRmPUao7jCr69wJfsp3e3wnBDsh9b6r
         RKk0lbTDVHKjtsxYWjOpcIG31tPawJk9QDHD2S6o7vBJa7Jcde2+RXfjEDx0irB7hupQ
         GIbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738713149; x=1739317949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l36A6AVJMDU9uRJ7DIwtIfqpyZuenOjv0s0yyt1jqr8=;
        b=c0WzpeckOxGgRziyj2aOkWQXDGp74ImfmTNIaFlsjJEZg0TLa/XE+A5d0WwoJk+h+S
         rmIqu8gHgPxsaGyF7hpp7NGrp0sdgdUxe70weRrABK4u2zbU4ggPQb9hosi9qmak1Iex
         Gw8XEntevVpOqXcHRqhC4ywoINPoeFbxXP9qoxfe2K/Z+bzq6kDdCFiA4lLfYp/2EuP1
         M9ls456v3MQ+HjTNS20UI87+Gsg9lNTYHTEtnAdMwqXF1IwZD8tLFo7xyGI0iZVxA1Jg
         88m+NchMzP5OUdoUAkb+bzJD3Igthr3GzSraJ3pGCn1LIqFsMAbn2OjqjG2CUwnUMMXL
         G8qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU44QT0g/2Ncf7J2Hb70lKWSJysd/Vda71TT8xRtKfAAH9hKXpKYj41QgPo1GSXjUpRyr3SbO/8oMKwNPD@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEykFT4qrtsPuAEAUQ/TTRl2tX7m70WdfklGeyyHX9TLawqNP
	BVkF7IBqrA/wk2j13iDpTsbiw881uiOVctzw+XPvsOGJRgTvVDQoDWrXlpGnYMvzlDokmKmwdH9
	7roD0aB30Io6gVdf5G6mL58AIG/Sp1XBYg3SU
X-Gm-Gg: ASbGnctrQjCOIUfI6QYFgwnGiR0mNvn6k6vIaZ1xjSoyofpSZlQJpw9RDf8WYF1K9Fd
	PPIlrfthSPC3OZOONjn5bOx+mMue9ofhkZqB9RGk+02mRl//8c+ksUqIX0T8F8QIblBJG8CE=
X-Google-Smtp-Source: AGHT+IFzPuhfJtcZSLnDRJaPSXwwbf5Qw3rSKr99Mir42c38+Xcm1tFlPBf1odITUXjMtibTW9GpBvgZPvyOhQyyssI=
X-Received: by 2002:a05:690c:48c3:b0:6f6:cad0:9ddd with SMTP id
 00721157ae682-6f989ee68bbmr7768737b3.18.1738713149315; Tue, 04 Feb 2025
 15:52:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com>
 <20250131-durften-weitblick-075d05e8f616@brauner> <CAHC9VhTSt-UoGOZvez8WPLxv4s6UQqJgDb5M4hWeTUeJY2oz3w@mail.gmail.com>
 <20250204-gepachtet-mehrmalig-debca5265df8@brauner>
In-Reply-To: <20250204-gepachtet-mehrmalig-debca5265df8@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Feb 2025 18:52:18 -0500
X-Gm-Features: AWEUYZmxvU9YBBRFSC9Dc7RTfcn4AC_OBYzlikGSwACt4guDBQ0naNT9F1dVLSY
Message-ID: <CAHC9VhSSxaYKj6J_HxY+cEbeea==_WgwPXH2APcZ0YQg+RhC9Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 5:07=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
> On Fri, Jan 31, 2025 at 09:39:31AM -0500, Paul Moore wrote:
> > On Fri, Jan 31, 2025 at 7:09=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Thu, Jan 30, 2025 at 04:05:53PM -0500, Paul Moore wrote:
> > > >
> > > > Now back to the merge into the VFS tree ... I was very surprised to
> > > > open this patchset and see that Christian had merged v5 after less
> > > > than 24 hours (at least according to the email timestamps that I se=
e)
> > > > and without an explicit ACK for the SELinux changes.  I've mentione=
d
> > > > this to you before Christian, please do not merge any SELinux, LSM
> > > > framework, or audit related patches without an explicit ACK.  I
> > >
> > > Things go into the tree for testing when the VFS side is ready for
> > > testing. We're at v5 and the patchset has gone through four iteration=
s
> > > over multiple months. It will go into linux-next and fs-next now for =
as
> > > much expsure as possible.
> > >
> > > I'm not sure what the confusion between merging things into a tree an=
d
> > > sending things upstream is. I have explained this to you before. The
> > > application message is also pretty clear about that.
> >
> > I'm not sure what the confusion is around my explicit request that you
> > refrain from merging anything that touches the LSM framework, SELinux,
> > or the audit subsystem without an explicit ACK.  I have explained this
> > to you before.
> >
> > For the record, your application/merge email makes no statement about
> > only sending patches to Linus that have been ACK'd by all relevant
> > parties.  The only statement I can see in your email that remotely
> > relates to ACKs is this:
> >
> >   "It's encouraged to provide Acked-bys and Reviewed-bys
> >    even though the patch has now been applied. If possible
> >    patch trailers will be updated."
> >
> > ... which once again makes no claims about holding back changes that
> > have not been properly ACK'd.
>
> If seems you're having difficulties understanding that included patches
> are subject to be updated from this content.

I'm having difficulties reconciling the inconsistencies between what
you've said here (which is presumably your actual policy/behavior?)
and what you've said in your merge emails.

--=20
paul-moore.com

