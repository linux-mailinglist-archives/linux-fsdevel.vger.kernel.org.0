Return-Path: <linux-fsdevel+bounces-44223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C3A6615A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 23:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3E223A7780
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F8204C0A;
	Mon, 17 Mar 2025 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8zLKMb3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2D9202C40
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 22:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742249546; cv=none; b=QpmchkQqGoWmvRrWWHk6vDxIE1M+aOVBKX0OZ8MN96rPRSHhqV/lpKhjoXd+/8s40e3r6fZdgVNbcMkmcTj3EetOd5PR2OD5V7kjj7hF/rthZ1u0rGRFDgEGGlMq2z271jreHS5nLxr06D1oLyiJFjrYqw/wIRdJF9ibYgeeXgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742249546; c=relaxed/simple;
	bh=usLCjoxsqNxSzSutwumY5Uq3e0q2VzW9jIdFhiDVJe0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=HOIw5pzXszq9lYYLsBi3xTPn5GPw+H6Kmu/cNgYVfmWTI9VJJNdtb51vfyxTTT6XUEZuZaEPEt3o1FjWzlXE/WGTMz6NCYV6/lkgi9xH4H4csxw3Vio8hDfWWZafaEkqKqa3CLOK1C8prt0oNtXizs3q18nrPNxQc7S6CHq9HUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8zLKMb3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742249543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6pVRX09G0SFKsJWurQ5KQ9f6tFMu5DS0xLdXsv+JFok=;
	b=B8zLKMb39XNCrK+nNM+CSNe6HIP4Zeqo/kSANd/ua5D/z36QLb3jLY0ccYyeRk/LQZPn7P
	tQh6VawX0x/1j6nrcNI/mwjCEXdw6M+n6xouY1eCbEEVbuEF8uEzaaS6CyAc5tPKtaR0hr
	YpurGdouv5XWWRFB3vqk6GYHQZLBrTA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-cq-J--F_NJ25fhgySNfabQ-1; Mon,
 17 Mar 2025 18:12:20 -0400
X-MC-Unique: cq-J--F_NJ25fhgySNfabQ-1
X-Mimecast-MFC-AGG-ID: cq-J--F_NJ25fhgySNfabQ_1742249538
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7D16E19560BB;
	Mon, 17 Mar 2025 22:12:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A180118001EF;
	Mon, 17 Mar 2025 22:12:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <9a4b6142448b70ca4cfad092219b3e23841dd961.camel@ibm.com>
References: <9a4b6142448b70ca4cfad092219b3e23841dd961.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-8-dhowells@redhat.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    "slava@dubeyko.com" <slava@dubeyko.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/35] libceph: Change ceph_osdc_call()'s reply to a ceph_databuf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2342308.1742249533.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 22:12:13 +0000
Message-ID: <2342310.1742249533@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +	struct ceph_databuf *reply;
> > +	void *p, *q, *end;
> =

> If I understood correctly the logic, q represents a pointer on current
> position.  So, maybe, it makes sense to rename p into something like
> "begin"? In this case, we will have begin pointer, end pointer and p cou=
ld
> be used as the name of pointer on current position.

"hdr" might be a better choice.

> > +	iov_iter_advance(&reply->iter, q - p);
> >  =

> > -	if (offset_in_page(p) + object_map_bytes > reply_len) {
> > +	if (object_map_bytes > ceph_databuf_len(reply)) {
> =

> Does it mean that we had bug before here? Because it was offset_in_page(=
p) +
> object_map_bytes before.

No.  The iov_iter_advance() call advances the iterator over the header whi=
ch
renders the subtraction unnecessary.

> >  	rbd_dev->object_map_size =3D object_map_size;
> =

> Why do we have object_map_size and object_map_bytes at the same time? It=
 could
> be confusing for my taste. Maybe, we need to rename the object_map_size =
to
> object_map_num_objects?

Those names preexist.

> > +	reply =3D ceph_databuf_reply_alloc(1, inbound_size, GFP_KERNEL);
> =

> Interesting... We allocated memory page before. Now we allocate the memo=
ry
> of inbound size. Potentially, it could be any size of starting from zero
> bytes and including several memory pages. Could we have an issue here?

Shouldn't do.  ceph_databuf_reply_alloc() will expand databuf's bvec[] as
necessary to accommodate sufficient pages for the requested amount of
bufferage.

David


