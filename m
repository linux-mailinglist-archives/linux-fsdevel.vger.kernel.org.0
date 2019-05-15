Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D80771FACF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfEOT3h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20248308ED54;
        Wed, 15 May 2019 19:27:34 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE3501972A;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2B3EB225491; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 29/30] fuse: Take inode lock for dax inode truncation
Date:   Wed, 15 May 2019 15:27:14 -0400
Message-Id: <20190515192715.18000-30-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 15 May 2019 19:27:34 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When a file is opened with O_TRUNC, we need to make sure that any other
DAX operation is not in progress. DAX expects i_size to be stable.

In fuse_iomap_begin() we check for i_size at multiple places and we expect
i_size to not change.

Another problem is, if we setup a mapping in fuse_iomap_begin(), and
file gets truncated and dax read/write happens, KVM currently hangs.
It tries to fault in a page which does not exist on host (file got
truncated). It probably requries fixing in KVM.

So for now, take inode lock. Once KVM is fixed, we might have to
have a look at it again.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 9b82d9b4ebc3..d0979dc32f08 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -420,7 +420,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	int err;
 	bool lock_inode = (file->f_flags & O_TRUNC) &&
 			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
+			  (fc->writeback_cache || IS_DAX(inode));
 
 	err = generic_file_open(inode, file);
 	if (err)
-- 
2.20.1

