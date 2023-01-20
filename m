Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7793675880
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Jan 2023 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjATPZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 10:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbjATPZA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:25:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23741DA104
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674228248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M9kcFm4bZIrWxqb92kaZI81madTzRGEizfXuC8UiNAg=;
        b=R1KbeLfEAH7dNS3KQLD0j6QGhwvf0ufT0sHLI5EIBphCwzWoWgDZhfHWMHtN6jEzX+f2dH
        Iesba5hhMNmczNdVi51idHFLN1QXrRzgdSvjIBu5RlMsxd0DDSToqh9O2ub39egEW07FQE
        hLecqJLs9KVO0U7mhun679PPPeO4j1A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-611-6PvEt7eHMKKG1VaKX8-XxA-1; Fri, 20 Jan 2023 10:23:59 -0500
X-MC-Unique: 6PvEt7eHMKKG1VaKX8-XxA-1
Received: by mail-ej1-f69.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so4003590ejc.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Jan 2023 07:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M9kcFm4bZIrWxqb92kaZI81madTzRGEizfXuC8UiNAg=;
        b=zK+aExdnMFP949kFXjWzKvAg+hpRwJAlRoXjTTzvHk8O6xJvE5hGfIc/6cdtFr2Ju1
         xs/CpXqRyRuLF4DExL9495/MRc22FONKDMfKeQRa6jAW5aGuiGZgfKh+2JXD0fPJNiyO
         qRD88pFdu4RDqiiiIeMm7+7OGmGzqRrFnPFQAgKzS7cPsIGRus764E92Q9+IrVPMdAXa
         qMWj8FxI45GKDB4ADGjkmn4+7H8bp2HoA9y5y/7LgC2TyP13IalYNdCPAOMlGyXa5mB6
         SgvHc/IDfJHr0MP1SvSwveC8zMidzTr7jFaEu5GlIZtjjpG3xNrUDS0paDNrh37/CCtG
         fBaw==
X-Gm-Message-State: AFqh2kqbZawAAOBQRom1hvWFnGzFtvW54IWVa5+24lWMF+//xGkIXAhv
        /P+5zZSfyc7ymHCaQ8cSsTE5wthzITWrGDkWaD4TX3jimxhEXaQcRh+PcUoOCPaOhJUD33TCQ/v
        Gl4PLHK0K05tdI7mWZLsBgY5ATSuQi6Mj7SRDLnX04E9IMT/tJXXOLf5+ykXjHenJS5YLM6VvQQ
        ==
X-Received: by 2002:a17:907:8e8c:b0:86f:fbcf:f30a with SMTP id tx12-20020a1709078e8c00b0086ffbcff30amr17256947ejc.58.1674228236759;
        Fri, 20 Jan 2023 07:23:56 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu9qkCLMflGLnlHw4DtZmrXLGQEq54VRSN4Eh5U4Z+xTENpAmtCMu5VVcOv2DCIdzj6GA3G8Q==
X-Received: by 2002:a17:907:8e8c:b0:86f:fbcf:f30a with SMTP id tx12-20020a1709078e8c00b0086ffbcff30amr17256918ejc.58.1674228236482;
        Fri, 20 Jan 2023 07:23:56 -0800 (PST)
Received: from localhost.localdomain (c-e6a5e255.022-110-73746f36.bbcust.telenor.se. [85.226.165.230])
        by smtp.googlemail.com with ESMTPSA id s16-20020a1709067b9000b00872eb47f46dsm5706976ejo.19.2023.01.20.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:23:55 -0800 (PST)
From:   Alexander Larsson <alexl@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 6/6] composefs: Add kconfig and build support
Date:   Fri, 20 Jan 2023 16:23:34 +0100
Message-Id: <44514e018d5fa27ace5c97c6c30e95a9cca89032.1674227308.git.alexl@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1674227308.git.alexl@redhat.com>
References: <cover.1674227308.git.alexl@redhat.com>
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
2.39.0

