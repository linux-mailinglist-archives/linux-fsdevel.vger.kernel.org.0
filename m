Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B278611CB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 11:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfLLKuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 05:50:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:57140 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728733AbfLLKuV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:50:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2BB16B187;
        Thu, 12 Dec 2019 10:50:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 085B71E0CAD; Thu, 12 Dec 2019 11:50:20 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     reiserfs-devel@vger.kernel.org
Cc:     <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] reiserfs: Fix spurious unlock in reiserfs_fill_super() error handling
Date:   Thu, 12 Dec 2019 11:50:18 +0100
Message-Id: <20191212105018.910-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212105018.910-1-jack@suse.cz>
References: <20191212105018.910-1-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we fail to allocate string for journal device name we jump to
'error' label which tries to unlock reiserfs write lock which is not
held. Jump to 'error_unlocked' instead.

Fixes: f32485be8397 ("reiserfs: delay reiserfs lock until journal initialization")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index d127af64283e..a6bce5b1fb1d 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1948,7 +1948,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 		if (!sbi->s_jdev) {
 			SWARN(silent, s, "", "Cannot allocate memory for "
 				"journal device name");
-			goto error;
+			goto error_unlocked;
 		}
 	}
 #ifdef CONFIG_QUOTA
-- 
2.16.4

