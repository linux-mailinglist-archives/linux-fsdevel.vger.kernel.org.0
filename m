Return-Path: <linux-fsdevel+bounces-41740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB3A36453
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 18:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501EE3B2225
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2025 17:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034082690D0;
	Fri, 14 Feb 2025 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dmH6fF//"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A126869E
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2025 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739553578; cv=none; b=Y7W6nmgZqez/S5BI3OsG7bpqQxTjBhsKn6GG5pUgwElp34IW1yPgbsdRkJhJ/s55MocWjbTsWCq13A06txcR9jVZ95GHKELb/KETE/ARiYhDqLB7i9NcBL91p3icgEg4sZRnLEZDQXr+4P0KfPg96YcFHQVhj65wc5XZOv2MX68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739553578; c=relaxed/simple;
	bh=htfsxT6ZOYRxUgoN1uX19Eysgkq3E6IWloBbUVZgt4k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ZLywsmKqdKdJZciVu1aeEYJNr8p0jme93NgXqmDBxKxGKDQVeXl+ENAaTw6zeGRX4jJNB6gbLYhwBBo9+YOU8mnphsrinnOyXoGkMw8eRfzmN1ZpJUqaeAeUG7DXp5fKJg/CD5fu9IEs9Zq6U4Gaqnw+puDOOH0a5NRIVa0S9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dmH6fF//; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739553575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jGTD3k8czPc44V9vRLr5CqMTjZnNp6WpN4+hddmhCe4=;
	b=dmH6fF//m7DsHcKH9Q5f7rXEtrlvT5CIuKGixlbmK06Pw9ucLc4bbwfKvMlTb0gwohhQHa
	GUjxRi/x/Ym4U/ywZ7o8XyrFl9jaKdLtRi6vb3Hs6pBIigtX5u0yQQnoGW9dewq+SkVhhS
	btttUq6gqN72gSgcfoze6m7qrTp8Lho=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-nfAN1-VvPH2Bp_FuIJBp0Q-1; Fri,
 14 Feb 2025 12:19:32 -0500
X-MC-Unique: nfAN1-VvPH2Bp_FuIJBp0Q-1
X-Mimecast-MFC-AGG-ID: nfAN1-VvPH2Bp_FuIJBp0Q_1739553571
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 196AD196E078;
	Fri, 14 Feb 2025 17:19:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.92])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F9B81800352;
	Fri, 14 Feb 2025 17:19:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250205000249.123054-1-slava@dubeyko.com>
References: <20250205000249.123054-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com,
    linux-fsdevel@vger.kernel.org, pdonnell@redhat.com,
    amarkuze@redhat.com, Slava.Dubeyko@ibm.com
Subject: Re: [RFC PATCH 0/4] ceph: fix generic/421 test failure
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4153979.1739553567.1@warthog.procyon.org.uk>
Date: Fri, 14 Feb 2025 17:19:27 +0000
Message-ID: <4153980.1739553567@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Okay...   I *think* that fixes the hang.  There was one case where I saw the
hang, but I'm not sure that I had your patches applied or whether I'd managed
to boot the previous kernel that didn't.

So, just with respect to fixing the hang:

	Tested-by: David Howells <dhowells@redhat.com>

There's still the issue of encrypted filenames occasionally showing through
which generic/397 is showing up - but I don't think your patches here fix
that, right?

David


