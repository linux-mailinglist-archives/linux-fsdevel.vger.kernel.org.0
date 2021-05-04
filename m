Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29433729BD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 May 2021 13:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhEDL5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 May 2021 07:57:11 -0400
Received: from mx-out.tlen.pl ([193.222.135.148]:44063 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230187AbhEDL5L (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 May 2021 07:57:11 -0400
Received: (wp-smtpd smtp.tlen.pl 30375 invoked from network); 4 May 2021 13:56:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1620129372; bh=ZflAlwfVgQ8t4U6A4utcxhrvXLX4YAaPe8kf3JeY4cs=;
          h=From:To:Cc:Subject;
          b=fI5VwxFsFHPXveN919uY3zU3lWOLBf9m3QSXoR40QV5eqFRWv8eEnw3a3oUbH7jGu
           lNZ7c+1XlgXUHJfzeOGSw5IPcE1xQoYWUHNlgSKx3LMRo+7e/SGg+9IZ85cX5B7F4l
           OqB6Ke+PI1kETSOdvblnm5ZobCGHFSTf8N0Xk01M=
Received: from 89-64-47-21.dynamic.chello.pl (HELO localhost.localdomain) (arek_koz@o2.pl@[89.64.47.21])
          (envelope-sender <arek_koz@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <gregkh@linuxfoundation.org>; 4 May 2021 13:56:12 +0200
From:   "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3] proc: Use seq_read_iter for /proc/*/maps
Date:   Tue,  4 May 2021 13:53:58 +0200
Message-Id: <20210504115358.20741-1-arek_koz@o2.pl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YIqFcHj3O2t+JJak@kroah.com>
References: <YIqFcHj3O2t+JJak@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 59b837cc2ea74145e071cd5bd1b8498e
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000004 [QSex]                               
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since seq_read_iter looks mature enough to be used for /proc/<pid>/maps,
re-allow applications to perform zero-copy data forwarding from it.

Some executable-inspecting tools (e.g. pwntools) rely on patching entry
point instructions with minimal machine code that uses sendfile to read
/proc/self/maps to stdout.  The sendfile call allows them to do it
without excessive allocations, which would change the mappings, and
therefore distort the information.

This is inspired by the series by Cristoph Hellwig (linked).

Link: https://lore.kernel.org/lkml/20201104082738.1054792-1-hch@lst.de/
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arkadiusz Kozdra (Arusekk) <arek_koz@o2.pl>
---
v3:
  - Only commit message changed.
  - Clarify what tools use this.
  - Do not mention performance.

The average execution time of a patched static ELF outputting to a pipe
(the use case of pwntools inspecting mappings of an executable)
was varying both before and after ca. 3.43ms +-0.05ms (I decided that
the performance impact is not worth mentioning in the commit message).

I think that the change should probably marginally improve speed, but
it will most likely also affect the memory footprint and as such likely
minimally decrease power consumption (I suppose it would only be
measurable when the mappings description grows many pages long).
Speed might be more affected in pathological cases like a close-to-OOM
scenario, but I was unable to test this reliably.
I did my tests under qemu-system-x86_64 on a Ryzen 4500 host without
kvm, with default kernel config.

If someone wants to also test this feature of pwntools for themselves,
it can be used as follows and should print something other than None:

    $ pip install pwntools
    $ python3
    >>> from pwn import *
    >>> print(ELF("/bin/true").libc)

Sorry for the delay, but it took me much time to figure out some
low-overhead timing methods.

Does this change need selftests?  It looks like it should never break
again if it only uses common code hopefully tested elsewhere.

 fs/proc/task_mmu.c   | 3 ++-
 fs/proc/task_nommu.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e862cab69583..06282294ddb8 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -351,7 +351,8 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read    = generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..e55e79fd0175 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -295,7 +295,8 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
+	.splice_read	= generic_file_splice_read,
 	.llseek		= seq_lseek,
 	.release	= map_release,
 };
-- 
2.31.1

