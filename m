Return-Path: <linux-fsdevel+bounces-11079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7CD850DC0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 08:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB14A1F262A5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 07:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFEFF9E8;
	Mon, 12 Feb 2024 07:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lhWVSV/4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAD4DF41;
	Mon, 12 Feb 2024 07:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722045; cv=none; b=qQTtuJgIAw3A793eTbVItRgvhAgDDwlUpN+vfAvmDe2MopWzj1UABBT7+huxUcPQ43wzCoC9R0W1pH5VaNEOozuOapFIaEJWUUXw2ijvrfMniiEpgDAgW5ZiALSHnQpwyxpcaDoU9GyD+fh9p6pbWeR1wt07v/eI5nyJRhRNF/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722045; c=relaxed/simple;
	bh=Zp3cCLINEokOiPdXtcRCwweX4H6+xgszIGGxoW504HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MidxacPvdn8IhUI0bJ7wDzC5PQNcW0wv+Is+TGcSj6/1dpxc6oM7chOMYKzTnOubx8kkGjOzFqZGzI6IE66TtlxtQKSLa0FHSII3mNehN9J0yuzGBM9ZvLrkzkw0NAQlj2BWKtfdQsHZEC0tijkv4RYaMWcG3eJe7C8eVRjnT7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lhWVSV/4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+lqvdXiJyeUBbv4RbCH+VsOF1ziPvzDxge6GroiRQvo=; b=lhWVSV/4NJ4gJRcE/4QSmGNsRr
	Heu4UlhYcFVsZC14064f5jmUtC5kEA1lwOPdwrtQf/Bd7PJ5yNt6me07tldTSZffNrXe9k9NZy+5B
	Q9u+5SQ1ktlUZn5sZQ8fUhl2Vnbn0E+3wvmBv13JFwaQXgdvnYDwIzTGHIinQdW+iQtDq8jmJTTrz
	g3wzeNkmBYPbwoft5gs6t2NdV9u2q9PCKcYUZVS3UVElrQHEBVTvNFaSYRv0dndWcI5M47ywQfpbR
	LDsxxgMQmNqqi/ArS94YpOJDoT+J02951fSMYJiE3fyr8JXxC0wQeiCpo3cdaZ3zkymXgD/xDHVRr
	BnWZab8w==;
Received: from [2001:4bb8:190:6eab:75e9:7295:a6e3:c35d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQVt-00000004SoV-3u3n;
	Mon, 12 Feb 2024 07:14:02 +0000
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
Subject: [PATCH 02/14] writeback: remove a duplicate prototype for tag_pages_for_writeback
Date: Mon, 12 Feb 2024 08:13:36 +0100
Message-Id: <20240212071348.1369918-3-hch@lst.de>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
[hch: split from a larger patch]
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Brian Foster <bfoster@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Dave Chinner <dchinner@redhat.com>
---
 include/linux/writeback.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 453736fd1d23ce..4b8cf9e4810bad 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -363,8 +363,6 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb);
 typedef int (*writepage_t)(struct folio *folio, struct writeback_control *wbc,
 				void *data);
 
-void tag_pages_for_writeback(struct address_space *mapping,
-			     pgoff_t start, pgoff_t end);
 int write_cache_pages(struct address_space *mapping,
 		      struct writeback_control *wbc, writepage_t writepage,
 		      void *data);
-- 
2.39.2


