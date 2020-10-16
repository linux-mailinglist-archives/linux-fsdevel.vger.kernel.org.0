Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B232901B8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406090AbgJPJSx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 05:18:53 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:54017 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405946AbgJPJSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:18:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBNGHj_1602839931;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UCBNGHj_1602839931)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 17:18:51 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [PATCH v3 0/2] block, iomap: disable iopoll for split bio
Date:   Fri, 16 Oct 2020 17:18:49 +0800
Message-Id: <20201016091851.93728-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is to fix the potential hang occurred in sync polling.

Please refer the following link for background info and the v1 patch:
https://patchwork.kernel.org/project/linux-block/patch/20201013084051.27255-1-jefflexu@linux.alibaba.com/

The first patch disables iopoll for split bio in block layer, which is
suggested by Ming Lei.

The second patch disables iopoll when one dio need to be split into
multiple bios.



changes since v2:
- tune the line length of patch 1
- fix the condition checking whether split needed in patch 2

changes since v1:
- adopt the fix suggested by Ming Lei, to disable iopoll for split bio directly
- disable iopoll in direct IO routine of blkdev fs and iomap

Jeffle Xu (2):
  block: disable iopoll for split bio
  block,iomap: disable iopoll when split needed

 block/blk-merge.c    | 14 ++++++++++++++
 fs/block_dev.c       |  7 +++++++
 fs/iomap/direct-io.c |  8 ++++++++
 3 files changed, 29 insertions(+)

-- 
2.27.0

