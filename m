Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653F910A4DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2019 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKZTyn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Nov 2019 14:54:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:40158 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbfKZTyk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Nov 2019 14:54:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B5DF8AD3B;
        Tue, 26 Nov 2019 19:54:38 +0000 (UTC)
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
Subject: [PATCH v4 rebase 01/10] cdrom: add poll_event_interruptible
Date:   Tue, 26 Nov 2019 20:54:20 +0100
Message-Id: <e42492fccee554e167e617a2cb066bad15efa14b.1574797504.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574797504.git.msuchanek@suse.de>
References: <cover.1574797504.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add convenience macro for polling an event that does not have a
waitqueue.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 drivers/cdrom/cdrom.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index ac42ae4651ce..2ad6b73482fe 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -282,10 +282,24 @@
 #include <linux/fcntl.h>
 #include <linux/blkdev.h>
 #include <linux/times.h>
+#include <linux/delay.h>
 #include <linux/uaccess.h>
+#include <linux/sched/signal.h>
 #include <scsi/scsi_common.h>
 #include <scsi/scsi_request.h>
 
+#define poll_event_interruptible(event, interval) ({ \
+	int ret = 0; \
+	while (!(event)) { \
+		if (signal_pending(current)) { \
+			ret = -ERESTARTSYS; \
+			break; \
+		} \
+		msleep_interruptible(interval); \
+	} \
+	ret; \
+})
+
 /* used to tell the module to turn on full debugging messages */
 static bool debug;
 /* default compatibility mode */
-- 
2.23.0

