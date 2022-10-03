Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C845F3053
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Oct 2022 14:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiJCMaz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Oct 2022 08:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiJCMaw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:30:52 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494641D00;
        Mon,  3 Oct 2022 05:30:50 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a3so4233109wrt.0;
        Mon, 03 Oct 2022 05:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=95pD3kUkfrwjBpMlRxRAZrJWP3np9vHScnVl0JeavSM=;
        b=dY+6Xw/ujB3LBTYWSZT9lkX5gdVOGr1UM4R9BsYWNqvrmwFHtdyDZ53mgy/rDyUKuC
         WF5l1Zo+gyf/e8X+kxKkJzY5RHELupKp8so1GAAV+JNe3D9YUooRqQWpgJyNMbGSL2TK
         Wwa7rCez++sF9GmDBqyILd2wRVhHtavFikoAvAjJZbEL/xq5VPvYBPz/XQ+00GDxaDe1
         XTeeA5xAh1MrVvgq8y8oiktnwR/LDGLx2rAyzXHNDW9RAS5ZZtrCSSkJN6UaHdtT68S2
         4cUhB/tLYNPr8a7KwpBasAZzJhbWnd32OLdhmiMkwRd3ffHLiu5Dt86KNRboBKe4if7p
         XJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=95pD3kUkfrwjBpMlRxRAZrJWP3np9vHScnVl0JeavSM=;
        b=sso/7fBc3OcUVC/v2OjbeSqzpTpq//c1Dn8kzUziTibrLYf8Vi6fdA/ZPbXSo4Nmaa
         4B0+kQ9we/2+GGY8yPLaFBgutA/61miMwKoih5ut/ipG0qN07r5mH6Kx4LfyM0RmUgZr
         68MQU0N8T6kuGsl9axDnwlqMt1P22Rial/GctpgrOZ2CuxMKzSx9PIy/AujXCLF0iCHR
         uTMeeml7Yy2UwS0t+NGV1fyBfbqGDooKeA+PMIskiWhoL//VrOxmf5XjK8Er377W4ush
         tN3ZccDLPIkTAcm01V0UBFdLsLUKYLUvWuQmbSkhHrw2vNQ4ucNlX6Y44oaql+G21XEH
         jY+g==
X-Gm-Message-State: ACrzQf1rX6KTz9MHweM6dKKVTZ2tkg5g/GUR+nC7EQZi6MWlAdkzBf+r
        0ij9t9IhKPiAN6drg84vbSI=
X-Google-Smtp-Source: AMsMyM6vO78FnlnzKRt6zDuUYEZjtz2taLdEK1yCV2Avc0wB1Tr/NSIstA3a9cRf4CRTiQnAnT7Z4w==
X-Received: by 2002:a05:6000:2c1:b0:226:e816:b6a4 with SMTP id o1-20020a05600002c100b00226e816b6a4mr13510266wry.330.1664800249514;
        Mon, 03 Oct 2022 05:30:49 -0700 (PDT)
Received: from localhost.localdomain ([5.29.8.191])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c4e0e00b003b535ad4a5bsm11845392wmq.9.2022.10.03.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 05:30:48 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
Date:   Mon,  3 Oct 2022 15:30:40 +0300
Message-Id: <20221003123040.900827-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221003123040.900827-1-amir73il@gmail.com>
References: <20221003123040.900827-1-amir73il@gmail.com>
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

