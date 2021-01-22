Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F158C300A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 18:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbhAVRwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 12:52:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729481AbhAVRwE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 12:52:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5002E23AA1;
        Fri, 22 Jan 2021 17:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611337883;
        bh=yLO+A1ljIfqO/p2jKFSqSiZv9SibpfihSeI5YzB7Mq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kzh03ULZ551nNc3tCxjeqczVLHHfYMVA5OMJfwS3yvJN/LeW3vZJjP0mRlUAUB5W/
         crh6N/QwkPHHgB1+HOOwD7GtJYzQ65CRIMvFhpOLMMvzmq+Sz/U6PJlUyQnCUcj666
         df5D+zasEmkj0YqniXYbHP0I1LJHUmw14gB1k7gYWsRY58xeVr1YWlc0MdMq/WrVE/
         +LT73p8lMJw89Y+7oOlTm73kKokopbBePXn87T2H3Mg53/UVAQUihfNXz8KsOdr2L3
         292tebiJoDK0eX2kSmYyuswG6Qd3jF5VssddnruuFj7/+vzLSNRCXNcuLEWOfMmHK1
         /rKMNY2t/m4yA==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        willy@infradead.org, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/6] ceph: fix invalidation
Date:   Fri, 22 Jan 2021 12:51:15 -0500
Message-Id: <20210122175119.364381-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210122175119.364381-1-jlayton@kernel.org>
References: <20210122175119.364381-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ensure that we invalidate the fscache whenever we go to invalidate the
pagecache.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c  | 1 +
 fs/ceph/inode.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 21ba949ca2c3..0102221db7bf 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1867,6 +1867,7 @@ static int try_nonblocking_invalidate(struct inode *inode)
 	u32 invalidating_gen = ci->i_rdcache_gen;
 
 	spin_unlock(&ci->i_ceph_lock);
+	ceph_fscache_invalidate(inode);
 	invalidate_mapping_pages(&inode->i_data, 0, -1);
 	spin_lock(&ci->i_ceph_lock);
 
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5d20a620e96c..2d424b41a8b9 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1863,6 +1863,7 @@ static void ceph_do_invalidate_pages(struct inode *inode)
 	orig_gen = ci->i_rdcache_gen;
 	spin_unlock(&ci->i_ceph_lock);
 
+	ceph_fscache_invalidate(inode);
 	if (invalidate_inode_pages2(inode->i_mapping) < 0) {
 		pr_err("invalidate_pages %p fails\n", inode);
 	}
-- 
2.29.2

