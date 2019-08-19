Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA06951D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 01:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbfHSXrk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 19:47:40 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42762 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbfHSXrk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 19:47:40 -0400
Received: by mail-yw1-f65.google.com with SMTP id z63so1579434ywz.9;
        Mon, 19 Aug 2019 16:47:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4Iy+tGZa9MuoKDFNlVuMOvVXUYJe5OTSe94gRpB2FE4=;
        b=MoHO2qCA8nVuYZ/bh+uCz24CNnYoAxwHTqKqnguLc09RVo5HCeQALTX4QGwcsZQ06m
         XNcQfUHAG/ummrhOXvfQvSQ6cO+/m+8PcxBg5WDQNeACDYATutm1lj2Ppk4by4ijeIDj
         f81HgcVE29lyfK9qoGlVSx9yJXXuFbVDTAPpAa4Xcse+laSKf4C1gJiRlCMDW+Q3UyEm
         HwPwsFDDjWXLqFHtlnFuQpzUvZccyVZyUClx3RCMyi4Jj9xd2IFQYBCay749tVsg3f7X
         k/wdY8RBmznbiwhEmYZTomwhdqW17Yo2x7dwSN+u7C6f/A2gxEEnvjY6IiWssJbTjKgo
         dGZQ==
X-Gm-Message-State: APjAAAUEzCP+P9lt7vVkEDrCK16i9LbefbaeEhf88tgS6GF6EMXc2DyL
        DfbNy/GvYaTQxqeYFKatJRk=
X-Google-Smtp-Source: APXvYqxRLKSR1+vM8bB5daeSs4Gx0i/oT6ia/P1Gb8RpE5QMJJ0WMe8o7+fGW3077LSAEjNXxq4pNg==
X-Received: by 2002:a81:2305:: with SMTP id j5mr9857116ywj.81.1566258459429;
        Mon, 19 Aug 2019 16:47:39 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id x138sm3357252ywg.4.2019.08.19.16.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Aug 2019 16:47:38 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
        infrastructure)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] locks: fix a memory leak bug
Date:   Mon, 19 Aug 2019 18:47:34 -0500
Message-Id: <1566258454-7684-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In __break_lease(), the file lock 'new_fl' is allocated in lease_alloc().
However, it is not deallocated in the following execution if
smp_load_acquire() fails, leading to a memory leak bug. To fix this issue,
free 'new_fl' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 fs/locks.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 686eae2..5993b2a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1592,7 +1592,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	ctx = smp_load_acquire(&inode->i_flctx);
 	if (!ctx) {
 		WARN_ON_ONCE(1);
-		return error;
+		goto free_lock;
 	}
 
 	percpu_down_read(&file_rwsem);
@@ -1672,6 +1672,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	spin_unlock(&ctx->flc_lock);
 	percpu_up_read(&file_rwsem);
 	locks_dispose_list(&dispose);
+free_lock:
 	locks_free_lock(new_fl);
 	return error;
 }
-- 
2.7.4

