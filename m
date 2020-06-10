Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FC81F5B53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 20:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729128AbgFJShP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 14:37:15 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:53430 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgFJShP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:37:15 -0400
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id BA90E203BD;
        Wed, 10 Jun 2020 18:37:12 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     ebiederm@xmission.com
Cc:     syzbot <syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com>,
        adobriyan@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: [PATCH v2] proc: s_fs_info may be NULL when proc_kill_sb is called
Date:   Wed, 10 Jun 2020 20:35:49 +0200
Message-Id: <20200610183549.1234214-1-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200610130422.1197386-1-gladkov.alexey@gmail.com>
References: <20200610130422.1197386-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Wed, 10 Jun 2020 18:37:13 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot found that proc_fill_super() fails before filling up sb->s_fs_info,
deactivate_locked_super() will be called and sb->s_fs_info will be NULL.
The proc_kill_sb() does not expect fs_info to be NULL which is wrong.

Link: https://lore.kernel.org/lkml/0000000000002d7ca605a7b8b1c5@google.com
Reported-by: syzbot+4abac52934a48af5ff19@syzkaller.appspotmail.com
Fixes: fa10fed30f25 ("proc: allow to mount many instances of proc in one pid namespace")
Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/root.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index ffebed1999e5..5e444d4f9717 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -264,11 +264,13 @@ static void proc_kill_sb(struct super_block *sb)
 {
 	struct proc_fs_info *fs_info = proc_sb_info(sb);
 
-	if (fs_info->proc_self)
-		dput(fs_info->proc_self);
+	if (!fs_info) {
+		kill_anon_super(sb);
+		return;
+	}
 
-	if (fs_info->proc_thread_self)
-		dput(fs_info->proc_thread_self);
+	dput(fs_info->proc_self);
+	dput(fs_info->proc_thread_self);
 
 	kill_anon_super(sb);
 	put_pid_ns(fs_info->pid_ns);
-- 
2.25.4

