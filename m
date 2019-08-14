Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9773B8D2D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 14:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfHNMS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 08:18:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38581 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfHNMS5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:18:57 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEp-0005kC-Ef; Wed, 14 Aug 2019 14:18:47 +0200
Received: from sha by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1hxsEm-00081V-Mj; Wed, 14 Aug 2019 14:18:44 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, Jan Kara <jack@suse.com>,
        Richard Weinberger <richard@nod.at>, kernel@pengutronix.de,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 03/11] fs: move __get_super() out of loop
Date:   Wed, 14 Aug 2019 14:18:26 +0200
Message-Id: <20190814121834.13983-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814121834.13983-1-s.hauer@pengutronix.de>
References: <20190814121834.13983-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__get_super_thawed() calls __get_super() multiple times. I can't see a case
where __get_super() would return another valid superblock when called
again, so move the call to __get_super() out of the loop. This is done in
preparation for the next patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/super.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 5960578a4076..f85d1ea194ae 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -786,17 +786,26 @@ EXPORT_SYMBOL(get_super);
 static struct super_block *__get_super_thawed(struct block_device *bdev,
 					      bool excl)
 {
+	struct super_block *s = __get_super(bdev, excl);
+	if (!s)
+		return NULL;
+
 	while (1) {
-		struct super_block *s = __get_super(bdev, excl);
-		if (!s || s->s_writers.frozen == SB_UNFROZEN)
+		if (s->s_writers.frozen == SB_UNFROZEN)
 			return s;
+
 		if (!excl)
 			up_read(&s->s_umount);
 		else
 			up_write(&s->s_umount);
+
 		wait_event(s->s_writers.wait_unfrozen,
 			   s->s_writers.frozen == SB_UNFROZEN);
-		put_super(s);
+
+		if (!excl)
+			down_read(&sb->s_umount);
+		else
+			down_write(&sb->s_umount);
 	}
 }
 
-- 
2.20.1

