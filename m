Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E61F583B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgFJPto (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 11:49:44 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43773 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgFJPtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 11:49:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id 23so1262530pfw.10;
        Wed, 10 Jun 2020 08:49:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ttnu+GumEeK2dxlrXFIgjuU2z6ZpHty3fj6TVLOpBV8=;
        b=sM6bANWh4UjbXp03MJVOonzPUWXJlh2cXCu4Eq+CQLYBsKyBGbFEuO1abWEJum4E59
         n3DEQEDt9il0AQvgI78hNAK6CzURvBZhH2LV2hupGFEI+Bs/WuGVY2FNBppfjrzHQqDg
         k6S8wjB/x6+bu8qOTLi5TzGYhZ672/omdQj5D5gf9PSU23CxChJc5kBrjF1+gI13RsIc
         QUaki2Cizke7yAJ6KYsbKcfrfVi9D/rL5Nee5epN09GfON9ilm8LFZOF/GRfTA8zfP8j
         RDKAtTou/jbGTQbXIyQ5qtKrXChSxiC+m29j9119is39vItLOw9Im2DVKc/bf/7WGiTn
         51kQ==
X-Gm-Message-State: AOAM531haJWhUwKdzAPQDlLvMnPw81llEjMgb57CwRHPEyM4UeWK66rN
        ++T4fK60DEZpomwDQKEj40Q=
X-Google-Smtp-Source: ABdhPJy4BST5Ypqj52/eoac8mQmWFwF6I7vWpY7xXXn85YwjFOb1Y0c/dkStnzo1uFPTe0w13h7IUw==
X-Received: by 2002:a63:58d:: with SMTP id 135mr3011251pgf.2.1591804173617;
        Wed, 10 Jun 2020 08:49:33 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id w65sm272528pfb.160.2020.06.10.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 08:49:26 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7148441D95; Wed, 10 Jun 2020 15:49:25 +0000 (UTC)
From:   "Luis R. Rodriguez" <mcgrof@kernel.org>
To:     gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com,
        roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com,
        jarkko.sakkinen@linux.intel.com, jmorris@namei.org,
        serge@hallyn.com, christian.brauner@ubuntu.com
Cc:     slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org,
        josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        bridge@lists.linux-foundation.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH 4/5] umh: fix processed error when UMH_WAIT_PROC is used
Date:   Wed, 10 Jun 2020 15:49:22 +0000
Message-Id: <20200610154923.27510-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luis Chamberlain <mcgrof@kernel.org>

When UMH_WAIT_PROC is used we call kernel_wait4(). This is
the *only* place in the kernel where we actually inspect the
error code. Prior to this patch we returned the value from the
wait call, and that technically requires us to use wrappers
such as WEXITSTATUS(). We either fix all callers to start
using WEXITSTATUS() and friends *or* we do address this within
the umh code and let the callers get the actual error code.

The way we use kernel_wait4() on the umh is with the options
set to 0, and when this is done the wait call only waits for
terminated children. Because of this, there is no point to
complicate checks for the umh with W*() calls. That would
make the checks complex, redundant, and simply not needed.

By making the umh do the checks for us we keep users
kernel_wait4() at bay, and promote avoiding introduction of
further W*() macros and the complexities this can bring.

There were only a few callers which properly checked for
the error status using open-coded solutions. We remove
them as they are no longer needed, and also remove open
coded implicit uses of W*() uses which should never
trigger given that the options passed to wait is 0.

The only helpers we really need are for termination, so we
just include those, and we prefix our W*() helpers with K.

Since all this does is *correct* an error code, if one
was found, this change only fixes reporting the *correct*
error, and there are two places where this matters, and
which this patch fixes:

  * request_module() used to fail with an error code of
    256 when a module was not found. Now it properly
    returns 1.

  * fs/nfsd/nfs4recover.c: we never were disabling the
    upcall as the error code of -ENOENT or -EACCES was
    *never* properly checked for.

Reported-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/drbd/drbd_nl.c | 20 ++++++++------------
 fs/nfsd/nfs4recover.c        |  2 +-
 include/linux/sched/task.h   | 13 +++++++++++++
 kernel/umh.c                 |  4 ++--
 net/bridge/br_stp_if.c       | 10 ++--------
 security/keys/request_key.c  |  2 +-
 6 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index da4a3ebe04ef..aee272e620b9 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -382,13 +382,11 @@ int drbd_khelper(struct drbd_device *device, char *cmd)
 	notify_helper(NOTIFY_CALL, device, connection, cmd, 0);
 	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
-		drbd_warn(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				drbd_usermode_helper, cmd, mb,
-				(ret >> 8) & 0xff, ret);
+		drbd_warn(device, "helper command: %s %s %s failed with exit code %u (0x%x)\n",
+				drbd_usermode_helper, cmd, mb, ret, ret);
 	else
-		drbd_info(device, "helper command: %s %s %s exit code %u (0x%x)\n",
-				drbd_usermode_helper, cmd, mb,
-				(ret >> 8) & 0xff, ret);
+		drbd_info(device, "helper command: %s %s %s completed successfully\n",
+				drbd_usermode_helper, cmd, mb);
 	sib.sib_reason = SIB_HELPER_POST;
 	sib.helper_exit_code = ret;
 	drbd_bcast_event(device, &sib);
@@ -424,13 +422,11 @@ enum drbd_peer_state conn_khelper(struct drbd_connection *connection, char *cmd)
 
 	ret = call_usermodehelper(drbd_usermode_helper, argv, envp, UMH_WAIT_PROC);
 	if (ret)
-		drbd_warn(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  drbd_usermode_helper, cmd, resource_name,
-			  (ret >> 8) & 0xff, ret);
+		drbd_warn(connection, "helper command: %s %s %s failed with exit code %u (0x%x)\n",
+			  drbd_usermode_helper, cmd, resource_name, ret, ret);
 	else
-		drbd_info(connection, "helper command: %s %s %s exit code %u (0x%x)\n",
-			  drbd_usermode_helper, cmd, resource_name,
-			  (ret >> 8) & 0xff, ret);
+		drbd_info(connection, "helper command: %s %s %s completed successfully\n",
+			  drbd_usermode_helper, cmd, resource_name);
 	/* TODO: conn_bcast_event() ?? */
 	notify_helper(NOTIFY_RESPONSE, NULL, connection, cmd, ret);
 
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 9e40dfecf1b1..33e6a7fd7961 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1820,7 +1820,7 @@ nfsd4_umh_cltrack_upcall(char *cmd, char *arg, char *env0, char *env1)
 
 	ret = call_usermodehelper(argv[0], argv, envp, UMH_WAIT_PROC);
 	/*
-	 * Disable the upcall mechanism if we're getting an ENOENT or EACCES
+	 * Disable the upcall mechanism if we're getting an -ENOENT or -EACCES
 	 * error. The admin can re-enable it on the fly by using sysfs
 	 * once the problem has been fixed.
 	 */
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 38359071236a..bba06befbff5 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -103,6 +103,19 @@ struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
 extern long kernel_wait4(pid_t, int __user *, int, struct rusage *);
 
+/* Only add helpers for actual use cases in the kernel */
+#define KWEXITSTATUS(status)		(__KWEXITSTATUS(status))
+#define KWIFEXITED(status)		(__KWIFEXITED(status))
+
+/* Nonzero if STATUS indicates normal termination.  */
+#define __KWIFEXITED(status)     (__KWTERMSIG(status) == 0)
+
+/* If KWIFEXITED(STATUS), the low-order 8 bits of the status.  */
+#define __KWEXITSTATUS(status)   (((status) & 0xff00) >> 8)
+
+/* If KWIFSIGNALED(STATUS), the terminating signal.  */
+#define __KWTERMSIG(status)      ((status) & 0x7f)
+
 extern void free_task(struct task_struct *tsk);
 
 /* sched_exec is called by processes performing an exec */
diff --git a/kernel/umh.c b/kernel/umh.c
index 79f139a7ca03..f81e8698e36e 100644
--- a/kernel/umh.c
+++ b/kernel/umh.c
@@ -154,8 +154,8 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
 		 * the real error code is already in sub_info->retval or
 		 * sub_info->retval is 0 anyway, so don't mess with it then.
 		 */
-		if (ret)
-			sub_info->retval = ret;
+		if (KWIFEXITED(ret))
+			sub_info->retval = KWEXITSTATUS(ret);
 	}
 
 	/* Restore default kernel sig handler */
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index ba55851fe132..bdd94b45396b 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -133,14 +133,8 @@ static int br_stp_call_user(struct net_bridge *br, char *arg)
 
 	/* call userspace STP and report program errors */
 	rc = call_usermodehelper(BR_STP_PROG, argv, envp, UMH_WAIT_PROC);
-	if (rc > 0) {
-		if (rc & 0xff)
-			br_debug(br, BR_STP_PROG " received signal %d\n",
-				 rc & 0x7f);
-		else
-			br_debug(br, BR_STP_PROG " exited with code %d\n",
-				 (rc >> 8) & 0xff);
-	}
+	if (rc != 0)
+		br_debug(br, BR_STP_PROG " failed with exit code %d\n", rc);
 
 	return rc;
 }
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e1b9f1a80676..ff462f3d46ca 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -193,7 +193,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 	ret = call_usermodehelper_keys(request_key, argv, envp, keyring,
 				       UMH_WAIT_PROC);
 	kdebug("usermode -> 0x%x", ret);
-	if (ret >= 0) {
+	if (ret != 0) {
 		/* ret is the exit/wait code */
 		if (test_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags) ||
 		    key_validate(key) < 0)
-- 
2.26.2

