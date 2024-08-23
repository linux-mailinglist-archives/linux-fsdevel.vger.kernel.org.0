Return-Path: <linux-fsdevel+bounces-26990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 016D395D77A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 22:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 340711C222ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 20:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A962B199EA6;
	Fri, 23 Aug 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekz4yxq1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95116199E98
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Aug 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443735; cv=none; b=BSg+rmQcB1qh5hssC94uaiM2t18qVLXcKsWrnQjN2Rl9aAz6R6wjn3MkuzgFZfu5TAy0KDa62iD9V7A+1ZsP89ADKmTdVaTPeqCuJPQMddmR6ufMaNFbpm3n5mh3aNJjHQYDsblrnjvWInfR+y5VB+s9dbA+rJ/vpPEyszp1TOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443735; c=relaxed/simple;
	bh=ht8EIVhw2/1il8Rsom6afgUGDhA62o/6wQOgoApvk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V3VojwBVc01e0z205bKjTMw15Pm1T/NMffykE/IMjs8J9lqeWD90TUKcD4puuZ1IRofletmKrSomcGKpJN/qln1+elkQNwafoOXdrCANYiNC86gbBeJTevBcVlGAfdXGFhFQ0BG56f5tKfjClWb7+JZovElACDnKMW5Yg0GGFwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ekz4yxq1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	b=ekz4yxq1RLQzM5Xgnwd9faEVqSNzz4WywcsTRXv/TnieTnLRJ+uIN5CFnBzRVyCUoMVF2H
	GgYOMpc8dEXHQyKjeJfLjZglTPo8F+sWPJwlzewJjyF8tRCEkr79AteZfSBsIf1g88R2HH
	JBb1GPKUGDcELj0snBvEPdnRvQUamp8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-JPiGnaA-NR6p3XE_f4cFaQ-1; Fri,
 23 Aug 2024 16:08:49 -0400
X-MC-Unique: JPiGnaA-NR6p3XE_f4cFaQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 385D61955D50;
	Fri, 23 Aug 2024 20:08:47 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D8E451955DD8;
	Fri, 23 Aug 2024 20:08:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 3/9] netfs: Fix netfs_release_folio() to say no if folio dirty
Date: Fri, 23 Aug 2024 21:08:11 +0100
Message-ID: <20240823200819.532106-4-dhowells@redhat.com>
In-Reply-To: <20240823200819.532106-1-dhowells@redhat.com>
References: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Fix netfs_release_folio() to say no (ie. return false) if the folio is
dirty (analogous with iomap's behaviour).  Without this, it will say yes to
the release of a dirty page by split_huge_page_to_list_to_order(), which
will result in the loss of untruncated data in the folio.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: c1ec4d7c2e13 ("netfs: Provide invalidate_folio and release_folio calls")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
---
 fs/netfs/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 554a1a4615ad..69324761fcf7 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -161,6 +161,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	unsigned long long end;
 
+	if (folio_test_dirty(folio))
+		return false;
+
 	end = folio_pos(folio) + folio_size(folio);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;


