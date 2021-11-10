Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC95144C171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 13:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhKJMmA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 07:42:00 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:40974 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbhKJMl5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 07:41:57 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C7B3C21B18;
        Wed, 10 Nov 2021 12:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636547948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qENyzIuIN1u61AS2jmcBV7xPRnnZIKHxYvSLP/WzXg=;
        b=H/jI1YC4du0RQg+YOVFlnVfTdX3tajhDk14KAxckROftRU+Hh21NvdfQquvzcm7fi/w4RM
        7c3zfewOj9QE3sMahA6PM8uXgz1dvwDtq+G82EQeJEsOrhU1KLE+XiTmXpfOCgS6ndswZp
        MkA3eOcb7vS3Bh/7f886r0+ckR2cGx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636547948;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qENyzIuIN1u61AS2jmcBV7xPRnnZIKHxYvSLP/WzXg=;
        b=xLGzI4YACEaTGMW4CG+o6gLfg1+txPqMDeO4MmpCjlaSU5l4tv5PWS8hQ77Yw9VlHQP/l5
        EPs25gX3Xzx+kSBQ==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 94BC2A3B81;
        Wed, 10 Nov 2021 12:39:08 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 1/4] initramfs: refactor do_header() cpio magic checks
Date:   Wed, 10 Nov 2021 13:38:47 +0100
Message-Id: <20211110123850.24956-2-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211110123850.24956-1-ddiss@suse.de>
References: <20211110123850.24956-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

do_header() is called for each cpio entry and fails if the first six
bytes don't match "newc" magic. The magic check includes a special case
error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
special case POSIX.1 check can be nested under the "newc" mismatch code
path to avoid calling memcmp() twice in a non-error case.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 init/initramfs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 2f3d96dc3db6..2f79b3ec0b40 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -257,12 +257,11 @@ static int __init do_collect(void)
 
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
2.31.1

