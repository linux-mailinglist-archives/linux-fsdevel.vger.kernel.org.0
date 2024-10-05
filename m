Return-Path: <linux-fsdevel+bounces-31072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4F4991967
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97AE01C2140A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928F915A4B7;
	Sat,  5 Oct 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YYOKLBd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A041798C;
	Sat,  5 Oct 2024 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728152596; cv=none; b=iwNaGKniw+oIz6Y3nv/4tuATSzN0lyW2vikEoAxw1kAPisLZJQTYl8/PcmNeaXEbA6rkYTWeP4kScKJq23dx6xPZ5zjgb6DXLBzpMzTUAyieuB7GsIPQlTzC7xodwO753UxT2ehfx9IJxFiONSmBXHhW6mDDs8NZHl4L3QzajNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728152596; c=relaxed/simple;
	bh=Lub6l4bdnCM8qmKWg3YLqHjftY/hKRNcH1zFmmZwC6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUJMJFnRb4mIVLGZjstPAdueOaWDnsMywViP+4tmcJh4XOQyv2hS8+bN2qLhPHas2kjh+77Rqp0pD3eEllf/wcf2zklTyJFqPgRaLbtbMYhpVlb7exhw9jkj0J3uifKJvKdGE/AnyuCfHhzI0YNTcoGzaVgWLhEf74WLaizWCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YYOKLBd5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=lj5Z3Kg2yzAsYe8hTus7ua3lJbABa7liSHvLTdCCTdo=; b=YYOKLBd5Fmf65wuJruSFPFGbLV
	qMwkZTXPFnrCrmP1Y71x1uGfQenrE0GUPqVf3sgQN8KRWMIS0wPZVrxhECiVhNzSTyIHh+f7mNmR2
	OJq14HPOmwFCJrYqEapMEk9jhLZ6uiUlNByMJgmkEfZJ3sPHbM/PNdtuAOVm6qkSlkhJJCk1Rd1Ss
	UCXFkAnR2rcSkZ7KU9nF8lU+o6n+tFMXr78QYTa+ox04rQBaEwjYoFNRfUAvURwIpf3ieyI8nRcqN
	2Rf9T3Vjs9q2BPUk2sJcpGhfGNiHiavxp5KwrfF9Z7hC8FElWqYX/wOQgq5o7yzVAoEE2znMMEMmz
	5+VTQUKA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sx9Qs-0000000DNyR-09KI;
	Sat, 05 Oct 2024 18:23:10 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/3] netfs: Remove call to folio_index()
Date: Sat,  5 Oct 2024 19:23:03 +0100
Message-ID: <20241005182307.3190401-2-willy@infradead.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241005182307.3190401-1-willy@infradead.org>
References: <20241005182307.3190401-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling folio_index() is pointless overhead; directly dereferencing
folio->index is fine.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/trace/events/netfs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 1d7c52821e55..72a208fd4496 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -451,7 +451,7 @@ TRACE_EVENT(netfs_folio,
 		    struct address_space *__m = READ_ONCE(folio->mapping);
 		    __entry->ino = __m ? __m->host->i_ino : 0;
 		    __entry->why = why;
-		    __entry->index = folio_index(folio);
+		    __entry->index = folio->index;
 		    __entry->nr = folio_nr_pages(folio);
 			   ),
 
-- 
2.43.0


