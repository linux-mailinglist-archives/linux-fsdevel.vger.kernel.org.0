Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5797658A58
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 09:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbiL2IO3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 03:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbiL2IOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:14:00 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5413D56
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:15 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so15120188pjg.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Dec 2022 00:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8DbNiGbTyMPWSOnHF8Kc/zLYgsGw2pv5SS5s5v0R+s=;
        b=g9XepsvU/uDTIkRU/0RfRztiaH4ysj5lPHnKvHquo4r2R81/t9Ab0n0lHqtHLvd81L
         Q99LTPfepq7s8nl2fawi9Q1Hj0cYT+r116Jc2iu54KTeJljXqfbrFWykA1a3MtFEjxbc
         IILAMKAGR6lSnvUPpxgAk36YR2QLLOe+csueQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8DbNiGbTyMPWSOnHF8Kc/zLYgsGw2pv5SS5s5v0R+s=;
        b=jA1zp7/Dp+ut7PTmnQ21XRlGUuM0ZDSMkBKPKDlQvR3/NkKHRawZmqf4mScT1w4yu2
         jU03k8cbc9AvtRjYvEH2PyRZDQFXfBcJhnMOyX/8xC4kpSpOKoScV3V9k9b/sxzEFOac
         SDI3RbArglFUBFGAAq+tSJNb+E6uy2S3Rnxf830tF9Ms8+p5YPuuA741JtNLh3fbf+kO
         NuY4kU8Iq0C6QY/kDE1N0pU43ByQDAITD9IWQGCTGW9QKG1aoS2RdOfNVSeQCZtPAgm4
         CcMLgSiBHicMz/ojenD01iId9GyUGylnf5j5wfLbm7ft4kgjeC3Nmto/OR5WcWL/Mc/N
         dMsw==
X-Gm-Message-State: AFqh2krvdDgO+0KntySYkBNYw3jcp5CgsTRkawlD4GaRZPQQJMNR+awI
        ykrDz8fu6HhTwX3S9Ec2Q0MxQlpoxuig6KlC
X-Google-Smtp-Source: AMrXdXtgQYYpwQ6pz9x9/465K8tsLdsmt3F7AV27atGdHHls0t4amkRI67RTybj/weosU20glWNaiw==
X-Received: by 2002:a17:903:228a:b0:191:217f:b2ea with SMTP id b10-20020a170903228a00b00191217fb2eamr42495271plh.40.1672301595208;
        Thu, 29 Dec 2022 00:13:15 -0800 (PST)
Received: from sarthakkukreti-glaptop.hsd1.ca.comcast.net ([2601:647:4200:b5b0:75ff:1277:3d7b:d67a])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902e9cc00b00192820d00d0sm6496325plk.120.2022.12.29.00.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:13:14 -0800 (PST)
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
Subject: [PATCH v2 7/7] ext4: Add a per-file provision override xattr
Date:   Thu, 29 Dec 2022 00:12:52 -0800
Message-Id: <20221229081252.452240-8-sarthakkukreti@chromium.org>
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

Adds a per-file provision override that allows select files to
override the per-mount setting for provisioning blocks on allocation.

This acts as a mechanism to allow mounts using provision to
replicate the current behavior for fallocate() and only preserve
space at the filesystem level.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 fs/ext4/extents.c | 32 ++++++++++++++++++++++++++++++++
 fs/ext4/xattr.h   |  1 +
 2 files changed, 33 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a73f44264fe2..9861115681b3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4428,6 +4428,26 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	return err;
 }
 
+static int ext4_file_provision_support(struct inode *inode)
+{
+	char provision;
+	int ret =
+		ext4_xattr_get(inode, EXT4_XATTR_INDEX_TRUSTED,
+			       EXT4_XATTR_NAME_PROVISION_POLICY, &provision, 1);
+
+	if (ret < 0)
+		return ret;
+
+	switch (provision) {
+	case 'y':
+		return 1;
+	case 'n':
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 				  ext4_lblk_t len, loff_t new_size,
 				  int flags)
@@ -4440,12 +4460,24 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	struct ext4_map_blocks map;
 	unsigned int credits;
 	loff_t epos;
+	bool provision = false;
+	int file_provision_override = -1;
 
 	/*
 	 * Attempt to provision file blocks if the mount is mounted with
 	 * provision.
 	 */
 	if (test_opt2(inode->i_sb, PROVISION))
+		provision = true;
+
+	/*
+	 * Use file-specific override, if available.
+	 */
+	file_provision_override = ext4_file_provision_support(inode);
+	if (file_provision_override >= 0)
+		provision &= file_provision_override;
+
+	if (provision)
 		flags |= EXT4_GET_BLOCKS_PROVISION;
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0b15a8..69e97f853b0c 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -140,6 +140,7 @@ extern const struct xattr_handler ext4_xattr_security_handler;
 extern const struct xattr_handler ext4_xattr_hurd_handler;
 
 #define EXT4_XATTR_NAME_ENCRYPTION_CONTEXT "c"
+#define EXT4_XATTR_NAME_PROVISION_POLICY "provision"
 
 /*
  * The EXT4_STATE_NO_EXPAND is overloaded and used for two purposes.
-- 
2.37.3

