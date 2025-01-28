Return-Path: <linux-fsdevel+bounces-40252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDC1A212CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587D03A416E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 20:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257831D61B1;
	Tue, 28 Jan 2025 20:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHC5MI3o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B132729CE7
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738094479; cv=none; b=V3B90Ioh2uouyeScWVHFuyOlOyhIFwr6mGN2HfnWEBmWaVUrwdBn+SRuKyZzE2ZnwtH6S2kbl/kTIXTNJfNYMDSdu1/fqOJAifNzUFWhh7gruhmgO4akNtQSI3pnBuO2nCeYxpC2HkOutEhzXlzAm1tosZTVp9/v12fsUzYIckg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738094479; c=relaxed/simple;
	bh=GFBPua+h9W3l5orAHvCzjEKoouO8cCBGjaMclENh5lg=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=j2GQeostrTWqUbAU9DsW+jEYiYpvexiaVETC4xLLWwGevNcGou5KJjU2pbZlgjpSWNwFiVMtNVr/U0wSpGWawXoLd4b569q467DAhixsy+oGUlUQ2V4Zu4CNA3cqhQsupAWmh+8RJBdxX8yat2TLflqxfgcqqQTnOhJDK7Ncv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHC5MI3o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738094476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wIvZjl3NgMs9vTOM9Fhv0XSulPZl9EHhPaUZjLM6aYk=;
	b=LHC5MI3oqpjTH8Zs2ENgI+ptsLookQDE6/FfSH5OhuKRAMIBM0HvWpbbKtV/0wR4Iqn3q3
	ZUdixv5Nux6GYTweqSXGrhGq0JeT2C3RMWLYVgTj9x/QxuCkpfgJeLh8QoKDh7qLJyID9a
	cOjd4oBhtyFFLiQ6319IckXLbyjO4LA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-n092nb4QPhqjYRtyu1NV-g-1; Tue,
 28 Jan 2025 15:01:15 -0500
X-MC-Unique: n092nb4QPhqjYRtyu1NV-g-1
X-Mimecast-MFC-AGG-ID: n092nb4QPhqjYRtyu1NV-g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 965E119560B4;
	Tue, 28 Jan 2025 20:01:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.56])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F255A19560A7;
	Tue, 28 Jan 2025 20:01:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3469649.1738083455@warthog.procyon.org.uk>
References: <3469649.1738083455@warthog.procyon.org.uk> <3406497.1738080815@warthog.procyon.org.uk> <c79589542404f2b73bcdbdc03d65aed0df17d799.camel@ibm.com> <20250117035044.23309-1-slava@dubeyko.com> <988267.1737365634@warthog.procyon.org.uk> <CAO8a2SgkzNQN_S=nKO5QXLG=yQ=x-AaKpFvDoCKz3B_jwBuALQ@mail.gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "idryomov@gmail.com" <idryomov@gmail.com>,
    Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3532743.1738094469.1@warthog.procyon.org.uk>
Date: Tue, 28 Jan 2025 20:01:09 +0000
Message-ID: <3532744.1738094469@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

I added some tracing to fs/ceph/addr.c and this highlights the bug causing the
hang that I'm seeing.

So what I see is ceph_writepages_start() being entered and getting a
collection of folios from filemap_get_folios_tag():

    netfs_ceph_writepages: i=10000004f52 ix=0
    netfs_ceph_wp_get_folios: i=10000004f52 oix=0 ix=8000000000000 nr=6

Then we get out the first dirty folio from the batch and attempt to lock it:

    netfs_folio: i=10000004f52 ix=00003-00003 ceph-wb-lock

which succeeds.  We then pass through a number of lines:

    netfs_ceph_wp_track: i=10000004f52 line=1218

which is the "/* shift unused page to beginning of fbatch */" comment, then:

    netfs_ceph_wp_track: i=10000004f52 line=1238

which is followed by "offset = ceph_fscrypt_page_offset(pages[0]);", then:

    netfs_ceph_wp_track: i=10000004f52 line=1264

which is the error handling path of:

		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
			rc = -EIO;
			goto release_folios;
		}

and then:

    netfs_ceph_wp_track: i=10000004f52 line=1389

which is "release_folios:".

We then reenter ceph_writepages_start(), get the same batch of dirty folios
and try to lock them again:

    netfs_ceph_writepages: i=10000004f52 ix=0
    netfs_ceph_wp_get_folios: i=10000004f52 oix=0 ix=8000000000000 nr=6
    netfs_folio: i=10000004f52 ix=00003-00003 ceph-wb-lock

and that's where we hang.

I think the problem is that the error handling here:

		if (!ceph_inc_osd_stopping_blocker(fsc->mdsc)) {
			rc = -EIO;
			goto release_folios;
		}

is insufficient.  The folios are locked and can't just be released.

Why ceph_inc_osd_stopping_blocker() fails is also something that needs looking
at.

David


