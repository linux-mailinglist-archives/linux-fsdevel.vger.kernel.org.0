Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4F21F9CB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730213AbgFOQLk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:11:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37986 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728585AbgFOQLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:11:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592237499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AFpokfWrHaipWh7YJWyhlDrGpwMEhWoMK+9HrZUUdI4=;
        b=T7ZHVXN41X30W2qmLZOPZK4nieZEQF8MFTBzW1ZaXxNGQ9EXKv2OMGHDG+2Mr9I1mhA9lH
        QuVpBieCrFdiO4wUT11z495fLMhIPn8GnIcqYVIRTXCS2EgLIuq535RBdyoNtEEKq/XvmZ
        xoACG+wsM1LPix/OiIrjfwiJXf+JDE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-2T1UwQj2Ocqvg3-Q18Dsew-1; Mon, 15 Jun 2020 12:11:37 -0400
X-MC-Unique: 2T1UwQj2Ocqvg3-Q18Dsew-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F51901D06;
        Mon, 15 Jun 2020 16:02:49 +0000 (UTC)
Received: from max.home.com (unknown [10.40.195.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49EFD5D9CD;
        Mon, 15 Jun 2020 16:02:46 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] iomap: Make sure iomap_end is called after iomap_begin
Date:   Mon, 15 Jun 2020 18:02:44 +0200
Message-Id: <20200615160244.741244-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure iomap_end is always called when iomap_begin succeeds: the
filesystem may take locks in iomap_begin and release them in iomap_end,
for example.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/iomap/apply.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 76925b40b5fd..c00a14d825db 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -46,10 +46,10 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	ret = ops->iomap_begin(inode, pos, length, flags, &iomap, &srcmap);
 	if (ret)
 		return ret;
-	if (WARN_ON(iomap.offset > pos))
-		return -EIO;
-	if (WARN_ON(iomap.length == 0))
-		return -EIO;
+	if (WARN_ON(iomap.offset > pos) || WARN_ON(iomap.length == 0)) {
+		written = -EIO;
+		goto out;
+	}
 
 	trace_iomap_apply_dstmap(inode, &iomap);
 	if (srcmap.type != IOMAP_HOLE)
@@ -80,6 +80,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
 	written = actor(inode, pos, length, data, &iomap,
 			srcmap.type != IOMAP_HOLE ? &srcmap : &iomap);
 
+out:
 	/*
 	 * Now the data has been copied, commit the range we've copied.  This
 	 * should not fail unless the filesystem has had a fatal error.

base-commit: 97e0204907ac4c42c6e94ef466a047523f34b853
-- 
2.26.2

