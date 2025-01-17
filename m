Return-Path: <linux-fsdevel+bounces-39558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22275A15911
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 22:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FBFE3A6665
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2025 21:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27A1D5ACD;
	Fri, 17 Jan 2025 21:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSNQww9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A092B1AA1F1
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jan 2025 21:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149556; cv=none; b=COG5opcjk4tNFxHof8Dv5fDqEawq7A2OIQ2MOOVVG+y5JS0bUntNDychYmBAON9mxSaeovMXpJKDn4PdWKrkXT/foeFInjBG2EUfz5S9TL0/jLWJ+6ohFjHG94w0Paypj5/3UzadfT+EClTjr2lBxOt0INXD82oDG2yNpq4QaMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149556; c=relaxed/simple;
	bh=EkMyk43BRClIMCfAWI5j0PdG7dnC1/D0YCEJ5u5cKN0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=TSGj/Cq+qVv/a85Key5M4a4AcgWT7oNGl/hc+FzBg9vRGaukLu6Ffr646Hibz12krzhcT7vXi91RXCxuDN0ZjjeVOqLBAG+hKVVv12KXr26wegGmIvmw/RJzWjJg7dA5IHbKhTQHs1z9HLTBGh0NQi1kSXwYLaKUk0zh0cJTZvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iSNQww9n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737149553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EkMyk43BRClIMCfAWI5j0PdG7dnC1/D0YCEJ5u5cKN0=;
	b=iSNQww9nLq6DFU84z2o5O7l+30rnKTBSaUjS7oPv81BUE1B+9eK2GHw5vYeNiFs3qT9byy
	2kmK+9QXjg0cCSXhYf9q8sp6bf39QX7dmpsHEnDBjcCYxoWhw53l/qCpjlen+y+a3Ol5W6
	krbL5oplW56zg70gIFzyxVYv31FYeoY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-HuVLlw_aPUyfdGUawLwbOQ-1; Fri,
 17 Jan 2025 16:32:32 -0500
X-MC-Unique: HuVLlw_aPUyfdGUawLwbOQ-1
X-Mimecast-MFC-AGG-ID: HuVLlw_aPUyfdGUawLwbOQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28C881955DDD;
	Fri, 17 Jan 2025 21:32:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B1A63003E7F;
	Fri, 17 Jan 2025 21:32:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250117035044.23309-1-slava@dubeyko.com>
References: <20250117035044.23309-1-slava@dubeyko.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: dhowells@redhat.com, ceph-devel@vger.kernel.org, idryomov@gmail.com,
    linux-fsdevel@vger.kernel.org, amarkuze@redhat.com,
    Slava.Dubeyko@ibm.com
Subject: Re: [PATCH v2] ceph: Fix kernel crash in generic/397 test
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <887441.1737149548.1@warthog.procyon.org.uk>
Date: Fri, 17 Jan 2025 21:32:28 +0000
Message-ID: <887442.1737149548@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> The generic/397 test generate kernel crash for the case of
> encrypted inode with unaligned file size (for example, 33K
> or 1K):

By "unaligned", you mean with respect to the content crypto unit size?

David


