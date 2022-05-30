Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F51B537359
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 May 2022 03:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiE3Bks (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 May 2022 21:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiE3Bkr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 May 2022 21:40:47 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E963EAA5
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:40:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f21so9313976pfa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 May 2022 18:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H7unC4ownPzSgIneOEus8VvlbiKaGr/5bsj+MLLARkw=;
        b=F+jcLhmMa1fdNwt934xZxIvqAZrp3oqK6FasgDl2yEX4zP18/6i2Z/r029sARrDkqm
         vzey0c9a2KdCguchIJnmk1FllnQMQgZosbAgpXnndjFotR0925XK3aMpsw3xKoLjdyut
         7jE5WSGjBeFo7Fi4+ULEMHNBxbHfmj04GS9Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H7unC4ownPzSgIneOEus8VvlbiKaGr/5bsj+MLLARkw=;
        b=IMPInGbOTyALzgxTbF48nQ7+T/rbY7wQDYYb0ttRHGAkM+7LyIqUtXmHOM4opOjZld
         fwFbQQLtvdfPX22+uVbtgLd7gUksE+XDGlQLInKf/zqTGgQBYgLUaNvcYpqIY3NDZ7n0
         yUWCVjZgpWELV/hVbRimNrFEGSqSB/oMIznu3wiQ2GPpqIM0ZyFZNwp333tvwcL868cd
         o0lD23H/3SxyBci8w8gh87pMKAYXX9bnP7hKk3G+Mi6c/jMSp46mzqTPCdtyl43OtVQh
         QYe8aV6GERdTLT3J4LJNm0MAA3GFbYtQQDSlLNRFmaPEtMbw0l6mWAgukemCggUsgzxm
         sSdQ==
X-Gm-Message-State: AOAM532cWdLl7F2KaC0YH85NaiHqJjNB1E4FoksMjH8xokOTYq004ebG
        jqkERq0NCXnw/c/SVzxviJ9pJOeZD9/Lew==
X-Google-Smtp-Source: ABdhPJwdJa+Pqh5Tbb+vDpYt+mvq0qnp6W55sOpBmdl0koBatfm81awmkOl+mUugzpDJBFnI8yAosw==
X-Received: by 2002:a65:668b:0:b0:3f6:4026:97cd with SMTP id b11-20020a65668b000000b003f6402697cdmr44684419pgw.420.1653874845626;
        Sun, 29 May 2022 18:40:45 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b0015f2d549b46sm662285plb.237.2022.05.29.18.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 18:40:45 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v3 2/2] FUSE: Retire superblock on force unmount
Date:   Mon, 30 May 2022 11:39:58 +1000
Message-Id: <20220530113953.v3.2.I692165059274c30b59bed56940b54a573ccb46e4@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220530013958.577941-1-dlunev@chromium.org>
References: <20220530013958.577941-1-dlunev@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

