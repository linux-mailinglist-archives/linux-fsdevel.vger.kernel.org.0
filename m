Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD495249D6F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHSMHr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 08:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728254AbgHSMGp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 08:06:45 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32B862063A;
        Wed, 19 Aug 2020 12:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597838804;
        bh=9+A5km3rBzonFlpdLOc0whd9dr9SchgC9q+8u5/c76o=;
        h=From:To:Cc:Subject:Date:From;
        b=EqviEmp8C9kRTc1t3ll7o04U9C+mageaSvMQi+eTgEkaJAfNO+/TmnpTtKM4Nvz4H
         bxNgdgvqJkdTcKQzQkGRpyD4F9j4VO9dAwWKJ0xVSPlyt5SUUobxXDvLEKlZ5XTCkk
         Jp+IfvNW6MUMRhr2/wHylrlkek3h+ytm1EFhLeks=
From:   Leon Romanovsky <leon@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] fs: Add function declaration of simple_dname
Date:   Wed, 19 Aug 2020 15:06:40 +0300
Message-Id: <20200819120640.939889-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

The simple_dname() is declared in internal header file but the
declaration is missing in d_path.c.

The compilation with W=1 generates the following GCC warning.

fs/d_path.c:311:7: warning: no previous prototype for 'simple_dname' [-Wmissing-prototypes]
  311 | char *simple_dname(struct dentry *dentry, char *buffer, int buflen)
      |       ^~~~~~~~~~~~

Fixes: 7e5f7bb08b8c ("unexport simple_dname()")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
Changelog:
v1: Dropped "extern" removal chunk
v0: https://lore.kernel.org/lkml/20200819083259.919838-1-leon@kernel.org/
---
 fs/d_path.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index 0f1fc1743302..4b89448cc78e 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -8,6 +8,8 @@
 #include <linux/prefetch.h>
 #include "mount.h"

+#include "internal.h"
+
 static int prepend(char **buffer, int *buflen, const char *str, int namelen)
 {
 	*buflen -= namelen;
--
2.26.2

