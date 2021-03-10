Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6852333468C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 19:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhCJSUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 13:20:47 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:56482 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232828AbhCJSUV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 13:20:21 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id 87B0140F00;
        Wed, 10 Mar 2021 18:20:19 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v5 1/5] docs: proc: add documentation about mount restrictions
Date:   Wed, 10 Mar 2021 19:19:56 +0100
Message-Id: <333cf0c988255d7bf54871ad4fa02af2aaa8d4a3.1615400395.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615400395.git.gladkov.alexey@gmail.com>
References: <cover.1615400395.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Wed, 10 Mar 2021 18:20:19 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Documentation/filesystems/proc.rst | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..3daf0e7d1071 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -50,6 +50,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 
   4	Configuring procfs
   4.1	Mount options
+  4.2	Mount restrictions
 
   5	Filesystem behavior
 
@@ -2175,6 +2176,21 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+4.2	Mount restrictions
+--------------------------
+
+The procfs can be mounted without any special restrictions if user namespace is
+not used. You only need to have permission to mount (CAP_SYS_ADMIN).
+
+If you are inside the user namespace, the kernel checks the instances of procfs
+available to you and will not allow procfs to be mounted if:
+
+  1. There is a bind mount of part of procfs visible. Whoever mounts should be
+     able to see the entire filesystem.
+  2. Mount is prohibited if a new mount overrides the readonly option or family
+     of atime options.
+  3. If any file or non-empty procfs directory is hidden by another filesystem.
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.29.2

