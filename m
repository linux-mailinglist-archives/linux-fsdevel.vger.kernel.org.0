Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E2C52405B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348842AbiEKWgw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 18:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348834AbiEKWgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 18:36:46 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAD5387BF
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:36:46 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x18so3210748plg.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 15:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=si1Rwhr5j9axuLzTcmMSWZj1IF9byAf7FS+JUx2lWqQ=;
        b=Y1mOoFpuxbMkem3auol/NJSBXB/PCujD/y1PVTZDkChfddxepgxXfoqshDcktwqGpP
         ARhYZ7veM2ssN8ZclXRl3dw+H03xpWbYiIROWS3VPFrzWnf2UPTo/ZvCBunsjbo0iayU
         1kzdoHqbypVeAr1XxsMdL2S/gZSskNsyRZymg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=si1Rwhr5j9axuLzTcmMSWZj1IF9byAf7FS+JUx2lWqQ=;
        b=kOxD0LNoznJWSDIwVTpSnzbsOV6t1SWnCJkkK4MOaIqqteVhzAbgYdr0qLkHWsnlOK
         0aySw6cf7k3lWDVZtK9UANpYRN5oJmpKKDnH5rGB+g0OLnBX/jT8+gYIQRxK47I8oGkB
         W+kQAYjaFMNOAZN9UCsCeuetJr6la4CqAR9jgWj8bizkpgWncYMGJiQV8USO+Linovq5
         RKS65VdsushATnd0rCVvkb3B+PW2/XstxdajY221ZCEblh+R1COAiCmFZpXHhsTwc8UG
         GaJmsLIip1FoClXF8dI7k6o4aYIuoTVFBYUxn9VdXZ5dlvwg95d091ul1+V5tPN64hs6
         ECSA==
X-Gm-Message-State: AOAM531VJgQSXLHraVj6uuS1MJEjeLAv4jT0QDvGIVowWT05c5GDgHNL
        xGmwO3ei0jwDrFiYsTsWqDEDbVM+sa+GpA==
X-Google-Smtp-Source: ABdhPJzhp1wK1HcHgFgRwXNdOwOYc2AkkaevEP6SkCY6EqKLZyEDAmT5vf1CXRqTBa5UrZOjEt/Liw==
X-Received: by 2002:a17:90b:4a08:b0:1dc:6cc1:3d24 with SMTP id kk8-20020a17090b4a0800b001dc6cc13d24mr7728354pjb.131.1652308605699;
        Wed, 11 May 2022 15:36:45 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b0015e8d4eb1d2sm2391855pld.28.2022.05.11.15.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:36:45 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     hch@infradead.org, fuse-devel@lists.sourceforge.net, tytso@mit.edu,
        miklos@szeredi.hu, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v2 2/2] FUSE: Retire superblock on force unmount
Date:   Thu, 12 May 2022 08:29:10 +1000
Message-Id: <20220512082832.v2.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220511222910.635307-1-dlunev@chromium.org>
References: <20220511222910.635307-1-dlunev@chromium.org>
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

