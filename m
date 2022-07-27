Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7340582061
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jul 2022 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiG0Gpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiG0Gov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:51 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052D640BDA
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so1222058pjf.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jul 2022 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XDNROrSqKzyA1L1M+SB07diVx6X/b8xPoeGY/Lj78Aw=;
        b=GpIKOXIWUDtcIO0SokOTsUOk5j320G3Xti70ANRzozbGTAoONxsCskms0m1FM4iZax
         G8CG/9OK5j7tfbvPwFjAeFpGnWSaw98voWkjYrIckmrR1TWV33Imol32Bkn4T91gRG59
         Xq2O02ojrRvXM9jgOBn6/uYONtxri39d1GPMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XDNROrSqKzyA1L1M+SB07diVx6X/b8xPoeGY/Lj78Aw=;
        b=HX5qBjFJvTYkSLmfAfsejWjGMkzld0vTh9H/GmASCE+LNceT+Y8W8UEW9zoj8k7mwR
         Bx88WwCZ61edvWqVCB1j2IEZ+pYfn439rxxd05dVi/tLr/abz9SrZGAMDaySCYbfH2Id
         51/U81jrN0q1D4+WteuCAJ0mzgtiJx1QGFBtuPXmFeF2hPERsAsYV+FcK4fVXI//yeaX
         Cb9O+MxVAEK2eP041N1mi1CnuKGzSsees4sCAh1MZBE4kWLrxd3UT6Mqtqiqih5DKeTT
         Gz4aMIsDiO5k3w0R1JmI2aanMrLEnwJD1uMrIZNYTrIlFKKgJuqc7ldN5xN/WtNac2Rl
         9mvQ==
X-Gm-Message-State: AJIora/DGwjgpyG8GLimwLpChotkXMearE7+mVwsUhbiY21S3lqEstWu
        dKMtMCifaGdHphSBKHtzuQq+Tg==
X-Google-Smtp-Source: AGRyM1uex+Nm55OX2ZGryHSVY2YxmlleVBEPD5U7Boyj5d+KDkszRor2X7950nOxTGuLbEPNPBBvSw==
X-Received: by 2002:a17:902:a382:b0:16d:b787:9e86 with SMTP id x2-20020a170902a38200b0016db7879e86mr374930pla.105.1658904287478;
        Tue, 26 Jul 2022 23:44:47 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b0016bdf0032b9sm12627001pln.110.2022.07.26.23.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:44:47 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v5 2/2] FUSE: Retire block-device-based superblock on force unmount
Date:   Wed, 27 Jul 2022 16:44:25 +1000
Message-Id: <20220727164328.v5.2.Ia8e6b14cb01caf13a4290236e37b04dff5626bc7@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220727064425.4144478-1-dlunev@chromium.org>
References: <20220727064425.4144478-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Force unmount of FUSE severes the connection with the user space, even
if there are still open files. Subsequent remount tries to re-use the
superblock held by the open files, which is meaningless in the FUSE case
after disconnect - reused super block doesn't have userspace counterpart
attached to it and is incapable of doing any IO.

This patch adds the functionality only for the block-device-based
supers, since the primary use case of the feature is to gracefully
handle force unmount of external devices, mounted with FUSE. This can be
further extended to cover all superblocks, if the need arises.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

Changes in v5:
- Restrict retire_super call in FUSE to be issued for fuseblk only.
- Commit message

Changes in v2:
- Use an exported function instead of directly modifying superblock

 fs/fuse/inode.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff88..9e931f53794bb 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -476,8 +476,14 @@ static void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (!fc->no_force_umount)
-		fuse_abort_conn(fc);
+	if (fc->no_force_umount)
+		return;
+
+	fuse_abort_conn(fc);
+
+	// Only retire block-device-based superblocks.
+	if (sb->s_bdev != NULL)
+		retire_super(sb);
 }
 
 static void fuse_send_destroy(struct fuse_mount *fm)
-- 
2.31.0

