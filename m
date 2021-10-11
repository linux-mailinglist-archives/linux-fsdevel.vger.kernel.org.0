Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D03428579
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Oct 2021 05:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbhJKDML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Oct 2021 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbhJKDML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Oct 2021 23:12:11 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E24F3C061570;
        Sun, 10 Oct 2021 20:10:11 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so9478926pgr.11;
        Sun, 10 Oct 2021 20:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKE37Vzcg9+LHwiEWeLufYL/SNzO2ST/ZEGnzU9bkq8=;
        b=hfrg3y0aCHXr43ob3bJBuad5QIDCG9lXSL9aOUf9pGEc4MSrwEtp91iCBrcShRgm8w
         dhSnB1z+otNw2jWe8S0ktt0gEn74l0tk4mfJwdHc3RD+4wJ8mbc4gixsLTL3oStHPUN3
         bUgIbMMrnhzSMLiuW/bAkDDs8uklzMYPUmA98LzVTNqvWsVWMt3jeC4Nk+eDntr36Czk
         z3iUIoMJ3pRfUHv9pgFRgDYTbZJgx8KvlXY+frQBpu/qfaLtbpUX+Vs4tjg1VfFVrZcG
         Jn8LL4xAuR2zskvr/wMgckKsZLu3fU3++cyu4z9GcKLkAvUkXXJfUeVqVJRuq50f8ecH
         GPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sKE37Vzcg9+LHwiEWeLufYL/SNzO2ST/ZEGnzU9bkq8=;
        b=t8OgF2VvqVXb2JPqlNXfAX/FCMtRHSOB6mWKaO6O1u+Sx4R3eXYWEklcn5MLToJjHw
         6qtTSbKN/rJXytMQOQ7IB+4Ho2Ey5p6pMqAQBEAz631+hF/bKliqayZp9ampND/+R+rT
         Is37/3inXKMXgizr5EJavPS/vzO/il99aGdxZ2FJ1rzS0SoGdRlSWRWraxYTjacmWy0z
         3hiLiiZjqdxMl7A0ucsIpsxUvaGPVeKxDrdb1HnZx01EV11ctvetyB4OszDk3U+QBB5p
         1LU6sA1A7aKI8XFAtOorzaDxdFa5b11sG1Ylrg7AEWq0iQmOiw+pChg/dnyLu80q9i61
         TzDA==
X-Gm-Message-State: AOAM530Z4BV9/cNNZQOU1lkGnH/lFuFtXavPgEGh9XEB8TVRjOUJcrwZ
        tdMllPq0VgCyvAKnKPphj3upO+qUxvgS4OQv
X-Google-Smtp-Source: ABdhPJwLsGpBUEXcD0l5uiCmjM5PPfSt1CYwOsJymEOYudaTLCjDtFY5B4Vp3afVAU5K0Chl2BO1UQ==
X-Received: by 2002:a63:5d5f:: with SMTP id o31mr16332181pgm.312.1633921811110;
        Sun, 10 Oct 2021 20:10:11 -0700 (PDT)
Received: from localhost.localdomain ([94.177.118.104])
        by smtp.gmail.com with ESMTPSA id k13sm6121618pfc.197.2021.10.10.20.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 20:10:10 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix GPF in nilfs_mdt_destroy
Date:   Mon, 11 Oct 2021 11:09:56 +0800
Message-Id: <20211011030956.2459172-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In alloc_inode, inode_init_always could return -NOMEM if
security_inode_alloc fails. In its error handling, i_callback and
nilfs_free_inode will be called. However, because inode->i_private is
not initialized due to the failure of security_inode_alloc, the function
nilfs_is_metadata_file_inode can return true and nilfs_mdt_destroy will
be executed to lead to GPF bug.

Fix this bug by moving the assignment of inode->i_private before
security_inode_alloc.

BTW, this bug is triggered by fault injection in the syzkaller.

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index ed0cab8a32db..f6fce84bf550 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -160,6 +160,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_dir_seq = 0;
 	inode->i_rdev = 0;
 	inode->dirtied_when = 0;
+	inode->i_private = NULL;
 
 #ifdef CONFIG_CGROUP_WRITEBACK
 	inode->i_wb_frn_winner = 0;
@@ -194,7 +195,6 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	lockdep_set_class_and_name(&mapping->invalidate_lock,
 				   &sb->s_type->invalidate_lock_key,
 				   "mapping.invalidate_lock");
-	inode->i_private = NULL;
 	inode->i_mapping = mapping;
 	INIT_HLIST_HEAD(&inode->i_dentry);	/* buggered by rcu freeing */
 #ifdef CONFIG_FS_POSIX_ACL
-- 
2.25.1

