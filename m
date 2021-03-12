Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95AC3393CB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Mar 2021 17:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhCLQml (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Mar 2021 11:42:41 -0500
Received: from raptor.unsafe.ru ([5.9.43.93]:49778 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232942AbhCLQmE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:42:04 -0500
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-94-113-225-162.net.upcbroadband.cz [94.113.225.162])
        by raptor.unsafe.ru (Postfix) with ESMTPSA id D512740C9A;
        Fri, 12 Mar 2021 16:42:01 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: [PATCH v6 1/5] docs: proc: add documentation about mount restrictions
Date:   Fri, 12 Mar 2021 17:41:44 +0100
Message-Id: <e57f67df145fd79baabd4c8cbaa75c7d1269282a.1615567183.git.gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.29.3
In-Reply-To: <cover.1615567183.git.gladkov.alexey@gmail.com>
References: <cover.1615567183.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (raptor.unsafe.ru [0.0.0.0]); Fri, 12 Mar 2021 16:42:02 +0000 (UTC)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 Documentation/filesystems/proc.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2fa69f710e2a..5a1bb0e081fd 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -50,6 +50,7 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 
   4	Configuring procfs
   4.1	Mount options
+  4.2	Mount restrictions
 
   5	Filesystem behavior
 
@@ -2175,6 +2176,19 @@ information about processes information, just add identd to this group.
 subset=pid hides all top level files and directories in the procfs that
 are not related to tasks.
 
+4.2	Mount restrictions
+--------------------------
+
+If user namespaces are in use, the kernel additionally checks the instances of
+procfs available to the mounter and will not allow procfs to be mounted if:
+
+  1. This mount is not fully visible.
+
+     a. It's root directory is not the root directory of the filesystem.
+     b. If any file or non-empty procfs directory is hidden by another mount.
+
+  2. A new mount overrides the readonly option or any option from atime familty.
+
 Chapter 5: Filesystem behavior
 ==============================
 
-- 
2.29.3

