Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97967770B06
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 23:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjHDVd3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHDVd2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6486E2
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 14:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691184760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/6uD9P+MNfwKoMtFQjp8y/Prw7N6snYRHghi9zMz1dA=;
        b=YMbAAjkq0OrjR1rRPhRKprYGRmlVcn9CKvG+a6gZOhrpVK18ErIAih1V1LrDUtYZ1wMjPq
        Rby4n8poy0w33d/01VY3LfGVrIpCrKwcjm1UDS8w+M6ytK+mSy84MYLos3kOvujVJp5Kjv
        e87Qywt90kGVMTX8ZoHwlXW+HVSIOVk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-185-HXzf5_ycP1erdXKyIEjmvw-1; Fri, 04 Aug 2023 17:32:38 -0400
X-MC-Unique: HXzf5_ycP1erdXKyIEjmvw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 57C588DC661
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 21:32:38 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.225.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68C1240C2063;
        Fri,  4 Aug 2023 21:32:37 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     cluster-devel@redhat.com
Cc:     David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: Don't use filemap_splice_read
Date:   Fri,  4 Aug 2023 23:32:36 +0200
Message-Id: <20230804213236.1499047-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Bob Peterson <rpeterso@redhat.com>

Starting with patch 2cb1e08985, gfs2 started using the new function
filemap_splice_read rather than the old (and subsequently deleted)
function generic_file_splice_read.

filemap_splice_read works by taking references to a number of folios in
the page cache and splicing those folios into a pipe.  The folios are
then read from the pipe and the folio references are dropped.  This can
take an arbitrary amount of time.  We cannot allow that in gfs2 because
those folio references will pin the inode glock to the node and prevent
it from being demoted, which can lead to cluster-wide deadlocks.

Instead, use copy_splice_read.

(In addition, the old generic_file_splice_read called into ->read_iter,
which called gfs2_file_read_iter, which took the inode glock during the
operation.  The new filemap_splice_read interface does not take the
inode glock anymore.  This is fixable, but it still wouldn't prevent
cluster-wide deadlocks.)

Fixes: 2cb1e08985e3 ("splice: Use filemap_splice_read() instead of generic_file_splice_read()")
Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1bf3c4453516..b43fa8b8fc05 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1578,7 +1578,7 @@ const struct file_operations gfs2_file_fops = {
 	.fsync		= gfs2_fsync,
 	.lock		= gfs2_lock,
 	.flock		= gfs2_flock,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= simple_nosetlease,
 	.fallocate	= gfs2_fallocate,
@@ -1609,7 +1609,7 @@ const struct file_operations gfs2_file_fops_nolock = {
 	.open		= gfs2_open,
 	.release	= gfs2_release,
 	.fsync		= gfs2_fsync,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= copy_splice_read,
 	.splice_write	= gfs2_file_splice_write,
 	.setlease	= generic_setlease,
 	.fallocate	= gfs2_fallocate,
-- 
2.40.1

