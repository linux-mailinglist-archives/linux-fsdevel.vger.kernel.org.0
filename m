Return-Path: <linux-fsdevel+bounces-24026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60E7937BD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 19:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A2FFB21E35
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jul 2024 17:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02927146D6E;
	Fri, 19 Jul 2024 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8eOJHiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6479145FFB;
	Fri, 19 Jul 2024 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721411474; cv=none; b=SdNEWfd0ocdKaMVtXTWwZNbRN42JonKhsipGaRKazl+F8+gNTRwHEs69G2NwoGuLPBToHafLjeAvmtOJcdiOuqkihShRE1XDmMnKiehtDPAVokkBFAr4WVv2Rd9M+qglCqlwGf/XB86XF5RrRuM3uxjXI5QVt0lbwQS14Te//kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721411474; c=relaxed/simple;
	bh=f3AnAbCdhP7uDxCrhcq1jIjBuYqKEB7kWnOPuV8bV6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=olq7lPf7EHhStAKqOKBqpi4ZzwAk/VRmM4nBa8xA6umsocAN4E6GiVPgYtoXDZr3IpEakPm0FM1tlUU1jPuiSSVLdg/ZI2G/XcPE77vI7AxBG8hPv3IxEAmkyQU3BuMJHvC/3VfMdZ0YrFwGKkj23mGKdVrNBOEZoYEUQFwQec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8eOJHiA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=3BH0lKK785jAOhDmb6rSgSz+2L3arHyij79aSxbGT/I=; b=s8eOJHiAQvWL5itGf9Uo3HN1NV
	z/eWdaY899sh5cDQVjhS4FTTn6ZmxcoFl0C2ieXvnpP3kLOwhVHrOfyJF5cQKIsGeefVgtO2/h8TI
	a91e1EjMat8b151G9lp8Uc6iWZA/+Erwa+wAUVhyqK6JfYgicO+5COwynA52OJCPvihOV/R7HMlPn
	pfm6+EshcQogeFgSRj7DMfCt7RtMmEzadlDw3kJkDpzPfxEPQSW6IHGVpfOV1zK7xcbXX66RcJepy
	iKE7qDGAUWZrhE+pnHVVPNg5tqrgCiuovh/FrN8lXRQCF8qVxw+IBB5/+gBEmtCj/Ae0YtgoauAq2
	Xb8JieIg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUrl9-00000003J4g-1LrF;
	Fri, 19 Jul 2024 17:51:11 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/4] gfs2: Remove __gfs2_writepage()
Date: Fri, 19 Jul 2024 18:51:02 +0100
Message-ID: <20240719175105.788253-3-willy@infradead.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240719175105.788253-1-willy@infradead.org>
References: <20240719175105.788253-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Call aops->writepages() instead of using write_cache_pages() to call
aops->writepage.  Change the handling of -ENODATA to not set the
persistent error on the block device.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/gfs2/log.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 6ee6013fb825..f9c5089783d2 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -80,15 +80,6 @@ void gfs2_remove_from_ail(struct gfs2_bufdata *bd)
 	brelse(bd->bd_bh);
 }
 
-static int __gfs2_writepage(struct folio *folio, struct writeback_control *wbc,
-		       void *data)
-{
-	struct address_space *mapping = data;
-	int ret = mapping->a_ops->writepage(&folio->page, wbc);
-	mapping_set_error(mapping, ret);
-	return ret;
-}
-
 /**
  * gfs2_ail1_start_one - Start I/O on a transaction
  * @sdp: The superblock
@@ -140,7 +131,7 @@ __acquires(&sdp->sd_ail_lock)
 		if (!mapping)
 			continue;
 		spin_unlock(&sdp->sd_ail_lock);
-		ret = write_cache_pages(mapping, wbc, __gfs2_writepage, mapping);
+		ret = mapping->a_ops->writepages(mapping, wbc);
 		if (need_resched()) {
 			blk_finish_plug(plug);
 			cond_resched();
@@ -149,6 +140,7 @@ __acquires(&sdp->sd_ail_lock)
 		spin_lock(&sdp->sd_ail_lock);
 		if (ret == -ENODATA) /* if a jdata write into a new hole */
 			ret = 0; /* ignore it */
+		mapping_set_error(mapping, ret);
 		if (ret || wbc->nr_to_write <= 0)
 			break;
 		return -EBUSY;
-- 
2.43.0


