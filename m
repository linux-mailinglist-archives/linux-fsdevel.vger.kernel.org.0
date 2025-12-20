Return-Path: <linux-fsdevel+bounces-71800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E5DCD3187
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 16:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 024FB3012DFC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Dec 2025 15:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3584D2472BA;
	Sat, 20 Dec 2025 15:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bSPdYtKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28103A1E60
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Dec 2025 15:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766243845; cv=none; b=mkL63UGKPv2crvgCgvvqAzpdR7WdQmAKcoZlJiif1f4G59N/TNi0uSeDdEtrX2+/JZpediRUBw4spozUqFxbedSTa5gZmQ4pTzhCY0EFhpHuxajaVJMdATuZCaonaHfe6UEJDGZS1P+i6ZgSzscnbibwP95g1p5wEToxuxt0ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766243845; c=relaxed/simple;
	bh=e8z/1Np1RndNWC0tNeC0T0y+iRLoaBewoFzMNOL1kEE=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=T4bWQj+iWP/WOdflI2M+qhqcBUTvoZ9GOmv3ETw0ZYiZk4YLg1gl+aBFDnctKV5hrq2yuRkQUJLMgp4X5IQwrTCXgdzqwj7CpZDW6rz0e6kjJ4/c8kEpPJwzkpjUUhB/gBVDJfLD2PjczvvFGEk935bNP2k9WiSn1/Li8sRAEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bSPdYtKe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766243842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e8z/1Np1RndNWC0tNeC0T0y+iRLoaBewoFzMNOL1kEE=;
	b=bSPdYtKeK5q4TMNpMNWtnIXp5+RSa0Ta3/S4lL9L03cacRYC3o9RJDQLGIOH/HWbiPmz1c
	RI+VAZNE2fDk4lYdIro4OePvV0IoF3etBGQfWfLBttL7qh819lufhpgKcXaqEIEKU/t/uJ
	JQ/jYOaIguau1xfgCMdgrNHC2Bn/Ing=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-gj9iZeUoMP-3A5o7NcpMhw-1; Sat,
 20 Dec 2025 10:17:19 -0500
X-MC-Unique: gj9iZeUoMP-3A5o7NcpMhw-1
X-Mimecast-MFC-AGG-ID: gj9iZeUoMP-3A5o7NcpMhw_1766243837
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0543D19560B2;
	Sat, 20 Dec 2025 15:17:16 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.5])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E38830001A2;
	Sat, 20 Dec 2025 15:17:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8618918.T7Z3S40VBb@weasel>
References: <8618918.T7Z3S40VBb@weasel> <938162.1766233900@warthog.procyon.org.uk>
To: Christian Schoenebeck <linux_oss@crudebyte.com>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>,
    Chris Arges <carges@cloudflare.com>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <sfrench@samba.org>, v9fs@lists.linux.dev,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfs: Fix early read unlock of page with EOF in middle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <941466.1766243830.1@warthog.procyon.org.uk>
Date: Sat, 20 Dec 2025 15:17:10 +0000
Message-ID: <941467.1766243830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Christian Schoenebeck <linux_oss@crudebyte.com> wrote:

> What about write_collect.c side, is it safe as is?

That's a good question - but it should be safe since it doesn't modify the
content of the page and doesn't typically write beyond the EOF (though it
might write a block that spans the EOF marker to the cache).

David


