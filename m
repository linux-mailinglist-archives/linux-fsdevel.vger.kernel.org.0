Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63053C27D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 23:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732167AbfI3VDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 17:03:22 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:16464 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731582AbfI3VDS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:18 -0400
Received: from smtp2.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 71D6CA164B;
        Mon, 30 Sep 2019 20:37:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.240])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id 3S-0EmaE9R3C; Mon, 30 Sep 2019 20:37:31 +0200 (CEST)
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
Subject: [PATCH v13 9/9] Documentation: update path-lookup to mention trailing magic-links
Date:   Tue,  1 Oct 2019 04:33:16 +1000
Message-Id: <20190930183316.10190-10-cyphar@cyphar.com>
In-Reply-To: <20190930183316.10190-1-cyphar@cyphar.com>
References: <20190930183316.10190-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We've introduced new (somewhat subtle) behaviour regarding trailing
magic-links, so it's best to make sure everyone can follow along with
the reasoning behind trailing_magiclink().

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 Documentation/filesystems/path-lookup.rst | 80 ++++++++++++++++++-----
 1 file changed, 63 insertions(+), 17 deletions(-)

diff --git a/Documentation/filesystems/path-lookup.rst b/Documentation/filesystems/path-lookup.rst
index 434a07b0002b..c30145b3d9ba 100644
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
@@ -1149,22 +1153,61 @@ so ``NULL`` is returned to indicate that the symlink can be released and
 the stack frame discarded.
 
 The other case involves things in ``/proc`` that look like symlinks but
-aren't really::
+aren't really (and are therefore commonly referred to as "magic-links")::
 
      $ ls -l /proc/self/fd/1
      lrwx------ 1 neilb neilb 64 Jun 13 10:19 /proc/self/fd/1 -> /dev/pts/4
 
 Every open file descriptor in any process is represented in ``/proc`` by
-something that looks like a symlink.  It is really a reference to the
-target file, not just the name of it.  When you ``readlink`` these
-objects you get a name that might refer to the same file - unless it
-has been unlinked or mounted over.  When ``walk_component()`` follows
-one of these, the ``->follow_link()`` method in "procfs" doesn't return
-a string name, but instead calls ``nd_jump_link()`` which updates the
-``nameidata`` in place to point to that target.  ``->follow_link()`` then
-returns ``NULL``.  Again there is no final component and ``get_link()``
-reports this by leaving the ``last_type`` field of ``nameidata`` as
-``LAST_BIND``.
+a magic-link.  It is really a reference to the target file, not just the
+name of it (hence making them "magical" compared to ordinary symlinks).
+When you ``readlink`` these objects you get a name that might refer to
+the same file - unless it has been unlinked or mounted over.  When
+``walk_component()`` follows one of these, the ``->follow_link()`` method
+in "procfs" doesn't return a string name, but instead calls
+``nd_jump_link()`` which updates the ``nameidata`` in place to point to
+that target.  ``->follow_link()`` then returns ``NULL``. Again there is
+no final component and ``get_link()`` reports this by leaving the
+``last_type`` field of ``nameidata`` as ``LAST_BIND``.
+
+In order to avoid potential re-opening attacks (especially in the context
+of containers), it is necessary to restrict the ability for a trailing
+magic-link to be opened. The restrictions are as follows (and are
+implemented in ``trailing_magiclink()``):
+
+* If the ``open()`` is an "ordinary open" (without ``O_PATH``), the
+  access-mode of the ``open()`` call must be permitted by one of the
+  octets in the magic-link's file mode (elsewhere in Linux, ordinary
+  symlinks have a file mode of ``0777`` but this doesn't apply to
+  magic-links). Each "ordinary" file in ``/proc/self/fd/$n`` has the user
+  octet of its file mode set to correspond to the access-mode it was
+  opened with.
+
+  This restriction means that you cannot re-open an ``O_RDONLY`` file
+  descriptor through ``/proc/self/fd/$n`` with ``O_RDWR``.
+
+With a "half-open" (with ``O_PATH``), there is no ``-EACCES``-enforced
+restrictions on ``open()``, but there are rules about the mode shown in
+``/proc/self/fd/$n``:
+
+* If the target of the ``open()`` is not a magic-link, then the group
+  octet of the file mode is set to permit all access modes.
+
+* Otherwise, the mode of the new ``O_PATH`` descriptor is set to
+  effectively the same mode as the magic-link (though the permissions are
+  set in the group octet of the mode). This means that an ``O_PATH`` of a
+  magic-link gives you no more re-open permissions than the magic-link
+  itself.
+
+With these ``O_PATH`` restrictions, it is still possible to re-open an
+``O_PATH`` file descriptor but you cannot use ``O_PATH`` to work around
+the above restrictions on "ordinary opens" of magic-links.
+
+In order to avoid certain race conditions (where a file descriptor
+associated with a magic-link is swapped, causing the ``link_inode`` of
+``nameidata`` to become stale during magic-link traversal),
+``nd_jump_link()`` stores the mode of the magic-link during traversal in
+``last_magiclink``.
 
 Following the symlink in the final component
 --------------------------------------------
@@ -1187,7 +1230,8 @@ handles the final component.  If the final component is a symlink
 that needs to be followed, then ``trailing_symlink()`` is called to set
 things up properly and the loop repeats, calling ``link_path_walk()``
 again.  This could loop as many as 40 times if the last component of
-each symlink is another symlink.
+each symlink is another symlink. ``trailing_magiclink()`` is then called to
+deal with permission checks relevant to ``/proc/$pid/fd``-style "symlinks".
 
 The various functions that examine the final component and possibly
 report that it is a symlink are ``lookup_last()``, ``mountpoint_last()``
@@ -1310,12 +1354,14 @@ longer needed.
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

