Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B5528EDCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgJOHke (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 03:40:34 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45827 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbgJOHke (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 03:40:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC4eKmP_1602747631;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UC4eKmP_1602747631)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 15:40:31 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     axboe@kernel.dk, hch@infradead.org, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, joseph.qi@linux.alibaba.com,
        xiaoguang.wang@linux.alibaba.com
Subject: [v2 0/2] block, iomap: disable iopoll for split bio
Date:   Thu, 15 Oct 2020 15:40:29 +0800
Message-Id: <20201015074031.91380-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patchset is to fix the potential hang occured in sync polling.

Please refer the following link for background info and the v1 patch:
https://patchwork.kernel.org/project/linux-block/patch/20201013084051.27255-1-jefflexu@linux.alibaba.com/

The first patch disables iopoll for split bio in block layer, which is
suggested by Ming Lei.

The second patch disables iopoll when one IO request need to be split into
multiple bios.

changes since v1:
- adopt the fix suggested by Ming Lei, to disable iopoll for split bio directly
- disable iopoll in direct IO routine of blkdev fs and iomap


Jeffle Xu (2):
  block: disable iopoll for split bio
  block,iomap: disable iopoll when split needed

 block/blk-merge.c    | 16 ++++++++++++++++
 fs/block_dev.c       |  7 +++++++
 fs/iomap/direct-io.c |  9 ++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

-- 
2.27.0

