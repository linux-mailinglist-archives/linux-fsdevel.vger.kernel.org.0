Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E0329918E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Oct 2020 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784574AbgJZP6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Oct 2020 11:58:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58185 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1784566AbgJZP5g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603727855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XtIg8kCXjeLzHwMGzqXo41x42k9dsaG3Y++Yc06Zfug=;
        b=GIk+20tHj/68YBnYvBaAmTV+EdPHLdkIyKg2HT0MjXMWaDMNsV1xMGI9u1Vnn+5t4JstOc
        EFuyfq/RangxguVi2UD1VepML3omFhC1QdLjPPRtA2mSK1qjFCbmScVql37Qxyw9/yJKiy
        2SiKXYAoL0vXgJ6zSZkCW8plO/qRidI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-IQ5xuMxoN4ejX9L8vlKzSQ-1; Mon, 26 Oct 2020 11:57:33 -0400
X-MC-Unique: IQ5xuMxoN4ejX9L8vlKzSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0513E106B26E;
        Mon, 26 Oct 2020 15:57:32 +0000 (UTC)
Received: from sulaco.redhat.com (ovpn-112-242.rdu2.redhat.com [10.10.112.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E4F25B4B2;
        Mon, 26 Oct 2020 15:57:31 +0000 (UTC)
From:   Tony Asleson <tasleson@redhat.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] buffer_io_error: Use dev_err_ratelimited
Date:   Mon, 26 Oct 2020 10:57:30 -0500
Message-Id: <20201026155730.542020-1-tasleson@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace printk_ratelimited with dev_err_ratelimited which
adds dev_printk meta data. This is used by journald to
add disk ID information to the journal entry.

This re-worked change is from a different patch series
and utilizes the following suggestions.

- Reduce indentation level (Andy Shevchenko)
- Remove unneeded () for conditional operator (Sergei Shtylyov)

Signed-off-by: Tony Asleson <tasleson@redhat.com>
---
 fs/buffer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 50bbc99e3d96..18175fbb1101 100644
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
+		(unsigned long long)bh->b_blocknr, msg);
 }
 
 /*

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.26.2

