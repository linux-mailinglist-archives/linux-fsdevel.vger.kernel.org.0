Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBD83102C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 03:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBECZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 21:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhBECY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 21:24:59 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DB9C061797
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Feb 2021 18:24:18 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id t186so4503707qke.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Feb 2021 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=6d9ABw+2MMja8w+m/Ge5BEthUdZ4QJrI2VfEHE0lgZM=;
        b=Wc16uuiBzr8uRjh+FFc3aIVuYhA4o0xASF2SZxYJnSmlvoMBSrBe3o+TwZR3i71wu/
         fqI4C+NddGfKrN79A8uKvB/q6omI/GP9hEtW/sg69RyL3/2WcO4gxwzosiUilwevKO40
         W9GedpIGi4x2wd5wgj4dMTWcXsvW6I8ncM32cwEbWi8ZNJnCsROyGUBiIZhNqKZXGMjO
         /EVsU2QqlGJReEo8F1Rg79kqGShzlt0flDZIvLOZWrIW0e54pnTDADWfK6X72sHXMBFE
         PzRiVNGkqfISNW+tz/s/6UL65wp2v17Qg95lrHV9rWpeAfNgdamhTwR58a+JTd0plkzx
         Racg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=6d9ABw+2MMja8w+m/Ge5BEthUdZ4QJrI2VfEHE0lgZM=;
        b=Yr5QjtUlsdX5zZSFPnGgXLMtSpOnn2E+9eg9PdTRHTyV0FhvNcvBiwGcEvUJUL8m1U
         Q0jHia46VsxtEKjjPxu7VDtpB+wPQwYTD5n20NdOxA3L+reZCV2IWREDWJO8TLOWKl53
         gHWt2RLn/uUQLuklLZoQeAwhIW8fd6PoeKJuzvQtabO+OkYIfFC3I3MedeHEgURDEl9k
         X2txhDtU04xkhVFY9wPVrdB/JbpSVWDiFGMsoFuSwbMWbcPA0lJYnMqYLZ2YIt3hwoLA
         LB0vGCmSZPaKNhhJV0UUn8GiGcKIrSoRnEwYKFFXU6Yt2xReN7ZNxqc4HS7IId5BWJ48
         D09w==
X-Gm-Message-State: AOAM532YPMF7LgAg/epSpEGwNg3mnyXekzm2vofJNlNNvNLoydcG6cfi
        d2STPuf0akTP/B7x+rqkz8YW4lGoCraxhl8NrA==
X-Google-Smtp-Source: ABdhPJw8Yeorck2XB7ovp4pfEx707riZ2xycBS0Z28A1vOhEhNyxFRWBW6rhdYjGLZma2NqW8dSu+H8zYFEZQD05eA==
Sender: "kaleshsingh via sendgmr" <kaleshsingh@kaleshsingh.c.googlers.com>
X-Received: from kaleshsingh.c.googlers.com ([fda3:e722:ac3:10:14:4d90:c0a8:2145])
 (user=kaleshsingh job=sendgmr) by 2002:ad4:5606:: with SMTP id
 ca6mr2501087qvb.1.1612491857373; Thu, 04 Feb 2021 18:24:17 -0800 (PST)
Date:   Fri,  5 Feb 2021 02:23:20 +0000
In-Reply-To: <20210205022328.481524-1-kaleshsingh@google.com>
Message-Id: <20210205022328.481524-2-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20210205022328.481524-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v3 2/2] dmabuf: Add dmabuf inode number to /proc/*/fdinfo
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     jannh@google.com, jeffv@google.com, keescook@chromium.org,
        surenb@google.com, minchan@kernel.org, hridya@google.com,
        kernel-team@android.com, Kalesh Singh <kaleshsingh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Anand K Mistry <amistry@google.com>,
        NeilBrown <neilb@suse.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Andrei Vagin <avagin@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If a FD refers to a DMA buffer add the DMA buffer inode number to
/proc/<pid>/fdinfo/<FD> and /proc/<pid>/task/<tid>/fdindo/<FD>.

The dmabuf inode number allows userspace to uniquely identify the buffer
and avoids a dependency on /proc/<pid>/fd/* when accounting per-process
DMA buffer sizes.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
Changes in v3:
  - Add documentation in proc.rst
Changes in v2:
  - Update patch description

 Documentation/filesystems/proc.rst | 17 +++++++++++++++++
 drivers/dma-buf/dma-buf.c          |  1 +
 2 files changed, 18 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..fdd38676f57f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2031,6 +2031,23 @@ details]. 'it_value' is remaining time until the timer expiration.
 with TIMER_ABSTIME option which will be shown in 'settime flags', but 'it_value'
 still exhibits timer's remaining time.
 
+DMA Buffer files
+~~~~~~~~~~~~~~~~
+
+::
+
+	pos:	0
+	flags:	04002
+	mnt_id:	9
+	dmabuf_inode_no: 63107
+	size:   32768
+	count:  2
+	exp_name:  system-heap
+
+where 'dmabuf_inode_no' is the unique inode number of the DMA buffer file.
+'size' is the size of the DMA buffer in bytes. 'count' is the file count of
+the DMA buffer file. 'exp_name' is the name of the DMA buffer exporter.
+
 3.9	/proc/<pid>/map_files - Information about memory mapped files
 ---------------------------------------------------------------------
 This directory contains symbolic links which represent memory mapped files
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 9ad6397aaa97..d869099ede83 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -414,6 +414,7 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 {
 	struct dma_buf *dmabuf = file->private_data;
 
+	seq_printf(m, "dmabuf_inode_no:\t%lu\n", file_inode(file)->i_ino);
 	seq_printf(m, "size:\t%zu\n", dmabuf->size);
 	/* Don't count the temporary reference taken inside procfs seq_show */
 	seq_printf(m, "count:\t%ld\n", file_count(dmabuf->file) - 1);
-- 
2.30.0.478.g8a0d178c01-goog

