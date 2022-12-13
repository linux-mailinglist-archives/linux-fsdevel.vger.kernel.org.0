Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CEE64BB1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbiLMRbw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbiLMRas (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C92123397
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670952591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+GiG0BGe80J6W6TnK0jiJK/bNKCYrNUMGHoKQBGkRkw=;
        b=fa0+ibUbJCodjilQmYgM4XGPvdANJdFMbXcLv9sCwuMZ/GxepQ18BAcVlPyxSZKlyME6Wt
        s7r5rX1RgR1+S+I+QjZx91KV+vfe0a9eVzyKoN/OjvpFyrseVL/ICMqzCCn91G5UWmB7fR
        c1nkFu8xPNe7sAaeFid1K3ajBKsJfhc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-FXl_S_ZcPYiv6ayb4KD6fg-1; Tue, 13 Dec 2022 12:29:50 -0500
X-MC-Unique: FXl_S_ZcPYiv6ayb4KD6fg-1
Received: by mail-ej1-f69.google.com with SMTP id hq42-20020a1709073f2a00b007c100387d64so9616279ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Dec 2022 09:29:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+GiG0BGe80J6W6TnK0jiJK/bNKCYrNUMGHoKQBGkRkw=;
        b=0dFXbEC8Bj46Gf8vM041SjxIbxz/nNsfVXpETvWwDn3oVkXpg5BWFUbVZNYIKagpVl
         6kbt54PqXoqysCs23kQcEGTUI6ZIz3TtDFXSHU09Xd4Hw1P0teHOiR819NKReI12FU+2
         HenWUnz51Gf6ExuF7PmDLwOjKtmDzgooMIWEUVpoEQYxAw5bCr1wOd0x88g0HfOT+805
         kjUiE0MNUnQHaJuzODEF2iGwXxZT3YOHf/ksg0ucb3SsofpB0z6llB3k3DleQ2uxscBR
         OMXceK/yA3l3RIr41itwnhLGji07wlaFWZSpR/A6aH9M74NxdMtBQ29GwpWQduGcaM66
         YBgw==
X-Gm-Message-State: ANoB5pkWIlh4DUeO1LMYOaNdo7CqgR4jInR5U36hfo+FcZyoaFCfmv9w
        oCMJpqgwriUA/LfLZCbWcPl3wbCOVOsox6wq6MCaX1VicJ6ThSMTGYPopoJwUJ535QbAw7U5lVZ
        Q9u9hqrW3LEv1RW/ccEeUjJWE
X-Received: by 2002:a05:6402:2986:b0:45c:834b:f298 with SMTP id eq6-20020a056402298600b0045c834bf298mr16957704edb.21.1670952589314;
        Tue, 13 Dec 2022 09:29:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4+VYAsy05Ni1/O+l//FoyYcD0DzahMvHdo1dYl84a/uMCpesHVM+J1EHD+ElFaOaTbL4DKPQ==
X-Received: by 2002:a05:6402:2986:b0:45c:834b:f298 with SMTP id eq6-20020a056402298600b0045c834bf298mr16957692edb.21.1670952589140;
        Tue, 13 Dec 2022 09:29:49 -0800 (PST)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b0047025bf942bsm1204187edb.16.2022.12.13.09.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 09:29:48 -0800 (PST)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Andrey Albershteyn <aalbersh@redhat.com>
Subject: [RFC PATCH 11/11] xfs: add fs-verity ioctls
Date:   Tue, 13 Dec 2022 18:29:35 +0100
Message-Id: <20221213172935.680971-12-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221213172935.680971-1-aalbersh@redhat.com>
References: <20221213172935.680971-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add fs-verity ioctls to enable, dump metadata (descriptor and Merkle
tree pages) and obtain file's digest.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_ioctl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 3cd46d030ccdc..dff3672c16140 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -43,6 +43,7 @@
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <linux/fileattr.h>
+#include <linux/fsverity.h>
 
 /*
  * xfs_find_handle maps from userspace xfs_fsop_handlereq structure to
@@ -2267,6 +2268,16 @@ xfs_file_ioctl(
 		return error;
 	}
 
+	case FS_IOC_ENABLE_VERITY:
+		return fsverity_ioctl_enable(filp, (const void __user *)arg);
+
+	case FS_IOC_MEASURE_VERITY:
+		return fsverity_ioctl_measure(filp, (void __user *)arg);
+
+	case FS_IOC_READ_VERITY_METADATA:
+		return fsverity_ioctl_read_metadata(filp,
+						    (const void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
-- 
2.31.1

