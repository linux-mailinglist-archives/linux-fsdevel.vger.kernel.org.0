Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8014D11C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 16:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbfJIOwV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 10:52:21 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33070 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOwU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:52:20 -0400
Received: from [167.98.27.226] (helo=rainbowdash.codethink.co.uk)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iIDK1-0001Ox-G5; Wed, 09 Oct 2019 15:52:13 +0100
Received: from ben by rainbowdash.codethink.co.uk with local (Exim 4.92.2)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1iIDK0-0004L3-Vm; Wed, 09 Oct 2019 15:52:12 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-kernel@lists.codethink.co.uk
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/namespace: make to_mnt_ns static
Date:   Wed,  9 Oct 2019 15:52:11 +0100
Message-Id: <20191009145211.16614-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The to_mnt_ns() is not exported outside the file so
make it static to fix the following sparse warning:

fs/namespace.c:1731:22: warning: symbol 'to_mnt_ns' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index fe0e9e1410fe..b87b127fdce4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1728,7 +1728,7 @@ static bool is_mnt_ns_file(struct dentry *dentry)
 	       dentry->d_fsdata == &mntns_operations;
 }
 
-struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
+static struct mnt_namespace *to_mnt_ns(struct ns_common *ns)
 {
 	return container_of(ns, struct mnt_namespace, ns);
 }
-- 
2.23.0

