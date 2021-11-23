Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB0D45A1C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Nov 2021 12:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbhKWLqJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Nov 2021 06:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236419AbhKWLqI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Nov 2021 06:46:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD63961028;
        Tue, 23 Nov 2021 11:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637667780;
        bh=M+JaEg2RT5fj5F0W4xzGQDdowgzdRhhOGLcBClbcOx0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=em50dK6tYhdFvTDXLWywAOQWcU57vnwHDL0Az54tUB3ycI13ckzi9S0/zygYlnyN9
         ku5qleR3eN/s7+TWJZ4uhZKi3vS5jiNAaJGU8TMubJ5sumIoe2hryTP7o/gQyeaUBM
         Mat0WESd0rJtk5ga7natkZT0oCgoyd3odIDx+klXJbNh+obOxpuyv28xRRQET+RK7z
         dFUbIonjrEsPatDkk+dXY/QmzxO1nVOlOB8bB1sh7GKpCO03GuyMRMittWNJccRTin
         2uAkS/nmRsNDmUqnizkVga/ojMTd48HdrrWgWtMgVbpYmYes463hYx8Qs7vd9O6pYF
         nxIV/FHwgTGUw==
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Seth Forshee <sforshee@digitalocean.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 07/10] fs: remove unused low-level mapping helpers
Date:   Tue, 23 Nov 2021 12:42:24 +0100
Message-Id: <20211123114227.3124056-8-brauner@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123114227.3124056-1-brauner@kernel.org>
References: <20211123114227.3124056-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775; h=from:subject; bh=sQNQwAKITQlBki0kjx3b4Jwr64/5Px+y6rVmxx3vUXY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTOuVy6Oq99q6TI45O3/+27VPv7+b9/1/ke8bOcK1i5UsPf w0NtSkcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEuKUZGY7M1/jbqmilxMNqr3Lwxz 9Bg40hK35qv8o3SVrSbjJjnzgjw1P7jDZ9Rf9n4vv3/1a4yNty9roSn+/if0GJt7LmhR1XYwMA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we ported all places to use the new low-level mapping helpers
that are able to support filesystems mounted with an idmapping we can
remove the old low-level mapping helpers. With the removal of these old
helpers we also conclude the renaming of the mapping helpers we started
in [1].

[1]: commit a65e58e791a1 ("fs: document and rename fsid helpers")
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>
CC: linux-fsdevel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 include/linux/mnt_mapping.h | 56 -------------------------------------
 1 file changed, 56 deletions(-)

diff --git a/include/linux/mnt_mapping.h b/include/linux/mnt_mapping.h
index c555b9836d35..f55b62fd27ae 100644
--- a/include/linux/mnt_mapping.h
+++ b/include/linux/mnt_mapping.h
@@ -13,62 +13,6 @@ struct user_namespace;
  */
 extern struct user_namespace init_user_ns;
 
-/**
- * kuid_into_mnt - map a kuid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_into_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return make_kuid(mnt_userns, __kuid_val(kuid));
-}
-
-/**
- * kgid_into_mnt - map a kgid down into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_into_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return make_kgid(mnt_userns, __kgid_val(kgid));
-}
-
-/**
- * kuid_from_mnt - map a kuid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kuid: kuid to be mapped
- *
- * Return: @kuid mapped up according to @mnt_userns.
- * If @kuid has no mapping INVALID_UID is returned.
- */
-static inline kuid_t kuid_from_mnt(struct user_namespace *mnt_userns,
-				   kuid_t kuid)
-{
-	return KUIDT_INIT(from_kuid(mnt_userns, kuid));
-}
-
-/**
- * kgid_from_mnt - map a kgid up into a mnt_userns
- * @mnt_userns: user namespace of the relevant mount
- * @kgid: kgid to be mapped
- *
- * Return: @kgid mapped up according to @mnt_userns.
- * If @kgid has no mapping INVALID_GID is returned.
- */
-static inline kgid_t kgid_from_mnt(struct user_namespace *mnt_userns,
-				   kgid_t kgid)
-{
-	return KGIDT_INIT(from_kgid(mnt_userns, kgid));
-}
-
 /**
  * initial_idmapping - check whether this is the initial mapping
  * @ns: idmapping to check
-- 
2.30.2

