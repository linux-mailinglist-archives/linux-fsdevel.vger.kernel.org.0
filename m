Return-Path: <linux-fsdevel+bounces-7076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E9E821962
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 11:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54D741C21B87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jan 2024 10:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33259DDC9;
	Tue,  2 Jan 2024 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FwV3rcr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6413ADDAD
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jan 2024 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704189844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ny2AxAZYQ7Swi2tyUfwPdF1yJ0tRqtIF7a9WoAXifeI=;
	b=FwV3rcr7rOuCgZZYQwmdK6sJBserHqGLJ7Vse2/tSOTQy7Hbn1+98r8NPi3g9WvhyxRF20
	/JF5Efa34csfnOfqOBbzWgDf15DZHUPlOH8u9q8sOIFg2E67YzQhW1muC4oFmrfGUb9FN8
	6CtSJKC8NndKSJ8+yYPFVAaFfK3Tyjo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-aZo05vPBPjuywjIBm9BzJA-1; Tue, 02 Jan 2024 05:04:00 -0500
X-MC-Unique: aZo05vPBPjuywjIBm9BzJA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 49075101A52A;
	Tue,  2 Jan 2024 10:04:00 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7B44A2166B31;
	Tue,  2 Jan 2024 10:03:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZZPUKHTQ//eL53SM@casper.infradead.org>
References: <ZZPUKHTQ//eL53SM@casper.infradead.org> <3490948.1704185806@warthog.procyon.org.uk>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Christoph Hellwig <hch@lst.de>,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: Re: bio_vec, bv_page and folios
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5778.1704189838.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2024 10:03:58 +0000
Message-ID: <5779.1704189838@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jan 02, 2024 at 08:56:46AM +0000, David Howells wrote:
> > Hi Christoph, Willy,
> > =

> > Will bv_page in struct bio_vec ever become a folio pointer rather than=
 I page
> > pointer?  I'm guessing not as it still presumably needs to be able to =
point to
> > non-folio pages.
> =

> My plan for bio_vec is that it becomes phyr -- a physical address +
> length.  No more page or folio reference.

Interesting...  What does that mean for those places that currently use
bv_page as a place to stash a pointer to the page and use it to clean up t=
he
page later?

David


