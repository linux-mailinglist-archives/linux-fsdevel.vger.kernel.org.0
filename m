Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B9437F34
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 22:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhJVUSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Oct 2021 16:18:01 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43434 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhJVURw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Oct 2021 16:17:52 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1FA5F212C6;
        Fri, 22 Oct 2021 20:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634933734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNU+rWeDc4fnlH5M93y+Bu51/poFzNxm0nK8OEDtSz0=;
        b=Oyzn9CdUQC444jBRn9aDwK5Nc/QrFClXXJL+++OjZLRFlSkTrU6prGnCZzKAebwOzlsn11
        sZIv6vUz0cxfTrrVrStpOB+3NaRLayBpZrLD+nr0YMOxhQfLlte7KC/V81tO/18K28iBTN
        ebD8nlbo7Jg2DulE/MfVPOM+D9zMOOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634933734;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNU+rWeDc4fnlH5M93y+Bu51/poFzNxm0nK8OEDtSz0=;
        b=WXL7jFAIrRMQiEB8/i22yp920bW/o/c+bj+Od2RKTs6aQ1f1GPqfSWTWdm89+e4R3qqUL6
        JxezbOGjfKNw0GDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 740021348D;
        Fri, 22 Oct 2021 20:15:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ueE3DOUbc2H0dgAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 22 Oct 2021 20:15:33 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 3/5] btrfs: Add sharedext mount option
Date:   Fri, 22 Oct 2021 15:15:03 -0500
Message-Id: <3905859891d47e0666737fa4c2d4459bd4178221.1634933122.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634933121.git.rgoldwyn@suse.com>
References: <cover.1634933121.git.rgoldwyn@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

The mount option to use shared pages for shared extents. If set, pass
custom file_offset_to_device function to filemap_read().

sharedext may not describe it well. Suggest a better name?

TODO Checks:
Check if the pagesize == blocksize

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/ctree.h | 1 +
 fs/btrfs/super.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4aa4f4760b72..5c97112143d6 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -1415,6 +1415,7 @@ enum {
 	BTRFS_MOUNT_DISCARD_ASYNC		= (1UL << 28),
 	BTRFS_MOUNT_IGNOREBADROOTS		= (1UL << 29),
 	BTRFS_MOUNT_IGNOREDATACSUMS		= (1UL << 30),
+	BTRFS_MOUNT_SHAREDEXT			= (1UL << 31),
 };
 
 #define BTRFS_DEFAULT_COMMIT_INTERVAL	(30)
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..432f40f72466 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -397,6 +397,7 @@ enum {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	Opt_ref_verify,
 #endif
+	Opt_sharedext,
 	Opt_err,
 };
 
@@ -471,6 +472,7 @@ static const match_table_t tokens = {
 #ifdef CONFIG_BTRFS_FS_REF_VERIFY
 	{Opt_ref_verify, "ref_verify"},
 #endif
+	{Opt_sharedext, "sharedext"},
 	{Opt_err, NULL},
 };
 
@@ -1013,6 +1015,10 @@ int btrfs_parse_options(struct btrfs_fs_info *info, char *options,
 			btrfs_set_opt(info->mount_opt, REF_VERIFY);
 			break;
 #endif
+		case Opt_sharedext:
+			btrfs_info(info, "enabling shared memory for shared extents");
+			btrfs_set_opt(info->mount_opt, SHAREDEXT);
+			break;
 		case Opt_err:
 			btrfs_err(info, "unrecognized mount option '%s'", p);
 			ret = -EINVAL;
-- 
2.33.1

