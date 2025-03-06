Return-Path: <linux-fsdevel+bounces-43375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA08A552C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 18:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7DBE7A3782
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Mar 2025 17:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196452561C5;
	Thu,  6 Mar 2025 17:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6BlRLLn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F45946C
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Mar 2025 17:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281560; cv=none; b=rFE0l5cEFLuLLU0WzuDH+LeNGnBVleKUngnUhjbTOu4Zsl1LyRVmrDjLiT+O3tQv0Zo3ueA+WjhaPwjSm9uxQO8HYAcrRqTPq+I90B7GFecnsSGhRHcsXJKomC127pl2BPQKCrD4qMngL5TwIUl1YfsQf5AZ0YEAqSoYX6Az2QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281560; c=relaxed/simple;
	bh=1zk/Wf5UBNnW+CYKHKRvUx81qFWSHkXU/Q2Txv1Mg1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCSoJF2CXZfqJWgHrSkr1jTrHe92FarO7/C7FL1MjCL18Ru4azxXtpV6me136mvBtPby3KUOjjbj3WPuhlAwuLOfUsRzCmCJAhEZODF6U6WGcKSJsGUE+seC7NuUUwr+Mdq1T4h1TfBQetcWj2faPymwz7Y8BVxl5LqJCiSbna8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z6BlRLLn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741281558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VUWoEwD1QtHX1NkxE737fq82KwPX2Nk79R3EEcVwNlY=;
	b=Z6BlRLLnx2ZuvfUZlls4ql44b+P4vFVbOGvX4Y9h+Lw2Rh7L1oCErYGb/PJbEzNer4m9LE
	exacOxjfA2OgGf2nxqhKF4pBgQEX2U+Ou5Pw0Ors11/DAQreZwJYI51Wn+Aaz6e5TbhPoi
	NeWvJtM+a/5j6YcboqpRoLdb1WUSFnQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-wnZIkqgvOc69aRY8m1DUmw-1; Thu, 06 Mar 2025 12:19:02 -0500
X-MC-Unique: wnZIkqgvOc69aRY8m1DUmw-1
X-Mimecast-MFC-AGG-ID: wnZIkqgvOc69aRY8m1DUmw_1741281542
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-86bbd798b3cso1044329241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Mar 2025 09:19:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741281542; x=1741886342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUWoEwD1QtHX1NkxE737fq82KwPX2Nk79R3EEcVwNlY=;
        b=HrAHd7YBLHTz/HcDkp/GJ6R9DnceH3KqIz9XZ8OzNF9tTK4nQFolarv6lDQNifCAqb
         NRlzAGFTttRsy4vu5JOUUkFpsG6cwF4DZnU2JXzT/CwIXswLvFmpOGy64BG/h4D5gFIn
         XMamsc+cKLJxpxp5jT5p7C25nNlv5s2nJOfhN9G66oUbgxatOSeS1CiaB+dTA76MsAVp
         FROxLudZixkpq3PRyKSHo6V2yO7YVsv4YBSrbSqYvs3c0N/J8v03TYYK+seKvFmJkzPn
         /HqMg5lRSMp9iVPpBYp2S92u7egxy0I4+3sw9WI3CefXDZJq/2aHpcVDh0nqFgo+3T4u
         gaXg==
X-Forwarded-Encrypted: i=1; AJvYcCUiyDYbQIie2U1YsvQmFb8noPmoThVUdZIlUHIVA/tsnLpNILcAnVSsaM/HY9WC1kSvLiw0tl0PT44or69Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7OCRGLhHoREuUOGQQYeem/rVDqyA6qACbyflbh2L38HEfq4KQ
	lO5GfAkNrIN/BrjJFFXCEfenzSejqve4RZD7BaUjstWGcnT3lZK08UcYGNOPswxNk9+b9wb9JXn
	gYSkII7T6pnceYBcpS4a3RCw9lLDepJrQ/iYriykTKw/jVh4N+hzopHAFF1VELvqGdq66hJmRYG
	t3Wn5vU6j7cw2r7CmUzXgHtthADU2tTU4khId7Sw==
X-Gm-Gg: ASbGncs5nk1CRjMXEG7e/ql9Nx4AyPpOkUBsYF+HOW6fyS6/cTiAy/PX7h42noimJUY
	05aU4aoiXjHe/KkQFZDFJDrJLZwLnKaxfJ8HmbNO8QWaEai7V+Bh1Uf6/KKDKsCsP6JHVwx3T
X-Received: by 2002:a05:6102:5490:b0:4c1:9b88:5c30 with SMTP id ada2fe7eead31-4c2e292962emr5979451137.19.1741281542266;
        Thu, 06 Mar 2025 09:19:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7spgLqpPQaIcIR+gCiOtfl1Cc6hZYDhCnOcThE+Z2s7vNWkkQetRZiUqTe+9qs6bZrerq/C7urJCzh9HnSNo=
X-Received: by 2002:a05:6102:5490:b0:4c1:9b88:5c30 with SMTP id
 ada2fe7eead31-4c2e292962emr5979396137.19.1741281541943; Thu, 06 Mar 2025
 09:19:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3989572.1734546794@warthog.procyon.org.uk> <4170997.1741192445@warthog.procyon.org.uk>
 <CAO8a2Sg2b2nW6S3ctS+H0F1Owt=rAkKCyjnFW3WoRSKYD-sSDQ@mail.gmail.com>
 <CACPzV1mpUUnxpKQFtDzd25NzwooQLyyzdRhxEsHKtt3qfh35mA@mail.gmail.com>
 <128444.1741270391@warthog.procyon.org.uk> <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
In-Reply-To: <CAJ4mKGZP2a8acd3Z7OT4UxJo-eygz30_V4Ouh05daMQ=pQv4aw@mail.gmail.com>
From: Alex Markuze <amarkuze@redhat.com>
Date: Thu, 6 Mar 2025 19:18:51 +0200
X-Gm-Features: AQ5f1JpQcoMH0pu_ANh7Fi3mDGR-c82TH6fAs4PV2crn8yOt0NZj2cZVfepYRdc
Message-ID: <CAO8a2ShjbUuk9_+9P9oVcgTU87ZASNpa735xOyC+tMetL13bdA@mail.gmail.com>
Subject: Re: Is EOLDSNAPC actually generated? -- Re: Ceph and Netfslib
To: Gregory Farnum <gfarnum@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Venky Shankar <vshankar@redhat.com>, 
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Patrick Donnelly <pdonnell@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

It's not about endians. It's just about the fact that some linux
arches define the error code of EOLDSNAPC/ERETRY to a different
number.

On Thu, Mar 6, 2025 at 6:22=E2=80=AFPM Gregory Farnum <gfarnum@redhat.com> =
wrote:
>
> On Thu, Mar 6, 2025 at 6:13=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
> >
> > Venky Shankar <vshankar@redhat.com> wrote:
> >
> > > > That's a good point, though there is no code on the client that can
> > > > generate this error, I'm not convinced that this error can't be
> > > > received from the OSD or the MDS. I would rather some MDS experts
> > > > chime in, before taking any drastic measures.
> > >
> > > The OSDs could possibly return this to the client, so I don't think i=
t
> > > can be done away with.
> >
> > Okay... but then I think ceph has a bug in that you're assuming that th=
e error
> > codes on the wire are consistent between arches as mentioned with Alex.=
  I
> > think you need to interject a mapping table.
>
> Without looking at the kernel code, Ceph in general wraps all error
> codes to a defined arch-neutral endianness for the wire protocol and
> unwraps them into the architecture-native format when decoding. Is
> that not happening here? It should happen transparently as part of the
> network decoding, so when I look in fs/ceph/file.c the usage seems
> fine to me, and I see include/linux/ceph/decode.h is full of functions
> that specify "le" and translating that to the cpu, so it seems fine.
> And yes, the OSD can return EOLDSNAPC if the client is out of date
> (and certain other conditions are true).
> -Greg
>


