Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24BDD1CC58A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgEIXqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728129AbgEIXp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:45:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E46FC05BD09;
        Sat,  9 May 2020 16:45:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRA-77; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/20] fat_dir_ioctl(): hadn't needed that access_ok() for more than a decade...
Date:   Sun, 10 May 2020 00:45:39 +0100
Message-Id: <20200509234557.1124086-2-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

address is passed only to put_user() and copy_to_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/fat/dir.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index 054acd9fd033..b4ddf48fa444 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -804,8 +804,6 @@ static long fat_dir_ioctl(struct file *filp, unsigned int cmd,
 		return fat_generic_ioctl(filp, cmd, arg);
 	}
 
-	if (!access_ok(d1, sizeof(struct __fat_dirent[2])))
-		return -EFAULT;
 	/*
 	 * Yes, we don't need this put_user() absolutely. However old
 	 * code didn't return the right value. So, app use this value,
@@ -844,8 +842,6 @@ static long fat_compat_dir_ioctl(struct file *filp, unsigned cmd,
 		return fat_generic_ioctl(filp, cmd, (unsigned long)arg);
 	}
 
-	if (!access_ok(d1, sizeof(struct compat_dirent[2])))
-		return -EFAULT;
 	/*
 	 * Yes, we don't need this put_user() absolutely. However old
 	 * code didn't return the right value. So, app use this value,
-- 
2.11.0

