Return-Path: <linux-fsdevel+bounces-43303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F66A50CCB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 21:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3A2160A3F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Mar 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656D1253340;
	Wed,  5 Mar 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FZYpwx2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8922F25486B
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Mar 2025 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741207661; cv=none; b=PE17FDsOkepskWeaZU9610wPRmGXmOcaHg/d2BD/mR4JGyAJQlaAEQ5d7nL/wFoxNu3u6wrzwm7WAS/7Ciz7qr/+hcQFNRf4KWIzUPM6B/iuE6iA1VWCJDx5t+GRszobH/VeHVTaukrwTgb+7OWBhdji5fbXSQ2moOb2RSo717c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741207661; c=relaxed/simple;
	bh=SzG9HOQSoXm+MAoPjlJAH/t0h0G5IDNciFoyhbM+hjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VpIycVFPJxlt2jsC6EBdqhRe9zC5L689oasfLAifWT7iQl3USA2VUqkBAiO4Y6QRJSwsEpd593CGmKBs9njVjTwDnj0pMia2yiwxYpK6qA4WkpPZxo/KmxxNa4xPo8Y0lG7M8l2vc0rnWZI1IHHPw9OOBXtYCWzWpX0Q5kGzews=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FZYpwx2Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=5BzNXNHKC1Tn1Nct68aiy/1TPdaC/IIAzgU3YaciPxg=; b=FZYpwx2Z0PJcR27ACxunai6Drb
	oEUvYV1JLIwfx0bmwK+cv5nVnyDxIQrxkDKRt7pYi3rr82ldi4+qapAiYIy95sqiNFFQinPQz+f7x
	k8e8Xl3n3+7vyNDb2idXXybYLjODZg+ypuA5XS3tUz/KzUQB4tTGCSWA/a+/xvJzs2oSmGlbbT11N
	4qew6J39cADntK4LwT2yks2HAdHvg6/uVCpIHlpolISR63324q39kzVj4Ky2Bj//JXzL/Wkyv7F81
	HcMaGpTJny4HrSfwtoJ8MQHyK7p0raOLLEHqQ0jrflxsttpotjnQ1VqWk/HI6kKFiENfW9KO/DGof
	B0lQw8iw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tpveT-00000006BnV-2fg4;
	Wed, 05 Mar 2025 20:47:37 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	devel@lists.orangefs.org,
	linux-fsdevel@vger.kernel.org,
	Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH v2 7/9] orangefs: Unify error & success paths in orangefs_writepages_work()
Date: Wed,  5 Mar 2025 20:47:31 +0000
Message-ID: <20250305204734.1475264-8-willy@infradead.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305204734.1475264-1-willy@infradead.org>
References: <20250305204734.1475264-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both arms of this conditional now have the same loop, so sink it out
of the conditional.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Tested-by: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/inode.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 879d96c11b1c..927c2829976c 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -107,33 +107,23 @@ static int orangefs_writepages_work(struct orangefs_writepages *ow,
 	wr.gid = ow->gid;
 	ret = wait_for_direct_io(ORANGEFS_IO_WRITE, inode, &off, &iter, ow->len,
 	    0, &wr, NULL, NULL);
-	if (ret < 0) {
+	if (ret < 0)
 		mapping_set_error(ow->mapping, ret);
-		for (i = 0; i < ow->npages; i++) {
-			if (PagePrivate(ow->pages[i])) {
-				wrp = (struct orangefs_write_range *)
-				    page_private(ow->pages[i]);
-				ClearPagePrivate(ow->pages[i]);
-				put_page(ow->pages[i]);
-				kfree(wrp);
-			}
-			end_page_writeback(ow->pages[i]);
-			unlock_page(ow->pages[i]);
-		}
-	} else {
+	else
 		ret = 0;
-		for (i = 0; i < ow->npages; i++) {
-			if (PagePrivate(ow->pages[i])) {
-				wrp = (struct orangefs_write_range *)
-				    page_private(ow->pages[i]);
-				ClearPagePrivate(ow->pages[i]);
-				put_page(ow->pages[i]);
-				kfree(wrp);
-			}
-			end_page_writeback(ow->pages[i]);
-			unlock_page(ow->pages[i]);
+
+	for (i = 0; i < ow->npages; i++) {
+		if (PagePrivate(ow->pages[i])) {
+			wrp = (struct orangefs_write_range *)
+			    page_private(ow->pages[i]);
+			ClearPagePrivate(ow->pages[i]);
+			put_page(ow->pages[i]);
+			kfree(wrp);
 		}
+		end_page_writeback(ow->pages[i]);
+		unlock_page(ow->pages[i]);
 	}
+
 	return ret;
 }
 
-- 
2.47.2


