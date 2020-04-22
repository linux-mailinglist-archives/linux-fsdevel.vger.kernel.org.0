Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B131B4831
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgDVPDG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:03:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:57988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgDVPDF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:03:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 189F3AD39;
        Wed, 22 Apr 2020 15:03:03 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 54CCA1E0E56; Wed, 22 Apr 2020 17:03:03 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/23 v2] mm: Speedup page cache truncation
Date:   Wed, 22 Apr 2020 17:02:33 +0200
Message-Id: <20200422150256.23473-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

this is a second version of my patches to avoid clearing marks from xas_store()
and thus fix regression in page cache truncation.

Changes since v1
- rebased on 5.7-rc2
- drop xas_for_each_marked() fix as it was already merged
- reworked the whole series based on Matthew's feedback - we now create new
  function xas_store_noinit() and use it instead of changing xas_store()
  behavior. Note that for xas_store_range() and __xa_cmpxchg() I didn't bother
  to change names although they stop clearing marks as well. This is because
  there are only very few callers so it's easy to verify them, also chances of
  a clash with other patch introducing new callers are very small.

Original motivation:

Conversion of page cache to xarray (commit 69b6c1319b6 "mm: Convert truncate to
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
