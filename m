Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4493731670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 13:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343822AbjFOLW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jun 2023 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjFOLWt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:22:49 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECE270E;
        Thu, 15 Jun 2023 04:22:48 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f64fb05a8aso10386974e87.0;
        Thu, 15 Jun 2023 04:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686828167; x=1689420167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtcK+MjYdgt5xdkH51XxFu0Rk4q4gitGQTSMk2pN95c=;
        b=Q5nCDzdwkUN02VMpgE3e7v0izLc1MKQloFXVNcaP5ug1pHAxMajcJVXs7+YhTu33dG
         BvFiq7Qybaq2OwFmzPyE0eysw5Y5+iY5cUh2SnzgLSz28PPc99pFRHuHOLxBWhlhEqS7
         2G2swaICGukhSi092XA6XfVFsCMvXe+HOWBW80FrT8nkYs902k4E3/v6DT8ypj8Kb2yO
         QFmzDDyerNzWGjyHl59fJz6ByZrGdmpXhLo89powOoHQJOcwhm+TY4sxsluJHhn0nWBJ
         73P7sBfC7xvOMcj0mRJ+WIrucwpMCxJU+gI/F4+n8goyOtCG7hll0kqG9IsCPfD1nnAd
         VXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686828167; x=1689420167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtcK+MjYdgt5xdkH51XxFu0Rk4q4gitGQTSMk2pN95c=;
        b=DztaQOAYFGY2ieyt3Iiu2kSfaQK1g57N+gTDe1bgHKJIzQyjDOLZtOa58dKteSBwlq
         TNrlHLH/41FhbUYYYC7VpNBOG/iCmt3fPczHSqVn00mm0a9PMmm2ude0UMyByQr+s+Qb
         u7tijsVRKnzwHnRhGugBLxHWgXCRN4RB08zylIuJ/MH5JKWIjmOV4ddDgRwevI/1f2G4
         1BQlXkl6ZuMErvn5UucRzj+yYbiquXGpVA3AsHqs+aeLGUlMXRuqBcdtWy3sTe9/Y3ZQ
         ih1acwK70uEMM9vf+QB2e/mtiPEoOPIdccHns3dw+ZhunvKdMFsF1GxnjZyQ04s7xHA1
         o8Vg==
X-Gm-Message-State: AC+VfDx5QMZ5ATx35IilSYkF8YzZfMz1xnPwdTRmFFdYRkmsRFWh0AQY
        XZtaVlgMEOBR874NL9+CdOY=
X-Google-Smtp-Source: ACHHUZ5099iEyEh/Kg7/Wfnc9H8S+EUZv6Sr9rMhZeuu6AFx//UBMXh8syEPsaUbvSItrBxGqBslxA==
X-Received: by 2002:a05:6512:534:b0:4f7:6a63:7555 with SMTP id o20-20020a056512053400b004f76a637555mr2412809lfc.16.1686828166850;
        Thu, 15 Jun 2023 04:22:46 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a197019000000b004f80f03d990sm355089lfc.259.2023.06.15.04.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 04:22:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v5 5/5] ovl: enable fsnotify events on underlying real files
Date:   Thu, 15 Jun 2023 14:22:29 +0300
Message-Id: <20230615112229.2143178-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230615112229.2143178-1-amir73il@gmail.com>
References: <20230615112229.2143178-1-amir73il@gmail.com>
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

Overlayfs creates the real underlying files with fake f_path, whose
f_inode is on the underlying fs and f_path on overlayfs.

Those real files were open with FMODE_NONOTIFY, because fsnotify code was
not prapared to handle fsnotify hooks on files with fake path correctly
and fanotify would report unexpected event->fd with fake overlayfs path,
when the underlying fs was being watched.

Teach fsnotify to handle events on the real files, and do not set real
files to FMODE_NONOTIFY to allow operations on real file (e.g. open,
access, modify, close) to generate async and permission events.

Because fsnotify does not have notifications on address space
operations, we do not need to worry about ->vm_file not reporting
events to a watched overlayfs when users are accessing a mapped
overlayfs file.

Acked-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c      | 4 ++--
 include/linux/fsnotify.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index c610ae35b0b9..cb53c84108fc 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,8 +34,8 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 		return 'm';
 }
 
-/* No atime modification nor notify on underlying */
-#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
+/* No atime modification on underlying */
+#define OVL_OPEN_FLAGS (O_NOATIME)
 
 static struct file *ovl_open_realfile(const struct file *file,
 				      const struct path *realpath)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bb8467cd11ae..6f6cbc2dc49b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -91,7 +91,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
-	const struct path *path = &file->f_path;
+	/* Overlayfs internal files have fake f_path */
+	const struct path *path = f_real_path(file);
 
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
-- 
2.34.1

