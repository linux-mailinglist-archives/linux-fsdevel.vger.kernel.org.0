Return-Path: <linux-fsdevel+bounces-28986-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF79972865
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 06:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702CF28553F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 04:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C61143895;
	Tue, 10 Sep 2024 04:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bj0jSLAV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B64820314;
	Tue, 10 Sep 2024 04:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725943200; cv=none; b=qQkWb3VkXKhPoE08a3TvURQ64eC21HK9mOZukt6KgVmD+uKfLd+UyLR7ISCpNiYtSS997AkrgrnyQx4F6OXGMdWOsAJLgYsyPxlkt2JvWI0Rw//BqHM7wGa+kocHFbW6kpWHkZwhMNDx88JgtLTnFb3TtjrX+M0+2QZIDrlPA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725943200; c=relaxed/simple;
	bh=wp7u1N0phaN8xxSaUItF3Q6edEAFedLSzRqNmjg2V0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cck7pXiTHUuCGl8SQIFyDusXIQGWNclTZYOV1mr14PMtrcV5h8egz3bM3FWBPFEVf0Zo+GTDW0U+ZSoHZF8vhVKrdf/TQLsjp7UUXL0N3EtwWWF3xK4JJRM5QPOZt5BHYc53jXerqPinSJgKzhCDMgD93JEW10TLCYZMtVAoQ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Bj0jSLAV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OJIQATWube4CC9CNdJU2AxlpnGIU3myYtBNpj/x6H64=; b=Bj0jSLAVHGIQqxhSthgiboOkJp
	RMwGP9tLvqQmeeQbla9OuIIyJje+eR/56t2QF78TDalQV+J/ilcde+3RVRL9zm7JecLYmYUPANiud
	rN7vgzd5oFV1tZRJUc1ddOZXTXePHiXJ6p5szpObWAllZfx92F8V+MI2Jt7M7mYk+k/SDgBBM2A1v
	DPa6SGZ8lxC40v7S9E5BmgPHJjUvasXc/1h062IPIUxnlqUR8yb6lWDnPOjbkR80AH75q6RgXMmWJ
	/Q+IBwnp/V2/6W9s0AipiD5oEORGJM1nwIYeLfZdOw1nXtXC7kAOPBxaiytaX6u4SDd2Wf+tieK6m
	2fk9QyBA==;
Received: from ppp-2-84-49-240.home.otenet.gr ([2.84.49.240] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snsfV-00000004ElP-1FNu;
	Tue, 10 Sep 2024 04:39:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/12] iomap: handle a post-direct I/O invalidate race in iomap_write_delalloc_release
Date: Tue, 10 Sep 2024 07:39:03 +0300
Message-ID: <20240910043949.3481298-2-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240910043949.3481298-1-hch@lst.de>
References: <20240910043949.3481298-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

When direct I/O completions invalidates the page cache it holds neither the
i_rwsem nor the invalidate_lock so it can be racing with
iomap_write_delalloc_release.  If the search for the end of the region that
contains data returns the start offset we hit such a race and just need to
look for the end of the newly created hole instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index f420c53d86acc5..69a931de1979b9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1241,7 +1241,15 @@ static int iomap_write_delalloc_release(struct inode *inode,
 			error = data_end;
 			goto out_unlock;
 		}
-		WARN_ON_ONCE(data_end <= start_byte);
+
+		/*
+		 * If we race with post-direct I/O invalidation of the page cache,
+		 * there might be no data left at start_byte.
+		 */
+		if (data_end == start_byte)
+			continue;
+
+		WARN_ON_ONCE(data_end < start_byte);
 		WARN_ON_ONCE(data_end > scan_end_byte);
 
 		error = iomap_write_delalloc_scan(inode, &punch_start_byte,
-- 
2.45.2


