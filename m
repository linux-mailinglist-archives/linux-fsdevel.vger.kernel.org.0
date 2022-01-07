Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C4D48784B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 14:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347614AbiAGNiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 08:38:25 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50226 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238475AbiAGNiY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:38:24 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 34A5321115;
        Fri,  7 Jan 2022 13:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641562703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ly1qWDMyzaC9LSjWtQrvzZF4gUZP1qfdd/b/C0c1M4=;
        b=cCl5fFhI+LwE6v389Eki8Fgw4d9hux1WeGjY85cikjygjb4gjKKob+lwYHzsNOFeGdvSnk
        Ez1gA6g2aBOi4dxGm7hFn6NG30z5Z1wH1EQ7eqN6pHhBmMSt1lqUXULhVUTWs8IEDXwBDk
        zXRp19RedPMHW1uRjQiQqjmUDQNyJEI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641562703;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ly1qWDMyzaC9LSjWtQrvzZF4gUZP1qfdd/b/C0c1M4=;
        b=HQSNZqVUH1pbY+34kDStkqoIdVL9AU10gn3GHzMSgXGKAK1RrpWuxSNEnMICM0yQOd2mjd
        /TXBRDgJnwRjkODg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F2171A3B87;
        Fri,  7 Jan 2022 13:38:22 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Martin Wilck <mwilck@suse.com>, viro@zeniv.linux.org.uk,
        willy@infradead.org, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v6 1/6] initramfs: refactor do_header() cpio magic checks
Date:   Fri,  7 Jan 2022 14:38:09 +0100
Message-Id: <20220107133814.32655-2-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220107133814.32655-1-ddiss@suse.de>
References: <20220107133814.32655-1-ddiss@suse.de>
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
Reviewed-by: Martin Wilck <mwilck@suse.com>
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

