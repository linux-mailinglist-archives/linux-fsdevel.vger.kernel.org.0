Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E396C8CD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Mar 2023 10:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbjCYJA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Mar 2023 05:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYJAY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Mar 2023 05:00:24 -0400
X-Greylist: delayed 1224 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Mar 2023 02:00:23 PDT
Received: from 2.mo583.mail-out.ovh.net (2.mo583.mail-out.ovh.net [178.33.109.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9251AEC68
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Mar 2023 02:00:23 -0700 (PDT)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.138.54])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 8E74524AA0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Mar 2023 08:22:58 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-b5mzw (unknown [10.110.115.83])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 399FD1FDB8;
        Sat, 25 Mar 2023 08:22:58 +0000 (UTC)
Received: from sk2.org ([37.59.142.95])
        by ghost-submission-6684bf9d7b-b5mzw with ESMTPSA
        id Hx90CGKvHmROLgAAPonFnQ
        (envelope-from <steve@sk2.org>); Sat, 25 Mar 2023 08:22:58 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-95G001979e6abd-a82b-49ba-b0fa-720b54dd7305,
                    745B6840FAD6CF9A1C2D0979EF8FEE52BEA9C661) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Stephen Kitt <steve@sk2.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Update relatime comments to include equality
Date:   Sat, 25 Mar 2023 09:22:32 +0100
Message-Id: <20230325082232.2017437-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 12637663506040260315
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeduveevffdvgfelvdfgkeevfeevvdehueeuvdegjedugfeguefhgfdvtdeivedvieenucffohhmrghinhepshhtrggtkhgvgigthhgrnhhgvgdrtghomhenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddrleehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

relatime also updates atime if the previous atime is equal to one or
both of the ctime and mtime; a non-strict interpretation of "earlier
than" and "younger than" in the comments allows this, but for clarity,
this makes it explicit.

Pointed out by "epiii2" and "ctrl-alt-delor" in
https://unix.stackexchange.com/q/740862/86440.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 fs/inode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 4558dc2f1355..3ec5a8f7b644 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1804,8 +1804,8 @@ EXPORT_SYMBOL(bmap);
 
 /*
  * With relative atime, only update atime if the previous atime is
- * earlier than either the ctime or mtime or if at least a day has
- * passed since the last atime update.
+ * earlier than or equal to either the ctime or mtime,
+ * or if at least a day has passed since the last atime update.
  */
 static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 			     struct timespec64 now)
@@ -1814,12 +1814,12 @@ static int relatime_need_update(struct vfsmount *mnt, struct inode *inode,
 	if (!(mnt->mnt_flags & MNT_RELATIME))
 		return 1;
 	/*
-	 * Is mtime younger than atime? If yes, update atime:
+	 * Is mtime younger than or equal to atime? If yes, update atime:
 	 */
 	if (timespec64_compare(&inode->i_mtime, &inode->i_atime) >= 0)
 		return 1;
 	/*
-	 * Is ctime younger than atime? If yes, update atime:
+	 * Is ctime younger than or equal to atime? If yes, update atime:
 	 */
 	if (timespec64_compare(&inode->i_ctime, &inode->i_atime) >= 0)
 		return 1;

base-commit: 65aca32efdcb0965502d3db2f1fa33838c070952
-- 
2.30.2

