Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5504D1BCD57
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 22:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgD1U14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 16:27:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35351 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726286AbgD1U14 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588105675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Eg1xk1qbLOD2jm86OCEQIZspFf2KSHhRV26te2Q2h+g=;
        b=hAeK2RY72viEtrFmmnlslL4eDE9KSl+Cb6+7kfSSNiDYAvHjRS7PjBXy318dbNlMzmKFJU
        0/k9UviwvmTAsoOHmbt6lOHYWbMvOUrK7fwGhS1QpqZU5tQwON42/NdfWYEpAleG4XKQUP
        Fi9Taae2lgEXx+OYI1HZLctxm/ps3f4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-X_DZxyeYPVy9uo7zIXD4BA-1; Tue, 28 Apr 2020 16:27:52 -0400
X-MC-Unique: X_DZxyeYPVy9uo7zIXD4BA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4234480058A;
        Tue, 28 Apr 2020 20:27:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-113-129.rdu2.redhat.com [10.10.113.129])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A756A60CD3;
        Tue, 28 Apr 2020 20:27:49 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] Fix use after free in get_tree_bdev()
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     Lukas Czerner <lczerner@redhat.com>, Ian Kent <raven@themaw.net>,
        torvalds@linux-foundation.org, dhowells@redhat.com,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Apr 2020 21:27:48 +0100
Message-ID: <158810566883.1168184.8679527126430822408.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 6fcf0c72e4b9, a fix to get_tree_bdev() put a missing blkdev_put() in
the wrong place, before a warnf() that displays the bdev under
consideration rather after it.

This results in a silent lockup in printk("%pg") called via warnf() from
get_tree_bdev() under some circumstances when there's a race with the
blockdev being frozen.  This can be caused by xfstests/tests/generic/085 in
combination with Lukas Czerner's ext4 mount API conversion patchset.  It
looks like it ought to occur with other users of get_tree_bdev() such as
XFS, but apparently doesn't.

Fix this by switching the order of the lines.

Fixes: 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in get_tree_bdev()")
Reported-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Ian Kent <raven@themaw.net>
cc: Al Viro <viro@zeniv.linux.org.uk>
---

 fs/super.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..a288cd60d2ae 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1302,8 +1302,8 @@ int get_tree_bdev(struct fs_context *fc,
 	mutex_lock(&bdev->bd_fsfreeze_mutex);
 	if (bdev->bd_fsfreeze_count > 0) {
 		mutex_unlock(&bdev->bd_fsfreeze_mutex);
-		blkdev_put(bdev, mode);
 		warnf(fc, "%pg: Can't mount, blockdev is frozen", bdev);
+		blkdev_put(bdev, mode);
 		return -EBUSY;
 	}
 


