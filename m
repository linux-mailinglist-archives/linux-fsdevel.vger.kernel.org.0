Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8055EDC6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Sep 2022 14:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbiI1MUQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Sep 2022 08:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbiI1MUJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:20:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8B97F089
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 05:20:08 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a29so12380279pfk.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Sep 2022 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=XJFmD8H0AdxkjqNWMmBcMwiyS5s3pK6IsOOp8rLRxV8=;
        b=wWO87O3TOPTuGNrrk3cPfNBWDTedWB7HFdmHbB03wkdZDCvh89oRLv1wJmwTpnTZD2
         l0PB1bKgBtJ9ijeR0gL+9tZUayJ0OKHfxU8aUfh+cPftUHb5nZnz6ySPAA22Io2X4BIY
         p1fjsn0H7Tub8MkNupbHF5WBARjlfMqewgUaJdln0ew2sy4Kgx2ej6hUBAGfT+XPlBDZ
         eyQyMHV6WG+hjPN5muoIqYYwPpa51StJPzdmbw55UzKSpGUeIKoN0uO5x/AJDwA71veN
         rf9zQ/hmVSjjNWeqOYpStkmJq7wMyeO/eZcGT99niB1XhX6xAZhZPKWfluA0kSn7e/cG
         eImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=XJFmD8H0AdxkjqNWMmBcMwiyS5s3pK6IsOOp8rLRxV8=;
        b=SjlhL25PrIig957DzdF6o2XhOC7Y3Ln/aKh/QhqR7cNqvyWT/WJ1tMJ+H0kkkleq/i
         mHpBWAliG2v7XdLRplgcXnudhQWkxHdZpwqJh5jZYMJTfRYXL0wIprMzxrZH9NUos1ms
         tOCXt7ErQEdJ2+4mPhjvg9G7MdUQnhm6Icth3637N3lbE+H/Yt/wpntedRM5zNn1RaCX
         VBGbxawQT3/7hgPqlzcqgfchxKhzxq6qkYYHUUVvDjucXoQUAbOxqkBylJD5jg3SFySB
         o3Mhe9ux9flOZJ/E9aUHR037lU6vw1CfxywN45W8t3JGyg42parskz0Du9HT8Jn6TuKL
         vs3A==
X-Gm-Message-State: ACrzQf2Hfkj+xOKrBDj+2WSFkSN7IJ+MpSypc7eDVxpgIBQEQjZYe/XS
        p3B0czT7IBp6q16H0fr+dyNlMth0v9dDqA==
X-Google-Smtp-Source: AMsMyM5JopGIGKQV+Dwdp5lMP0rpvaD0WoueBqZuh7pYlTz0s68GTj00J9wCuw9rNIAD4e1EiXmBng==
X-Received: by 2002:a63:510a:0:b0:43c:4558:b47e with SMTP id f10-20020a63510a000000b0043c4558b47emr24494847pgb.464.1664367607670;
        Wed, 28 Sep 2022 05:20:07 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id ij23-20020a170902ab5700b0016f196209c9sm3550235plb.123.2022.09.28.05.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 05:20:07 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>
Subject: [PATCH] fuse: always revalidate rename target dentry
Date:   Wed, 28 Sep 2022 20:19:34 +0800
Message-Id: <20220928121934.3564-1-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The previous commit df8629af2934 ("fuse: always revalidate if exclusive
create") ensures that the dentries are revalidated on O_EXCL creates. This
commit complements it by also performing revalidation for rename target
dentries. Otherwise, a rename target file that only exists in kernel dentry
cache but not in the filesystem may result in an EEXIST.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Signed-off-by: Zhang Tianci <zhangtianci.1997@bytedance.com>
---
 fs/fuse/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b585b04e815e..a453fc57ce4f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -214,7 +214,7 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 	if (inode && fuse_is_bad(inode))
 		goto invalid;
 	else if (time_before64(fuse_dentry_time(entry), get_jiffies_64()) ||
-		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL))) {
+		 (flags & (LOOKUP_EXCL | LOOKUP_REVAL | LOOKUP_RENAME_TARGET))) {
 		struct fuse_entry_out outarg;
 		FUSE_ARGS(args);
 		struct fuse_forget_link *forget;
-- 
2.20.1

