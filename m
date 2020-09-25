Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1884F2788C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Sep 2020 14:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgIYM5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Sep 2020 08:57:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729537AbgIYM5e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Sep 2020 08:57:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58EA2AB9F
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2020 12:57:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F3941E12EB; Fri, 25 Sep 2020 14:57:32 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] udf: Limit sparing table size
Date:   Fri, 25 Sep 2020 14:57:30 +0200
Message-Id: <20200925125730.8496-4-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200925125730.8496-1-jack@suse.cz>
References: <20200925125730.8496-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Although UDF standard allows it, we don't support sparing table larger
than a single block. Check it during mount so that we don't try to
access memory beyond end of buffer.

Reported-by: syzbot+9991561e714f597095da@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 7df371e59eb7..d169c1f20c6d 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1353,6 +1353,12 @@ static int udf_load_sparable_map(struct super_block *sb,
 			(int)spm->numSparingTables);
 		return -EIO;
 	}
+	if (le32_to_cpu(spm->sizeSparingTable) > sb->s_blocksize) {
+		udf_err(sb, "error loading logical volume descriptor: "
+			"Too big sparing table size (%u)\n",
+			le32_to_cpu(spm->sizeSparingTable));
+		return -EIO;
+	}
 
 	for (i = 0; i < spm->numSparingTables; i++) {
 		loc = le32_to_cpu(spm->locSparingTable[i]);
-- 
2.16.4

