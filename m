Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A992221A35A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgGIPTl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 11:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgGIPSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:18:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7BC08C5DC;
        Thu,  9 Jul 2020 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=EhX9Q3ZGDojbQvb1EzGZvSpfqH7btOJeCuQpHhIypuc=; b=FVHwwdtZvDaxIUJS9eAkXYejFo
        frByOBRVJz21caBymP5nVCdUD0pnfSksQ/XJ9SMY1PjZ6/SThIYpYQ6/JcoY4fXAVCM7dXvPPjFY/
        bhMb6Tkojt29sCo313lLR9VSpNeNdSQ+cBRYOmmV/m69e5niAOCIG1fcAiOQECscYzYCz1+uonekZ
        JJjY/UehpmehNYom3t0f2ypHA5mRdgSHfaF1+cmaTPKs1+PgorP8kLBqa7QIoKLMHeRcurYVl4pbD
        EBB3fZpxN2vDEW+Md6CvSDRZIBcoCIW/Cg9Hi9pk5WauMRJL5nLM+R9MsBmFUn89UcmWLChBqRCoj
        EwuOJTmA==;
Received: from [2001:4bb8:188:5f50:7053:304b:bf82:82cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtYJZ-0005KL-R7; Thu, 09 Jul 2020 15:18:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/17] md: remove the autoscan partition re-read
Date:   Thu,  9 Jul 2020 17:18:01 +0200
Message-Id: <20200709151814.110422-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200709151814.110422-1-hch@lst.de>
References: <20200709151814.110422-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

devfs is long gone, and autoscan works just fine without this these days.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
2.26.2

