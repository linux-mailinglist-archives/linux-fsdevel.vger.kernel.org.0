Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13AB743A73
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjF3LKw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 07:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231854AbjF3LKu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 07:10:50 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A93170F;
        Fri, 30 Jun 2023 04:10:49 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QssxC5SfczpWLF;
        Fri, 30 Jun 2023 19:07:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 30 Jun
 2023 19:10:45 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v3 0/5] quota: fix race condition between dqput() and dquot_mark_dquot_dirty()
Date:   Fri, 30 Jun 2023 19:08:17 +0800
Message-ID: <20230630110822.3881712-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Honza,

This is a solution that uses dquot_srcu to avoid race condition between
dqput() and dquot_mark_dquot_dirty(). I performed a 12+h fault injection
stress test (6 VMs, 4 test threads per VM) and have not found any problems.
And I tested the performance based on the next branch (5c875096d590), this
patch set didn't degrade performance, but rather had a ~5% improvement.

V1->V2:
	Modify the solution to use dquot_srcu.
V2->V3:
	Merge some patches, optimize descriptions.
	Simplify solutions, and fix some spelling errors.

Baokun Li (5):
  quota: factor out dquot_write_dquot()
  quota: rename dquot_active() to inode_quota_active()
  quota: add new helper dquot_active()
  quota: fix dqput() to follow the guarantees dquot_srcu should provide
  quota: simplify drop_dquot_ref()

 fs/quota/dquot.c | 244 ++++++++++++++++++++++++-----------------------
 1 file changed, 125 insertions(+), 119 deletions(-)

-- 
2.31.1

