Return-Path: <linux-fsdevel+bounces-18337-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA408B7854
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04D41C225A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1C3175561;
	Tue, 30 Apr 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A+XdUmwZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECBC171E4D
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485731; cv=none; b=gwH6B7/tR1ZOAD7HeOD1V+TWNJkfsLCyOASAaKo75tBi3/h/tdgNugOrlkLHdPlcCpvlIFQw3irP8UfAEVD2GJnWycavLs0NA1Dc0LIZSGjFKQ83gHMcIQkr30ny62NweRknrYZAl0Ag6pPNR4D2nmb7Ru37PmUmMgqYd1qybzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485731; c=relaxed/simple;
	bh=b31u1bZv47KcpUE2YEcbeJ9EX9O+/YAoXgPL9zxJe9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7iPqFx3GFfUmqqStBXuCESrpjwwNYAmia7uzCKWUeHiHhc2oetMdvITjHICComVqnV5FYpej2siVUWFEl1/AvWFJnqxg52ZOHvQUpTjJd+4XhIaAx9golwnBd809L8DIWzRp0I0ilucrzNZRRzcC2S5eZMRIZJMJcos8lZmdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A+XdUmwZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjFRfxxSIhn/sZySlzA+YPg8ujVk0zbXsyNAbtLG88o=;
	b=A+XdUmwZ3BYpJ50awaBC6+zfJ7BGa7G/3PMoxTeTIRPp/7RN/nWX+XmJvrXRMg6FaXZl1b
	0vdEwhX1ilOnEI9aJmXbO40/RaQqlLLczfhmwUmP+vd9De6sz4Je3t7QjnFnMQ5wLiOgDo
	ksmaVtAwX+QQLoK1TiCUV3BueHdYyfY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ESWFmT24OQqLiwHsx02-fA-1; Tue, 30 Apr 2024 10:02:03 -0400
X-MC-Unique: ESWFmT24OQqLiwHsx02-fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9306E834FBF;
	Tue, 30 Apr 2024 14:01:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD5441C0654E;
	Tue, 30 Apr 2024 14:01:48 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/22] mm: Export writeback_iter()
Date: Tue, 30 Apr 2024 15:00:43 +0100
Message-ID: <20240430140056.261997-13-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Export writeback_iter() so that it can be used by netfslib as a module.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-mm@kvack.org
---

Notes:
    Changes
    =======
    ver #2)
     - Mark the symbol _GPL.

 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..06fc89d981e8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2546,6 +2546,7 @@ struct folio *writeback_iter(struct address_space *mapping,
 	folio_batch_release(&wbc->fbatch);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(writeback_iter);
 
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.


