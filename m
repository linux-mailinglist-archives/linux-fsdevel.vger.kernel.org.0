Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEE720364
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfEPK1J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:09 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39068 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfEPK1J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id n25so2526193wmk.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k2nXCJMpePJI+ALTBh04qK+bh4SwR5zHDxDAb4kBoHQ=;
        b=kHpLGlS+eFAAjajP7Uy9jlIn64KnhU4BAcHyAxj5EAdDtpeE0Rw9BOVXFN4yFh4s3H
         EAYTB5v+0Rndg4JLfkYAlLCyRrj1oxwlegXc7AGzsmglNmMztqxs0Rt8M/TR3tEeJfNN
         qppZn44x30Z83jcC33UmWmkmIud4g8UIhYkB2NOdYpR0Az3zn+Zja7zeUTsZcbBBmYsl
         sAwwsB2vWBy545WGe/P/nNT4SBoLZUI76OTgcwz21rCg3tLsYJ/xGkDgrtuLe7oOmSyb
         UBTaJv0uidtL6Q5hdjFZ5+YUW/Z41F2QWMq7FuX93/BghllKsECJo/Hn5xdC680yqVJO
         AXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k2nXCJMpePJI+ALTBh04qK+bh4SwR5zHDxDAb4kBoHQ=;
        b=rPB4ywkVXwdqBvnTcSlH7fJE0vcV2pRCQeoewTcoHRY3ImVKN3gCgi+gXo0CfXd7qw
         +R+kZUcKXPL71PS2cVVcY5SVT+dPppUkOaMldVVVUwZbYF451Q+8WElxeRT264OL8Uzf
         tPAKhrN2L9Eo2MGXZuDKUT+ccNZ+KenzRkyocDsJtlBHb2QWXbNOKGCHmtg4zfs1407z
         /CTKIZ0gPaTJ7l1mw5h5AaS3gC4GEhnLyv8jxJ5yOz10+o6yVc14/ij6aGM+ln0HtHI1
         IyNs8a7ayi19GqYBbEe9qzNuSpZMGHWsnvwexDUdmZ4d90GvZZwknc4LxUPvyCjfTQkh
         hclA==
X-Gm-Message-State: APjAAAU6A8BTijn8EQvJQms4RIIzM8nVxBJuE2plCt/1UJ2VkHVWUst+
        vEbjWknfSuvAR+L6hdJF6X4=
X-Google-Smtp-Source: APXvYqyDsLNUCwJ/aNjwBcX6PJIkHMTADuPLI0smlwt5HIKoMfM+dOeDRvljISyUtEC1PkYGWBAySg==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr14471585wmc.44.1558002427981;
        Thu, 16 May 2019 03:27:07 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org, Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 11/14] fsnotify: call fsnotify_rmdir() hook from configfs
Date:   Thu, 16 May 2019 13:26:38 +0300
Message-Id: <20190516102641.6574-12-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will allow generating fsnotify delete events after the
fsnotify_nameremove() hook is removed from d_delete().

Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/configfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 591e82ba443c..2356008029f7 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -27,6 +27,7 @@
 #undef DEBUG
 
 #include <linux/fs.h>
+#include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -1797,6 +1798,7 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_rmdir(d_inode(parent), dentry);
 	d_delete(dentry);
 	inode_unlock(d_inode(parent));
 
@@ -1925,6 +1927,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	fsnotify_rmdir(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
 	d_delete(dentry);
-- 
2.17.1

