Return-Path: <linux-fsdevel+bounces-63654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A43CEBC8B19
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 13:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A5F04EB5BF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 11:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B992DFA3B;
	Thu,  9 Oct 2025 11:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EImXM8gj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F15B2D6E7D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760007990; cv=none; b=e4qPP5FHUsADS6qkXzaRJZce68PPUnAo1NnJB+jKs9nIdn6wtnCv+Ce3GwDzb70/Jq6hWJctPZFGNaFPDMql8gp7pR9um/WF7pMOwZh/Srxi6gQ/7VGR8B5OY0R2Oe/nEGVh1BXFWb1skzOcSL7+gzBRnzRtG593bIAiUoyjlmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760007990; c=relaxed/simple;
	bh=4019sHdt1ppywB7KuVCM4qPsAA8CYsCpMl8vDwO/dqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T+mXIFyp4qB85dFUO8I8miolAYOb3NSo3cMfYYrZvx0NK4RSkRbO3SeQFIJgPRLLSCeVtu8OsGUUTGDqEt/4uMhoBHtt7paI1r2xLKPMlQX+Os4JMSh+X5oKImDrRnsS3JBVkc2Ec9JJjbQoMLEONk3KAXfIbjedtcimcbqPc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EImXM8gj; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-339a0b9ed6cso143717a91.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 04:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760007988; x=1760612788; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7WvQ1lRZvaAgyHD3mjKbF3FMdanug0QiqVEdNsY/yo=;
        b=EImXM8gjbz2A33y1K5LM4l11rsBrWub3tl+yfwWC5bXHNSc+tZXHc0V/cbiqRc4R+W
         4XF//dBoize0EtCBVb2VZ/c+fDkMcpC8QS0Gkqap0RfofJHdRYg5Fhm951JhXQ0wq6kg
         3ywNQUIdTxwlJ/BuPF0ztZ+5jyxeHXJqru/ahxYAH7/Uw7ITHBDZlHD/Dq99ooA+Q8C0
         Z26KoeuNXwyScCougo3LLNkrHyjFGpvOBAN8ruIMkyU2IibcNgWnKo1U+aU082/SU6mS
         POPAi9Chx61rWDDEApur7M86HcvN4l6QH4MUjH8eNRKwS6ba/9Dbb8SHgtMaBKAVN30H
         VsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760007988; x=1760612788;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7WvQ1lRZvaAgyHD3mjKbF3FMdanug0QiqVEdNsY/yo=;
        b=dugEV2BQrq8IXL4il+iN9q94tIloXe6V6/FnYrZXFR9Qtml5Zl99YobdkGLQ9zDLT4
         J3P0hf2WoFGOy/owh1LeUiyNowrtF6Qcoo+h2ABB42mXq4oGOpCPnpVk8RhEQ1zbnv9H
         XRk4TUpvoKqbi9H+/B+pYBOyPn5tJUG6wXetybMqK69jNUw/qJ5ORRlEpVgKfqHYxAMc
         IQS6GcJx0NBvOR8xar/pTjuR1ks6ZxQI4l4ifQpSrLSoi4tCEmyIW/48V48mzw+5ahbS
         Z8br9uiW2Av44BSoXjglxF5/Y59PB3eQ6GKds62qbX+M0lH3A15ApeBdA7+sQLM4/U7D
         d3Rw==
X-Gm-Message-State: AOJu0YxmH9rsnpUxTb8N3VMvOqrmAJIPzts7O5kr6VTlJwmfrEUqn3zX
	UwXVK6+yCcrtLX2tC2KCNQPgJYwiDX0dCzQuWvV5NLnoyNN6Bt78Mqf/kWG+sq/7c+VylykT
X-Gm-Gg: ASbGncsYlIBoWBKYGqarWjbaLoZEOj+YGIh3Q/GQyvftWXJ9d/Q202dMnqAyZmrsacy
	dZDwk2cWbSOxTeLYKBABJz/Z4bv13RKuv8cTHefwZ5gupzOqQO2/47b1N3neNeG0LFK4RudLlny
	FiGCcevO/hYKRKLiIMHSCY2zYaoYk91hZ5x/Wc1RG/eaC+bx7odeGGlPifQpZwBw/+HnVsWQyzD
	Dx0cgfwUNU+jYZigXe0nqywoZnWishbyM2iBJRDg93ayjV/Qa1ixyUV96/7RWFHdyOmnuAUlVCO
	/BLhBsPSkb0R14kTLy4GsIw/oNiuiLOpndH3vuQPriSL1XBDqIHl2EXZnXz+sfka5oMsMvPGoRZ
	s5f7SRR0pTE5cwTfIHySXPxG3/8mGLPBepqBBL8LYm3Zd98Y=
X-Google-Smtp-Source: AGHT+IGSwQwv+DWm4fZTGnL1m8RsvGOG+CnnXuES1p83dQ0sn1NZ9Z72M1jNOXsaIKJ7wWyoYpo9dA==
X-Received: by 2002:a17:90b:1b42:b0:32e:64ca:e849 with SMTP id 98e67ed59e1d1-33b513990d5mr4618313a91.8.1760007988258;
        Thu, 09 Oct 2025 04:06:28 -0700 (PDT)
Received: from gm-arco.lan ([111.201.7.16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b513926fesm6732041a91.21.2025.10.09.04.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 04:06:27 -0700 (PDT)
From: "guangming.zhao" <giveme.gulu@gmail.com>
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
Date: Thu,  9 Oct 2025 19:06:23 +0800
Message-ID: <20251009110623.3115511-1-giveme.gulu@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The race occurs as follows:
1. A write operation locks a page, fills it with new data, marks it
   Uptodate, and then immediately unlocks it within fuse_fill_write_pages().
2. This opens a window before the new data is sent to the userspace daemon.
3. A concurrent read operation for the same page may decide to re-validate
   its cache from the daemon. The fuse_wait_on_page_writeback()
   mechanism does not protect this synchronous writethrough path.
4. The read request can be processed by the multi-threaded daemon *before*
   the write request, causing it to reply with stale data from its backend.
5. The read syscall returns this stale data to userspace, causing data
   verification to fail.

This can be reliably reproduced on a mainline kernel (e.g., 6.1.x)
using iogen and a standard multi-threaded libfuse passthrough filesystem.

Steps to Reproduce:
1. Mount a libfuse passthrough filesystem (must be multi-threaded):
   $ ./passthrough /path/to/mount_point

2. Run the iogen/doio test from LTP (Linux Test Project) with mixed
   read/write operations (example):
   $ /path/to/ltp/iogen -N iogen01 -i 120s -s read,write 500k:/path/to/mount_point/file1 | \
     /path/to/ltp/doio -N iogen01 -a -v -n 2 -k

3. A data comparison error similar to the following will be reported:
   *** DATA COMPARISON ERROR ***
   check_file(/path/to/mount_point/file1, ...) failed
   expected bytes:  X:3091346:gm-arco:doio*X:3091346
   actual bytes:    91346:gm-arco:doio*C:3091346:gm-

The fix is to delay unlocking the page until after the data has been
successfully sent to the daemon. This is achieved by moving the unlock
logic from fuse_fill_write_pages() to the completion path of
fuse_send_write_pages(), ensuring the page lock is held for the entire
critical section and serializing the operations correctly.

[Note for maintainers]
This patch is created and tested against the 5.15 kernel. I have observed
that recent kernels have migrated to using folios, and I am not confident
in porting this fix to the new folio-based code myself.

I am submitting this patch to clearly document the race condition and a
proven fix on an older kernel, in the hope that a developer more
familiar with the folio conversion can adapt it for the mainline tree.

Signed-off-by: guangming.zhao <giveme.gulu@gmail.com>
---
[root@gm-arco example]# uname -a
Linux gm-arco 6.16.8-arch3-1 #1 SMP PREEMPT_DYNAMIC Mon, 22 Sep 2025 22:08:35 +0000 x86_64 GNU/Linux
[root@gm-arco example]# ./passthrough /tmp/test/
[root@gm-arco example]# mkdir /tmp/test/yy
[root@gm-arco example]# /home/gm/code/ltp/testcases/kernel/fs/doio/iogen -N iogen01 -i 120s -s read,write 500b:/tmp/test/yy/kk1 1000b:/tmp/test/yy/kk2 | /home/gm/code/ltp/testcases/kernel/fs/doio/doio -N iogen01 -a -v -n 2 -k

iogen(iogen01) starting up with the following:

Out-pipe:              stdout
Iterations:            120 seconds
Seed:                  3091343
Offset-Mode:           sequential
Overlap Flag:          off
Mintrans:              1           (1 blocks)
Maxtrans:              131072      (256 blocks)
O_RAW/O_SSD Multiple:  (Determined by device)
Syscalls:              read write
Aio completion types:  none
Flags:                 buffered sync

Test Files:

Path                                          Length    iou   raw iou file
                                              (bytes) (bytes) (bytes) type
-----------------------------------------------------------------------------
/tmp/test/yy/kk1                               256000       1     512 regular
/tmp/test/yy/kk2                               512000       1     512 regular

doio(iogen01) (3091346) 17:43:50
---------------------
*** DATA COMPARISON ERROR ***
check_file(/tmp/test/yy/kk2, 116844, 106653, X:3091346:gm-arco:doio*, 23, 0) failed

Comparison fd is 3, with open flags 0
Corrupt regions follow - unprintable chars are represented as '.'
-----------------------------------------------------------------
corrupt bytes starting at file offset 116844
    1st 32 expected bytes:  X:3091346:gm-arco:doio*X:3091346
    1st 32 actual bytes:    91346:gm-arco:doio*C:3091346:gm-
Request number 13873
syscall:  write(4, 02540107176414100, 106653)
          fd 4 is file /tmp/test/yy/kk2 - open flags are 04010001
          write done at file offset 116844 - pattern is X:3091346:gm-arco:doio*

doio(iogen01) (3091344) 17:43:50
---------------------
(parent) pid 3091346 exited because of data compare errors

 fs/fuse/file.c | 36 ++++++++++--------------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 5c5ed58d9..a832c3122 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1098,7 +1098,6 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	struct fuse_file *ff = file->private_data;
 	struct fuse_mount *fm = ff->fm;
 	unsigned int offset, i;
-	bool short_write;
 	int err;
 
 	for (i = 0; i < ap->num_pages; i++)
@@ -1113,26 +1112,21 @@ static ssize_t fuse_send_write_pages(struct fuse_io_args *ia,
 	if (!err && ia->write.out.size > count)
 		err = -EIO;
 
-	short_write = ia->write.out.size < count;
 	offset = ap->descs[0].offset;
 	count = ia->write.out.size;
 	for (i = 0; i < ap->num_pages; i++) {
 		struct page *page = ap->pages[i];
 
-		if (err) {
-			ClearPageUptodate(page);
-		} else {
-			if (count >= PAGE_SIZE - offset)
-				count -= PAGE_SIZE - offset;
-			else {
-				if (short_write)
-					ClearPageUptodate(page);
-				count = 0;
-			}
-			offset = 0;
-		}
-		if (ia->write.page_locked && (i == ap->num_pages - 1))
-			unlock_page(page);
+        if (!err && !offset && count >= PAGE_SIZE)
+            SetPageUptodate(page);
+
+        if (count > PAGE_SIZE - offset)
+            count -= PAGE_SIZE - offset;
+        else
+            count = 0;
+        offset = 0;
+
+        unlock_page(page);
 		put_page(page);
 	}
 
@@ -1195,16 +1189,6 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 		if (offset == PAGE_SIZE)
 			offset = 0;
 
-		/* If we copied full page, mark it uptodate */
-		if (tmp == PAGE_SIZE)
-			SetPageUptodate(page);
-
-		if (PageUptodate(page)) {
-			unlock_page(page);
-		} else {
-			ia->write.page_locked = true;
-			break;
-		}
 		if (!fc->big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
-- 
2.51.0


