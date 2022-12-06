Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C71643FE8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Dec 2022 10:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbiLFJcV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Dec 2022 04:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiLFJcS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:32:18 -0500
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C96A1D0CB;
        Tue,  6 Dec 2022 01:32:17 -0800 (PST)
From:   Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
        t=1670319133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oCm3OMZIxqZDVn064joCmMPgJl8SxdgvibLxjtPgDRU=;
        b=DS94TmjNMU2BFTBVqyYOH3lkLVGzP9hJzb/sgawSRJT87V5TWsNIyLhkcEwO2xcWM00wFW
        Ni39B6aoijZqlmnyFgSVoCDx5pz+hcx2CMvZffTDu1VLVZzN0e03VpDcRXAZBlKZiFYRXF
        p47FCC3wBoDb7UMvfrNqsWiZobD0qjA=
To:     David Sterba <dsterba@suse.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org, trufanov@swemel.ru, vfh@swemel.ru
Subject: [PATCH] file: Added pointer check
Date:   Tue,  6 Dec 2022 12:32:13 +0300
Message-Id: <20221206093213.29050-1-arefev@swemel.ru>
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

Found by Linux Verification Center (linuxtesting.org) with SVACE.

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

