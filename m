Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9283CB1C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 07:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhGPFKf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 01:10:35 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:44440 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhGPFKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 01:10:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0UfwgDyq_1626412048;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UfwgDyq_1626412048)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Jul 2021 13:07:39 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Chao Yu <chao@kernel.org>, Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 0/2] erofs: iomap support for tailpacking cases
Date:   Fri, 16 Jul 2021 13:07:22 +0800
Message-Id: <20210716050724.225041-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

non-tailpacking I/O: https://lore.kernel.org/r/20210712120241.199903-1-hsiangkao@linux.alibaba.com

This patchset is a follow-up patchset of the previous patchset and
interacts with iomap itself, whcih mainly adds preliminary EROFS iomap
support for all tackpacking inline cases and has been preliminary
tested myself.

It only covers iomap read path. The write path remains untouched and
bail out with -EIO if inline data with pos != 0 since EROFS cannot be
used for actual testing. It'd be better to be implemented if upcoming
fs users care rather than leave untested dead code around in kernel.
 
Hopefully [PATCH 1/2] could be landed in iomap for-next independently
since it has few changes / iomap-specific and the rest patches can be
rebased upon iomap for-next then.

Comments are welcome. Thanks for your time on reading this!

Thanks,
Gao Xiang

Gao Xiang (2):
  iomap: support tail packing inline read
  erofs: convert all uncompressed cases to iomap

 fs/erofs/data.c        | 288 +++++++----------------------------------
 fs/iomap/buffered-io.c |  41 +++++-
 fs/iomap/direct-io.c   |   8 +-
 3 files changed, 90 insertions(+), 247 deletions(-)

-- 
2.24.4

