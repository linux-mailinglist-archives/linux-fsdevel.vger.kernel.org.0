Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08C67E5F1A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2019 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJZS7h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Oct 2019 14:59:37 -0400
Received: from mout-p-101.mailbox.org ([80.241.56.151]:50152 "EHLO
        mout-p-101.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbfJZS7g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:59:36 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 470qz85SdpzKmsD;
        Sat, 26 Oct 2019 20:59:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter06.heinlein-hosting.de (spamfilter06.heinlein-hosting.de [80.241.56.125]) (amavisd-new, port 10030)
        with ESMTP id suRkpnqaA-TF; Sat, 26 Oct 2019 20:59:28 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH RESEND v14 6/6] Documentation: path-lookup: mention LOOKUP_MAGICLINK_JUMPED
Date:   Sun, 27 Oct 2019 05:57:00 +1100
Message-Id: <20191026185700.10708-7-cyphar@cyphar.com>
In-Reply-To: <20191026185700.10708-1-cyphar@cyphar.com>
References: <20191026185700.10708-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that we have a special flag to signify magic-link jumps, mention it
within the path-lookup docs. And now that "magic link" is the correct
term for nd_jump_link()-style symlinks, clean up references to this type
of "symlink".

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/path-lookup.rst | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 434a07b0002b..2c32795389bd 100644
--- a/Documentation/filesystems/path-lookup.rst
+++ b/Documentation/filesystems/path-lookup.rst
@@ -405,6 +405,10 @@ is requested.  Keeping a reference in the ``nameidata`` ensures that
 only one root is in effect for the entire path walk, even if it races
 with a ``chroot()`` system call.
 
+It should be noted that in the case of ``LOOKUP_IN_ROOT`` or
+``LOOKUP_BENEATH``, the effective root becomes the directory file descriptor
+passed to ``openat2()`` (which exposes these ``LOOKUP_`` flags).
+
 The root is needed when either of two conditions holds: (1) either the
 pathname or a symbolic link starts with a "'/'", or (2) a "``..``"
 component is being handled, since "``..``" from the root must always stay
@@ -1149,7 +1153,7 @@ so ``NULL`` is returned to indicate that the symlink can be released and
 the stack frame discarded.
 
 The other case involves things in ``/proc`` that look like symlinks but
-aren't really::
+aren't really (and are therefore commonly referred to as "magic-links")::
 
      $ ls -l /proc/self/fd/1
      lrwx------ 1 neilb neilb 64 Jun 13 10:19 /proc/self/fd/1 -> /dev/pts/4
@@ -1310,12 +1314,14 @@ longer needed.
 ``LOOKUP_JUMPED`` means that the current dentry was chosen not because
 it had the right name but for some other reason.  This happens when
 following "``..``", following a symlink to ``/``, crossing a mount point
-or accessing a "``/proc/$PID/fd/$FD``" symlink.  In this case the
-filesystem has not been asked to revalidate the name (with
-``d_revalidate()``).  In such cases the inode may still need to be
-revalidated, so ``d_op->d_weak_revalidate()`` is called if
+or accessing a "``/proc/$PID/fd/$FD``" symlink (also known as a "magic
+link"). In this case the filesystem has not been asked to revalidate the
+name (with ``d_revalidate()``).  In such cases the inode may still need
+to be revalidated, so ``d_op->d_weak_revalidate()`` is called if
 ``LOOKUP_JUMPED`` is set when the look completes - which may be at the
-final component or, when creating, unlinking, or renaming, at the penultimate component.
+final component or, when creating, unlinking, or renaming, at the
+penultimate component. ``LOOKUP_MAGICLINK_JUMPED`` is set alongside
+``LOOKUP_JUMPED`` if a magic-link was traversed.
 
 Final-component flags
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.23.0

