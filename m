Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22BB6299AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Nov 2022 14:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKONJo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Nov 2022 08:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKONJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:09:43 -0500
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 05:09:41 PST
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D32B0B;
        Tue, 15 Nov 2022 05:09:41 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1668517431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uJ6lXtZtZ1sEYf/d5F93niJVu+vUIJKmF7MEG0yD42M=;
        b=CYUqVNxElFXbc7OLDSqcUxvFOmb5TBlIPRXRmhagE+PwL5GvO/olITDHKJ2e1ZsJP6+4I4
        PhykhIqUdLcVo7XSkbZ1aPgnNOOEP055A9MdffQi9WPR4RmAudnd9yyae2JxR0vXXTY1bJ
        C0ZRTAPrcRbwqlU4aTLkT7gf6AnYtks=
To:     David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        ldv-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] file: Added pointer check
Date:   Tue, 15 Nov 2022 16:03:51 +0300
Message-Id: <20221115130351.77351-1-arefev@swemel.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return value of a function 'affs_bread' is dereferenced at file.c:970
without checking for null, but it is usually checked for this function.

Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 fs/affs/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index d91b0133d95d..4566fa767f65 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -963,6 +963,8 @@ affs_truncate(struct inode *inode)
 
 	while (ext_key) {
 		ext_bh = affs_bread(sb, ext_key);
+		if (!ext_bh)
+			break;
 		size = AFFS_SB(sb)->s_hashsize;
 		if (size > blkcnt - blk)
 			size = blkcnt - blk;
-- 
2.25.1

