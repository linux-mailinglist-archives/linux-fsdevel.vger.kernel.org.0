Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB147A9346
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 22:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIDUWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Sep 2019 16:22:00 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:65512 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbfIDUV7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:21:59 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 0A85DA10DB;
        Wed,  4 Sep 2019 22:21:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id 4Q-pCNALFn6r; Wed,  4 Sep 2019 22:21:50 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <christian@brauner.io>
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
        Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v12 06/12] procfs: switch magic-link modes to be more sane
Date:   Thu,  5 Sep 2019 06:19:27 +1000
Message-Id: <20190904201933.10736-7-cyphar@cyphar.com>
In-Reply-To: <20190904201933.10736-1-cyphar@cyphar.com>
References: <20190904201933.10736-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that magic-link modes are obeyed for file re-opening purposes, some
of the pre-existing magic-link modes need to be adjusted to be more
semantically correct.

The most blatant example of this is /proc/self/exe, which had a mode of
a+rwx even though tautologically the file could never be opened for
writing (because it is the current->mm of a live process).

With the new O_PATH restrictions, changing the default mode of these
magic-links allows us to avoid delayed-access attacks such as we saw in
CVE-2019-5736.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/proc/base.c       | 20 ++++++++++----------
 fs/proc/namespaces.c |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ebea9501afb8..297242174402 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -133,9 +133,9 @@ struct pid_entry {
 
 #define DIR(NAME, MODE, iops, fops)	\
 	NOD(NAME, (S_IFDIR|(MODE)), &iops, &fops, {} )
-#define LNK(NAME, get_link)					\
-	NOD(NAME, (S_IFLNK|S_IRWXUGO),				\
-		&proc_pid_link_inode_operations, NULL,		\
+#define LNK(NAME, MODE, get_link)			\
+	NOD(NAME, (S_IFLNK|(MODE)),			\
+		&proc_pid_link_inode_operations, NULL,	\
 		{ .proc_get_link = get_link } )
 #define REG(NAME, MODE, fops)				\
 	NOD(NAME, (S_IFREG|(MODE)), NULL, &fops, {})
@@ -3028,9 +3028,9 @@ static const struct pid_entry tgid_base_stuff[] = {
 	REG("numa_maps",  S_IRUGO, proc_pid_numa_maps_operations),
 #endif
 	REG("mem",        S_IRUSR|S_IWUSR, proc_mem_operations),
-	LNK("cwd",        proc_cwd_link),
-	LNK("root",       proc_root_link),
-	LNK("exe",        proc_exe_link),
+	LNK("cwd",        S_IRWXUGO, proc_cwd_link),
+	LNK("root",       S_IRWXUGO, proc_root_link),
+	LNK("exe",        S_IRUGO|S_IXUGO, proc_exe_link),
 	REG("mounts",     S_IRUGO, proc_mounts_operations),
 	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
 	REG("mountstats", S_IRUSR, proc_mountstats_operations),
@@ -3429,11 +3429,11 @@ static const struct pid_entry tid_base_stuff[] = {
 	REG("numa_maps", S_IRUGO, proc_pid_numa_maps_operations),
 #endif
 	REG("mem",       S_IRUSR|S_IWUSR, proc_mem_operations),
-	LNK("cwd",       proc_cwd_link),
-	LNK("root",      proc_root_link),
-	LNK("exe",       proc_exe_link),
+	LNK("cwd",       S_IRWXUGO, proc_cwd_link),
+	LNK("root",      S_IRWXUGO, proc_root_link),
+	LNK("exe",       S_IRUGO|S_IXUGO, proc_exe_link),
 	REG("mounts",    S_IRUGO, proc_mounts_operations),
-	REG("mountinfo",  S_IRUGO, proc_mountinfo_operations),
+	REG("mountinfo", S_IRUGO, proc_mountinfo_operations),
 #ifdef CONFIG_PROC_PAGE_MONITOR
 	REG("clear_refs", S_IWUSR, proc_clear_refs_operations),
 	REG("smaps",     S_IRUGO, proc_pid_smaps_operations),
diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index dd2b35f78b09..cd1e130913f7 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -94,7 +94,7 @@ static struct dentry *proc_ns_instantiate(struct dentry *dentry,
 	struct inode *inode;
 	struct proc_inode *ei;
 
-	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRWXUGO);
+	inode = proc_pid_make_inode(dentry->d_sb, task, S_IFLNK | S_IRUGO);
 	if (!inode)
 		return ERR_PTR(-ENOENT);
 
-- 
2.23.0

