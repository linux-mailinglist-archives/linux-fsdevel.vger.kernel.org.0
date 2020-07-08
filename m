Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC092187C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 14:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgGHMjo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 08:39:44 -0400
Received: from casper.infradead.org ([90.155.50.34]:33940 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgGHMjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 08:39:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GkrkQYGdmQJutQEhdY7I3KafDobNvEk6jvWbehB6Yvo=; b=gup3UjF+a9lZXCFX1oFt0a0yT/
        vOFSQWZPV7z0jSBaBnjGdFxv4Wp0R/VWpOardAZN6Du3P2Pn0a1PPkG4gASM9GFzSGF5qFMMEMx+a
        7TDzUU2cSoMGOe0J1FIdKx4hyvINKP3Z2jQFmUr+5GkS79X+xFT/oM6QIGB2BVVOqB7x5vHl4MQGX
        lL/yyxMZA0NDJPm90i6e1lVgTqfgRqzZWB45IcpQ8cc4QXCqPLORbvXgXSmBtaZtEmBkSxl+tIH+r
        Hb12BFJuWwp14y4Pgt6c4qOqcs0fAf4zDFwYXU7hwD5FoxUpGPcIYDpJj+Q1r+klFjx/2ooMBZhci
        PL1pxk7A==;
Received: from 213-225-32-40.nat.highway.a1.net ([213.225.32.40] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jt9MF-0002M4-QH; Wed, 08 Jul 2020 12:39:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Song Liu <song@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/6] xtensa/simdisk: remove the call to check_disk_change
Date:   Wed,  8 Jul 2020 14:25:45 +0200
Message-Id: <20200708122546.214579-6-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708122546.214579-1-hch@lst.de>
References: <20200708122546.214579-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The simdisk driver doesn't support event notifications, which means
that check_disk_change is a no-op.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/platforms/iss/simdisk.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 5107140dbb7edc..3447556d276d32 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -127,8 +127,6 @@ static int simdisk_open(struct block_device *bdev, fmode_t mode)
 	struct simdisk *dev = bdev->bd_disk->private_data;
 
 	spin_lock(&dev->lock);
-	if (!dev->users)
-		check_disk_change(bdev);
 	++dev->users;
 	spin_unlock(&dev->lock);
 	return 0;
-- 
2.26.2

