Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE31D36E859
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 12:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhD2KEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Apr 2021 06:04:47 -0400
Received: from mx-out.tlen.pl ([193.222.135.142]:18261 "EHLO mx-out.tlen.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238046AbhD2KEq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:04:46 -0400
Received: (wp-smtpd smtp.tlen.pl 2600 invoked from network); 29 Apr 2021 12:03:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1619690637; bh=ygjEkLzoy67+HxQNC9nOx8jeF7wnqzCRlbT0WkJJcS0=;
          h=From:To:Cc:Subject;
          b=LwnqmiX7PrqVlTiTLaln3sNLKzPHxAoBMfDfjpqcaAMxJ5ohyrsw3DnoM1wLq+eY5
           aQOYMDULeavXLpYMW4gUdOgWNyRT5PawV/Vew4vEXM34ldBjZRCsad5zcJiuiSmiGm
           7HADcyoA+REJDht35wiOTPeMFkXQqa5x1iTCqhS8=
Received: from 89-64-46-199.dynamic.chello.pl (HELO localhost.localdomain) (arek_koz@o2.pl@[89.64.46.199])
          (envelope-sender <arek_koz@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <torvalds@linux-foundation.org>; 29 Apr 2021 12:03:57 +0200
From:   "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        "Arkadiusz Kozdra (Arusekk)" <arek_koz@o2.pl>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2] proc: Use seq_read_iter for /proc/*/maps
Date:   Thu, 29 Apr 2021 12:05:08 +0200
Message-Id: <20210429100508.18502-1-arek_koz@o2.pl>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
References: <CAHk-=wibrw+PnBiQbkGy+5p4GpkPwmmodw-beODikL-tiz0dFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: d2a92516f227032653df43168bef5a51
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000000 [AcNU]                               
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since seq_read_iter looks mature enough to be used for /proc/<pid>/maps,
re-allow applications to perform zero-copy data forwarding from it.

Some executable-inspecting tools rely on patching entry point
instructions with minimal machine code that uses sendfile to read
/proc/self/maps to stdout.  The sendfile call allows them to do it
faster and without excessive allocations.

This is inspired by the series by Cristoph Hellwig (linked).

Changes since v1:

only change proc_pid_maps_operations

Link: https://lore.kernel.org/lkml/20201104082738.1054792-1-hch@lst.de/
Fixes: 36e2c7421f02 ("fs: don't allow splice read/write without explicit ops")
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arkadiusz Kozdra (Arusekk) <arek_koz@o2.pl>
---
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

