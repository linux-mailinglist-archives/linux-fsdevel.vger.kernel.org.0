Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D18A31D9DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 13:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhBQM7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 07:59:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231709AbhBQM7b (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:59:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D2C2C64E5B;
        Wed, 17 Feb 2021 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613566730;
        bh=zRe/lqkidHiEoAwmrgUeqTtafbyLTn3SRsEdUj4nkPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K+BN8sEw/4bvapDjVdZXvVvNQoymM/Jodg9RgZMMNl26VCIW4eoJ7FZ/GrXtvQRTg
         HSo3tZ8pNAsEFip2GbhZYlRSxjVANEfcaKShxloWIt8OscKAR3iCmvKIKIqvQo7t4v
         n2EhN4tBzphD0aToehpiZYTlANY4ED8J2b68fR8O7QANXbaiCuTVAla2kzLUMz7FuM
         6NpRE7Ys7h26j6vP3sjpuwRFGRqIoOcGMN3MKLoxX2vYg9j9p5nJN4tMtK8dR9KPZ7
         FePrbWf4BYmI6rRQerofefOhIWpxAtV6u6Kht95mPIaxF40vFWqPQmyFDhtZ5xUaXK
         PMNyHfVhv8U9Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     dhowells@redhat.com, idryomov@gmail.com
Cc:     xiubli@redhat.com, ceph-devel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/6] ceph: fix fscache invalidation
Date:   Wed, 17 Feb 2021 07:58:42 -0500
Message-Id: <20210217125845.10319-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210217125845.10319-1-jlayton@kernel.org>
References: <20210217125845.10319-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that we invalidate the fscache whenever we invalidate the
pagecache.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
Cc: linux-cachefs@redhat.com
Cc: linux-fsdevel@vger.kernel.org
---
 fs/ceph/caps.c  | 1 +
 fs/ceph/inode.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index ca07dfc60652..c40f713d6d21 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1867,6 +1867,7 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	u32 invalidating_gen = ci->i_rdcache_gen;
 
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_fscache_invalidate(inode);
 	invalidate_mapping_pages(&inode->i_data, 0, -1);
 	spin_lock(&ci->i_ceph_lock);
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index adc8fc3c5d85..2caa6df0bcdf 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1906,6 +1906,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	orig_gen = ci->i_rdcache_gen;
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_fscache_invalidate(inode);
 	if (invalidate_inode_pages2(inode->i_mapping) < 0) {
 		pr_err("invalidate_pages %p fails\n", inode);
 	}
-- 
2.29.2

