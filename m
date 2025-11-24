Return-Path: <linux-fsdevel+bounces-69673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB499C80E4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99C8B345A1B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FEF30DEC7;
	Mon, 24 Nov 2025 14:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KeR0k8P5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC514C5B0;
	Mon, 24 Nov 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992821; cv=none; b=WLWBgPM//wl9RZGFGxccVQRN4mawLTYDht8dM+CCuDtgyDfJrGmz+GGojYPUVCj6bkvd+oGvEy+BtV3XcMxj8ek0jplsSeoLHmW3kQIAfWRj8+/cxfcx9o7ZYBv9fwcH2k447CS2jQv0FYDlrKMNXW7jOkEbVqvEje7eKkvPHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992821; c=relaxed/simple;
	bh=s7TG71OMZSjeM5qe8tygktwGncFNygn7/KQHn0fXUBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JdLUnfSU0kAzSTzHMZN+GlUtQLPoG7hX8Ds9DXlVTxIgNHbMhbmgVAUvAAy4yK8864+3SMwMTy70XweZ/uQlJ1ZQ2sWgceRw6SE75WMVFXqdXUQO5TgTMIekIk229wmExaxa90CPkALz4hfKl6YnhPTeVAwjnf83PxyOcKsn6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KeR0k8P5; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WDvin/rL/RoRAlCvuyQ1/rJM2feNPMMspuCCnq3UoXQ=; b=KeR0k8P5uZWWT6IF8GgTCe5TOZ
	VMpHggyXkJpt+kAY8Xe6YxqjY4ZDSMaXYuP0loj/TJDYsYGIcInFUv4+SKxEHPDUT/I2cyQZL9C9S
	nUrEVMN2sXX616wdsgJCMnX9uaF+rboGJvf9IaOp5ya6Imk3BTEtoWHnK3Vve4AwXujg0KnSMEagn
	6YPn978ifD1os/h/jg/ylogyXwSTLFA2BItnD99a0Rj7nJAwQO37GkT04CtECm3yQTMVgFXPSsk5b
	uGVTbYIY8PWVdesAR28C7nYxr4p21YI7KS97E5RENcrZ/BqcDeA1MBC+qli+zOYFKgxqLa9s8inmu
	BJGp1+qA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNX73-0000000Bnn6-2qAw;
	Mon, 24 Nov 2025 14:00:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: brauner@kernel.org
Cc: djwong@kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Subject: [PATCH] iomap: allocate s_dio_done_wq for async reads as well
Date: Mon, 24 Nov 2025 15:00:13 +0100
Message-ID: <20251124140013.902853-1-hch@lst.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Since commit 222f2c7c6d14 ("iomap: always run error completions in user
context"), read error completions are deferred to s_dio_done_wq.  This
means the workqueue also needs to be allocated for async reads.

Fixes: 222f2c7c6d14 ("iomap: always run error completions in user context")
Reported-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: syzbot+a2b9a4ed0d61b1efb3f5@syzkaller.appspotmail.com
---
 fs/iomap/direct-io.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index d4e2e328d893..8e273408453a 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -738,12 +738,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			}
 			goto out_free_dio;
 		}
+	}
 
-		if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
-			ret = sb_init_dio_done_wq(inode->i_sb);
-			if (ret < 0)
-				goto out_free_dio;
-		}
+	if (!wait_for_completion && !inode->i_sb->s_dio_done_wq) {
+		ret = sb_init_dio_done_wq(inode->i_sb);
+		if (ret < 0)
+			goto out_free_dio;
 	}
 
 	inode_dio_begin(inode);
-- 
2.47.3


