Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E49B64EDE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiLPP10 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiLPP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:07 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8662EBE
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4E01D5D115;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQv6iX4a7FDX4R4LhucfEvyfyk17l+uCwS8OIKW5df8=;
        b=YolMirsqYU9jcYdQHcGbZIAGuvSAyh21pNIO4UoMNz2PSxp50OozGeL2iZH0q+v2epzcP6
        +WRHqbOv+6Nni1Ybii9oXiW6yRwo1oYha6vh4pe/+aVo7qSamB0JkHvd/31DeGBMkE93v0
        4I4PWmOIKDITHq+q+PG4pESU2FaR6eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wQv6iX4a7FDX4R4LhucfEvyfyk17l+uCwS8OIKW5df8=;
        b=7gATxHTmjXnhfWFIPH240s2h9xSpIn5UmQcruo966TmZ0WmWqjeqpTIqEmIIYHI0s6qeJc
        /csihYi/vJOowOAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D486138FD;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3r0iB0aOnGPPCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8F19A076C; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 10/20] udf: Provide function to mark entry as deleted using new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:14 +0100
Message-Id: <20221216152656.6236-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=jack@suse.cz; h=from:subject; bh=zdAD4LCzmFx7pl7CUssn1kricp9GmMLV7xBojcNvuFA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBjnI2evx4Pr0ZEU6GIHSHTrC6a3nlYOh3MFJPb+1XK WjuisWuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCY5yNngAKCRCcnaoHP2RA2ZkQB/ 9lX7XLupfbMFghAknpDTnV1pFLIxIyAl2a/hShZFASX+XjCl0o04d6L5F/dbIDH8kwE8RyAyyghhTI XmgOuKn9W4mVZlIcDI9XRbJDtT1HuYOo+HipucvUnXbU0USxe2bH28oLorAz0TTqbmRzOlUV8xT5U7 6E9TMK88eKkCEZGpqu6hhPxFig1CCbE3PXKJFNuWdrJ7SjI/mj7L5ON9q+I6awSW+Dv0+RbPq7Fhdp /UT0J+qpcm57Z/yYBGu01iCM9/JiMP6EiPLY74UNDrNaqZMLkpF6g3l7guevEnFMnuO1siJMZAqH7x JEaFIU6/vPftOHdspY6T+TFH5v87mV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide function udf_fiiter_delete_entry() to mark directory entry as
deleted using new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 964ac7d4e274..f38ed9c1b54d 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -711,6 +711,16 @@ static struct fileIdentDesc *udf_add_entry(struct inode *dir,
 	return fi;
 }
 
+static void udf_fiiter_delete_entry(struct udf_fileident_iter *iter)
+{
+	iter->fi.fileCharacteristics |= FID_FILE_CHAR_DELETED;
+
+	if (UDF_QUERY_FLAG(iter->dir->i_sb, UDF_FLAG_STRICT))
+		memset(&iter->fi.icb, 0x00, sizeof(struct long_ad));
+
+	udf_fiiter_write_fi(iter, NULL);
+}
+
 static int udf_delete_entry(struct inode *inode, struct fileIdentDesc *fi,
 			    struct udf_fileident_bh *fibh,
 			    struct fileIdentDesc *cfi)
-- 
2.35.3

