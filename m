Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6757B355611
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbhDFOHU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 10:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232880AbhDFOHT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617718031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=O3QLOZNvk5LI9aoHXKpUZE6l4zsrxFxH5oJtgSZGjRc=;
        b=ErQzUovTgqntQJE5GwiC9A/BMrb2V91+Rz3nuwPIwLHPDdSbth6Xh8FUjSkGNFn4Ciu4RT
        RXNlntmMULvY/Ml1wbQtrN+V66dpzjZJeDbOwd+OKwDv6BAWDsGhBMdF9X+QiaYZT5ESP3
        Vuxh9/XaOT4iGGK/283oydqc+Kxuj2k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-542-DHAbWGaAPzGjWBLZAdZMrw-1; Tue, 06 Apr 2021 10:07:09 -0400
X-MC-Unique: DHAbWGaAPzGjWBLZAdZMrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D9AD31018F76;
        Tue,  6 Apr 2021 14:07:07 +0000 (UTC)
Received: from horse.redhat.com (ovpn-117-29.rdu2.redhat.com [10.10.117.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 121395D745;
        Tue,  6 Apr 2021 14:07:07 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9B9C422054F; Tue,  6 Apr 2021 10:07:06 -0400 (EDT)
Date:   Tue, 6 Apr 2021 10:07:06 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Cc:     virtio-fs-list <virtio-fs@redhat.com>, eric.auger@redhat.com
Subject: [PATCH] fuse: Invalidate attrs when page writeback completes
Message-ID: <20210406140706.GB934253@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fuse when a direct/write-through write happens we invalidate attrs because
that might have updated mtime/ctime on server and cached mtime/ctime
will be stale.

What about page writeback path. Looks like we don't invalidate attrs there.
To be consistent, invalidate attrs in writeback path as well. Only exception
is when writeback_cache is enabled. In that case we strust local mtime/ctime
and there is no need to invalidate attrs.

Recently users started experiencing failure of xfstests generic/080,
geneirc/215 and generic/614 on virtiofs. This happened only newer
"stat" utility and not older one. This patch fixes the issue.

So what's the root cause of the issue. Here is detailed explanation.

generic/080 test does mmap write to a file, closes the file and then
checks if mtime has been updated or not. When file is closed, it
leads to flushing of dirty pages (and that should update mtime/ctime
on server). But we did not explicitly invalidate attrs after writeback
finished. Still generic/080 passed so far and reason being that we
invalidated atime in fuse_readpages_end(). This is called in fuse_readahead()
path and always seems to trigger before mmaped write.

So after mmaped write when lstat() is called, it sees that atleast one
of the fields being asked for is invalid (atime) and that results in
generating GETATTR to server and mtime/ctime also get updated and test
passes.

But newer /usr/bin/stat seems to have moved to using statx() syscall now
(instead of using lstat()). And statx() allows it to query only ctime
or mtime (and not rest of the basic stat fields). That means when
querying for mtime, fuse_update_get_attr() sees that mtime is not
invalid (only atime is invalid). So it does not generate a new GETATTR
and fill stat with cached mtime/ctime. And that means updated mtime
is not seen by xfstest and tests start failing.

Invalidating attrs after writeback completion should solve this problem
in a generic manner.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 8cccecb55fb8..482281bf170a 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1759,8 +1759,17 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 		container_of(args, typeof(*wpa), ia.ap.args);
 	struct inode *inode = wpa->inode;
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_conn *fc = get_fuse_conn(inode);
 
 	mapping_set_error(inode->i_mapping, error);
+	/*
+	 * A writeback finished and this might have updated mtime/ctime on
+	 * server making local mtime/ctime stale. Hence invalidate attrs.
+	 * Do this only if writeback_cache is not enabled. If writeback_cache
+	 * is enabled, we trust local ctime/mtime.
+	 */
+	if (!fc->writeback_cache)
+		fuse_invalidate_attr(inode);
 	spin_lock(&fi->lock);
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
 	while (wpa->next) {
-- 
2.25.4

