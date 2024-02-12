Return-Path: <linux-fsdevel+bounces-11080-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F517850DC2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06271F263C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6FA10A29;
	Mon, 12 Feb 2024 07:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQnFDH25"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169D310A0A;
	Mon, 12 Feb 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722051; cv=none; b=nq5034kbkSChHFEdNGLOo+U8Cr1y0GTYhhNMD+n+CXyn70GPLraXQDD/GGTspgNmEgroA+313s8jjk+gN586DQCYD1ph07XxwWHVdn+G+3YHWr5OPE7Rfz4KTyOmMk2uPZoy5rdKOjzadetmOu6OVrxIQjqgDmnucqxJVijEB6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722051; c=relaxed/simple;
	bh=qDZNRvNkd4jQjG015zJAhoIiQiTD5FYJGjIDp41iL4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B88gtsj4RUMcL8B268vib7RbKu2/3Bby618SzmDhZ8wvIb0CesY2XPLyQbVNo1VjncyMKOkIhLJsUvRdF4shRJF9GfVTjbWZAhgQWd+y93it3AQdU6LvPNt6AkZZ/7i2oT/ajkKAOfHtNxBV6qr33/gX+lzKqKBz8d12I91AGhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hQnFDH25; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=64fRIZ4p3xI47I0UjDfQWbOQW89h4igNM/M4APDkPmk=; b=hQnFDH252tFU20hQNpYyUplf2R
	jumeUc/X4ZUzuexuSNHm/zyXaPRqcggyQGFdoyLASrp+lMWu36MwQwZda9DfA0i/tGTxurxcVuYk2
	7vQX8a5ep+6PGO+lgk/7ZmNu31DToIMDnMWWY+Inpo4BxJEsJm3nuNY2w1S2m/Udr5dnhsz4m+w3g
	hzaOAlGV33RWtrmBE7qG4n77S7sz8swMFa3bkYWn2FVEhrxmydbyy+8dvY+/NHpSd8nKTnUt5B4MC
	VAQhbSlVmXb6BrgLz0ZDBvn5840bRz3glHriIl64SpSG9IT83gI/0PvG0Y+zfo6FPqO9mOGthd9Ck
	GyUqemog==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQVw-00000004SpN-2Uys;
	Mon, 12 Feb 2024 07:14:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-mm@kvack.org
Cc: Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.com>,
	David Howells <dhowells@redhat.com>,
	Brian Foster <bfoster@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Dave Chinner <dchinner@redhat.com>
Subject: [PATCH 03/14] writeback: fix done_index when hitting the wbc->nr_to_write
Date: Mon, 12 Feb 2024 08:13:37 +0100
Message-Id: <20240212071348.1369918-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212071348.1369918-1-hch@lst.de>
References: <20240212071348.1369918-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When write_cache_pages finishes writing out a folio, it fails to update
done_index to account for the number of pages in the folio just written.
That means when range_cyclic writeback is restarted, it will be
restarted at this folio instead of after it as it should.  Fix that
by updating done_index before breaking out of the loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 62901fa905f01e..aa3b432f77e37a 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2505,6 +2505,7 @@ int write_cache_pages(struct address_space *mapping,
 			 * keep going until we have written all the pages
 			 * we tagged for writeback prior to entering this loop.
 			 */
+			done_index = folio->index + nr;
 			wbc->nr_to_write -= nr;
 			if (wbc->nr_to_write <= 0 &&
 			    wbc->sync_mode == WB_SYNC_NONE) {
-- 
2.39.2


