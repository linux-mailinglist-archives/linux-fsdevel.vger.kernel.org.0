Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501F910384
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2019 02:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfEAAfp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Apr 2019 20:35:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbfEAAfo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Apr 2019 20:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 620D15D60F;
        Wed,  1 May 2019 00:35:44 +0000 (UTC)
Received: from localhost (dhcp-12-130.nay.redhat.com [10.66.12.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CEA7E171B7;
        Wed,  1 May 2019 00:35:43 +0000 (UTC)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Cc:     Xiong Zhou <jencce.kernel@gmail.com>,
        David Howells <dhowells@redhat.com>
Subject: [PATCH resend] vfs: return EINVAL instead of ENOENT when missing source
Date:   Wed,  1 May 2019 08:35:35 +0800
Message-Id: <20190501003535.23426-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Wed, 01 May 2019 00:35:44 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Xiong Zhou <jencce.kernel@gmail.com>

mount(2) with a NULL source device would return ENOENT instead of EINVAL
after this commit:

commit f3a09c92018a91ad0981146a4ac59414f814d801
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Sun Dec 23 18:55:56 2018 -0500

    introduce fs_context methods

Change the return value to be compatible with the old behaviour.

This was caught by LTP mount02[1]. This testcase is calling mount(2) with a
NULL device name and expecting EINVAL to PASS but now we are getting ENOENT.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/mount/mount02.c

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
Reviewed-by: David Howells <dhowells@redhat.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 583a0124bc39..48e51f13a4ba 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1469,7 +1469,7 @@ int vfs_get_tree(struct fs_context *fc)
 
 	if (fc->fs_type->fs_flags & FS_REQUIRES_DEV && !fc->source) {
 		errorf(fc, "Filesystem requires source device");
-		return -ENOENT;
+		return -EINVAL;
 	}
 
 	if (fc->root)
-- 
2.21.0

