Return-Path: <linux-fsdevel+bounces-44656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F891A6B03F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 23:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74CE189F328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 22:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1919322A4F3;
	Thu, 20 Mar 2025 22:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJgU/vas"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7AB1F7074
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Mar 2025 22:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742508115; cv=none; b=bjK2YG8lBnnnryv9ghKb1h108qgmoyJF/GU2QzDmt674XBtcipPphc5QCerxF7lTmZk448nPRCl2p0pYMCvB9m4imoMdEPfp3v7plekGugBWm14Gkbgi5KboflVHbSOLQJRr2szPedfthI72bIyq3apb8xWn1K0XhIsJ4lhPgOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742508115; c=relaxed/simple;
	bh=l46e7WvQp7J+u4Z5EX8AQyZh+dGtvJNmAWmfgvlr7CM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=k78ZiInjxVomfKMQEr9YJUVW0Hu7uhhXIAXobLh3jvxEq1/WXHi3sT5CkF2g22Am+EGZgGgQqq6Djf6uujdDnznjJ9fuu4/+9KKlkzk4QfAAd8BekusWm76D0NuexGcAIR91Pr5uz2mXGXaBW33FIjM0KZPismwZDOy0ENa6Aug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJgU/vas; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742508112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3pVNFaMrkkMNH1afwjuMhJu9nhsFzBTmbXX/DA+H+oU=;
	b=AJgU/vasrsGmQrflmJ8X3Yyp4Xu46sXPcL2+FLVv4PWCZkSJJP/toi0rRUy6iIVHk46xR/
	R0zNnhpEtWeu87Kq3ReqosJKbdYwqSII+Sb38WF4qaeFdIP3ODmbh58epVSaGBefUM5g8a
	6JpqUUBChUOnSayrF0N32V3fRW6QRG8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-DoN8hO2rPGWqv68As9fzgw-1; Thu,
 20 Mar 2025 18:01:49 -0400
X-MC-Unique: DoN8hO2rPGWqv68As9fzgw-1
X-Mimecast-MFC-AGG-ID: DoN8hO2rPGWqv68As9fzgw_1742508108
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74367180882E;
	Thu, 20 Mar 2025 22:01:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D710D3001D1F;
	Thu, 20 Mar 2025 22:01:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3fa0bf814ce79765c88211990644a010197b11bf.camel@ibm.com>
References: <3fa0bf814ce79765c88211990644a010197b11bf.camel@ibm.com> <a62918950646701cb9bb2ab0a32c87b53e2f102e.camel@dubeyko.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-5-dhowells@redhat.com> <2161520.1742212378@warthog.procyon.org.uk>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: dhowells@redhat.com, "slava@dubeyko.com" <slava@dubeyko.com>,
    "dongsheng.yang@easystack.cn" <dongsheng.yang@easystack.cn>,
    "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
    "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
    Alex Markuze <amarkuze@redhat.com>,
    "jlayton@kernel.org" <jlayton@kernel.org>,
    "idryomov@gmail.com" <idryomov@gmail.com>,
    "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH 04/35] ceph: Convert ceph_mds_request::r_pagelist to a databuf
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3188325.1742508102.1@warthog.procyon.org.uk>
Date: Thu, 20 Mar 2025 22:01:42 +0000
Message-ID: <3188326.1742508102@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> > > > +	if (ceph_databuf_insert_frag(dbuf, 0, sizeof(*header),
> > > > GFP_KERNEL) < 0)
> > > > +		goto out;
> > > > +	if (ceph_databuf_insert_frag(dbuf, 1, PAGE_SIZE, GFP_KERNEL)
> > > > < 0)
> > > >  		goto out;
> > > >  
> > > > +	iov_iter_bvec(&iter, ITER_DEST, &dbuf->bvec[1], 1, len);
> > > 
> > > Is it correct &dbuf->bvec[1]? Why do we work with item #1? I think it
> > > looks confusing.
> > 
> > Because you have a protocol element (in dbuf->bvec[0]) and a buffer (in
> > dbuf->bvec[1]).
> 
> It sounds to me that we need to have two declarations (something like this):
> 
> #define PROTOCOL_ELEMENT_INDEX    0
> #define BUFFER_INDEX              1

But that's specific to this particular usage.  There may or may not be a
frag/page allocated to a protocol element and there may or may not be buffer
parts and may be multiple buffer parts.  There could even be multiple pages
allocated to protocol elements.

David


