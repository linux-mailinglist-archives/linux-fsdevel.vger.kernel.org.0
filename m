Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E88A3D0E86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 14:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236964AbhGULXV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 07:23:21 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:52252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbhGULMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 07:12:43 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1709120322;
        Wed, 21 Jul 2021 11:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1626868321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oheTBrlOPmKCC8KCnUKF7tUM9F2teFLgWY0LPZQFvyQ=;
        b=JG2CNnzRKzqNaPCAB1wlKP5URh163B744KaUL/U0/JPyqqRy8NEqkzU+OEy963L6NrpQGa
        rZPNmVOYnBxSP15watS9bVDehn2kmUQrO4mVrwvDUhN8tSX3s8ZjQxBU7EZCuCl7dHYfMC
        s8PwR4gcrATfjdTOWifcQ9xW0Gx1sv8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1626868321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=oheTBrlOPmKCC8KCnUKF7tUM9F2teFLgWY0LPZQFvyQ=;
        b=kmatwo2zbfQ7hPJBs+r5BZgdiw6b46V0ihR4xKRW/vVm+2cRlzt5jfp9bU52JbDTRTJ9NA
        bmheqP//0XTMWmBg==
Received: from echidna.suse.de (unknown [10.163.26.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C6D19A3B88;
        Wed, 21 Jul 2021 11:52:00 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH RESEND 1/3] initramfs: move unnecessary memcmp from hot path
Date:   Wed, 21 Jul 2021 13:51:51 +0200
Message-Id: <20210721115153.28620-1-ddiss@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_header() is called for each cpio entry and first checks for "newc"
magic before parsing further. The magic check includes a special case
error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
special case POSIX.1 check needn't be done in the hot path, so move it
under the non-newc-magic error path.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index af27abc59643..f01590cefa2d 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -256,12 +256,11 @@ static int __init do_collect(void)
 
 static int __init do_header(void)
 {
-	if (memcmp(collected, "070707", 6)==0) {
-		error("incorrect cpio method used: use -H newc option");
-		return 1;
-	}
 	if (memcmp(collected, "070701", 6)) {
-		error("no cpio magic");
+		if (memcmp(collected, "070707", 6) == 0)
+			error("incorrect cpio method used: use -H newc option");
+		else
+			error("no cpio magic");
 		return 1;
 	}
 	parse_header(collected);
-- 
2.26.2

