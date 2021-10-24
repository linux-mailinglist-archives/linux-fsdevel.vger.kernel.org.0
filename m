Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0D438907
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Oct 2021 15:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhJXN2q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Oct 2021 09:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhJXN2q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Oct 2021 09:28:46 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2EC061764
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Oct 2021 06:26:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id d13so5024004wrf.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Oct 2021 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfSmQPTqOxoIZlSKekAsFe/BR1K85v7nZmrfNBoimgY=;
        b=QXnDa7+FeH2hYc1Rs3MLBDk11LG/vcNLqxEq8Jh7Tf5dKcmuf5qM/Tpo1ewTT7UfPs
         L/uNynvJjmtAe+v5UIMJOEOsnQWyuyrF4xAO6qO8JgO6JlqEkAO4f1y1NUCiovTleteR
         NW4VtretAwjY0EFeD6Ases/79U9GogMs9ZfPSRfDVcCsuQwiu0gJgo2Om7X+WRNrDdLd
         GR1FPp2VnMpkzUjzZuxdC1uFlkCPiXJsIMHM3FtYShfUxwAlroPDo+AMr/+dfIlpy0Ru
         Yx71MsDBsPfb4lx5I8Ldl8jr+S02spGyFRGOC2jdB1M3sjH06bTKNIoZMlhoVcalfvlW
         o4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xfSmQPTqOxoIZlSKekAsFe/BR1K85v7nZmrfNBoimgY=;
        b=S/0RjHpp3V/p9rawvQLwJrt0v8A9soXG22O9IsfMpt6DzxvWQVCatpT6rWv4Ow/s3u
         HBj/kwF01YahUscamuVmvacjMZh1xXmT/GThLSpkdoN/Zc/UX5leuEkm2+tAcT6DV+d1
         0dNQWb5fagWwYdo/a+aiGtMmCbPHAEGlTUmmI5O2V/ORlb9sAO1IFcUm0040j1mF5H0h
         uGP8FEnBitDxc6ValRTVF/Bm4ePNQYAee7gU41PNA8DWWb2+zdyAdIBfkY5uz+qzGunM
         jpGUCl0EglVUa5RCF+8WDIkCgo/VnwkoPgsSmUUwmmymckh9hR4oHQN53qOP3+rg0Tu0
         xC4A==
X-Gm-Message-State: AOAM531ekyxenbwtYBbSrx5LpyifNkug2N9LGfE4xzGXD4/sYdeHV93w
        ZdHN1IiL5yBLzExT4u0h2r7LB3M4oCk=
X-Google-Smtp-Source: ABdhPJwTHr2ISFF++diGCZz15HDZy7qZBpbvlUZMpmlPO5Fikl5WP8B6qSnws4jkbnDIrY411KA8Ow==
X-Received: by 2002:a05:6000:552:: with SMTP id b18mr16068421wrf.112.1635081983653;
        Sun, 24 Oct 2021 06:26:23 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id m2sm5125449wrb.58.2021.10.24.06.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 06:26:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH] fuse: add FOPEN_NOFLUSH
Date:   Sun, 24 Oct 2021 16:26:07 +0300
Message-Id: <20211024132607.1636952-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add flag returned by OPENDIR request to avoid flushing data cache
on close.

Different filesystems implement ->flush() is different ways:
- Most disk filesystems do not implement ->flush() at all
- Some network filesystem (e.g. nfs) flush local write cache of
  FMODE_WRITE file and send a "flush" command to server
- Some network filesystem (e.g. cifs) flush local write cache of
  FMODE_WRITE file without sending an additional command to server

FUSE flushes local write cache of ANY file, even non FMODE_WRITE
and sends a "flush" command to server (if server implements it).

The FUSE implementation of ->flush() seems over agressive and
arbitrary and does not make a lot of sense when writeback caching is
disabled.

Instead of deciding on another arbitrary implementation that makes
sense, leave the choice of per-file flush behavior in the hands of
the server.

Link: https://lore.kernel.org/linux-fsdevel/CAJfpegspE8e6aKd47uZtSYX8Y-1e1FWS0VL0DH2Skb9gQP5RJQ@mail.gmail.com/
Suggested-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Miklos,

I've tested this manually by watching --debug-fuse prints
with and without --nocache option to passthrough_hp.

The libfuse+passthrough_hp patch is at:
https://github.com/amir73il/libfuse/commits/fopen_noflush

Thanks,
Amir.

 fs/fuse/file.c            | 3 +++
 include/uapi/linux/fuse.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 11404f8c21c7..6f502a76f9ac 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -483,6 +483,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
+	if (ff->open_flags & FOPEN_NOFLUSH)
+		return 0;
+
 	err = write_inode_now(inode, 1);
 	if (err)
 		return err;
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 36ed092227fa..383781d1878f 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -184,6 +184,7 @@
  *
  *  7.34
  *  - add FUSE_SYNCFS
+ *  - add FOPEN_NOFLUSH
  */
 
 #ifndef _LINUX_FUSE_H
@@ -290,12 +291,14 @@ struct fuse_file_lock {
  * FOPEN_NONSEEKABLE: the file is not seekable
  * FOPEN_CACHE_DIR: allow caching this directory
  * FOPEN_STREAM: the file is stream-like (no file position at all)
+ * FOPEN_NOFLUSH: don't flush data cache on every close
  */
 #define FOPEN_DIRECT_IO		(1 << 0)
 #define FOPEN_KEEP_CACHE	(1 << 1)
 #define FOPEN_NONSEEKABLE	(1 << 2)
 #define FOPEN_CACHE_DIR		(1 << 3)
 #define FOPEN_STREAM		(1 << 4)
+#define FOPEN_NOFLUSH		(1 << 5)
 
 /**
  * INIT request/reply flags
-- 
2.25.1

