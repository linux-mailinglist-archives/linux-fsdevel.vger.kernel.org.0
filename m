Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9279474030
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Dec 2021 11:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232879AbhLNKOd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Dec 2021 05:14:33 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33528 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhLNKOb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Dec 2021 05:14:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 358CC1F3C4;
        Tue, 14 Dec 2021 10:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639476870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RMZaY+rA5tmkbUf8JzLdGe9JjYsq40PJZ05Xghdt73E=;
        b=KlBRHCaEZPgMgvz5xLBLTjVDLT6NPtLbWvPp7CIcDMOe5i/AzoRNYegLlzz4S6e/i6wjHS
        3JJ2a8BJNkvbnUpW+ASGe5+uWNJSK3ZVAm5P/H7DLJZdcJsiLoEKxiddq36D/E276/04PW
        iYc7kQkuTsSO4JkmRLXiI2aIrjGmhuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639476870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RMZaY+rA5tmkbUf8JzLdGe9JjYsq40PJZ05Xghdt73E=;
        b=RpLM8t+fmm4dZwijzbxW4qRyGHqQQT6Vt7bxbt1oro8m1hyPoh/uYjrrbGLUu5O6ng6V3S
        SHmj8+XIh+eA3OCA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id 22A09A3B81;
        Tue, 14 Dec 2021 10:14:30 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E83AC1E1581; Tue, 14 Dec 2021 11:14:29 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot+9ca499bb57a2b9e4c652@syzkaller.appspotmail.com
Subject: [PATCH] udf: Fix error handling in udf_new_inode()
Date:   Tue, 14 Dec 2021 11:14:28 +0100
Message-Id: <20211214101428.32085-1-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; h=from:subject; bh=s7i1qo9+BxjbNF4Fh5eka9bRRRcBiim8/YPGYAu+vnc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhuG5+tS4R0+0kMNahpqRuUS0q4w9jUf7NS1GDSsU3 Yx4NbO+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYbhufgAKCRCcnaoHP2RA2QbzCA DQN/j3W1m35mhHQ5PIfpW3AKC8dfF6tQtqqb+Zk3zDbFftGrjj/+T7mBYE5EOH0kvL5RrujJ54gs9/ oNeZ/qpdTZppxyhTQDQKZyCeSOt49wEv3c+97ZrkE9kLzGLRdVJUpCxWhyKCDfdzOUL/zvuvPqmuDh 1jgUgBjEM0ZCT0Ei4b3AggVwibW85f6R1aekOKoxvHHc1Ks1nl9rT7AJDurMW04q76zYLcqh0NJ1M/ 1Ou7CFoYW5zg8klRdDTQficnVgdn5aemjeKo/sQ436bUmHaLhoysTVRwYBAqXD2HRvg/PIHDCzKnyD FxVMg2nzFyxVSlArIGROr4V7Fm5Xmx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When memory allocation of iinfo or block allocation fails, already
allocated struct udf_inode_info gets freed with iput() and
udf_evict_inode() may look at inode fields which are not properly
initialized. Fix it by marking inode bad before dropping reference to it
in udf_new_inode().

Reported-by: syzbot+9ca499bb57a2b9e4c652@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/ialloc.c | 2 ++
 1 file changed, 2 insertions(+)

I plan to queue this fix into my tree.

								Honza

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 2ecf0e87660e..b5d611cee749 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -77,6 +77,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 					GFP_KERNEL);
 	}
 	if (!iinfo->i_data) {
+		make_bad_inode(inode);
 		iput(inode);
 		return ERR_PTR(-ENOMEM);
 	}
@@ -86,6 +87,7 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 			      dinfo->i_location.partitionReferenceNum,
 			      start, &err);
 	if (err) {
+		make_bad_inode(inode);
 		iput(inode);
 		return ERR_PTR(err);
 	}
-- 
2.26.2

