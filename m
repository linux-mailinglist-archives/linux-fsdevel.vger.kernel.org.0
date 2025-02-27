Return-Path: <linux-fsdevel+bounces-42756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC6AA48029
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 14:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E16C17BCCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 13:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4323024D;
	Thu, 27 Feb 2025 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V5ilNhUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A95522B584
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 13:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664199; cv=none; b=mJSUN/5Bj+dFMA8pcvykPQdGPuUjyvhFiZ3s8yQm4QThl3DOltAVhQFlUoOZgrsMi2EuBnbB/gvC5ft+kB/pqqzI7pN2RNJotHB0JJry7R2CPctoBDNtIDb+kQKC2VeLttnubc1vIYFx4dEHTABkC1ZK1ogFYNJLsIdCAuD9Az0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664199; c=relaxed/simple;
	bh=7cX201qpgIhIVLKgCS/C6EJzBqDp4hINeKlAjk9+2ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxVi9wL2FTwNIWinQuFpfXfZSCo4KKEiOFFg4JczCFctznaAopBWU5pmSNAfwL7HGK0Vi7ezc5hCKz+Nqfig50jhwZiIA2T/FYYnCQsNpAg5rJCFeku/MxA9scKen++rvB0X1uptuq4omDTlU4jSNG7VJyewn0hj/11v1B0Lu7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V5ilNhUm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740664197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AnR45FmfqnDkr8yeueN0wO5f3L5d7ELEsHPILizbINE=;
	b=V5ilNhUmOb9phxGrAX5dzZZh7ucR3Ew2XWxt6K1TvpndZus4IlYJvt7Ubr68oF6QfUnL4f
	lor9jHMmXDzGh9zgegAtXzWi3MdoLo/znqoRODmEFlzZJtQTiN7y90SeujQEi4L2R7P5i3
	k3qF22pnvC9G/4TmOtzgbSTHMolN0O8=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-OrbZli_hPIePtiZmZh0X3w-1; Thu, 27 Feb 2025 08:49:55 -0500
X-MC-Unique: OrbZli_hPIePtiZmZh0X3w-1
X-Mimecast-MFC-AGG-ID: OrbZli_hPIePtiZmZh0X3w_1740664195
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-86b3a7cb97eso259095241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Feb 2025 05:49:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740664195; x=1741268995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AnR45FmfqnDkr8yeueN0wO5f3L5d7ELEsHPILizbINE=;
        b=CHL8vAp/FUIH6HnuooNmfBki9rw5eryrsxG6gQn5CV8j69ZQUCuqh5DRakyTusVlBi
         o8XtzfiTiInhHHa94PM+rgT9IillxQNUydZmJKj5cEzB+Jgq54LYDL1Rx5r4zz6sL5gg
         sfZrB4nJDZKXk18fBafTFFJ3JRJ3cLrdzmZWGRsgdTaGpNEUISK1hTFSPgCRL9ur4jSK
         pTezTFm+BwuLsVSMdT/wqHF1huYXk8+dt2VpSWQ5RLXsbi336rUZrCbAlwQ0soCEzj9l
         vnX0klchIWdJlXv+2ZW1i30CRoiMzyJx/h0g2MllqBlusvhQ6oWFE+7yGMURLmutI0gB
         fP7Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8nXXQlU1k6yFZ+rWmTJJlrfKy4V69DkSikPHd40BB28R48TS24jHQyc6E8uuIj+Irigqm14a2KhDLzKud@vger.kernel.org
X-Gm-Message-State: AOJu0YzRhVyb7MmWwr9yGePIGIcXynhka5b4h1d3U6w3e26YNVYBtJsM
	WI6kMCT3wLrcjdkcDkEX/Dht3pTOYWbOCOvt1PSeXh+S83fPMrVz+Md4NVtlaLL9W9J8YqTLUn+
	cdk9xc7QYQMnIsXBYQr511ILePH/A+BHo+kAVgH8aT0STP0Xa+5wZrEGP2MQlzOgzte9aiPCkfW
	ziabLYRHaK12OJ5HE/WaID/uhHtZSonjts3np+DA==
X-Gm-Gg: ASbGncvHieV+U+wo05Exta64xzItK+mLWjziEHhXEr/ZqIN5ilrzIhHoWpBTSfvAEc4
	F2/qhJOkCwQYMNaHJTXBPRYEXB1HsbzfeLamkWVThKLOJopUgvnCsrumNf2O0TksRAOvUC9X4
X-Received: by 2002:a05:6102:6cb:b0:4bc:de7e:4153 with SMTP id ada2fe7eead31-4c01e18b50dmr4220480137.3.1740664195250;
        Thu, 27 Feb 2025 05:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf9hFydBWUqU/pOSrfW+xDfSyL5zm3ZG+C0SiFAFQzNXv0rUvFxebBGu4a9/gKYBOKEiRhFAEx3a6AmT1KiYM=
X-Received: by 2002:a05:6102:6cb:b0:4bc:de7e:4153 with SMTP id
 ada2fe7eead31-4c01e18b50dmr4220467137.3.1740664194959; Thu, 27 Feb 2025
 05:49:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3148604.1740657480@warthog.procyon.org.uk> <20250227-halbsatz-halbzeit-b9f6be29c21c@brauner>
 <CAOi1vP-5NLXpGrjjw6de-rP29ax8C7ct9srwPiwTk_VBQzkDuw@mail.gmail.com>
In-Reply-To: <CAOi1vP-5NLXpGrjjw6de-rP29ax8C7ct9srwPiwTk_VBQzkDuw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 27 Feb 2025 15:49:44 +0200
X-Gm-Features: AQ5f1JoEunfwlFzP4evBN7CXVff_jSd_yPGXCfTawN6PmAnpmIofJU2hcF_Rvew
Message-ID: <CAO8a2Sgis34dEPcae=uMHfh9NRqY9B4jJdura0EwtCYL7D4L2A@mail.gmail.com>
Subject: Re: Can you take ceph patches and ceph mm changes into the VFS tree?
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, pdonnell@redhat.com, Slava.Dubeyko@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I like the direction of this work=E2=80=94it addresses some long=E2=80=91st=
anding
issues and makes the complex writeback logic far more manageable.
The patches fix known problems with page locking and writeback
blockers and improve the overall code structure. I don't see any
specific issues.
The changes do introduce some inherent risk due to the extensive
nature of the modifications, the patches have already survived a good
number of xfstest runs, which is very encouraging.

Reviewed-by: "Alex Markuze <amarkuze@redhat.com>"

On Thu, Feb 27, 2025 at 3:10=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Thu, Feb 27, 2025 at 12:59=E2=80=AFPM Christian Brauner <brauner@kerne=
l.org> wrote:
> >
> > On Thu, Feb 27, 2025 at 11:58:00AM +0000, David Howells wrote:
> > > Hi Christian,
> > >
> > > Unless the ceph people would prefer to take them through the ceph tre=
e, can
> > > you consider taking the following fixes:
> > >
> > >     https://lore.kernel.org/r/20250205000249.123054-1-slava@dubeyko.c=
om/
> > >
> > > into the VFS tree and adding:
> > >
> > >     https://lore.kernel.org/r/20250217185119.430193-1-willy@infradead=
.org/
> > >
> > > on top of that.  Willy's patches are for the next merge window, but a=
re
> > > rebased on top of Viacheslav's patches.
> > >
> > > I have the patches here also:
> > >
> > >     https://web.git.kernel.org/pub/scm/linux/kernel/git/dhowells/linu=
x-fs.git/log/?h=3Dceph-folio
> >
> > Sure! Thanks! I'll wait until tomorrow so people have time to reply.
>
> No objection to taking Viacheslav's and Willy's patches through the VFS
> tree given that there is a dependency and Willy wanted his 10/9 that is
> strictly speaking outside of Ceph to go along.  It would be good if Alex
> could review Viacheslav's series first though as it's a pretty sizeable
> refactor.
>
> Thanks,
>
>                 Ilya
>


