Return-Path: <linux-fsdevel+bounces-60033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E1B41019
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 00:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0298E54557A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 22:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1B27780E;
	Tue,  2 Sep 2025 22:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F4WV3TXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5D20E00B;
	Tue,  2 Sep 2025 22:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852844; cv=none; b=sfwqvv9gVhevXj4OcgRP88I5ACbdKDkAr1BGS0LEWD0dSCxh3TRdZmCP5xXc74mUW11X0IAUt79PCPEu7/ArJwKuLawGyXgUlGSLQTOBalQbVmARDH2kSFwasSQwgOGewLJ9w6sLNIsxBlRBWli5thW6XcmVLBiaRDHAhbgelgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852844; c=relaxed/simple;
	bh=aGIRsV9W7yRHkxZ5RFmGNXNNlqvBFtD/ngQ0qVv3OSg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Fs2rhDeeG16TWAZXpdkrycGI95wb1Qc6INFBY/ASCBkLjK3bnzqXaAJMcO9v68b9HGxioG27favA1Fvywwnln3hBmr+6CHVIyoTgtZS5Vz0XWleYxukvCuvm8JHAk6e6CSs1Rv9/BwofXuULITvtX6AOyPDh6s4YZKPBAffDd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F4WV3TXS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF14C4CEED;
	Tue,  2 Sep 2025 22:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1756852844;
	bh=aGIRsV9W7yRHkxZ5RFmGNXNNlqvBFtD/ngQ0qVv3OSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F4WV3TXSoWes6xFTKpw/mxjIT3/thiuBh6crUHxk7GOnw8fsvmxLTgHhU2tQKe8Fg
	 hd7vZJvdW6CFunsHRzmbsuA/CzqDeB2VdZECvfRlMKwfHOg55oLsXXT4Y/Hm3m0NqL
	 F5M69AfoRzwvYPpub50mQ0gWSm53We47+qwdvREA=
Date: Tue, 2 Sep 2025 15:40:43 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: david@redhat.com, joannelkoong@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, m.szyprowski@samsung.com,
 mszeredi@redhat.com, willy@infradead.org, syzkaller-bugs@googlegroups.com,
 Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] mm: fix lockdep issues in writeback handling
Message-Id: <20250902154043.7214448ff3a9cb68c8d231d5@linux-foundation.org>
In-Reply-To: <20250902095250.1319807-1-nogikh@google.com>
References: <345d49d2-5b6b-4307-824b-5167db737ad2@redhat.com>
	<20250902095250.1319807-1-nogikh@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Sep 2025 11:52:50 +0200 Aleksandr Nogikh <nogikh@google.com> wrote:

> Hi,
> 
> When can the patch be expected to reach linux-next?
> Syzbot can't build/boot the tree for more than 12 days already :(

Please don't top-post - it messes things up so much.

There's nothing I can reasonably do about this - it's fixing an issue
that's coming in from Miklos's tree and perhaps he's offline.

Perhaps Stephen can directly add it to linux-next for a while?

From: Marek Szyprowski <m.szyprowski@samsung.com>
To: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Joanne Koong <joannelkoong@gmail.com>
Subject: [PATCH] mm: fix lockdep issues in writeback handling
Date: Tue, 26 Aug 2025 15:09:48 +0200
Sender: owner-linux-mm@kvack.org
X-Mailer: git-send-email 2.34.1

Commit 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT") removed
BDI_CAP_WRITEBACK_ACCT flag and refactored code that depend on it.
Unfortunately it also moved some variable intialization out of guarded
scope in writeback handling, what triggers a true lockdep warning. Fix
this by moving initialization to the proper place.

Fixes: 167f21a81a9c ("mm: remove BDI_CAP_WRITEBACK_ACCT")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 mm/page-writeback.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 99e80bdb3084..3887ac2e6475 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2984,7 +2984,7 @@ bool __folio_end_writeback(struct folio *folio)
 
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 
 		xa_lock_irqsave(&mapping->i_pages, flags);
@@ -2992,6 +2992,7 @@ bool __folio_end_writeback(struct folio *folio)
 		__xa_clear_mark(&mapping->i_pages, folio_index(folio),
 					PAGECACHE_TAG_WRITEBACK);
 
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, -nr);
 		__wb_writeout_add(wb, nr);
 		if (!mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK)) {
@@ -3024,7 +3025,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 	if (mapping && mapping_use_writeback_tags(mapping)) {
 		XA_STATE(xas, &mapping->i_pages, folio_index(folio));
 		struct inode *inode = mapping->host;
-		struct bdi_writeback *wb = inode_to_wb(inode);
+		struct bdi_writeback *wb;
 		unsigned long flags;
 		bool on_wblist;
 
@@ -3035,6 +3036,7 @@ void __folio_start_writeback(struct folio *folio, bool keep_write)
 		on_wblist = mapping_tagged(mapping, PAGECACHE_TAG_WRITEBACK);
 
 		xas_set_mark(&xas, PAGECACHE_TAG_WRITEBACK);
+		wb = inode_to_wb(inode);
 		wb_stat_mod(wb, WB_WRITEBACK, nr);
 		if (!on_wblist) {
 			wb_inode_writeback_start(wb);
-- 
2.34.1



