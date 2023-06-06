Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E0E7239C6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 09:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236148AbjFFHmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbjFFHlN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:41:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C937170F;
        Tue,  6 Jun 2023 00:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vuH0cWPL8qHtuuqoY6Ow8SnHOfsHuYxiebFIU5Vf46Y=; b=3gPyZfEi+OdaSn5VmdbupG3LdE
        ESR/D4Ih4YMaf5TrcYcrdr1iKuHbg7mHVbxmotTCJCjwUcIN6ltz8oKogCmiBJFkFZGJ8kPsghRbh
        TWinvG5H7TEa+HarFNp6UZSbc3tEXcMBHWVQ1GP3jRRitkjm/KcXsiaOXCtmEV195AoHZZxxqkieO
        h7dgImMUIPTgEiqoljO4DfPKzxS/byMfRFllHAhgYIdArocY4PtiqmCq6VjM4IVNdRy33rbKk4v8F
        uyeKYJM5THg16nwQo9n+6FWB16yCz9ARfw7yvzerq+icjLbXf8w/3uamxqF8+sOFJxaVfyHZ9+jdt
        kwsG8FQA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q6RIv-000ZBa-3D;
        Tue, 06 Jun 2023 07:40:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Richard Weinberger <richard@nod.at>,
        Josef Bacik <josef@toxicpanda.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Phillip Potter <phil@philpotter.co.uk>,
        Coly Li <colyli@suse.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-um@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        linux-btrfs@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 12/31] swsusp: don't pass a stack address to blkdev_get_by_path
Date:   Tue,  6 Jun 2023 09:39:31 +0200
Message-Id: <20230606073950.225178-13-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

holder is just an on-stack pointer that can easily be reused by other calls,
replace it with a static variable that doesn't change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/power/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 81aec3b2c60510..b03ff1a33c7f68 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1510,6 +1510,8 @@ int swsusp_read(unsigned int *flags_p)
 	return error;
 }
 
+static void *swsusp_holder;
+
 /**
  *      swsusp_check - Check for swsusp signature in the resume device
  */
@@ -1517,14 +1519,13 @@ int swsusp_read(unsigned int *flags_p)
 int swsusp_check(bool snapshot_test)
 {
 	int error;
-	void *holder;
 	fmode_t mode = FMODE_READ;
 
 	if (snapshot_test)
 		mode |= FMODE_EXCL;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    mode, &holder, NULL);
+					    mode, &swsusp_holder, NULL);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
-- 
2.39.2

