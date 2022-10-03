Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3200E5F303C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiJCMWM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJCMWK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:22:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6CC36425;
        Mon,  3 Oct 2022 05:22:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u16-20020a05600c211000b003b5152ebf09so8927755wml.5;
        Mon, 03 Oct 2022 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=95pD3kUkfrwjBpMlRxRAZrJWP3np9vHScnVl0JeavSM=;
        b=S3RK1UemlCpEx4SIplIBEBJlSsndlMDsbhd2iGpWkBXvyrXmadBAVhyAae6yBChNA/
         oq7UvkbG83O7OpAMQQK2ei5oGEqGo2qpfCfcIG9lARQSric1W7kjA7oETsuftyKHQrHH
         fS8Nc+NncxcYdMSaRL2a6MJv4bxWoxf9aXc/lnQRk54agX6ZANVBrVjQG66bK3p+mzfS
         8C8pRk91HUhr+2T1W4TWqHJrdyyQcXDHEgCOSX02rOvlFZqf3F058W2g2aLmznnJwMW9
         IotzP9CJV6EPzHVTOjTfGFLd+1ProcPedCVAJUK/4TIZzhrWpnNKuTrxLgHWeLE1+GV1
         IC0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=95pD3kUkfrwjBpMlRxRAZrJWP3np9vHScnVl0JeavSM=;
        b=Wh8bNBtNLeyWbXJjrNmKenmwkSNg+DELG8AILqMQqc1vmKEg0QN+oGm2W7S9YpZoF4
         NF+MToYFNkQvIFPZqi/ZGEECduK1BRbaVI57RjnJhJm/WQm++U+BCCGgbgs9MviuXCTd
         XN3TIWhWE3tA+7pc+aj+/HLXwCVfKyABJ/8Rri0IRgUi8kN+Pwt5FB6LalfTEwUL89wi
         bXo3egfjD1DtlgmaQ7SqsxnTfYAI+97eStQUcqLSKpE8glPojmjbcz0CqfgCX6rR7Rjm
         tYJ8qIxyO5hkmvjAtxcCdV4hgAVqTGnJo0mnGNsNVd6+wY2uaQvTP/XeapU8rXTfXg2a
         VJ9Q==
X-Gm-Message-State: ACrzQf39eqAoeILK6PhimtrPR7P+Y0L2SqBiqchsyEcyZskR0lCrBeMK
        t8fsIGZnFD/xUMmkVqWc8vY=
X-Google-Smtp-Source: AMsMyM7vKDdXNNDwxHCMD72gLcXSRsgldGkiDgvAlvIjBuHWs0zas//hsV+lEr2BvO97/0ydtAcqJQ==
X-Received: by 2002:a05:600c:214e:b0:3b4:709b:b0d with SMTP id v14-20020a05600c214e00b003b4709b0b0dmr6969596wml.4.1664799725601;
        Mon, 03 Oct 2022 05:22:05 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id v11-20020a05600c444b00b003a682354f63sm16983387wmn.11.2022.10.03.05.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:22:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.com>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
Date:   Mon,  3 Oct 2022 15:21:54 +0300
Message-Id: <20221003122154.900300-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003122154.900300-1-amir73il@gmail.com>
References: <20221003122154.900300-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Underlying fs doesn't remove privs because fallocate is called with
privileged mounter credentials.

This fixes some failure in fstests generic/683..687.

Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c8308da8909a..e90ac5376456 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -517,9 +517,16 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 	const struct cred *old_cred;
 	int ret;
 
+	inode_lock(inode);
+	/* Update mode */
+	ovl_copyattr(inode);
+	ret = file_remove_privs(file);
+	if (ret)
+		goto out_unlock;
+
 	ret = ovl_real_fdget(file, &real);
 	if (ret)
-		return ret;
+		goto out_unlock;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
 	ret = vfs_fallocate(real.file, mode, offset, len);
@@ -530,6 +537,9 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 
 	fdput(real);
 
+out_unlock:
+	inode_unlock(inode);
+
 	return ret;
 }
 
-- 
2.25.1

