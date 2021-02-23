Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1BE322B30
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Feb 2021 14:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhBWNIC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Feb 2021 08:08:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232700AbhBWNHP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Feb 2021 08:07:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4549964E58;
        Tue, 23 Feb 2021 13:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614085595;
        bh=oI6F4eOnVGdQU5NM0wAxSp3n2bPXLAtJV1L6DKnkpjg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YHCoatOk8f4a2IpHmxCRPjCsl+V0jAlgoOsgMuok7a7+POhDfwdIrm2DpC5ZwiT/W
         SiTFP5bcPrO88RvrasIuIAQd8FK2vC6sUeJVpjHigO87OmV8Bc82mRkqYyJSLVXTBv
         7ZzdPGObe3YoXGE4jQmb31jErzrpAs9Lqs1AnStxKCXK0TrgXsa/lNYOXsBH/004Bo
         CAB2OpOdRpsG1TGL5Gufs1nhWoLK4iS5c/IZi1MqEUzRQ++nXPDDg6XE2OwjzM13j6
         tcSC/ZJdzNYJn2YPJofTrPuSvv8kKdiSL3+6qCzIzZs1Z4zw0XRo5VrArg1vsL+sjL
         YJvqniKfr0D9Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org
Cc:     idryomov@gmail.com, xiubli@redhat.com, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
        willy@infradead.org
Subject: [PATCH v3 3/6] ceph: fix fscache invalidation
Date:   Tue, 23 Feb 2021 08:06:26 -0500
Message-Id: <20210223130629.249546-4-jlayton@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210223130629.249546-1-jlayton@kernel.org>
References: <20210223130629.249546-1-jlayton@kernel.org>
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
index b256fc8c68d0..e12e4cdefac1 100644
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

