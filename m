Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33689682C63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 13:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjAaMQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 07:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjAaMQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:16:10 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8BF3FF09
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 04:16:07 -0800 (PST)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A6AC7414A7
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 12:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675167365;
        bh=T9pFM0TaSiU75dNwwObnUqA54OKkqExI+JiVpjCtTNY=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Mfq5S/9XBDHZwf8X9Z5PyvLshiQ4n9APoR30xl6AZZ31VxeO6z3m2oWjZAZ8qKBPb
         HkanjfsHaOv5P3Hdmr87dYqD3pGnGBvymJnxfNQHWjpVOQj9HvA24B5J2/abvrUW1Q
         h3tDj9I+JI5BC5QEUU+wsLN5IUAOfmwqFiQ0vUOqw6hbnk8toOWdx5lBDzat3xu8hK
         aas8hgS/b/4XLeLP8ldHwQZTwPxvJLDl7QfVFelJB1h2GK/zaUaMzJfYONM9lCr3ej
         qvYnPFlIvVrm7Nvu38rmE8ZlbvklMCGEL+hhajMMljiIZMTcDn2M5O7rXkfrN0YR1S
         uVZIjZYHFaUhg==
Received: by mail-ed1-f72.google.com with SMTP id m7-20020a056402510700b00488d1fcdaebso10388843edd.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 04:16:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9pFM0TaSiU75dNwwObnUqA54OKkqExI+JiVpjCtTNY=;
        b=PP84IfmVr7O+tIroZtLMVX8zJBFeGFtl943eVnwTEvNEa9hihOrc1Ngjz87Xcmrviq
         SULn7Kpl7mUVgA1oaX3YPTPmQgsu7uOvXRnJAVAwkzK+lpg2ryDH+9czyFKZ2PeyxQWF
         1AivHhZvU6aU0Fnc1+k5uD8j0Mg04qpf8amMi/XblXHrtkanuClsLku+ayGa7cr6oze3
         tedxeAyhNA69Th9mD5a+hiF2iklcWIokMkVMOLeBBzpRMm03Y056G1NWExBP3p4Dg8yS
         lB1vGckLtLsHuv4YPKCvd9T5dyMdt3MI0+JtUt4970FD93tiqjDJpH/ONhMxF8voUwVH
         ersA==
X-Gm-Message-State: AO0yUKXHKa7eU7x6ik1NncJDjRRpDbeZpo7c3agjvNF8TbIqug8MQGto
        be55wQBOSJwloxqPOYjqqwck+DPn6i3CDbIorMZsc9OKcm2T0lpaOZO9T/LRg+/gYLJQ+saB+rh
        fidVGibpA98yg95kiaVVxUQP8t+X5pUCNzgBW3zex2vA=
X-Received: by 2002:a50:9e2f:0:b0:4a1:f49e:48bf with SMTP id z44-20020a509e2f000000b004a1f49e48bfmr18447827ede.7.1675167362836;
        Tue, 31 Jan 2023 04:16:02 -0800 (PST)
X-Google-Smtp-Source: AK7set/ypBMfNG1otMzUvh3lwDVgiSjv8iNANEI/lOt7rsQ5LLwFAFauXQGDGD1JtBOLqr1hdn9sVQ==
X-Received: by 2002:a50:9e2f:0:b0:4a1:f49e:48bf with SMTP id z44-20020a509e2f000000b004a1f49e48bfmr18447817ede.7.1675167362622;
        Tue, 31 Jan 2023 04:16:02 -0800 (PST)
Received: from amikhalitsyn.. (ip5f5bf399.dynamic.kabel-deutschland.de. [95.91.243.153])
        by smtp.gmail.com with ESMTPSA id u20-20020a50a414000000b004a08c52a2f0sm8378432edb.76.2023.01.31.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 04:16:02 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     corbet@lwn.net
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH 1/2] docs: filesystems: vfs: actualize struct file_system_type description
Date:   Tue, 31 Jan 2023 13:15:46 +0100
Message-Id: <20230131121546.176946-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Cc: linux-fsdevel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 Documentation/filesystems/vfs.rst | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 2c15e7053113..fab3bd702250 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -107,7 +107,7 @@ file /proc/filesystems.
 struct file_system_type
 -----------------------
 
-This describes the filesystem.  As of kernel 2.6.39, the following
+This describes the filesystem.  As of kernel 6.1, the following
 members are defined:
 
 .. code-block:: c
@@ -115,14 +115,24 @@ members are defined:
 	struct file_system_type {
 		const char *name;
 		int fs_flags;
+		int (*init_fs_context)(struct fs_context *);
+		const struct fs_parameter_spec *parameters;
 		struct dentry *(*mount) (struct file_system_type *, int,
-					 const char *, void *);
+			const char *, void *);
 		void (*kill_sb) (struct super_block *);
 		struct module *owner;
 		struct file_system_type * next;
-		struct list_head fs_supers;
+		struct hlist_head fs_supers;
+
 		struct lock_class_key s_lock_key;
 		struct lock_class_key s_umount_key;
+		struct lock_class_key s_vfs_rename_key;
+		struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
+
+		struct lock_class_key i_lock_key;
+		struct lock_class_key i_mutex_key;
+		struct lock_class_key invalidate_lock_key;
+		struct lock_class_key i_mutex_dir_key;
 	};
 
 ``name``
@@ -132,6 +142,15 @@ members are defined:
 ``fs_flags``
 	various flags (i.e. FS_REQUIRES_DEV, FS_NO_DCACHE, etc.)
 
+``init_fs_context``
+	Initializes 'struct fs_context' ->ops and ->fs_private fields with
+	filesystem-specific data.
+
+``parameters``
+	Pointer to the array of filesystem parameters descriptors
+	'struct fs_parameter_spec'.
+	More info in Documentation/filesystems/mount_api.rst.
+
 ``mount``
 	the method to call when a new instance of this filesystem should
 	be mounted
@@ -148,7 +167,8 @@ members are defined:
 ``next``
 	for internal VFS use: you should initialize this to NULL
 
-  s_lock_key, s_umount_key: lockdep-specific
+  s_lock_key, s_umount_key, s_vfs_rename_key, s_writers_key,
+  i_lock_key, i_mutex_key, invalidate_lock_key, i_mutex_dir_key: lockdep-specific
 
 The mount() method has the following arguments:
 
-- 
2.34.1

