Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA09140B209
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Sep 2021 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhINOuy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Sep 2021 10:50:54 -0400
Received: from foss.arm.com ([217.140.110.172]:45764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233883AbhINOum (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:50:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 232F6101E;
        Tue, 14 Sep 2021 07:49:25 -0700 (PDT)
Received: from a077416.arm.com (unknown [10.163.44.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 069773F5A1;
        Tue, 14 Sep 2021 07:49:22 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] fs/ioctl: Remove unnecessary __user annotation
Date:   Tue, 14 Sep 2021 20:19:12 +0530
Message-Id: <20210914144912.11687-1-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

__user annotations are used by the checker (e.g sparse) to mark user
pointers. However here __user is applied to a struct directly, without
a pointer being directly involved.

Although the presence of __user does not cause sparse to emit a warning,
__user should be removed for consistency with other uses of offsetof().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 504e69578112..1ed097e94af2 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -430,7 +430,7 @@ static int ioctl_file_dedupe_range(struct file *file,
 		goto out;
 	}
 
-	size = offsetof(struct file_dedupe_range __user, info[count]);
+	size = offsetof(struct file_dedupe_range, info[count]);
 	if (size > PAGE_SIZE) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.17.1

