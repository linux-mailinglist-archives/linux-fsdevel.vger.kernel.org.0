Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA912966BB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372399AbgJVVha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 17:37:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372395AbgJVVha (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:37:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 141DBABDE;
        Thu, 22 Oct 2020 21:37:28 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     viro@zeniv.linux.org.uk
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] fs/dcache: optimize start_dir_add()
Date:   Thu, 22 Oct 2020 14:16:50 -0700
Message-Id: <20201022211650.25045-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Considering both end_dir_add() and d_alloc_parallel(), the
dir->i_dir_seq wants acquire/release semantics, therefore
micro-optimize for ll/sc archs and use finer grained barriers
to provide (load)-ACQUIRE ordering (L->S + L->L). This comes
at no additional cost for most of x86, as sane tso models will
have a nop for smp_rmb/smp_acquire__after_ctrl_dep.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
Alternatively I guess we could just use cmpxchg_acquire().

 fs/dcache.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..22738daccb9c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2502,13 +2502,18 @@ EXPORT_SYMBOL(d_rehash);
 
 static inline unsigned start_dir_add(struct inode *dir)
 {
+	unsigned n;
 
 	for (;;) {
-		unsigned n = dir->i_dir_seq;
-		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
-			return n;
+		n = READ_ONCE(dir->i_dir_seq);
+		if (!(n & 1) && cmpxchg_relaxed(&dir->i_dir_seq, n, n + 1) == n)
+			break;
 		cpu_relax();
 	}
+
+	/* create (load)-ACQUIRE ordering */
+	smp_acquire__after_ctrl_dep();
+	return n;
 }
 
 static inline void end_dir_add(struct inode *dir, unsigned n)
-- 
2.26.2

