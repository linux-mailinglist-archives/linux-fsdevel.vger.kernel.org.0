Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B65C39F53A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 13:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhFHLlV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 07:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbhFHLlU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:41:20 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89CEC061787;
        Tue,  8 Jun 2021 04:39:25 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lqa4q-005ptK-SK; Tue, 08 Jun 2021 11:39:24 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] namei: make sure nd->depth is always valid
Date:   Tue,  8 Jun 2021 11:39:24 +0000
Message-Id: <20210608113924.1391062-4-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
References: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
 <20210608113924.1391062-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zero it in set_nameidata() rather than in path_init().  That way
it always matches the number of valid nd->stack[] entries.
Since terminate_walk() does zero it (after having emptied the
stack), we don't need to reinitialize it in subsequent path_init().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 40ffb249aa7f..d38b17ad604c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -581,6 +581,7 @@ static void __set_nameidata(struct nameidata *p, int dfd, struct filename *name)
 {
 	struct nameidata *old = current->nameidata;
 	p->stack = p->internal;
+	p->depth = 0;
 	p->dfd = dfd;
 	p->name = name;
 	p->path.mnt = NULL;
@@ -2320,7 +2321,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 
 	nd->flags = flags;
 	nd->state |= ND_JUMPED;
-	nd->depth = 0;
 
 	nd->m_seq = __read_seqcount_begin(&mount_lock.seqcount);
 	nd->r_seq = __read_seqcount_begin(&rename_lock.seqcount);
-- 
2.11.0

