Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4072185B1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGHLMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgGHLMO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:14 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A7C08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a6so3748046wmm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wW7i379j65GNEXl3sU/RlLG0qLaHJvRj9OVSBvvQeeU=;
        b=X1Au66ABqmpUohFrlSKCmUWwcalFZz4pmEbXM3nRhW3QpfUQYkpdqU0NIP/R8iQ1UA
         eY/9JYWYqriWn+Xjdiyz1g+yLh3wfj0uoBJVOngcLf5PsI9GVvqTaIgV6YKj8Kr3zFi1
         OsZlvcqdX2K3gKVQ3sRAqrGQ3cwjcTMnl8ByPiO/IrDV/RiVUd0u0i14SiMj67Xhg7aP
         ixx/ZekwLBdYwekleUt0XniX14/JEZbngBlzC/jtyXFCM3yuVoVG+wh44Sys5DS7s2fz
         ubZesDXjo58lj5O9M/BBBj1WeQDdErdyaw70S4Fl37jTM+GVrRYzlSs7QZOEPn1lSlfh
         kVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wW7i379j65GNEXl3sU/RlLG0qLaHJvRj9OVSBvvQeeU=;
        b=KyOkLlnq9mqRbn1X0h8HqgTLAdZaAQkJMMPB6+NyXpTX1ZUO7Bx280AcaTTivICdRN
         wRKURB40Mf4CujvoibiRLo/8Y4S+hvg4xjWXA77vxzk/3PSs3PeMA64IbpmFLA7MJT8W
         g/riwvX+AElgQwOsWNF7qHwbrRA6M5Qtm2m8nTLWApk472UgizQHAutsEUcI0IZlRmps
         iwFT58Kj0rHwVAd3zARb2w1FWKJuYD1tGX7cN+d5gTUIs9jsoOEkrUaeJPJLUNgnrjCv
         8CbBSQjyAYlx/F5gSnf86fxzrU4NJ07sR11XXS9uc4GjbVIP95XTv6hZRKJxmWrN64S9
         BDHg==
X-Gm-Message-State: AOAM532xfVrevkahCkTfD0g+dKlEPUXH5NDr9FZHJYsCNlJuc4ohvZ8x
        xLGXtn/k8i589y90LzywUTlJERF1
X-Google-Smtp-Source: ABdhPJy0Bxg63fVMYZgZho6dI36/5Zwr8JOzU9nRg5lVqozfDPSXQzjO1dmD4qZeDo0kSFGRtIZHpQ==
X-Received: by 2002:a1c:48:: with SMTP id 69mr9186376wma.32.1594206732455;
        Wed, 08 Jul 2020 04:12:12 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 05/20] kernfs: do not call fsnotify() with name without a parent
Date:   Wed,  8 Jul 2020 14:11:40 +0300
Message-Id: <20200708111156.24659-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When creating an FS_MODIFY event on inode itself (not on parent)
the file_name argument should be NULL.

The change to send a non NULL name to inode itself was done on purpuse
as part of another commit, as Tejun writes: "...While at it, supply the
target file name to fsnotify() from kernfs_node->name.".

But this is wrong practice and inconsistent with inotify behavior when
watching a single file.  When a child is being watched (as opposed to the
parent directory) the inotify event should contain the watch descriptor,
but not the file name.

Fixes: df6a58c5c5aa ("kernfs: don't depend on d_find_any_alias()...")
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/kernfs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 06b342d8462b..e23b3f62483c 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -912,7 +912,7 @@ static void kernfs_notify_workfn(struct work_struct *work)
 		}
 
 		fsnotify(inode, FS_MODIFY, inode, FSNOTIFY_EVENT_INODE,
-			 &name, 0);
+			 NULL, 0);
 		iput(inode);
 	}
 
-- 
2.17.1

