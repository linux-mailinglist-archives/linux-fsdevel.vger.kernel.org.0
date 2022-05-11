Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48225228FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 03:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240497AbiEKBbc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 21:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiEKBb0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 21:31:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10B434B4
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 18:31:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cx11-20020a17090afd8b00b001d9fe5965b3so3492289pjb.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 18:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wQmwATZBlwPgfe8/IGykSqfJ1WJmNhS7AYJLIfu/Nbs=;
        b=jdvdOCo2qk6heSQztmRcF899GenupEv0QQQh1lywcGwx6Kpf9sxQcL2o94zB9sDFRG
         Jth1x3ZXgTgq27nABt9ux9Q5QOzYmdZi8r6Ttw6qfkL8CmbXuG2bSSeoBMBIZtSszFgq
         ftr4Qoc7Ed9l8CpFJ00KYOZ+j8e5+w+M+gDFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wQmwATZBlwPgfe8/IGykSqfJ1WJmNhS7AYJLIfu/Nbs=;
        b=pGMg44P06MFpYC6DtiKUxI9jkytuVV8TnmtHmnVg0WHqYMVfvWPuu8ZT18nadQy6uB
         7WqEEiwmga6Kr8UdGihAeJdJWwiwMwmZIIPP6IukofM07N78lMj56BiK5oWdV4K+08iS
         qGeB20lbhpNcj5Ht89kwFqIpuUVdO2Xji0vTi+a2y/Efe0Z+mS7lAYOwtyeCjoQWz4XR
         fBRP84SuYLEYJpkspqmTIFjwds9iq5ArfgXY3hkFZ81f0BmPxVCJkbS0pIlKbcl27KhR
         vDoS9YYeF3sQLTZz8EMjDH8zyCjaYCisMjAZQpBkh/vg/Kvr07kwJEBJUeUKHYFMDjtb
         Z3IQ==
X-Gm-Message-State: AOAM531/sie0G/cUvWymCWz99zybbFyVMuxfk/7HaltHDmnhMBGY1ND8
        OgNGQTq88yj2E1gGifhlL2W0QcouXM0vrg==
X-Google-Smtp-Source: ABdhPJwStc3JS5ugin6DYuNIOemCa2wJPbZeDEGecbfHJpVUVx+kYkZovA4pUxJSJoOwQ6w/IkIZqA==
X-Received: by 2002:a17:902:7fc9:b0:15f:2afd:82f3 with SMTP id t9-20020a1709027fc900b0015f2afd82f3mr3976685plb.91.1652232684169;
        Tue, 10 May 2022 18:31:24 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090aa50400b001cd4989feecsm2494749pjq.56.2022.05.10.18.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:31:23 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 1/2] fs/super: Add a flag to mark super block defunc
Date:   Wed, 11 May 2022 11:30:56 +1000
Message-Id: <20220511113050.1.Ifc059f4eca1cce3e2cc79818467c94f65e3d8dde@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511013057.245827-1-dlunev@chromium.org>
References: <20220511013057.245827-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

File system can mark a block "defunc" in order to prevent matching
against it in a new mount.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 fs/super.c         | 4 ++--
 include/linux/fs.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f1d4a193602d6..fc5b3efe0cd01 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1216,7 +1216,7 @@ static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 
 static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
 {
-	return s->s_bdev == fc->sget_key;
+	return !s->s_defunc && s->s_bdev == fc->sget_key;
 }
 
 /**
@@ -1307,7 +1307,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return (void *)s->s_bdev == data;
+	return !s->s_defunc && (void *)s->s_bdev == data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23a..76feb3fe9bb9e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1448,6 +1448,7 @@ struct super_block {
 	struct rw_semaphore	s_umount;
 	int			s_count;
 	atomic_t		s_active;
+	bool			s_defunc;
 #ifdef CONFIG_SECURITY
 	void                    *s_security;
 #endif
-- 
2.31.0

