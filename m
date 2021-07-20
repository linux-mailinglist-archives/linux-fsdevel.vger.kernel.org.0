Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC013CF701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 11:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhGTI5Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 04:57:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhGTI5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 04:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626773873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBarrLvizU9ZaDOkgvxZkp4MZ9HfLKj4KaZtjEh7Ick=;
        b=UoY8NhzG8tTXsm21NS5aO0OY+JCBnKTlAE27XqWseUhkft18kMOFUCIoewM8A5KEhxPJcb
        ZyILL+bMOl7F/NcFl3xcGDQeZC/PSHK+iUjx5VWbIjJqMSMxKm+3k6iiZ9r4xVNYnH1pxV
        WhzHKl1TDh2oUVcr+CJOkpjcrQc6KJ4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-EnflwxQlP5Kb5Qot-r4ENQ-1; Tue, 20 Jul 2021 05:37:52 -0400
X-MC-Unique: EnflwxQlP5Kb5Qot-r4ENQ-1
Received: by mail-ej1-f71.google.com with SMTP id u12-20020a17090617ccb029051ab3a0d553so6546110eje.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jul 2021 02:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PBarrLvizU9ZaDOkgvxZkp4MZ9HfLKj4KaZtjEh7Ick=;
        b=ajS53AVDdwcJuBvt1cUjXM4MtF2hdYvP9D515iFfth9LSuEpLWbfv8lHqnbpQrU/H+
         3mUDOxhstWYBEbxGEe9BmIUVprIQ1XLIjX3BiN4UIwPX6XI5FQo4q+DcO0c8D3n8C+qA
         5SBs3dDiiV9NN9z4NLbHxLqsx3BKUqgF1qr057DTwB8LnEmcg/sH2VPPGjhUYlPPr/Ee
         QVD0Z2pN2WxXwLNNp3ocSYNtFfQCo2oaY1yYEt+1lQ3KirlWG+s1UDf2WEzUyvLqCHQz
         ARC7Ie2QUrg0Gl2aCAPusZAyFTu7b0GzpeYiwgu+KkOWKUFNryVprirBxiVDCwYq/bOs
         jaTA==
X-Gm-Message-State: AOAM531rKlNj8rb9aVYqcEUw0PjcRt8Mnv9tPQ9czSVWM46oC1V/iorn
        radrJLrEkkBsuuY35pNk7DPwLeOF+L9mHejkxxQ5KrjNQ1disaq7w0uG0wqIJVN5w9MNfxJ5/P7
        55RR3zn1nyMnAMgyZoI1TTFN4NkSGIkOr+kZZ6+RUMfp9s/zN+lBLMW1XyXyOgXnQyB69vc4S3A
        l7
X-Received: by 2002:a17:907:33cc:: with SMTP id zk12mr31758723ejb.168.1626773870621;
        Tue, 20 Jul 2021 02:37:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFAZ+pHxK++TMFR2QwZZQtwPuvwRbfPcp1tRcLrxkS5sV2A1n1Ghh70CXm1bfAkc97A7RkAg==
X-Received: by 2002:a17:907:33cc:: with SMTP id zk12mr31758706ejb.168.1626773870411;
        Tue, 20 Jul 2021 02:37:50 -0700 (PDT)
Received: from localhost.localdomain ([84.19.91.9])
        by smtp.gmail.com with ESMTPSA id d18sm6888195ejr.50.2021.07.20.02.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 02:37:49 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     cem@redhat.com
Subject: [PATCH 1/1] exfat: Add fiemap support
Date:   Tue, 20 Jul 2021 11:37:48 +0200
Message-Id: <20210720093748.180714-2-preichl@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210720093748.180714-1-preichl@redhat.com>
References: <20210720093748.180714-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 fs/exfat/exfat_fs.h | 3 +++
 fs/exfat/file.c     | 1 +
 fs/exfat/inode.c    | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 1d6da61157c9..1c22aa7107d4 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -428,6 +428,9 @@ long exfat_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long exfat_compat_ioctl(struct file *filp, unsigned int cmd,
 				unsigned long arg);
 
+extern int exfat_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+	u64 start, u64 len);
+
 /* namei.c */
 extern const struct dentry_operations exfat_dentry_ops;
 extern const struct dentry_operations exfat_utf8_dentry_ops;
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6af0191b648f..7823dcbca96e 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -432,4 +432,5 @@ const struct file_operations exfat_file_operations = {
 const struct inode_operations exfat_file_inode_operations = {
 	.setattr     = exfat_setattr,
 	.getattr     = exfat_getattr,
+	.fiemap	     = exfat_fiemap,
 };
diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 1803ef3220fd..c6f95d68badc 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -13,6 +13,7 @@
 #include <linux/uio.h>
 #include <linux/random.h>
 #include <linux/iversion.h>
+#include <linux/fiemap.h>
 
 #include "exfat_raw.h"
 #include "exfat_fs.h"
@@ -358,6 +359,13 @@ static int exfat_get_block(struct inode *inode, sector_t iblock,
 	return err;
 }
 
+int exfat_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
+		u64 start, u64 len)
+{
+	return generic_block_fiemap(inode, fieinfo, start, len,
+			exfat_get_block);
+}
+
 static int exfat_readpage(struct file *file, struct page *page)
 {
 	return mpage_readpage(page, exfat_get_block);
-- 
2.31.1

