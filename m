Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB83D151C19
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2020 15:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbgBDOZT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Feb 2020 09:25:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:49622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbgBDOZT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:25:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 94F38AEC5;
        Tue,  4 Feb 2020 14:25:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E05CD1E0BAA; Tue,  4 Feb 2020 15:25:15 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 0/8] mm: Speedup page cache truncation
Date:   Tue,  4 Feb 2020 15:25:06 +0100
Message-Id: <20200204142514.15826-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

conversion of page cache to xarray (commit 69b6c1319b6 "mm: Convert truncate to
XArray" in particular) has regressed performance of page cache truncation
by about 10% (see my original report here [1]). This patch series aims at
improving the truncation to get some of that regression back.

The first patch fixes a long standing bug with xas_for_each_marked() that I've
uncovered when debugging my patches. The remaining patches then work towards
the ability to stop clearing marks in xas_store() which improves truncation
performance by about 6%.

The patches have passed radix_tree tests in tools/testing and also fstests runs
for ext4 & xfs.

								Honza

[1] https://lore.kernel.org/linux-mm/20190226165628.GB24711@quack2.suse.cz
