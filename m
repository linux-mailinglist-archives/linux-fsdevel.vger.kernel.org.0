Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E7A4EEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2019 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbfFUSoZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 14:44:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:16899 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFUSoY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 14:44:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1561142662;
        s=strato-dkim-0002; d=pinc-software.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=UipmIdlTqQ9PzhNLIRvIbIptfED4ilmnLRnrv6Son8s=;
        b=HDGKV1ySewXaPCd28lY71x5VWYgwg0myuryAJuG12bQEm7ry4r0LD9Aso2k39bOsM/
        MbAtu1UFW0SiWYzUmOk8KyRyQQUeFyKdCVl7YX/oQueobxKfFcSuIimymlEpVnJXadXP
        Ha56t3yw8BvZGRPaVYms7PhYZo7wEbNQ/4fM8jntYd54gw3Va/oa5tkpMDjhKvI+/SfJ
        sG0IAL6V2CHhBheQw0kdFqcVRH64Qy/+cDcsfkRJBFc29luYR/TatNOVK65qpUeakKM7
        lGpqVM2OkBeeqgXLOlJ54h8iEx1dzlEGZf08ql/oU19hhiEcFgt882553FYtUFGZI0xM
        z/wQ==
X-RZG-AUTH: ":LXQBeUSIa/ZoedDIRs9YOPxY4/Y41LMYtYgA+S704F0fcsNycI1rqp7htm44FTK51uMij61Yqhw="
X-RZG-CLASS-ID: mo00
Received: from localhost
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id z087d6v5LIiMRc9
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Fri, 21 Jun 2019 20:44:22 +0200 (CEST)
From:   =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
To:     Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Axel=20D=C3=B6rfler?= <axeld@pinc-software.de>
Subject: [PATCH RESEND] befs: Removed incorrect check
Date:   Fri, 21 Jun 2019 20:44:18 +0200
Message-Id: <20190621184418.15614-1-axeld@pinc-software.de>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The relation between ag_shift and blocks_per_ag is a bit more complex,
and also depends on the fs block size.
Since blocks_per_ag is not even being used, simply omit the check.

Signed-off-by: Axel Dörfler <axeld@pinc-software.de>
---
 fs/befs/super.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/befs/super.c b/fs/befs/super.c
index 7c50025c99d8..29fa37557656 100644
--- a/fs/befs/super.c
+++ b/fs/befs/super.c
@@ -99,13 +99,6 @@ befs_check_sb(struct super_block *sb)
 		return BEFS_ERR;
 	}
 
-
-	/* ag_shift also encodes the same information as blocks_per_ag in a
-	 * different way, non-fatal consistency check
-	 */
-	if ((1 << befs_sb->ag_shift) != befs_sb->blocks_per_ag)
-		befs_error(sb, "ag_shift disagrees with blocks_per_ag.");
-
 	if (befs_sb->log_start != befs_sb->log_end ||
 	    befs_sb->flags == BEFS_DIRTY) {
 		befs_error(sb, "Filesystem not clean! There are blocks in the "
-- 
2.17.1

