Return-Path: <linux-fsdevel+bounces-57365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0573B20C54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562FC3B8CB8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E6F2561A2;
	Mon, 11 Aug 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h2WrE2VM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8D02580D2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Aug 2025 14:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923080; cv=none; b=kSpQiyTWUGEaXVbfUP6HSTlQLsX9sXDUqaw9FlZXNQs0AskkSccM0q2x5+tiYA8mrEQY9OTyNN5yv0fnwmltykYI1NZsF/6kE98bry/qV6GcIHh1/r292scRnLEgGgLhCjBpEN6P1huK8XxaR++y68PrjmsiwqI2wEwZEVEW3no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923080; c=relaxed/simple;
	bh=PFgJ+zB5hVpERr6LzS1Phpz3tCMO3VqUYvX2WhQo1To=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=rQg0xTOl6sO2CIH5BrVnnwLmdN+qNEQojTvxsQEF/YuyBz2MfpfRetXr8ZokqKI16u6cb260aZB9ZN/G9eTBRuAlE9abg2SGZmNOiIKe3lK/p1O1hULldaee6oXknnsdIrBHhwgtzZuEogLl7wkgGX8Jlc52fyNq86wY3fhTO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h2WrE2VM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754923077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zj+nQGw4ZVcuIWrfoL36qS6s2se7TenOLOhyMxt+l1Q=;
	b=h2WrE2VMM0rwiwtXC6TetJgpFfnNaO/kY/HSswJ0+NC87/UuwH3BTPSV8fcmu6riuXimg5
	YgzPCJOrTYzafeM5CgbVu/x5wDGWBJMW1UCY0iCEUsTAVr4g+cvq5oXsP4hFlgVVOtRL2j
	dZZxckm7lW4rPVBMQC/Dqm/wAcavPZg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-pzW5bl4iPZ-V7ZkxMVTt5A-1; Mon,
 11 Aug 2025 10:37:54 -0400
X-MC-Unique: pzW5bl4iPZ-V7ZkxMVTt5A-1
X-Mimecast-MFC-AGG-ID: pzW5bl4iPZ-V7ZkxMVTt5A_1754923072
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9C708195609E;
	Mon, 11 Aug 2025 14:37:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.21])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 08FE91800280;
	Mon, 11 Aug 2025 14:37:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org>
References: <20250811-iot_iter_folio-v1-1-d9c223adf93c@codewreck.org> <20250811-iot_iter_folio-v1-0-d9c223adf93c@codewreck.org>
To: asmadeus@codewreck.org
Cc: dhowells@redhat.com, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
    Christian Brauner <brauner@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Andrew Morton <akpm@linux-foundation.org>,
    Maximilian Bosch <maximilian@mbosch.me>, Ryan Lahfa <ryan@lahfa.xyz>,
    Christian Theune <ct@flyingcircus.io>,
    Arnout Engelen <arnout@bzzt.net>, linux-kernel@vger.kernel.org,
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
    stable@vger.kernel.org
Subject: Re: [PATCH 1/2] iov_iter: iterate_folioq: fix handling of offset >= folio size
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <385672.1754923063.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 11 Aug 2025 15:37:43 +0100
Message-ID: <385673.1754923063@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Dominique Martinet via B4 Relay wrote:

> It's apparently possible to get an iov forwarded all the way up to the

By "forwarded" I presume you mean "advanced"?

> end of the current page we're looking at, e.g.
> =

> (gdb) p *iter
> $24 =3D {iter_type =3D 4 '\004', nofault =3D false, data_source =3D fals=
e, iov_offset =3D 4096, {__ubuf_iovec =3D {
>       iov_base =3D 0xffff88800f5bc000, iov_len =3D 655}, {{__iov =3D 0xf=
fff88800f5bc000, kvec =3D 0xffff88800f5bc000,
>         bvec =3D 0xffff88800f5bc000, folioq =3D 0xffff88800f5bc000, xarr=
ay =3D 0xffff88800f5bc000,
>         ubuf =3D 0xffff88800f5bc000}, count =3D 655}}, {nr_segs =3D 2, f=
olioq_slot =3D 2 '\002', xarray_start =3D 2}}
> =

> Where iov_offset is 4k with 4k-sized folios
> =

> This should have been because we're only in the 2nd slot and there's
> another one after this, but iterate_folioq should not try to map a
> folio that skips the whole size, and more importantly part here does
> not end up zero (because 'PAGE_SIZE - skip % PAGE_SIZE' ends up
> PAGE_SIZE and not zero..), so skip forward to the "advance to next
> folio" code.

Note that things get complicated because folioqs form a segmented list tha=
t
can be under construction as it advances.  So if there's no next folioq
segment at the time you advance to the end of the current one, it will end=
 up
parked at the end of the last folio or with slot=3D=3Dnr_slots because the=
re's
nowhere for it to advance to.  However, the folioq chain can then get
extended, so the advancer has to detect this and move on to the next segme=
nt.

Anyway:

Acked-by: David Howells <dhowells@redhat.com>

Note that extract_folioq_to_sg() already does this as does
iov_iter_extract_folioq_pages().


