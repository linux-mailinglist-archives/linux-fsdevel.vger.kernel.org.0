Return-Path: <linux-fsdevel+bounces-43644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A321A59BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1AB188CF57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB092309B1;
	Mon, 10 Mar 2025 17:03:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucr.edu (mail.cs.ucr.edu [169.235.30.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CD19004A;
	Mon, 10 Mar 2025 17:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.30.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626181; cv=none; b=IqYU1sP3ha+3/JN1RtNssXqvTv7QhL8Uz46WnarppGnA4uETUyhWMQF/hkgl6QawVo2g9bqU9JhxQ0Z7epJREvsDPWH4lfS6vchl8Yp1ZJqVxE2a/ZpJBGKopEfllGuo9uCNBNF2ujeY/sH9l7D/Jvh9HSQ3EAemSQx6JBesqD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626181; c=relaxed/simple;
	bh=hdUusOO1njK/6Sqr856+h049ZnrUaK5BHfpdHIEg3LM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mvzh5c2+GLw4SyU8W/46T6hgyPVOEIyWy5Lz3HwXsPOSPbKZm0T5eqnf9bk7ETCrpxrg34sXPKRaJmo3IzMpA/1Q8hxsC+mF2bDAxyw1QBJvr13kv8iJpl3h2OZ1Q3IPge5JNNgJoSDAZN/+mVy4Bjrem0ru7wLdrbgMPDYGBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=none smtp.mailfrom=mail.cs.ucr.edu; arc=none smtp.client-ip=169.235.30.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.cs.ucr.edu
Received: by mail.cs.ucr.edu (Postfix, from userid 1000)
	id BAB902C800243; Mon, 10 Mar 2025 09:55:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cs.ucr.edu BAB902C800243
X-Spam-Report: No
X-Spam-Level: No
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu [169.235.27.223])
	by mail.cs.ucr.edu (Postfix) with ESMTP id 9C2D92C8002FC;
	Mon, 10 Mar 2025 09:55:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.cs.ucr.edu 9C2D92C8002FC
Received: by kq.cs.ucr.edu (Postfix, from userid 101072)
	id 84D6427E46DC; Mon, 10 Mar 2025 09:54:46 -0700 (PDT)
From: Yuan Tan <tanyuan@tinylab.org>
To: axboe@kernel.dk,
	syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com
Cc: linux-block@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org,
	falcon@tinylab.org,
	tanyuan@tinylab.org
Subject: [PATCH] block: add lock for safe nrpages access in invalidate_bdev()
Date: Mon, 10 Mar 2025 09:54:00 -0700
Message-Id: <20250310165400.3166618-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>
References: <67ceb38a.050a0220.e1a89.04b1.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a data-race in __filemap_add_folio / invalidate_bdev[1]
due to concurrent access to mapping->nrpages.
Adds a lock around the access to nrpages.

[1] https://syzkaller.appspot.com/bug?extid=f2aaf773187f5cae54f3

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Reported-by: syzbot+f2aaf773187f5cae54f3@syzkaller.appspotmail.com
---
 block/bdev.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

I had already completed and tested this patch before Matthew sent the
email. I'm not sure if this solution is correct. If it's not, please
ignore the patch :)

diff --git a/block/bdev.c b/block/bdev.c
index 9d73a8fbf7f9..934043d09068 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -96,7 +96,14 @@ void invalidate_bdev(struct block_device *bdev)
 {
 	struct address_space *mapping = bdev->bd_mapping;
 
-	if (mapping->nrpages) {
+	XA_STATE(xas, &mapping->i_pages, 0);  /* we don't care about the index */
+	unsigned long nrpages;
+
+	xas_lock_irq(&xas);
+	nrpages = mapping->nrpages;
+	xas_unlock_irq(&xas);
+
+	if (nrpages) {
 		invalidate_bh_lrus();
 		lru_add_drain_all();	/* make sure all lru add caches are flushed */
 		invalidate_mapping_pages(mapping, 0, -1);
-- 
2.25.1


