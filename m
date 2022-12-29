Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59468658A53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiL2IO2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiL2INa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:13:30 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC2313D48
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n4so18307722plp.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vv5x1KdmMeVtIhlp3zKOKF7sZVF7KRZLRJQbPD3QKT4=;
        b=T05xc0ET+ovYWIL5pcnCM2gTG/W0v/0OqHvEwFkZjoBf10OqF0ArlagciQllVNzMtn
         GIrm+w7+DEYMtu0OMfltv5BLAP1xPtYnbtZ4WfOOVblA64a9OsheTZbsH52zOo8QN0Sp
         hWwPftBw+HDztRSuSQCbaldwNxaNhj1AdbITs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vv5x1KdmMeVtIhlp3zKOKF7sZVF7KRZLRJQbPD3QKT4=;
        b=iz3XC4nvhv4NpRno3LylZWdMx7a5qzM4+rjH8+sdggJyp3nXR+rD1IIiNdyKIub+HQ
         kRDzOxtqZsOzKY+DDQSmqQAj9GzNl4VrqMcCo64+WQlvCB496MIaJ2ec08DbdHgBg4ZJ
         JyosPy/m08RBWvHHoa0fMm6tvhFZyGHCoJXkcuP2HWJzCUPhxyiBybENilkpBMSunzJV
         Rl+DMWd9EKaO9FJmUpDbZCCMfUBLhjGodMQbg/effO/hfWu8LdiT07JBPMoxXdT7tHTS
         XwnlB9XbaZ9pSifHXLo+y9IeH6MpHPJOoqB1D1ZaQXbsOXzWhLiEkvfNehYjE4ztmL/d
         pY8Q==
X-Gm-Message-State: AFqh2krNHanTxaRkRj6rihj3k6lzXv0e8SUKdc/fu5OYm41btCQCd1fN
        Elv/mvxJdkckE7A137ca9t35Dg==
X-Google-Smtp-Source: AMrXdXvrTl4SO8Hr42En8z77cNqZKNC6eJ1qGCmNwbui5VQ51uN9dxzll3B3KUp7znSacUHIozLKhA==
X-Received: by 2002:a17:902:a70c:b0:189:dcc3:e4a1 with SMTP id w12-20020a170902a70c00b00189dcc3e4a1mr28589601plq.9.1672301592863;
        Thu, 29 Dec 2022 00:13:12 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:12 -0800 (PST)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     sarthakkukreti@google.com, dm-devel@redhat.com,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Brian Foster <bfoster@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Bart Van Assche <bvanassche@google.com>,
        Daniil Lunev <dlunev@google.com>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 6/7] ext4: Add mount option for provisioning blocks during allocations
Date:   Thu, 29 Dec 2022 00:12:51 -0800
Message-Id: <20221229081252.452240-7-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20221229081252.452240-1-sarthakkukreti@chromium.org>
References: <20221229081252.452240-1-sarthakkukreti@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a mount option that sets the default provisioning mode for
all files within the filesystem.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 7 +++++++
 fs/ext4/super.c   | 7 +++++++
 3 files changed, 15 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 49832e90b62f..29cab2e2ea20 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1269,6 +1269,7 @@ struct ext4_inode_info {
 #define EXT4_MOUNT2_MB_OPTIMIZE_SCAN	0x00000080 /* Optimize group
 						    * scanning in mballoc
 						    */
+#define EXT4_MOUNT2_PROVISION		0x00000100 /* Provision while allocating file blocks */
 
 #define clear_opt(sb, opt)		EXT4_SB(sb)->s_mount_opt &= \
 						~EXT4_MOUNT_##opt
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 2e64a9211792..a73f44264fe2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4441,6 +4441,13 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	unsigned int credits;
 	loff_t epos;
 
+	/*
+	 * Attempt to provision file blocks if the mount is mounted with
+	 * provision.
+	 */
+	if (test_opt2(inode->i_sb, PROVISION))
+		flags |= EXT4_GET_BLOCKS_PROVISION;
+
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
 	map.m_len = len;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 260c1b3e3ef2..5bc376f6a6f0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1591,6 +1591,7 @@ enum {
 	Opt_max_dir_size_kb, Opt_nojournal_checksum, Opt_nombcache,
 	Opt_no_prefetch_block_bitmaps, Opt_mb_optimize_scan,
 	Opt_errors, Opt_data, Opt_data_err, Opt_jqfmt, Opt_dax_type,
+	Opt_provision, Opt_noprovision,
 #ifdef CONFIG_EXT4_DEBUG
 	Opt_fc_debug_max_replay, Opt_fc_debug_force
 #endif
@@ -1737,6 +1738,8 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
 	fsparam_flag	("reservation",		Opt_removed),	/* mount option from ext2/3 */
 	fsparam_flag	("noreservation",	Opt_removed),	/* mount option from ext2/3 */
 	fsparam_u32	("journal",		Opt_removed),	/* mount option from ext2/3 */
+	fsparam_flag	("provision",		Opt_provision),
+	fsparam_flag	("noprovision",		Opt_noprovision),
 	{}
 };
 
@@ -1826,6 +1829,8 @@ static const struct mount_opts {
 	{Opt_nombcache, EXT4_MOUNT_NO_MBCACHE, MOPT_SET},
 	{Opt_no_prefetch_block_bitmaps, EXT4_MOUNT_NO_PREFETCH_BLOCK_BITMAPS,
 	 MOPT_SET},
+	{Opt_provision, EXT4_MOUNT2_PROVISION, MOPT_SET | MOPT_2},
+	{Opt_noprovision, EXT4_MOUNT2_PROVISION, MOPT_CLEAR | MOPT_2},
 #ifdef CONFIG_EXT4_DEBUG
 	{Opt_fc_debug_force, EXT4_MOUNT2_JOURNAL_FAST_COMMIT,
 	 MOPT_SET | MOPT_2 | MOPT_EXT4_ONLY},
@@ -2977,6 +2982,8 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 		SEQ_OPTS_PUTS("dax=never");
 	} else if (test_opt2(sb, DAX_INODE)) {
 		SEQ_OPTS_PUTS("dax=inode");
+	} else if (test_opt2(sb, PROVISION)) {
+		SEQ_OPTS_PUTS("provision");
 	}
 
 	if (sbi->s_groups_count >= MB_DEFAULT_LINEAR_SCAN_THRESHOLD &&
-- 
2.37.3

