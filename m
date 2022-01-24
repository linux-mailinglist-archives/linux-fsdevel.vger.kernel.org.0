Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C63749882A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jan 2022 19:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245181AbiAXSUE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jan 2022 13:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245189AbiAXSUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:20:02 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C654C06173B;
        Mon, 24 Jan 2022 10:20:02 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id g2so16118316pgo.9;
        Mon, 24 Jan 2022 10:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OV/KakYBUwiYtspMCEnyhQi3Nwwqu8YQJvyXMpbEBCE=;
        b=nc9DDY2ts77US2x1jGKsIIYBnX38A+eaMHKVdn175fL11NhRLvEwFKFVJaZ/CrtMwm
         sAXP5xXaC7+Wae9nSdS3UocXVjRvNJ91dzDMBAq0M5ExxTihnvgsLmvLlnWP9Pim9pM3
         fN7l6e/yscTJ+7PieUQisdaiU3lFhP42w2q9lfur7vvwFy8Cc7Evh3Rsd3gLVjcYt/nE
         Cd3H4ujrZqiK62dUy7OWnDtUazwPFngKvZApSRWgHOVjOR2QwZwSEyCDx7jfo8hE6gKD
         48JtltV2fddEDXBzyN5QFevriucNFVGW9fuksi12XFV10kjyt1YjWsFpYArBJUBbal2a
         HSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OV/KakYBUwiYtspMCEnyhQi3Nwwqu8YQJvyXMpbEBCE=;
        b=CzFbsMUzr9Pyrr5KorllifzTcVbTOBGonhSKDAbBuSorzRdYf7pM/oKeksJVhvzXOz
         9db0bpX7XOBQTbI29T8K/6ONY2NPiOrqdQt5v6AbH+KY0J3zJDFagomOlbXdrz2Iak+l
         FvGWnpu+5PW5kOkXttN/rSucuRvVUW1tmL+UzWGD3IrBbCvq8EjZk8nkxIUpvY+gNi0/
         r1EYRcwtGAKqWhYaX97StoVkA3sh/Er5SFODPPIhKm2j01P+KZLWVH6iBuHUyBMroH0I
         S6EeLqW0CGkGF3JPIyjPN93ID3cq/u3wU5ncBzyax1VS60knU6coPWsr8nwHpL2Wbz7J
         05hA==
X-Gm-Message-State: AOAM531rbOGhzijgCVbeES0cuoYLLyUw1zoS/QaX3CoHZNPakiBrutWY
        61RV5bgYjkvEEyNN5/tLAtw=
X-Google-Smtp-Source: ABdhPJx/UbjQ6nzJrH5RU1hc83JH6lexUNrwVpYUT4tDSz1UEuMzg6YNnHUAfXAsU3AsWwQFsQDrUQ==
X-Received: by 2002:a63:924c:: with SMTP id s12mr12553165pgn.536.1643048401561;
        Mon, 24 Jan 2022 10:20:01 -0800 (PST)
Received: from tong-desktop.local (99-105-211-126.lightspeed.sntcca.sbcglobal.net. [99.105.211.126])
        by smtp.googlemail.com with ESMTPSA id ha11sm366667pjb.3.2022.01.24.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:20:01 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/2] sysctl: fix return type to make compiler happy
Date:   Mon, 24 Jan 2022 10:18:13 -0800
Message-Id: <20220124181812.1869535-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
References: <20220124104012.nblfd6b5on4kojgi@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When CONFIG_SYSCTL=n and CONFIG_BINFMT_MISC={y,m}, compiler will
complain due to return type not matching. Fix the return type in
register_sysctl_mount_point() to make compiler happy

fs/binfmt_misc.c: In function ‘init_misc_binfmt’:
fs/binfmt_misc.c:827:21: error: assignment to ‘struct ctl_table_header *’ from incompatible pointer type ‘struct sysctl_header *’ [-Werror=incompatible-pointer-types]
  827 |  binfmt_misc_header = register_sysctl_mount_point("fs/binfmt_misc");

Fixes: ee9efac48a08("sysctl: add helper to register a sysctl mount point")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 include/linux/sysctl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 180adf7da785..6353d6db69b2 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -265,7 +265,7 @@ static inline struct ctl_table_header *register_sysctl_table(struct ctl_table *
 	return NULL;
 }
 
-static inline struct sysctl_header *register_sysctl_mount_point(const char *path)
+static inline struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
 	return NULL;
 }
-- 
2.25.1

