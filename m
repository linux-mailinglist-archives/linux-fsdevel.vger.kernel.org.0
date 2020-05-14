Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329F61D2B49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 11:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgENJYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 05:24:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52622 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgENJYm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 05:24:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id m24so19825183wml.2;
        Thu, 14 May 2020 02:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeYIuSZz1h4OodCnVuDHUt8ckF0iXfCrXxOaLt9JUQ4=;
        b=ifQagYT0KZ8DlXoX0/FKQBtz62IxhxwoN/j0yatm2amT735vSHtKWq0xJOXUE0ehqC
         F3EyaJDOH0chBdvTBSj+c/lYGMTwb/vRMptZPpvds6k5W08YPSxXS7wzocIfIz+kOJqw
         idFOp3FxrAE8i6MvLedgXhHLfeTeDk62T+m0gtk3ZnHRo7VwohtcTHWUP7uHxJlaGCg7
         WBf3URkM2mas1NRkaP9bFiy7PqYHQLbAf0wJkeo1wUFj+ADppkv/Mt93nW9C0AoynBjN
         6d690IWwGNt+6iRTXB/Co1UOvLiP68EEb94qlyTC9wWxUaOOyx2OmqXaBS6tlAEVNV9d
         4AZA==
X-Gm-Message-State: AGi0PuYjPmBjqJw/QKPr3518fX+Bw0jqG/nMa/v+FLKJxraAakOhZx2s
        8ADd5cuJm7cKP97/2L2tPRA=
X-Google-Smtp-Source: APiQypKo/hTuashElmeVUqkdUJ1iJcJVYyopfByz7uBTm2Qvs4U5IP1bFV2zn1aHSauh82kQVVoPeQ==
X-Received: by 2002:a1c:9948:: with SMTP id b69mr45735656wme.44.1589448280615;
        Thu, 14 May 2020 02:24:40 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id z132sm38877763wmc.29.2020.05.14.02.24.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:24:40 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 1/3] btrfs: rename btrfs_parse_device_options back to btrfs_parse_early_options
Date:   Thu, 14 May 2020 11:24:13 +0200
Message-Id: <20200514092415.5389-2-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514092415.5389-1-jth@kernel.org>
References: <20200514092415.5389-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/btrfs/super.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 438ecba26557..07cec0d16348 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -482,8 +482,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
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
@@ -919,8 +920,9 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
  * All other options will be parsed on much later in the mount process and
  * only when we need to allocate a new super block.
  */
-static int btrfs_parse_device_options(const char *options, fmode_t flags,
-				      void *holder)
+static int btrfs_parse_early_options(struct btrfs_fs_info *info,
+				     const char *options, fmode_t flags,
+				     void *holder)
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *device_name, *opts, *orig, *p;
@@ -987,7 +989,7 @@ static int btrfs_parse_subvol_options(const char *options, char **subvol_name,
 
 	/*
 	 * strsep changes the string, duplicate it because
-	 * btrfs_parse_device_options gets called later
+	 * btrfs_parse_early_options gets called later
 	 */
 	opts = kstrdup(options, GFP_KERNEL);
 	if (!opts)
@@ -1551,7 +1553,7 @@ static struct dentry *btrfs_mount_root(struct file_system_type *fs_type,
 	}
 
 	mutex_lock(&uuid_mutex);
-	error = btrfs_parse_device_options(data, mode, fs_type);
+	error = btrfs_parse_early_options(fs_info, data, mode, fs_type);
 	if (error) {
 		mutex_unlock(&uuid_mutex);
 		goto error_fs_info;
-- 
2.26.1

