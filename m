Return-Path: <linux-fsdevel+bounces-52525-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1F7AE3D46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125B5188A49D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 10:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173023D28B;
	Mon, 23 Jun 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gGMIRphi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5C239E6A
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675875; cv=none; b=p7pMoZzzD2oVXTG0OEB696hCYw3sIh7w84Jk8ZwOLgprV4J0tt1r0B3fo1S1JDHcGOgTm+SttWY9v8A3ITjDwFTNnwxqs6KHHk0tdN4iJW5EEgks4tmu0YUq+tO2LE1zSzj5ITfVpcgUcluV8RILJ5vkJql+gjFN22ac7l5262g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675875; c=relaxed/simple;
	bh=UWME3XWaA3mYNTAF4jzXFx44J7v0qfaW41Ag+aZwT7k=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=Z4f4ey2nD0/VUhH0YNXJBI2AJLiLz/vIjaW7Orhk1DWzeFo3AVH3tWHTcVy3MZWdbI9/8Rjqxw1X3EvmgfEnLWpfHuP65yigEx136KDk13nztIDoSoDe9qHI43J1b7YUWttqltN+Ls7fkR3T8dmKp5SDoJlVb89l9IPNUssP3G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gGMIRphi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750675872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QsYyfB+Z7vJsNRi6uhzXLbhNGPzqKCN+qJj9FfeE5iA=;
	b=gGMIRphiJ3AR1zn3HcIhbbXn/4Q8gQhR+t8V9ppLJrB6+U5SSp2IcTHbMqS882nqY+/OQ5
	m4GztAUOCA3sqHrZI45/9BqRoScl9HyYS6HuKyjLWHay5It9AJJVPembt5+uiRURTK8amn
	MJyenULkMyaEH8xR2SnQjvjBuU+uZJA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-CFX2wP3BN9qpbl-vblsOvA-1; Mon,
 23 Jun 2025 06:51:07 -0400
X-MC-Unique: CFX2wP3BN9qpbl-vblsOvA-1
X-Mimecast-MFC-AGG-ID: CFX2wP3BN9qpbl-vblsOvA_1750675865
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E38E21809C82;
	Mon, 23 Jun 2025 10:51:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0D4A430001A1;
	Mon, 23 Jun 2025 10:50:59 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2135907.1747061490@warthog.procyon.org.uk>
References: <2135907.1747061490@warthog.procyon.org.uk> <1069540.1746202908@warthog.procyon.org.uk> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: dhowells@redhat.com, Andrew Lunn <andrew@lunn.ch>,
    Eric Dumazet <edumazet@google.com>,
    "David S. Miller" <davem@davemloft.net>,
    Jakub Kicinski <kuba@kernel.org>,
    David Hildenbrand <david@redhat.com>,
    John Hubbard <jhubbard@nvidia.com>,
    Mina Almasry <almasrymina@google.com>, willy@infradead.org,
    Christian Brauner <brauner@kernel.org>,
    Al Viro <viro@zeniv.linux.org.uk>, netdev@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: How to handle P2P DMA with only {physaddr,len} in bio_vec?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1098394.1750675858.1@warthog.procyon.org.uk>
Date: Mon, 23 Jun 2025 11:50:58 +0100
Message-ID: <1098395.1750675858@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christoph,

Looking at the DMA address mapping infrastructure, it makes use of the page
struct to access the physical address (which obviously shouldn't be a problem)
and to find out if the page is involved in P2P DMA.

dma_direct_map_page() calls is_pci_p2pdma_page():

	static inline bool is_pci_p2pdma_page(const struct page *page)
	{
		return IS_ENABLED(CONFIG_PCI_P2PDMA) &&
			is_zone_device_page(page) &&
			page_pgmap(page)->type == MEMORY_DEVICE_PCI_P2PDMA;
	}

What's the best way to manage this without having to go back to the page
struct for every DMA mapping we want to make?  Do we need to have
iov_extract_user_pages() note this in the bio_vec?

	struct bio_vec {
		physaddr_t	bv_base_addr;	/* 64-bits */
		size_t		bv_len:56;	/* Maybe just u32 */
		bool		p2pdma:1;	/* Region is involved in P2P */
		unsigned int	spare:7;
	};

I'm guessing that only folio-type pages can be involved in this:

	static inline struct dev_pagemap *page_pgmap(const struct page *page)
	{
		VM_WARN_ON_ONCE_PAGE(!is_zone_device_page(page), page);
		return page_folio(page)->pgmap;
	}

as only struct folio has a pointer to dev_pagemap?  And I assume this is going
to get removed from struct page itself at some point soonish.

David


