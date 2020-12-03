Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB3E2CE09B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 22:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgLCV1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 16:27:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCV1W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:27:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F54C061A4F;
        Thu,  3 Dec 2020 13:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=juCGwxNJR/WCN39XNy/MX6jWiwiXbFwfdpu+ylfus94=; b=SKOsOILzFmz5ZttUfXMLGUCI54
        Ykz38opfbLDgceMuUrxiypy/35dV71Ew77+OkRPVXlZBn7ex7q36Ise1eWYdCxDAtaf719qJczNVP
        KtAW0De6B8WMwAKcMjZexJxikO+U6viLd6wwFR2OZKBzfpmmUaK58ktSRK2piTFtHVwLX5cI/RVfr
        Uwtc4qefNJP4qJ2FKShy76Gty4FIGEI0dvN+R1D8Kfk4O45+Hv4WLwvHF/xziH0mFr1nXNGGh8me0
        Q907TvwtM7Mn3MwmemjuGi5eZjIoDzcVojzs71fKSjbBZHTIauU32ah27xDBnJx2bU7x6ZQjnJHR7
        rOw8GhlQ==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkw7a-00080h-SI; Thu, 03 Dec 2020 21:26:39 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] bfs: don't use WARNING: string when it's just info.
Date:   Thu,  3 Dec 2020 13:26:34 -0800
Message-Id: <20201203212634.17278-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make the printk() [bfs "printf" macro] seem less severe by changing
"WARNING:" to "NOTE:".

<asm-generic/bug.h> warns us about using WARNING or BUG in a
format string other than in WARN() or BUG() family macros.
bfs/inode.c is doing just that in a normal printk() call, so
change the "WARNING" string to be "NOTE".

Reported-by: syzbot+3fd34060f26e766536ff@syzkaller.appspotmail.com
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/bfs/inode.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201127.orig/fs/bfs/inode.c
+++ linux-next-20201127/fs/bfs/inode.c
@@ -350,7 +350,7 @@ static int bfs_fill_super(struct super_b
 
 	info->si_lasti = (le32_to_cpu(bfs_sb->s_start) - BFS_BSIZE) / sizeof(struct bfs_inode) + BFS_ROOT_INO - 1;
 	if (info->si_lasti == BFS_MAX_LASTI)
-		printf("WARNING: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
+		printf("NOTE: filesystem %s was created with 512 inodes, the real maximum is 511, mounting anyway\n", s->s_id);
 	else if (info->si_lasti > BFS_MAX_LASTI) {
 		printf("Impossible last inode number %lu > %d on %s\n", info->si_lasti, BFS_MAX_LASTI, s->s_id);
 		goto out1;
