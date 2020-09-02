Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE27C25ACB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgIBONv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 10:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbgIBONL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:13:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA39C061258;
        Wed,  2 Sep 2020 07:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=F3ySvW+0LV/eEp4ukNxLWcqNSpE01eTInOOTJQ8Lr18=; b=G7X44HiRcM/JgcWlZooMaP4koW
        rcfEa3NDJkcDkQKo8ORctDDkXQ5IseKhAws17oXMoud7xM2TlcsfR/GqWZvJ75mlyalzSDqid/81C
        PAMCykjZi+PpLdP2yzYKuVt9+tFvVmIEZtbSe1zF2Yhr87Bnn0ktPOM2Q6AsFj/MDh07bvgDsHP9E
        oZh/erionLIYWEtxl7f/8F700PmHfi6W6QYGTGNoRy4a/2gsckqgfiWOBqXX3g9wTDAgGG0T59Pea
        7zGDP0q4DYNPXWRB+c5iVq2k3wL7Ys8qFaGX0hz/qWZrpj8Oz5/qWXDh/YKV78xpBK26bi+limiW5
        xnQ16DeQ==;
Received: from [2001:4bb8:184:af1:6a63:7fdb:a80e:3b0b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDTV4-0005eB-Gm; Wed, 02 Sep 2020 14:12:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-m68k@lists.linux-m68k.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/19] gdrom: use bdev_check_media_change
Date:   Wed,  2 Sep 2020 16:12:10 +0200
Message-Id: <20200902141218.212614-12-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902141218.212614-1-hch@lst.de>
References: <20200902141218.212614-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The GD-ROM driver does not have a ->revalidate_disk method, so it can
just use bdev_check_media_change without any additional changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/cdrom/gdrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 09b0cd292720fa..9874fc1c815b53 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -479,7 +479,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
 {
 	int ret;
 
-	check_disk_change(bdev);
+	bdev_check_media_change(bdev);
 
 	mutex_lock(&gdrom_mutex);
 	ret = cdrom_open(gd.cd_info, bdev, mode);
-- 
2.28.0

