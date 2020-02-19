Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A8E163BCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 05:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgBSEEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Feb 2020 23:04:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44244 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726464AbgBSEEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Feb 2020 23:04:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id j23so2460635qtr.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Feb 2020 20:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP2MqxukizBRlPC9SfvqBAcpKQDQ39+MBV8Jn9d7IdU=;
        b=knLDS9RoP4max5hfagxZux9hUSAX4uFXfIJOs4Pl2iD9XJS0gDytXhY535GWwyXKmN
         GJGwl+8ma/bF3nRhUMOQSPTgsNO/7vN7ewM5h8CkBZnCKRxP101mDXAPZcn6FYdj448X
         0inKFN/p2mRk2G19n6AB6ukXJyEI6j0DXLgym23pawd/vSoFtufYh7mTtUO6o+y/vjw2
         e1USu3q3AkJyEWBUdYnDTdoEEfoz03ddfy9+SkuecdjATdIvFhRcOs1uXasqBzGjRHMR
         vJ1UwDMKKfS0aJHfclnzQaWPADxOLlMObvWb9NCenfbbY11xlpkRGRjdmJZ2WfSEOgkl
         6KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP2MqxukizBRlPC9SfvqBAcpKQDQ39+MBV8Jn9d7IdU=;
        b=H9Lpmb7WpDHO2knZYyz+ihvg3MEJ79V80uKc2cJU3D7imbQJ4bq+uwryOsKmfIX3l5
         9jQEuI5YTp0JACm+5NORVKiUOqsZ+y7/vz+7ON0xMmxOv31o6WyPsJVKmwutdJDyjq1V
         qn5faqdk7e/j7pTgv3ew2MjYlYoPix5rfJbH5EdUPKutzCMWa7fu9CiQoNM8zS+CPil6
         64uIdazc4iF/g13luyFQOlHvPJZ1qqYJ3FCQ1NtDCqRWuEPCkjkxcyH8k+hJb2TuugPn
         MxkDM2I9sa7FH7coWno8Dtbmc60xb7RhiyHOaNFoApr133MPkFAtrth9fBQtCi4fe2v9
         RlDg==
X-Gm-Message-State: APjAAAVJZCeJq9OOkB6XCQA9DmJg6Psp9h/eYc8Imig9PWWRhUHblKt6
        jWrEVBPtokZ2NKTfeGZ/T0EcVw==
X-Google-Smtp-Source: APXvYqyuVmcb2uQ0JQaLq7Vd7ocdcNzzYrdnVg8V+sqphizIq6oakYuSZVaek3e4KcMnvWva5NaWNA==
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr19970707qtj.158.1582085086153;
        Tue, 18 Feb 2020 20:04:46 -0800 (PST)
Received: from ovpn-121-44.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r6sm323671qtm.63.2020.02.18.20.04.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 20:04:45 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     viro@zeniv.linux.org.uk
Cc:     hch@infradead.org, darrick.wong@oracle.com, elver@google.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] fs: fix a data race in i_size_write/i_size_read
Date:   Tue, 18 Feb 2020 23:04:26 -0500
Message-Id: <20200219040426.1140-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inode::i_size could be accessed concurently as noticed by KCSAN,

 BUG: KCSAN: data-race in iomap_do_writepage / iomap_write_end

 write to 0xffff8bf68fc0cac0 of 8 bytes by task 7484 on cpu 71:
  iomap_write_end+0xea/0x530
  i_size_write at include/linux/fs.h:888
  (inlined by) iomap_write_end at fs/iomap/buffered-io.c:782
  iomap_write_actor+0x132/0x200
  iomap_apply+0x245/0x8a5
  iomap_file_buffered_write+0xbd/0xf0
  xfs_file_buffered_aio_write+0x1c2/0x790 [xfs]
  xfs_file_write_iter+0x232/0x2d0 [xfs]
  new_sync_write+0x29c/0x3b0
  __vfs_write+0x92/0xa0
  vfs_write+0x103/0x260
  ksys_write+0x9d/0x130
  __x64_sys_write+0x4c/0x60
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffff8bf68fc0cac0 of 8 bytes by task 5901 on cpu 70:
  iomap_do_writepage+0xf4/0x450
  i_size_read at include/linux/fs.h:866
  (inlined by) iomap_do_writepage at fs/iomap/buffered-io.c:1558
  write_cache_pages+0x523/0xb20
  iomap_writepages+0x47/0x80
  xfs_vm_writepages+0xc7/0x100 [xfs]
  do_writepages+0x5e/0x130
  __writeback_single_inode+0xd5/0xb20
  writeback_sb_inodes+0x429/0x910
  __writeback_inodes_wb+0xc4/0x150
  wb_writeback+0x47b/0x830
  wb_workfn+0x688/0x930
  process_one_work+0x54f/0xb90
  worker_thread+0x80/0x5f0
  kthread+0x1cd/0x1f0
  ret_from_fork+0x27/0x50

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 70 PID: 5901 Comm: kworker/u257:2 Tainted: G             L    5.6.0-rc2-next-20200218+ #2
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
 Workqueue: writeback wb_workfn (flush-254:0)

The write is protected by exclusive inode::i_rwsem (in
xfs_file_buffered_aio_write()) but the read is not. A shattered value
could introduce a logic bug. Fixed it using a pair of WRITE/READ_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3cd4fe6b845e..25f98da90cf3 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -863,7 +863,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 	preempt_enable();
 	return i_size;
 #else
-	return inode->i_size;
+	return READ_ONCE(inode->i_size);
 #endif
 }
 
@@ -885,7 +885,7 @@ static inline void i_size_write(struct inode *inode, loff_t i_size)
 	inode->i_size = i_size;
 	preempt_enable();
 #else
-	inode->i_size = i_size;
+	WRITE_ONCE(inode->i_size, i_size);
 #endif
 }
 
-- 
2.21.0 (Apple Git-122.2)

