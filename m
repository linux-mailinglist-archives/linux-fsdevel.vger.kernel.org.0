Return-Path: <linux-fsdevel+bounces-38097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D399FBDAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B81884505
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 12:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8991C1F20;
	Tue, 24 Dec 2024 12:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X/cd3lHm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D811990A2;
	Tue, 24 Dec 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045020; cv=none; b=Q5qLZnnWGYRXeygwLTC+zUetSgAPekNcjISj4arusM4ByJoCQey0XOzv6W9Ab1pRdBy9OTOeATSSp4AG9CK5eDXxjtT/FVcI8yxhNzIlZEXTMcGXlhxSMt0IdJCE858Z/Nenapz2ni1waPrfJqUtTQse/J3/BvQ08tir07vDwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045020; c=relaxed/simple;
	bh=3DCXqU9gS2F2dLR2lqJBt/yyQvNaWM0YGd3ZPxpaIPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLaUGe85dR5w99pCImnJ7Da0/uQ6e97TI1yydtYRjl3i2ifRe6lyp6ULV1DSTTwiMY4kJbiAe/gf7eXggbLOaIyY3JDPWoDQGPBJhlQqOcjfXRPwOUwp2GJlpBN+iJJ6KAKYupooFRpSUs3TuCz+0CQBcsmrowwxRLQ7EnMfGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=X/cd3lHm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=y3KMwf37b8qf4cE4Yi0JHhgCLpTdc9C3Jtz07UoNrf8=; b=X/cd3lHmiG1317VnUgkV9OYgF7
	PnzhhxBL0FJ34OeASgU+aE+c00gJixXRjAmxrvAC0dwXlpEzosEVo9xB8lsMZ4MLSwleOUuSjoW1p
	1kURZOQCv/JYUccvEgsIoCN4T+WwQ5sNvCPj9yDi476Z0EicRU/6YWIH0mSN4CXXN+bwNUNi9M+nF
	GH0Vt86mmgbu1Bd2jtsCy9LTioOYzCVTqaHVw/GHKppmpt+MDYDdH/dcnLbT6VrGCb0gCK4dkSoJD
	WbuRjEei2X/H+wwfLfZ912dMsKNQJaqmU+UiDmL9a8UbrXRqd4hcM1l0qwlWiG6eHOCQ+y9gBeIjO
	ADkKHV9Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ4Sz-000000032v9-34HA;
	Tue, 24 Dec 2024 12:56:53 +0000
Date: Tue, 24 Dec 2024 12:56:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: David Howells <dhowells@redhat.com>, Xiubo Li <xiubli@redhat.com>,
	"ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	Alex Markuze <amarkuze@redhat.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"idryomov@gmail.com" <idryomov@gmail.com>,
	"netfs@lists.linux.dev" <netfs@lists.linux.dev>
Subject: Re: Ceph and Netfslib
Message-ID: <Z2qvlXf08wuZ81bv@casper.infradead.org>
References: <1729f4bf15110c97e0b0590fc715d0837b9ae131.camel@ibm.com>
 <3989572.1734546794@warthog.procyon.org.uk>
 <3992139.1734551286@warthog.procyon.org.uk>
 <690826facef0310d7f44cf522deeed979b6ff287.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690826facef0310d7f44cf522deeed979b6ff287.camel@ibm.com>

On Mon, Dec 23, 2024 at 11:13:47PM +0000, Viacheslav Dubeyko wrote:
>  * On writeback, we must submit writes to the osd IN SNAP ORDER.  So,
>  * we look for the first capsnap in i_cap_snaps and write out pages in
>  * that snap context _only_.  Then we move on to the next capsnap,
>  * eventually reaching the "live" or "head" context (i.e., pages that
>  * are not yet snapped) and are writing the most recently dirtied
>  * pages

Speaking of writeback, ceph doesn't need a writepage operation.  We're
removing ->writepage from filesystems in favour of using ->migrate_folio
for migration and ->writepages for writeback.  As far as I can tell,
filemap_migrate_folio() will be perfect for ceph (as the ceph_snap_context
contains no references to the address of the memory).  And ceph already
has a ->writepages.  So I think this patch should work.  Can you give it
a try?

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 85936f6d2bf7..5a5a870b6aee 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -810,32 +810,6 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	return err;
 }
 
-static int ceph_writepage(struct page *page, struct writeback_control *wbc)
-{
-	int err;
-	struct inode *inode = page->mapping->host;
-	BUG_ON(!inode);
-	ihold(inode);
-
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    ceph_inode_to_fs_client(inode)->write_congested) {
-		redirty_page_for_writepage(wbc, page);
-		return AOP_WRITEPAGE_ACTIVATE;
-	}
-
-	folio_wait_private_2(page_folio(page)); /* [DEPRECATED] */
-
-	err = writepage_nounlock(page, wbc);
-	if (err == -ERESTARTSYS) {
-		/* direct memory reclaimer was killed by SIGKILL. return 0
-		 * to prevent caller from setting mapping/page error */
-		err = 0;
-	}
-	unlock_page(page);
-	iput(inode);
-	return err;
-}
-
 /*
  * async writeback completion handler.
  *
@@ -1584,7 +1558,6 @@ static int ceph_write_end(struct file *file, struct address_space *mapping,
 const struct address_space_operations ceph_aops = {
 	.read_folio = netfs_read_folio,
 	.readahead = netfs_readahead,
-	.writepage = ceph_writepage,
 	.writepages = ceph_writepages_start,
 	.write_begin = ceph_write_begin,
 	.write_end = ceph_write_end,
@@ -1592,6 +1565,7 @@ const struct address_space_operations ceph_aops = {
 	.invalidate_folio = ceph_invalidate_folio,
 	.release_folio = netfs_release_folio,
 	.direct_IO = noop_direct_IO,
+	.migrate_folio = filemap_migrate_folio,
 };
 
 static void ceph_block_sigs(sigset_t *oldset)

