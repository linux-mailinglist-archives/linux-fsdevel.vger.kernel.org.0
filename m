Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5C599858
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 17:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbfHVPkX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 11:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731416AbfHVPkX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 11:40:23 -0400
Received: from zzz.localdomain (ip-173-136-158-138.anahca.spcsdns.net [173.136.158.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC6E206B7;
        Thu, 22 Aug 2019 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566488422;
        bh=SfOoM3PHuBEneEy6zEnQoPXo8PrZZi4Vbo2wZC3GXoo=;
        h=From:To:Subject:Date:From;
        b=G5EHro9CRz2V4Rl4cHD5EwWtygeN+NzsO4Xh34jtF5dk0sYG/orhu/lDVohLL2FYi
         r3LqHX2QnM8ocyDHPWGcww+74pWqTqaAPqOPiNbiZiNYfg1OY4QGE1hLunDvkdqVtT
         W7NHeXFv14qWuagoWU6LcJNQOHBVFZK8lM1Szyeo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH RESEND] fs/namespace.c: make to_mnt_ns() static
Date:   Thu, 22 Aug 2019 08:40:14 -0700
Message-Id: <20190822154014.14401-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make to_mnt_ns() static to address the following 'sparse' warning:

    fs/namespace.c:1736:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index e6990f3d526d..41c6b848915c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1734,7 +1734,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.22.1

