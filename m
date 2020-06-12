Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85D61F7609
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgFLJeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgFLJeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65130C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:09 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y13so9455221eju.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+1FfbhSGpx28ZH/By0VG04RLX5syo3D4ukuXN4TbR4E=;
        b=qwXMzNvYWAkPdr8QCTBB0OYJBNLsMhKPqnz1lwn34rTFmzyrNKsv3AHHcgpE+5P1HL
         yDb2d+P7LfTBWWRuTloilR48luLRKY/W2tHrDK+YikJvdXptLmLRfXO5I0wE8IqidyAo
         wbgrqUPygo+6+wme5nBC+hujwvYTBu8shD2G+LnKZX+Y4CfEgq8Rf+JXpO0WgXV8uykZ
         w09tIo5aZ+UQh/LaDVqws/jkdl5/ViUNlChF1514MYQjdmGCNLKvOiRmkU8PJpgh69qq
         h8EznWzEshN5+6DgWrpsWPXboRk91q2Alshj1U83ERIOSM6Opzln/sqkgbdZCGUcvnn+
         tapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+1FfbhSGpx28ZH/By0VG04RLX5syo3D4ukuXN4TbR4E=;
        b=MS8xYawtNXlX17C5oKtdFE4By7R9XqmZon4uAWtbRnDjafU9ZBt58gj8fOdPGMVuB3
         sxzWR4NEbwU0g6fQotyk0x48O4n7DjSNQBcsRrKUAAiUcM4TGJ4YlsYuTCtLuRZ164Id
         48WLNH0nDDICp/GwXHeJeBRRzIdGen+Zk+lL1aenGVAkpEJh/yINPDswrmpr6YYUx4bM
         AxGIGZhAX/hyVSvpEjIXApL10KDQb/M9Q2idb08CIXOXX1aZnoZ03EiSKKPdCQBB4OKi
         GDeUNzzwM/AKBlJ6yujEFBzQgby+TeTYZuLHMk9vgmMctLChUSVVMFUHM7OKaJHkjEyA
         QINA==
X-Gm-Message-State: AOAM530TqRmD4odI4WvYK7yPtJblepbcJGgQP+YM6MeZB7JGixJoAlA+
        nFxk3kh3/VMoKzvJF9Q16KvBg+6F
X-Google-Smtp-Source: ABdhPJzeIoztiu1qWAI76ixkLrr5NgrnNYz+czKuiRDBAUHGJ7LhV69IcVMJ+AHzXJbAG0JODBuY9A==
X-Received: by 2002:a17:906:784c:: with SMTP id p12mr12238398ejm.123.1591954448185;
        Fri, 12 Jun 2020 02:34:08 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:07 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/20] kernfs: do not call fsnotify() with name without a parent
Date:   Fri, 12 Jun 2020 12:33:28 +0300
Message-Id: <20200612093343.5669-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

