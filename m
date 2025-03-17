Return-Path: <linux-fsdevel+bounces-44224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A3A6618B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 23:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8183A9141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 22:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51454204597;
	Mon, 17 Mar 2025 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDt8/09+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A0202C47
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Mar 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742250376; cv=none; b=DEttwVVsktJTycKRBfQV0HXuXWjG9heOrMZ0ryVLX6cJUSLRV7dt2YNk3oGeqKBLlDU6E7QE73YmlUPsXbg4pC6leMxU+aBwgAk/duwA1leR+67Gf75FEvO7k1yYT23gI8tnYlikPv0P1CRoicPdtJJtGPAG4OSuFJWpcV6utZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742250376; c=relaxed/simple;
	bh=MFJ0Lo//Ju5gWfi71VQ1cgg5LNab7fehD2stzF52p+M=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=eG+XsHDn0c5VDhKPduwuPC1mggAblde2XOq4NCN14fhgwQKZluNdBKf1P4cQL6dMHGdAIjqFkG88eP30Zfb++zhw9QCfqaAKB78ZK5a+PJuEZ/xHMiMg6kTnof89oEp7clOLp2QYiFl8FN3kPUHJBWYOH//iARAGejdE8JOgqC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDt8/09+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742250374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4S2fQMl2F6KY1Aue5YIw362BMJ8oJdYbwC8OSZWD64s=;
	b=CDt8/09+8WRtT8U6/tP1LpeAaUPata/U/f65sO3J+kWpPT5k47ckN8jvYgh6kirR7vQzhj
	s5KeMguHQpjedNLO/pZfwUm3IZ6mBvXl4gL6L/Ao1DNgbdGf2/wJhsvgURLq258xl6WEwA
	o+gU/tldWQk3udjwRD2hIbFPaUl4Ywk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-lT_RFLNjMGO0waXDPzTY3A-1; Mon,
 17 Mar 2025 18:26:10 -0400
X-MC-Unique: lT_RFLNjMGO0waXDPzTY3A-1
X-Mimecast-MFC-AGG-ID: lT_RFLNjMGO0waXDPzTY3A_1742250369
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8291E1800257;
	Mon, 17 Mar 2025 22:26:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A1901800268;
	Mon, 17 Mar 2025 22:26:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <90a695663117ec2822c7384af3943c9d4edcc802.camel@ibm.com>
References: <90a695663117ec2822c7384af3943c9d4edcc802.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-12-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 11/35] ceph: Use ceph_databuf in DIO
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2342924.1742250364.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Mar 2025 22:26:04 +0000
Message-ID: <2342925.1742250364@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > +					    ITER_GET_BVECS_PAGES, &start);
> > +		if (bytes < 0) {
> > +			if (size =3D=3D 0)
> > +				return bytes;
> > +			break;
> =

> I am slightly confused by 'break;' here. Do we have a loop around?

Yes.  You need to look at the original code as the while-directive didn't =
make
it into the patch context;-).

> > -	return size;
> > +	return 0;
> =

> Do we really need to return zero here? It looks to me that we calculated=
 the
> size for returning here. Am I wrong?

The only caller only cares if an error is returned.  It doesn't actually c=
are
about the size.  The size is stored in the databuf anyway.

> > +		dbuf =3D ceph_databuf_req_alloc(npages, 0, GFP_KERNEL);
> =

> I am still feeling confused of allocated npages of zero size. :)

That's not what it's saying.  It's allocating npages' worth of bio_vec[] a=
nd
not creating any bufferage.  The bio_vecs will be loaded from a DIO reques=
t.
As mentioned in a previous reply, it might be worth creating a separate
databuf API call for this case.

> > -static void put_bvecs(struct bio_vec *bvecs, int num_bvecs, bool shou=
ld_dirty)
> > +static void ceph_dirty_pages(struct ceph_databuf *dbuf)
> =

> Does it mean that we never used should_dirty argument with false value? =
Or the
> main goal of this method is always making the pages dirty?
> =

> >  {
> > +	struct bio_vec *bvec =3D dbuf->bvec;
> >  	int i;
> >  =

> > -	for (i =3D 0; i < num_bvecs; i++) {
> > -		if (bvecs[i].bv_page) {
> > -			if (should_dirty)
> > -				set_page_dirty_lock(bvecs[i].bv_page);
> > -			put_page(bvecs[i].bv_page);
> =

> So, which code will put_page() now?

The dirtying of pages is split from the putting of those pages.  The datab=
uf
releaser puts the pages, but doesn't dirty them.  ceph_aio_complete_req()
needs to do that itself.  Netfslib does this on behalf of the filesystem a=
nd
switching to that will delegate the responsibility.

Also in future, netfslib will handle putting the page refs or unpinning th=
e
pages as appropriate - and ceph should not then take refs on those pages
(indeed, as struct page is disintegrated into different types such as foli=
os,
there may not even *be* a ref counter on some of the pages).

David


