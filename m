Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA86401B49
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Sep 2021 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242054AbhIFMhv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Sep 2021 08:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236783AbhIFMhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Sep 2021 08:37:51 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFCEC061575
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Sep 2021 05:36:46 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id a21so5437396vsp.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Sep 2021 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TbWrj3QNej/qZF2lL5yaCFxTztlbSz072qzpuy8iCzY=;
        b=GmWjtNXUK3BiTqj4naAI8P+eVi9I8Og8ScSSDN2ajUZzd8c3gsYJuQkoWo9V3EHc2B
         8fNvzJFtYQPjmwDZbRqywmCwB/PHO9Neq1fWIdq/ey2Ulawrr4z0mi8F7oLVeh3fOq14
         CPYPr0JqmjmYmXZ2H/AQSoIhAuDxxDLEKYvdDQucPJbqGQb1KVl6gaRDo6cQr4JhBmDV
         05pBvSAaYrvyDjYFxW97TqxVJhgIvG0XSVhluNB3R3PelSVx4Hg0BWRTkB1xvTFX0zOO
         wZWGUqqOYv5BJiNRIsdLGpKth7ZV7vD0unpca5PZKasnZ91W/UX7JMihdTEUSdO6Mkom
         sQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TbWrj3QNej/qZF2lL5yaCFxTztlbSz072qzpuy8iCzY=;
        b=G6VZJEnN8witOvmJs2wvuW2shGODCFz5nII4MZ1KXoWBkXFxLuf9ZYP1QJ4AQ+/BXZ
         eGEI62XKWavQbsUMqIfilxp0t2h9dzTJP0iMcMHOzBI4ZHbUXLuYqVSP7oSYuuWa1CLm
         okck16OMw/ywHuu3BcYHi1YxrHzqsAA6ZUQOY1AHHGfHl486VCKFQ4n382S18FNtaAs9
         vPX4TjF9B+xcmhTeIh13OB9O1www5iatCLSRnRrfaL8RDsB2ErEiWcFFbk3nD+8c121g
         W5mUaa0zI/Re7zbv8WQuUT0lTU2axqD6BTeJJs/pwtTyzG13EBrkH9ZYRrpEct25f7rL
         mPsA==
X-Gm-Message-State: AOAM530Cb+XPRTinVeVmBV5rbCgZsIHXMeN+WhpdNuZLxr6fWMoIOAX1
        v17ULH4UHp/366CamARCtTiUW0CELJUJNAmhSVazoInaStHVgw==
X-Google-Smtp-Source: ABdhPJw6mYDj4rPzNc2BJDX5jSsYVakrM5fcL9065W/K9vunoB53HFkF1xjrUl5X2a5BORe+NdW7yvfqF29F9mstrjI=
X-Received: by 2002:a67:a24f:: with SMTP id t15mr5756165vsh.25.1630931805908;
 Mon, 06 Sep 2021 05:36:45 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Mon, 6 Sep 2021 20:36:18 +0800
Message-ID: <CAPm50a+j8UL9g3UwpRsye5e+a=M0Hy7Tf1FdfwOrUUBWMyosNg@mail.gmail.com>
Subject: [PATCH] fuse: add a dev ioctl for recovery
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For a simple read-only file system, as long as the connection
is not broken, the recovery of the user-mode read-only file
system can be realized by putting the request of the processing
list back into the pending list.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/dev.c             | 38 +++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/fuse.h |  1 +
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 491c092d427b..8e1b69a5b503 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2239,7 +2239,7 @@ static int fuse_device_clone(struct fuse_conn
*fc, struct file *new)
 static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
                           unsigned long arg)
 {
-       int res;
+       int res = 0;
        int oldfd;
        struct fuse_dev *fud = NULL;

@@ -2268,6 +2268,42 @@ static long fuse_dev_ioctl(struct file *file,
unsigned int cmd,
                        }
                }
                break;
+
+       case FUSE_DEV_IOC_RECOVERY:
+       {
+               struct fuse_iqueue *fiq;
+               struct fuse_pqueue *fpq;
+               struct fuse_req *req, *next;
+               LIST_HEAD(recovery);
+               unsigned int i;
+
+               fud = fuse_get_dev(file);
+               fiq = &fud->fc->iq;
+               fpq = &fud->pq;
+
+               spin_lock(&fpq->lock);
+               list_for_each_entry_safe(req, next, &fpq->io, list) {
+                       spin_lock(&req->waitq.lock);
+                       clear_bit(FR_LOCKED, &req->flags);
+                       list_move(&req->list, &recovery);
+                       spin_unlock(&req->waitq.lock);
+               }
+               for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+                       list_splice_tail_init(&fpq->processing[i],
+                                             &recovery);
+               list_for_each_entry_safe(req, next, &recovery, list) {
+                       clear_bit(FR_SENT, &req->flags);
+               }
+               spin_unlock(&fpq->lock);
+
+               spin_lock(&fiq->lock);
+               list_for_each_entry_safe(req, next, &recovery, list) {
+                       set_bit(FR_PENDING, &req->flags);
+               }
+               list_splice(&recovery, &fiq->pending);
+               spin_unlock(&fiq->lock);
+               break;
+       }
        default:
                res = -ENOTTY;
                break;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..fc07324efa9d 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -923,6 +923,7 @@ struct fuse_notify_retrieve_in {
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC             229
 #define FUSE_DEV_IOC_CLONE             _IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_RECOVERY          _IOR(FUSE_DEV_IOC_MAGIC+1, 0, uint32_t)

 struct fuse_lseek_in {
        uint64_t        fh;
--
2.27.0
