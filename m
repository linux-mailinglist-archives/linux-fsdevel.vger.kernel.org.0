Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22744C7EB7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 00:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiB1Xtv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 18:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiB1Xtr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:49:47 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D1311986C;
        Mon, 28 Feb 2022 15:49:08 -0800 (PST)
Received: by mail-pg1-f169.google.com with SMTP id 139so12949868pge.1;
        Mon, 28 Feb 2022 15:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+biUERzhN3OtcHe6E63JMhZ230AqlvzuRrAUZqIvIbg=;
        b=oi0yLmQJAuRiDZQXDkYNywHoXMFF23URPiXzO7zI2C9BQdGQ9uzwepUbWGsy9uiq3G
         +MpEBbLTi9pNccvdw1IjdLVlyqqE7OOF08x+7BEBsv6v5s8UWtagB3+w4Up+eOlZsv4Z
         HjUJ17fn44xCBJXtiIXLk+G8Glkqx7ty9sAWd5K5Rpjg8/N5/c1FfzoAzsUXCMhVDlMB
         RDYpu1a8HzqXrJ8uS1boXEStxz2XRTihZxn0Wh2IeXF31dYCQAY3Ud61vDtNB8RLcSsh
         ghlFI+A6FYRd8UNAif9N+J6Q/JECH4W+Kg5E6hHpxGtgZ9+oOWA+WaZPRVNkql0YSk7r
         PSfw==
X-Gm-Message-State: AOAM533eXp0ogWD5m3wnBNTw6wjEuWd3O2/Ze6R12J3/TvEpIFmdO4nJ
        6fRsH9+nXpJ1AvblfYLIOBqJdaqF75Q=
X-Google-Smtp-Source: ABdhPJz3fBa6nXqZeI25RJxKqcQBk6Ucrv1dzy69l1uZP96CY3ejSz5VVyVrzaguG68hRDYJo3CXFg==
X-Received: by 2002:a63:1651:0:b0:342:b566:57c4 with SMTP id 17-20020a631651000000b00342b56657c4mr18828400pgw.258.1646092147338;
        Mon, 28 Feb 2022 15:49:07 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id t27-20020aa7939b000000b004ce11b956absm13829905pfe.186.2022.02.28.15.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 15:49:06 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 3/4] ksmbd: increment reference count of parent fp
Date:   Tue,  1 Mar 2022 08:48:32 +0900
Message-Id: <20220228234833.10434-3-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228234833.10434-1-linkinjeon@kernel.org>
References: <20220228234833.10434-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add missing increment reference count of parent fp in
ksmbd_lookup_fd_inode().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c   | 2 ++
 fs/ksmbd/vfs_cache.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 3151ab7d7410..03c3733e54e4 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5764,8 +5764,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (parent_fp) {
 		if (parent_fp->daccess & FILE_DELETE_LE) {
 			pr_err("parent dir is opened with delete access\n");
+			ksmbd_fd_put(work, parent_fp);
 			return -ESHARE;
 		}
+		ksmbd_fd_put(work, parent_fp);
 	}
 next:
 	return smb2_rename(work, fp, user_ns, rename_info,
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 0974d2e972b9..c4d59d2735f0 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -496,6 +496,7 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
 	list_for_each_entry(lfp, &ci->m_fp_list, node) {
 		if (inode == file_inode(lfp->filp)) {
 			atomic_dec(&ci->m_count);
+			lfp = ksmbd_fp_get(lfp);
 			read_unlock(&ci->m_lock);
 			return lfp;
 		}
-- 
2.25.1

