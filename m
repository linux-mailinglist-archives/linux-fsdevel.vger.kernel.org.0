Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFB7158214
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgBJSKV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 13:10:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34331 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726809AbgBJSKV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581358220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=aeAB5V+k2GaxTCmEF7nztOH9WJLjFXNifdHFn8sC8oo=;
        b=ApEW8401m0EdKWcZWmG2CYJ7E6CgE7TD1Z+5FQZ/yR/LdUmUwwdMV0s1TS8jqdZKkIAeyZ
        MLvyxDpZ7Ly0WrkfWMaGdCpFcZe4Mn/UVa2wxnTX5ev0CskO/fKv7TAQoL0Tl/MC3D/yEg
        Yp8siQP9nceROfKKopo77nFiwM5liNM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-uYF-wzivPfigIThGt6dvMw-1; Mon, 10 Feb 2020 13:10:17 -0500
X-MC-Unique: uYF-wzivPfigIThGt6dvMw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE122801E6D;
        Mon, 10 Feb 2020 18:10:16 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CADC10013A7;
        Mon, 10 Feb 2020 18:10:15 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     raven@themaw.net
Subject: [patch] fs: fix use after free in get_tree_bdev
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 10 Feb 2020 13:10:15 -0500
Message-ID: <x49a75q1fg8.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in get_tree_bdev()")
introduced a use-after-free of the bdev.  This was caught by fstests
generic/085, which now results in a kernel panic.  Fix it.

Cc: stable@vger.kernel.org # v5.4+
Fixes: 6fcf0c72e4b9 ("vfs: add missing blkdev_put() in get_tree_bdev()")
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

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
 

