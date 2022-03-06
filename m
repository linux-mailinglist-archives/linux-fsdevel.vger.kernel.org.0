Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA254CE80B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Mar 2022 02:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbiCFBMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Mar 2022 20:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiCFBL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Mar 2022 20:11:56 -0500
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C27D35DE4;
        Sat,  5 Mar 2022 17:11:05 -0800 (PST)
Received: by mail-pj1-f49.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so11121154pjl.4;
        Sat, 05 Mar 2022 17:11:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5U0EkgWVSJ79epU5pa7kyBPr31R0QM605pzAOhpRvE=;
        b=kTp4MkiF21FEVA8DQwWVqrIp2hUDl7np9csm/QGkJpVowbAmer3IPzy4Q0KPe+txzX
         R13qX+1UgWERxkwm6wNfc4W0UbMtNcCnOVSovTK8ihSeCO2/q7chtAOR8cuKCTP/jDQ5
         O0OgLxMbtn3MjjOUO/0wW3PPRjzVnykB40bnng1tEregiKudZVM8Ry9/C2qhp5GcLPSa
         fVhNa6GREEpnhtvjCVHshT4Ibthr7va1I7QYyNDgfc1EGhbHDPzMZPywmiDLvnsWjAhW
         G4P7sBGxRvuVbsL69L1+jaWmrmVRvW4n4yZ+zOf4wbDfbJSqS3PpdWR3tbvSpd/yjkyc
         BXBw==
X-Gm-Message-State: AOAM530N2Qq0Vjgesn7V5JMAWmqNHHuO0XtnMFr7tOovDwh6Gl4P8jl+
        s6EtlIpGHUxQJ1RAMdNiGrJtw0zXiO8=
X-Google-Smtp-Source: ABdhPJzKs4hnz3OSVnhemV0Sxq2dorrUTqvCkl7hmq20U7wCqA2nmAG1VZQsx9IKM9jrwyidGEY63Q==
X-Received: by 2002:a17:903:244a:b0:151:36cc:2f71 with SMTP id l10-20020a170903244a00b0015136cc2f71mr5751110pls.115.1646529064903;
        Sat, 05 Mar 2022 17:11:04 -0800 (PST)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id d2-20020a056a0024c200b004f6b6817549sm7668110pfv.173.2022.03.05.17.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 17:11:04 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 4/4] ksmbd: increment reference count of parent fp
Date:   Sun,  6 Mar 2022 10:10:45 +0900
Message-Id: <20220306011045.13014-4-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220306011045.13014-1-linkinjeon@kernel.org>
References: <20220306011045.13014-1-linkinjeon@kernel.org>
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
 v2:
   - switch the order of 3/4 and 4/4 patch.

 fs/ksmbd/vfs.c       | 2 ++
 fs/ksmbd/vfs_cache.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index f703dbfe22c0..0b92092f3e8a 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -769,8 +769,10 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, struct path *old_path,
 		if (parent_fp->daccess & FILE_DELETE_LE) {
 			pr_err("parent dir is opened with delete access\n");
 			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
 			goto out5;
 		}
+		ksmbd_fd_put(work, parent_fp);
 	}
 
 	rd.old_mnt_userns	= mnt_user_ns(old_path->mnt),
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index ffb534281836..df600eb04552 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -493,6 +493,7 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct inode *inode)
 	list_for_each_entry(lfp, &ci->m_fp_list, node) {
 		if (inode == file_inode(lfp->filp)) {
 			atomic_dec(&ci->m_count);
+			lfp = ksmbd_fp_get(lfp);
 			read_unlock(&ci->m_lock);
 			return lfp;
 		}
-- 
2.25.1

