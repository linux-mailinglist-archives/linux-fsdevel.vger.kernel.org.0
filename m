Return-Path: <linux-fsdevel+bounces-24948-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 982F2946D5C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 10:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41015B20D15
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Aug 2024 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2679119470;
	Sun,  4 Aug 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knYXW94Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4BA134AB
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Aug 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722758622; cv=none; b=ANvYukR2MezT/57iUNWL7loZgiEmjDQF/avrrKynIBaRkkhZL6AdbG87DHHpASv2Vpe0whs16bVGelxKyuPyChOk7i2By7rQ1CieCYNm35su0/XLHt0XKcgTmW43Gs3J3MfoXTsph//F3Afgw36erz2CPqAEDQ+CRN/KwbOPaNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722758622; c=relaxed/simple;
	bh=CqNNbW/EsBaUObUF2KnK4vcgcw9cffFJLSZewzDtJko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M1rgpQssK6ndVF0J5I6EiiYUrANSJnnWPEBXdFBE5aey0KQTlj99P9w/IVfNHtcdGsCoN4TFVr6llvla33dfr4dYvqQHp2GQRyfMe1uaYO2FK4q+dOUNu/Swpg4vX6JoCILY9/g80+iPvU9wySk9Ok0L6Cm6k9PEWu/wKNoh82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knYXW94Q; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso8218796b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 04 Aug 2024 01:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722758620; x=1723363420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl1rHoOZW4CfvQTCyDf7+3EuviFeFNZFpQCf74PII9c=;
        b=knYXW94QcCCp0SbXJc84taSSfSuFWZbdm649dCbfe316hBmAkb/8kMF99fcjVeny8M
         4W7ue5SgTqR4BYmfVp8S8p9NM8OzRYRBW0LpJUJUZYM9qPQkTcNb5TvnNZGtQkh+bky2
         oMEGuROtv510yXa1mUGmQ+9sTFdeBRmRTNjNa/XAfMsyri308UkxsAogbkfgm4TDvHgt
         z7ZgtoKa8fOqk621kHyV+mIJT5NzJEQuoZwmAiovQ+u5hVJt8CAPM80S+KJ8/uN3ZFsI
         yEb2EogBJycTLVf3O8YV0nzfP/bZlD/Uw/EvA7I3GPbQCAY+ZZoCwUrxdxjkGEwI7XHj
         omVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722758620; x=1723363420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl1rHoOZW4CfvQTCyDf7+3EuviFeFNZFpQCf74PII9c=;
        b=FUgloM1ygC5xBgPpiclyuZOIF3f4zmv+4XtToWUOFLzv+9djf90wyd7nbDX5HIH9k8
         XXx5GMfwKrz/ZIE6h/ags+GEDG6e0NEMTe7+xwekFwo4Vczrt/QlXBceSBPusuYf8bXg
         h4o+gSuanEhp03f7+wA0tC1mZxahw/lAUWsqPl7VoaXBUzJjEVejZgcizZyVcVFs/gkg
         wkCASKYTLs62X/g+KOr4/lPlNnq1wf6JGoudlOisJMV30+E+ZkkGt8N2qtwqC2770+bT
         95ZQqPHBFiH0lYzyY8ICdQ9VC/rHTfmqOcyyBbmrMld8Ksk7z/hYSL77DBARuyWTDJHR
         y0xA==
X-Gm-Message-State: AOJu0Yyiq9Wtt7zg1W6CEEoSAmbVOVRkzKPtqfmVZyn2cMN6Ox28QtA3
	AaSdWXzge2a2vISf8fUP7ayU5TRxqy3VVItODEViYuMeZqMD1bfO
X-Google-Smtp-Source: AGHT+IHV1bJsjHXMyK/I3kSrFPKgJSnczzkvGgjWhvZ1817k9xrqQXqtD5m4Qmvx+gG4gAj0q1rF0A==
X-Received: by 2002:a17:90b:4a08:b0:2c9:9fcd:aa51 with SMTP id 98e67ed59e1d1-2cff9419a1fmr9833368a91.5.1722758620359;
        Sun, 04 Aug 2024 01:03:40 -0700 (PDT)
Received: from localhost.localdomain ([39.144.105.172])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4064c3sm8051899a91.10.2024.08.04.01.03.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Aug 2024 01:03:39 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH] fs: Add a new flag RWF_IOWAIT for preadv2(2)
Date: Sun,  4 Aug 2024 16:02:51 +0800
Message-Id: <20240804080251.21239-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Background
==========

Our big data workloads are deployed on XFS-based disks, and we frequently
encounter hung tasks caused by xfs_ilock. These hung tasks arise because
different applications may access the same files concurrently. For example,
while a datanode task is writing to a file, a filebeat[0] task might be
reading the same file concurrently. If the task writing to the file takes a
long time, the task reading the file will hang due to contention on the XFS
inode lock.

This inode lock contention between writing and reading files only occurs on
XFS, but not on other file systems such as EXT4. Dave provided a clear
explanation for why this occurs only on XFS[1]:

  : I/O is intended to be atomic to ordinary files and pipes and FIFOs.
  : Atomic means that all the bytes from a single operation that started
  : out together end up together, without interleaving from other I/O
  : operations. [2]
  : XFS is the only linux filesystem that provides this behaviour.

As we have been running big data on XFS for years, we don't want to switch
to other file systems like EXT4. Therefore, we plan to resolve these issues
within XFS.

Proposal
========

One solution we're currently exploring is leveraging the preadv2(2)
syscall. By using the RWF_NOWAIT flag, preadv2(2) can avoid the XFS inode
lock hung task. This can be illustrated as follows:

  retry:
      if (preadv2(fd, iovec, cnt, offset, RWF_NOWAIT) < 0) {
          sleep(n)
          goto retry;
      }

Since the tasks reading the same files are not critical tasks, a delay in
reading is acceptable. However, RWF_NOWAIT not only enables IOCB_NOWAIT but
also enables IOCB_NOIO. Therefore, if the file is not in the page cache, it
will loop indefinitely until someone else reads it from disk, which is not
acceptable.

So we're planning to introduce a new flag, IOCB_IOWAIT, to preadv2(2). This
flag will allow reading from the disk if the file is not in the page cache
but will not allow waiting for the lock if it is held by others. With this
new flag, we can resolve our issues effectively.

Link: https://lore.kernel.org/linux-xfs/20190325001044.GA23020@dastard/ [0]
Link: https://github.com/elastic/beats/tree/master/filebeat [1]
Link: https://pubs.opengroup.org/onlinepubs/009695399/functions/read.html [2]
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Dave Chinner <david@fromorbit.com>
---
 include/linux/fs.h      | 6 ++++++
 include/uapi/linux/fs.h | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd34b5755c0b..5df7b5b0927a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3472,6 +3472,12 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags,
 			return -EPERM;
 		ki->ki_flags &= ~IOCB_APPEND;
 	}
+	if (flags & RWF_IOWAIT) {
+		kiocb_flags |= IOCB_NOWAIT;
+		/* IOCB_NOIO is not allowed for RWF_IOWAIT */
+		if (kiocb_flags & IOCB_NOIO)
+			return -EINVAL;
+	}
 
 	ki->ki_flags |= kiocb_flags;
 	return 0;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index 191a7e88a8ab..17a8c065d636 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -332,9 +332,12 @@ typedef int __bitwise __kernel_rwf_t;
 /* Atomic Write */
 #define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
 
+/* per-IO, allow waiting for IO, but not waiting for lock */
+#define RWF_IOWAIT	((__force __kernel_rwf_t)0x00000080)
+
 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
-			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC)
+			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC | RWF_IOWAIT)
 
 /* Pagemap ioctl */
 #define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
-- 
2.43.5


