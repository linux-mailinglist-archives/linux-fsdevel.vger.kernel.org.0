Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026541EEC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 15:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353902AbhJANov (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 09:44:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42632 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352761AbhJANou (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:44:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5ADD22266F;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633095785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89I/GqU4jKbZ8oW6eMaU78Wbp+BG4tQO08Wgw9elk0E=;
        b=Pu14E9j1K9nZDi1Zw/I2GYYGxHLyZxDpEyxwMk3d+DOAyVYVlRiOwFI3dmZJH4cpetW72R
        dhEmEFjoYxIanAOEVxnldM5r0OkIrF6FZGbHih6C3evnRZzeUeR0zjFBLsMJFk38U/XlsR
        S+drfsttD/jMNjLkgis1l+Q6xtDVuBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633095785;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=89I/GqU4jKbZ8oW6eMaU78Wbp+BG4tQO08Wgw9elk0E=;
        b=3prTXzLIrTE8hjxomuUiS155QjxAPBa7kOKJ4PZIN7VfEeKThFb5W0yO2HRJKYZqqoiSCD
        0UQ58GK2J3mgjrAg==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3018BA3B88;
        Fri,  1 Oct 2021 13:43:05 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, willy@infradead.org,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v3 1/5] initramfs: refactor do_header() cpio magic checks
Date:   Fri,  1 Oct 2021 15:42:52 +0200
Message-Id: <20211001134256.5581-2-ddiss@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001134256.5581-1-ddiss@suse.de>
References: <20211001134256.5581-1-ddiss@suse.de>
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
index a842c0544745..6897994c60fb 100644
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

