Return-Path: <linux-fsdevel+bounces-36279-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284A59E0D1D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 21:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DBA7B61305
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 19:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1151DED44;
	Mon,  2 Dec 2024 19:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kFzPvbBd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3711D958E;
	Mon,  2 Dec 2024 19:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733166248; cv=none; b=Vi+jeexJOkvkmGrUbjP5fBZYIreGcS0xbO8icjb8/lckZxD0IIICTErdjqOWnlMAH6nJ0NdAN3OtORJ6TKYscLdKGUQU5DwmqA8sIiilEm2KzORPXma6gwAFZlmh8r5s3EAVy26yShPa4FTS4jSQWXZzN18nEMgx/2130lUy0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733166248; c=relaxed/simple;
	bh=R+EFamtDipQJhF9nv3eu3I3TJ6149H7R4q3kWXfEaKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI1la7Ixnufl+i5ORZgvuXk+sUN/dlxdJSnqmXidvbBogLZ/lNyUtplw8gljbRe6u3AehtX574VDhzRrrt6/urKyjg7zqkzlGxn+p/7Yf08NZP2h+rwOymAecuyLAwI6uxrqkzB28TCqWI0MCJ8ykFs4foPksRnqa5jcWiWVJ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kFzPvbBd; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rB5zOkGVK9tONvMKWptVJOAKG502RIHXWt9G7MFcAT8=; b=kFzPvbBd94g3zvpl4kGqXDTrcP
	hXtSMjh4EHOtrYrDsJ94wC5lbEYIexXJbldmAOfvQSjgK+0OxsVSUNZ1aJPMJIc0E/lD9MYTUz6aY
	B5tUDDom4YXWAWaA7NOSuDTN6VsrbVuGZ2d1iC9AawDlTd5U4m9xUmYmiZ5MWMTDwrC31dPBitOii
	Sre86dxJjNHVlbFq0LMsNa4A0rVcWq34oKMil8wfMRURRsY6gUPfri4/E7j7RD+SdvGbZhL7YM9kQ
	8hwblYjXI3VF6bequ7AWXiXeDkczyCT05LF5j9rzAhYCPmC4TZ87EvL6YENVG8EqHH83TfV0IFHph
	DLBxycaw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBiE-00000008VPm-46nk;
	Mon, 02 Dec 2024 19:04:03 +0000
Date: Mon, 2 Dec 2024 19:04:02 +0000
From: Matthew Wilcox <willy@infradead.org>
To: kernel test robot <lkp@intel.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
	ceph-devel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/5] ceph: Use a folio in ceph_writepages_start()
Message-ID: <Z04EopWaTpI5a4R3@casper.infradead.org>
References: <20241129055058.858940-6-willy@infradead.org>
 <202411292322.iv4hDiEQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202411292322.iv4hDiEQ-lkp@intel.com>

On Fri, Nov 29, 2024 at 11:42:44PM +0800, kernel test robot wrote:
> >> fs/ceph/addr.c:1178:39: warning: variable 'page' is uninitialized when used here [-Wuninitialized]
>     1178 |                                         fscrypt_encrypt_pagecache_blocks(page,

This will fix the bug.  I'll send a v2 with this folded in.

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 1e0c982f5abe..b065b971a9f0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1040,7 +1040,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		int num_ops = 0, op_idx;
 		unsigned i, nr_folios, max_pages, locked_pages = 0;
 		struct page **pages = NULL, **data_pages;
-		struct page *page;
+		struct folio *folio;
 		pgoff_t strip_unit_end = 0;
 		u64 offset = 0, len = 0;
 		bool from_pool = false;
@@ -1054,7 +1054,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 		if (!nr_folios && !locked_pages)
 			break;
 		for (i = 0; i < nr_folios && locked_pages < max_pages; i++) {
-			struct folio *folio = fbatch.folios[i];
+			folio = fbatch.folios[i];
 
 			doutc(cl, "? %p idx %lu\n", folio, folio->index);
 			if (locked_pages == 0)
@@ -1175,7 +1175,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 			if (IS_ENCRYPTED(inode)) {
 				pages[locked_pages] =
-					fscrypt_encrypt_pagecache_blocks(page,
+					fscrypt_encrypt_pagecache_blocks(&folio->page,
 						PAGE_SIZE, 0,
 						locked_pages ? GFP_NOWAIT : GFP_NOFS);
 				if (IS_ERR(pages[locked_pages])) {
@@ -1303,7 +1303,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 			/* writepages_finish() clears writeback pages
 			 * according to the data length, so make sure
 			 * data length covers all locked pages */
-			u64 min_len = len + 1 - thp_size(page);
+			u64 min_len = len + 1 - folio_size(folio);
 			len = get_writepages_data_length(inode, pages[i - 1],
 							 offset);
 			len = max(len, min_len);

