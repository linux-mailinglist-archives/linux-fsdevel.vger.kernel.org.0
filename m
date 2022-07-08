Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F118E56B4FE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jul 2022 11:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237682AbiGHJCN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jul 2022 05:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbiGHJCJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:02:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E5E3337B;
        Fri,  8 Jul 2022 02:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7F5CB82563;
        Fri,  8 Jul 2022 09:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7B1C341CA;
        Fri,  8 Jul 2022 09:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657270926;
        bh=Cos+09RJY3P5XDXoEiCLXXTGQoTT3+qyhXWdGsGOtq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPd5oZr8bh8DkGzmhjWTZUjZWtgCHrrrihc8weKXZZHFnC+zSe0rGXrp0mxPsZQKJ
         tjTTQzlH7CRFisoT9lLLNjmKJCUKSrMZm88O33zzkHRgC0ZlwGVXbpIOBqP7yXwllz
         PWKOVy3Sx6dkTpDXw+jzAIaGS+qcm3ouyskHVE38qVHPbs/lMVYbIT3yJRpIkGRp6J
         wZknYysyFHzxapC6GI7mJk0VLYn3jXouHBPe/2Fb6QpCE60qJUjf1xQlOgMAT9EImO
         rEvR+AZAjAiNHrYzfWH3kOcVCVyoLYDmE2zuO7BfuHp1mvRGdWygQbZ/3qhWUjOU6n
         Zf51G9ky23dJA==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/3] acl: make posix_acl_clone() available to overlayfs
Date:   Fri,  8 Jul 2022 11:01:33 +0200
Message-Id: <20220708090134.385160-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220708090134.385160-1-brauner@kernel.org>
References: <20220708090134.385160-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1893; h=from:subject; bh=Cos+09RJY3P5XDXoEiCLXXTGQoTT3+qyhXWdGsGOtq8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQd/8R19/Gvhvinn/KlGzxYytY8dHy6Kmk/S3SlDMOJUt5f 2pd3dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEyk+DjD//Scu17ran/yfqoz4auVyp Hc9cxo3osVTnyGwW68F27/kGFkmD5v34TnJXvN3a88j4nfVnDKu8WCRbbsfL7mq8dx6/b8ZQMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ovl_get_acl() function needs to alter the POSIX ACLs retrieved from the
lower filesystem. Instead of hand-rolling a overlayfs specific
posix_acl_clone() variant allow export it. It's not special and it's not deeply
internal anyway.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/posix_acl.c            | 3 ++-
 include/linux/posix_acl.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 331edcf54cfd..0634d697f408 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -199,7 +199,7 @@ EXPORT_SYMBOL(posix_acl_alloc);
 /*
  * Clone an ACL.
  */
-static struct posix_acl *
+struct posix_acl *
 posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 {
 	struct posix_acl *clone = NULL;
@@ -213,6 +213,7 @@ posix_acl_clone(const struct posix_acl *acl, gfp_t flags)
 	}
 	return clone;
 }
+EXPORT_SYMBOL_GPL(posix_acl_clone);
 
 /*
  * Check if an acl is valid. Returns 0 if it is, or -E... otherwise.
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index b65c877d92b8..7d1e604c1325 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -73,6 +73,7 @@ extern int set_posix_acl(struct user_namespace *, struct inode *, int,
 			 struct posix_acl *);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
+struct posix_acl *posix_acl_clone(const struct posix_acl *acl, gfp_t flags);
 
 #ifdef CONFIG_FS_POSIX_ACL
 int posix_acl_chmod(struct user_namespace *, struct inode *, umode_t);
-- 
2.34.1

