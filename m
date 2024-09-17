Return-Path: <linux-fsdevel+bounces-29570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E0097ADEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 11:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E131C22092
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Sep 2024 09:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0952715C147;
	Tue, 17 Sep 2024 09:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hiAllB/c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A10150990;
	Tue, 17 Sep 2024 09:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726565534; cv=none; b=b1UWzkUtz1zSWU2kIOlYhBDRKUZnztyB9nkOO+xLXaXzTUSWWpCZ6m7JEqgHDh7LnzsVBeWV4ObKfry2anQo72dBC/kyBkMe118KsuLHwEoYEfyJZ7lnGseOCX7A7xx9urwCXNeUbkqddsFTdG5AnJny6ojftLWdUCUp1dsRxag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726565534; c=relaxed/simple;
	bh=bYcVc+PqeHmqPJzhSjc2SvfecRr25R0jHytk8paNgsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kc1bJTCEQL8CnOx05X/oHmTP7zqFvxC2nLtW+leG3FqIDCMamvO86nRbplLNtT8q8xSHAwbDQVr8+4jZjzMx39tHbKUB/dBvFhVQ2OhHPlvIWYBfZK1sQPCYT9clv19ZvuJn0Y+KYguIxhqdM4BX3dWzniccWh5FQeQIrlzWK/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hiAllB/c; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AqxKUzFGQdmgzjFQB7tJnhZLtky0WoPwa3ZP0bwa7kw=; b=hiAllB/ciABy+VhhuHSacSE+Oa
	SkkEdCai+UpuhIa9Yf1t+vo02bnbfsGYxVDgljWR3ImyeE7KwLUBF1VNYMhKx4oAl16yvn/pQ6OPQ
	H3m2XoG5UiYzmqwMb5tuuRdps/hVoLjPG4pohXphNPaX2soLEzxWxfUcY+BYEFrXFfVvJSoYdsG02
	2Pyl5awELZWuUbbvhKTT6oxktKMcKpioP2G61vO7hgxyRoK9+bZXzQBt7Fmf/M7fihX6s6K9fAlbG
	9wzarVZDbmH1YOOtLKXK07Ymuk7V/UT48FXq1KB2oVwYg0M6i2v4+MLsQVIiw6agHfahLFV47FNAC
	s9XTgnRA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqUZ2-00000002zBP-3zLK;
	Tue, 17 Sep 2024 09:32:04 +0000
Date: Tue, 17 Sep 2024 10:32:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Jens Axboe <axboe@kernel.dk>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZulMlPFKiiRe3iFd@casper.infradead.org>
References: <A5A976CB-DB57-4513-A700-656580488AB6@flyingcircus.io>
 <ZuNjNNmrDPVsVK03@casper.infradead.org>
 <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>

On Mon, Sep 16, 2024 at 10:47:10AM +0200, Chris Mason wrote:
> I've got a bunch of assertions around incorrect folio->mapping and I'm
> trying to bash on the ENOMEM for readahead case.  There's a GFP_NOWARN
> on those, and our systems do run pretty short on ram, so it feels right
> at least.  We'll see.

I've been running with some variant of this patch the whole way across
the Atlantic, and not hit any problems.  But maybe with the right
workload ...?

There are two things being tested here.  One is whether we have a
cross-linked node (ie a node that's in two trees at the same time).
The other is whether the slab allocator is giving us a node that already
contains non-NULL entries.

If you could throw this on top of your kernel, we might stand a chance
of catching the problem sooner.  If it is one of these problems and not
something weirder.

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0b618ec04115..006556605eb3 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -1179,6 +1179,8 @@ struct xa_node {
 
 void xa_dump(const struct xarray *);
 void xa_dump_node(const struct xa_node *);
+void xa_dump_index(unsigned long index, unsigned int shift);
+void xa_dump_entry(const void *entry, unsigned long index, unsigned long shift);
 
 #ifdef XA_DEBUG
 #define XA_BUG_ON(xa, x) do {					\
diff --git a/lib/xarray.c b/lib/xarray.c
index 32d4bac8c94c..6bb35bdca30e 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -6,6 +6,8 @@
  * Author: Matthew Wilcox <willy@infradead.org>
  */
 
+#define XA_DEBUG
+
 #include <linux/bitmap.h>
 #include <linux/export.h>
 #include <linux/list.h>
@@ -206,6 +208,7 @@ static __always_inline void *xas_descend(struct xa_state *xas,
 	unsigned int offset = get_offset(xas->xa_index, node);
 	void *entry = xa_entry(xas->xa, node, offset);
 
+	XA_NODE_BUG_ON(node, node->array != xas->xa);
 	xas->xa_node = node;
 	while (xa_is_sibling(entry)) {
 		offset = xa_to_sibling(entry);
@@ -309,6 +312,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 		return false;
 	xas->xa_alloc->parent = NULL;
 	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
+	XA_NODE_BUG_ON(xas->xa_alloc, memchr_inv(&xas->xa_alloc->slots, 0, sizeof(void *) * XA_CHUNK_SIZE));
 	xas->xa_node = XAS_RESTART;
 	return true;
 }
@@ -345,6 +349,7 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 		return false;
 	xas->xa_alloc->parent = NULL;
 	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
+	XA_NODE_BUG_ON(xas->xa_alloc, memchr_inv(&xas->xa_alloc->slots, 0, sizeof(void *) * XA_CHUNK_SIZE));
 	xas->xa_node = XAS_RESTART;
 	return true;
 }
@@ -388,6 +393,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 	}
 	XA_NODE_BUG_ON(node, shift > BITS_PER_LONG);
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
+	XA_NODE_BUG_ON(node, memchr_inv(&node->slots, 0, sizeof(void *) * XA_CHUNK_SIZE));
 	node->shift = shift;
 	node->count = 0;
 	node->nr_values = 0;

