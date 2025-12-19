Return-Path: <linux-fsdevel+bounces-71702-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08FCCE1E2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 02:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DE223014AD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4D5221DAC;
	Fri, 19 Dec 2025 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhtaN4LE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGj+ITNM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8758921ABB9
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766106704; cv=none; b=DZN73ulrZuWH1hGpkOEI/WkuoHhvRlDvu0ycVARQxq8gEFeKFWp8CSrt9WJobH/vJvdj6Q3whDKJiF1bzOBk4/ZazgNe6rH6ZR/mtDzhvFHpNLYLMOg83M0l5NyKRbzWrvSQuDOIh22x/RPYqDlWKacNtahNp7NIFlwt2qeRr7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766106704; c=relaxed/simple;
	bh=cypdv1WcQjsWPVmw/CKxIZtz/TZoJzZOztqX045WzdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCGuiH6z3Wf6JOwAPcoHYVpJdfD0i5J9epTb2DaadI1P08QPyJTuxYQVksbn54A+0BOielzTgLWik24v77DhwtVHbhPdHBTgQVSULcOsDR7aI6hGmA/hhFzg5I7rgXAhfUejvJnv767dzg9fIcIkdm5mx2z0codn0LDQBbJlreY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhtaN4LE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGj+ITNM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766106701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kK1BjENHT315R0V+8XhXVEsGAsXTisaxdut0tnfFRGY=;
	b=OhtaN4LEjHB/l6mRphjEtYuyt/D1PLqoPNtIbQAHHeqEgp14yGKSq6RZZgV1B9Gb4esc6Z
	fwj8GjCa2yGV5LKxxEJNeexpi88of6N3FmfKrfBHmDQ0Md3p5tp/DA89FttZzJTO8knbWE
	wks/J03YkhrU0WITdqpbiuy81EhN52E=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-qsb6T2BnOu2Sw-RLNEFsuQ-1; Thu, 18 Dec 2025 20:11:40 -0500
X-MC-Unique: qsb6T2BnOu2Sw-RLNEFsuQ-1
X-Mimecast-MFC-AGG-ID: qsb6T2BnOu2Sw-RLNEFsuQ_1766106699
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-45322138f81so2118554b6e.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766106699; x=1766711499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kK1BjENHT315R0V+8XhXVEsGAsXTisaxdut0tnfFRGY=;
        b=dGj+ITNMim6NOVeEAMHFyI7TqwZaf683IiZjWUT6VCiZdVyxXvGm3P7PgfRvGPP7oq
         7ZLzEjB3ZIEmgnhSvQcyRXr8BcwHDmDgZd40/ObF1Ase27cIod99xhDWHO0KMmA/8Rzd
         AV1ETWCj5JUqL8ZHtPayYZ2TaBKF6bfNZ/eSP3LlwYh8iUExf65tt8TZIQO7Y2/4AbKd
         TwxO2UPJ7edTFp91F/JbM/s3mta0n0Cv4d5bziJSkjKiSqCMm+ra31Ag8MKfbUKnBt+E
         F259AAVaS1Vie8iSjz2/OCkwGdD5dJtsByDximLCtYiKu37rSNj1mzIBj0hNCyebc5Ca
         Gj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766106699; x=1766711499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kK1BjENHT315R0V+8XhXVEsGAsXTisaxdut0tnfFRGY=;
        b=qsIMz/trJ1IeKJbnN9BFhNOiGrc4TfzStmKbnfPKKjMJG0MPNtGo/i2qwprzT2uVeF
         ZU3S7dlGMh7iOGYDRe2cU4kQq5DukD5EyaNJMqgINvZtnhHQzQ0e4SkZ+N0nmz4yGK9G
         RqR8YPTJxa3fuNOaJgaGfVUwX2qwBrSE6/7McKS1qcnDA3AeqWmAo89RdeVwdJOZxFBU
         L++ECPp4QhdiXfZMNqF8ILABqifUpUggayCGzRP9ktx26hgl+RCWTFxFgn3qCcTvqNgU
         8ji/FIoc6x0ev7+8TzVYMdLmWVlMQG+b+0wQHP4mjo8FxbjCgmALEL0JQcihPpgczFuw
         lv3A==
X-Forwarded-Encrypted: i=1; AJvYcCX1fj7GZXFE6nPl8u+e4JWEIXUPkJZFUYpK8w1CX07V5YeJV126ayQRDVNsHIQsAQFtc7Kk7aHjtNStxHqu@vger.kernel.org
X-Gm-Message-State: AOJu0YzjmR2Oas6MfqgNxWJMP1dATYOmEETf0GM3LXFrEqeo5IxU25KM
	xnMvTSKGxMgu4xXY05FuzJrpY4gduzOwjF9mrTHy88v2SbXnmKtgta/wVLZ1EuJ/Pnft4X24K0p
	3zkZYwn7eiTfgylQ2CkNDvzYxgoP8saSRotraiZDrtGK4E0z+IHRmIqR33owjgzBlWXsj0LGqm5
	OI8NhCdQtSOrkovWL6i4fgEOVvBGDxRPpIQynBBsiD4A==
X-Gm-Gg: AY/fxX6mAgJaFjjdvUv+y7/C08h3XHD0T3SdVXkqzVNpQxxHJoDAPmWDkMyeLuBmUjH
	+av5ke0BhmjcBuoJpll5Ge0XV88W4JHulEWX00bjJ2YmoIx/erPDv0VEQ47ueWVr+0qNMkUWetH
	+vUblulbadMUYvvUS9A+tmyPvrs4+oN8IbCZaYhCURQqbxo750AIIorNjOvy8hYdr3CSXqpPNtX
	+D6rZm/NWIGwNezJXa6BBjiXg==
X-Received: by 2002:a05:6808:e82:b0:450:c7dc:d7f6 with SMTP id 5614622812f47-457a2956782mr2011013b6e.25.1766106699400;
        Thu, 18 Dec 2025 17:11:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtVBPCCNoDj+iZNdcFdsjUyUmyVLsV5cVhaTU6hofQvRoJEGh8oFm6QrJ5JkKPTeWjcI4OOJDjXeg+R4RJsI0=
X-Received: by 2002:a05:6808:e82:b0:450:c7dc:d7f6 with SMTP id
 5614622812f47-457a2956782mr2010999b6e.25.1766106699050; Thu, 18 Dec 2025
 17:11:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215215301.10433-2-slava@dubeyko.com> <CA+2bHPbtGQwxT5AcEhF--AthRTzBS2aCb0mKvM_jCu_g+GM17g@mail.gmail.com>
 <efbd55b968bdaaa89d3cf29a9e7f593aee9957e0.camel@ibm.com> <CA+2bHPYRUycP0M5m6_XJiBXPEw0SyPCKJNk8P5-9uRSdtdFw4w@mail.gmail.com>
 <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com>
In-Reply-To: <fd1e92b107d6c36f65ebc12e5aaa7fb773608c6f.camel@ibm.com>
From: Patrick Donnelly <pdonnell@redhat.com>
Date: Thu, 18 Dec 2025 20:11:13 -0500
X-Gm-Features: AQt7F2o1xOq8N6VmFiiXc3BbbWHuTS4OE1Ez9oqQgwuW2iKClAq_iiWbHkenKdg
Message-ID: <CA+2bHPaxwf5iVo5N9HgOeCQtVTL8+LrHN_=K3EB-z+jujdGbuQ@mail.gmail.com>
Subject: Re: [PATCH v2] ceph: fix kernel crash in ceph_open()
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: Viacheslav Dubeyko <vdubeyko@redhat.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	Kotresh Hiremath Ravishankar <khiremat@redhat.com>, Alex Markuze <amarkuze@redhat.com>, 
	"idryomov@gmail.com" <idryomov@gmail.com>, Pavan Rallabhandi <Pavan.Rallabhandi@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 2:02=E2=80=AFPM Viacheslav Dubeyko
<Slava.Dubeyko@ibm.com> wrote:
>
> On Wed, 2025-12-17 at 22:50 -0500, Patrick Donnelly wrote:
> > On Wed, Dec 17, 2025 at 3:44=E2=80=AFPM Viacheslav Dubeyko
> > <Slava.Dubeyko@ibm.com> wrote:
> > >
> > > On Wed, 2025-12-17 at 15:36 -0500, Patrick Donnelly wrote:
> > > > Hi Slava,
> > > >
> > > > A few things:
> > > >
> > > > * CEPH_NAMESPACE_WIDCARD -> CEPH_NAMESPACE_WILDCARD ?
> > >
> > > Yeah, sure :) My bad.
> > >
> > > > * The comment "name for "old" CephFS file systems," appears twice.
> > > > Probably only necessary in the header.
> > >
> > > Makes sense.
> > >
> > > > * You also need to update ceph_mds_auth_match to call
> > > > namespace_equals.
> > > >
> > >
> > > Do you mean this code [1]?
> >
> > Yes, that's it.
> >
> > > >  Suggest documenting (in the man page) that
> > > > mds_namespace mntopt can be "*" now.
> > > >
> > >
> > > Agreed. Which man page do you mean? Because 'man mount' contains no i=
nfo about
> > > Ceph. And it is my worry that we have nothing there. We should do som=
ething
> > > about it. Do I miss something here?
> >
> > https://github.com/ceph/ceph/blob/2e87714b94a9e16c764ef6f97de50aecf1b0c=
41e/doc/man/8/mount.ceph.rst
> >
> > ^ that file. (There may be others but I think that's the main one
> > users look at.)
>
> So, should we consider to add CephFS mount options' details into
> man page for generic mount command?

For the generic mount command? No, only in mount.ceph(8).


--=20
Patrick Donnelly, Ph.D.
He / Him / His
Red Hat Partner Engineer
IBM, Inc.
GPG: 19F28A586F808C2402351B93C3301A3E258DD79D


