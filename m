Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DA81F5263
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 12:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFJKdu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 06:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728083AbgFJKdu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:33:50 -0400
Received: from tleilax.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F61320656;
        Wed, 10 Jun 2020 10:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591785229;
        bh=Y6b0gSncn1/a5Q78r0kRdmb3Y99DmqJm0a/r4EgnVRU=;
        h=From:To:Cc:Subject:Date:From;
        b=do1Tm6pIfzK8K5U8XgdJZ6geVi9hW1o+iZrhn4x4bNVZDBAzc0qH6z1L4/nsdC3mP
         y4LLDoCIU24b0s5SOnUHayn1emNhLlSdfIDqrGROErM25cbWZM+sYjjZQXB6r9xPqW
         +86QeR+KjlmN9wardTz+l0kukPG95zeQQJpW3BRc=
From:   Jeff Layton <jlayton@kernel.org>
To:     mtk.manpages@gmail.com
Cc:     linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][man-pages] sync.2: syncfs() now returns errors if writeback fails
Date:   Wed, 10 Jun 2020 06:33:47 -0400
Message-Id: <20200610103347.14395-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A patch has been merged for v5.8 that changes how syncfs() reports
errors. Change the sync() manpage accordingly.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man2/sync.2 | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/man2/sync.2 b/man2/sync.2
index 7198f3311b05..27e04cff5845 100644
--- a/man2/sync.2
+++ b/man2/sync.2
@@ -86,11 +86,26 @@ to indicate the error.
 is always successful.
 .PP
 .BR syncfs ()
-can fail for at least the following reason:
+can fail for at least the following reasons:
 .TP
 .B EBADF
 .I fd
 is not a valid file descriptor.
+.TP
+.B EIO
+An error occurred during synchronization.
+This error may relate to data written to any file on the filesystem, or on
+metadata related to the filesytem itself.
+.TP
+.B ENOSPC
+Disk space was exhausted while synchronizing.
+.TP
+.BR ENOSPC ", " EDQUOT
+Data was written to a files on NFS or another filesystem which does not
+allocate space at the time of a
+.BR write (2)
+system call, and some previous write failed due to insufficient
+storage space.
 .SH VERSIONS
 .BR syncfs ()
 first appeared in Linux 2.6.39;
@@ -121,6 +136,13 @@ or
 .BR syncfs ()
 provide the same guarantees as fsync called on every file in
 the system or filesystem respectively.
+.PP
+In mainline kernel versions prior to 5.8,
+.\" commit 735e4ae5ba28c886d249ad04d3c8cc097dad6336
+.BR syncfs ()
+will only fail with EBADF when passed a bad file descriptor. In 5.8
+and later kernels, it will also report an error if one or more inodes failed
+to be written back since the last syncfs call.
 .SH BUGS
 Before version 1.3.20 Linux did not wait for I/O to complete
 before returning.
-- 
2.26.2

