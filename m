Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE08E49D7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 13:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409275AbfJYLVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 07:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56812 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbfJYLVv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:21:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 396CDB227;
        Fri, 25 Oct 2019 11:21:49 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Ewan D. Milne" <emilne@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/7] cdrom: add poll_event_interruptible
Date:   Fri, 25 Oct 2019 13:21:38 +0200
Message-Id: <0a5ab9c86120851692aaa4390ee85ab9b2f86a8a.1572002144.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1572002144.git.msuchanek@suse.de>
References: <cover.1572002144.git.msuchanek@suse.de>
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

