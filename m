Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEAD204AA1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jun 2020 09:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgFWHJv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 03:09:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbgFWHJR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:17 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 901AC20829;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=OlnMTTa5ehdz61kbpcxRW/wxM9TbGDNOSFyHXcWFpUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0i6qYhYoyfJT86/k2q2y7dhrglPs9lGR5/v2uPKNxQKLOXX06Xs+T3ukDfN3enq9+
         w5F6E5IsvaN+zMjvKMhKxrCjxdAunRwsYQVeOn1BArq9v8eKND5DwMWanESRi8NZL2
         OtvA/HuY4KnhGcjxnWFcqmFUU229+XvNTCj1ArQU=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qji-Fp; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 15/15] docs: fs: proc.rst: convert a new chapter to ReST
Date:   Tue, 23 Jun 2020 09:09:11 +0200
Message-Id: <de67ec04a2e735f4450eb3ce966f7d80b9438244.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A new chapter was added to proc.rst. Adjust the markups
to avoid this warning:

	Documentation/filesystems/proc.rst:2194: WARNING: Inconsistent literal block quoting.

And to properly mark the code-blocks there.

Fixes: 37e7647a7212 ("docs: proc: add documentation for "hidepid=4" and "subset=pid" options and new mount behavior")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 Documentation/filesystems/proc.rst | 44 ++++++++++++++----------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 53a0230a08e2..cc0fd2685562 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2179,46 +2179,44 @@ subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
 5	Filesystem behavior
-----------------------------
+---------------------------
 
 Originally, before the advent of pid namepsace, procfs was a global file
 system. It means that there was only one procfs instance in the system.
 
 When pid namespace was added, a separate procfs instance was mounted in
 each pid namespace. So, procfs mount options are global among all
-mountpoints within the same namespace.
+mountpoints within the same namespace::
 
-::
+	# grep ^proc /proc/mounts
+	proc /proc proc rw,relatime,hidepid=2 0 0
 
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=2 0 0
+	# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
+	mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
+	+++ exited with 0 +++
 
-# strace -e mount mount -o hidepid=1 -t proc proc /tmp/proc
-mount("proc", "/tmp/proc", "proc", 0, "hidepid=1") = 0
-+++ exited with 0 +++
-
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=2 0 0
-proc /tmp/proc proc rw,relatime,hidepid=2 0 0
+	# grep ^proc /proc/mounts
+	proc /proc proc rw,relatime,hidepid=2 0 0
+	proc /tmp/proc proc rw,relatime,hidepid=2 0 0
 
 and only after remounting procfs mount options will change at all
-mountpoints.
+mountpoints::
 
-# mount -o remount,hidepid=1 -t proc proc /tmp/proc
+	# mount -o remount,hidepid=1 -t proc proc /tmp/proc
 
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=1 0 0
-proc /tmp/proc proc rw,relatime,hidepid=1 0 0
+	# grep ^proc /proc/mounts
+	proc /proc proc rw,relatime,hidepid=1 0 0
+	proc /tmp/proc proc rw,relatime,hidepid=1 0 0
 
 This behavior is different from the behavior of other filesystems.
 
 The new procfs behavior is more like other filesystems. Each procfs mount
 creates a new procfs instance. Mount options affect own procfs instance.
 It means that it became possible to have several procfs instances
-displaying tasks with different filtering options in one pid namespace.
+displaying tasks with different filtering options in one pid namespace::
 
-# mount -o hidepid=invisible -t proc proc /proc
-# mount -o hidepid=noaccess -t proc proc /tmp/proc
-# grep ^proc /proc/mounts
-proc /proc proc rw,relatime,hidepid=invisible 0 0
-proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
+	# mount -o hidepid=invisible -t proc proc /proc
+	# mount -o hidepid=noaccess -t proc proc /tmp/proc
+	# grep ^proc /proc/mounts
+	proc /proc proc rw,relatime,hidepid=invisible 0 0
+	proc /tmp/proc proc rw,relatime,hidepid=noaccess 0 0
-- 
2.26.2

