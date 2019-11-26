Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC48310A4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfKZTzS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:55:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:40240 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727006AbfKZTyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7661CB0B8;
        Tue, 26 Nov 2019 19:54:43 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Hannes Reinecke <hare@suse.com>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4 rebase 06/10] bdev: reset first_open when looping in __blkget_dev
Date:   Tue, 26 Nov 2019 20:54:25 +0100
Message-Id: <b241c0d380e42c114bd9ca7955260fdd708ef76c.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is not clear that no other thread cannot open the block device when
__blkget_dev drops it and loop to restart label. Reset first_open to
false when looping.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 fs/block_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa2..545bb6c8848a 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1560,7 +1560,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	int ret;
 	int partno;
 	int perm = 0;
-	bool first_open = false;
+	bool first_open;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1580,6 +1580,7 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  restart:
 
 	ret = -ENXIO;
+	first_open = false;
 	disk = bdev_get_gendisk(bdev, &partno);
 	if (!disk)
 		goto out;
-- 
2.23.0

