Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDC057F9A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 11:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfF0JvB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 05:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39074 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbfF0JvB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 05:51:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0716830BB367;
        Thu, 27 Jun 2019 09:51:01 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-180.str.redhat.com [10.33.192.180])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20F185D71B;
        Thu, 27 Jun 2019 09:50:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Fix internal type confusion in getdents system calls
Date:   Thu, 27 Jun 2019 11:50:58 +0200
Message-ID: <878stnwe4d.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 09:51:01 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The callback functions use a signed int type, but the callers have
only verified the value as an unsigned type.  This should be only
a cosmetic change because if the value wraps around, this error
check catches it:

	if (reclen > buf->count)
		return -EINVAL;

But it should be clearer to prevent the wrap-around.

Signed-off-by: Florian Weimer <fweimer@redhat.com>
---
 fs/readdir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 2f6a4534e0df..d344061e387e 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -159,7 +159,7 @@ struct getdents_callback {
 	struct dir_context ctx;
 	struct linux_dirent __user * current_dir;
 	struct linux_dirent __user * previous;
-	int count;
+	unsigned int count;
 	int error;
 };
 
@@ -246,7 +246,7 @@ struct getdents_callback64 {
 	struct dir_context ctx;
 	struct linux_dirent64 __user * current_dir;
 	struct linux_dirent64 __user * previous;
-	int count;
+	unsigned int count;
 	int error;
 };
 
@@ -413,7 +413,7 @@ struct compat_getdents_callback {
 	struct dir_context ctx;
 	struct compat_linux_dirent __user *current_dir;
 	struct compat_linux_dirent __user *previous;
-	int count;
+	unsigned int count;
 	int error;
 };
 
-- 
2.21.0

