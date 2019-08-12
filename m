Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6726789557
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2019 04:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfHLCQt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Aug 2019 22:16:49 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:60447 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfHLCQt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Aug 2019 22:16:49 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x7C2GKdJ086225;
        Mon, 12 Aug 2019 11:16:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp);
 Mon, 12 Aug 2019 11:16:20 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav402.sakura.ne.jp)
Received: from ccsecurity.localdomain (softbank126227201116.bbtec.net [126.227.201.116])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x7C2GBYp086184
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 11:16:20 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        "J. Bruce Fields" <bfields@redhat.com>,
        syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
Subject: [PATCH] nfsd: fix dentry leak upon mkdir failure.
Date:   Mon, 12 Aug 2019 11:16:11 +0900
Message-Id: <1565576171-6586-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <0000000000001097b6058fe1fb22@google.com>
References: <0000000000001097b6058fe1fb22@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot is reporting that nfsd_mkdir() forgot to remove dentry created by
d_alloc_name() when __nfsd_mkdir() failed (due to memory allocation fault
injection) [1].

[1] https://syzkaller.appspot.com/bug?id=ce41a1f769ea4637ebffedf004a803e8405b4674

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+2c95195d5d433f6ed6cb@syzkaller.appspotmail.com>
Fixes: e8a79fb14f6b76b5 ("nfsd: add nfsd/clients directory")
Cc: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfsctl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 13c5487..e32dc1c 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1176,8 +1176,10 @@ static int __nfsd_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	struct inode *inode;
 
 	inode = nfsd_get_inode(dir->i_sb, mode);
-	if (!inode)
+	if (!inode) {
+		dput(dentry);
 		return -ENOMEM;
+	}
 	d_add(dentry, inode);
 	inc_nlink(dir);
 	fsnotify_mkdir(dir, dentry);
-- 
1.8.3.1

