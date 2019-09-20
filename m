Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A20A0B94B4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2019 17:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfITP6s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Sep 2019 11:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfITP6s (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:58:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1C7338A1C8E;
        Fri, 20 Sep 2019 15:58:48 +0000 (UTC)
Received: from asgard.redhat.com (ovpn-112-68.ams2.redhat.com [10.36.112.68])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C21CF19C5B;
        Fri, 20 Sep 2019 15:58:43 +0000 (UTC)
Date:   Fri, 20 Sep 2019 17:58:21 +0200
From:   Eugene Syromiatnikov <esyr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 1/3] fcntl: fix typo in RWH_WRITE_LIFE_NOT_SET r/w hint
 name
Message-ID: <8a7ab0242b9aa8dc89bab0f8054b742162bb10d9.1568994791.git.esyr@redhat.com>
References: <cover.1568994791.git.esyr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1568994791.git.esyr@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.69]); Fri, 20 Sep 2019 15:58:48 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

According to commit message in the original commit c75b1d9421f8 ("fs:
add fcntl() interface for setting/getting write life time hints"),
as well as userspace library[1] and man page update[2], R/W hint constants
are intended to have RWH_* prefix. However, RWF_WRITE_LIFE_NOT_SET retained
"RWF_*" prefix used in the early versions of the proposed patch set[3].
Rename it and provide the old name as a synonym for the new one
for backward compatibility.

[1] https://github.com/axboe/fio/commit/bd553af6c849
[2] https://github.com/mkerrisk/man-pages/commit/580082a186fd
[3] https://www.mail-archive.com/linux-block@vger.kernel.org/msg09638.html

Fixes: c75b1d9421f8 ("fs: add fcntl() interface for setting/getting write life time hints")
Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 fs/fcntl.c                       | 2 +-
 include/uapi/linux/fcntl.h       | 9 ++++++++-
 tools/include/uapi/linux/fcntl.h | 9 ++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771..41b6438 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -261,7 +261,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 static bool rw_hint_valid(enum rw_hint hint)
 {
 	switch (hint) {
-	case RWF_WRITE_LIFE_NOT_SET:
+	case RWH_WRITE_LIFE_NOT_SET:
 	case RWH_WRITE_LIFE_NONE:
 	case RWH_WRITE_LIFE_SHORT:
 	case RWH_WRITE_LIFE_MEDIUM:
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 1d33835..1f97b33 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -58,7 +58,7 @@
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
  */
-#define RWF_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NOT_SET	0
 #define RWH_WRITE_LIFE_NONE	1
 #define RWH_WRITE_LIFE_SHORT	2
 #define RWH_WRITE_LIFE_MEDIUM	3
@@ -66,6 +66,13 @@
 #define RWH_WRITE_LIFE_EXTREME	5
 
 /*
+ * The originally introduced spelling is remained from the first
+ * versions of the patch set that introduced the feature, see commit
+ * v4.13-rc1~212^2~51.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
diff --git a/tools/include/uapi/linux/fcntl.h b/tools/include/uapi/linux/fcntl.h
index 1d33835..1f97b33 100644
--- a/tools/include/uapi/linux/fcntl.h
+++ b/tools/include/uapi/linux/fcntl.h
@@ -58,7 +58,7 @@
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
  */
-#define RWF_WRITE_LIFE_NOT_SET	0
+#define RWH_WRITE_LIFE_NOT_SET	0
 #define RWH_WRITE_LIFE_NONE	1
 #define RWH_WRITE_LIFE_SHORT	2
 #define RWH_WRITE_LIFE_MEDIUM	3
@@ -66,6 +66,13 @@
 #define RWH_WRITE_LIFE_EXTREME	5
 
 /*
+ * The originally introduced spelling is remained from the first
+ * versions of the patch set that introduced the feature, see commit
+ * v4.13-rc1~212^2~51.
+ */
+#define RWF_WRITE_LIFE_NOT_SET	RWH_WRITE_LIFE_NOT_SET
+
+/*
  * Types of directory notifications that may be requested.
  */
 #define DN_ACCESS	0x00000001	/* File accessed */
-- 
2.1.4

