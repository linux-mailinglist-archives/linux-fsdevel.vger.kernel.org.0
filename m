Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D003C92165
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 12:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfHSKfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 06:35:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55472 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfHSKfS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 06:35:18 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 51609BA7CB78A0572AFD;
        Mon, 19 Aug 2019 18:35:12 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 19 Aug
 2019 18:35:03 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-fsdevel@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        <linux-erofs@lists.ozlabs.org>, "Chao Yu" <chao@kernel.org>,
        Miao Xie <miaoxie@huawei.com>, <weidu.du@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 0/6] staging: erofs: first stage of corrupted compressed images
Date:   Mon, 19 Aug 2019 18:34:20 +0800
Message-ID: <20190819103426.87579-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190819080218.GA42231@138>
References: <20190819080218.GA42231@138>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

I have fuzzed EROFS for about a day and observed the following
issues due to corrupted compression images by my first fuzzer
(It seems ok for uncompressed images for now). Now it can survive
for 10+ minutes on my PC (Let me send out what I'm done and
I will dig it more deeply...)

All the fixes are trivial.

Note that those have dependency on EFSCORRUPTED, so for-next
is needed and I will manually backport them by hand due to
many cleanup patches...

Thanks,
Gao Xiang

Gao Xiang (6):
  staging: erofs: some compressed cluster should be submitted for
    corrupted images
  staging: erofs: cannot set EROFS_V_Z_INITED_BIT if fill_inode_lazy
    fails
  staging: erofs: add two missing erofs_workgroup_put for corrupted
    images
  staging: erofs: avoid loop in submit chains
  staging: erofs: detect potential multiref due to corrupted images
  staging: erofs: avoid endless loop of invalid lookback distance 0

 drivers/staging/erofs/zdata.c | 46 ++++++++++++++++++++++++++---------
 drivers/staging/erofs/zmap.c  |  9 +++++--
 2 files changed, 42 insertions(+), 13 deletions(-)

-- 
2.17.1

