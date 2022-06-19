Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C9B550814
	for <lists+linux-fsdevel@lfdr.de>; Sun, 19 Jun 2022 05:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiFSDee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 23:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiFSDec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 23:34:32 -0400
X-Greylist: delayed 903 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Jun 2022 20:34:28 PDT
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04589E0A8
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Jun 2022 20:34:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1655608753; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BGdWtsxVkAJrfRdGeNS8uzf0sacHcgtJXo3V3ayg3B9RdLeT/yqHQSiQTGyx+ku7NvA61rLVnuBrz/b13iVCo1suJ2fpd3t+X2EWIs85K0TSxKwNggtc/9+DX1cO8IBCBSj6ooeUS3CtSLpUV8Pi3e69MNdLeZtmBZYYqjhHvHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1655608753; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=K31raOFRmm5EutGOWfSlrYv9RrOZleh/ZyaQ262yQTI=; 
        b=BWd+9xTIHD1WExPEvjwFwUZ2eCFtlrnBBo5wFQtuR5QMvqXFIzgoJqgmGVb3OHLa3aw0rT4bVRJoyLhSjFKTG/YbXY6gIvykD0aaT6em2s59ZnCrjgE3EgL+5dJx6Ma1fsUYOgIeMcgbKFNT4hCjWQoH3BH//WmVmxknTkZeHz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1655608753;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=K31raOFRmm5EutGOWfSlrYv9RrOZleh/ZyaQ262yQTI=;
        b=OMZZZ8SB+4LkieDY6nNDX8CyhfGvoYEVebRgNA5j46VgGQEs6QqxKqyN0uTiXWnN
        qLgssKw6kozRXvoNqaf6tmoHDnXeUXrlNAxsIzUu8Sjr8rCSRKkEnfDDuV5UECtUYpM
        W1Cl8Qzu0dQXre4nfudHK4e38wc56hP1arWtXrqc=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1655608751552267.86709799681773; Sat, 18 Jun 2022 20:19:11 -0700 (PDT)
Date:   Sat, 18 Jun 2022 20:19:11 -0700
From:   Li Chen <me@linux.beauty>
To:     "Alexander Viro" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel" <linux-fsdevel@vger.kernel.org>
Message-ID: <18179f8b59d.b7fe20f5281387.193977444358758943@linux.beauty>
In-Reply-To: 
Subject: [PATCH] fs: use call_read_iter(file, &kiocb, &iter); for
  __kernel_{read|write}
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Just use these helper functions to replace f_op->{read,write}_iter()

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 fs/read_write.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index b1b1cdfee9d3..9518aeca0273 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -437,7 +437,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos)
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, READ, &iov, 1, iov.iov_len);
-	ret = file->f_op->read_iter(&kiocb, &iter);
+	ret = call_read_iter(file, &kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
 			*pos = kiocb.ki_pos;
@@ -533,7 +533,7 @@ ssize_t __kernel_write(struct file *file, const void *buf, size_t count, loff_t
 	init_sync_kiocb(&kiocb, file);
 	kiocb.ki_pos = pos ? *pos : 0;
 	iov_iter_kvec(&iter, WRITE, &iov, 1, iov.iov_len);
-	ret = file->f_op->write_iter(&kiocb, &iter);
+	ret = call_write_iter(file, &kiocb, &iter);
 	if (ret > 0) {
 		if (pos)
 			*pos = kiocb.ki_pos;
-- 
2.36.1


