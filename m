Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E963E1B73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391826AbfJWMxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 08:53:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:49286 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391001AbfJWMxL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 08:53:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 475E4B679;
        Wed, 23 Oct 2019 12:53:09 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Benjamin Coddington <bcodding@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 1/8] cdrom: add poll_event_interruptible
Date:   Wed, 23 Oct 2019 14:52:40 +0200
Message-Id: <7fc0315de16d99ba29b4ffc565996188d290fac9.1571834862.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571834862.git.msuchanek@suse.de>
References: <cover.1571834862.git.msuchanek@suse.de>
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

