Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF8363A70A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Nov 2022 12:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiK1LTa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Nov 2022 06:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiK1LSz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A061167D4
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669634271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bfBW73LGL9+SMTcT0q3UKBY6n7ebNKGVYFSRGPrdczE=;
        b=MvuMVSZNHXqapxtUIzdA8vfjBBX3aNG5S1ca/Pg+4uOLc4PwD8vtW+FIeMkDIfEZx6u6EN
        P3rstCT5fK7U2PfPycla9Zy8VpmrxSYX7j8JsRS4Skvq5QjrYH2Eky18MTE/RGRaFwbTb8
        DJVzWUUKLQbd7CSZpMHmMYYLDWkYN5A=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-230-8khDaTc2PXSn1WWVwxMPQg-1; Mon, 28 Nov 2022 06:17:50 -0500
X-MC-Unique: 8khDaTc2PXSn1WWVwxMPQg-1
Received: by mail-lf1-f70.google.com with SMTP id t8-20020a056512208800b004b1abbe7021so3643069lfr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Nov 2022 03:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfBW73LGL9+SMTcT0q3UKBY6n7ebNKGVYFSRGPrdczE=;
        b=1KFsytkuHLWplJbryiUCbGnPd6IT3RuelgRqu9gjCKhKYEddtuGIsURvRs7ijzWKw3
         zToE+EKJB2FuruHoaXVJH4DAlZ7yE9/N5cDDkpNRttoHccYaFTITIEPlo4lyJViK1K2t
         lAsFL4jDTr3tSsPpkl63IKIf//LkzUDQ2K6lo/gejwh5F7bn1iuA5LRPFWfYtvPtOu96
         /y14/YmPN92fYcks4fCFTtLYErMGyGdrOIolLVwnNmuL+QzPD+Ta2hTZ1C04z3hr1tlm
         o9vffmxtbMue0TcCcq0f5K7Qhd3K0bM7wzn3dxcqRnUN2/SsK/gbG2ex4Kxiiju/Yin4
         9bDA==
X-Gm-Message-State: ANoB5pkV2iYsHpmJY03m+YLz9Fe587WBG43n1TGKtucVMeV7IIyjh+Sx
        wLsf0qEEuX1gdq9DUSN0xxnQURaQoaQkxOA1J+TILxYQtbl7emCmevR9DsdVsUU5kPI/ESUhPeb
        hFUiOUVRovahi18SEyxAc1rhqkaJUb0DelyMeWtuRbmJc+b7GqTvBJX0B6fjXkRJA6hAQdt6zhg
        ==
X-Received: by 2002:a19:6917:0:b0:4b0:2da9:55d0 with SMTP id e23-20020a196917000000b004b02da955d0mr10495825lfc.187.1669634268633;
        Mon, 28 Nov 2022 03:17:48 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4mc5mXsUXD1MdME9y94GOyO8gtF9VyPiX8dxqD782++BQhr3pi0l1rgNCaW19RrCU5CChosQ==
X-Received: by 2002:a19:6917:0:b0:4b0:2da9:55d0 with SMTP id e23-20020a196917000000b004b02da955d0mr10495813lfc.187.1669634268372;
        Mon, 28 Nov 2022 03:17:48 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id t1-20020ac25481000000b0048a982ad0a8sm1699609lfk.23.2022.11.28.03.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:17:47 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com, alexl@redhat.com
Subject: [PATCH 6/6] composefs: Add kconfig and build support
Date:   Mon, 28 Nov 2022 12:17:39 +0100
Message-Id: <a0524f492d2ac64b99f3de6ea2b27249a4bcadad.1669631086.git.alexl@redhat.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1669631086.git.alexl@redhat.com>
References: <cover.1669631086.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds Makefile and Kconfig for composefs, and
updates Makefile and Kconfig files in the fs directory

Signed-off-by: Alexander Larsson <alexl@redhat.com>
---
 fs/Kconfig            |  1 +
 fs/Makefile           |  1 +
 fs/composefs/Kconfig  | 18 ++++++++++++++++++
 fs/composefs/Makefile |  5 +++++
 4 files changed, 25 insertions(+)
 create mode 100644 fs/composefs/Kconfig
 create mode 100644 fs/composefs/Makefile

diff --git a/fs/Kconfig b/fs/Kconfig
index 2685a4d0d353..de8493fc2b1e 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -127,6 +127,7 @@ source "fs/quota/Kconfig"
 source "fs/autofs/Kconfig"
 source "fs/fuse/Kconfig"
 source "fs/overlayfs/Kconfig"
+source "fs/composefs/Kconfig"
 
 menu "Caches"
 
diff --git a/fs/Makefile b/fs/Makefile
index 4dea17840761..d16974e02468 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -137,3 +137,4 @@ obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
 obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_VBOXSF_FS)		+= vboxsf/
 obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
+obj-$(CONFIG_COMPOSEFS_FS)	+= composefs/
diff --git a/fs/composefs/Kconfig b/fs/composefs/Kconfig
new file mode 100644
index 000000000000..88c5b55380e6
--- /dev/null
+++ b/fs/composefs/Kconfig
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config COMPOSEFS_FS
+	tristate "Composefs filesystem support"
+	select EXPORTFS
+	help
+	  Composefs is a filesystem that allows combining file content from
+	  existing regular files with a metadata directory structure from
+	  a separate binary file. This is useful to share file content between
+	  many different directory trees, such as in a local container image store.
+
+	  Composefs also allows using fs-verity to validate the content of the
+	  content-files as well as the metadata file which allows dm-verity
+	  like validation with the flexibility of regular files.
+
+	  For more information see Documentation/filesystems/composefs.rst
+
+	  If unsure, say N.
diff --git a/fs/composefs/Makefile b/fs/composefs/Makefile
new file mode 100644
index 000000000000..eac8445e7d25
--- /dev/null
+++ b/fs/composefs/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_COMPOSEFS_FS) += composefs.o
+
+composefs-objs += cfs-reader.o cfs.o
-- 
2.38.1

