Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0C71495D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jan 2020 14:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAYNGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jan 2020 08:06:46 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:41322 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAYNGq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:06:46 -0500
Received: from localhost.localdomain (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id D7178C61B3D;
        Sat, 25 Jan 2020 13:06:42 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v7 01/11] proc: Rename struct proc_fs_info to proc_fs_opts
Date:   Sat, 25 Jan 2020 14:05:31 +0100
Message-Id: <20200125130541.450409-2-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200125130541.450409-1-gladkov.alexey@gmail.com>
References: <20200125130541.450409-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc_namespace.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 273ee82d8aa9..9a8b624bc3db 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -37,23 +37,23 @@ static __poll_t mounts_poll(struct file *file, poll_table *wait)
 	return res;
 }
 
-struct proc_fs_info {
+struct proc_fs_opts {
 	int flag;
 	const char *str;
 };
 
 static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 {
-	static const struct proc_fs_info fs_info[] = {
+	static const struct proc_fs_opts fs_opts[] = {
 		{ SB_SYNCHRONOUS, ",sync" },
 		{ SB_DIRSYNC, ",dirsync" },
 		{ SB_MANDLOCK, ",mand" },
 		{ SB_LAZYTIME, ",lazytime" },
 		{ 0, NULL }
 	};
-	const struct proc_fs_info *fs_infop;
+	const struct proc_fs_opts *fs_infop;
 
-	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
+	for (fs_infop = fs_opts; fs_infop->flag; fs_infop++) {
 		if (sb->s_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
@@ -63,7 +63,7 @@ static int show_sb_opts(struct seq_file *m, struct super_block *sb)
 
 static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 {
-	static const struct proc_fs_info mnt_info[] = {
+	static const struct proc_fs_opts mnt_opts[] = {
 		{ MNT_NOSUID, ",nosuid" },
 		{ MNT_NODEV, ",nodev" },
 		{ MNT_NOEXEC, ",noexec" },
@@ -72,9 +72,9 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 		{ MNT_RELATIME, ",relatime" },
 		{ 0, NULL }
 	};
-	const struct proc_fs_info *fs_infop;
+	const struct proc_fs_opts *fs_infop;
 
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
+	for (fs_infop = mnt_opts; fs_infop->flag; fs_infop++) {
 		if (mnt->mnt_flags & fs_infop->flag)
 			seq_puts(m, fs_infop->str);
 	}
-- 
2.24.1

