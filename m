Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC83BAD2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jul 2021 15:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbhGDNxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Jul 2021 09:53:44 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55329 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229492AbhGDNxn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Jul 2021 09:53:43 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UeeMavo_1625406659;
Received: from e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UeeMavo_1625406659)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 04 Jul 2021 21:51:05 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        nvdimm@lists.linux.dev, "Darrick J. Wong" <djwong@kernel.org>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [RFC PATCH 0/2] erofs: dio/dax support for non-tailpacking cases
Date:   Sun,  4 Jul 2021 21:50:54 +0800
Message-Id: <20210704135056.42723-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

This patchset mainly adds preliminary EROFS iomap dio/dax support
for non-tailpacking uncompressed cases.

Direct I/O is useful in certain scenarios for uncompressed files.
For example, double pagecache can be avoid by direct I/O when
loop device is used for uncompressed files containing upper layer
compressed filesystem.

Also, DAX is quite useful for some VM use cases in order to
save guest memory extremely by using the minimal lightweight EROFS.

Tail-packing inline iomap support will be handled later since
currently iomap doesn't support such data pattern, which is
independent to non-tailpacking cases.

Comments are welcome. Thanks for your time on reading this!

Thanks,
Gao Xiang

Gao Xiang (1):
  erofs: dax support for non-tailpacking regular file

Huang Jianan (1):
  erofs: iomap support for non-tailpacking DIO

 fs/erofs/Kconfig    |   1 +
 fs/erofs/data.c     | 143 +++++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/inode.c    |  10 +++-
 fs/erofs/internal.h |   3 +
 fs/erofs/super.c    |  20 ++++++-
 5 files changed, 173 insertions(+), 4 deletions(-)

-- 
2.24.4

