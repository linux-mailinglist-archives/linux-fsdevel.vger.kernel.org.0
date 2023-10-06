Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B967BBF35
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjJFSym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbjJFSyf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3892A100
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jjx9VgV/7dT4tZbJ3E3mhAPuVCjLtjMTEsq27X+yTiE=;
        b=A06UEsTVtrcx4DP9FdgqI+qTrJvEU9gLnKl9i/QznxguQMF1F+D6yqMCe+tXMR/9IoUpPf
        c32TV0uagewR+GQcufAehbrSHz+O0xckfHtjfcWyXY+2rGJrgdW5xoVWk/DQmPFyrD2tzI
        m9jmrx9qL8r/aUZDzlx+nCyZVOhZ7Z8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-EobzyEGYPVmJNJIK0llPMQ-1; Fri, 06 Oct 2023 14:52:33 -0400
X-MC-Unique: EobzyEGYPVmJNJIK0llPMQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b2c1159b0aso206681566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618352; x=1697223152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jjx9VgV/7dT4tZbJ3E3mhAPuVCjLtjMTEsq27X+yTiE=;
        b=jrQnBRK5k6gcxfMIM6slPCCjGzKXDOu/PozYlUGeidMKlUVlIjbp6qzqVJHXMOjn6q
         yxN6GhEkYGnEtC68yN61ABhU+7ggSTbM9gcpaIBGNp7TtoW1fvrZb+crIh4OSiQcCENA
         FQuIDYHlworhu/j5aRMbwm6wWdjixSjxeRXJICQSiDJubi+66gl4pPBECiP3gk0wGxQC
         s1q2lypsrbvHc1NgH3VAtICpyOMJ4sMthk5Pto/gLRHvTYCUhabeP3zOOz+E/5EwEh5E
         Kk6ozfkPTkDW8V+xnREdPkZCy20E9r/5g6CmHckngM2ZFLpOcwKRRW8IVyEhxJrsVGrF
         otDA==
X-Gm-Message-State: AOJu0Yx8vX4q2lrj3wEA7WduREAqVd2cp/8B5l+AJlQO7c3wNi033V3R
        CzQ+uAwO+415Kn0nzcio0h2ngLC8vangZ3RkDKuYkq6HMItfVAC/C9exxx8BOO8N1iwFRihMp+D
        Cqg34ynqL0hGqOBcF6xtNoHRr
X-Received: by 2002:a17:906:3116:b0:9a9:e4ba:2da7 with SMTP id 22-20020a170906311600b009a9e4ba2da7mr8028345ejx.49.1696618352610;
        Fri, 06 Oct 2023 11:52:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDPDtaO2TAQS7SQHAc7X+kA+HXfojdJw5ChBvvTI1/xFzblcVVwt2Q3wqp9BD4yXfaMCDGqw==
X-Received: by 2002:a17:906:3116:b0:9a9:e4ba:2da7 with SMTP id 22-20020a170906311600b009a9e4ba2da7mr8028334ejx.49.1696618352414;
        Fri, 06 Oct 2023 11:52:32 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:32 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 15/28] xfs: introduce workqueue for post read IO work
Date:   Fri,  6 Oct 2023 20:49:09 +0200
Message-Id: <20231006184922.252188-16-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As noted by Dave there are two problems with using fs-verity's
workqueue in XFS:

1. High priority workqueues are used within XFS to ensure that data
   IO completion cannot stall processing of journal IO completions.
   Hence using a WQ_HIGHPRI workqueue directly in the user data IO
   path is a potential filesystem livelock/deadlock vector.

2. The fsverity workqueue is global - it creates a cross-filesystem
   contention point.

This patch adds per-filesystem, per-cpu workqueue for fsverity
work.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_mount.h | 1 +
 fs/xfs/xfs_super.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index d19cca099bc3..3d77844b255e 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -109,6 +109,7 @@ typedef struct xfs_mount {
 	struct xfs_mru_cache	*m_filestream;  /* per-mount filestream data */
 	struct workqueue_struct *m_buf_workqueue;
 	struct workqueue_struct	*m_unwritten_workqueue;
+	struct workqueue_struct	*m_postread_workqueue;
 	struct workqueue_struct	*m_reclaim_workqueue;
 	struct workqueue_struct	*m_sync_workqueue;
 	struct workqueue_struct *m_blockgc_wq;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..5e1ec5978176 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -554,6 +554,12 @@ xfs_init_mount_workqueues(
 	if (!mp->m_unwritten_workqueue)
 		goto out_destroy_buf;
 
+	mp->m_postread_workqueue = alloc_workqueue("xfs-pread/%s",
+			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
+			0, mp->m_super->s_id);
+	if (!mp->m_postread_workqueue)
+		goto out_destroy_postread;
+
 	mp->m_reclaim_workqueue = alloc_workqueue("xfs-reclaim/%s",
 			XFS_WQFLAGS(WQ_FREEZABLE | WQ_MEM_RECLAIM),
 			0, mp->m_super->s_id);
@@ -587,6 +593,8 @@ xfs_init_mount_workqueues(
 	destroy_workqueue(mp->m_reclaim_workqueue);
 out_destroy_unwritten:
 	destroy_workqueue(mp->m_unwritten_workqueue);
+out_destroy_postread:
+	destroy_workqueue(mp->m_postread_workqueue);
 out_destroy_buf:
 	destroy_workqueue(mp->m_buf_workqueue);
 out:
@@ -602,6 +610,7 @@ xfs_destroy_mount_workqueues(
 	destroy_workqueue(mp->m_inodegc_wq);
 	destroy_workqueue(mp->m_reclaim_workqueue);
 	destroy_workqueue(mp->m_unwritten_workqueue);
+	destroy_workqueue(mp->m_postread_workqueue);
 	destroy_workqueue(mp->m_buf_workqueue);
 }
 
-- 
2.40.1

