Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F922ED6A8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 19:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbhAGSVg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 13:21:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59670 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728894AbhAGSVf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 13:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610043608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pl35x0Cl+kwuobwnKT9pU8/ptvmcEj74wGGft0vf5zc=;
        b=hFKb7culxushoptWtFIgojqzA6dNyAZvAfLu6m/SrdlW5CYK5fNysgjuTXJ3fXydAqiijP
        hvjUoYDioImvM87J+pgcoAUOoR8CtPbpcAqTs2nv+J2iZxiewweSy9ll+N/878ELSMZaUA
        n9R3+z3BmoMUjdC0/ElcEF3U4k57AoE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-e65DrLljOYejgUN8wLdnvA-1; Thu, 07 Jan 2021 13:20:04 -0500
X-MC-Unique: e65DrLljOYejgUN8wLdnvA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E69B1F765;
        Thu,  7 Jan 2021 18:20:03 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 214CC5D9DD;
        Thu,  7 Jan 2021 18:20:03 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 075E418095FF;
        Thu,  7 Jan 2021 18:20:03 +0000 (UTC)
Date:   Thu, 7 Jan 2021 13:20:00 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Satya Tangirala <satyat@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Message-ID: <1630504905.43082455.1610043600869.JavaMail.zimbra@redhat.com>
In-Reply-To: <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com>
References: <20201224044954.1349459-1-satyat@google.com> <20210107162000.GA2693@lst.de> <1137375419.42956970.1610036857271.JavaMail.zimbra@redhat.com>
Subject: [fs PATCH] fs: fix freeze count problem in freeze_bdev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.112.201, 10.4.195.4]
Thread-Topic: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb
Thread-Index: QLSEzKoRlbffxOodTzmv1w/O4NuJkjkVwvLu
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I wrote this patch to fix the freeze/thaw device problem before I saw
the patch "fs: Fix freeze_bdev()/thaw_bdev() accounting of bd_fsfreeze_sb"
from Satya Tangirala. That one, however, does not fix the bd_freeze_count
problem and this patch does. Jens, Christoph, what do you think?
This is a very recreatable problem via repeated runs of generic/085,
at least on gfs2.

Description:

Before this patch, if you tried to freeze a device (function freeze_bdev)
while it was being unmounted, it would get NULL back from get_active_super
and correctly bypass the freeze calls. Unfortunately, it forgot to decrement
its bd_fsfreeze_count. Subsequent calls to device thaw (thaw_bdev) would
see the non-zero bd_fsfreeze_count and assume the bd_fsfreeze_sb value was
still valid. That's not a safe assumption and resulted in use-after-free,
which often caused fatal kernel errors like: "unable to handle page fault
for address."

This patch adds the necessary decrement of bd_fsfreeze_count for that
error path. It also adds code to set the bd_fsfreeze_sb to NULL when the
last reference is reached in thaw_bdev.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
---
 fs/block_dev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e56ee1f2652..c6daf7d12546 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -555,8 +555,10 @@ int freeze_bdev(struct block_device *bdev)
 		goto done;
 
 	sb = get_active_super(bdev);
-	if (!sb)
+	if (!sb) {
+		bdev->bd_fsfreeze_count--;
 		goto sync;
+	}
 	if (sb->s_op->freeze_super)
 		error = sb->s_op->freeze_super(sb);
 	else
@@ -600,6 +602,7 @@ int thaw_bdev(struct block_device *bdev)
 	if (!sb)
 		goto out;
 
+	bdev->bd_fsfreeze_sb = NULL;
 	if (sb->s_op->thaw_super)
 		error = sb->s_op->thaw_super(sb);
 	else

