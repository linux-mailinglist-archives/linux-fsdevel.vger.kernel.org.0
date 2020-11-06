Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEB62A9D2C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgKFTE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728232AbgKFTEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B7BC0613D2;
        Fri,  6 Nov 2020 11:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=X/fdtbnM6VzLEnbiAcIZtVB4MyztRye1iMhB9bpmGjw=; b=KdFsWVDDKhCb1S0+D0SokRPV+y
        +J4M6xcEJslqQfLhh8x6+66DaWFnczf1aBndVMP3EIIA+96ALRDycvFUpIzf2js2xvrsL5iP6O1+A
        ZKLK8qzUck32sEA469YdsEhBj5KXKjBMfIrXwNzMerCpymh6yL7J+3OCKmpXeH15Tn7bxLuzBCRLz
        hl7TxbtqOEdufrClF29OKAO2fi/5ZmeFIHiUXsY/1CVk/DF7ZGpB+29s9GAZmn5HLwCP/ya6jSA1Q
        muKeYFGA3/E5oI4KqySpaJNW0DC9LvJqAjqN3XUqHjqzBVWPtrxSloZh0rikWjmPlEjklxeW4xqF+
        LXF3M7pQ==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb72G-00016V-3y; Fri, 06 Nov 2020 19:04:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/24] md: remove a spurious call to revalidate_disk_size in update_size
Date:   Fri,  6 Nov 2020 20:03:34 +0100
Message-Id: <20201106190337.1973127-23-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

None of the ->resize methods updates the disk size, so calling
revalidate_disk_size here won't do anything.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-cluster.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 87442dc59f6ca3..35e2690c1803dd 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1299,8 +1299,6 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
 	} else {
 		/* revert to previous sectors */
 		ret = mddev->pers->resize(mddev, old_dev_sectors);
-		if (!ret)
-			revalidate_disk_size(mddev->gendisk, true);
 		ret = __sendmsg(cinfo, &cmsg);
 		if (ret)
 			pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
-- 
2.28.0

