Return-Path: <linux-fsdevel+bounces-62550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34868B990B0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 11:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F1E4A74C8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0432D5926;
	Wed, 24 Sep 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O4x2mWwc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232DD28136C
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Sep 2025 09:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705009; cv=none; b=mzNnFoWnCtXWzpOcS+LFEU1Lkx4CRqFd+xd520stW1MpNy8wfJoSUpzJUpVT0doRJ2RzW80eON1GrBekuve6n+IIx12+TRXsdLFO0UY/SHkHvgyD6OAeeW1ZSk/ciGs69JRe/uJ/J3WIJn+93AIF7ktU5pGKlBfrWhVKXtyhEJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705009; c=relaxed/simple;
	bh=c3WYyLfLsNmtvEzF6+B83hsfNUhOUKyRDyy9vNhoLjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCB3YK2p2HXBDb4x67yUnrZKl9Mtf9h9s5EoqHWBDT03u9/W/kC+QgTksFCWoPnqtYBRJmMUHt7O+TAS7LHGWauCl60QoXL8As6rz1PesEpFZ28yoP3MfyeGRafw0Tt5pE3G66hc5fylOtctdkCU4ItyMCDS5SnBbKuTWSvT4Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=O4x2mWwc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=twv6KxSdXx35qZ3CpUV/NZu9uC6ECLHW8NTgoYmP/QE=; b=O4x2mWwcpmyfC565DMI1tWz2ft
	2qlkeRwbGTec1Pzgv9mWJMbyuznJ2AlLAvkWcG8tWWhoIncsJ/65FLQGXCyeUSTugED90O54p4yUr
	s0uwXVlFQivuk46RKsm+1UXZ3UqZPUG3J0uJvsk8jurXbx6SZxAhBOm7m6HuqJ4OuVYswYlJXyfd9
	CFTEs1anrOjIIRI99RXHHIzZzEH8YnAf6776sF6vtEr9vOgRakTkP/hpYJz5/HA1/7hh9EreSIUTR
	LXkZ8N6mqVdfugYEd+nkKqTPgffUn/6B/RD7B4ZjpmIiCA9yoeJ9jiP7Kuyr9+IpyMI2V5D5Xk0ji
	V32gRKFg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1LVi-0000000CXGH-3AmB;
	Wed, 24 Sep 2025 09:10:02 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>
Subject: [RFC PATCH 0/2] Defer evicting inodes to a workqueue
Date: Wed, 24 Sep 2025 10:09:55 +0100
Message-ID: <20250924091000.2987157-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Evicting an inode is a complex process which may require allocating
memory, running a transaction, etc, etc.  Doing it as part of reclaim
is a bad idea and leads to hard-to-reproduce bug reports.  This pair of
patches defers it to a workqueue if we're in reclaim.

Bugs:
https://lore.kernel.org/all/CALm_T+3j+dyK02UgPiv9z0f1oj-HM63oxhsB0JF9gVAjeVfm1Q@mail.gmail.com/
https://lore.kernel.org/all/CALm_T+2cEDUJvjh6Lv+6Mg9QJxGBVAHu-CY+okQgh-emWa7-1A@mail.gmail.com/
https://lore.kernel.org/all/20250326105914.3803197-1-matt@readmodwrite.com/

I don't know if this is a good idea, to be honest.  We're kind of lying
to reclaim by pretending that we've freed N inodes when actually we've
just queued them for eviction.  On the other hand, XFS has been doing
it for years, so perhaps it's not important.

I think the real solution here is to convert the Linux VFS to use the
same inode lifecycle as IRIX, but I don't fully understand the downsides
of that approach.  One major pro of course is that XFS wouldn't have to
work around the Linux VFS any more.

I do wonder if a better approach might be:

+++ b/fs/inode.c
@@ -883,6 +883,10 @@ void evict_inodes(struct super_block *sb)
                        spin_unlock(&inode->i_lock);
                        continue;
                }
+               if (in_reclaim() && (inode->i_state & I_DIRTY_ALL)) {
+                       spin_unlock(&inode->i_lock);
+                       continue;
+               }
 
                inode->i_state |= I_FREEING;
                inode_lru_list_del(inode);

Thoughts?

Matthew Wilcox (Oracle) (2):
  Add in_reclaim()
  fs: Defer evicting inodes to a workqueue

 fs/inode.c               | 36 ++++++++++++++++++++++++++++++++++--
 include/linux/sched/mm.h | 11 +++++++++++
 mm/page_alloc.c          | 10 +++++-----
 3 files changed, 50 insertions(+), 7 deletions(-)

-- 
2.47.2


