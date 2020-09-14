Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE7C2693C5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 19:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgINRmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 13:42:49 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:5854 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725999AbgINRmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:42:44 -0400
X-Greylist: delayed 875 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Sep 2020 13:42:33 EDT
X-ASG-Debug-ID: 1600104471-0e4088502909400001-kl68QG
Received: from mail.didiglobal.com (bogon [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id pPwWhX9XrVOuYHVL; Tue, 15 Sep 2020 01:27:51 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 15 Sep
 2020 01:27:50 +0800
Date:   Tue, 15 Sep 2020 01:27:43 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <jack@suse.cz>, <amir73il@gmail.com>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [RFC PATCH] inotify: add support watch open exec event
Message-ID: <20200914172737.GA5011@192.168.3.9>
X-ASG-Orig-Subj: [RFC PATCH] inotify: add support watch open exec event
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS05.didichuxing.com (172.20.36.127) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: bogon[172.20.36.175]
X-Barracuda-Start-Time: 1600104471
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 2931
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.84623
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now the IN_OPEN event can report all open events for a file, but it can
not distinguish if the file was opened for execute or read/write.
This patch add a new event IN_OPEN_EXEC to support that. If user only
want to monitor a file was opened for execute, they can pass a more
precise event IN_OPEN_EXEC to inotify_add_watch.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 fs/notify/inotify/inotify_user.c | 3 ++-
 include/linux/inotify.h          | 2 +-
 include/uapi/linux/inotify.h     | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 186722ba3894..eb42d11a9988 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -819,8 +819,9 @@ static int __init inotify_user_setup(void)
 	BUILD_BUG_ON(IN_EXCL_UNLINK != FS_EXCL_UNLINK);
 	BUILD_BUG_ON(IN_ISDIR != FS_ISDIR);
 	BUILD_BUG_ON(IN_ONESHOT != FS_IN_ONESHOT);
+	BUILD_BUG_ON(IN_OPEN_EXEC != FS_OPEN_EXEC);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 22);
+	BUILD_BUG_ON(HWEIGHT32(ALL_INOTIFY_BITS) != 23);
 
 	inotify_inode_mark_cachep = KMEM_CACHE(inotify_inode_mark,
 					       SLAB_PANIC|SLAB_ACCOUNT);
diff --git a/include/linux/inotify.h b/include/linux/inotify.h
index 6a24905f6e1e..88fc82c8cf2a 100644
--- a/include/linux/inotify.h
+++ b/include/linux/inotify.h
@@ -15,7 +15,7 @@ extern struct ctl_table inotify_table[]; /* for sysctl */
 #define ALL_INOTIFY_BITS (IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
 			  IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
 			  IN_MOVED_TO | IN_CREATE | IN_DELETE | \
-			  IN_DELETE_SELF | IN_MOVE_SELF | IN_UNMOUNT | \
+			  IN_DELETE_SELF | IN_MOVE_SELF | IN_OPEN_EXEC | IN_UNMOUNT | \
 			  IN_Q_OVERFLOW | IN_IGNORED | IN_ONLYDIR | \
 			  IN_DONT_FOLLOW | IN_EXCL_UNLINK | IN_MASK_ADD | \
 			  IN_MASK_CREATE | IN_ISDIR | IN_ONESHOT)
diff --git a/include/uapi/linux/inotify.h b/include/uapi/linux/inotify.h
index 884b4846b630..f19ea046cc87 100644
--- a/include/uapi/linux/inotify.h
+++ b/include/uapi/linux/inotify.h
@@ -39,6 +39,7 @@ struct inotify_event {
 #define IN_DELETE		0x00000200	/* Subfile was deleted */
 #define IN_DELETE_SELF		0x00000400	/* Self was deleted */
 #define IN_MOVE_SELF		0x00000800	/* Self was moved */
+#define IN_OPEN_EXEC		0x00001000	/* File was opened */
 
 /* the following are legal events.  they are sent as needed to any watch */
 #define IN_UNMOUNT		0x00002000	/* Backing fs was unmounted */
@@ -66,7 +67,7 @@ struct inotify_event {
 #define IN_ALL_EVENTS	(IN_ACCESS | IN_MODIFY | IN_ATTRIB | IN_CLOSE_WRITE | \
 			 IN_CLOSE_NOWRITE | IN_OPEN | IN_MOVED_FROM | \
 			 IN_MOVED_TO | IN_DELETE | IN_CREATE | IN_DELETE_SELF | \
-			 IN_MOVE_SELF)
+			 IN_MOVE_SELF | IN_OPEN_EXEC)
 
 /* Flags for sys_inotify_init1.  */
 #define IN_CLOEXEC O_CLOEXEC
-- 
2.18.2

