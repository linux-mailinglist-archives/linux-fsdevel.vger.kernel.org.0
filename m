Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E125D73E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 12:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbfJOKu4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 06:50:56 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:42932 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727142AbfJOKu4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:50:56 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iKKPi-0007WH-T0; Tue, 15 Oct 2019 11:50:50 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iKKPi-0008BP-Eu; Tue, 15 Oct 2019 11:50:50 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/fnctl: fix missing __user in fcntl_rw_hint()
Date:   Tue, 15 Oct 2019 11:50:49 +0100
Message-Id: <20191015105049.31412-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The fcntl_rw_hint() has a missing __user annotation in
the code when assinging argp. Add this to fix the
following sparse warnings:

fs/fcntl.c:280:22: warning: incorrect type in initializer (different address spaces)
fs/fcntl.c:280:22:    expected unsigned long long [usertype] *argp
fs/fcntl.c:280:22:    got unsigned long long [noderef] [usertype] <asn:1> *
fs/fcntl.c:287:34: warning: incorrect type in argument 1 (different address spaces)
fs/fcntl.c:287:34:    expected void [noderef] <asn:1> *to
fs/fcntl.c:287:34:    got unsigned long long [usertype] *argp
fs/fcntl.c:291:40: warning: incorrect type in argument 2 (different address spaces)
fs/fcntl.c:291:40:    expected void const [noderef] <asn:1> *from
fs/fcntl.c:291:40:    got unsigned long long [usertype] *argp
fs/fcntl.c:303:34: warning: incorrect type in argument 1 (different address spaces)
fs/fcntl.c:303:34:    expected void [noderef] <asn:1> *to
fs/fcntl.c:303:34:    got unsigned long long [usertype] *argp
fs/fcntl.c:307:40: warning: incorrect type in argument 2 (different address spaces)
fs/fcntl.c:307:40:    expected void const [noderef] <asn:1> *from
fs/fcntl.c:307:40:    got unsigned long long [usertype] *argp

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Jeff Layton <jlayton@kernel.org>
Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..7ca7562f2b79 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -277,7 +277,7 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 			  unsigned long arg)
 {
 	struct inode *inode = file_inode(file);
-	u64 *argp = (u64 __user *)arg;
+	u64 __user *argp = (u64 __user *)arg;
 	enum rw_hint hint;
 	u64 h;
 
-- 
2.23.0

