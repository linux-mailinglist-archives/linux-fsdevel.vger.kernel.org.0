Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 350B5ABC70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404327AbfIFP0i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 11:26:38 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:57071 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404126AbfIFP0i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:26:38 -0400
Received: from smtp5.infomaniak.ch (smtp5.infomaniak.ch [83.166.132.18])
        by smtp-sh2.infomaniak.ch (8.14.4/8.14.4/Debian-8+deb8u2) with ESMTP id x86FP9Ih086018
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 17:25:09 +0200
Received: from localhost (ns3096276.ip-94-23-54.eu [94.23.54.103])
        (authenticated bits=0)
        by smtp5.infomaniak.ch (8.14.5/8.14.5) with ESMTP id x86FP9Sx047701;
        Fri, 6 Sep 2019 17:25:09 +0200
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Philippe=20Tr=C3=A9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        Yves-Alexis Perez <yves-alexis.perez@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 5/5] doc: Add documentation for the fs.open_mayexec_enforce sysctl
Date:   Fri,  6 Sep 2019 17:24:55 +0200
Message-Id: <20190906152455.22757-6-mic@digikod.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190906152455.22757-1-mic@digikod.net>
References: <20190906152455.22757-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Changes since v1:
* move from LSM/Yama to sysctl/fs

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Reviewed-by: Philippe Trébuchet <philippe.trebuchet@ssi.gouv.fr>
Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mickaël Salaün <mickael.salaun@ssi.gouv.fr>
---
 Documentation/admin-guide/sysctl/fs.rst | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index 2a45119e3331..f2f5bbe428d6 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -37,6 +37,7 @@ Currently, these files are in /proc/sys/fs:
 - inode-nr
 - inode-state
 - nr_open
+- open_mayexec_enforce
 - overflowuid
 - overflowgid
 - pipe-user-pages-hard
@@ -165,6 +166,48 @@ system needs to prune the inode list instead of allocating
 more.
 
 
+open_mayexec_enforce
+--------------------
+
+The ``O_MAYEXEC`` flag can be passed to :manpage:`open(2)` to only open regular
+files that are expected to be executable.  If the file is not identified as
+executable, then the syscall returns -EACCES.  This may allow a script
+interpreter to check executable permission before reading commands from a file.
+One interesting use case is to enforce a "write xor execute" policy through
+interpreters.
+
+Thanks to this flag, it is possible to enforce the ``noexec`` mount option
+(i.e.  the underlying mount point of the file is mounted with MNT_NOEXEC or its
+underlying superblock is SB_I_NOEXEC) not only on ELF binaries but also on
+scripts.  This may be possible thanks to script interpreters using the
+``O_MAYEXEC`` flag.  The executable permission is then checked before reading
+commands from a file, and thus can enforce the ``noexec`` at the interpreter
+level by propagating this security policy to the scripts.  To be fully
+effective, these interpreters also need to handle the other ways to execute
+code (for which the kernel can't help): command line parameters (e.g., option
+``-e`` for Perl), module loading (e.g., option ``-m`` for Python), stdin, file
+sourcing, environment variables, configuration files...  According to the
+threat model, it may be acceptable to allow some script interpreters (e.g.
+Bash) to interpret commands from stdin, may it be a TTY or a pipe, because it
+may not be enough to (directly) perform syscalls.
+
+There is two complementary security policies: enforce the ``noexec`` mount
+option, or enforce executable file permission.  These policies are handled by
+the ``fs.open_mayexec_enforce`` sysctl (writable only with ``CAP_MAC_ADMIN``)
+as a bitmask:
+
+1 - mount restriction:
+    check that the mount options for the underlying VFS mount do not prevent
+    execution.
+
+2 - file permission restriction:
+    check that the to-be-opened file is marked as executable for the current
+    process (e.g., POSIX permissions).
+
+Code samples can be found in tools/testing/selftests/exec/omayexec.c and
+https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
+
+
 overflowgid & overflowuid
 -------------------------
 
-- 
2.23.0

