Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F305D7BBF1B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 20:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjJFSxw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 14:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjJFSxv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 14:53:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DBCF
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Oct 2023 11:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696618345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1rGIaFOcgzEDtbNfKOICnouTJvfDrh5OEfl1tH6mXc=;
        b=SPYklz2aqNHLcWMfSrv4w7F7UPuLUWWM7TnkUkjwxYIRN8Y6Iwtq4oghk3nHdE9A2yflb1
        rmT4jFxWndXPCm0H2mbK0koShjcJdX2cJUXw9B3bHsu4sz4lsz4YCan612c7hZqtjA3mHG
        TeQQn7cfPRJgJVRkhqAivfVNLeLQjc4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-gxNY5g3JPOeELhl3DZGGkA-1; Fri, 06 Oct 2023 14:52:24 -0400
X-MC-Unique: gxNY5g3JPOeELhl3DZGGkA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9ae70250ef5so395937566b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Oct 2023 11:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618343; x=1697223143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1rGIaFOcgzEDtbNfKOICnouTJvfDrh5OEfl1tH6mXc=;
        b=hK3TEdhMeXVDwC2I+iwyBKh4PgVlBy6zgPFVZwd/RV9tg/J+iZ3iiUuMJtKI3wsyKk
         DfBRdbnP4Ay+U07pwsMKusjCh0zPqgg1pBob/xZrZFLnmOuZUuAWCuPOiLuX+IB5BOj6
         VSbvGh+CGQ2ZK6e3MOA7wiVS43fSuPbzlWfBm2VVhZ0VAa//Os635NGs9omT1miNZmZX
         2psNfooY0My6QdR4GwoCrdbkFqxYrrMYIEk2I4r17clLeObQwP5lVYk0t5EWUiIdBTzY
         Mcgje57DQF5bidGP+jA69akyxZJSqn4MWNyff8E3prrAZhprFnsXR5AT4B78MF8GeuTw
         XO3A==
X-Gm-Message-State: AOJu0YxUtMPndybnQBGNEtjb99qpDTJs/uu8GEfrwOt949b8GAT6ktnI
        jcsBZDXEUcv+dycoE3z/mq3iGba6cWtHBgPMn7bXrcFBX8Pof7RRuZZkKJuVyQuNwYq59LStQkC
        IRwxCGmL1hlUymvZ+14RTXbj8
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id dm17-20020a170907949100b009a5962ccb6cmr5175897ejc.31.1696618342978;
        Fri, 06 Oct 2023 11:52:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH17nmROYKxmyjF7xwhLbMraoHotdEHwmzzX8X0FXNpicq6vdW0N2QZENxJT12qGNrH88Nkhg==
X-Received: by 2002:a17:907:9491:b0:9a5:962c:cb6c with SMTP id dm17-20020a170907949100b009a5962ccb6cmr5175890ejc.31.1696618342685;
        Fri, 06 Oct 2023 11:52:22 -0700 (PDT)
Received: from localhost.localdomain ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id os5-20020a170906af6500b009b947f81c4asm3304741ejb.155.2023.10.06.11.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:52:22 -0700 (PDT)
From:   Andrey Albershteyn <aalbersh@redhat.com>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        fsverity@lists.linux.dev
Cc:     djwong@kernel.org, ebiggers@kernel.org, david@fromorbit.com,
        dchinner@redhat.com, Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v3 05/28] fs: add FS_XFLAG_VERITY for fs-verity sealed inodes
Date:   Fri,  6 Oct 2023 20:48:59 +0200
Message-Id: <20231006184922.252188-6-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006184922.252188-1-aalbersh@redhat.com>
References: <20231006184922.252188-1-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add extended file attribute FS_XFLAG_VERITY for inodes sealed with
fs-verity.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 Documentation/filesystems/fsverity.rst | 9 +++++++++
 include/uapi/linux/fs.h                | 1 +
 2 files changed, 10 insertions(+)

diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
index 13e4b18e5dbb..af889512c6ac 100644
--- a/Documentation/filesystems/fsverity.rst
+++ b/Documentation/filesystems/fsverity.rst
@@ -326,6 +326,15 @@ the file has fs-verity enabled.  This can perform better than
 FS_IOC_GETFLAGS and FS_IOC_MEASURE_VERITY because it doesn't require
 opening the file, and opening verity files can be expensive.
 
+Extended file attributes
+------------------------
+
+For fs-verity sealed files the FS_XFLAG_VERITY extended file
+attribute is set. The attribute can be observed via lsattr.
+
+    [root@vm:~]# lsattr /mnt/test/foo
+    --------------------V- /mnt/test/foo
+
 .. _accessing_verity_files:
 
 Accessing verity files
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index b7b56871029c..5172a2eb902c 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_VERITY		0x00020000	/* fs-verity sealed inode */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.40.1

