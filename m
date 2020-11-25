Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4592C3694
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 03:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgKYCIt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 21:08:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgKYCIt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 21:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606270128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=ho8HpwoPUuZTLBQfNoLjdwsKkHLTcLrfA85VTJfFieI=;
        b=Xh52/9sBQbc1zuBtbdyfKjTLoO6pkaSSabYWgm5ZTiznst1AOfJMswL2b5fmS7DG7VWoQD
        wvUmAKiuS/YZ57TgNNkpzYw1coHa2gu/0xFcXjxQu5grE2CVGnSmp/PTw0Ef6buSwH4r/A
        sxOQNIzlWRIxPJ4tcspyX+MJptcT2qA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-UWkRYCynN56tB8Sg68ecnQ-1; Tue, 24 Nov 2020 21:08:45 -0500
X-MC-Unique: UWkRYCynN56tB8Sg68ecnQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64E98101AFA7;
        Wed, 25 Nov 2020 02:08:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.60.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEFBC1002391;
        Wed, 25 Nov 2020 02:08:42 +0000 (UTC)
From:   XiaoLi Feng <xifeng@redhat.com>
To:     linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Cc:     Xiaoli Feng <fengxiaoli0714@gmail.com>
Subject: [PATCH v2] fs/stat: set attributes_mask for STATX_ATTR_DAX
Date:   Wed, 25 Nov 2020 10:08:40 +0800
Message-Id: <20201125020840.1275-1-xifeng@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiaoli Feng <fengxiaoli0714@gmail.com>

keep attributes and attributes_mask are consistent for
STATX_ATTR_DAX.
---
Hi,
Please help to review this patch. I send this patch because xfstests generic/532
is failed for dax test.

 fs/stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index dacecdda2e79..4619b3fc9694 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -80,8 +80,10 @@ int vfs_getattr_nosec(const struct path *path, struct kstat *stat,
 	if (IS_AUTOMOUNT(inode))
 		stat->attributes |= STATX_ATTR_AUTOMOUNT;
 
-	if (IS_DAX(inode))
+	if (IS_DAX(inode)) {
 		stat->attributes |= STATX_ATTR_DAX;
+		stat->attributes_mask |= STATX_ATTR_DAX;
+	}
 
 	if (inode->i_op->getattr)
 		return inode->i_op->getattr(path, stat, request_mask,
-- 
2.18.1

