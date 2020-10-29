Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3350529F53A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 20:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgJ2T3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 15:29:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:51804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJ2T3d (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:29:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 26D71AE72;
        Thu, 29 Oct 2020 19:28:42 +0000 (UTC)
Date:   Thu, 29 Oct 2020 12:07:48 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Dave Chinner <david@fromorbit.com>
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        peterz@infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH v2] fs/dcache: optimize start_dir_add()
Message-ID: <20201029190748.u5zrnk6rjtc4p43v@linux-p48b>
References: <20201022211650.25045-1-dave@stgolabs.net>
 <20201026215923.GA306023@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201026215923.GA306023@dread.disaster.area>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Considering both end_dir_add() and d_alloc_parallel(), the
dir->i_dir_seq wants acquire/release semantics, therefore
micro-optimize for ll/sc archs. Also add READ_ONCE around
the variable mostly for documentation purposes - either
the successful cmpxchg or the pause will avoid the tearing).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 fs/dcache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index ea0485861d93..9177f0d08a5a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2504,8 +2504,8 @@ static inline unsigned start_dir_add(struct inode *dir)
 {

	for (;;) {
-		unsigned n = dir->i_dir_seq;
-		if (!(n & 1) && cmpxchg(&dir->i_dir_seq, n, n + 1) == n)
+		unsigned n = READ_ONCE(dir->i_dir_seq);
+		if (!(n & 1) && cmpxchg_acquire(&dir->i_dir_seq, n, n + 1) == n)
			return n;
		cpu_relax();
	}
--
2.26.2
