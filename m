Return-Path: <linux-fsdevel+bounces-43942-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACDCA602F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 21:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F319C5F25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 20:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9471F463C;
	Thu, 13 Mar 2025 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="arsDX0RU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B18B1F4284
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Mar 2025 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741898878; cv=none; b=CBW3Snhl1+BiMWJfLgx0p/C2DkJxu9oljmMCxMlmd3NCNMABiVzkooJuCoKdR4KH+kkuwHRinAqwYw8CwEaAYEULxMT7M+JWmXos6zuz6WhKXRDKUX8p5OnjMxc68ydAbCnYnrmZS0qRotsDHQdKtKp19rA22id2pspSaUyIKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741898878; c=relaxed/simple;
	bh=BJAL/2BqmnF2wqJ0CNyA2TidlwFu13d/cuLzBvREwgM=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sZXRCRQL7Ulee/USd+KBWWieW3eE96Fe9aSkfsWVUmR3vk2NsCj3vYvpyxBCBrM+kGxR+mkBWBRjiVa+dLxVqv55fRQxUfHTry3gUCyxwjSybNX71uLeoKAc35kB75cZroxtGK7fnCUv3Bc0ihnfQqy4Hp+cI5NsFNjCdWva2Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=arsDX0RU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741898876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6524Cf8HlDwGjtyKBEw77UKWV6Y0ZpYj68qA0nrJekk=;
	b=arsDX0RU5EI2898nRZ6O6GFhuRN7rOVdZDLqqUWcKEEkupGXeMn1bVGiweLnkCbjBGgkdE
	b0ZoJkGIfnaHxB7khJMKGVvEX+y3tvsUFDMCAAbQeGKQnkRN3U+BiOU1dZ3W/4MFiX9V4d
	YBYJ0DcXzQc8d2MpIcejptCtmt2Fvhc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-XrGS2Ke0P9Ki2Sy3jOvxVg-1; Thu,
 13 Mar 2025 16:47:52 -0400
X-MC-Unique: XrGS2Ke0P9Ki2Sy3jOvxVg-1
X-Mimecast-MFC-AGG-ID: XrGS2Ke0P9Ki2Sy3jOvxVg_1741898871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C6271955E80;
	Thu, 13 Mar 2025 20:47:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29AF21955BCB;
	Thu, 13 Mar 2025 20:47:47 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com>
References: <3cc1ac78a01be069f79dcf82e2f3e9bfe28d9a4b.camel@dubeyko.com> <1385372.1741861062@warthog.procyon.org.uk>
To: slava@dubeyko.com
Cc: dhowells@redhat.com, Alex Markuze <amarkuze@redhat.com>,
    Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, ceph-devel@vger.kernel.org,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    Slava.Dubeyko@ibm.com
Subject: Re: Does ceph_fill_inode() mishandle I_NEW?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1468675.1741898867.1@warthog.procyon.org.uk>
Date: Thu, 13 Mar 2025 20:47:47 +0000
Message-ID: <1468676.1741898867@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

slava@dubeyko.com wrote:

> What do you mean by mishandling? Do you imply that Ceph has to set up
> the I_NEW somehow? Is it not VFS responsibility?

No - I mean that if I_NEW *isn't* set when the function is called,
ceph_fill_inode() will go and partially reinitialise the inode.  Now, having
reviewed the code in more depth and talked to Jeff Layton about it, I think
that the non-I_NEW pass will only change pointers with some sort of locking
and will release the old target - though it may overwrite some pointers with
the same value without protection (i_fops for example).

That said, if it's possible for *two* processes to be going through that
function without I_NEW set, you can get places where both of them will try
freeing the old data and replacing it with new without any locking - but I
don't know if that can happen.

David


