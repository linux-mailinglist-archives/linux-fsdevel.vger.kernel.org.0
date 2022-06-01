Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6F4539AA0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jun 2022 03:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348915AbiFABLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 May 2022 21:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348918AbiFABL3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 May 2022 21:11:29 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419A995A12
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:27 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id c14so395036pgu.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 May 2022 18:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nKEUJeXWAGT71M4N/DTrrCo2nCewg6Tf9KzJevsB9XY=;
        b=m4J4YCPDnXF//qtjts865ZEuKBRqf0VgVqj8gZK53Befqo6FPRUTVnDwec4dQ580d9
         aqJFMSXZjyHyKdqTbS6lLV0hIrBiojyaSD+b57dVyQTsRs5qzwshLrXr6e7DI22TdbpQ
         ygOKjK8SeE4jIxf2tqNA2rfo4UpBFDX2rRNg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nKEUJeXWAGT71M4N/DTrrCo2nCewg6Tf9KzJevsB9XY=;
        b=wC3qTW1cMOiynF0v28mi1CRH8TMzajmj86pW7igfTo7R3H33VdSGk3IVIK24+7Dmpw
         6xkK3Bm+m6nr6bWEGHfwfK7XUwNbXNUfIw2n/SIifco//7Ny5NuKQNrc3P+R8v8pCztQ
         GtexRBy8iMDtgGXx1wn7jEL16Wy4/oaXWC1PH8HsaaScwQLxu0JHUmvXRayaLKH4hM22
         kQ1GA28EwojhQBTU5RJC5EJYBFB+6cBV+ksk907rASUauzj24I180kRhODno6E2t3OmW
         BVgqUSWpKMTFbTBO2x550aWLCJtxHPBEY0uKAGgCFONCnvm8jhtIQO8CcaChF/qMhkbx
         6K9w==
X-Gm-Message-State: AOAM531VKIbcEjaMAKA0jcyagLHzT9OkWkjc20x3hN6FLJ03xnMSlcTi
        9cpzS87Z5XIhMRc+o6fZne9/b1F6qujutQ==
X-Google-Smtp-Source: ABdhPJynnTGiG4LmI3+NfkdP8fOwQQyaZS2a5FcA44p1Pbzas8YuxiUlcinQhaCxvItUIGBAXtUoYg==
X-Received: by 2002:a05:6a00:15c5:b0:518:9848:4915 with SMTP id o5-20020a056a0015c500b0051898484915mr47269716pfu.62.1654045886479;
        Tue, 31 May 2022 18:11:26 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id mi16-20020a17090b4b5000b001df6173700dsm2621916pjb.49.2022.05.31.18.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 18:11:26 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
X-Google-Original-From: Daniil Lunev <dlunev@google.com>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        Daniil Lunev <dlunev@chromium.org>,
        Daniil Lunev <dlunev@google.com>
Subject: [PATCH v4 2/2] FUSE: Retire superblock on force unmount
Date:   Wed,  1 Jun 2022 11:11:03 +1000
Message-Id: <20220601111059.v4.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220601011103.12681-1-dlunev@google.com>
References: <20220601011103.12681-1-dlunev@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Daniil Lunev <dlunev@chromium.org>

Force unmount of FUSE severes the connection with the user space, even
if there are still open files. Subsequent remount tries to re-use the
superblock held by the open files, which is meaningless in the FUSE case
after disconnect - reused super block doesn't have userspace counterpart
attached to it and is incapable of doing any IO.

Signed-off-by: Daniil Lunev <dlunev@chromium.org>

Signed-off-by: Daniil Lunev <dlunev@google.com>
---

(no changes since v3)

Changes in v3:
- No changes

Changes in v2:
- Use an exported function instead of directly modifying superblock

 fs/fuse/inode.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff88..8875361544b2a 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -476,8 +476,11 @@ static void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (!fc->no_force_umount)
-		fuse_abort_conn(fc);
+	if (fc->no_force_umount)
+		return;
+
+	fuse_abort_conn(fc);
+	retire_super(sb);
 }
 
 static void fuse_send_destroy(struct fuse_mount *fm)
-- 
2.31.0

