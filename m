Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3531B2B7037
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 21:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgKQUgV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 15:36:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgKQUgV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605645379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G8/wxJoq12QfdqHJtRO4GIpzD5Y227qifeERfdJXT9A=;
        b=V4xYwmr1OVnshCWUb7xlnE4JS5i4KBtq5Uio3ktcB7fwdTiwbmQ6WkAr7rQWTn04Mnutye
        FihFLVTJ2vS/gJz7l0suN+9e/1pb+NhTYWE/hBLGUCNPAxsnp0AHWH4iY69tVhQpuhWkg9
        Vj5W3T1N3EEMO0geaUmvsSkNJEZu4/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-zg-lqcXVP2uA9_nkr76IBA-1; Tue, 17 Nov 2020 15:36:18 -0500
X-MC-Unique: zg-lqcXVP2uA9_nkr76IBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28A918030DA;
        Tue, 17 Nov 2020 20:36:17 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-190.rdu2.redhat.com [10.10.112.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9180E5C1CF;
        Tue, 17 Nov 2020 20:36:16 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2] buffer_io_error: Use dev_err_ratelimited
Date:   Tue, 17 Nov 2020 14:36:16 -0600
Message-Id: <20201117203616.307787-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace printk_ratelimited with dev_err_ratelimited which
adds dev_printk meta data. This is used by journald to
add disk ID information to the journal entry.

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---

V2: 

- Move change log to after marker line (Andy Shevchenko)
- Remove printk cast (Andy Shevchenko)
    
V1: 

This re-worked change is from a different patch series
and utilizes the following suggestions.
    
- Reduce indentation level (Andy Shevchenko)
- Remove unneeded () for conditional operator (Sergei Shtylyov)

 fs/buffer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50bbc99e3d96..32f237e350bf 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -125,10 +125,17 @@ EXPORT_SYMBOL(__wait_on_buffer);
 
 static void buffer_io_error(struct buffer_head *bh, char *msg)
 {
-	if (!test_bit(BH_Quiet, &bh->b_state))
-		printk_ratelimited(KERN_ERR
-			"Buffer I/O error on dev %pg, logical block %llu%s\n",
-			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
+	struct device *gendev;
+
+	if (test_bit(BH_Quiet, &bh->b_state))
+		return;
+
+	gendev = bh->b_bdev->bd_disk ?
+		disk_to_dev(bh->b_bdev->bd_disk) : NULL;
+
+	dev_err_ratelimited(gendev,
+		"Buffer I/O error, logical block %llu%s\n",
+		bh->b_blocknr, msg);
 }
 
 /*

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.26.2

