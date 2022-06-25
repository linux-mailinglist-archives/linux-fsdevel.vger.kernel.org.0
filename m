Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF1D55A929
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Jun 2022 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbiFYLBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Jun 2022 07:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbiFYLBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Jun 2022 07:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C9233E3C;
        Sat, 25 Jun 2022 04:01:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63BE7B80813;
        Sat, 25 Jun 2022 11:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F18C3411C;
        Sat, 25 Jun 2022 11:01:36 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="k9rAARxa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656154896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+cNHKtE95GsFoHDL/3ALQ8YKwfdHzX/1d4YROHsMAlI=;
        b=k9rAARxajcZIvLi0y0ATSswbnRVwSp0pTuV6nJSIHtuOc8Lt+5GEf3+Ujzf1HeBRKW1E7R
        +vETWoYEBtNuUEuroW0ue84N2/HSfCN6df7aM8pylcrcTKlcu3l8i+DDbKxRhc+30FIesp
        +sswK9/vwFiPYBATVwpSoCs1VFcGm3c=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 010d61fa (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 25 Jun 2022 11:01:36 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v2 5/8] fs: do not compare against ->llseek
Date:   Sat, 25 Jun 2022 13:01:12 +0200
Message-Id: <20220625110115.39956-6-Jason@zx2c4.com>
In-Reply-To: <20220625110115.39956-1-Jason@zx2c4.com>
References: <20220625110115.39956-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now we can rely on llseek being functional (via vfs_llseek) if
FMODE_LSEEK is set, so remove the old broken comparisons.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/coredump.c          | 4 ++--
 fs/overlayfs/copy_up.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..9f4aae202109 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -816,9 +816,9 @@ static int __dump_skip(struct coredump_params *cprm, size_t nr)
 {
 	static char zeroes[PAGE_SIZE];
 	struct file *file = cprm->file;
-	if (file->f_op->llseek && file->f_op->llseek != no_llseek) {
+	if (file->f_mode & FMODE_LSEEK) {
 		if (dump_interrupted() ||
-		    file->f_op->llseek(file, nr, SEEK_CUR) < 0)
+		    vfs_llseek(file, nr, SEEK_CUR) < 0)
 			return 0;
 		cprm->pos += nr;
 		return 1;
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 714ec569d25b..022606c9703b 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -226,8 +226,7 @@ static int ovl_copy_up_data(struct ovl_fs *ofs, struct path *old,
 	/* Couldn't clone, so now we try to copy the data */
 
 	/* Check if lower fs supports seek operation */
-	if (old_file->f_mode & FMODE_LSEEK &&
-	    old_file->f_op->llseek)
+	if (old_file->f_mode & FMODE_LSEEK)
 		skip_hole = true;
 
 	while (len) {
-- 
2.35.1

