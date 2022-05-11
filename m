Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880325228FE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 03:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240480AbiEKBbo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 May 2022 21:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240518AbiEKBbb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 May 2022 21:31:31 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550A44C788
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 18:31:29 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c11so402226plg.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 May 2022 18:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nyT+TEM6YfXjFwh6RP3Mgulu/QW39cAOrSoKYlACyaM=;
        b=meI7q9780fzkqj6a0HhsAQmhu3va+coXBZlxQAwgjwFiDPhNeV2GiDAIgDzjWT5Dni
         rsOyD5RkxOqImMxvbKnwTxybY7H6JTfuS2lsAMjuWh1HUHkXQ4PRvCUSB5wj8KZgbyXQ
         gpQmQW533keZw+eCzRQfdd5meZ/0WUPyR7ifA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyT+TEM6YfXjFwh6RP3Mgulu/QW39cAOrSoKYlACyaM=;
        b=GG7HVu45VS7ClcWeD7vp8oOSErWCc0KCdcNeCOeiM0TA+H/OI+7R29yNV5yRE/EYxl
         EvDXQVSKPHV6eDOuN0+86Iw2R67i2/eExGKWHkwiC/SMKwXJiuS6mtAhGZgHbSe9+lTU
         n7pUhLIrXeETQHj9byD/7L9ALEsxGbg9xSPL3AaEi/ZtzCTasnD1gFHwe/NjPzu2IWkh
         MO+4fqWqY3fVdSozwf7DHE0f2QBKcBGgjHWgE2neXmE6ZtT/0HlhRRTL2itLQTzfTozu
         LhP1/9FgkjzA5s4CG7Rxhb/JS49jeoTMxc46IGhu6/aY8SPu9yqyr58aLq15oO9Kke1O
         Qvvg==
X-Gm-Message-State: AOAM532raACtyUbrIcfeEJA6qSiXcOddTLs647NMduOV0qd/qgMOHU+3
        nO8BiGKXpQ+lgpo4Dk8Bo1BaOOET+Hbq6A==
X-Google-Smtp-Source: ABdhPJyVmsGY+I+4n3pCMGU/dXV5in4S+vZlRPTbhVbpJV4FxM/OsoM7PfiNLPYpVZRQ812YNj6kFA==
X-Received: by 2002:a17:903:40cf:b0:15e:9bd0:2cab with SMTP id t15-20020a17090340cf00b0015e9bd02cabmr22614313pld.170.1652232688669;
        Tue, 10 May 2022 18:31:28 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090aa50400b001cd4989feecsm2494749pjq.56.2022.05.10.18.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:31:28 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 2/2] FUSE: Mark super block defunc on force unmount
Date:   Wed, 11 May 2022 11:30:57 +1000
Message-Id: <20220511113050.2.I103b609e957667ca427c689fd83990e6ab32f3dd@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511013057.245827-1-dlunev@chromium.org>
References: <20220511013057.245827-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

Signed-off-by: Daniil Lunev <dlunev@chromium.org>
---

 fs/fuse/inode.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff88..e2ad3c9b2d5c5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -476,8 +476,15 @@ static void fuse_umount_begin(struct super_block *sb)
 {
 	struct fuse_conn *fc = get_fuse_conn_super(sb);
 
-	if (!fc->no_force_umount)
-		fuse_abort_conn(fc);
+	if (fc->no_force_umount)
+		return;
+
+	sb->s_defunc = true;
+	if (sb->s_bdi != &noop_backing_dev_info) {
+		bdi_put(sb->s_bdi);
+		sb->s_bdi = &noop_backing_dev_info;
+	}
+	fuse_abort_conn(fc);
 }
 
 static void fuse_send_destroy(struct fuse_mount *fm)
-- 
2.31.0

