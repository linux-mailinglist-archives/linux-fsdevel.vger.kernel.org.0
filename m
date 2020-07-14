Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F4321FCB0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 21:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgGNTLA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 15:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgGNTI6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:08:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88DCC061755;
        Tue, 14 Jul 2020 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ldk35b647Blt4bomZ36KmbfkoU4onYAwVp0xJ3QcwvM=; b=lCDAzL5PEoWj3Zv8OCtq7KXifo
        q4/YWDxx86bG7QJvCno34VPOO6pcAqRbBZXTdtYRWZzOLFuq1Aqo7AsL0eGleCI1DfuH+aacsT/sE
        v6JB42zM0NNfOVb5MiZemMGVEdG+H9XTQygGYjD2JElDBYZHn20QR+ofcBpLsZGUE8toK/bLvI3s6
        yoZQmeTmjVfQCPpDFlZyTph6+wM14MTR0bWJMhect5yeF6ur/XddYngIvRZWAr3jHhuraCqvgTifJ
        4l2v6IMRLZ3HYXlLb/axs8/CzDfcL9QjIU1jtMmn403H2pmTRQ5pMeE1PHtmEwtgs968XDX2MOdVd
        +SnRNXEQ==;
Received: from [2001:4bb8:188:5f50:f037:8cfe:627e:7028] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvQIS-0005qG-CA; Tue, 14 Jul 2020 19:08:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/23] md: remove the autoscan partition re-read
Date:   Tue, 14 Jul 2020 21:04:10 +0200
Message-Id: <20200714190427.4332-7-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
References: <20200714190427.4332-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

devfs is long gone, and autoscan works just fine without this these days.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md-autodetect.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/md/md-autodetect.c b/drivers/md/md-autodetect.c
index 0eb746211ed53c..6bc9b734eee6ff 100644
--- a/drivers/md/md-autodetect.c
+++ b/drivers/md/md-autodetect.c
@@ -240,16 +240,6 @@ static void __init md_setup_drive(void)
 			err = ksys_ioctl(fd, RUN_ARRAY, 0);
 		if (err)
 			printk(KERN_WARNING "md: starting md%d failed\n", minor);
-		else {
-			/* reread the partition table.
-			 * I (neilb) and not sure why this is needed, but I cannot
-			 * boot a kernel with devfs compiled in from partitioned md
-			 * array without it
-			 */
-			ksys_close(fd);
-			fd = ksys_open(name, 0, 0);
-			ksys_ioctl(fd, BLKRRPART, 0);
-		}
 		ksys_close(fd);
 	}
 }
-- 
2.27.0

