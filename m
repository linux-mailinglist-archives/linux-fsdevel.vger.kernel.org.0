Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB6F741245
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 15:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjF1NYV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 09:24:21 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:21997 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbjF1NYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:24:20 -0400
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qrj0D1KzvzlVmr;
        Wed, 28 Jun 2023 21:21:32 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 28 Jun
 2023 21:24:16 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <jack@suse.cz>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH v2 0/7] quota: fix race condition between dqput() and dquot_mark_dquot_dirty()
Date:   Wed, 28 Jun 2023 21:21:48 +0800
Message-ID: <20230628132155.1560425-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Honza,

This is a solution that uses dquot_srcu to avoid race condition between
dqput() and dquot_mark_dquot_dirty(). I performed a 24+h fault injection
stress test (6 VMs, 4 test threads per VM) and have not found any problems.
And I tested the performance based on the latest mainline (6aeadf7896bf),
the patch set did not lead to performance degradation, and even a little
bit of improvement.

V1->V2:
	Modify the solution to use dquot_srcu.

Baokun Li (7):
  quota: factor out dquot_write_dquot()
  quota: add new global dquot list releasing_dquots
  quota: rename dquot_active() to inode_dquot_active()
  quota: add new helper dquot_active()
  quota: fix dqput() to follow the guarantees dquot_srcu should provide
  quota: simplify drop_dquot_ref()
  quota: remove unused function put_dquot_list()

 fs/quota/dquot.c | 237 +++++++++++++++++++++++++++--------------------
 1 file changed, 134 insertions(+), 103 deletions(-)

-- 
2.31.1

