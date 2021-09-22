Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261F414828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Sep 2021 13:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbhIVLyB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 07:54:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50776 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVLyA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 07:54:00 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 358BD201E9;
        Wed, 22 Sep 2021 11:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632311550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=axIV2Aaeicqox/fHORSsUBSw8MCPPCxxCoZiD3aru9k=;
        b=H3khMMnawKOYn6w1uZ7Hy4rkW/nhSWGb1a1UJ9G3Ht/IO/fOBZiv8fqVhLclJU33umoEVR
        j26/g7AUwLQAYq6RP+NykD6znlfh2Cm6bQswfah3N0SJHLNM12AC0AvQ3kuDiFYnE/s6bv
        TqjtuS6j/bjg0SGyHWKpKR8irEraXUw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632311550;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=axIV2Aaeicqox/fHORSsUBSw8MCPPCxxCoZiD3aru9k=;
        b=0fg7YVVjE3ZvJbQCkw2OdN8rXirE5QqjdqgfEywtc0G9wJzjyrnP1CE4aVFRBSXEPKdLMw
        qqfjSyosf+SEjgBg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EC46CA3BA0;
        Wed, 22 Sep 2021 11:52:29 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Date:   Wed, 22 Sep 2021 13:52:18 +0200
Message-Id: <20210922115222.8987-1-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
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
2.31.1

