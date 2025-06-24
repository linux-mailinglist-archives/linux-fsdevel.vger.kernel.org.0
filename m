Return-Path: <linux-fsdevel+bounces-52718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35196AE6026
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D3D23BAFE0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4350B27AC25;
	Tue, 24 Jun 2025 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cFLfhDEO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E162777F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Jun 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755751; cv=none; b=IuW65d5ejeXIHU3UDAXT/eyzTRE6ABOrc6+79pXOiQuHQ9tq2+nmLu0X5r5swGgf7JniKmWJeznIRycZNPh/pRH5pFZKKZwbiF7Ig+dHbTmZNgzWaEzNYIFfx4PgXNrAKwDYu9c+ecPuQhZOQeRnviX+HWVRLCh0u24vrksaoqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755751; c=relaxed/simple;
	bh=JP89Vj/TbeY6UC2SgI40l+r8YLLxMD0iD9JJ5lKeLaQ=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BopGbiLeYo9Qovb97rLqQBhOS2RLgAN86/LTumcwud7bs+ngkVHTCxR5RsAbR8njmIlzXiQ9UXFrcVMXcAAIebtLUPvtgfQBr54yyfza9IrRPSGVB/F6H/qf+UPgbGPtVmyK+onWc5OWRyFtLJ3nsVEUSDiVMpDYPmDc2GEiD1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cFLfhDEO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750755748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlOdlXhfpJ2qnP2BlVlsaFgHtdVv+17pO3XA1MNaXFU=;
	b=cFLfhDEOfzkm1NVSTM8+CXlkJfH14nyoi9ynWCeAhxbSw1AQutdialwYOpKbSEokDE/B5B
	9s+YVPzlwpAg3xZzOlvU8AulvJay3s/mYU5ODIt4OD64t3hApWQBRpN3MQxsxbMemnsk3x
	/FhXGe7m9QqxvdGfwCbk7+uhdaI7/Ns=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-psbfh304N8yHCFiaoILq0w-1; Tue,
 24 Jun 2025 05:02:22 -0400
X-MC-Unique: psbfh304N8yHCFiaoILq0w-1
X-Mimecast-MFC-AGG-ID: psbfh304N8yHCFiaoILq0w_1750755739
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC1561956046;
	Tue, 24 Jun 2025 09:02:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6E92618046C4;
	Tue, 24 Jun 2025 09:02:07 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <aFlaxwpKChYXFf8A@infradead.org>
References: <aFlaxwpKChYXFf8A@infradead.org> <2135907.1747061490@warthog.procyon.org.uk> <1069540.1746202908@warthog.procyon.org.uk> <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch> <0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch> <1015189.1746187621@warthog.procyon.org.uk> <1021352.1746193306@warthog.procyon.org.uk> <1098395.1750675858@warthog.procyon.org.uk>
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
    linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
    Logan Gunthorpe <logang@deltatee.com>,
    Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: How to handle P2P DMA with only {physaddr,len} in bio_vec?
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1143686.1750755725.1@warthog.procyon.org.uk>
Date: Tue, 24 Jun 2025 10:02:05 +0100
Message-ID: <1143687.1750755725@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, Jun 23, 2025 at 11:50:58AM +0100, David Howells wrote:
> > What's the best way to manage this without having to go back to the page
> > struct for every DMA mapping we want to make?
> 
> There isn't a very easy way.  Also because if you actually need to do
> peer to peer transfers, you right now absolutely need the page to find
> the pgmap that has the information on how to perform the peer to peer
> transfer.

Are you expecting P2P to become particularly common?  Because page struct
lookups will become more expensive because we'll have to do type checking and
Willy may eventually move them from a fixed array into a maple tree - so if we
can record the P2P flag in the bio_vec, it would help speed up the "not P2P"
case.

> > Do we need to have
> > iov_extract_user_pages() note this in the bio_vec?
> > 
> > 	struct bio_vec {
> > 		physaddr_t	bv_base_addr;	/* 64-bits */
> > 		size_t		bv_len:56;	/* Maybe just u32 */
> > 		bool		p2pdma:1;	/* Region is involved in P2P */
> > 		unsigned int	spare:7;
> > 	};
> 
> Having a flag in the bio_vec might be a way to shortcut the P2P or not
> decision a bit.  The downside is that without the flag, the bio_vec
> in the brave new page-less world would actually just be:
> 
> 	struct bio_vec {
> 		phys_addr_t	bv_phys;
> 		u32		bv_len;
> 	} __packed;
> 
> i.e. adding any more information would actually increase the size from
> 12 bytes to 16 bytes for the usualy 64-bit phys_addr_t setups, and thus
> undo all the memory savings that this move would provide.

Do we actually need 32 bits for bv_len, especially given that MAX_RW_COUNT is
capped at a bit less than 2GiB?  Could we, say, do:

 	struct bio_vec {
 		phys_addr_t	bv_phys;
 		u32		bv_len:31;
		u32		bv_use_p2p:1;
 	} __packed;

And rather than storing the how-to-do-P2P info in the page struct, does it
make sense to hold it separately, keyed on bv_phys?

Also, is it possible for the networking stack, say, to trivially map the P2P
memory in order to checksum it?  I presume bv_phys in that case would point to
a mapping of device memory?

Thanks,
David


