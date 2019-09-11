Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D182AFA26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 12:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfIKKPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Sep 2019 06:15:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34225 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfIKKPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Sep 2019 06:15:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so11310412pgc.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2019 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Ry6ajNyh/0breEuSmOCiSm0eNBsSiDuEaP8SmdpUUzc=;
        b=Oukg04IOcUy2wnwFY26GN4KWkFD+d0n5/lB3hX8vPM/LTjYeErPlk9SVO9i9YGwVHb
         tW4B7stJ8XVsWrgUDGJhftn7xcjWR9No9P4kUinMD48icVHrrZglDlV8gGhlqtFuXZ8w
         zjv2kvKAMQ7mJNLMa3a68ihmBI91DfK5KNsSayyrI8LoxVaNt1R7e+Ox5ZZPFIXbuUbS
         FUXTePhLlHbC6CtQNFHcXzvTpcln7NqXKHrIaRj8NndiNYTgsBjixI+XnmjEXurVs38j
         CaQgFqZTq3njSRiyoMC0nKbnWrysK4tYLrQOkoo1dA9qPTUSolTPgDiIEV+Zm+2PS4fF
         YImA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ry6ajNyh/0breEuSmOCiSm0eNBsSiDuEaP8SmdpUUzc=;
        b=gZb9/T7BSNIn8jcXHvyW+05If6HdRCPjWrZhTMbagaVC9cTz1Vpr1ZJcrFc3JA/QJH
         eZuOcNUfqMb4gCKkWXTXf503IWaiOxVvq2V47WvDVNYVxi3hQLvhe9dvN6QFMKfzk8Iv
         nEKvcMei/PRXtD1GMplXWDua1iaAmxlv8Ev9Yn58kXhMrcj3wYW2SILAcZ0MjVo8ghVK
         sq7UlWGjZGn8woutmBgjyvSvkOT+iSfnK/Im36e3dFO9sPJGFZSQlZ4FenSUMyV6DGn+
         IhplF/ILb9nHh9NIQ1AkWjfxQskVW15hGaTVxLg6Q7uETB2JVTuK7oAS8Vnp+ZaSZ/pn
         AbLg==
X-Gm-Message-State: APjAAAWKEK59ENkCUsI+AoexReNPWn+1PvGFvuElUKIbEPKF/dVjE4+C
        kgJOcPQOQc6irgQVgsCmO43IDysT8kQgWA==
X-Google-Smtp-Source: APXvYqwDZ7D+ztZV+TWyz7L4vdxY16DmjH+mf9ujAX3+LAOrqPN/CaCnpN7Z49J1EFuMGYfVUHTjqQ==
X-Received: by 2002:a17:90a:1502:: with SMTP id l2mr4601245pja.140.1568196934856;
        Wed, 11 Sep 2019 03:15:34 -0700 (PDT)
Received: from india11.lab ([205.234.21.5])
        by smtp.gmail.com with ESMTPSA id v10sm2098913pjk.23.2019.09.11.03.15.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 03:15:34 -0700 (PDT)
From:   Chakra Divi <chakragithub@gmail.com>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Cc:     Chakra Divi <chakragithub@gmail.com>
Subject: [PATCH] fuse:send filep uid as part of fuse write req
Date:   Wed, 11 Sep 2019 10:15:17 +0000
Message-Id: <1568196917-25674-1-git-send-email-chakragithub@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In current code in fuse write request current_fsuid is sent,
however this creates an issue in sudo execution context.
Changes to consider uid and gid from file struture pointer
that is created as part of open file instead of current_fsuid,gid

Steps to reproduce the issue:
1) create user1 and user2
2) create a file1 with user1 on fusemount
3) change the file1 permissions to 600
4) execute the following command
user1@linux# sudo -u user2 whoami >> /fusemnt/file1
Here write fails with permission denied error

on nfs and ext4 - above use case is working, but on fuse
its failing

Signed-off-by: Chakra Divi <chakragithub@gmail.com>
---
 fs/fuse/file.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5ae2828..e1d223c 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1134,6 +1134,7 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 	struct inode *inode = mapping->host;
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct file *file = iocb->ki_filp;
 	int err = 0;
 	ssize_t res = 0;
 
@@ -1150,6 +1151,9 @@ static ssize_t fuse_perform_write(struct kiocb *iocb,
 		if (IS_ERR(req)) {
 			err = PTR_ERR(req);
 			break;
+		} else {
+			req->in.h.uid = file->f_cred->uid.val;
+			req->in.h.gid = file->f_cred->gid.val;
 		}
 
 		count = fuse_fill_write_pages(req, mapping, ii, pos);
-- 
2.7.4

