Return-Path: <linux-fsdevel+bounces-3843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F6F7F92A6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 13:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA7CD1C20B05
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Nov 2023 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DB8D2EA;
	Sun, 26 Nov 2023 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wBpVm4XP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A07AEB;
	Sun, 26 Nov 2023 04:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VOJ+OhWMdxatCYdzTdcHH3XOKvdIXVzUwQzfovaJkaY=; b=wBpVm4XPcC2JRGSYRb7HrWSc1B
	IkQaEPRGoW1gxtPz85HmukgCC7wiUV7KKbaE5t3qnPPWsJAKBemx8hAFYzZmSccG8RRNi01gEEidi
	mbzs9Pd/OSBW4KAY77ldP28pwGlHYw2sKuDAZF5nQZHkg0og8of47aG9t42/qacmlEUg/25ZYyq1+
	1M7GW8j5IitSYXN8kPkv7qcfuOMlY7iXsdq/kBAPvti9cXPusulUPIZZv3GCXIFALW0MhBQotaT/K
	38w41Yjhsf1UfvrqQ5rVW+NOEmX8LbJ2InEdemGHadn1O+GQYwW+PQDY3kZ05t6VzkFcO5+FMlYNY
	YGyssV0g==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1r7EXr-00BCDU-2Z;
	Sun, 26 Nov 2023 12:47:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/13] iomap: treat inline data in iomap_writepage_map as an I/O error
Date: Sun, 26 Nov 2023 13:47:09 +0100
Message-Id: <20231126124720.1249310-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231126124720.1249310-1-hch@lst.de>
References: <20231126124720.1249310-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

iomap_writepage_map aready warns about inline data, but then just ignores
it.  Treat it as an error and return -EIO.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/iomap/buffered-io.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 98d52feb220f0a..b1bcc43baf0caf 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1818,8 +1818,10 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 		if (error)
 			break;
 		trace_iomap_writepage_map(inode, &wpc->iomap);
-		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE))
-			continue;
+		if (WARN_ON_ONCE(wpc->iomap.type == IOMAP_INLINE)) {
+			error = -EIO;
+			break;
+		}
 		if (wpc->iomap.type == IOMAP_HOLE)
 			continue;
 		iomap_add_to_ioend(inode, pos, folio, ifs, wpc, wbc,
-- 
2.39.2


