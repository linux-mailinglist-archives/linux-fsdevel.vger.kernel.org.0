Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5EA758382
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jul 2023 19:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjGRRcR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jul 2023 13:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRRcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9508DB3;
        Tue, 18 Jul 2023 10:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 167DF616A0;
        Tue, 18 Jul 2023 17:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE2FFC433C7;
        Tue, 18 Jul 2023 17:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689701534;
        bh=axeb2oq3ugfHBp8V7r1e4++IvwdwAuve6L0DU/phV+Y=;
        h=From:Date:Subject:To:Cc:From;
        b=RGGHYKAdr9A1pP7KSCiMF8arJ7ePa1xy5wVRsQ8toGSZKsQAX/s28NQG1OYyQ8HNB
         PXNUg2EZk7ZarV9f3H8m+d1Mhuvi5RDJsUz/xS6829UpLddV73HIdXeRL+D6ZFx32i
         6X5FrOOHoVaat/QK9pYmYXG+zABEJpxYhyOXyhkXtuTaev+nob1frEnf7vXN06ZxuY
         8bi+I/QD39orPeSov7EwjGheVsbcnrRTglOk1276rMbEMKnbSRfSFjHqeOFk/oubBl
         0GBN48lUuOCmLIkochWE3O/XHUQuEzsOe8RHkb6NLGG66ceReDI++GvvwJf2lEha6+
         Af6eXnBB07d/A==
From:   Jeff Layton <jlayton@kernel.org>
Date:   Tue, 18 Jul 2023 13:31:59 -0400
Subject: [PATCH] ext4: fix the time handling macros when ext4 is using
 small inodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-ctime-v1-1-24e2f96dcdf3@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI7MtmQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDc0ML3eSSzNxU3TRDE4OUxFQLcwvLFCWg2oKi1LTMCrA50bG1tQDzzuw
 cVwAAAA==
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=axeb2oq3ugfHBp8V7r1e4++IvwdwAuve6L0DU/phV+Y=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBktsydVvBKNzDju8jE+b0NYW+NkK39lUgCDtOnh
 VRGrTTKhBOJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLbMnQAKCRAADmhBGVaC
 FV9uEAC+J5EE0zF76pogRmUja2GnRdskqbCVOTmRIXPfWiRGO3E8Kwcl2kEKknqmBO/9oLatu2D
 vL3C2B4Fbr78VWkpOobK0qveTjWxvnBJk1KAtIASaXWiqzsRN1YztjAYUbT3u3St39996c7EKZe
 1mFdjwvrKqQXIpkJSLba41/iw6Snem/3DZNMKgA518hpfyetiwK3+FGg8NQ0TZ9ZSRjjQncklA6
 LzjjB27Le1dhQ/X8TWViottRwmtWPqciS9tuVz7iQi82ijmxAr852f9ltYCaHYwLbL0h4U9au8U
 MiO1pwqmjSvsrmLu2blvmMOLWWb/pukEe1rhSbxKuDxNrfCR8I4GP65i9Dxp5tV36Xl+CinlMRP
 2qZ/nxPfNKInKqF1tq84Eg8jRxCXJ/qNEqqQdSYjLB+Erpd6HHpJZKejinJyzpPF7rqAAt9hNA8
 iudm6QXBcKO9WtjPkiiogrBicJPPzyPQ2tGBxcLCcdx8HBrrrBMc10xrNGZrsKPL//h2+5nZ3sU
 BK2lWiiifimf6rbeG/eXyKU/r8AWxGKwJLyXYRg3iswI+1t4QN4HQMi90sN5ooVZgQAcuONbbUA
 Lpa35rXQLXwYdP+jGOzUeEhhA57qXH2a2S5HuOjICAIHC1Om9LzqyzzovegzEGjOStTk4t4gPS4
 21wFYAISREwI9HA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If ext4 is using small on-disk inodes, then it may not be able to store
fine grained timestamps. It also can't store the i_crtime at all in that
case since that fully lives in the extended part of the inode.

979492850abd got the EXT4_EINODE_{GET,SET}_XTIME macros wrong, and would
still store the tv_sec field of the i_crtime into the raw_inode, even
when they were small, corrupting adjacent memory.

This fixes those macros to skip setting anything in the raw_inode if the
tv_sec field doesn't fit, and to properly return a {0,0} timestamp when
the raw_inode doesn't support it.

Cc: Jan Kara <jack@suse.cz>
Fixes: 979492850abd ("ext4: convert to ctime accessor functions")
Reported-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ext4/ext4.h | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2af347669db7..1e2259d9967d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -900,8 +900,10 @@ do {										\
 #define EXT4_INODE_SET_CTIME(inode, raw_inode)					\
 	EXT4_INODE_SET_XTIME_VAL(i_ctime, inode, raw_inode, inode_get_ctime(inode))
 
-#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)			       \
-	EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode), raw_inode, (einode)->xtime)
+#define EXT4_EINODE_SET_XTIME(xtime, einode, raw_inode)				\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime))			\
+		EXT4_INODE_SET_XTIME_VAL(xtime, &((einode)->vfs_inode),		\
+					 raw_inode, (einode)->xtime)
 
 #define EXT4_INODE_GET_XTIME_VAL(xtime, inode, raw_inode)			\
 	(EXT4_FITS_IN_INODE(raw_inode, EXT4_I(inode), xtime ## _extra) ?	\
@@ -922,9 +924,14 @@ do {										\
 		EXT4_INODE_GET_XTIME_VAL(i_ctime, inode, raw_inode));		\
 } while (0)
 
-#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)			       \
-do {									       \
-	(einode)->xtime = EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode), raw_inode);	\
+#define EXT4_EINODE_GET_XTIME(xtime, einode, raw_inode)				\
+do {										\
+	if (EXT4_FITS_IN_INODE(raw_inode, einode, xtime)) 			\
+		(einode)->xtime =						\
+			EXT4_INODE_GET_XTIME_VAL(xtime, &(einode->vfs_inode),	\
+						 raw_inode);			\
+	else									\
+		(einode)->xtime = (struct timespec64){0, 0};			\
 } while (0)
 
 #define i_disk_version osd1.linux1.l_i_version

---
base-commit: c62e19541f8bb39f1f340247f651afe4532243df
change-id: 20230718-ctime-f140dae8789d

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

