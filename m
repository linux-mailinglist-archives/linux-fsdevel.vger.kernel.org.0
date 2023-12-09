Return-Path: <linux-fsdevel+bounces-5395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE9F80B23D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 06:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF2A1C20CCE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Dec 2023 05:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E076A185C;
	Sat,  9 Dec 2023 05:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EyshFnSC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2299EF9;
	Fri,  8 Dec 2023 21:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UVdfZGmsuqsBczQNBSxQaiN+7u93tT/zycciBXwX+nc=; b=EyshFnSCaJHx4CejqCbPo25Vk+
	pbEY7x2S8AVYNgwRuutOLX/M+mBD06Fa2WVX6HUBZiu8zgOn9zo0Lvh+KiAl7oK67+uDk3fcDMxT4
	Q7RsMcA71rhLavR3o6oqi+j5DwsHgray3+nwRaAr860A5m35mfzF2QiXgnds3Ms5ur8xuY2W5j9pw
	pZGu5pPtql2uL0Dm6UJ2Cp4l0Dfc8ALvrckxY5z49yeeFrxy/7Zcuk8o1OjiJV28lZsfglm6fAAuw
	R3uWtbX7wVq47iow4cDxBjTq9/xPwDo6BRPio9s5UGhm6om1NTKo0Y6ES+BrQ++Zy7IhiHd0Wi8l0
	j41z+qjA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBqFs-0071NF-Ib; Sat, 09 Dec 2023 05:52:00 +0000
Date: Sat, 9 Dec 2023 05:52:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>, zlang@redhat.com,
	Pankaj Raghav <p.raghav@samsung.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-mm@kvack.org,
	xfs <linux-xfs@vger.kernel.org>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: mm/truncate.c:669 VM_BUG_ON_FOLIO() - hit on XFS on different
 tests
Message-ID: <ZXQAgFl8WGr2pK7R@casper.infradead.org>
References: <ZXObKBfw/0bcRQNr@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vC0AjNz9klew6+qA"
Content-Disposition: inline
In-Reply-To: <ZXObKBfw/0bcRQNr@bombadil.infradead.org>


--vC0AjNz9klew6+qA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 02:39:36PM -0800, Luis Chamberlain wrote:
> Commit aa5b9178c0190 ("mm: invalidation check mapping before folio_contains")
> added on v6.6-rc1 moved the VM_BUG_ON_FOLIO() on invalidate_inode_pages2_range()
> after the truncation check.
> 
> We managed to hit this VM_BUG_ON_FOLIO() a few times on v6.6-rc5 with a slew
> of fstsets tests on kdevops [0] on the following XFS config as defined by
> kdevops XFS's configurations [1] for XFS with the following failure rates
> annotated:
> 
>   * xfs_reflink_4k: F:1/278 - one out of 278 times
>     - generic/451: (trace pasted below after running test over 17 hours)
>   * xfs_nocrc_4k: F:1/1604 - one ou tof 1604 times
>      - generic/451: https://gist.github.com/mcgrof/2c40a14979ceeb7321d2234a525c32a6
> 
> To be clear F:1/1604 means you can run the test in a loop and on test number
> about 1604 you may run into the bug. It would seem Zorro had hit also
> with a 64k directory size (mkfs.xfs -n size=65536) on v5.19-rc2, so prior 
> to Hugh's move of the VM_BUG_ON_FOLIO() while testing generic/132 [0].
> 
> My hope is that this could help those interested in reproducing, to
> spawn up kdevops and just run the test in a loop in the same way.
> Likewise, if you have a fix to test we can test it as well, but it will
> take a while as we want to run the test in a loop over and over many
> times.

I'm pretty sure this is the same problem recently diagnosed by Charan.
It's terribly rare, so it'll take a while to find out.  Try the attached
patch?

--vC0AjNz9klew6+qA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-Migrate-high-order-folios-in-swap-cache-correctly.patch"

From 4bd18e281a5e99f3cc55a9c9cc78cbace4e9a504 Mon Sep 17 00:00:00 2001
From: Charan Teja Kalla <quic_charante@quicinc.com>
Date: Sat, 9 Dec 2023 00:39:26 -0500
Subject: [PATCH] mm: Migrate high-order folios in swap cache correctly

Large folios occupy N consecutive entries in the swap cache
instead of using multi-index entries like the page cache.
However, if a large folio is re-added to the LRU list, it can
be migrated.  The migration code was not aware of the difference
between the swap cache and the page cache and assumed that a single
xas_store() would be sufficient.

This leaves potentially many stale pointers to the now-migrated folio
in the swap cache, which can lead to almost arbitrary data corruption
in the future.  This can also manifest as infinite loops with the
RCU read lock held.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
[modifications to the changelog & tweaked the fix]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/migrate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index d9d2b9432e81..2d67ca47d2e2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -405,6 +405,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	int dirty;
 	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
 	long nr = folio_nr_pages(folio);
+	long entries, i;
 
 	if (!mapping) {
 		/* Anonymous page without mapping */
@@ -442,8 +443,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 			folio_set_swapcache(newfolio);
 			newfolio->private = folio_get_private(folio);
 		}
+		entries = nr;
 	} else {
 		VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
+		entries = 1;
 	}
 
 	/* Move dirty while page refs frozen and newpage not yet exposed */
@@ -453,7 +456,11 @@ int folio_migrate_mapping(struct address_space *mapping,
 		folio_set_dirty(newfolio);
 	}
 
-	xas_store(&xas, newfolio);
+	/* Swap cache still stores N entries instead of a high-order entry */
+	for (i = 0; i < entries; i++) {
+		xas_store(&xas, newfolio);
+		xas_next(&xas);
+	}
 
 	/*
 	 * Drop cache reference from old page by unfreezing
-- 
2.42.0


--vC0AjNz9klew6+qA--

