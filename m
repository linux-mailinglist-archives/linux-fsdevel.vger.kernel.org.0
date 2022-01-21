Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCC5496552
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 19:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiAUSxL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jan 2022 13:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229453AbiAUSxK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:53:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642791190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AsIAvBTcI5g7o+PrVjk2os/OZq2YScnOHuSRIsTSZcM=;
        b=BuRp+YSbSEVQWCY3qcHeto59Xw9m9P03AnI0ejIpYsqWAdpP3koSOrP9lQti/GNnivUGN7
        /wulXU548lGKm0T7RWUXCOfbRb8eoEYkttPWNmEqrtYiVJI2Ist+pWACEvld97LhN0M9+l
        S2FO7yfnf0r/1tItcYWG1lC+bhQbSFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-kcRpiG9KP9O_MocB27JiPQ-1; Fri, 21 Jan 2022 13:53:08 -0500
X-MC-Unique: kcRpiG9KP9O_MocB27JiPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B8261006AA3;
        Fri, 21 Jan 2022 18:53:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.11.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B03734D50;
        Fri, 21 Jan 2022 18:53:01 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] vfs: Pre-allocate superblock in sget_fc() if !test
Date:   Fri, 21 Jan 2022 13:52:55 -0500
Message-Id: <20220121185255.27601-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the test function is not defined in sget_fc(), we always need
to allocate a new superblock. So there is no point in acquiring the
sb_lock twice in this case. Optimize the !test case by pre-allocating
the superblock first before acquring the lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 fs/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/super.c b/fs/super.c
index a6405d44d4ca..c2bd5c34a826 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -520,6 +520,8 @@ struct super_block *sget_fc(struct fs_context *fc,
 	struct user_namespace *user_ns = fc->global ? &init_user_ns : fc->user_ns;
 	int err;
 
+	if (!test)
+		s = alloc_super(fc->fs_type, fc->sb_flags, user_ns);
 retry:
 	spin_lock(&sb_lock);
 	if (test) {
-- 
2.27.0

