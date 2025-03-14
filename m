Return-Path: <linux-fsdevel+bounces-44041-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E0DA61BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 21:09:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF873A14BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Mar 2025 20:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C776221D85;
	Fri, 14 Mar 2025 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d9+Gda3K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1294217F56
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Mar 2025 20:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741982523; cv=none; b=nPH5cXJUEibjgA0KwyNB6XtZL2BV/7vfRDZJaJVk5ov0t4Qss8qxcF9yJQtnXsu5sNNj+DViU4DTn8iIR+iDHStsxRdevwoL6pem13njD6wShq+kUwIOgS8z8EhJenMj1Rxt4qWbd8vGShQ7vUilL5QlEslkHI8gwE6A6rAVG4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741982523; c=relaxed/simple;
	bh=IOnoKm30i2gTvyFK+uUTrGFu6CKL9+fAN1uynEfTKNU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=s8YfbeMOtN7KFzE5Ac9FmcBi9V2RsAPV+MGteqynIOPYnVDlHvV56ynA8ZcAhkhLK7V6d9amdLI/yeZ28AkD+GLrp9NMCOKkyv3u70BeoBSlW6+5lGxiSldiNVDWumvZ1j2dqZA4JQ7Sq8DuxSVcrBw9iJUSX2r1P5uA0kHWP1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d9+Gda3K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741982520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sP7bsciAed3mv4rlNhBPKL9uchv7k0Ev3qtjfqaxmQQ=;
	b=d9+Gda3Ka3sLWxtBDE0EHo43hbAGqyz8UwfKzzUdiWt+Rw/Y58B7PCT1BfNzgOgT6s/v0d
	mHiqQUyLfkuUggkr3xO5284J7VDZPgmC8+gsFT7IXyLCsUpBfkHYQSy/QIOLhlVl6zTFFw
	J1R7uyPoI0CVZZuubMIbMnEYxXJZtRY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-oQaF7_6DNZScfQClf4zY5A-1; Fri,
 14 Mar 2025 16:01:57 -0400
X-MC-Unique: oQaF7_6DNZScfQClf4zY5A-1
X-Mimecast-MFC-AGG-ID: oQaF7_6DNZScfQClf4zY5A_1741982515
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52E94195608A;
	Fri, 14 Mar 2025 20:01:55 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A5CC73003902;
	Fri, 14 Mar 2025 20:01:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f6be2823c1bfd37cb7629feb40a1a579bb9378d6.camel@ibm.com>
References: <f6be2823c1bfd37cb7629feb40a1a579bb9378d6.camel@ibm.com> <20250313233341.1675324-1-dhowells@redhat.com> <20250313233341.1675324-3-dhowells@redhat.com>
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
Subject: Re: [RFC PATCH 02/35] libceph: Rename alignment to offset
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1998183.1741982510.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Mar 2025 20:01:50 +0000
Message-ID: <1998185.1741982510@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <Slava.Dubeyko@ibm.com> wrote:

> >  		struct {
> >  			struct page	**pages;
> =

> Do we still operate by pages here? It looks like we need to rework it so=
mehow.

One of the points of these patches is to rework this, working towards redu=
cing
everything to just an iterator where possible, using a segmented list as t=
he
actual buffers.

One of the things hopefully to be discussed at LSF/MM is how we might comb=
ine
struct folio_queue, struct bvec[] and struct scatterlist into something th=
at
can hold references to more general pieces of memory and not just folios -=
 and
that might be something we can use here for handing buffers about.

Anyway, my aim is to get all references to pages and folios (as far as
possible) out of 9p, afs, cifs and ceph - delegating all of that to netfsl=
ib
for ceph (rbd is slightly different - but I've completed the transformatio=
n
there).

Netfslib will pass an iterator to each subrequest describing the buffer, a=
nd
we might need to go from there to another iterator describing a bounce buf=
fer
for transport encryption, but from there, we should pass the iterator dire=
ctly
to the socket.

Further, I would like to make it so that we can link these buffers togethe=
r
such that we can fabricate an entire message within a single iterator - an=
d
then we no longer need to cork the TCP socket.

David


