Return-Path: <linux-fsdevel+bounces-37757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A1E09F6E7C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 20:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D7116F6AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Dec 2024 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8FE1FC7D0;
	Wed, 18 Dec 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iFmAy4MZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9871B1FC7CC
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Dec 2024 19:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551297; cv=none; b=Y2hEdgOt5itrK24zEDkeWQslPB6hnJleJ1EcjbiuPGw2A4n0upUJpJX4PTjKEFzI3T16TYbkZbIHGpWrW/d49riFBH+4lF7D1lgdgj3/OgmCHZlDs7Ed08ky1Y/Yy6trzJZmHMEk3xCQQSOGqco6fcNUntO5WRoNPC6JdDORxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551297; c=relaxed/simple;
	bh=rhGlXkPY7EI8Yz+uLt450QDS4ROFG/DcI3cx4MA07m4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=qIpJhhxzDDwenHjKcnMMLcGBlSbAV7UESOHWvxVxwrFpEf1+MExqt+61dH+AYi5xae5uY8b+zDWwmaifLzCau5rJBh63zoBs3t+JVky4HvvrQVAp4QLUoC/i1Z0i1YaxX9157Re6dkg1etPnXom6xl5z8P04UcAMNl7lwlzhkGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iFmAy4MZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734551294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XhDBuHs14TqcMJz/vYztmTvQ51mJNqS6N8qyOPSaf1E=;
	b=iFmAy4MZMMZ+S1qTnnXG1fUujjIfCFmMxEiWFvScSRl2rYFDI69QzdPCMLiIjzPkXVJhny
	7ZOGIuuIR9C3ZcG6Sqj4ZoG5sLzOchnbG3MWHM8pbQn5FQSy5isrGXUOT7qaDF1WjTEz+Y
	IO1e3teJvkal65bOW7QgiGay2Ju6usM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-E3CQrFw5PtWnqEn7JGLWrg-1; Wed,
 18 Dec 2024 14:48:11 -0500
X-MC-Unique: E3CQrFw5PtWnqEn7JGLWrg-1
X-Mimecast-MFC-AGG-ID: E3CQrFw5PtWnqEn7JGLWrg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F093319560B2;
	Wed, 18 Dec 2024 19:48:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9EDF819560A2;
	Wed, 18 Dec 2024 19:48:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
References: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com> <3989572.1734546794@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    Xiubo Li <xiubli@redhat.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "netfs@lists.linux.dev" <netfs@lists.linux.dev>
Subject: Re: Ceph and Netfslib
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Dec 2024 19:48:06 +0000
Message-ID: <3992139.1734551286@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > Firstly, note that there may be a bug in ceph writeback cleanup as it
> > stands.
> > It calls folio_detach_private() without holding the folio lock (it
> > holds the
> > writeback lock, but that's not sufficient by MM rules).=C2=A0 This means
> > you have a
> > race between { setting ->private, setting PG_private and inc refcount
> > } on one
> > hand and { clearing ->private, clearing PG_private and dec refcount }
> > on the
> > other.
> >=20
>=20
> I assume you imply ceph_invalidate_folio() method. Am I correct here?

Actually, no, writepages_finish() is the culprit.

ceph_invalidate_folio() is called with the folio locked and can freely wran=
gle
folio->private.

> > Secondly, there's a counter, ci->i_wrbuffer_ref, that might actually be
> > redundant if we do it right as I_PINNING_NETFS_WB offers an alternative
> > way we might do things.  If we set this bit, ->write_inode() will be
> > called with wbc->unpinned_netfs_wb set when all currently dirty pages h=
ave
> > been cleaned up (see netfs_unpin_writeback()).  netfslib currently uses
> > this to pin the fscache objects but it could perhaps also be used to pin
> > the writeback cap for ceph.
>=20
> Yeah, ci->i_wrbuffer_ref looks like not very reliable programming
> pattern and if we can do it in other way, then it could be more safe
> solution. However, this counter is used in multiple places of ceph
> code. It needs to find a solution to get rid of this counter in safe
> and easy way.
>=20
> >=20
> > Thirdly, I was under the impression that, for any given page/folio,
> > only the
> > head snapshot could be altered - and that any older snapshot must be
> > flushed
> > before we could allow that.
> >=20
> >=20
> > Fourthly, the ceph_snap_context struct holds a list of snaps.=C2=A0 Does
> > it really
> > need to, or is just the most recent snap for which the folio holds
> > changes
> > sufficient?
> >=20
>=20
> Let me dive into the implementation details. Maybe, Alex can share more
> details here.

Thanks.

David


