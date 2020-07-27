Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE0422F04A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732054AbgG0OXU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 10:23:20 -0400
Received: from raptor.unsafe.ru ([5.9.43.93]:51904 "EHLO raptor.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732044AbgG0OXT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:23:19 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 10:23:17 EDT
Received: from comp-core-i7-2640m-0182e6.redhat.com (ip-89-102-33-211.net.upcbroadband.cz [89.102.33.211])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by raptor.unsafe.ru (Postfix) with ESMTPSA id DD21220A04;
        Mon, 27 Jul 2020 14:15:41 +0000 (UTC)
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v1 2/2] Show /proc/self/net only for CAP_NET_ADMIN
Date:   Mon, 27 Jul 2020 16:14:11 +0200
Message-Id: <20200727141411.203770-3-gladkov.alexey@gmail.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200727141411.203770-1-gladkov.alexey@gmail.com>
References: <20200727141411.203770-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.1 (raptor.unsafe.ru [5.9.43.93]); Mon, 27 Jul 2020 14:15:42 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Show /proc/self/net only for CAP_NET_ADMIN if procfs is mounted with
subset=pid option in user namespace. This is done to avoid possible
information leakage.

Signed-off-by: Alexey Gladkov <gladkov.alexey@gmail.com>
---
 fs/proc/proc_net.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/proc/proc_net.c b/fs/proc/proc_net.c
index dba63b2429f0..11fa2c4b3529 100644
--- a/fs/proc/proc_net.c
+++ b/fs/proc/proc_net.c
@@ -275,6 +275,12 @@ static struct net *get_proc_task_net(struct inode *dir)
 	struct task_struct *task;
 	struct nsproxy *ns;
 	struct net *net = NULL;
+	struct proc_fs_info *fs_info = proc_sb_info(dir->i_sb);
+
+	if ((fs_info->pidonly == PROC_PIDONLY_ON) &&
+	    (current_user_ns() != &init_user_ns) &&
+	    !capable(CAP_NET_ADMIN))
+		return net;
 
 	rcu_read_lock();
 	task = pid_task(proc_pid(dir), PIDTYPE_PID);
-- 
2.25.4

