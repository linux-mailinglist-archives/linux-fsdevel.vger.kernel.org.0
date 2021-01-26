Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D923F30402E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 15:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404337AbhAZOO4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 09:14:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392689AbhAZNls (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:41:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72424229C9;
        Tue, 26 Jan 2021 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611668468;
        bh=OaZLeWPsD/eZf264wEiS+6LRODx5CuEYHyrxEn87Yp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EisiiPB6Kr94U5C5zBciXPFhUFtPg5jPT9Nqc+eQHdW5LgKE9eaxx7fS400jjQiOY
         Ujgdx4GVFvOAUKCd5TrUEfWP1MjMHMDMCslMQq2MyrwZW1aDgCFW0gbmFcm5a1EdHK
         on3ehWuJbM5rpPVhbrqWzng2mGzoUocoOlAH/8fZwOeKHU4Nv+Gf2X5ZF+CdlzDl6I
         McDawQ0M5A3EVGGtslFWyst4GWJAUf1RrEBs6Uh7W8CRmcr+o3ylXoLkPXIlQvM0Zv
         7UDVFVih6zGokTMIxTO435gbL4R8/i02l4tqf61nV53d8VMSzUkqchbqQmuk8d9ub6
         TLXVWUPaWNwZg==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, idryomov@gmail.com, dhowells@redhat.com
Cc:     willy@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [PATCH 3/6] ceph: fix fscache invalidation
Date:   Tue, 26 Jan 2021 08:41:00 -0500
Message-Id: <20210126134103.240031-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210126134103.240031-1-jlayton@kernel.org>
References: <20210126134103.240031-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that we invalidate the fscache whenever we invalidate the
pagecache.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
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

