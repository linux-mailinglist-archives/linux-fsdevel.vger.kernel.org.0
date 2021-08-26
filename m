Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27AB3F8BF5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Aug 2021 18:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243203AbhHZQVd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Aug 2021 12:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243150AbhHZQVU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:21:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC63961157;
        Thu, 26 Aug 2021 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629994833;
        bh=bxPw9/IjvBWN735Tv0FZOQZfWM7OnabC7ZLfvIh0/jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IAQhr/zxlKAYMdCpfN9T+Hj+BWXIagKruSwiEMdwnWEbKXgD+42XqdrfISzcnGOiI
         KrIK/UnJ7eCenQkwh/YVwm2ZpE+26QWknxZZ7OB680voFIvvttpKlJeIH7SKByXuyq
         V1IRuv1C+d5/j7XFMGlq/UslzHU+ID1dc29pjB6/xTjAFnunEjL8FZ5WB8ahHJ4LTL
         AHIVcx39pPrp7hn4P5EPoMgjJDifrOcsExqEiU2oiRlzGpx2V1UPbelJcEexLzbCRm
         ZMU9owkvjVFohyOucuhnp2KrUUFF8nDBt4CMdsr2VCZBqttkcs4sEhqdGgLeEXQ72T
         siny2g3fCgFeA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com, xiubli@redhat.com, lhenriques@suse.de,
        khiremat@redhat.com, ebiggers@kernel.org
Subject: [RFC PATCH v8 18/24] ceph: make d_revalidate call fscrypt revalidator for encrypted dentries
Date:   Thu, 26 Aug 2021 12:20:08 -0400
Message-Id: <20210826162014.73464-19-jlayton@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826162014.73464-1-jlayton@kernel.org>
References: <20210826162014.73464-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If we have a dentry which represents a no-key name, then we need to test
whether the parent directory's encryption key has since been added.  Do
that before we test anything else about the dentry.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/dir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 4fa776d8fa53..7977484d0317 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1700,6 +1700,10 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	struct inode *dir, *inode;
 	struct ceph_mds_client *mdsc;
 
+	valid = fscrypt_d_revalidate(dentry, flags);
+	if (valid <= 0)
+		return valid;
+
 	if (flags & LOOKUP_RCU) {
 		parent = READ_ONCE(dentry->d_parent);
 		dir = d_inode_rcu(parent);
@@ -1712,8 +1716,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		inode = d_inode(dentry);
 	}
 
-	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
-	     dentry, inode, ceph_dentry(dentry)->offset);
+	dout("d_revalidate %p '%pd' inode %p offset 0x%llx nokey %d\n", dentry,
+	     dentry, inode, ceph_dentry(dentry)->offset, !!(dentry->d_flags & DCACHE_NOKEY_NAME));
 
 	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
 
-- 
2.31.1

