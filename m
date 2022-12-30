Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E356F659C90
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 22:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbiL3VxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 16:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiL3VxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:53:11 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2D21CFE8
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:53:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id v7-20020a056902108700b007971863ae72so2149243ybu.22
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 13:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4DokS/FZJlMuz65NYBFzd2Wq7AgsGKfPd6D2qH+qms=;
        b=FgGwqmDX00GIWfIYPn/v8jRlZd2/7/eGhsa3XhZaxfOffHYe3todQjnwAAsP2bTkVA
         NXtj5qc/YfA9UTTSKVXDsNyMAQiVWsVl5biYy5PbMY3paPPCX1TsCSWPWHZT0vluz8M2
         VScUMyAHmNjsnk5aY8zH9ZZjn9mmLgCd7ClnRRUHlssSxX4w6uZ375mhpBYm4hH6bUqk
         xB7kwz3GbYZZCAfOS0HKy4R4y5kIVxhSP1t+NvJeST2lASf5xuxdPggulq/bzWk8UuQ1
         hAI2KXL04UliLjieBCQZ/eRt4IbXiY4KhcH6y4MZ0aG+I4BPczrrrZjPSI8kHJD1RcBs
         60eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4DokS/FZJlMuz65NYBFzd2Wq7AgsGKfPd6D2qH+qms=;
        b=sVGYYWKxZc5UzO5I85W3RjVJ+IK87PbUmcvMc4tiQLcPdqO/EFmsuWUrAn/QQVe5UW
         3pUqbB/7OPOwEV6wle8nQhBaV6Y/qofyCtSJ84OD8YgQjljN19VjU3i3D/O1qDhzlSew
         hrJu6FnYnFQsTC0eHIZQZGhI5sKizz/8JrmNSA+sgrUGIDmIgMR8fQRlQFYtngDiHxY+
         I7rzRmkB5e0hHFRhyHpProk3QYPx+vHI6tURgIfHXAzZjmPt9dd3Qv4DJ4myAZSG/Ga3
         qQcnauxNZ7AJIhKeCA5NDFH9GDr1awrmJvdRmrsr7jZvxYTDAVkoWQ3/Ev6SfCCI0bum
         Hy3Q==
X-Gm-Message-State: AFqh2kpb1+yo17BnUAOZ1nWhR+Umu9gyJ9LO57CcVDOHh0SmXPdoVXum
        KgUEbysjY47P1zFm2M+FVRc64rlVxKo=
X-Google-Smtp-Source: AMrXdXtTmFzViPQcW6Bc4aF7poiGpJjp1VELwrivuun/rdXIksgRPlpJqcuBPyGHvQEmV73KcdhsYhrdZTI=
X-Received: from yuzhao.bld.corp.google.com ([2620:15c:183:200:81fe:2008:27c1:d0cb])
 (user=yuzhao job=sendgmr) by 2002:a81:494f:0:b0:480:c531:5824 with SMTP id
 w76-20020a81494f000000b00480c5315824mr2177473ywa.247.1672437180183; Fri, 30
 Dec 2022 13:53:00 -0800 (PST)
Date:   Fri, 30 Dec 2022 14:52:52 -0700
In-Reply-To: <20221230215252.2628425-1-yuzhao@google.com>
Message-Id: <20221230215252.2628425-2-yuzhao@google.com>
Mime-Version: 1.0
References: <20221230215252.2628425-1-yuzhao@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH mm-unstable v2 2/2] mm: support POSIX_FADV_NOREUSE
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Righi <andrea.righi@canonical.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michael Larabel <michael@michaellarabel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@google.com,
        Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds POSIX_FADV_NOREUSE to vma_has_recency() so that the
LRU algorithm can ignore access to mapped files marked by this flag.

The advantages of POSIX_FADV_NOREUSE are:
1. Unlike MADV_SEQUENTIAL and MADV_RANDOM, it does not alter the
   default readahead behavior.
2. Unlike MADV_SEQUENTIAL and MADV_RANDOM, it does not split VMAs and
   therefore does not take mmap_lock.
3. Unlike MADV_COLD, setting it has a negligible cost, regardless of
   how many pages it affects.

Its limitations are:
1. Like POSIX_FADV_RANDOM and POSIX_FADV_SEQUENTIAL, it currently does
   not support range. IOW, its scope is the entire file.
2. It currently does not ignore access through file descriptors.
   Specifically, for the active/inactive LRU, given a file page shared
   by two users and one of them having set POSIX_FADV_NOREUSE on the
   file, this page will be activated upon the second user accessing
   it. This corner case can be covered by checking POSIX_FADV_NOREUSE
   before calling folio_mark_accessed() on the read path. But it is
   considered not worth the effort.

There have been a few attempts to support POSIX_FADV_NOREUSE, e.g.,
[1]. This time the goal is to fill a niche: a few desktop
applications, e.g., large file transferring and video
encoding/decoding, want fast file streaming with mmap() rather than
direct IO. Among those applications, an SVT-AV1 regression was
reported when running with MGLRU [2]. The following test can reproduce
that regression.

  kb=$(awk '/MemTotal/ { print $2 }' /proc/meminfo)
  kb=$((kb - 8*1024*1024))

  modprobe brd rd_nr=1 rd_size=$kb
  dd if=/dev/zero of=/dev/ram0 bs=1M

  mkfs.ext4 /dev/ram0
  mount /dev/ram0 /mnt/
  swapoff -a

  fallocate -l 8G /mnt/swapfile
  mkswap /mnt/swapfile
  swapon /mnt/swapfile

  wget http://ultravideo.cs.tut.fi/video/Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z
  7z e -o/mnt/ Bosphorus_3840x2160_120fps_420_8bit_YUV_Y4M.7z
  SvtAv1EncApp --preset 12 -w 3840 -h 2160 \
               -i /mnt/Bosphorus_3840x2160.y4m

For MGLRU, the following change showed a [9-11]% increase in FPS,
which makes it on par with the active/inactive LRU.

  patch Source/App/EncApp/EbAppMain.c <<EOF
  31a32
  > #include <fcntl.h>
  35d35
  < #include <fcntl.h> /* _O_BINARY */
  117a118
  >             posix_fadvise(config->mmap.fd, 0, 0, POSIX_FADV_NOREUSE);
  EOF

[1] https://lore.kernel.org/r/1308923350-7932-1-git-send-email-andrea@betterlinux.com/
[2] https://openbenchmarking.org/result/2209259-PTS-MGLRU8GB57

Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 include/linux/fs.h        | 2 ++
 include/linux/mm_inline.h | 3 +++
 mm/fadvise.c              | 5 ++++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 066555ad1bf8..5660ed0edf1a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -166,6 +166,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File supports DIRECT IO */
 #define	FMODE_CAN_ODIRECT	((__force fmode_t)0x400000)
 
+#define	FMODE_NOREUSE		((__force fmode_t)0x800000)
+
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index fe5b8449e14a..064f92c78bfa 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -600,6 +600,9 @@ static inline bool vma_has_recency(struct vm_area_struct *vma)
 	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
 		return false;
 
+	if (vma->vm_file && (vma->vm_file->f_mode & FMODE_NOREUSE))
+		return false;
+
 	return true;
 }
 
diff --git a/mm/fadvise.c b/mm/fadvise.c
index bf04fec87f35..fb7c5f43fd2a 100644
--- a/mm/fadvise.c
+++ b/mm/fadvise.c
@@ -80,7 +80,7 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 	case POSIX_FADV_NORMAL:
 		file->f_ra.ra_pages = bdi->ra_pages;
 		spin_lock(&file->f_lock);
-		file->f_mode &= ~FMODE_RANDOM;
+		file->f_mode &= ~(FMODE_RANDOM | FMODE_NOREUSE);
 		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_RANDOM:
@@ -107,6 +107,9 @@ int generic_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 		force_page_cache_readahead(mapping, file, start_index, nrpages);
 		break;
 	case POSIX_FADV_NOREUSE:
+		spin_lock(&file->f_lock);
+		file->f_mode |= FMODE_NOREUSE;
+		spin_unlock(&file->f_lock);
 		break;
 	case POSIX_FADV_DONTNEED:
 		__filemap_fdatawrite_range(mapping, offset, endbyte,
-- 
2.39.0.314.g84b9a713c41-goog

