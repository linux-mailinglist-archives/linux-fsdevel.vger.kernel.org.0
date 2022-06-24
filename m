Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25862559EF0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jun 2022 19:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiFXQ5N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jun 2022 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFXQ5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jun 2022 12:57:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12D453A4D;
        Fri, 24 Jun 2022 09:57:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D08E62330;
        Fri, 24 Jun 2022 16:57:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18816C34114;
        Fri, 24 Jun 2022 16:57:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="It7M6k85"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656089823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8LuQtGWAn0RhiR1wyaxvQfmjyDvl78geshXY45CC8MY=;
        b=It7M6k85D3/YcZVekD0YNZcu95KBdFc7b5tlQAN98srEf/Z60KR8gR76F2dfua++ik636Q
        +o0OyXD60CH4Q2eU79Gb69AbANjwgU/yZk83h/nhqirrrio4mIBCNIZkKi1zkZO0j/aZtd
        7Soc3zB4jl0DVRBxZGewc0AiosjdHxU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fe6b1642 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 24 Jun 2022 16:57:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 3/6] fs: clear FMODE_LSEEK if no llseek function
Date:   Fri, 24 Jun 2022 18:56:28 +0200
Message-Id: <20220624165631.2124632-4-Jason@zx2c4.com>
In-Reply-To: <20220624165631.2124632-1-Jason@zx2c4.com>
References: <20220624165631.2124632-1-Jason@zx2c4.com>
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

This helps unify a longstanding wart where FMODE_LSEEK hasn't been
uniformly unset when it should be.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 fs/file_table.c | 2 ++
 fs/open.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/fs/file_table.c b/fs/file_table.c
index 5424e3a8df5f..15700b2e1b53 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -241,6 +241,8 @@ static struct file *alloc_file(const struct path *path, int flags,
 	if ((file->f_mode & FMODE_WRITE) &&
 	     likely(fop->write || fop->write_iter))
 		file->f_mode |= FMODE_CAN_WRITE;
+	if ((file->f_mode & FMODE_LSEEK) && !file->f_op->llseek)
+		file->f_mode &= ~FMODE_LSEEK;
 	file->f_mode |= FMODE_OPENED;
 	file->f_op = fop;
 	if ((file->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ)
diff --git a/fs/open.c b/fs/open.c
index 1d57fbde2feb..07c332753a36 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -858,6 +858,8 @@ static int do_dentry_open(struct file *f,
 	if ((f->f_mode & FMODE_WRITE) &&
 	     likely(f->f_op->write || f->f_op->write_iter))
 		f->f_mode |= FMODE_CAN_WRITE;
+	if ((f->f_mode & FMODE_LSEEK) && !f->f_op->llseek)
+		f->f_mode &= ~FMODE_LSEEK;
 	if (f->f_mapping->a_ops && f->f_mapping->a_ops->direct_IO)
 		f->f_mode |= FMODE_CAN_ODIRECT;
 
-- 
2.35.1

