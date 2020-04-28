Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA8F1BBBC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 13:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgD1LAW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 07:00:22 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52182 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgD1LAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 07:00:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id x4so2249881wmj.1;
        Tue, 28 Apr 2020 04:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qpvH4kMAvloFXkFfMI7laBSfWeqfBoLeIX+YXg/++L4=;
        b=IUYymMXq3tuazRvO0ZmltbrMKypmbNZ7c7aEeIGzubfDpWPZNDXAJkXdNuSTT0h17D
         +ddn+l4VpK8Ij2+hdgTxz0S0as0tCREMnd5VDVqen5GXCP9/FBkTsY0hdtI8A22IIQv9
         vafOZwjNYbO5K5TG2cpXjy9bA2B1rao9atuI5mURVSNFgnqARXlPclVbZOO5Mhma3TYs
         wdv9uRB5LpMTesq2FKwpLc//rCQjuKxzcFVqlsE0wWrFsYbVMV/p/rD5DXTlbbjU9gCd
         cTaT5FL4Vdvj8L4DAx5VZHtQtpambRGVruIbg4vYtsrglbUVE/LBOPG7jQ/ksKjcR/o+
         VlEQ==
X-Gm-Message-State: AGi0PuYEJU91ZvHph15FO21o3/RjYG34Nk39uXXR/A5uGB1EO3A9E0IH
        2Ws0Clks3/fCdYYmqw42eiTSlEHsH/CcrA==
X-Google-Smtp-Source: APiQypJacslv0VtlasxYuVBGREB9UGinBP86haC+RwsZ84W1Bz2/AbifCY3NV+bQ3HyQt9GsuonOvQ==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr4043172wme.42.1588071619467;
        Tue, 28 Apr 2020 04:00:19 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id c83sm2997739wmd.23.2020.04.28.04.00.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:00:19 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 2/2] btrfs: rename btrfs_parse_device_options back to btrfs_parse_early_options
Date:   Tue, 28 Apr 2020 12:58:59 +0200
Message-Id: <20200428105859.4719-3-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428105859.4719-1-jth@kernel.org>
References: <20200428105859.4719-1-jth@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

As btrfs_parse_device_options() now doesn't only parse the -o device mount
option but -o auth_key as well, it makes sense to rename it back to
btrfs_parse_early_options().

This reverts commit fa59f27c8c35bbe00af8eff23de446a7f4b048b0.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/btrfs/super.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2645a9cee8d1..3acc7d26406f 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -475,8 +475,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 		case Opt_subvolrootid:
 		case Opt_device:
 			/*
-			 * These are parsed by btrfs_parse_subvol_options or
-			 * btrfs_parse_device_options and can be ignored here.
+			 * These are parsed by btrfs_parse_subvol_options
+			 * and btrfs_parse_early_options
+			 * and can be happily ignored here.
 			 */
 			break;
 		case Opt_nodatasum:
@@ -912,7 +913,7 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(struct btrfs_fs_info *info,
+static int btrfs_parse_early_options(struct btrfs_fs_info *info,
 				      const char *options, fmode_t flags,
 				      void *holder)
 {
@@ -994,7 +995,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 	/*
 	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
+	 * btrfs_parse_early_options gets called later
 	 */
 	opts = kstrdup(options, GFP_KERNEL);
 	if (!opts)
@@ -1560,7 +1561,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(fs_info, data, mode, fs_type);
+	error = btrfs_parse_early_options(fs_info, data, mode, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
-- 
2.16.4

