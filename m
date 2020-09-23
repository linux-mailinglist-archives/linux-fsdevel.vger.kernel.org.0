Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9568275EF4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 19:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgIWRon (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 13:44:43 -0400
Received: from relay.sw.ru ([185.231.240.75]:43164 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726234AbgIWRom (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:44:42 -0400
Received: from [172.16.25.93] (helo=amikhalitsyn-pc0.sw.ru)
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1kL7uv-000qjf-26; Wed, 23 Sep 2020 19:46:53 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     viro@zeniv.linux.org.uk
Cc:     avagin@gmail.com,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] fsopen: fsconfig syscall restart fix
Date:   Wed, 23 Sep 2020 19:46:36 +0300
Message-Id: <20200923164637.13032-2-alexander.mikhalitsyn@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923164637.13032-1-alexander.mikhalitsyn@virtuozzo.com>
References: <20200923164637.13032-1-alexander.mikhalitsyn@virtuozzo.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

During execution of vfs_fsconfig_locked function we can get ERESTARTNOINTR
error (or other interrupt error). But we changing fs context fc->phase
field to transient states and our entry fc->phase checks in switch cases
(see FS_CONTEXT_CREATE_PARAMS, FS_CONTEXT_RECONF_PARAMS) will always fail
after syscall restart which will lead to returning -EBUSY to the userspace.

The idea of the fix is to save entry-time fs_context phase field value and
recover fc->phase value to the original one before exiting with
"interrupt error" (ERESTARTNOINTR or similar).

Many thanks to Andrei Vagin <avagin@gmail.com> for help with that.

Signed-off-by: Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
---
 fs/fsopen.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/fs/fsopen.c b/fs/fsopen.c
index 27a890aa493a..70e6d163c169 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -209,6 +209,18 @@ SYSCALL_DEFINE3(fspick, int, dfd, const char __user *, path, unsigned int, flags
 	return ret;
 }
 
+static inline bool is_interrupt_error(int error)
+{
+	switch (error) {
+	case -EINTR:
+	case -ERESTARTSYS:
+	case -ERESTARTNOHAND:
+	case -ERESTARTNOINTR:
+		return true;
+	}
+	return false;
+}
+
 /*
  * Check the state and apply the configuration.  Note that this function is
  * allowed to 'steal' the value by setting param->xxx to NULL before returning.
@@ -217,11 +229,20 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 			       struct fs_parameter *param)
 {
 	struct super_block *sb;
+	enum fs_context_phase entry_phase;
 	int ret;
 
 	ret = finish_clean_context(fc);
 	if (ret)
 		return ret;
+
+	/* We changing fc->phase in the code below but we need to
+	 * return fc->phase to the original value if we get
+	 * "interrupt error" during the process to make fsconfig
+	 * syscall restart procedure work correctly.
+	 */
+	entry_phase = fc->phase;
+
 	switch (cmd) {
 	case FSCONFIG_CMD_CREATE:
 		if (fc->phase != FS_CONTEXT_CREATE_PARAMS)
@@ -264,7 +285,16 @@ static int vfs_fsconfig_locked(struct fs_context *fc, int cmd,
 
 		return vfs_parse_fs_param(fc, param);
 	}
-	fc->phase = FS_CONTEXT_FAILED;
+
+	/* We should fail context only if we get real error.
+	 * If we get ERESTARTNOINTR we can safely restart
+	 * fsconfig syscall.
+	 */
+	if (is_interrupt_error(ret))
+		fc->phase = entry_phase;
+	else
+		fc->phase = FS_CONTEXT_FAILED;
+
 	return ret;
 }
 
-- 
2.25.1

