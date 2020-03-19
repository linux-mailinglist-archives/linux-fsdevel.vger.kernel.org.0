Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFACF18BAA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 16:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCSPKv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 11:10:51 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40703 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgCSPKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:10:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id z12so2701425wmf.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2020 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Hw92EfxggEG70B0nQ2O8fMdQ77GBcOxSMBBaeFGaR3U=;
        b=VfKegURAKhBPON3k6ppAWK2c/4HFcTXNj1KpG8jzF5s24KNUQI6YfJVKU/U0pcRnRh
         S+WjnUYsSvmI5YGgz3tWsY7va4zPoltoKV8XKEhtscHzL0kK81QTU0E/IuxsCh5+fbqz
         mW/1pAGcUFEMikzY2oyjJdegdS/g+JHS4pDjUWrdEErzDi+NOIArhEfK7WODp2A6s0A7
         hT0aLuN0aCaj3wl5wKra4Do2TRSWgC7oBo51HK72NsHDkx/zezIk1PTMk4Eb2hEk3EC4
         t1w9zPmZrHREmPvnot/zfphDEB7IqlvKviAMea5vXbkxR0bKNwYvXPwGU/H9qfAtCCLy
         r2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Hw92EfxggEG70B0nQ2O8fMdQ77GBcOxSMBBaeFGaR3U=;
        b=ptbPgOLyDnA8vQ0HLJ47jhtia9zTpIZ89HdfrUsP0veheB3IyerOmSHyklb3nbp7Ah
         zvTuoNO/8ZS/PbR1GkK2kiIasAghoH2kETe8qq5ZpOiOx4JB/NusEkQpMyAekoGsBGyx
         ttnDSDIG7P8zJAFIeBsFGT2X9wMV9+DI/tXUl0JQZ7GVT6w1tXJ3FfoB2p7cjMpBt81Z
         pat9/eiq55iDVzq6La5+x5TlpIqqpUaJycIo76xcXLqYF4cHlwUpyBGoj9bbaDbvsaZA
         gJ+yv0f7Wb9XSOCgIzRjusnmpqmfzDT0nYnTj3AkLUyZYLxAa1V+T5CJTiXgaRGqB3pi
         Z2fg==
X-Gm-Message-State: ANhLgQ3EkMYW+Av6PJRMdgwpmaC1/qxMMyjunfcaJ1v1zRl11n/v1iWo
        X9G5khP6sbIBhMBxn6xn/Hs=
X-Google-Smtp-Source: ADFU+vvumBuursYBzo/Upn3RUiec2Fxxj/0PxwGEw2nKFnqSZ+rf9XdqJnrNJuDicxWgG6vyGKZaeA==
X-Received: by 2002:a1c:68d5:: with SMTP id d204mr4253905wmc.15.1584630649123;
        Thu, 19 Mar 2020 08:10:49 -0700 (PDT)
Received: from localhost.localdomain ([141.226.9.174])
        by smtp.gmail.com with ESMTPSA id t193sm3716959wmt.14.2020.03.19.08.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 08:10:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 08/14] fanotify: merge duplicate events on parent and child
Date:   Thu, 19 Mar 2020 17:10:16 +0200
Message-Id: <20200319151022.31456-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200319151022.31456-1-amir73il@gmail.com>
References: <20200319151022.31456-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

With inotify, when a watch is set on a directory and on its child, an
event on the child is reported twice, once with wd of the parent watch
and once with wd of the child watch without the filename.

With fanotify, when a watch is set on a directory and on its child, an
event on the child is reported twice, but it has the exact same
information - either an open file descriptor of the child or an encoded
fid of the child.

The reason that the two identical events are not merged is because the
object id used for merging events in the queue is the child inode in one
event and parent inode in the other.

For events with path or dentry data, use the victim inode instead of the
watched inode as the object id for event merging, so that the event
reported on parent will be merged with the event reported on the child.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6a202aaf941f..97d34b958761 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -312,7 +312,12 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	if (!event)
 		goto out;
 init: __maybe_unused
-	fsnotify_init_event(&event->fse, (unsigned long)inode);
+	/*
+	 * Use the victim inode instead of the watching inode as the id for
+	 * event queue, so event reported on parent is merged with event
+	 * reported on child when both directory and child watches exist.
+	 */
+	fsnotify_init_event(&event->fse, (unsigned long)id);
 	event->mask = mask;
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
 		event->pid = get_pid(task_pid(current));
-- 
2.17.1

