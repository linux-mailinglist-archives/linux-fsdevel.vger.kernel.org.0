Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0FFE319943
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 05:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhBLEp1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 23:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhBLEpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 23:45:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC8BC0613D6
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id j5so5438515pgb.11
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Feb 2021 20:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uwr/8PJUNMrs1DNHiVxSJVanvT/KDCxxvdzqAMfX/20=;
        b=jDPV6GnSoh0tUu9SL3pV6ZNkNlrVV4nNS5weOpmxNEER4+qGUF4kuWbxGzf7zUe4Q6
         0fNbc8n6aPmawRsXKF60jjdrAlO3PQ6/lKXdvfCYNb1N+gAjmCFqexp/zw0kQUWuFKmo
         tsPTSYVURrDD1QkSKI9JBQAqmySDiCWcOQCeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uwr/8PJUNMrs1DNHiVxSJVanvT/KDCxxvdzqAMfX/20=;
        b=HagFaD67ZHokr6kiMsElOOFrBSmVaF5wwKnvMvcHplVL2h0O6Ameh1saJ1pptylRmf
         JQUfh3A6v44GkWRXEGdgU4ZnNpEwGGcb5r50vHZ6eYr1Djo7y8Pqbh6cYdyA46Jbi88y
         Om0MVsEcS78xsxrf5qkOH6VBiOHBbhQgkEaDh6HwkjuXu8sLYndgPzgjB8YBSh6znhMb
         zKC8qX76EqqSz6wxQwbPMvs4PpENu6gd/Eb9wAffcRFXxApnTm7ZKtrI5YH6Q0RudCck
         tnf1TCVUIlGmHJpzNNkLKf3Z0QzobNf2OoLUAVSOgQMMRL0yiEH2PxcZ74zwPh7cB71d
         zpWA==
X-Gm-Message-State: AOAM533XtPVHdHT1NROj/TXEKG62/IuO9V/Y+caqBBhB/IiaujHkBnd6
        WzD17PHjdKmN65RaDH8B4BgKlQ==
X-Google-Smtp-Source: ABdhPJzVzB2K3BQRHbHlI8qUm7OdSQAl5fNCAIJBHSDbPKSvTVB19WkYz5J5ZvETG1Vuz0V/f25kmg==
X-Received: by 2002:a63:1965:: with SMTP id 37mr1468628pgz.349.1613105084885;
        Thu, 11 Feb 2021 20:44:44 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:a453:d6cd:41b9:5925])
        by smtp.gmail.com with ESMTPSA id 25sm7298904pfh.199.2021.02.11.20.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 20:44:44 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     "Darrick J . Wong" <djwong@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] fs: Add flag to file_system_type to indicate content is generated
Date:   Fri, 12 Feb 2021 12:44:00 +0800
Message-Id: <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
In-Reply-To: <20210212044405.4120619-1-drinkcat@chromium.org>
References: <20210212044405.4120619-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Filesystems such as procfs and sysfs generate their content at
runtime. This implies the file sizes do not usually match the
amount of data that can be read from the file, and that seeking
may not work as intended.

This will be useful to disallow copy_file_range with input files
from such filesystems.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
---
I first thought of adding a new field to struct file_operations,
but that doesn't quite scale as every single file creation
operation would need to be modified.

 include/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 3482146b11b0..5bd58b928e94 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2335,6 +2335,7 @@ struct file_system_type {
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
 #define FS_THP_SUPPORT		8192	/* Remove once all fs converted */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+#define FS_GENERATED_CONTENT	65536	/* FS contains generated content */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
 	struct dentry *(*mount) (struct file_system_type *, int,
-- 
2.30.0.478.g8a0d178c01-goog

