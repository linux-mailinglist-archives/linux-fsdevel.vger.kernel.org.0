Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B0072913D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 09:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbjFIHeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 03:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbjFIHeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:34:15 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62A4208;
        Fri,  9 Jun 2023 00:33:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso9139275e9.0;
        Fri, 09 Jun 2023 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686295969; x=1688887969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uO3UG4+Z6opg2/A9PFDYgyDAt4Y8Slu198NJmKbuNeA=;
        b=sZqxxQoYox0LsWjsJIoBKDKbvxMlJQn9wGzkn9fkKVD39s6ChShmepxAlrmWNps2w1
         VR7lowhdwctHGk4bFPHeksgBcSfw8dHOU9TygPFcdYl4kkitzvJtWQYJrMfem0Sfjpcl
         w2loKyk0cYEuCZwwv82IeKvdtCB1ZXiMYGBhKqr+iPrKjwG57Sp2B2Q6e/o5m+kZKWrs
         BSlknxKEjNfM0qx7Ook48FNDiPU7dCnOPXTA4JWFuCZvcnIeif2twFittT5kP3uDk1Fz
         YOOuaxLbeZKszKV3IZiZm4JKqiSeG2jrW2YzVuAoYU1tFEXBngOh1i+uCwKzw8AtofHJ
         axhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686295969; x=1688887969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uO3UG4+Z6opg2/A9PFDYgyDAt4Y8Slu198NJmKbuNeA=;
        b=Z8Gm31D58pZTC+tG4qr11Pio1y3Oh0eqSYfYdyUVUlSc+BCf2rS5Bc1vndb4d7T4K4
         FViYGoehFb5Yh0UtRnnjKb1pS6Arwq4oZWc5sZu107VPlFIaZtOglVTfZeT2P9pm+4r8
         woJoNMRjZ96sbVk8/u0lH4Vv+fDEVbA8dzJhToKNOtmEW8dn33hG1+WVfAXvnQZpEx6e
         64fF5oNbbR3ud81owBjDkwtVaFCFq4alaGhn/sFvKoIPKrpSjeYk4Go8sxZlg+gwRbVI
         yx/9p5tyDHLmQwevRzejeuXhX3BQT4L8S/xW54ZKgS0JTG+Abb1q4CE7Ethfid500bt4
         Bicg==
X-Gm-Message-State: AC+VfDwXJb/jEpSNTys1Lwy7+qOFXgRrgawYzrZDWRFH1FMI0QFCiK4b
        6wZLuhQazBe5QO0Wt3CE4uM=
X-Google-Smtp-Source: ACHHUZ5vHrxSrE+0EClUjymnoWrvU3CKOs63mXU2NidAxXSbkTP1X9InUdVoZBk+Y4h4ukH3DXns8w==
X-Received: by 2002:adf:ef4e:0:b0:307:869c:99ce with SMTP id c14-20020adfef4e000000b00307869c99cemr791841wrp.21.1686295969362;
        Fri, 09 Jun 2023 00:32:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id a3-20020a056000050300b003068f5cca8csm3624528wrf.94.2023.06.09.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 00:32:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 3/3] fs: store fake path in file_fake along with real path
Date:   Fri,  9 Jun 2023 10:32:39 +0300
Message-Id: <20230609073239.957184-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609073239.957184-1-amir73il@gmail.com>
References: <20230609073239.957184-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Instead of storing only the fake path in f_path, store the real path
in f_path and the fake path in file_fake container.

Call sites that use the macro file_fake_path() continue to get the fake
path from its new location.

Call sites that access f_path directly will now see the overlayfs real
path instead of the fake overlayfs path, which is the desired bahvior
for most users, because it makes f_path consistent with f_inode.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/open.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c9e2300a037d..4f4e7534f515 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1120,11 +1120,11 @@ struct file *open_with_fake_path(const struct path *fake_path, int flags,
 				 const struct path *path,
 				 const struct cred *cred)
 {
-	struct file *f = alloc_empty_file_fake(NULL, flags, cred);
+	struct file *f = alloc_empty_file_fake(fake_path, flags, cred);
 	if (!IS_ERR(f)) {
 		int error;
 
-		f->f_path = *fake_path;
+		f->f_path = *path;
 		error = do_dentry_open(f, d_inode(path->dentry), NULL);
 		if (error) {
 			fput(f);
-- 
2.34.1

