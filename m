Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8149CDEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2019 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbfHZLQn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Aug 2019 07:16:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726497AbfHZLQn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:16:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 84FD5AC26;
        Mon, 26 Aug 2019 11:16:41 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Ming Lei <ming.lei@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-btrfs@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 0/2] guarantee natural alignment for kmalloc()
Date:   Mon, 26 Aug 2019 13:16:25 +0200
Message-Id: <20190826111627.7505-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

After a while, here's v2 of the series, also discussed at LSF/MM [1].
I've updated the documentation bits and expanded changelog. Also measured
effect on SLOB, and found it to be within noise. That required first adding
some accounting for SLOB, which I believe is useful in general, so that
became Patch 1. All other details are in Patch 2 changelog.

[1] https://lwn.net/Articles/787740/

Vlastimil Babka (2):
  mm, sl[ou]b: improve memory accounting
  mm, sl[aou]b: guarantee natural alignment for kmalloc(power-of-two)

 Documentation/core-api/memory-allocation.rst |  4 ++
 include/linux/slab.h                         |  4 ++
 mm/slab_common.c                             | 19 +++++-
 mm/slob.c                                    | 62 +++++++++++++++-----
 mm/slub.c                                    | 14 ++++-
 5 files changed, 82 insertions(+), 21 deletions(-)

-- 
2.22.1

