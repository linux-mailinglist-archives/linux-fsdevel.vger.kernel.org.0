Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51C5220360
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfEPK1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32826 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfEPK1D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id d9so2809841wrx.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FwPQy0s/vjrkcLjVIUF8opKYwDegn02HiNSftLAbhlc=;
        b=rvZPpXM5s90ZCj5aclCMnAkn+zA0uiyEOixfG006T69B8iJzzQVF3VEKXQ0iJqKi5R
         um5TM8zRhaxsO40nUa3DG0rwIrA2PYfb8z3VKFTycnOfAJ7KU08yeu2wWfRVJLa+JYkS
         wa2Uxv6jThU/SRd4ggGnyaJe/cZ/IAdhmsUejP5zrWTxo1FT6iNGyRCJ5Z/giUHWQ8gt
         OET+VyoPHMw0VmoL5SG5eJJDtovvLGrVKwxRjwypUiDwt+VR7C559Af+OmFxWd4B/P6h
         MQxmx0w+PoR0VcnyFQu80VmA39fgK4vnlC7WqFypd56t5EsTgQEHA8N/fw+YK+Q7GoSX
         A4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FwPQy0s/vjrkcLjVIUF8opKYwDegn02HiNSftLAbhlc=;
        b=T9AGxkfrwbE4z1mepR7BicPuW7vK4JY+CLs/uxxRJOkhCPHpqQb1Tp3we0qagzWJzl
         6aVMCCkid8YAtvfXtQr3LEm2ZBGAcEld1fRtkIFv6b42w8r8DDlmJyQcrj+l4M98IEh+
         jJKnbWbe9EPvc1Q/dOpWTMsufyYLCgngRMG6tJFKwMQlSz1Ljp2wm9iIlu7eCOWHy2eZ
         r+rd+IGjGoCKHEVPmhFpws3wCQYwFITSCLgdIknmorrsA5jlfe25KvLpMIndLGmkjtNT
         OUwelWvBjkcrKyZLsGiAtjNkPO1xzUUAhq9nwOZUKzBAcFFmxaerJRIgDpBp96phKfM6
         47IQ==
X-Gm-Message-State: APjAAAXzyGMvspt7vBxnybGduISZHcW30gor8Ay84BvX0D3uDWNppNTL
        E7h2yD7hDF1OVLFpDvxLvisZRdGD
X-Google-Smtp-Source: APXvYqz2ebFQWv2JC9gRyJuqZ/g4oFldiMpUaoQe6Z0H14PFik47XsfNU0rk4sUz2PPxFzeA/txwug==
X-Received: by 2002:a5d:4d51:: with SMTP id a17mr29368254wru.260.1558002422563;
        Thu, 16 May 2019 03:27:02 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:01 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 07/14] fs: convert tracefs to use simple_remove() helper
Date:   Thu, 16 May 2019 13:26:34 +0300
Message-Id: <20190516102641.6574-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/tracefs/inode.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 7098c49f3693..6ac31ea9ad5d 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -501,25 +501,10 @@ __init struct dentry *tracefs_create_instance_dir(const char *name,
 
 static int __tracefs_remove(struct dentry *dentry, struct dentry *parent)
 {
-	int ret = 0;
-
-	if (simple_positive(dentry)) {
-		if (dentry->d_inode) {
-			dget(dentry);
-			switch (dentry->d_inode->i_mode & S_IFMT) {
-			case S_IFDIR:
-				ret = simple_rmdir(parent->d_inode, dentry);
-				break;
-			default:
-				simple_unlink(parent->d_inode, dentry);
-				break;
-			}
-			if (!ret)
-				d_delete(dentry);
-			dput(dentry);
-		}
-	}
-	return ret;
+	if (simple_positive(dentry))
+		return simple_remove(d_inode(parent), dentry);
+
+	return 0;
 }
 
 /**
-- 
2.17.1

