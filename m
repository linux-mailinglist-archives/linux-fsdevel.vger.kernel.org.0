Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 064DC189156
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 23:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbgCQW0g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 18:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:36022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgCQW0e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:26:34 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B1D9206EC;
        Tue, 17 Mar 2020 22:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584483993;
        bh=ruAtG9OxH76MhNcvwQuEEuxDpapB8Yb60Ewf5Z6KY9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FubgHNMBIChYitg84Ouu0Y2BlbThhHKw1V0xhINPSPl4hbTE8Q3g9AHahsgwbzjmX
         h1ILtCfFnYPJyFxFSVoQDle6uTzW0QyZ5aamP1C14rtW1gnuVfaUxHclx1UOXBweqA
         D+vHA+CzyuJWN6Ts3mxh6IDvJfI5SWY7S43Kyuvg=
Received: by pali.im (Postfix)
        id C4491125D; Tue, 17 Mar 2020 23:26:31 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] exfat: Fix discard support
Date:   Tue, 17 Mar 2020 23:25:55 +0100
Message-Id: <20200317222555.29974-5-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317222555.29974-1-pali@kernel.org>
References: <20200317222555.29974-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Discard support was always unconditionally disabled. Now it is disabled
only in the case when blk_queue_discard() returns false.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/exfat/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 16ed202ef527..30e914ad17b5 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -531,10 +531,11 @@ static int exfat_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (opts->discard) {
 		struct request_queue *q = bdev_get_queue(sb->s_bdev);
 
-		if (!blk_queue_discard(q))
+		if (!blk_queue_discard(q)) {
 			exfat_msg(sb, KERN_WARNING,
 				"mounting with \"discard\" option, but the device does not support discard");
-		opts->discard = 0;
+			opts->discard = 0;
+		}
 	}
 
 	sb->s_flags |= SB_NODIRATIME;
-- 
2.20.1

